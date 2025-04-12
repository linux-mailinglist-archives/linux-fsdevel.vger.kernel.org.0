Return-Path: <linux-fsdevel+bounces-46311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462CCA86AF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 06:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44114179B93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 04:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BA3188A0C;
	Sat, 12 Apr 2025 04:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr0M3GaW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBAB2581;
	Sat, 12 Apr 2025 04:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744432609; cv=none; b=dS0ZfZyNdvqsGRTetAmI6SF08h3zJWgaWLEors01HtcnUkOwI5XOYNKcph9I7lcPi2wwPikonCmS9dprLBVQk+NHrtk/Zhl5TvN+K1+U/ggEeDmM7j9U1zvYWDjfh2DCx6g41gCa4G4Cv0atm+u7TUFSNEkDd8ZjZV4Nl/Bj8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744432609; c=relaxed/simple;
	bh=dWpwNE+IEv5xEZqrdy2zX8cbD9eo0N6vof2jy7LY22o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JmZoNNGxtGGUcbSwgwKcHoi3W2v8rnVG1IE8/uNS5B2DTKNgXzMqThhTKbtyNbJLH+dEDvp1gE9fZetdWRFkMW7gPfVvg0pKNPvkNDlzKP0Xo9+2Djsu6Kb19qbRt6NyTDDF2wPguafET9UcoOvzOaerJNPdrk2zqtJCvIRtGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xr0M3GaW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73972a54919so2453124b3a.3;
        Fri, 11 Apr 2025 21:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744432605; x=1745037405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sMzyYTn4WuE4EsdB76LiGyB9L2UxItf7Sltpxk5CpzM=;
        b=Xr0M3GaWKhQ0JEsq21lQ4dPbDR2fWfau0sVo+6h0ARgGP79qgKpbTwmnbVLM5qvxEz
         T6ibwTXS5Czf5ZqCXr2J3yF85yq9umn0ia9qg5ua4IQn9uxRvtGacO3FTVzo5tsm1v7L
         7nmBfjHhUy82Vlgpxk9WwBFb7go4nMB37/Q0lsfsAnFQchZOWhzoGsoFqg9/RoUHDLoL
         EVPeybFKubfXg39pc5rRD38HkhfMD7k71B1Zbd8UDOq2riBaxGYEBB9bV8a4D1MTmpJU
         pGz+Q04eoAe7Np+pYZs7BQhitB64CM7VT8v0x60I2rUBntvJ5qcQRphM9XpTYmqKAh4h
         kyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744432605; x=1745037405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMzyYTn4WuE4EsdB76LiGyB9L2UxItf7Sltpxk5CpzM=;
        b=Lw4JwlfAgTH4dlmtzXh7w5Ah0kF6c6QorJZ3G7Mf9O2HguVoVImjhZApNe/PueDRDo
         1gOQgxX11sAEaB0ZrkOCartbnKPe2kZT6DtdGVeBI4fbSkJLXVN60XfxrpWfth81vxvb
         ADAZ/FQP1VTfHfN0Azp0SLS29pZseq7cUAkplmxW5eW2zJSua5/pQ4YCxOM1gsjJ7HQQ
         0OrE+9ruV5uolYSQg0+ABI4nu/IzpJ563uQcspWSVraJHu9s5/xrd8vNn4KXZVamrNTb
         kk+XvQjCIXxWm8ixw9Rn1IlW5DhJIsm9aW3cxYED6GkL1Mw+IvahaCKXt7tBIYh9XrK+
         UkZA==
X-Forwarded-Encrypted: i=1; AJvYcCVs6bicZiDWFCDwMQi7l3/Hy/zMfQveCCYTCJ8qoh4BFT6gW0Uy95iE35/LSwku8iEGXxCNsKz+tXh4oo5b@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/iDuFv8/DKZ2l7ZjKxF7RKQY93UpHB2/LFamPrdsaYDmZIRhJ
	5rkCn6qPImiyPix+Nnrn5STGGlrt8RJ6N/1u1T2F4PiEKoZedjjbE55EKQ==
X-Gm-Gg: ASbGncsbQJl2VcJepLakHvQTYdzx7hL6oWE4DY91TeXtiwdw4D8nY/C/mvcFjKSEt8J
	HuHQQDwFN8/6ue4dchR2aZfT8fF7o//wV6I83/PS0ngpAGG4BGQEU3SIJ9Rzphsv9+/iAs5QHM3
	V3mHnBSWz9ZPIu9jK6fNs9PvClbjQ+VXg8g9FlT3PR3i7bveyNTwv9Sbb381upka4j91+zvyoGn
	UYswuzgyXdHxXBGE3YNlCxq4gMzzWs/CRITs0z7pxYMleIO9Af68ggh47kOw9wMPFTTAUF6zqyj
	/ZSs5N2f8ynxh9bnCxQ4+nKtIwOfVwx4HWPG8f1OtbpurAE=
X-Google-Smtp-Source: AGHT+IEgr5KTviOB2Umr9g8y1ydPg/5WYIV2avsiB0hTb4uzPdBkD2czjwUa66AjeJKZjDMfw1csrA==
X-Received: by 2002:a05:6a20:e616:b0:1f5:5b77:3818 with SMTP id adf61e73a8af0-2017997314bmr8120745637.27.1744432604556;
        Fri, 11 Apr 2025 21:36:44 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0de8926sm4827993a12.30.2025.04.11.21.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 21:36:43 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	ojaswin@linux.ibm.com,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 1/2] Documentation: iomap: Add missing flags description
Date: Sat, 12 Apr 2025 10:06:34 +0530
Message-ID: <8d8534a704c4f162f347a84830710db32a927b2e.1744432270.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's document the use of these flags in iomap design doc where other
flags are defined too -

- IOMAP_F_BOUNDARY was added by XFS to prevent merging of I/O and I/O
  completions across RTG boundaries.
- IOMAP_F_ATOMIC_BIO was added for supporting atomic I/O operations
  for filesystems to inform the iomap that it needs HW-offload based
  mechanism for torn-write protection.

While we are at it, let's also fix the description of IOMAP_F_PRIVATE
flag after a recent:
commit 923936efeb74b3 ("iomap: Fix conflicting values of iomap flags")

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 Documentation/filesystems/iomap/design.rst | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
index e29651a42eec..f2df9b6df988 100644
--- a/Documentation/filesystems/iomap/design.rst
+++ b/Documentation/filesystems/iomap/design.rst
@@ -243,13 +243,25 @@ The fields are as follows:
      regular file data.
      This is only useful for FIEMAP.

-   * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
-     be set by the filesystem for its own purposes.
+   * **IOMAP_F_BOUNDARY**: This indicates I/O and its completion must not be
+     merged with any other I/O or completion. Filesystems must use this when
+     submitting I/O to devices that cannot handle I/O crossing certain LBAs
+     (e.g. ZNS devices). This flag applies only to buffered I/O writeback; all
+     other functions ignore it.
+
+   * **IOMAP_F_PRIVATE**: This flag is reserved for filesystem private use.

    * **IOMAP_F_ANON_WRITE**: Indicates that (write) I/O does not have a target
      block assigned to it yet and the file system will do that in the bio
      submission handler, splitting the I/O as needed.

+   * **IOMAP_F_ATOMIC_BIO**: This indicates write I/O must be submitted with the
+     ``REQ_ATOMIC`` flag set in the bio. Filesystems need to set this flag to
+     inform iomap that the write I/O operation requires torn-write protection
+     based on HW-offload mechanism. They must also ensure that mapping updates
+     upon the completion of the I/O must be performed in a single metadata
+     update.
+
    These flags can be set by iomap itself during file operations.
    The filesystem should supply an ``->iomap_end`` function if it needs
    to observe these flags:
--
2.48.1


