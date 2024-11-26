Return-Path: <linux-fsdevel+bounces-35913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B919D9A00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D32EFB24354
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E881D61A4;
	Tue, 26 Nov 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQyPDqZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C4E1D5CE3;
	Tue, 26 Nov 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632830; cv=none; b=L2hSk60K6zKzrUsl+G4n8fnZpPucirCQMXL4nQchpapScKJK/CjikUaxEjrquinotzrQnCbfBguBy4Mk0P906F8a7DOaAnkBi6yfcGftnGM/ie7VxZzUcBriVUnfa6qhG2AnMqlSfmDT+VoAYipAGM6u47SjiO7H5m/mxitcTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632830; c=relaxed/simple;
	bh=KSEVBZ/G7JYMF9cZqi5u8cLDXg26TGry99x5UGOUcQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dWWVcjvjE3wlomsy8X3QC1v6MBOfPmVXzu3QgQ5fVXMealJxTixaOFFw13tuOtxhqP6cafLMZ4Y5W+mPEGc2YMcIPiozbaulta2fGN5g+iZhA7+fxUBRbjNmzYzk1sFVXNZYeyP44ar7JuP27zV4U9nQnKAG0ZWmrDy8S+50XQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQyPDqZJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43169902057so50044275e9.0;
        Tue, 26 Nov 2024 06:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732632827; x=1733237627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Coi5uCvYLyf9BjKpQmReIjNPyxHK+7AsbkxIjGq+vUM=;
        b=iQyPDqZJ1urniUTVZ8GjSXH3/pc6vCamt44hc4adDWQqZTSbZIsaTRvHDVcLC4X27k
         vBeOpTFuANvVKIFvpo/5793iqoH8PweHjdmImCCh85Dv5VxEMDHFZiM0SDDqkBp6V2Lo
         kTE4DCFjhP6U5T0HuhndWUil0WXE4VqvDt0fa1ROtvTuqyJeZCDgy4b47F8OU11nVdxq
         2WXLKGvhJx4jqYdppXjWMZjIRbJ7BrUm2N309U046jPVwhQS+O8PLwoC7J/VMr5lm29a
         TaNsMpLCFt8upjgS4MmaOwj0rNARwAm9FR0P6AOVu5/yuLRvSqjF0rI9d/HBiShTyFkF
         pjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732632827; x=1733237627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Coi5uCvYLyf9BjKpQmReIjNPyxHK+7AsbkxIjGq+vUM=;
        b=vLpxTcWou+ovByghXiorc6VOhdbbialq9dGfdDqtTDTmKkUNB1sa/YTlVCNjU1Wn5b
         9V3jUKb0J7sIQa053ZzulQ6kVKAWdxCBbm8k8cRdCPHLwdUolsTf2O6uY5YhlpfPayeq
         D48mxUwfCWs2ae5snuXGTred5jKypZul8619fyYS6mrDI7eL7ihdNMtrA5zs/fqIVfA9
         12V7A2SSqE0Tp5Nb9smWF9znn1Fsd2/xlN0ENQqj3CE+wW36UzbkCu1miChWlWHwRLIG
         QGpuRrYqZVZRuOSDMrNOVnzJlcOY71Zkld03t5jPyvQme/SzUnfn2e6/3fLJkQoaZ1WH
         jhaA==
X-Forwarded-Encrypted: i=1; AJvYcCXAXTQOi2788p4lPx78fRqXXWQIXOw60PfUEKVelrkk7DqkToDxvlyxBx65eEEe6D2kHm7ovBRha3ZdKSEV@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyEfH7b1QFKvIYOst9idTatdrqIGkOldxccVYtJWkOJ4/KsrQ
	SMx7C9sg0t1iGpvACtwDurl1nR22ueCK142xNIvkQKiTDmrZ8VrU
X-Gm-Gg: ASbGnctbEnAoz1I0nty9kG5JUuqgPpImkOSSBmeoAKtG9lCEC3r2Ntlybz1sGcn8xZn
	8eeo1/ALKWncRDqGum+MY2h8Cnkcf4R8Ct6UbuCyar+9m1eND1FPvmQ19etfHK2P4PYKKDDJ8oD
	IZQ5Pqz38i9C2hiTXc1GbMMfzhtK+zg+jbAifrCLyFy9UOQEpwJUF42wy4+gW+shunq9mvUuAXR
	p2yNCgvQpDFkmgrH3JPazJreyizFXPBvElvB3qiDdY3NmGTwSD0NIgXhDlxgKvIjq5AdsFCExoa
	nCvjueOcB3oJ/BTh9boXa6kKbHz8WfDFjWN/TMitherQYyo=
X-Google-Smtp-Source: AGHT+IG4vVII1X339eVM9tDO9PrABmKn+C7lHU3NxImmxVqBCrKEHOuyeqJvyHrkyNbbXXZOEObfiA==
X-Received: by 2002:a05:600c:3b97:b0:431:60ec:7a91 with SMTP id 5b1f17b1804b1-433ce418036mr157138015e9.2.1732632826508;
        Tue, 26 Nov 2024 06:53:46 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b464320csm229143345e9.38.2024.11.26.06.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 06:53:46 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	syzbot+8d1206605b05ca9a0e6a@syzkaller.appspotmail.com
Subject: [PATCH] fs/backing_file: fix wrong argument in callback
Date: Tue, 26 Nov 2024 15:53:42 +0100
Message-Id: <20241126145342.364869-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 48b50624aec4 ("backing-file: clean up the API") unintentionally
changed the argument in the ->accessed() callback from the user file to
the backing file.

Fixes: 48b50624aec4 ("backing-file: clean up the API")
Reported-by: syzbot+8d1206605b05ca9a0e6a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-unionfs/67447b3c.050a0220.1cc393.0085.GAE@google.com/
Tested-by: syzbot+8d1206605b05ca9a0e6a@syzkaller.appspotmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/backing-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 526ddb4d6f76..cbdad8b68474 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -327,6 +327,7 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 		      struct backing_file_ctx *ctx)
 {
 	const struct cred *old_cred;
+	struct file *user_file = vma->vm_file;
 	int ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
@@ -342,7 +343,7 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 	revert_creds_light(old_cred);
 
 	if (ctx->accessed)
-		ctx->accessed(vma->vm_file);
+		ctx->accessed(user_file);
 
 	return ret;
 }
-- 
2.34.1


