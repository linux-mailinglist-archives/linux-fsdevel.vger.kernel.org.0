Return-Path: <linux-fsdevel+bounces-23379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB9B92B720
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59721B26265
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 11:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334F9158A29;
	Tue,  9 Jul 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIoi1ErR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0915A4AF
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523983; cv=none; b=dpua+R2Ol94i8MeIwxrb+l5ZFwbdr8zXVV+8fk2ZkMhLk2JO78xdlVbwKc4RFcR0EoqsPPsCdz5bpKEahRi6aRMOy+6LgpLaiHZjqVoUjF+RzyNDDVmwz7KwIfDZYXxz/53icPQjDDnM3dYll2J8KE1x5iJTYEGZhNXdJSTWUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523983; c=relaxed/simple;
	bh=Xjz3MTVYq/NAB3daYzBwLF+8t3T7ssr4yfGhYIRspPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIREjzUobiakQRljaK3c4cRkFXMfSkiN0o26GLaZ9/t13s525m985rDpHF52fWCMGU9HGm1XIA/l2BXwp7ofVQUmeN3ndPrixWZ8+W78j30vIkr4yqy+v65IAj8zOH7XQuuLlHBy7Sm2OikPRNknoiOSG79pjyMCvjzhpnpnujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIoi1ErR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720523981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YN0cRtZ4yjTFsrRdrBTPFQCjU2aNbe9nzOGwlrFJ09U=;
	b=RIoi1ErRETfh6dpZ6yUo1icvgk5JYEVBa1p1k4Vc2JgArS1RoVefFshq11UnyPDqA8nlcj
	SsAxcJRIRKquLEkiIc6hTfv3cFP/fxC7ketBBsp4+rjOh+rETJ8CSPG+yR1UzNN6/aedJE
	IIyE9roqFS14wtncNbiMgN7s6WDY4mE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-ROJDlJx0Pkip0maN2EIhAw-1; Tue, 09 Jul 2024 07:19:39 -0400
X-MC-Unique: ROJDlJx0Pkip0maN2EIhAw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367987cff30so3418441f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2024 04:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523978; x=1721128778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YN0cRtZ4yjTFsrRdrBTPFQCjU2aNbe9nzOGwlrFJ09U=;
        b=XtQmv2C7aoLS+q+Yot7WIspbFedmZVcl/t8vb1z2zcEN6a+MvpGUd7xblME19o9xtN
         Qq6lXI+vX27cuTSQOcoUH1OCdDomA8UzWV1WHBj12O2WLfrq/Bra57NRQElW7dcX5DDu
         c52vWBNogwN4V3NucZpbTHixIA4m3LKWx+uFBrIrUPrTq4Iq8xToGe6K1UPiKkfJU00X
         m0vDp+6zKi5UB+odmuRyVzcqCPXzggiNkxclHYPn/DM16WUM+qd+iDvAP1clj/kGdMQB
         fX4eDq3HokMP3SK7qHQx6G6tGttBGKK7DKL8R0IBw+v54y4TJG6BwjYJrYt/HUzJUUac
         SnHw==
X-Forwarded-Encrypted: i=1; AJvYcCXRn/AiHFB9ogQnv3DTYaBGOoaGthqzMrGD2alLPBfTXf+WwRFtAnU5GAnwq4TK2q3iWfSlwhmCqY5pLZJ9GAFbGRjgCL/fiJHzSEeL7w==
X-Gm-Message-State: AOJu0YxEVjWCVlh4KAocUeoQ9+NrEOQHfgdvKyq9DeGm02V7RvxP71qI
	x6zp4T97Aw9CXaJqbRrtv54KXQjRHt9svpXiRISDfd4nSiUf334V2J58oZSm296n7el5ohiFJZi
	89N/3OZupJZQSydGhEiNhdjYtzUVawyzhICec0N9X+GUTqLVhEkbFZm9bQBtAs0k=
X-Received: by 2002:adf:f20b:0:b0:366:ecd1:2f38 with SMTP id ffacd0b85a97d-367cea45cb1mr1566737f8f.7.1720523978451;
        Tue, 09 Jul 2024 04:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoGPU/A2758fnfW+6Bj1ZJdPWuqnkDg1NjoVhU3Nny/eh6gvsNgugn821lvXZApx4Cx1TO8g==
X-Received: by 2002:adf:f20b:0:b0:366:ecd1:2f38 with SMTP id ffacd0b85a97d-367cea45cb1mr1566715f8f.7.1720523977994;
        Tue, 09 Jul 2024 04:19:37 -0700 (PDT)
Received: from localhost (p200300cfd74b1c2b6d9a10b1cecd2745.dip0.t-ipconnect.de. [2003:cf:d74b:1c2b:6d9a:10b1:cecd:2745])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e08asm2270192f8f.11.2024.07.09.04.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:19:31 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Hanna Czenczek <hreitz@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 2/2] virtio-fs: Document 'file' mount option
Date: Tue,  9 Jul 2024 13:19:18 +0200
Message-ID: <20240709111918.31233-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709111918.31233-1-hreitz@redhat.com>
References: <20240709111918.31233-1-hreitz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the new mount option to the virtio-fs documentation.

While at it, remove the note that virtio-fs would support FUSE mount
options, because it does not.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 Documentation/filesystems/virtiofs.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/virtiofs.rst b/Documentation/filesystems/virtiofs.rst
index fd4d2484e949..201ac9ee13c5 100644
--- a/Documentation/filesystems/virtiofs.rst
+++ b/Documentation/filesystems/virtiofs.rst
@@ -43,7 +43,10 @@ Mount options
 -------------
 
 virtiofs supports general VFS mount options, for example, remount,
-ro, rw, context, etc. It also supports FUSE mount options.
+ro, rw, context, etc.
+
+The ``file`` mount option allows mounting a filesystem whose root node is not a
+directory but a regular file.
 
 atime behavior
 ^^^^^^^^^^^^^^
-- 
2.45.1


