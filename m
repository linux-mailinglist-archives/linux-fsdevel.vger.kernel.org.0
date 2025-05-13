Return-Path: <linux-fsdevel+bounces-48825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC63AB4F52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 11:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C5E1B43C58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E6021D3F8;
	Tue, 13 May 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQ/ER/nW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183B2144A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127908; cv=none; b=b3vbVLCG8vnEinh1HuRb+IgxHDAe/Wo8HORq6yfoxpSEfZK5/EOl9+CNEINJedagc5zAeNnsMutpMT875wjuPsNbHIPGjLP2QaEoNIjkMCkjs2Qdr8eQ4qW50UKa8AtcKDa+nsOP1puRPwEACfq+oUOfXFveoNvmNsPzNgrJS3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127908; c=relaxed/simple;
	bh=wSzH0WcqWhiy63ekDcp2P+4tMQ4i2gTZHqE6rCKQ++I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PVk84E4hpPssJ563xTxK13al2HEiO+ep01VxYVbiP8ZLeSbmXBwDPbIAGv01QJ1oYNeblIgndmQ5eiUkzUQ7dUqbtSEsAs5GXHAddf4/iWQ4hqswLWE8824dtBd9l/B3nHrPUbIVC7X6eiV2EanQ4Pc/9M6XMyk71M+RBSaiuqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQ/ER/nW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747127902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7i9r0bj6CyLmaFmxt3qgx2Tj6vgASlaO3PK3g/iy20=;
	b=EQ/ER/nW/71f2DhsSwW6Kw61pDqYE6R44wEIlynuuQPCNuKgwJzYo8DJmXlXn6C9GWUP3d
	+HbFQwnrJShjkOvWeXq0Wq199VH9Oa7DWTUn7XWwFtOBRFqdo87UxF2IIx7bABF7tUeoWy
	KamXo4TpKKZgMb4ENfDmE0anmcQszng=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-luN34s1jPESS-1t4r3_sAQ-1; Tue, 13 May 2025 05:18:21 -0400
X-MC-Unique: luN34s1jPESS-1t4r3_sAQ-1
X-Mimecast-MFC-AGG-ID: luN34s1jPESS-1t4r3_sAQ_1747127899
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so26203455e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 02:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127899; x=1747732699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7i9r0bj6CyLmaFmxt3qgx2Tj6vgASlaO3PK3g/iy20=;
        b=RAazF7qm9LQHDdBXaylUQOFAXnc6R1BcFyFDymcw9jHitxVItIHzrHCl3+FW1k5GWr
         +SOvK4z7Z9UYf3HwOW4tunLEkOju53mHXeKyVzXJb+LG1rFUUSK85rppDhxB6tadDu/L
         CsnV3rnYnL4oUA0BCcEA9H8RBIW0GHr/melICE0LBRpWQRzKoZ5GdOaEqiKGI7LE12S3
         9wFDXfzH/yzuIRbXXYls+Vdb3MoOj4PQfOFrGRJLpDXKbHs3VltLl0oH2jG8PsQEfnNW
         AT91pLlaNBc/yEz7/pMY+mPS2ZYZyRpVFSFBThR7BMxAPNjH/GxyUlYJgqUbhP2JDnJj
         yB2g==
X-Forwarded-Encrypted: i=1; AJvYcCUUVA4DyYlyGLXUvePSH6cKcVGumcyQcxxRdLlLrF/M/mmIZlV+Vi9B6zZAMeyKoxTVIpP8Tr+rAYKGyaNa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9mU+bSfiIClgJWd7smuLKlhZyy53eBQotylfT5yfYHyKUaC7i
	wsaw5ypr9IVYjANrTOY7g0uP/qslQx6EKjPB0xKmtPrISoPEMgPsuBoTgEKAnqCkrsGH4ta0sMZ
	cj2h1X6gp+wM2HqUG3gAAABkVOclJpG+1yBqM4b7NBsvsoBug8axTsmp/Rg3zyA==
X-Gm-Gg: ASbGncsy19AYtg36SJ7qFS9mpxCtVHqa5/6sLRXYYFIjmf1ISXCUVzYQXtWBgq84JHR
	DEUlJWs9ICC1yq2iUTGELo8F2fDiIN2FoMYliP8HipgCvLPIk06NA9tIwXLzoNwRIpbNo6iORIa
	hf1y0D/qYD5c8i+zhmgxbdzMC79BIotEAsvYDfNg7kBmrYR1n+jjSeYTFrUxjbWTa1+LdzpbBg4
	OmVFo95oHuzhhsR9a+HJ/9Jffy+IhUWPd03PXWNOyx6JhbTZCwcReMI9JqoipvrrevcF1cSWpCn
	txCdtJYBmVO/suIP2rF7IHGGhDdOhQJS3Kje3WuRZ82oNEM=
X-Received: by 2002:a05:600c:b85:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-442d6dde9a5mr123281975e9.33.1747127898714;
        Tue, 13 May 2025 02:18:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH48YApAweQLr9FqjcxLWZAARsvWVI15CFcissyg+mEXGTlUmY2j0SDRus7eO6YNuUdP6jeRg==
X-Received: by 2002:a05:600c:b85:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-442d6dde9a5mr123281625e9.33.1747127898279;
        Tue, 13 May 2025 02:18:18 -0700 (PDT)
Received: from [127.0.0.2] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ed666dc7sm12345655e9.18.2025.05.13.02.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 02:18:17 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Tue, 13 May 2025 11:17:56 +0200
Subject: [PATCH v5 3/7] selinux: implement inode_file_[g|s]etattr hooks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250513-xattrat-syscall-v5-3-22bb9c6c767f@kernel.org>
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
In-Reply-To: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1670; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=wSzH0WcqWhiy63ekDcp2P+4tMQ4i2gTZHqE6rCKQ++I=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpT5vOcHL6x//4Yt+9EFwZyLxr/7Tz9ZpP5u3tO4V
 q6ORSUh1y53lLIwiHExyIopsqyT1pqaVCSVf8SgRh5mDisTyBAGLk4BmEiwPiND+6YnluEhu/Qc
 Cx5cnc3R+vvvJvuQL0V6fGyyUclCHH6VjAwT/JZona0OZVzwJvX/wlkFTstmX7ezC/yqzlmc01k
 tfZMVAGD5RU0=
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
index e7a7dcab81db6a8735877eeb911975e06a9de688..9c6e264b090f9038d6848546760860bfe74b7341 100644
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


