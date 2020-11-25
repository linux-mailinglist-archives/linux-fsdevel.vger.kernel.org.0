Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AB92C3E5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 11:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgKYKqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 05:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgKYKqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:46:32 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F42C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 02:46:32 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w187so1935279pfd.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 02:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVocGFl0NO83QfmRGmsn75j5KiXzhBnKPCm/gVYZ/Ck=;
        b=YNx6a17SuNGzSgh/5mJhhB6egK6vrpaIHAdEQRsgAbjodboiSPq2oTqwxWQOPaSbey
         otuky4Pux7OUPoN0KiYZygN7BjrSKFDi4kbiVPRNMzBsg4dix5sr/ol5ULIccqp+s/DH
         7Cd2xqWJIGtAS86SgKR50WrTJyYoED5O92BTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVocGFl0NO83QfmRGmsn75j5KiXzhBnKPCm/gVYZ/Ck=;
        b=mKCyA+WyGWLbDPqcHaMYmxcjRcRiWaui3Wzs+hDmMSP1k0DHFNXm5MwvN+F7u6NNvr
         WR6Y0iJCnkF6NjWPQ80Dgeajrw5zdJd1wPEDcpgrXyW7gOteq2SZIlA47/7hELV02oBt
         nq6vSi+vnihqlLCVOtUcMgqBKrtaWdnLMABY+lMYDU3jxGSyroFpiePcAJ8nXgHCK/lu
         NpEupDULKgHg4Aun75kJs1fWPOYAxs5va4HZO2YnmUFzBtPpkwSwnFR7xu1S5Q1BNTIw
         HqwG/eVxIopgcJ4U7QY4y5iQj0Bwp5LAvEtum/OGIRuoXDe0cTg495I/wHf99RvatBWQ
         iWQA==
X-Gm-Message-State: AOAM531Z8yoXIPmghMLkLtUxTz5NV7BVw1lBZ8NyUjRpSM6H8NepO3jT
        ytvrpFsMbKWXNxjhTXSldLeX3Q==
X-Google-Smtp-Source: ABdhPJw011PnhG1KsTInONS3LeMxNfjaiOmeuCRLfOsAWW34If9z7Qq/ATs/ni1R2iAydBHDGjRMrg==
X-Received: by 2002:aa7:954e:0:b029:198:1a04:36a7 with SMTP id w14-20020aa7954e0000b02901981a0436a7mr2685240pfq.10.1606301191916;
        Wed, 25 Nov 2020 02:46:31 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id p15sm2408252pjg.21.2020.11.25.02.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 02:46:31 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v1 3/3] overlay: Add rudimentary checking of writeback errseq on volatile remount
Date:   Wed, 25 Nov 2020 02:46:21 -0800
Message-Id: <20201125104621.18838-4-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125104621.18838-1-sargun@sargun.me>
References: <20201125104621.18838-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Volatile remounts validate the following at the moment:
 * Has the module been reloaded / the system rebooted
 * Has the workdir been remounted

This adds a new check for errors detected via the superblock's
errseq_t. At mount time, the errseq_t is snapshotted to disk,
and upon remount it's re-verified. This allows for kernel-level
detection of errors without forcing userspace to perform a
sync and allows for the hidden detection of writeback errors.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 fs/overlayfs/overlayfs.h | 1 +
 fs/overlayfs/readdir.c   | 6 ++++++
 fs/overlayfs/super.c     | 1 +
 3 files changed, 8 insertions(+)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index de694ee99d7c..e8a711953b64 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -85,6 +85,7 @@ struct ovl_volatile_info {
 	 */
 	uuid_t		ovl_boot_id;	/* Must stay first member */
 	u64		s_instance_id;
+	errseq_t	errseq;	/* Implemented as a u32 */
 } __packed;
 
 /*
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 4e3e2bc3ea43..2bb0641ecbbd 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1109,6 +1109,12 @@ static int ovl_verify_volatile_info(struct ovl_fs *ofs,
 		return -EINVAL;
 	}
 
+	err = errseq_check(&volatiledir->d_sb->s_wb_err, info.errseq);
+	if (err) {
+		pr_debug("Workdir filesystem reports errors: %d\n", err);
+		return -EINVAL;
+	}
+
 	return 1;
 }
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 9a1b07907662..49dee41ec125 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1248,6 +1248,7 @@ static int ovl_set_volatile_info(struct ovl_fs *ofs, struct dentry *volatiledir)
 	int err;
 	struct ovl_volatile_info info = {
 		.s_instance_id = volatiledir->d_sb->s_instance_id,
+		.errseq = errseq_sample(&volatiledir->d_sb->s_wb_err),
 	};
 
 	uuid_copy(&info.ovl_boot_id, &ovl_boot_id);
-- 
2.25.1

