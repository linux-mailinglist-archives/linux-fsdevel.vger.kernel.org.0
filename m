Return-Path: <linux-fsdevel+bounces-48275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37FDAACC76
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AD3500901
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 17:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2D22857C2;
	Tue,  6 May 2025 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVsS6cZc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF3619DF8D;
	Tue,  6 May 2025 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553654; cv=none; b=jSkgV8G0KP84+QIHqkiZI7PeACZe2I/T9WgQ6276CAshHIRPcT7bck2Gc8NX6xryv1CCfGpfcI7c6ZrPMrqIQR8zp+TxZgfD3rrQGvz1ITTnJU5kaY+N4ZgLqtwsYZ0ej25xUZkRwvtw8BMvJtUlY1sQT+dG2XRjq6dDJI8CArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553654; c=relaxed/simple;
	bh=0cMsUtIJLhoBR7Cb9fzfigQ2s/NVRlIlBIhE6lmRySE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTM0oAShN0YMcYhIsOzbDTGxYQoU4F+lpHcnj/L7WzDfFZGrtPgsQ5WAtWr+r7V/3PH8PrUeB3XeWx6IcKq/9CBefX5ZhVN7B6NZz/GHnupMVrQK66CoiPguKqSIiK+ur2G7UlkZAmM2t5wOSkxYj6ZwO2RmaTYsnYswpHpnjak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVsS6cZc; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac3b12e8518so1015158266b.0;
        Tue, 06 May 2025 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746553651; x=1747158451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ErcZWjZ/E0Ae1siPNxNaDSU/qOrwFTKlxdyhXZdSea8=;
        b=mVsS6cZcrEe8zSRk0mlYl7jWTe1fxTQSPyl9X3SehdAz6cz2/Q7kx7+s7u4MOr8PKQ
         Ef1yshDJKSl/ANZ/muH/MVJfECqjn7Q0WOu4Dp/Xc1FzJh8FY5NglRocN3rjk/P1yHqx
         bfh/k83Yl8xIsX/6J8VLwLib5ncashXYM8lIvA4gP09UDOCrdw12jypU8DU/14salyF8
         4fISi77t8SS9TYTTmKjoMAVtq8zCGGZ9RXUblXSgo1LXT8wBwuPRxGE29v5U5lQorwTF
         PdL83t6chAXEIDsDpMkjoMTFKQIf22nZj7+WW8LurznFF+P/pz6cmtRdBTnYcjVwjVFq
         Zz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746553651; x=1747158451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErcZWjZ/E0Ae1siPNxNaDSU/qOrwFTKlxdyhXZdSea8=;
        b=nsodH/Gg6LaSt0VY0fiG7lhNeOUqHrJZVzBr9wIr2A+ITF/+VXl9/xljanbN2yjNb5
         8KQvyZrPijmajqvvAAoDi7+KwMvGO4rIxD5CqWOkuHMgrOdNqX1KAhK+liXeqM4SjLqq
         z9MQ9CcQWboqkDLoDR38sQeHjSRRLvBednMdaSyPGgXE2T2yQ58sIl333zqtW2r7dRVQ
         o8CL942tIMFqRQNiR+0BHCG13pNl0Ci1qFUwPp12eqQarrCBICXUfa2ase7KX6ZL1p1M
         aSwwovkjnLj+K/3MvZVTJWf5eX8EEPtkFUXsxdwApYKGbhfsP3icKFZxVaPUCk0lWJpI
         2kdA==
X-Forwarded-Encrypted: i=1; AJvYcCXXsaLXCBvgCYJ8jhquO47LJm5A6tTh6ZEDdDo7+DtXtAIZhmH17Rljc0sdem7m/5V/vQlDeifSvU8S0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx4SbjdJ5W0K4lVdoO0b3ETXFWkRKeWPiWPRuYoO8UQdtxJAEJ
	jzapN7bWDsVm2OUFk/lssGp5SW19CFmR4uFhFvO3/sneUiVawQi8cFHUrA==
X-Gm-Gg: ASbGncsxi0e8JiAiwfJ8xN1wpvZCFDlTE6IhgHv8iqek7+0KrocGEpyqunPgUceF7dQ
	5/yZy0z6aSbEPn95JyDjPaOu/q8m4R/wiHDWerqLDoqq1WsN+xheLAk95xRN0FQ/LzARv+Jd2Qb
	N2jPxXV4k3h+Nme90drMmJFCyyxj+LiMcvBqKYFTl5/fIxD6rwuIL9QCIqWWk65UKgUF3AK4kfL
	0SKbryfqbB4zHOOuau2onK0vhvgJpLCV+euufyYGZLGeL/pSYexr/GI2OFo73BQJ3zdsRVIeNHL
	/5fEWXIRzjyQcJJuIYdPAZeithyBdLidkAfrLaynZ6fN/G+/5LLZHhw=
X-Google-Smtp-Source: AGHT+IEqPQ72XbVqeEqU7BLGO0jFQVAojvqwGL+8TlAt6ccnslC5SgsEPQQr3pRpgYi9RiJ5xpkV3Q==
X-Received: by 2002:a17:907:c287:b0:ace:bead:5ee7 with SMTP id a640c23a62f3a-ad1e8cd65admr37049566b.39.1746553650560;
        Tue, 06 May 2025 10:47:30 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad1891a766fsm754374766b.69.2025.05.06.10.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 10:47:30 -0700 (PDT)
Date: Tue, 6 May 2025 19:47:29 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <j2tom2y6562wa7r6wjsxwgc25t3uoine45ills367o4y2booxr@3jdyomwkvt6w>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
 <20250506172539.GN2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506172539.GN2023217@ZenIV>

On 2025-05-06 18:25:39 +0100, Al Viro wrote:
> On Tue, May 06, 2025 at 03:36:03PM +0200, Klara Modin wrote:
> 
> >   25:	49 8b 44 24 60       	mov    0x60(%r12),%rax
> 	rax = fc->root
> >   2a:*	48 8b 78 68          	mov    0x68(%rax),%rdi		<-- trapping instruction
> 	rdi = rax->d_sb, hitting rax == 0
> 
> > > -	mnt = fc_mount(dup_fc);
> > > -	if (IS_ERR(mnt)) {
> > > -		put_fs_context(dup_fc);
> > > -		return PTR_ERR(mnt);
> > > +	ret = vfs_get_tree(dup_fc);
> > > +	if (!ret) {
> > > +		ret = btrfs_reconfigure_for_mount(dup_fc);
> > > +		up_write(&fc->root->d_sb->s_umount);
> 
> ... here.  D'oh...  Should be dup_fc, obviously - fc->root hadn't been
> set yet.  Make that line
> 		up_write(&dup_fc->root->d_sb->s_umount);
> and see if it helps.  Sorry about the braino...

Thanks, that fixes the oops for me.

Though now I hit another issue which I don't know if it's related or
not. I'm using an overlay mount with squashfs as lower and btrfs as
upper. The mount fails with invalid argument and I see this in the log:

overlayfs: failed to clone upperpath

