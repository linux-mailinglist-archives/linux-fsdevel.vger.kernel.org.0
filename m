Return-Path: <linux-fsdevel+bounces-48744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0DBAB38A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 15:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874341892B96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 13:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B8F2957D5;
	Mon, 12 May 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuAJIsvf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65218294A10
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055976; cv=none; b=nMyhATFbmFj+T3bibEUkngk0kpcg8bW6HKhrBV8b4NSBQqZB21msC5oviZ1ritsPpMdaGd6U84GueydWlYkzN2SrUkSy2Yhzs7RbA6TczrIsFpi2I/Lh7FfaZCWH61RHPQmszRLOFA/0fA7qKGLyXOT4/stuEqiwKm6rQaAaxd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055976; c=relaxed/simple;
	bh=9gJF743RWK+bJ6m7oQyctUYpmbwhq5qenEdMjKDH0Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLiXoz98nzXlaMImjdnCAHd/CkxqjIOCINm1blt3N2k3/atoBMxLA8cgj1NFUG9hje7/ujEaoB0uJYM+0L+ppG4l7fX5XFxvvvl9G2Zeh/CPg3KAbye6AX41HoyGPgvbFvpeVnoTzYaDJky2jFZLHDTq33e8mHNFjC+hrSY1pZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UuAJIsvf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747055970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLzO0UetENOl7ymbAc9ZwNTqK+089tCghqZXKpGiOB4=;
	b=UuAJIsvfW4+AoYzMO82WlQva0FNBss819kdie+Y1gla4xWXCXat4G4RChBnv7ipOq6oUxv
	Br6f+nJl0GuI5ai23EYG7EVia3zOcQ+et17ET2y1Qaeug5om/4rivcht+OFOQKat472D9k
	RG5xBweDySQrH4O0iZGNXQoexMF9E1c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-bR4CeJsuMl2s-BWjTVp9Tw-1; Mon, 12 May 2025 09:19:27 -0400
X-MC-Unique: bR4CeJsuMl2s-BWjTVp9Tw-1
X-Mimecast-MFC-AGG-ID: bR4CeJsuMl2s-BWjTVp9Tw_1747055965
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ad2200eb1d0so203974466b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 06:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055965; x=1747660765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLzO0UetENOl7ymbAc9ZwNTqK+089tCghqZXKpGiOB4=;
        b=Q81+pnKsTHI5VGHc0I4SzBI3B72SUQJToknYmyocPBwxdlMtLaxN5XtrSuItqzo0VS
         Bkx1MhQptpTQKECG1y0xKAath+18mf0+coIcYMM1qdJzjB1WCel42KnI09mm7/KbrgkK
         BZrpw1/AG25BARChc6WKJ63jt1/eaCpyKvijMvGLhYRk3STd8OEXUte/0y4ukmXY2hcs
         WKxyAFt2qrHJvCgoY9eCHFhust6k+s+CbObIt8Xr2lSn48ZZsqP7OQfkPFn1cfVeKh1q
         y6W6Pol3A03rgxrj3iIEjbM3xNH3l5lhZ5IdF9sGCciXT7rWPAoqHKat4aJE+m555Tg0
         kFPg==
X-Forwarded-Encrypted: i=1; AJvYcCU1jnjPY4Rptm1+8acqTvulqBFg/fknhX0FQuaHWJIEWFM8W52JILCNsCeJOKXvWkke0dyw1/L4lm3JxutH@vger.kernel.org
X-Gm-Message-State: AOJu0YzZrurwT5hU/cQuW4cER3Ftqr7oHse2kSTIHwB44P5oBRytFJDn
	zKhb2N+rebXeXy5BYV3rRAgkKjza5ipG1bnS4AmA44u6s1YyUL7YjKIphcI9QK+MYGBPLKdtXB4
	DzL/CFlAYlDjYTkTg4rmiFqRhpaS2mcogkyEbFNpl015KpnAz6SJKaEQ7D9p+CA==
X-Gm-Gg: ASbGncupo+HiHtnpk4Q96iSxVpzB2a7BYFu7tt5lN917KRm83uVV+YzsJ9ulksp3/dQ
	ObrYJm2wc9LpeWOqN8OW3BHYOr3ZVIpO0tJ+X5rT+t0PmTCWoIxs3WYVvhTs4Dp4HzYId+f1mS/
	Z70mid3ejhnZmp6z72sJimjNphrK/Pkx85dv7XEwYGDUa44qopoff2Ki/iezhbUkKokKXUl/Jqp
	wp0PgcImvVrRNu/kKqi4uSxDn4v8rycG6+imc9RW1GnoovO2nSa7LHCC94tRJL96uswX4GGH1ms
	Y2lG9pmpmRl2L4RS2B1LHpiZFBw=
X-Received: by 2002:a17:907:8b99:b0:ad2:2d6e:4962 with SMTP id a640c23a62f3a-ad22d6e52c2mr855522966b.42.1747055965126;
        Mon, 12 May 2025 06:19:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa3ZpYdTF3qd17gWEoRTHMnv+pL5522+Z5nSX7r6uDpni86IH6A8IHgBLuulX9yc13mwfyKQ==
X-Received: by 2002:a17:907:8b99:b0:ad2:2d6e:4962 with SMTP id a640c23a62f3a-ad22d6e52c2mr855517166b.42.1747055964687;
        Mon, 12 May 2025 06:19:24 -0700 (PDT)
Received: from [127.0.0.1] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bde09sm612328766b.125.2025.05.12.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:19:24 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 May 2025 15:18:56 +0200
Subject: [PATCH v5 3/7] selinux: implement inode_file_[g|s]etattr hooks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-xattrat-syscall-v5-3-a88b20e37aae@kernel.org>
References: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
In-Reply-To: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
 selinux@vger.kernel.org, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=9gJF743RWK+bJ6m7oQyctUYpmbwhq5qenEdMjKDH0Lc=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMhS/+h/6tvS4ypammLpAoYZzNSvmXjrOE5DOrL33V
 8CXj52HDmR0lLIwiHExyIopsqyT1pqaVCSVf8SgRh5mDisTyBAGLk4BmMjE64wMK86tctk6J8PH
 5NWsT9K3ktK/ublm/c3lZ8k/wnjIVFi0kZHh8PaZrp7Ld+k+Z2N7UH7CtdSLJcq5zkrlWQO7dK2
 M72wWABsnReQ=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

These hooks are called on inode extended attribute retrieval/change.

Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 security/selinux/hooks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7a7dcab81db..9c6e264b090f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3366,6 +3366,18 @@ static int selinux_inode_removexattr(struct mnt_idmap *idmap,
 	return -EACCES;
 }
 
+static int selinux_inode_file_setattr(struct dentry *dentry,
+				      struct fileattr *fa)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+}
+
+static int selinux_inode_file_getattr(struct dentry *dentry,
+				      struct fileattr *fa)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
+}
+
 static int selinux_path_notify(const struct path *path, u64 mask,
 						unsigned int obj_type)
 {
@@ -7272,6 +7284,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
 	LSM_HOOK_INIT(inode_listxattr, selinux_inode_listxattr),
 	LSM_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
+	LSM_HOOK_INIT(inode_file_getattr, selinux_inode_file_getattr),
+	LSM_HOOK_INIT(inode_file_setattr, selinux_inode_file_setattr),
 	LSM_HOOK_INIT(inode_set_acl, selinux_inode_set_acl),
 	LSM_HOOK_INIT(inode_get_acl, selinux_inode_get_acl),
 	LSM_HOOK_INIT(inode_remove_acl, selinux_inode_remove_acl),

-- 
2.47.2


