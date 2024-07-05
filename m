Return-Path: <linux-fsdevel+bounces-23247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02485928EBE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 23:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89BE284C96
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 21:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75C714535E;
	Fri,  5 Jul 2024 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCzI3kcO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEE81C693;
	Fri,  5 Jul 2024 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720214474; cv=none; b=LP14KMTnYSjQPH9+c6hrFY3ikVNParHSmAg+mFN3SF4UjhUj+1eV6khUZ6/IpoHhyD+JJEPjU5G+cXSudDLmHBscytii6P7Ho+jT0FKH+URIc6d9Wb2TLkKIqBei1DK0JHFmL+iO11wfIWgq8a6qVijEjwLNOXOQM+HQIKQJldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720214474; c=relaxed/simple;
	bh=259vAtFtfFin4zEglf9j2Tb2pv1+bgwmfztPjJ7NXCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwbDofk9R1J9RGBOiwU2BklTROBC4m5mUCpNK902yFVTFJy5PsRgULNpf8reeryV2XQX7drvs5YloL76KIh+UuKZawhMuTd+1sGSCZOAJugl43aELdQvzgwcQsW6mxQJnP+7uCr8bPemctma/IaF4M/uX0WNmiyi+uMjTN/QPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCzI3kcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB39C116B1;
	Fri,  5 Jul 2024 21:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720214473;
	bh=259vAtFtfFin4zEglf9j2Tb2pv1+bgwmfztPjJ7NXCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCzI3kcOSn8qkbh+/OajhItq1LWdc4obfyVBb33qBP0YL4g1Oa8uqRZQupqRnYQbZ
	 aMELap0lVZzrGwyNzPJ5cna0mZNOvDy0oJmFpnF5sE83DTj5UhPk23AUDXCzHwbhbo
	 IIAJTSO51aELYmb7dNEY5qkUOO9OE4jkZMJ0KNLQP445tA09JIeS8mMp0/QG6YOvMu
	 GO8Tyl/kuey89xenHruWQolaRu5xKcT1xw3IfEngw1osOmR6+/8ygkpbXl8U0Yk2aj
	 yPcZEcKjaAr8tSc70/dV7B62i15j6Hdw7Zxm5uOpiYNVwI99jptZNTRpQ3LtJQx0F2
	 Ug1AaCkk6UJWA==
From: Kees Cook <kees@kernel.org>
To: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] hfsplus: fix uninit-value in copy_name
Date: Fri,  5 Jul 2024 14:20:54 -0700
Message-Id: <172021445223.2844396.7059951310501602233.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_8BBB6433BC9E1C1B7B4BDF1BF52574BA8808@qq.com>
References: <00000000000037162f0618b6fefb@google.com> <tencent_8BBB6433BC9E1C1B7B4BDF1BF52574BA8808@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 21 May 2024 13:21:46 +0800, Edward Adam Davis wrote:
> [syzbot reported]
> BUG: KMSAN: uninit-value in sized_strscpy+0xc4/0x160
>  sized_strscpy+0xc4/0x160
>  copy_name+0x2af/0x320 fs/hfsplus/xattr.c:411
>  hfsplus_listxattr+0x11e9/0x1a50 fs/hfsplus/xattr.c:750
>  vfs_listxattr fs/xattr.c:493 [inline]
>  listxattr+0x1f3/0x6b0 fs/xattr.c:840
>  path_listxattr fs/xattr.c:864 [inline]
>  __do_sys_listxattr fs/xattr.c:876 [inline]
>  __se_sys_listxattr fs/xattr.c:873 [inline]
>  __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
>  x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

I've taken some security-related hfsplus stuff before, so:

Applied to for-next/hardening, thanks!

[1/1] hfsplus: fix uninit-value in copy_name
      https://git.kernel.org/kees/c/974a00974829

Take care,

-- 
Kees Cook


