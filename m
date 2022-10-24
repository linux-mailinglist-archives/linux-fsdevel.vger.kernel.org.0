Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D3A609FF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 13:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiJXLNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 07:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJXLNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:13:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86806DF8A
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 04:13:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 550F8B810FD
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 11:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C660C4347C;
        Mon, 24 Oct 2022 11:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666609980;
        bh=17luflAOmuP+Am0hdneY0vuAuxyaDWhcFiF0f4OsJlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRJDehv5rAzk3+cSVMDYPXL4IP6YRkqssPjvCX7UzExjShEbwcqMx8tcqaKveI/at
         AHoOL47Ml6OECkjfmwetkjfbyF5GFhh/3ne+jutAlojM8fzbl7BAPtf/7pVn5ENGeA
         5P0AHWqkAgbE7AdyoyqZFAlXMmdFuVAcOGiCYvWUB8YfsL7EokB8FLV1H+0IRh31Dy
         hvoSOw8iA8Gewfx6PwGN61h8fnjA+RyCWGu3EEMMLya43URSDs7oELlxQEoukLJfY/
         Yza3avltYunZ8YqRZTlt8k2G5g92TSe9gHnA/y3xbP0pCvQ9aafzJshJbROZ1VNw2M
         ZEuHumuHN+IDQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/8] mnt_idmapping: add missing helpers
Date:   Mon, 24 Oct 2022 13:12:42 +0200
Message-Id: <20221024111249.477648-2-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024111249.477648-1-brauner@kernel.org>
References: <20221024111249.477648-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209; i=brauner@kernel.org; h=from:subject; bh=17luflAOmuP+Am0hdneY0vuAuxyaDWhcFiF0f4OsJlg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSHFeu0nZzbIRe6lSf94a+VE37FF11oUalTfXWlJzDx1417 s+xPd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE+SIjw/Kq9NT3zDZHt4dt79FNTd 6SvXCOxpTXK6xNq2b8/v1g5mOG/66qjD90p76RXcX3y3J3yIyWbc3HL863/vre9ZQ13/ZlS9kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add missing helpers needed to convert all remaining places to the type
safe idmapped mount helpers. After the conversion we will remove all the
old helpers.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:

 include/linux/mnt_idmapping.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index f6e5369d2928..cd1950ddc6a9 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -98,6 +98,26 @@ static inline bool vfsgid_eq_kgid(vfsgid_t vfsgid, kgid_t kgid)
 	return vfsgid_valid(vfsgid) && __vfsgid_val(vfsgid) == __kgid_val(kgid);
 }
 
+static inline bool vfsuid_gt_kuid(vfsuid_t vfsuid, kuid_t kuid)
+{
+	return __vfsuid_val(vfsuid) > __kuid_val(kuid);
+}
+
+static inline bool vfsgid_gt_kgid(vfsgid_t vfsgid, kgid_t kgid)
+{
+	return __vfsgid_val(vfsgid) > __kgid_val(kgid);
+}
+
+static inline bool vfsuid_lt_kuid(vfsuid_t vfsuid, kuid_t kuid)
+{
+	return __vfsuid_val(vfsuid) < __kuid_val(kuid);
+}
+
+static inline bool vfsgid_lt_kgid(vfsgid_t vfsgid, kgid_t kgid)
+{
+	return __vfsgid_val(vfsgid) < __kgid_val(kgid);
+}
+
 /*
  * vfs{g,u}ids are created from k{g,u}ids.
  * We don't allow them to be created from regular {u,g}id.
@@ -333,6 +353,12 @@ static inline bool vfsuid_has_fsmapping(struct user_namespace *mnt_userns,
 	return uid_valid(from_vfsuid(mnt_userns, fs_userns, vfsuid));
 }
 
+static inline bool vfsuid_has_mapping(struct user_namespace *userns,
+				      vfsuid_t vfsuid)
+{
+	return from_kuid(userns, AS_KUIDT(vfsuid)) != (uid_t)-1;
+}
+
 /**
  * vfsuid_into_kuid - convert vfsuid into kuid
  * @vfsuid: the vfsuid to convert
@@ -419,6 +445,12 @@ static inline bool vfsgid_has_fsmapping(struct user_namespace *mnt_userns,
 	return gid_valid(from_vfsgid(mnt_userns, fs_userns, vfsgid));
 }
 
+static inline bool vfsgid_has_mapping(struct user_namespace *userns,
+				      vfsgid_t vfsgid)
+{
+	return from_kgid(userns, AS_KGIDT(vfsgid)) != (gid_t)-1;
+}
+
 /**
  * vfsgid_into_kgid - convert vfsgid into kgid
  * @vfsgid: the vfsgid to convert
-- 
2.34.1

