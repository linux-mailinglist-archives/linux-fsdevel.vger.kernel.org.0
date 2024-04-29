Return-Path: <linux-fsdevel+bounces-18128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DCD8B5F95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B18F1F23BA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66AD86655;
	Mon, 29 Apr 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbHLWhEl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC68626D;
	Mon, 29 Apr 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410317; cv=none; b=JcNB/XCBl8ovpUPaDEjEs79M8kKJAjVIhF5aIGRm5LkrmARl00iqsKyVmVgi8ZqSyiD/fwuV0HnF4AQdVp3TKWK35P6WwlBe3BtbQ8C2BFMogyjhRGt1QYFxQEmseYu9/3SeHcjTUMJJWtmjracBjBd1TVSTFIj27K1xWe5xzko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410317; c=relaxed/simple;
	bh=soONSsHFI6nzOHKUp35TcQ0GKddlcVxDmE7JFRha/Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CwOJxHRA1jdHPBSPlIU/EmgqzPzlKjJeIxDjmiBQZ0U1GpgfZS8XVKZwsdXMiHVArqMLNq7Ac2chfAhw3XC7wPuXayM9kA4hvBVgYLjS+IgyZMWKniC2GCiqes9oXYPUXPb54ZkrZzfjdv7cZbkLlhrZoSfW+B3h7G0OaGbD5E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbHLWhEl; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ee2d64423cso897105a34.2;
        Mon, 29 Apr 2024 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410315; x=1715015115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRZMXpVDaupswF2EGFq0CRj0FomMbu4maf2unw0x+4s=;
        b=nbHLWhEl90dXqvlIbUmOzj56hjzb7lxkdSWPLAUV6bywM5YEbP3MYfoJY1QPvrwbFo
         dXBlZZ09GwFSGEcb6NjhhJxulrW0GSdkSEYclQXN5C6oeSeSnEfA3RAxjx+KqVKyaefm
         E3THuGap8OojEwP+60i+eEqMwkZ4pOsamIyVDAhoC4aOeC+c4PVVE+4CN6Q4Q5QUD7fi
         PpLOnGZAbpZrb7nDVishtduis5UCxC5od6dUDLYgETc8fceGWQSJrSFpmM/l7MBxSTSr
         QQhdek2/nP19Hur/TnJhEZsCozw9OHb77apARf44rsDKofqOLqmQ2pSqb2P3pDSVHbtW
         NO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410315; x=1715015115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eRZMXpVDaupswF2EGFq0CRj0FomMbu4maf2unw0x+4s=;
        b=GICtQPrviX760g8rYFy+L7mnNDa3YHAPA1WKu3s7h/jYiMhljFYri2CgU0dX7rS/dp
         nj+J/0rKbJP/dV3xXPu6v+ybJBAESNEb1951kaySXCzhHVYA0g5hiHStk8C4YLGVI/iZ
         ILyJvkCL4Z59/6m35inn0iMnvlcJT5+wPHPGaoBm810IuhPuMfgpaWeGQsGGLEQnErtr
         ru9HBNQ3cyndQqIUdO9nxaDGCrYRa9fXzrxmm0N8bf69TlF7OkAjLJ9zjG5JPl1OLTkf
         bGe4ELw/bmLHbKMnpKn9Hse1ZbsC5Efj1ykGTM1zKB5YJZkyCEWoEpDZxSW9lgSAKnPk
         j1Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXPzU5tO3bmGDNP++4zfrexUrN3ySBqFeyf16bEKN5d9DJCp5+v2qpz4lp6Vo0WrlAJMdJBlq1mTTmmqKHLFXwVfem1SLkXeWFPrlDPYRT7f3Bz4zVRrGWblJNjsgZIc5VUAHMt7w8ASg==
X-Gm-Message-State: AOJu0YzLIb/OISfBB9amIWFwnttcAqr7UYfjcTqMFR+2CPcqLOUrZG0j
	SG3WY/omjWC0m1feV7VcfmsHMPS2+6NB1/iEvwqisr5+V7ipa1/Z
X-Google-Smtp-Source: AGHT+IFAZMCprMAfngbGfmfnfc0KD83EThJP15yBR4/UvGbdxcZfQLPaHwO+y+izxvLX28mjpzQ3QA==
X-Received: by 2002:a05:6830:1516:b0:6ee:3710:231c with SMTP id k22-20020a056830151600b006ee3710231cmr3205587otp.2.1714410315062;
        Mon, 29 Apr 2024 10:05:15 -0700 (PDT)
Received: from localhost.localdomain ([70.114.203.196])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6201000000b006ea20712e66sm4074448otj.17.2024.04.29.10.05.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 10:05:14 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John Groves <jgroves@micron.com>,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	Randy Dunlap <rdunlap@infradead.org>,
	Jerome Glisse <jglisse@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Ravi Shankar <venkataravis@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Steve French <stfrench@microsoft.com>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Stanislav Fomichev <sdf@google.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	John Groves <john@groves.net>
Subject: [RFC PATCH v2 07/12] famfs prep: Add fs/super.c:kill_char_super()
Date: Mon, 29 Apr 2024 12:04:23 -0500
Message-Id: <a702d42c922737c4f8278617db69ce2b6d813c5f.1714409084.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1714409084.git.john@groves.net>
References: <cover.1714409084.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Famfs needs a slightly different kill_super variant than already existed.
Putting it local to famfs would require exporting d_genocide(); this
seemed a bit cleaner.

Signed-off-by: John Groves <john@groves.net>
---
 fs/super.c         | 9 +++++++++
 include/linux/fs.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 69ce6c600968..cd276d30b522 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1236,6 +1236,15 @@ void kill_litter_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(kill_litter_super);
 
+void kill_char_super(struct super_block *sb)
+{
+	if (sb->s_root)
+		d_genocide(sb->s_root);
+	generic_shutdown_super(sb);
+	kill_super_notify(sb);
+}
+EXPORT_SYMBOL(kill_char_super);
+
 int set_anon_super_fc(struct super_block *sb, struct fs_context *fc)
 {
 	return set_anon_super(sb, NULL);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8dfd53b52744..cc586f30397d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2511,6 +2511,7 @@ void generic_shutdown_super(struct super_block *sb);
 void kill_block_super(struct super_block *sb);
 void kill_anon_super(struct super_block *sb);
 void kill_litter_super(struct super_block *sb);
+void kill_char_super(struct super_block *sb);
 void deactivate_super(struct super_block *sb);
 void deactivate_locked_super(struct super_block *sb);
 int set_anon_super(struct super_block *s, void *data);
-- 
2.43.0


