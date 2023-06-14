Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACBB7300D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbjFNNxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 09:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245083AbjFNNxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:53:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A748A6;
        Wed, 14 Jun 2023 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BrKiZJ/7P5/xEOj2+1/+w23iGdbuRJcoaS4+TydPQrU=; b=iaVfzAFislHMvK4fgcYmEmftit
        zSer6ZD4amu8Fdm6wa+O8vMTfFneJYaM+AdziypCD/zY/RTsk8X82jEepoZPIJpJekz3sfvECo7Jb
        8J86iS2YDuk6a4XkJS0b7NQtp2uxVuhpiypSXRwzVESAUCvqBOTg0UOUkXc95QHpQsLpNOVy9igfz
        68qStwCEjF3XiQ+yailPKEWyCPdvXQ2v0OM9AVPaRxva87xatn4VUJpPnl6J/D3Ll3cNpgQbqCmF/
        oVenZBP+RBREOUa29WQnrygaWSg+mWVKZZaNwQ/KX9anVQofdOSwrVsK+8A9j6qXz8utJllUJ9JY0
        65z3PjCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9QwZ-006O5L-B0; Wed, 14 Jun 2023 13:53:51 +0000
Date:   Wed, 14 Jun 2023 14:53:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 0/7] RFC: high-order folio support for I/O
Message-ID: <ZInGbz6X/ZQAwdRx@casper.infradead.org>
References: <20230614114637.89759-1-hare@suse.de>
 <cd816905-0e3e-6397-1a6f-fd4d29dfc739@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd816905-0e3e-6397-1a6f-fd4d29dfc739@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 03:17:25PM +0200, Hannes Reinecke wrote:
> Turns out that was quite easy to fix (just remove the check in
> set_blocksize()), but now I get this:
> 
> SGI XFS with ACLs, security attributes, quota, no debug enabled
> XFS (ram0): File system with blocksize 16384 bytes. Only pagesize (4096) or
> less will currently work.

What happens if you just remove this hunk:

+++ b/fs/xfs/xfs_super.c
@@ -1583,18 +1583,6 @@ xfs_fs_fill_super(
                goto out_free_sb;
        }

-       /*
-        * Until this is fixed only page-sized or smaller data blocks work.
-        */
-       if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
-               xfs_warn(mp,
-               "File system with blocksize %d bytes. "
-               "Only pagesize (%ld) or less will currently work.",
-                               mp->m_sb.sb_blocksize, PAGE_SIZE);
-               error = -ENOSYS;
-               goto out_free_sb;
-       }
-
        /* Ensure this filesystem fits in the page cache limits */
        if (xfs_sb_validate_fsb_count(&mp->m_sb, mp->m_sb.sb_dblocks) ||
            xfs_sb_validate_fsb_count(&mp->m_sb, mp->m_sb.sb_rblocks)) {
