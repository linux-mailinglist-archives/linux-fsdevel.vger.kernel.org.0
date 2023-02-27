Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7C36A43D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 15:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjB0OJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 09:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjB0OJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:09:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CCD525E;
        Mon, 27 Feb 2023 06:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b9phfdI9TMx72ilBp0eEoM6G1VduC5sCkR9fo7UPGL8=; b=vf/+dGjTdV4w1ejSFMgL+CRWNn
        ncZSHWtbNFAxGnRFo3OcpkpBXswgmlXKwvAhu9kkpcBv9nEXAvql0WL5JIoAVS3nOdG+0sDcijR2c
        hzCynyWfzljSy91esLtfEhX5BqIKfiZ0Q0itzem08XBOEHiYNa1h6IqR4Cf4Zb/Esrw2LRsCFZ8PT
        /2IFs/WxyboR/j0j52o8fnbRfDZMrxAKxgi9orL4aoNVaSKgRTXgAlvlj629j9TAz3TjNWIndvR7V
        4UqAuhMOVkuAQp5lkajlUXe3jD+xqZIlSHgYGJQz9H/ozINGvxrzxUEBTYhl3rGK3QAU1jFTNmi7d
        tSz4JyUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWeCK-0009om-D9; Mon, 27 Feb 2023 14:09:48 +0000
Date:   Mon, 27 Feb 2023 14:09:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 4/5] afs: Zero bytes after 'oldsize' if we're expanding
 the file
Message-ID: <Y/y5rFX2koj2W6Wa@casper.infradead.org>
References: <20230202204428.3267832-5-willy@infradead.org>
 <20230202204428.3267832-1-willy@infradead.org>
 <2730679.1677505767@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2730679.1677505767@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 01:49:27PM +0000, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> > POSIX requires that "If the file size is increased, the extended area
> > shall appear as if it were zero-filled".  It is possible to use mmap to
> > write past EOF and that data will become visible instead of zeroes.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> That seems to work.  Do you want me to pass it on to Linus?  If not:
> 
> Acked-by: David Howells <dhowells@redhat.com>

I'll send a patch series with all of this; it doesn't seem terribly
urgent.  Do you think there's a similar problem for AFS that Brian
noted with the generic patch?
