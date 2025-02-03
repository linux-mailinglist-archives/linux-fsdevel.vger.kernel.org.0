Return-Path: <linux-fsdevel+bounces-40586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E1A257E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 12:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892BA1887F9E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6420127C;
	Mon,  3 Feb 2025 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bFUhXZUd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2230A1E7C06;
	Mon,  3 Feb 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738581409; cv=none; b=PaGg4+5qW8F9J6AC9wf43mOaRImH6oNpt8ePZb4pRFjtwNAbo14MuR1We7nGiD5JUwN0mHTWxFwXYf0TnfEc68+TmlT8yeKzO0QVQ7K4Ay9UFGc0QAgxtHIztQ5d9hGFzSOO/CqYYp+dOAkBzpAAn/8Z7dcLrv6DN3OASt1izOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738581409; c=relaxed/simple;
	bh=4cLuk3/bBdkXe1iD03O4EWVeNfknvWN9sou4S9TbD/4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DxdrC4yO2waymU+GvA4eA5SdAGG3ufH2iN53ACjkHCEqHJuhflU1KwzVa9SnVEITgioSE4LgwXfVRN6Jeh9NiYnU1h5zCJ5JPr99Kr2M0jWxVwE0mYHNdMVYUbU7cB8+fVsporvSJzWEcU/1HS96iS4r+XS2iv6uF3BTtnTde/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bFUhXZUd; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1738581099; bh=JfvSvU+QwvlwjdxMt/E53LlcaB/6fR5rxo1LzD329WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bFUhXZUdqKNb0PhEvtCS26Lu9lXpgVB5p0d8bVCrSJVgg6Rqq5CtLJOE31c9kl67/
	 fpy5O8p3W+b4kKr/Ek8xBZ4R9pwbZunt3Hf6QtVNbl3himQZZvNm+NcwgffnBXz/Y+
	 kSOu9NYUIVelek7EAt9/tDNo0MD5ymDGyfFPwm8M=
Received: from pek-lxu-l1.wrs.com ([2408:8435:9930:1dde:8cb3:3b5b:faa2:1ccb])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id 16128AAC; Mon, 03 Feb 2025 19:05:33 +0800
X-QQ-mid: xmsmtpt1738580733t17ya3rep
Message-ID: <tencent_B0364B121B102524BA72BB5E33CB9E531B08@qq.com>
X-QQ-XMAILINFO: New1l5u9k9F/qxJOJolCbWg6+03aUQgy+QWjABnxnr4xBRWkUWZIV4FQapm1uC
	 oYzfpjpl9O8T/a4S8S1IhESX6otrAMeaq5pPKAo5cESIc/WIxFND14Ci5Dnx7x24X9BMnFh4h7/j
	 0ygcEotz1xYawmyoPNv8ktB1DixaG8cyYxlZXq/13wpegTZJMJJ9yrvfx6dWAlUO9oCiXzqRUnXV
	 nRUygEDkR95lRbufW7MEoyDyaLCOfYlGr7IHyrszBzTwdy9kCYDNyhBkmR+UoxaoYBQx7gVf3FBx
	 DH7h6jCbTQaG1NPzigLAkYiVsrFcC1VnvhgPrlEeeg9DAdgxky6RMQ67OkvBaSwShjsO3ZjlXRIM
	 CUuJWTWXEa32Fq3v7TAHqOB9NdJEV0xmyRMU1UscYOEkKLhGF/JxAf873ElXnVhNbLaTPou+UGF3
	 rX1JZ9iuZ2i7uJJ0Fpuf6mhp8i1eeMSO3alPdqB9CWoN3xBAi6Xbxcxz+q1EPZsTl3JjTbOVc/dc
	 I/Mj/0IWmegj3rAAzBqp3iT6ZLWyrvhfL16GcomQ2DyEQPuvsfR5STsdG860mRvhxrisWjE9vov8
	 gHjb8qBZJqPtE/pKpVjJMbBW7URHH2QCCDqnXSP6IzpxlHemW4K8cziyWeyaFimO9dfePWYiNkvW
	 13bbtDnocLw0k632it9MCWq8N+Mg+bfT3wPqsywUzXUDlADbXRXqxOdUC1BvgU1TDR3akoP/zyuO
	 Wz+ppYT2dh31Cz0RpiTy3AvR6Gk1fq5Ms4SheMQDDe0ejEj9VgGogiJztLg/3ebbZH78cdpQzf5G
	 WorGOLqiRB3MlNZJEHQwgnq5Cs94xphzTe5v+UK2buoXvgBIalqJDpLsVX3v2rswFLsJp8/epVY4
	 qvNdRMpYSP9qRrpd2mXEAmoOXrEPrmkD3aSdTvh5UbI7Aoa1EhU7wjWf8PE69p/7rvOxrkUK7r
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: gregkh@linuxfoundation.org
Cc: dakr@kernel.org,
	eadavis@qq.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] debugfs: add fsd's methods initialization
Date: Mon,  3 Feb 2025 19:05:32 +0800
X-OQ-MSGID: <20250203110532.1515323-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2025020345-breath-comma-4097@gregkh>
References: <2025020345-breath-comma-4097@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 3 Feb 2025 09:14:51 +0100, Greg KH wrote:
> On Mon, Feb 03, 2025 at 11:27:56AM +0800, Edward Adam Davis wrote:
> > syzbot reported a uninit-value in full_proxy_unlocked_ioctl. [1]
> >
> > The newly created fsd does not initialize methods, and increases the
> > initialization of methods for fsd.
> >
> > [1]
> > BUG: KMSAN: uninit-value in full_proxy_unlocked_ioctl+0xed/0x3a0 fs/debugfs/file.c:399
> >  full_proxy_unlocked_ioctl+0xed/0x3a0 fs/debugfs/file.c:399
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:906 [inline]
> >  __se_sys_ioctl+0x246/0x440 fs/ioctl.c:892
> >  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:892
> >  x64_sys_call+0x19f0/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:17
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Fixes: 41a0ecc0997c ("debugfs: get rid of dynamically allocation proxy_ops")
> > Reported-by: syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=8928e473a91452caca2f
> > Tested-by: syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  fs/debugfs/file.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Is this still an issue on 6.14-rc1, specifically after commit
> 57b314752ec0 ("debugfs: Fix the missing initializations in
> __debugfs_file_get()")?
No.

Edward


