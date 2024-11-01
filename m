Return-Path: <linux-fsdevel+bounces-33434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEBC9B8B7B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CE71F23953
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811D2150994;
	Fri,  1 Nov 2024 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJy3YhB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0C1662F7;
	Fri,  1 Nov 2024 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443891; cv=none; b=pULQO3PGKgdAiyhxZU3axMyLU6bbMWFj2V06BhwHF7NXY4v0IRoRZnlYt5exwNWLsTG+woDZO8en1Q/8QrSmmrwDqvLPBgTnD8imzcFTwdLa6r3PqXApISj6sNPfm191gWURWtcl4AIBfXKVhk/mlS65ULX7iGFNDwt+/f8i2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443891; c=relaxed/simple;
	bh=vaVgVv7YrZV3cIEBmlq17X937fsAcWlptFhuhHNeyxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cex6XkJ21BTdDJdw3IgA5nhWSxW8epWkVzNFeR9EK8mB78GWG5sEuN71VOMKUfsSQ587AVYJQTMtz0BoVAOZ2VMaAr5FStfcRiXOnoUJvfQT6HTa+70RF3IonUET8RjfdPekTY2RcoxxrsTN9oVzDtJ8RK/aWqEKFewbWO4Ns3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJy3YhB+; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2887326be3dso824331fac.1;
        Thu, 31 Oct 2024 23:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730443888; x=1731048688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhxFZHmBzzbN7OKvAvqCU+zoNbHp35oZYGK+yoxfA8k=;
        b=hJy3YhB+8ugHGBvGR8u7nt42KBiNv1Fdv33cdS8GJssay1dAuB+44jZToCn3Fw55tH
         H/+TzNmng2NFY0SLxi65uOjst0simwgRw/UnJ2a7d2ASRnBOKEWD0DIyA2qru+biYpDO
         SqKhCfj2aPiuqU2ylwgzyK6VREwjOaoa2omjKJum5KjbZg7zTt3NhGI4MdorSFYa8QqS
         gs0UhTZJep+9a4RY4IApY8zMouuLZT+A6mAbGbbQ7qXZYzP7iqIovSqI8hqkxe60wrj3
         U+++7oErks+5Q5W/wya9Y8LQf2gltWdUQ/AMWMTL0arhwG/5LQ4oyWC26kRNUCAGMvTh
         GZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730443888; x=1731048688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhxFZHmBzzbN7OKvAvqCU+zoNbHp35oZYGK+yoxfA8k=;
        b=vjfRqGvWq+A7txG7jNKkLtythfSLv9MSrQYnqdgGcQzEy6NpeYGtU07XDKNHiRzXz4
         XpROgi+S9YLyHgsTg6ZJ76+kSjXsEB9RdrZbmQVUG8ys65VB5CbzDkDuVlq2pas5FICl
         6qUI4+CR/jwcUS+U+BbGHyFDzPGn3F/mg0kKrI/w9k7N+p/fqcBD3IPlmETbOKbUurlB
         HHQ02mJxKpP9aRjZ/fkn1SZmoaX4qaophVCWS/3LDcDDrRq6tnmnVuEV07wuQNyL6WWu
         PTqVQTP3s0SyKdhLLwW41BRevg8hv4d51TuT7lTPcC6ySsmCtWdKJ7T83Mc44FjSpCnq
         opwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhho7+9IUEMXIc+pejNCpZQBX4F1J8eGM6XUiSebD+ltiWcmBS8/rpRlWOScKuKQCyJ7vtfE3lk2gX@vger.kernel.org, AJvYcCWFtzdYNTrHMEdt6NwRrQPt38nN+kGrqRnqNMNjuYK16odgNLpR55YZpOX4/LhmPhaXM1jyza+NZGEdDYw8@vger.kernel.org, AJvYcCXkiWmCvh3EG8XYPJOGev3QtpPWHtbs9V1dAZXwBGSXVBjWqgXajvlZQY1JaLn/6kI9Hv7i/kvYheXjmx5S@vger.kernel.org
X-Gm-Message-State: AOJu0YwwyENnJ5zGHJ+AFKLDTwtdWDfnvb27DhO+N0qdhs39zWMOoVrf
	lu9rCU7v1qN4zbrEhz+HxNjFtywpEWpaO3WXLenreFfWyZYIoyxiGUPsJQ==
X-Google-Smtp-Source: AGHT+IG2PpCGU18j4TG27jx7tqg8xRN7m1guvNIHyfgGBbDGQRzUtv9/AF48cKYSYlXTbK8C/jXcXg==
X-Received: by 2002:a05:6871:3598:b0:288:4313:a3f8 with SMTP id 586e51a60fabf-2948449bccfmr5276844fac.13.1730443887734;
        Thu, 31 Oct 2024 23:51:27 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([203.81.243.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8971sm2196209b3a.12.2024.10.31.23.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:51:27 -0700 (PDT)
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
Subject: [PATCH v4 3/4] ext4: Support setting FMODE_CAN_ATOMIC_WRITE
Date: Fri,  1 Nov 2024 12:20:53 +0530
Message-ID: <d8f73bc9fef19dd90de537376f11f9f26daccbeb.1730437365.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1730437365.git.ritesh.list@gmail.com>
References: <cover.1730437365.git.ritesh.list@gmail.com>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index a7b9b9751a3f..96d936f5584b 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -898,6 +898,9 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 			return ret;
 	}

+	if (ext4_inode_can_atomic_write(inode))
+		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+
 	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
 	return dquot_file_open(inode, filp);
 }
--
2.46.0


