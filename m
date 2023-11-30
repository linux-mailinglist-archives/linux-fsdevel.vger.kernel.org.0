Return-Path: <linux-fsdevel+bounces-4386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B7A7FF2A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618FDB2116D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC37D51007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VkLS+s2K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426E6D6C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 05:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6CJTndjC0BkUG0zxRnp6P7rtXXhMkx8qDYXxvC7SOTI=; b=VkLS+s2KfEhlfFJKShECB7lE4z
	Nks5ZnK9s4baxBaANARkMeLYGLbfJ9JZxtxyYLA22kHpYIrvKTkm2ZSi0esh3RMV6o0lk1o8/j2IF
	E/q810zRitz6WMGn9jlCz/2GCON76IOYroRCkogjOOYuFVLM7iWcN4SsIdq209d1Y4aKXgmivdPD7
	klcBZJOnwa5iGStG/BUEQxfyRZlC8ZfUpc+sn4RUvXb+/e25HUXtfPgV3e0yT/QsMwTiFIaqitaeA
	GxjSzYmWSUQREdFBToehlnh8KNjIQquhbDy6f5G/NH3NUWZYEwJSaziOhtI7Ob79RlnooxQzRs2CX
	rsMvbdYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r8gxn-00EToB-Pi; Thu, 30 Nov 2023 13:20:19 +0000
Date: Thu, 30 Nov 2023 13:20:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Carlos Llamas <cmllamas@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 5/5] file: remove __receive_fd()
Message-ID: <ZWiMEwj/PE24AYLj@casper.infradead.org>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
 <20231130-vfs-files-fixes-v1-5-e73ca6f4ea83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130-vfs-files-fixes-v1-5-e73ca6f4ea83@kernel.org>

On Thu, Nov 30, 2023 at 01:49:11PM +0100, Christian Brauner wrote:
> +++ b/include/linux/file.h
> @@ -96,10 +96,7 @@ DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
>  
>  extern void fd_install(unsigned int fd, struct file *file);
>  
> -extern int __receive_fd(struct file *file, int __user *ufd,
> -			unsigned int o_flags);
> -
> -extern int receive_fd(struct file *file, unsigned int o_flags);
> +extern int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags);

You could drop the 'extern' while you're at it.

