Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418D328F16F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 13:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgJOLih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 07:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgJOLig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:38:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676D8C061755;
        Thu, 15 Oct 2020 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HvK1K6vUxDvqtColNXbsVV3cp23c2ZJIGqkC190E7dA=; b=MQ1lQ7QGP43wzfdydVf6XcZ91K
        R1z2/pVN4VFgteVvlJcMUMTD4to8puSFW7OK8HWLXmTLHwD4koFLVk4tzwzoOQ+FBdMqaA76jz3Fj
        0U8guZfofBtvzj+3E/BaZmcW/rkeAqX1XDxlGPZIAyqNyuN4Hwn3P41prOl9cGcQ57OWVu4vMlwU1
        SIbQOmr7tAm/0NjWj/XOSc6fgbjZX5p+5DWsO8gN/KRV0GJosM/QLAYkAH//FUpYpuNvbknomvtlV
        UKTiiOi2WvoXVjyz1zeklVofZdkjp8LCkvunPVPqNXdoIU+ztVK+4G6EqgA5JbRxuDtGyahobiU/u
        BBa7S4DA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT1aU-00046q-5h; Thu, 15 Oct 2020 11:38:26 +0000
Date:   Thu, 15 Oct 2020 12:38:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] vfs: move generic_remap_checks out of mm
Message-ID: <20201015113826.GX20115@casper.infradead.org>
References: <160272187483.913987.4254237066433242737.stgit@magnolia>
 <160272188127.913987.8729718777463390497.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160272188127.913987.8729718777463390497.stgit@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 05:31:21PM -0700, Darrick J. Wong wrote:
> I would like to move all the generic helpers for the vfs remap range
> functionality (aka clonerange and dedupe) into a separate file so that
> they won't be scattered across the vfs and the mm subsystems.  The
> eventual goal is to be able to deselect remap_range.c if none of the
> filesystems need that code, but the tricky part here is picking a
> stable(ish) part of the merge window to rearrange code.

This makes sense to me.  There's nothing page-cache about this function.

> diff --git a/mm/filemap.c b/mm/filemap.c
> index 99c49eeae71b..cf20e5aeb11b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3098,8 +3098,7 @@ EXPORT_SYMBOL(read_cache_page_gfp);
>   * LFS limits.  If pos is under the limit it becomes a short access.  If it
>   * exceeds the limit we return -EFBIG.
>   */
> -static int generic_write_check_limits(struct file *file, loff_t pos,
> -				      loff_t *count)
> +int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
>  {
>  	struct inode *inode = file->f_mapping->host;
>  	loff_t max_size = inode->i_sb->s_maxbytes;

I wonder if generic_write_check_limits should be in fs/read_write.c --
it has nothing to do with the pagecache either.

