Return-Path: <linux-fsdevel+bounces-245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E3C7C7F46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 10:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77511C20B08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 08:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3A810790;
	Fri, 13 Oct 2023 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUAua533"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E6101D6
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 08:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F00C433C8;
	Fri, 13 Oct 2023 08:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697184169;
	bh=mJLa5c8eeNEwknytjJiX4Qjb797Erhab9cpet2X/9qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUAua533AvvYtx7YEw0FOGLg1MYJ2Yojvo9t7M4cNHppwp8s+NDkHwuZamHPcRLIc
	 Aiw/XEiVglTNoCajTO2JwyPE6J+WPdkSC5G0LSw/ruNO1GTAHufbYeqMXOx/ze9jvm
	 r/hfuy1zZ2LLPES+j9Q4YDMQWdINwd9RsQc5bmrU4phQROB3O4Q6Dsj11x95pwWP5l
	 zv2PxzV0xpsqlpjhmfQXPMUDlK0E8EGQAAE8WzwdJ3oX5YLxx8UGxKYZYIrzSgcSY3
	 vl6aL9W1dK/6qr5VrJm4Fu3VHioZDkSlLkK5t8Opd93bs+GDyxy6ENyl/Iq/Bks4qa
	 CHBjbf2Z2ZLFQ==
Date: Fri, 13 Oct 2023 10:02:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: cheng.lin130@zte.com.cn
Cc: viro@zeniv.linux.org.uk, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	david@fromorbit.com, hch@infradead.org, jiang.yong5@zte.com.cn,
	wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [RFC PATCH] fs: introduce check for drop/inc_nlink
Message-ID: <20231013-tyrannisieren-umfassen-0047ab6279aa@brauner>
References: <202310131527303451636@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202310131527303451636@zte.com.cn>

On Fri, Oct 13, 2023 at 03:27:30PM +0800, cheng.lin130@zte.com.cn wrote:
> From: Cheng Lin <cheng.lin130@zte.com.cn>
> 
> Avoid inode nlink overflow or underflow.
> 
> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> ---

I'm very confused. There's no explanation why that's needed. As it
stands it's not possible to provide a useful review.

I'm not saying it's wrong. I just don't understand why and even if this
should please show up in the commit message.

>  fs/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 67611a360..8e6d62dc4 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -328,6 +328,9 @@ static void destroy_inode(struct inode *inode)
>  void drop_nlink(struct inode *inode)
>  {
>  	WARN_ON(inode->i_nlink == 0);
> +	if (unlikely(inode->i_nlink == 0))
> +		return;
> +
>  	inode->__i_nlink--;
>  	if (!inode->i_nlink)
>  		atomic_long_inc(&inode->i_sb->s_remove_count);
> @@ -388,6 +391,9 @@ void inc_nlink(struct inode *inode)
>  		atomic_long_dec(&inode->i_sb->s_remove_count);
>  	}
>  
> +	if (unlikely(inode->i_nlink == ~0U))
> +		return;
> +
>  	inode->__i_nlink++;
>  }
>  EXPORT_SYMBOL(inc_nlink);
> -- 
> 2.18.1



