Return-Path: <linux-fsdevel+bounces-45856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F7A7DAEE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 12:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D18F16BA98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 10:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1059230BD1;
	Mon,  7 Apr 2025 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoQJGt4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861B0188734;
	Mon,  7 Apr 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744021201; cv=none; b=oFt3GWzGoCkwBVzPAhRdYCqnfSq9jTZL7qzRb6kzugD3tPoNYry48HYO85r5qDH+klRYIlQZfbobUpcUnFHbPj8JMBsCj5F331rZIprVfqjJUYqDeC+zy5An3ry4NQ+E8XfqZlYT/kPSYsadqqzYjxpYEjXkgHVHnzRpYdUaOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744021201; c=relaxed/simple;
	bh=fOE7PhsEk111c/xuVjShlu3XR7z9BpbnHrZFHyI0M8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWsMkvqlISALcC+uLk7dG7vHga4h94EUpR0TP8/oSfPGJkRWQtyZ2esV6CUvP9Xu8MuTi82vkZJ84kVu/PTO+gkZ9KMwyy3A7I7EeEai623OLpbze4YITZgytX25kwo/eKY7PdwQZ6mDPDGjZKBNJ+66Wm2YcBXNhUDDDvJNG04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoQJGt4t; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so6779165a12.0;
        Mon, 07 Apr 2025 03:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744021198; x=1744625998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJP9lSW7SQVc6yP4D0YFHSUFBbe1K7yvZx+B6mncpJs=;
        b=WoQJGt4tKkAyrBPXfNscRTg9YbOyfHfy72Z/VRNBXXzjNnk87XQxpons0uuF//D/P3
         4JFJQTeseGdftkJ2AS/UiJHjki8ZvccQdzozQMRQNggfIbsc2DXn7h0VoEHPShW5hAIj
         qWkT4UcIekVPSQ175Il185U9gyN9HywJKk/xELahV+bV0F4iq4FtK/sHa+ydvAHK+gzL
         j54aw/uKY2dGT9wKo+qnEo4+KpWHN80I3EFywkRxJJXTeeXIMrkYzZcoc/r8zjHJ37fP
         phEyAcpNB2TvD5Y6oqEmpIYl1Xu4WYFt2ZySaHh22VkVV+mEPdugHLCaa10H4BotKFzR
         rgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744021198; x=1744625998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJP9lSW7SQVc6yP4D0YFHSUFBbe1K7yvZx+B6mncpJs=;
        b=si4aXLzWrBycNb6AGtGE00vVGMK2pD2y9uYPZbOlDNomZVPoOOxdpWAlsfnq8l1plG
         92qCY2YvH0i6SRDGWkXFN1Iv7OAUl07shR9gzewV9uRZNwyaBut8x/5pL4jjT0wtyKRv
         xDqX+IB3QJstPywDnJyOpZPy/zXuSK69bTnaOjLfLcd90Zv0+jENiLzJ8tuuRywG+9/y
         Cjo+8RZZbnUDDvKsq/uIDvviWpHiRUihwfLGmOrKD9MQqWeewegssMEKc6/rK20TuQ7A
         eZruLsE4EXOela0hLL0bdrsyoODCUe3kOenEmqYMGKUAAsIkE8M8lFFi/Lsy/cgaFHQw
         IlUA==
X-Forwarded-Encrypted: i=1; AJvYcCVBQEj5yQcxBiiLrwHjNuJLk3SjBib96K8um2tKMtHSBORcZTY6jE9gYhpNN7oSq0GgnuREqzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxynNVk9QMuyFGpyptZ6jm+5nVJq6JDF2ZP73swEja7NsBLKDme
	Jbfe3LYVFMnC71MAm/ueUGwT5v7j5kIosXTXZqtPgEZl319ndT4lRBHmr4eGdcHIx+QPxgtSPYX
	O94PMzWxAsSxGyVM22w7kIWUirx0=
X-Gm-Gg: ASbGncvHi45eu9H3B/UPxA3Syvlh4v5hHUtGEycv1J01AxOlZYRLn7dndaMr0WsQctQ
	5VIQM1P3TMEWZGvva8CttWoFAApAEXYeA4q08zk4aLvnALHEKoWepRMYeUUqAHMrH7KkzVsDqUM
	JHqnMQ71nC5rWKXLCdCpRbSi6a8Q==
X-Google-Smtp-Source: AGHT+IFhVRK3HEOQyNKeUoqS7l4PomUqn0mNgFaxOXUm0OvxdIJFzL+Fp/yI1Ya2obVNPbSiEadIwrE/gpeTdz8s4Vg=
X-Received: by 2002:a05:6402:84d:b0:5ec:c990:b578 with SMTP id
 4fb4d7f45d1cf-5f0b647eff2mr9236038a12.19.1744021197643; Mon, 07 Apr 2025
 03:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
In-Reply-To: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 7 Apr 2025 12:19:45 +0200
X-Gm-Features: ATxdqUHBT1b03vrLukpC4HfGYCF95trwdWX1b9FKGRLf5q5lTBCZFPGs_7DQx_8
Message-ID: <CAGudoHHbkbaeqTrNJZxCnpB_4zokQobWfK_AP4nU78B58e9Tow@mail.gmail.com>
Subject: Re: [PATCH 0/9] fs: harden anon inodes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Penglei Jiang <superman.xpt@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 11:54=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> * Anonymous inodes currently don't come with a proper mode causing
>   issues in the kernel when we want to add useful VFS debug assert. Fix
>   that by giving them a proper mode and masking it off when we report it
>   to userspace which relies on them not having any mode.
>
> * Anonymous inodes currently allow to change inode attributes because
>   the VFS falls back to simple_setattr() if i_op->setattr isn't
>   implemented. This means the ownership and mode for every single user
>   of anon_inode_inode can be changed. Block that as it's either useless
>   or actively harmful. If specific ownership is needed the respective
>   subsystem should allocate anonymous inodes from their own private
>   superblock.
>
> * Port pidfs to the new anon_inode_{g,s}etattr() helpers.
>
> * Add proper tests for anonymous inode behavior.
>
> The anonymous inode specific fixes should ideally be backported to all
> LTS kernels.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Christian Brauner (9):
>       anon_inode: use a proper mode internally
>       pidfs: use anon_inode_getattr()
>       anon_inode: explicitly block ->setattr()
>       pidfs: use anon_inode_setattr()
>       anon_inode: raise SB_I_NODEV and SB_I_NOEXEC
>       selftests/filesystems: add first test for anonymous inodes
>       selftests/filesystems: add second test for anonymous inodes
>       selftests/filesystems: add third test for anonymous inodes
>       selftests/filesystems: add fourth test for anonymous inodes
>

I have two nits, past that LGTM

1. I would add a comment explaining why S_IFREG in alloc_anon_inode()
2. commit messages for selftests could spell out what's being added
instead of being counted, it's all one-liners

for example:
selftests/filesystems: validate that anonymous inodes cannot be chown()ed

--=20
Mateusz Guzik <mjguzik gmail.com>

