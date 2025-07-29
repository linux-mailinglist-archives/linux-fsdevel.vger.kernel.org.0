Return-Path: <linux-fsdevel+bounces-56229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C63B147F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 07:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F633B339B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 05:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ED824728D;
	Tue, 29 Jul 2025 05:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="s9s85bL1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96586250;
	Tue, 29 Jul 2025 05:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753768502; cv=none; b=cdBhI31lsp6W75jjsFe5gV4j/qd9NfBibXYGEL9XTfShKpL480M3krezh94jDMpLBScyH6/qIgVcmIwsxNhTQuyX8/TQM8+yCvvaKfNZ7TVyEtSkKyq2QsO5ZdhwheZy/Y+ohytMr7A8ZVzL/O3Jb2sguHq8juzWw6bNIoBEjSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753768502; c=relaxed/simple;
	bh=dSkiCJRYUC5gMPYqulrLyOkTt0+ZLvRy/x0p12H0SQU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CNNH5t2KYKfXGu1AR0uhGcNiK82AQuvrqMe2jTGbTy/303p+mEw760nMaTUiX3eH+etYjFaVmKwF3o9Sf9CtbvC4WMywFG1AIubA+xxrhRC0W/EZgEqJT6e2EGVMSa6OUBQ6drqrgtbuUG3yZVVBjKz3jzKQBO84sgiszeNeX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=s9s85bL1; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753768489; bh=2B19zXSw2lQTFpkmw7cx+eHfc+ejMvACQ9HOdwmQKMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s9s85bL1oQYLHZ3+qrX1L8TXkmIcLGSwR3TOZmhIVGE5tym25k0ma7ernrDJJRa8R
	 0DAErgakGPMfZYdRgOkuiueFQaKCGbvIlaNvGd7tGJFaN4ytsum/RFmbmGiXIKsn2M
	 59C6bCm2ufUtbR/XL2OrCHRzYAouV1PccdX/cCSY=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.231.14])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 819964F9; Tue, 29 Jul 2025 13:32:25 +0800
X-QQ-mid: xmsmtpt1753767145tralx44bg
Message-ID: <tencent_341B732549BA50BB6733349E621B0D4B7A08@qq.com>
X-QQ-XMAILINFO: NAOky/E1C/Nc7MF6SFpsV6JrOSa0yKQaY22ZeYY8SxvRMVQ6i3Bj2Uuvas6Sqn
	 vW6Sb+ra91JljLGaTYB1vUyvJRbb8F8NGOOjua5st5nLIqTASQ3EzrO0jGUEeBqEG1Xn6spXG5f1
	 Vh2SfbI83fdULwizpeq2it+sTH75VarNnOVOZiJqmoBCb2CrbfU4FEizRvrMOHHgaAqoF0MX6ByI
	 IraXT7F6SQ+l/JIYMoMNCG+3wWLRZtWz1Be3mPYhAdrvpplhg6GdCI0tHO+OIv2fdGThkasTtu0c
	 uYexqkMfarJ/C6jzwq2pnV1ikDSJEU+DqXarBXDCJ6QfjClboqeHFtWX0OxpAaD8MlBJmHIcwy0R
	 x37zSBTANs2+2HXBf+C++zxGYSfLI4Nd7zoJ0pJnZ6xm0gRzRsfNi2Y6Fd2avjhqWCV8jN08pyBr
	 5l5he8fxHjoLTod00B9sNOwFFUVTM2CcfLx+CrdbQ2sLm0MDjspWsVCSko49xsRwLlwZZ3JLMBNe
	 88BIsaR8wY2t6BQbytRMGY19HSFlZdifMRh/T7gSJLwDBfsbQCj9sf5I5X+MEC3kqIf4MIvR5p7M
	 WcAaQL0Rt8IcwVc/XpsUrTcXYyy69PVH/FvdEemMQYu2HAVAkR9XsmWEvwYNZogqvQ+95amlhycH
	 /S9McJEk776IQnufszyQghjv9QtKjx2hxVmGg644XPFYlTjRsvXnhIUUXpBmwjl0LgNzAU36Ozyu
	 m1vs+axbAY1VTJ9+uEMiyCBF/wWsVzit/oCRU1uTTU3gZotu4IXVcv6g7q6WnUPRkyFkXmo0Ub4r
	 X4F197gk4NmUbqMt1UFMrffjjRrgd5MAWlt2pUM4Ac9PJ/a+tWh17Z4ct0kq4K/u2+IbbOLQy6LO
	 gmJZD7VfEMcDCWyXb1Dk+62J/8pfPcVEQTJJ+uXyFsW3ED+XHS28fR2ul33gc3xEghvM6g8EF8zg
	 GUilas8eTcMwZfap+a9sEsf2c/oN8jvmuLX8VZjRLNvIxSNUlQI7UNG9Ypr2Z4exi8ezXLoztWUq
	 DbAB9v7bqZzu7usuomopKXXIaGGSUVDCzHZVb8zo14Jj6ZcYT9
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: viro@zeniv.linux.org.uk
Cc: eadavis@qq.com,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fat: Prevent the race of read/write the FAT16 and FAT32 entry
Date: Tue, 29 Jul 2025 13:32:26 +0800
X-OQ-MSGID: <20250729053225.2576953-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729050413.GF222315@ZenIV>
References: <20250729050413.GF222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Jul 2025 05:53:23 +0100, Al Viro wrote:
>FAT12 problem is that FAT entries being accessed there are 12-bit, packed in
>pairs into an array of 3-byte values.  Have you actually read what the functions
I learned it. I didn't really understand this code, but after your hint,
I understood that the 12-bit entry FAT12 has 3 bytes, and cacheline will
not be an integer multiple of 3. Finally, the entry with fat12 may exceed
the judgment of cacheline.
>are doing?  There we *must* serialize the access to bytes that have 4 bits
>from one entry and 4 from another - there's no such thing as atomically
>update half a byte; it has to be read, modified and stored back.  If two
>threads try to do that to upper and lower halves of the same byte at the
>same time, the value will be corrupted.
I will change the fix to READ_ONCE/WRITE_ONCE later.

BR,
Edward


