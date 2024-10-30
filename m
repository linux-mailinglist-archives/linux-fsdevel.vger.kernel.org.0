Return-Path: <linux-fsdevel+bounces-33256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A4D9B68A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 16:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35F4287EAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1115215027;
	Wed, 30 Oct 2024 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S32mXr4n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2122144A9;
	Wed, 30 Oct 2024 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303900; cv=none; b=MoPxe9u0hp3XW8Qpt4CLgwRcTmJpVMLQEb0YH+OwAfmID/syy6UB6jjP5fMfhLpsGjcjyHGlmrhN/HwBxL3DuP5p1/DbHLgI7adGy9u+uPjfCr8Z89ioH1Augj51sEPkcXpWhOEXzY2A1c0z6abGUcSP/gFScG3EJL9JV2QR1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303900; c=relaxed/simple;
	bh=C5cMhwPytVR2EzbChVNdP2H1ztmLjkB0HGNKbS+SibA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFsd9DK1DN7ekFBPDcdapnQEVmKKiKLIdAUAcVAEO5aYqHkMWMKnW9frP07+vIItf0Ti3mcAfkRY9dWriqPKG1+4Eyzg56tG0iOvtWY2a8BXSxg2zb0XKMt2uEfEYiz/aWn8LH+a/FsHkCEBt3ffNf6xEmNl8fPk0duXlikfoAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S32mXr4n; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso36031a12.1;
        Wed, 30 Oct 2024 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730303897; x=1730908697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAbLcLIUb8LSCLMQH+IQ3Pz3Cez3fTJykr77/x0LTCE=;
        b=S32mXr4nEGTQqlD2STasA0DeWNRE8X6RQmHLFWxe29JQZXN17JvkJeQ0yLcFXGG6c5
         P2M1lR+6vNYcDx0M76p5xOqeWIJNoi2daUJKuvZqnSWq5k8aJtVYVLnTkHgZUC8vWgkj
         noaSacvy+H29ChLC1IINjvYTwjnw4EcPZf0txNvlHkLHI5k5q7Xej7fxPi1MSQ2DxHSy
         DlPJpj4EoVjb6CRX/OfXgHflqhQPWlTsuusSYvYwhgdkdTmdlfF6W1Yd6sHm75oixa0D
         fbH+TrsxGMENyr42seHtLRRrG4pU2oZ2gjc+6y27jIA1DkjrEeRYwHAAjMNWIgYO0syJ
         4z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730303897; x=1730908697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAbLcLIUb8LSCLMQH+IQ3Pz3Cez3fTJykr77/x0LTCE=;
        b=l1GwQnI0ykelUSGrdnuIfB+N5TfTdYE0ibIv+hF5BP6RZfVFLaoOlm1EzHgHf6XVbS
         m+Je/hgRhS/jtqbx/JnNr62uAikDpSEV42e8UQP+zrpj76hmlZl6x/XRdGk5sicgwS9P
         FN2OXC8e5BJ+nX0u2Z4F6yulDuo/pTmA33y9DA6J9QifdBbOjTKwMakNoj7weMfVsxcS
         cx0/+iQxkRjHTmvQkLXPCKdC5YPgVrbFO95FMdB5Cq/pOwDAVDYr1escdWYOgiR6R7hl
         INf1oS8ujO6FeGNzx+ccCO/QnJnmz7nKCgOh05iIM1HUd/V1QvOtwwxy3PUMIN7JyPqu
         VZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxEoEcnPoWlZlI6YdR9zeOnnAlXRomOx8ziOxhiJFZoHrtAtNNg7CE2hY82HshVvZWBzha3r6knJ3Psfst@vger.kernel.org, AJvYcCWLgIg88W3qEQdEduzp+PM7KcMT5hs61LUGACn08Sdw+QiVevB4vOrtO5DgXrWRPDSvWVhYr1sgtNvddj8E@vger.kernel.org, AJvYcCWpGCkH+fAiomFfZLdcaFQuYFX/5ZbEbBDd77dDSkwqRYf59S3go0mVwk39R+u5cFON3JPgQRQ/ku26@vger.kernel.org
X-Gm-Message-State: AOJu0YxX6jFx35kY0rBvC2IgzlnBz9ZfWAGjhJi+vbhqnZ0poj21kphS
	f8UhOc6w7ejz3oD/OaQLB0aYq+1FPbgNpvCzL7WuxhSBdyph+9CuYJyMDQ==
X-Google-Smtp-Source: AGHT+IExGVU2eIhzLtlF5oC+IwQZch6SQphmFxCHEMGjkPilr1PdurYZniIoRt/eIMWw+CYH760DmA==
X-Received: by 2002:a05:6a21:164e:b0:1d9:87e3:120c with SMTP id adf61e73a8af0-1d9a851e807mr20475787637.32.1730303897299;
        Wed, 30 Oct 2024 08:58:17 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([203.81.241.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc89f2d5bsm9407519a12.57.2024.10.30.08.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:58:16 -0700 (PDT)
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
Subject: [PATCH v3 3/4] ext4: Support setting FMODE_CAN_ATOMIC_WRITE
Date: Wed, 30 Oct 2024 21:27:40 +0530
Message-ID: <6324c2a6d7cda24d72cb271e2a46a0b0df721d0a.1730286164.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1730286164.git.ritesh.list@gmail.com>
References: <cover.1730286164.git.ritesh.list@gmail.com>
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

Reviewed-by: John Garry <john.g.garry@oracle.com>
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


