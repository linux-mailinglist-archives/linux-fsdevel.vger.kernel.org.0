Return-Path: <linux-fsdevel+bounces-8412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 587B6836050
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 12:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF3F1F281EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 11:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC113A8CD;
	Mon, 22 Jan 2024 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMuaBy7Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECEE39AE8;
	Mon, 22 Jan 2024 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921409; cv=none; b=AhoBnrGJaKNrp5vZlSTZ1d4H6Yzth0pQURsWR+/fC/6arnq1lfq6GA+SfgIBA1BPPfVHxtEhsPkiuqy/AfPBOoLTMbTWZcahdD5XKfsFMk23CxiE9QAaKF4Qe0upfxyaHSzmGSI64h/PKBL5sL4XfKOpbaQJCeLVZtslPnWOnt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921409; c=relaxed/simple;
	bh=6CpJyM0xC2SpZ3IfFq61UhU8u/PyEEKm2vh2F1bgl/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuPrFRMtdRVNCNMNjaOSNRhOUqaNIwk76eXbGk5RDlC8tXSDzlfogVrXyJtlEjLBzmjGNKOROCJhXjKNQU/vqXWkQY4BPAuuDEI1GFGS0sacgk6XS7vGC1eNqyn1LhI/UxJgGsoiAwiSeQpL50zctQQCntTVKlULjQGE3Ui2Yeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMuaBy7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933F0C433F1;
	Mon, 22 Jan 2024 11:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921408;
	bh=6CpJyM0xC2SpZ3IfFq61UhU8u/PyEEKm2vh2F1bgl/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LMuaBy7YNKqgXP+g1PazxNm6iFgYjRZsO/SreZ3fHp1L07OjTeEWUyoto0uB15z2I
	 LruRKHar2RsEJ9jliqdpoD9cC/TwnhWEz6giO016jChY/LYP64VfSHYrScThnTg0KH
	 aUM4418m4mG0S+BLLUkd1Ra2eFcukz+9/7HNZNzMkJmkWsPtX3g/BxmGltGAywp4SZ
	 OcfnKjx1AalLGM+zTafg9hcZ/DDjabEgv6Fvgy5hfS+fnyZTNq3SU3oT+MDpMioPWf
	 Bf9pBf8dQG3vW9t5+LFkjw368OYE6TB8O+394fqtfX44TUoy6F9U8ejwOc0bBMe3g8
	 LjekVriBjwrwQ==
From: Christian Brauner <brauner@kernel.org>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] do_sys_name_to_handle(): use kzalloc() to fix kernel-infoleak
Date: Mon, 22 Jan 2024 12:03:10 +0100
Message-ID: <20240122-dahin-werden-289c66dfc773@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119153906.4367-1-n.zhandarovich@fintech.ru>
References: <20240119153906.4367-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572; i=brauner@kernel.org; h=from:subject:message-id; bh=6CpJyM0xC2SpZ3IfFq61UhU8u/PyEEKm2vh2F1bgl/Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu864IvHuoxiVFwZUnwXSSjNxy5Yzai3v8Gs9tmBBoz h8zP/NxRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ232Vk2KwW6n3zfYymsHHD iWuvnEqeOnv7PurnX7N5fsWakgV3VRkZnluy/TCt5tTMrqt3i2fdk7fD5+Ch42apHu7uy1+2BSS wAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 19 Jan 2024 07:39:06 -0800, Nikita Zhandarovich wrote:
> syzbot identified a kernel information leak vulnerability in
> do_sys_name_to_handle() and issued the following report [1].
> 
> [1]
> "BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x100 lib/usercopy.c:40
>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>  _copy_to_user+0xbc/0x100 lib/usercopy.c:40
>  copy_to_user include/linux/uaccess.h:191 [inline]
>  do_sys_name_to_handle fs/fhandle.c:73 [inline]
>  __do_sys_name_to_handle_at fs/fhandle.c:112 [inline]
>  __se_sys_name_to_handle_at+0x949/0xb10 fs/fhandle.c:94
>  __x64_sys_name_to_handle_at+0xe4/0x140 fs/fhandle.c:94
>  ...
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] do_sys_name_to_handle(): use kzalloc() to fix kernel-infoleak
      https://git.kernel.org/vfs/vfs/c/1b380b340f19

