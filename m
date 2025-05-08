Return-Path: <linux-fsdevel+bounces-48517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F30AB04F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBEC3B006E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48F321D5B0;
	Thu,  8 May 2025 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTWVCYxd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2B74B1E72;
	Thu,  8 May 2025 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746737467; cv=none; b=tPTMJKkqftuI4KdEVEyFTggQfQKXl+/xbedxd8di9eyb02e3qkjMw1ks34hILJMSjI1z+czwQEHbGC+fxBtiKsAyo0uQX3mWB39zZaElSLhMcw4TBgpq8hdZYh3/YRZe2yGz8rvYLwQBqxEU8d9GZ/OQOJAR8fgHZJiP0b4skFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746737467; c=relaxed/simple;
	bh=i8U2DwlenqYEXiN1Afx577EOVYnOs8GMPgHAsWV7lO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ml8vA4CA4gZtPBbmvIpXwqgrISUR0qhmd7eBjcGQ2Li7TahjeIqPXkLgJKLGddRox8dXyIplISaqVnq0dsTIJqYlM2GVByWd6ttnrlcDeLVzpJbLr3ziH86IpAoFjostsWYkM3MrGYST9xDF2O+mfhoE+3od18qTNgGIEcAwtiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTWVCYxd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74019695377so1164843b3a.3;
        Thu, 08 May 2025 13:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746737464; x=1747342264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iynY1FqHd4+SQTiVKWRTl+x1PpH/b45jtAdyzroyg7s=;
        b=dTWVCYxdg13TPG1V1wL5AEVIGZqKYlhUL79LLJtqCC7Z5/7LiCcomHDziOpcQD3LqY
         fKgh8wCT2PnQjsaoJr/CCIfz/zmeqbL+XUjMO9FaTBejwyeNQUAw1N6ig2aqFYIIEhMj
         ZlX8/g9ymXo6haeuzjnsJPyx9YB47SnmvJ8WmptWkwlgS+8Jf2K1Vi1LmeCbAVf5HaPm
         l5KuVMHV8/7dnnBElPL/xlefpmyxOWWaodkFjuATfo537E+gO/suW+aeKttZcRNJPbO/
         sPAV0DMm/IcEHaFl6GaZn1fUKD406zrkcCOk9QGHdxXbQ1IeR2WxSRkDzOUKD1iLQT/S
         C7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746737464; x=1747342264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iynY1FqHd4+SQTiVKWRTl+x1PpH/b45jtAdyzroyg7s=;
        b=qDBMwhBs9hOVWsy111mkyuytWVVIL7hE3dpzuVDpQ9y2LWL0tiXdwCrYyOslIbcF6K
         Ri4CO/TmBg9447marcUHVpYYPCyJm8ZuGHhgny2kZtdHcxejRsli/aFx73kpVVypeeeF
         ORPkWhLJObH6+NMMfrHmUPT0bzo3h4O80esNY0qhzioQ6UwknBw8wWtORwDt/Kap1wB+
         OAK4+z6gafT3okUFZqpBCW4dmt0Yf2F1FBecjslfCEVrMYSMy7m6hoZcjDktwLfhWUmY
         HKqrckn9KLGMLVlgtlJHfaiCI1HXKjUPRvEEre6FySa3gPRepDVDFUsYRfJsh5SZ6LnT
         PPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxStUIIwO/pas/Mt+tpSKYykTabJx1wohsINzSevzULfTdGHP9JcFOTCZ3AQR23dtYi+6dd10DKnNgGwqT@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNA3Ds5Ty6koqQxyESlu6R2Vh/+/jb+QNT+9Tje/8x6kPf4Pn
	8FeTwBSmEAjBoDnLvbNE2LRl48LOsSo3XCz8qJLw9DnwOBFfpmj8lasUAQ==
X-Gm-Gg: ASbGncujAV48Q2g4FV/6cipCLC+UtXYcfAwLqP04FklwSrtuwXo3X+TjV9NCKzLJIaE
	kpdLT3CdGYIOdTemCZh1MJconARN2Id+1Zu+H/92EdqQW8XUemxJbyG8ubo+YNNegFW1EPCB1Um
	XUKH3+DIp+KeMumk2S/HOmhYNC+YYa+/KG5bWkNlnLKqu+mByIws5Nmn507ZyYmcXw9CfOudF6p
	4FluNh87mDhcSjFzXCrco20nvUnZlK38vSo7WFxPGH/KXLXirdI0A59uf7TtWhSbBMxSJYfZbRp
	HLS6cpK0vwWZj6Yr2MjeqjF9DZPRjRFwb3cQ93h2RrVlFvo=
X-Google-Smtp-Source: AGHT+IHp6StcMJCGnEsnpryp4ILMu9+WQEL6ZBbivpF5pBSJxsxzQ1+/SxWhYllcXUZQCvO3OBoydg==
X-Received: by 2002:a05:6a00:85a2:b0:742:3cc1:9485 with SMTP id d2e1a72fcca58-7423cc196c9mr713624b3a.12.1746737464457;
        Thu, 08 May 2025 13:51:04 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a97de2sm463763b3a.175.2025.05.08.13.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 13:51:03 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 1/7] ext4: Document an edge case for overwrites
Date: Fri,  9 May 2025 02:20:31 +0530
Message-ID: <9f95d7e26f3421c5aa0b835b5aa1dd4f702fc380.1746734745.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746734745.git.ritesh.list@gmail.com>
References: <cover.1746734745.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext4_iomap_overwrite_begin() clears the flag for IOMAP_WRITE before
calling ext4_iomap_begin(). Document this above ext4_map_blocks() call
as it is easy to miss it when focusing on write paths alone.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..b10e5cd5bb5c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3436,6 +3436,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		}
 		ret = ext4_iomap_alloc(inode, &map, flags);
 	} else {
+		/*
+		 * This can be called for overwrites path from
+		 * ext4_iomap_overwrite_begin().
+		 */
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
 	}
 
-- 
2.49.0


