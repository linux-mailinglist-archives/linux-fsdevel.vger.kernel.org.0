Return-Path: <linux-fsdevel+bounces-23203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A699928A29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E31289963
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 13:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E3714D71D;
	Fri,  5 Jul 2024 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jex1gBGw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462FB1459E8;
	Fri,  5 Jul 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187504; cv=none; b=ZWWOdqoMF+Fo6oTOt6dLwR7DbibSLpsfBqUuUz9JjRT4Ny72ySc6sZlJJeZ9nILPbL4EqgAVTvWekMV/3FSJwjwB6Nn4mHfz7JZJw6T4yLLLABIuIpUKWF8gfBVTfarcfEMqWBaLPkswfghIpXumRfpcHsjLce5JjGvucEkhMag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187504; c=relaxed/simple;
	bh=urUDF153CoiDcMDWRDMzDWpAaTmQ8cCHwSJ9+UdzMEQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gGxjEiZwaNxxarQl6MppxAc+TfbzNn2hwO3+j2IvG4e2o5t4bMJgnFH2qD0T6xFINid7Sd+Z4Y/op9L2tzpbrqFJnOMozT/DVNCvIK2uwmIBiHh00ssCDsdiJe1RgKJIS6WGoov7TbFOs7uJ0S2PIcfUendudfXzIEGq/xVPtIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jex1gBGw; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1720187186; bh=fhVbaIgGwwHNR/kKBaEYStBQPHJD4wLkX8sJh3fGGOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jex1gBGwQ+BCNgn4I53sSLWeZI2tIu8xaKXL0z7e29/EJuw3onodqTV27uveil9FY
	 P4pgKLGa41heVxYGRIXoS6Xly+9aXcz3WXpLJorXFrly8gReaapNNr+pZ7QC470dHA
	 G31481BwJfZTlDYyfieYzrYbVyw+TQj0AeLo1bWA=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id B97A02F4; Fri, 05 Jul 2024 21:46:23 +0800
X-QQ-mid: xmsmtpt1720187183t2a0ysnof
Message-ID: <tencent_7DB079166D742F9D6DFC94D8E95EED4ECC0A@qq.com>
X-QQ-XMAILINFO: NY/MPejODIJVT7nc4vCek/Paguko6wt8f5U6j7JStUxYtoUIGpo8/CRRhiWXP9
	 g0wl1gPyP/S0DKhyygNsxG1ymjdGaLhSpwuLvmJzhbgIFcWWhPukKLmX/zALzr5+BR4xPsAV5Q+r
	 NIa4bxCoo/dKbZaiezSsu9l02qI+pixwSJieaNzysbf70xCTtbeu3XxD3D6lEuO3IqCFqfEpeQuQ
	 mqSqU2j8/RAv6cysCiRS6PAVHA31IBGAic6FBo7BnqzVdQKb6NGAhgCBelNRYbaNDEVZchOMKfvP
	 eO7jk2nWByphkL8nMovYHSOUb/q+/yfknYLDYfjT+QZk2cGMGMPBlnFUpj7mZ9fpLnWzIBD97DBo
	 KluHv+BKs/kWZqG3Q7V8TNhqs8o4M3+fQHwbJ4LHeMLYAMA+lZ/VJOJXtlq1NHzw8Ys46SYp0fvp
	 hndBZHx7yF43grW0sFEoh1UtxAReTJfwPbqfdNEBdpTVcDAM9eOwyWIpFI02D1kTa0eTwzhLn5E6
	 pcfqupHFatZIfA4/W8HtpEeKesmaNgH+xggNiG02Eb1A66aYbxepgD8lMbQzcuxR4uu/ePf08Z9o
	 DTKEf2bCLqiHNNSsMNddTb6jSxOaDm37X//8gbG/hO2RzCCZ/eAulvlAL72cmEqXPuX05OMKDCX/
	 W6NzYT05Bu0PCfktg7iJecsfFtraiTS0I2gmsQoKb+EvUzz+EPwoAiEgbtuhNLLcuAQEEvUvLbwh
	 17HylpWoQ1duSHexbh2xRBKGG018AOq4lJNG+4jEugHXqNOgUo1BbaCUIwJHJM7BocGrC4UWnHFj
	 wl02FOvoqSwFggJzTXNdxtE18+0Dwz+AfiPhXnPQV7ulv7QjpX60W42OZLdPNvzVgWHcyt04HMgR
	 bpx5kmCMeCTdsQ7UopHqketK09Suki8MiwNfVBW1MajuiBHbGhQLi1nS4rkqMSWIJBQtVJ+8NNpd
	 +yTII+Bic=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: dvyukov@google.com
Cc: eadavis@qq.com,
	kees@kernel.org,
	brauner@kernel.org,
	walmeida@microsoft.com,
	justinstitt@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] hfsplus: fix uninit-value in copy_name
Date: Fri,  5 Jul 2024 21:46:21 +0800
X-OQ-MSGID: <20240705134620.654516-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACT4Y+agurcHCQnLTrVjLXr1-kEj1wbmXCHX6LPM=J1-o5wT2g@mail.gmail.com>
References: <CACT4Y+agurcHCQnLTrVjLXr1-kEj1wbmXCHX6LPM=J1-o5wT2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 4 Jul 2024 15:36:37 +0200, Dmitry Vyukov wrote:
> > [syzbot reported]
> > BUG: KMSAN: uninit-value in sized_strscpy+0xc4/0x160
> >  sized_strscpy+0xc4/0x160
> >  copy_name+0x2af/0x320 fs/hfsplus/xattr.c:411
> >  hfsplus_listxattr+0x11e9/0x1a50 fs/hfsplus/xattr.c:750
> >  vfs_listxattr fs/xattr.c:493 [inline]
> >  listxattr+0x1f3/0x6b0 fs/xattr.c:840
> >  path_listxattr fs/xattr.c:864 [inline]
> >  __do_sys_listxattr fs/xattr.c:876 [inline]
> >  __se_sys_listxattr fs/xattr.c:873 [inline]
> >  __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
> >  x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Uninit was created at:
> >  slab_post_alloc_hook mm/slub.c:3877 [inline]
> >  slab_alloc_node mm/slub.c:3918 [inline]
> >  kmalloc_trace+0x57b/0xbe0 mm/slub.c:4065
> >  kmalloc include/linux/slab.h:628 [inline]
> >  hfsplus_listxattr+0x4cc/0x1a50 fs/hfsplus/xattr.c:699
> >  vfs_listxattr fs/xattr.c:493 [inline]
> >  listxattr+0x1f3/0x6b0 fs/xattr.c:840
> >  path_listxattr fs/xattr.c:864 [inline]
> >  __do_sys_listxattr fs/xattr.c:876 [inline]
> >  __se_sys_listxattr fs/xattr.c:873 [inline]
> >  __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
> >  x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > [Fix]
> > When allocating memory to strbuf, initialize memory to 0.
> >
> > Reported-and-tested-by: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  fs/hfsplus/xattr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> > index 9c9ff6b8c6f7..858029b1c173 100644
> > --- a/fs/hfsplus/xattr.c
> > +++ b/fs/hfsplus/xattr.c
> > @@ -698,7 +698,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
> >                 return err;
> >         }
> >
> > -       strbuf = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
> > +       strbuf = kzalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
> >                         XATTR_MAC_OSX_PREFIX_LEN + 1, GFP_KERNEL);
> >         if (!strbuf) {
> >                 res = -ENOMEM;
> 
> Hi Edward,
> 
> Was this ever merged anywhere? I still don't see it upstream.
Yes, me too.

--
Edward


