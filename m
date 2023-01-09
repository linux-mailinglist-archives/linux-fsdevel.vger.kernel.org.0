Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756C566295A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 16:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjAIPIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 10:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjAIPHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:07:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B262B94;
        Mon,  9 Jan 2023 07:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3ur7C+W2r8wDUsaTYPPPMV6CzMQmfkaZSRCKEcopFFQ=; b=nh4Y1aUgxZvfFlpIE1QZR9wDiq
        /r5xjZ2NMM7L6Y36kwT/MLtlC8F8AuB/KtP4F4v6S3SRt43AOrUfGVVzVfiM20rDZwkvdoJScmbAw
        HK3wU1/SdXYDsDkI79q+B6cxODNDyPwuZ4YLzb3v0Dj0OyVZmXDiYSigjVdO6bf/XW7rjl6NUhzDB
        F2e7GUTNuL4A9QqGrKXFiiuqb5wBwml+3ess0bGcAZNs1ruHFShbBv13oC2EruTOqq/3jsUt69RFv
        kpTieWrVuEpi8yDQxFVaz9G0qsGraRybQUlNsjn8N77w+fArKfx1w5BhAggxcCUU3Q3uIusyPxfF+
        RSOcf2HA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEtkW-002NXd-N3; Mon, 09 Jan 2023 15:07:44 +0000
Date:   Mon, 9 Jan 2023 15:07:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/11] cifs: Remove call to filemap_check_wb_err()
Message-ID: <Y7wtwD/Yr+nWSqpx@casper.infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
 <20230109051823.480289-9-willy@infradead.org>
 <7d1499fadf42052711e39f0d8c7656f4d3a4bc9d.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d1499fadf42052711e39f0d8c7656f4d3a4bc9d.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 09:42:36AM -0500, Jeff Layton wrote:
> On Mon, 2023-01-09 at 05:18 +0000, Matthew Wilcox (Oracle) wrote:
> > filemap_write_and_wait() now calls filemap_check_wb_err(), so we cannot
> > glean any additional information by calling it ourselves.  It may also
> > be misleading as it will pick up on any errors since the beginning of
> > time which may well be since before this program opened the file.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/cifs/file.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> > index 22dfc1f8b4f1..7e7ee26cf77d 100644
> > --- a/fs/cifs/file.c
> > +++ b/fs/cifs/file.c
> > @@ -3042,14 +3042,12 @@ int cifs_flush(struct file *file, fl_owner_t id)
> >  	int rc = 0;
> >  
> >  	if (file->f_mode & FMODE_WRITE)
> > -		rc = filemap_write_and_wait(inode->i_mapping);
> > +		rc = filemap_write_and_wait(file->f_mapping);
> 
> If we're calling ->flush, then the file is being closed. Should this
> just be?
> 		rc = file_write_and_wait(file);
> 
> It's not like we need to worry about corrupting ->f_wb_err at that
> point.

Yes, I think you're right, and then this is a standalone patch that can
go in this cycle, perhaps.
