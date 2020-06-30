Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5480920FD95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 22:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgF3UX6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 16:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgF3UX6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:23:58 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B38206B6;
        Tue, 30 Jun 2020 20:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593548637;
        bh=l9RYQ1V9rC0eV/2Cav74VbY6gmCMxIgckvz1UR0Gs5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peu3T7LcDbJmZ6m1V77CJRMfLPcFdijYiYlvAS7BjXdj96eVSaImqnQof9UnF1h8k
         deyTLMmDjr0j1U7+Bs5iV/SpK7ZX71d6YqY2/bnENix7jEKj91AP+Akr91Zd6EUe6w
         SG6OXmtF+/q8CZFJFx0PBnSPMVqVki8VJf61/nZw=
Date:   Tue, 30 Jun 2020 13:23:57 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: always expose label 'next_page'
Message-ID: <20200630202357.GA1396584@google.com>
References: <020937f3-2947-ca41-c18a-026782216711@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <020937f3-2947-ca41-c18a-026782216711@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/30, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build error when F2FS_FS_COMPRESSION is not set/enabled.
> This label is needed in either case.
> 
> ../fs/f2fs/data.c: In function ‘f2fs_mpage_readpages’:
> ../fs/f2fs/data.c:2327:5: error: label ‘next_page’ used but not defined
>      goto next_page;

Thank you for the fix. This was actually introduced by the recent testing patch.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=ff963ad2bf54460431f517b5cae473997a29bf2a

If you don't mind, please let me integrate this into the original patch.
Let me know.

Thanks,

> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <yuchao0@huawei.com>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> ---
>  fs/f2fs/data.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- linux-next-20200630.orig/fs/f2fs/data.c
> +++ linux-next-20200630/fs/f2fs/data.c
> @@ -2366,9 +2366,7 @@ set_error_page:
>  			zero_user_segment(page, 0, PAGE_SIZE);
>  			unlock_page(page);
>  		}
> -#ifdef CONFIG_F2FS_FS_COMPRESSION
>  next_page:
> -#endif
>  		if (rac)
>  			put_page(page);
>  
