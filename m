Return-Path: <linux-fsdevel+bounces-33028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F7E9B1FAC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 19:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A61F0B21845
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 18:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB995186284;
	Sun, 27 Oct 2024 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2TJoZjF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC6185923;
	Sun, 27 Oct 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730053079; cv=none; b=SQAa5d4pE1wdH5nQ5ZuyPhnazObVq+UTM/B5xoQmBROvndF22XQA/Ec+i/ATs/IKmsHSJdNnPv1sRRpJG1cNnSKICShT/9Ex4jv4oulItlRMVIGtWBQuPsI5LKgBRhC+UULqjQygjtmJMlQLm+MAtqUdGyQnny7ng8MxJ4MEvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730053079; c=relaxed/simple;
	bh=+Kq9Z5tndx7d8My1EDcLmC5OkXd+eYGSXICBqfZJQm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0uZxkaGQXXMX3ru4vnq9Dy+5Aw0JdDUQru2iZipqc7s549mIxg463Q8xEnau0H1+/6+jhWvjF751YYra4DptBEI0efPNvIQw9Qwn7PSeP3YYVEY68R2r01mlYBUcR9CEslHvKrpjD81jc5KttE0KQgsciUxOwZkWv9QUgjHXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2TJoZjF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cf3e36a76so34742365ad.0;
        Sun, 27 Oct 2024 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730053076; x=1730657876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+h3NnvEkUh4JyGQi7rGno9Md2mADF6L0JRgif7uwPg=;
        b=b2TJoZjF+IoKU86tTS0dZnpEn8yjVB0PliAiw094netDiLzNx9pimt1rG7IpVfm/WV
         tzdGkrBZCfs3SrfcGoXO0K8RsfjQEGl24wR1bH8UDSIubnMnqeYK2N51droPW5tM+ykx
         rnK23RTibDRbc9J3ojZXFz7C+UgbcmNt/Xb44i4WgW2unna703olggI/rx3qaRRC3C3g
         3xRNmVe57DYYT++fM+4m0ggOHTp76ZjDjn1GTfWHRXSxFmgfoGAYsfxZtewUHhthBJHf
         bHi7ar4tt4urvRyfA2n2pzu+Lz0wK+AxI1Q6OquGPFl37QpnCKOOoKnz68ipkGlTQTrY
         moXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730053076; x=1730657876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+h3NnvEkUh4JyGQi7rGno9Md2mADF6L0JRgif7uwPg=;
        b=i/M4Ww0sYoadtZjLPXb9YFbOw0u3gkJuyjcG4Iu5AuK2nx/SdRetpBwr85gCIZKAox
         t1RBI3K9dPKR6tiC4Ls2NaJbLkUynqjDmqp334K3SV5Q6T+e7NvBjDqqsyyd7xqaVjmR
         MqNOJbXp9QBgcDxNSwUt6VromYD0ENbIYfZixygR1EZVM3o+Oy1AgFFXO52SFCIa9iT/
         J54FWxed1bzkdhiqhUGp7Pl1XXqQEj2/+OK9onhh+bTA1q2KapQfoITme1/hX5QBJ25j
         bzsiYUv8yEaLk/+N73QwAA69pBOElIn8OVirQ02M3Or+lbpmiPCzLUjssn2rklH2BtKm
         3rog==
X-Forwarded-Encrypted: i=1; AJvYcCU9Q73KgFh6DCmrdv/iR7YMai/3F+wfeHRtUBHo83OBrMH4gK8uxjpWKgkduC6k98qixXTLlvcw565TKtbD@vger.kernel.org, AJvYcCUrpvZlCatyQz3hxqz7aKMVGHFwzESWa+YlFj+Veqrft6PbR0BQXrT3raJpQd+my3EONeohqYKmsqZ67+Np@vger.kernel.org, AJvYcCXUfCuhCbGXFSTbqfpEwtrVU6vu9t56yk/yiBYHKsvyuH2HKQNrVK0nLFi+Xl1qfw1xBuH0IP4Pw8fc@vger.kernel.org
X-Gm-Message-State: AOJu0YzxyW99MCgs4jdvT3vkh2fDekhoZwY15bC6zytS5kb/n5r+pxLc
	mlfG0N/msjLkM8wpa65rb1PdFbQzM85VPQJYsjQpPrPRIWMZS9qt755D9w==
X-Google-Smtp-Source: AGHT+IE6qvy6/jDGpnieNnqa5gpNIZJ/VGzknEc5hpU86jWBQ91TiI3g8sAzXPXYI8QZZG0akBE44Q==
X-Received: by 2002:a05:6a21:6282:b0:1cc:9f25:54d4 with SMTP id adf61e73a8af0-1d9a84d9ddfmr8080021637.38.1730053076059;
        Sun, 27 Oct 2024 11:17:56 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.83.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc867d0c1sm4306492a12.33.2024.10.27.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 11:17:55 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 3/4] ext4: Support setting FMODE_CAN_ATOMIC_WRITE
Date: Sun, 27 Oct 2024 23:47:27 +0530
Message-ID: <ff8a6b81109e4a81ef304eb5b523ed777d62e2a2.1729944406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729944406.git.ritesh.list@gmail.com>
References: <cover.1729944406.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FS needs to add the fmode capability in order to support atomic writes
during file open (refer kiocb_set_rw_flags()). Set this capability on
a regular file if ext4 can do atomic write.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index a7b9b9751a3f..8116bd78910b 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -898,6 +898,9 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 			return ret;
 	}
 
+	if (S_ISREG(inode->i_mode) && ext4_can_atomic_write(inode->i_sb))
+		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+
 	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
 	return dquot_file_open(inode, filp);
 }
-- 
2.46.0


