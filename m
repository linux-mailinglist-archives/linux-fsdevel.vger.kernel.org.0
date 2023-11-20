Return-Path: <linux-fsdevel+bounces-3257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB547F1D10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 20:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB385B21948
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 19:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A9F347B0;
	Mon, 20 Nov 2023 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if/eOK5X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134079C;
	Mon, 20 Nov 2023 11:05:32 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso4153373b3a.1;
        Mon, 20 Nov 2023 11:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700507130; x=1701111930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zd++HJYMLvpd7mdF+UkLdm6vt1MAuB0fn/E4Eq0fcFU=;
        b=if/eOK5XrxCd2u/uCjsEBi9plGoijkoLtmhAj6ul9Jyzd2FyJuyI0DQYO8Q1wOMa+C
         hIbDWbgbeILfY7HkVOiePPhsbKBPEI46SjubaToGmhXNCpPcvbJCg2GGuHq7qiUM8hZ9
         4NLiiqGlisjsjKEVwE3nYYq4FaZG1XvVsmF6YQrjHKz62U+Iw5XrwhwUmfxIE98ZMzNd
         zRf4S1LV6HygGwRgHRhJRXqlnzhZgcEN8b2u2V15VEzcvdqpMwU+C2PwzfIrmViEK2KT
         r70vPjt+p3NH778Ug/WV7wj5Z932gwcW6zAEomI+yMp6ds97cV0KU2/itxe2OCFQu4ak
         IInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507130; x=1701111930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zd++HJYMLvpd7mdF+UkLdm6vt1MAuB0fn/E4Eq0fcFU=;
        b=WV/tQMW/PlPPdVH1NXC/ha9NRSrqvPmpRQSvPmztbzbURQBXEXg8+yB/rij6kX1iX1
         6NgQNgfxBiZ8KQoinZKM8oOslgMKV3Ewso0PCvr4hhHJ/SpIbdpi0TeL8v4WhtGyaJvE
         wwqSxsvdJjjaMgQbT17Agj2lWAS/ajX4HPIUGxvfD1KO4Zs3MNc/Spg59fu8K0spp1+X
         kPyVStRD8Y12kx5nlYiMDyks1C1jpfMAJ/25J3DqBxcMUKG136qSdU0QIf3PS7rkT0Tc
         sBZTjZmAtleoo1LSqtFDCmypTyr/4vYvK2KocgRyaOOppvNfYmlXccHh2wek5l9FKoZI
         MXTA==
X-Gm-Message-State: AOJu0Ywe31kLAHsIPSpSfMATBwgTcZUUhLBVn0L7vhLLCGdIS4/67dwb
	U1aLjog/uuaR+peC+n/sHk6hIP41fXc=
X-Google-Smtp-Source: AGHT+IEB1sE5/O62jI2/n9JbYZigLWD6BFuABUFN6o7pPlkyPys+wj2SGeD0Ge2L7bgPE6olDglYug==
X-Received: by 2002:a05:6a20:9188:b0:187:c2be:3c41 with SMTP id v8-20020a056a20918800b00187c2be3c41mr7602932pzd.1.1700507130541;
        Mon, 20 Nov 2023 11:05:30 -0800 (PST)
Received: from dw-tp.localdomain ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id y10-20020a62f24a000000b006c69851c7c9sm6353699pfl.181.2023.11.20.11.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:05:29 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 1/3] ext2: Fix ki_pos update for DIO buffered-io fallback case
Date: Tue, 21 Nov 2023 00:35:19 +0530
Message-ID: <9cdd449fc1d63cf2dba17cfa2fa7fb29b8f96a46.1700506526.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700506526.git.ritesh.list@gmail.com>
References: <cover.1700506526.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit "filemap: update ki_pos in generic_perform_write", made updating
of ki_pos into common code in generic_perform_write() function.
This also causes generic/091 to fail.

Fixes: 182c25e9c157 ("filemap: update ki_pos in generic_perform_write")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 1039e5bf90af..4ddc36f4dbd4 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -258,7 +258,6 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out_unlock;
 		}
 
-		iocb->ki_pos += status;
 		ret += status;
 		endbyte = pos + status - 1;
 		ret2 = filemap_write_and_wait_range(inode->i_mapping, pos,
-- 
2.41.0


