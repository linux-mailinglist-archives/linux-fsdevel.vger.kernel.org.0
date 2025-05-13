Return-Path: <linux-fsdevel+bounces-48828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9513AAB4F7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 11:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083DC1B44009
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637A6221DB6;
	Tue, 13 May 2025 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBNmZTYP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3421FF2A
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127916; cv=none; b=mEjYoycoeQmUDYrOFpZ6oF91biQQzsTg/IdABZ+TK9tCVNOejG1qaAbai3JRSmaydgk1BqIGS2cLJE88+5RWTwnCf9WHdz0i6ejO9x26NL0PKhXWoJH9hih0eLGqXx5x0Qf4ftoiCAU0np0TN3U4kCDSHPJrGZRsRPAhGXq46Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127916; c=relaxed/simple;
	bh=YJHrfLnlg7eZFp+zMmd8Wb9VJWvyb8UUtIhLAWunkgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkhLV6BR0uT5zX2qtWDw9dSSYWj+UC+bmgrn6St92O+WTKtbTx9dSwCUxiBCYStNzhfo56aCjgNtrXUVpl0Zt9wE6KKOP17Q5l3YHsW1hlBTW6pqQAF3/m9DTuFq8BGa/HhwjS9aVJzAZ9+TqSLFA5TySM+3146CCqfACK4JoT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBNmZTYP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747127910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTNboLswrf9jYl7R2fhkHc5Mf/EfkCXeYw0mqBAK6/s=;
	b=IBNmZTYPvhGTURipNTiBuSgT5xvo+/OCz0c5wIztc6G6KJU21BGbbntEkd9TwssAXhGABA
	CQ1MY8TPrmym+5tVplbHgUpjR23PvJ3EZPcKBFjzlElgZlQr+FnbdXpMiUZBZhG+GudqSp
	7/7HQZdnEzb+bD9GRxIpaAEG+euK5mg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-LcYRQVKZMtusC3vo2wPbIQ-1; Tue, 13 May 2025 05:18:29 -0400
X-MC-Unique: LcYRQVKZMtusC3vo2wPbIQ-1
X-Mimecast-MFC-AGG-ID: LcYRQVKZMtusC3vo2wPbIQ_1747127908
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so26226665e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 02:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127908; x=1747732708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTNboLswrf9jYl7R2fhkHc5Mf/EfkCXeYw0mqBAK6/s=;
        b=YE1N33Y1RcE92nnea+1ZauAiSgBMkc23TvkxX/yrPK7YWGKEZk8K2tZ7NUmKgwUpj/
         6uw8jq46AfrobDXE5FID44SoN49eJiR82AvQfkL63UH8Xr3J+SFDl0lzngycbniGngHq
         Wi8CysVC54UZVci/GDjCE9HQK6l6icXN67zGLljqFkaG2cUTLj+fowXnY3g9qApKlZqK
         FE/w1yCOZ3mu1jjLYjNs5lAwHXuuZdujqudT85E3m0XOIpgT9SIeOVOXyIlAi3QhB1j3
         QTQ0IuAObQuIMTCVV73nCqUm/tr2j/7vzuGVu7WG3Cr6pq9Kz6SqtA2qZ2XnjSP4mNoa
         +7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGhyc2w99A3Bd3WrlTqD+cGYqkMp2hUhoy/N/cNgvgsntiKTUmVaONQUVflcZB0nvuYvClC6xC6IWvmSvn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0tsweSygERDEWbyZiIdxv9ZbWDmroGAzBzW0YH3epD50spput
	plPb8kaMtyWrN31XJZXB+cty0+wOYiFflPEz2o7NYqOoIoOVI9RwfaAKZkPgdzcUnG/I7hpy77k
	WxFvNCSl40IvgvZIo3OiWKlCJZ4ibfAMZ4In1EwnqOc28DSplej/hBJmbtEnSrA==
X-Gm-Gg: ASbGnctkUvsGfoEfTZZ2Y7u8IcIDRRAdOTQb8If/YeQH2KjozFzubMzVgyF+P3oGQ59
	YNM2QrK3lc6tCB7FAbKQVK7ydBXU4sVe/+DGU2m+qSjmO1x6XlBM8HcQjKERm/NI95CW7uAYBuU
	cA8xZCohYVw7inEv0npTDxrVThRWOphT5ZllShC7UPflm5/FICwOwTVELzdK3OGEYKqpuZRzbzU
	MVsi9LFbS9XZCw8iggx0oE26f7WFlNcWfWi2Kg9XFDEge25cLhUbRYyg6OSxBkcxw1CWCQHzJjB
	5uI3qkd5qB0jDg1++B9HuEIqjrYUoEKpDSPw1B9/oexeCwY=
X-Received: by 2002:a05:600c:a44:b0:43c:ec4c:25b1 with SMTP id 5b1f17b1804b1-442d6dc5328mr122857445e9.23.1747127907914;
        Tue, 13 May 2025 02:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSD3cBiAoSeE7mQdYxANptZgCWG/QkVumgW8cBneSabqw55k5N+mANgM6mplP1ZmV2IXy+GQ==
X-Received: by 2002:a05:600c:a44:b0:43c:ec4c:25b1 with SMTP id 5b1f17b1804b1-442d6dc5328mr122856725e9.23.1747127907396;
        Tue, 13 May 2025 02:18:27 -0700 (PDT)
Received: from [127.0.0.2] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ed666dc7sm12345655e9.18.2025.05.13.02.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 02:18:26 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Tue, 13 May 2025 11:17:59 +0200
Subject: [PATCH v5 6/7] fs: prepare for extending file_get/setattr()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250513-xattrat-syscall-v5-6-22bb9c6c767f@kernel.org>
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
 Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4058; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=9XBaUh9nVlDr1zwSfKo8V8Sk8eQqpQogexfwmlm0gVw=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpT5vPOZks/wtDRVZEmxBIYe5ev8+dRYqU9jmV3pq
 7kMIixTrTpKWRjEuBhkxRRZ1klrTU0qkso/YlAjDzOHlQlkCAMXpwBMpFiC4X9p7J15fxbat9he
 mdT3SbJAs8nY5O8mm3bJBqPW/P+fSrMZGRa/jE7lPNT/+IYD18HcdxonZRZ9fZhVKzp94enez8E
 cOSwA2gRECg==
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Amir Goldstein <amir73il@gmail.com>

We intend to add support for more xflags to selective filesystems and
We cannot rely on copy_struct_from_user() to detect this extension.

In preparation of extending the API, do not allow setting xflags unknown
by this kernel version.

Also do not pass the read-only flags and read-only field fsx_nextents to
filesystem.

These changes should not affect existing chattr programs that use the
ioctl to get fsxattr before setting the new values.

Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kernel.org/
Cc: Pali Rohár <pali@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_attr.c           | 19 +++++++++++++------
 include/linux/fileattr.h | 22 +++++++++++++++++++++-
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index d696f440fa4ffcba8985cc4bfe22a1c0e612ac7c..6cd1e820f7b108c12c06654df843104f460b94cf 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -91,8 +91,10 @@ EXPORT_SYMBOL(vfs_fileattr_get);
 
 void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx)
 {
+	__u32 mask = FS_XFLAGS_MASK;
+
 	memset(fsx, 0, sizeof(struct fsxattr));
-	fsx->fsx_xflags = fa->fsx_xflags;
+	fsx->fsx_xflags = fa->fsx_xflags & mask;
 	fsx->fsx_extsize = fa->fsx_extsize;
 	fsx->fsx_nextents = fa->fsx_nextents;
 	fsx->fsx_projid = fa->fsx_projid;
@@ -119,13 +121,20 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 }
 EXPORT_SYMBOL(copy_fsxattr_to_user);
 
-void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa)
+int fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa)
 {
+	__u32 mask = FS_XFLAGS_MASK;
+
+	if (fsx->fsx_xflags & ~mask)
+		return -EINVAL;
+
 	fileattr_fill_xflags(fa, fsx->fsx_xflags);
+	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
 	fa->fsx_extsize = fsx->fsx_extsize;
-	fa->fsx_nextents = fsx->fsx_nextents;
 	fa->fsx_projid = fsx->fsx_projid;
 	fa->fsx_cowextsize = fsx->fsx_cowextsize;
+
+	return 0;
 }
 
 static int copy_fsxattr_from_user(struct fileattr *fa,
@@ -136,9 +145,7 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
 	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
 		return -EFAULT;
 
-	fsxattr_to_fileattr(&xfa, fa);
-
-	return 0;
+	return fsxattr_to_fileattr(&xfa, fa);
 }
 
 /*
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 433efa0f47844ef063373eb390672812682b6388..f62a5143eb2dccd5ceedfe72439cc4cab823cb1d 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -14,6 +14,26 @@
 	 FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
 	 FS_XFLAG_PROJINHERIT)
 
+/* Read-only inode flags */
+#define FS_XFLAG_RDONLY_MASK \
+	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
+
+/* Flags to indicate valid value of fsx_ fields */
+#define FS_XFLAG_VALUES_MASK \
+	(FS_XFLAG_EXTSIZE | FS_XFLAG_COWEXTSIZE)
+
+/* Flags for directories */
+#define FS_XFLAG_DIRONLY_MASK \
+	(FS_XFLAG_RTINHERIT | FS_XFLAG_NOSYMLINKS | FS_XFLAG_EXTSZINHERIT)
+
+/* Misc settable flags */
+#define FS_XFLAG_MISC_MASK \
+	(FS_XFLAG_REALTIME | FS_XFLAG_NODEFRAG | FS_XFLAG_FILESTREAM)
+
+#define FS_XFLAGS_MASK \
+	(FS_XFLAG_COMMON | FS_XFLAG_RDONLY_MASK | FS_XFLAG_VALUES_MASK | \
+	 FS_XFLAG_DIRONLY_MASK | FS_XFLAG_MISC_MASK)
+
 /*
  * Merged interface for miscellaneous file attributes.  'flags' originates from
  * ext* and 'fsx_flags' from xfs.  There's some overlap between the two, which
@@ -35,7 +55,7 @@ struct fileattr {
 
 void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx);
 int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
-void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa);
+int fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa);
 
 void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
 void fileattr_fill_flags(struct fileattr *fa, u32 flags);

-- 
2.47.2


