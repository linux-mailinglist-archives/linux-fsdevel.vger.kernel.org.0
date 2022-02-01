Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0E74A6154
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 17:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbiBAQ0T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 11:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241011AbiBAQ0S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:26:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AE4C061714;
        Tue,  1 Feb 2022 08:26:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 417ECB82EDF;
        Tue,  1 Feb 2022 16:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EC6C340EB;
        Tue,  1 Feb 2022 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643732776;
        bh=ensdKH5/5ATlXb56b9QEsLbO6Ls5DhgDYHxVsVdMhIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VcylpKYnkQjjYp3sXdZysU2q1BNMe6JPsf8gxCFs61I0Or0mtY/f9pZGsZGdY4p1S
         VYasnMOMCv22nc6nbC7/gb/FFHHzlI+7dQ8SNylm3Nza0WdQLBR7aso5Uol9xLBn+x
         eyDQ182yiwgxZcX38Gbp6/DaQGsrrwfzUAN4/+pb0xfoOzdNPoFo5p5p7gbdbqKmCJ
         DKNRnAE81Gy8puPT/Uu5mRSNDg2/vFRt0LiVuOQL2eCaD63o8v3qv+4ghyy/bPOKvc
         EkvMmJEkYXojv/ZwSQUc1KiHV58t1/3Kbbe9Hdf5eJ3lPd742vgGDo+aMLAnvCZqKi
         ji1ymnLQyfFrA==
Date:   Tue, 1 Feb 2022 09:26:11 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, viro@zeniv.linux.org.uk,
        ndesaulniers@google.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v3] seq_file: fix NULL pointer arithmetic warning
Message-ID: <YflfI9uAz0bR2r4m@dev-arch.archlinux-ax161>
References: <Yfgo8p6Vk+h4+YHY@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yfgo8p6Vk+h4+YHY@fedora>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Maíra,

On Mon, Jan 31, 2022 at 03:22:42PM -0300, Maíra Canal wrote:
> Implement conditional logic in order to replace NULL pointer arithmetic.
> 
> The use of NULL pointer arithmetic was pointed out by clang with the
> following warning:
> 
> fs/kernfs/file.c:128:15: warning: performing pointer arithmetic on a
> null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>                 return NULL + !*ppos;
>                        ~~~~ ^
> fs/seq_file.c:559:14: warning: performing pointer arithmetic on a
> null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>         return NULL + (*pos == 0);
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>

Thanks a lot for the patch!

It looks like Arnd sent a similar patch but it was never picked up:

https://lore.kernel.org/r/20201028151202.3074398-1-arnd@kernel.org/

This is a cleaner solution as it uses existing defines and functions to
deduplicate the code.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> V1 -> V2:
> - Use SEQ_START_TOKEN instead of open-coding it
> - kernfs_seq_start call single_start instead of open-coding it
> V2 -> V3:
> - Remove the EXPORT of the single_start symbol
> ---
>  fs/kernfs/file.c         | 7 +------
>  fs/seq_file.c            | 4 ++--
>  include/linux/seq_file.h | 1 +
>  3 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 9414a7a60a9f..7aefaca876a0 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -120,13 +120,8 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
>  		if (next == ERR_PTR(-ENODEV))
>  			kernfs_seq_stop_active(sf, next);
>  		return next;
> -	} else {
> -		/*
> -		 * The same behavior and code as single_open().  Returns
> -		 * !NULL if pos is at the beginning; otherwise, NULL.
> -		 */
> -		return NULL + !*ppos;
>  	}
> +	return single_start(sf, ppos);
>  }
>  
>  static void *kernfs_seq_next(struct seq_file *sf, void *v, loff_t *ppos)
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index f8e1f4ee87ff..7ab8a58c29b6 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -554,9 +554,9 @@ int seq_dentry(struct seq_file *m, struct dentry *dentry, const char *esc)
>  }
>  EXPORT_SYMBOL(seq_dentry);
>  
> -static void *single_start(struct seq_file *p, loff_t *pos)
> +void *single_start(struct seq_file *p, loff_t *pos)
>  {
> -	return NULL + (*pos == 0);
> +	return *pos ? NULL : SEQ_START_TOKEN;
>  }
>  
>  static void *single_next(struct seq_file *p, void *v, loff_t *pos)
> diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> index 88cc16444b43..60820ab511d2 100644
> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -162,6 +162,7 @@ int seq_dentry(struct seq_file *, struct dentry *, const char *);
>  int seq_path_root(struct seq_file *m, const struct path *path,
>  		  const struct path *root, const char *esc);
>  
> +void *single_start(struct seq_file *, loff_t *);
>  int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
>  int single_open_size(struct file *, int (*)(struct seq_file *, void *), void *, size_t);
>  int single_release(struct inode *, struct file *);
> -- 
> 2.34.1
> 
