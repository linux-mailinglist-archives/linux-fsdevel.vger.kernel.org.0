Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0586943F8CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 10:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhJ2I2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 04:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232305AbhJ2I2x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:28:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2B776115C;
        Fri, 29 Oct 2021 08:26:22 +0000 (UTC)
Date:   Fri, 29 Oct 2021 10:26:20 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, revest@chromium.org, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] seq_file: fix passing wrong private data
Message-ID: <20211029082620.jlnauplkyqmaz3ze@wittgenstein>
References: <20211029032638.84884-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211029032638.84884-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 11:26:38AM +0800, Muchun Song wrote:
> DEFINE_PROC_SHOW_ATTRIBUTE() is supposed to be used to define a series
> of functions and variables to register proc file easily. And the users
> can use proc_create_data() to pass their own private data and get it
> via seq->private in the callback. Unfortunately, the proc file system
> use PDE_DATA() to get private data instead of inode->i_private. So fix
> it. Fortunately, there only one user of it which does not pass any
> private data, so this bug does not break any in-tree codes.
> 
> Fixes: 97a32539b956 ("proc: convert everything to "struct proc_ops"")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/seq_file.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> index 103776e18555..72dbb44a4573 100644
> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -209,7 +209,7 @@ static const struct file_operations __name ## _fops = {			\
>  #define DEFINE_PROC_SHOW_ATTRIBUTE(__name)				\
>  static int __name ## _open(struct inode *inode, struct file *file)	\
>  {									\
> -	return single_open(file, __name ## _show, inode->i_private);	\
> +	return single_open(file, __name ## _show, PDE_DATA(inode));	\
>  }									\
>  									\
>  static const struct proc_ops __name ## _proc_ops = {			\

Hm, after your change DEFINE_SHOW_ATTRIBUTE() and
DEFINE_PROC_SHOW_ATTRIBUTE() macros do exactly the same things, right?:

#define DEFINE_SHOW_ATTRIBUTE(__name)					\
static int __name ## _open(struct inode *inode, struct file *file)	\
{									\
	return single_open(file, __name ## _show, inode->i_private);	\
}									\
									\
static const struct file_operations __name ## _fops = {			\
	.owner		= THIS_MODULE,					\
	.open		= __name ## _open,				\
	.read		= seq_read,					\
	.llseek		= seq_lseek,					\
	.release	= single_release,				\
}

#define DEFINE_PROC_SHOW_ATTRIBUTE(__name)				\
static int __name ## _open(struct inode *inode, struct file *file)	\
{									\
	return single_open(file, __name ## _show, inode->i_private);	\
}									\

Can't you just replace the single instance where
DEFINE_PROC_SHOW_ATTRIBUTE with DEFINE_SHOW_ATTRIBUTE() and remove
DEFINE_PROC_SHOW_ATTRIBUTE completely?

Christian
