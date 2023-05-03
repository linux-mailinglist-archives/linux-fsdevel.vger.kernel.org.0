Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991226F5B80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjECPtq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 11:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjECPtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 11:49:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D2C4C29
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 08:49:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 30FC668AA6; Wed,  3 May 2023 17:49:36 +0200 (CEST)
Date:   Wed, 3 May 2023 17:49:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] filemap: fix the conditional folio_put in
 filemap_fault
Message-ID: <20230503154936.GA31522@lst.de>
References: <20230503154526.1223095-1-hch@lst.de> <ZFKCRPRgoKWaWhQW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFKCRPRgoKWaWhQW@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 04:48:20PM +0100, Matthew Wilcox wrote:
> > -		folio_put(folio);
> 
> Why not simply:
> 
> -	if (folio)
> +	if (!IS_ERR_OR_NULL(folio))

no need for the OR_NULL.  But I find the extra label way easier to
reason about, and it's exactly the same amount of code.
