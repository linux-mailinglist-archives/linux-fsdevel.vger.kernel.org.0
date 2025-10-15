Return-Path: <linux-fsdevel+bounces-64197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA37BDC668
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 06:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCA4406757
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 04:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A842F1FD1;
	Wed, 15 Oct 2025 04:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHNYE0kL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0B2FF176
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501018; cv=none; b=HgTfUIDkZ4XDEywv/4FmGUd6f+dkfC3jpF0n5+hN2EUBQFrkozWUQpyTjbhU3qbnoUPTfwk0Nb09q5i4OnwWMgzqm6NSNrFfALOi7PVMxdipStwV5nbnG9xJ1PCjBn+0oAEPXxtzNyxlE+wFvOPufL1aooeWl4QIlCEcJ+ADkEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501018; c=relaxed/simple;
	bh=MUM+uW6qnDu0apC4KR7QWlmonTleTGezmIe8a4nc1Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlvlPK7CPX54gJ/TCGdkdk4t0qX/ZaVF37dbfTeV/LUlO621tiGt+08OJUn16YYZ8zee4pjfz+TG3jEYTx8+iQ8xt5SrFOGr5bCf0jmin+CamxXGNgcs9jclgGTvIGrRdaK8DwvLk4xmBtMYp8I5CQAXjgq8jAY6lYt1uo7kAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHNYE0kL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760501015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5ohKs6qKbp9M57nvQdcRMhKqmCNN3hHdO4AybKNaC4=;
	b=NHNYE0kLseEuBSWKqB0W5+v5Bx+0CBp3ntb7/IgRkq9YjvSWBbVDA8iNMcp5Zxnr/3J6M1
	3qAh3sJ5P/KyKvxjKd1ebuEx/nslEid07zJIs/oP4Ed0OhegqJcIlBuhoJM1vcDb2SzlPK
	abvZlPbrBHapQtVxS784fFTL1caH2Ak=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-IKAbGKi2NNi6ZQE2V-hPuQ-1; Wed, 15 Oct 2025 00:03:31 -0400
X-MC-Unique: IKAbGKi2NNi6ZQE2V-hPuQ-1
X-Mimecast-MFC-AGG-ID: IKAbGKi2NNi6ZQE2V-hPuQ_1760501011
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-339b704e2e3so11522010a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 21:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760501010; x=1761105810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5ohKs6qKbp9M57nvQdcRMhKqmCNN3hHdO4AybKNaC4=;
        b=Lp9WIHRi0B971c/s2MBguEdXXT6Ea1TsQG3eqsNiZD/+Hj0ayRbTCu8ZWX+q2iLOMs
         wkz1QhGNoHsh+yJwC6s9E/lhf3DHm68HGuYVuOesuXHHOYyBNmxeDKWCT6jFm5pDW1yt
         pJqC4wcAopPdH/V8wWyjkl68DfymYrWjtIHeahv3LtYdGBuUa+hFEhRK2o/E95vcGt+a
         grtcwAu+fM7EIRfonsAeIeyTB3O1Tc96fTczv63UQIAdAq/esLlSpO1KOTv1DytiJPNx
         8OSKyHY5aaZVFEZzKqGj54mdkdR732LAJLvWM63F9+7mTcGiX1ktt/tPIhnZyuQej8c+
         APmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrLhIeoKtYcDp5GSCX5ylz199ZVPD07T7IxMO2pG3QNggnuUhpXI91bG3bICMLgITM/o81sCPWIWyOARaf@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCSWzWuWYuuHhffXzEHyG3e+t6It9vxhLsnQ+s+KSyaQBKhy+
	QXkPcOuvqpKazelnltqXZuRsdLJzxFFbIhB88C9LArNLdRZV88dg1Z8iWAFJmnStcOIJELkYMSc
	OPlvtRxu9jllqe/8/EEboVvItjnRXlz1K9f8NR3uo1VsnTbFPxjO5V7ltI5sawJNdTss=
X-Gm-Gg: ASbGncvoGf9K9PbzdQSX/d8tGj7p+z8cnUOZLKkbVINduSfVl9QnEDjs+0OQn8PkHmO
	3skmKb4pZD+oTFeL9OxCbM+NoGzDi3zNS3tn5EVjy/PMjfKr5Wfj3X+y0HMWdwPaCLW21T+K7GS
	BtXUO2RaCOGPxhgGj3mBVfYenteQVZPwagtuVYgetEgB6KAZpZmDpdNVGPymCwaYBKQIT+TCKVK
	GyrM1wE9rosDk5GJlq8U02+vr96tRbJJ/h6TWKwMPcknICZU2g2higE8KUhRBhjKuee770NxA6g
	HBsL/i1xmQx08PU5xFpPbXVSRYxfUTrlR9U=
X-Received: by 2002:a17:90b:4a45:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-33b5111731amr37028096a91.3.1760501009928;
        Tue, 14 Oct 2025 21:03:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuLhwfwk717yOcd8hPJjqG2qML+HfCGwgfNoBL1CNQBuD1WSe9rogLQkLlfQFnzLiekkeHRA==
X-Received: by 2002:a17:90b:4a45:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-33b5111731amr37028057a91.3.1760501009473;
        Tue, 14 Oct 2025 21:03:29 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b978607cfsm608006a91.9.2025.10.14.21.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:03:28 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH rust-next v2 3/3] rust: samples: miscdevice: add lseek samples
Date: Wed, 15 Oct 2025 13:02:43 +0900
Message-ID: <20251015040246.151141-4-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015040246.151141-1-ryasuoka@redhat.com>
References: <20251015040246.151141-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add lseek samples in Rust MiscDevice samples

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 samples/rust/rust_misc_device.rs | 68 ++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index d69bc33dbd99..7f227deef69d 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -12,6 +12,7 @@
 //! #include <errno.h>
 //! #include <fcntl.h>
 //! #include <unistd.h>
+//! #include <string.h>
 //! #include <sys/ioctl.h>
 //!
 //! #define RUST_MISC_DEV_FAIL _IO('|', 0)
@@ -19,9 +20,11 @@
 //! #define RUST_MISC_DEV_GET_VALUE _IOR('|', 0x81, int)
 //! #define RUST_MISC_DEV_SET_VALUE _IOW('|', 0x82, int)
 //!
+//! #define BUF_SIZE 16
 //! int main() {
 //!   int value, new_value;
 //!   int fd, ret;
+//!   char *buf[BUF_SIZE];
 //!
 //!   // Open the device file
 //!   printf("Opening /dev/rust-misc-device for reading and writing\n");
@@ -86,6 +89,40 @@
 //!     return -1;
 //!   }
 //!
+//!   // Write values to the buffer
+//!   char *w_buf = "ABCDEFG";
+//!   ret = write(fd, w_buf, strlen(w_buf));
+//!   if (ret < 0) {
+//!     perror("write");
+//!     close(fd);
+//!     return errno;
+//!   }
+//!   printf("Write values to the buffer: %.*s\n", ret, w_buf);
+//!
+//!   // Read values from the buffer
+//!   lseek(fd, 0, SEEK_SET);
+//!   ret = read(fd, buf, BUF_SIZE - 1);
+//!   if (ret < 0) {
+//!   	perror("read");
+//! 	close(fd);
+//! 	return errno;
+//!   }
+//!   buf[ret] = '\0';
+//!   printf("Read values from the buffer: %s\n", buf);
+//!
+//!   // Read value from the middle of the buffer
+//!   memset(buf, 0, sizeof(buf));
+//!   lseek(fd, 1, SEEK_SET);
+//!   lseek(fd, 2, SEEK_CUR);
+//!   ret = read(fd, buf, BUF_SIZE - 1);
+//!   if (ret < 0) {
+//!   	perror("read");
+//! 	close(fd);
+//! 	return errno;
+//!   }
+//!   buf[ret] = '\0';
+//!   printf("Read values from the middle of the buffer: %s\n", buf);
+//!
 //!   // Close the device file
 //!   printf("Closing /dev/rust-misc-device\n");
 //!   close(fd);
@@ -114,6 +151,9 @@
 const RUST_MISC_DEV_GET_VALUE: u32 = _IOR::<i32>('|' as u32, 0x81);
 const RUST_MISC_DEV_SET_VALUE: u32 = _IOW::<i32>('|' as u32, 0x82);
 
+const SEEK_SET: i32 = 0;
+const SEEK_CUR: i32 = 1;
+
 module! {
     type: RustMiscDeviceModule,
     name: "rust_misc_device",
@@ -204,6 +244,34 @@ fn write_iter(mut kiocb: Kiocb<'_, Self::Ptr>, iov: &mut IovIterSource<'_>) -> R
         Ok(len)
     }
 
+    fn llseek(
+        me: Pin<&RustMiscDevice>,
+        file: &mut File,
+        offset: i64,
+        whence: i32,
+    ) -> Result<isize> {
+        dev_info!(me.dev, "LLSEEK Rust Misc Device Sample\n");
+        let pos: i64 = file.pos();
+
+        let new_pos = match whence {
+            SEEK_SET => offset,
+            SEEK_CUR => pos + offset,
+            _ => {
+                dev_err!(me.dev, "LLSEEK does not recognised: {}.\n", whence);
+                return Err(EINVAL);
+            }
+        };
+
+        if new_pos < 0 {
+            dev_err!(me.dev, "The file offset becomes negative: {}.\n", new_pos);
+            return Err(EINVAL);
+        }
+
+        *file.pos_mut() = new_pos;
+
+        Ok(new_pos as isize)
+    }
+
     fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usize) -> Result<isize> {
         dev_info!(me.dev, "IOCTLing Rust Misc Device Sample\n");
 
-- 
2.51.0


