Return-Path: <linux-fsdevel+bounces-17781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EED38B22B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E500B28F88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5D8149DE3;
	Thu, 25 Apr 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7dcTkBO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7EC149C7D;
	Thu, 25 Apr 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051757; cv=none; b=UX+V0w99M/jFXr6wU8Nn5NI9hK5YfQey6I0f0V8TA/4UVOev1MydIRKcsHTJ6cxAZ8lHTLPsqqS2tClWcXm6q82itODbzUPGyPAS5AchVF+cyE5fZlO9Al2HFiF0fjr4dxF3+2yvsIFBYjV1GODO8iasHhCdbTo9TzkGtZt3S68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051757; c=relaxed/simple;
	bh=8PI/Yd36KE16CRpWHWbzB5M8B8kPx+mwO9n/9I4bEvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1lTyxBLMlqqLyx7nCoKy83v78DvsyNTJVi3NJl+RDX2dVJbOpa6/NoEnSQv0vJ9uNblLGM+z2Fuy9lESv0qGQW7m8sSAm3a8zp14WIDPABp8U+P5wqx/HUtCbEw2TKODu9nQAHIkd9YWnQpgGIiw8l/ZbsHqb9KITiZ6OeXQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7dcTkBO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so985268b3a.2;
        Thu, 25 Apr 2024 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714051754; x=1714656554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdS7HPQ96MsYbjUY38DCfySnr+/bDWzu/eQof1r1iiI=;
        b=W7dcTkBOx5AxprC0K8gOeL/nIsNVysvYmi5hIEUR56b9xYmXpp6yS3T47sTFiAaLcu
         mdivFUSU5EgLxVMPdsPR1Oc0Y0y7+KI3hJgwOtdiK/9gtp/xrefFZgJzKvY/BWOb7Qur
         HL/heG++wKpCbFpE3wV+KiQS7V6uI/s9f8TtuV8qprhvTmD+18c3wLLwmnEwjtlZVxT0
         F8GYuVhHDnD4z/okF/UlGOhk+ZoDVPCYn4SHvKC1AFqA/9+Vw8vgYawuyhuZFNMa0fwl
         qbHpNm7W23RB2J5nCkrwTGakaECMh76cDFscOdflkqrNwX07Pqbcy+VbwVoc7q9zCzRO
         EXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714051754; x=1714656554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdS7HPQ96MsYbjUY38DCfySnr+/bDWzu/eQof1r1iiI=;
        b=R5fZnpIV2Fdomq3MJRLQpWJtz6Nu+Xqtt5rPYIMroDl2t1j3J+apBaZLagfbGdMNrj
         1/ZYfkP55leq7sD+2tgd5tumPuDpArq1WcSSmV2SSdUK3DPzyOsqC11fomzKmkAMBex2
         65VzCcmwGKjgH5rysD3rfeFLn1N63O/NGV99loh11Ysn5B6zDxEOfjIP/3XVmA1g/jdB
         EFJk2OkLOWHAdorPmaCHoHNBmnr2rP7FVHzH2/JacdZW84LmRR+3AfC0yvUT7ULc5NzE
         lC4l+Oqhw5twt9dm4fSdhkN0OocwXbC0Mr/Nq9M4IjfsVELQwOfrC5k6yTs8PsXpc9L+
         YT4w==
X-Forwarded-Encrypted: i=1; AJvYcCXAO+9vtl3Nkpk1NtjQBsBrr3STYIVhn0Oq79FnF41L5vmwdsAbdNxdq8y9htSgwD/a3VBxao72zGEMOWnXQZOQvYgF8zZS6UIX
X-Gm-Message-State: AOJu0YxpxHOR9LcHZmstk0dQ7imkfBryzRer0x6CvopzGsEfiHU6FWIQ
	bINTfoWkSe4Mhgzz8sOFrcwi6V/UDe1MqzYxkfutOJeJB3ptYg5wxtfeRqVN
X-Google-Smtp-Source: AGHT+IH9C9r7Mnh4AB4KUmTdE9g+FmuvxgTspXlf6hn2+h3axk/BCWPGTa3Tf+wX9TDeNMVQNv8XQw==
X-Received: by 2002:a05:6a20:12cc:b0:1a3:c3a9:53b7 with SMTP id v12-20020a056a2012cc00b001a3c3a953b7mr6938369pzg.55.1714051754548;
        Thu, 25 Apr 2024 06:29:14 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id s15-20020a62e70f000000b006f260fb17e5sm9764518pfh.141.2024.04.25.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:29:14 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [RFCv3 3/7] ext2: Enable large folio support
Date: Thu, 25 Apr 2024 18:58:47 +0530
Message-ID: <581b2ed21a709093522f3747c06e8171c82f2d8c.1714046808.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714046808.git.ritesh.list@gmail.com>
References: <cover.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that ext2 regular file buffered-io path is converted to use iomap,
we can also enable large folio support for ext2.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index f90d280025d9..2b62786130b5 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1424,10 +1424,12 @@ void ext2_set_file_ops(struct inode *inode)
 {
 	inode->i_op = &ext2_file_inode_operations;
 	inode->i_fop = &ext2_file_operations;
-	if (IS_DAX(inode))
+	if (IS_DAX(inode)) {
 		inode->i_mapping->a_ops = &ext2_dax_aops;
-	else
+	} else {
 		inode->i_mapping->a_ops = &ext2_file_aops;
+		mapping_set_large_folios(inode->i_mapping);
+	}
 }
 
 struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
-- 
2.44.0


