Return-Path: <linux-fsdevel+bounces-28848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DCA96F6FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 16:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF4A1C2438C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C971D279B;
	Fri,  6 Sep 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NZOkkI0v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13291D1741
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633311; cv=none; b=PozS6/9oeAcPflkRJOprBNdyiE5mTuW1YYHBk7+RNNfESVwd0lThHvgVP3lYcrZdKa0qw7Cn1Io7E1DECCWqK65WJ/s7Ijg2M22THEnrcTCqZUlf5Rsy6gg6M+vx3U+U/3rx6J0nRwtfwoX82dRhDwD4lgOdDZGusKctY56q9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633311; c=relaxed/simple;
	bh=vRdXR+Ob0mnRFvuQCd+W3NEcC2Rb5RFsu+cBKmNqVa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H8vQNlkDopVZBEC3IYqViUmvahPrhtYUq5KL/c2QN2+4YepRDaRa7ssa25CJENl0qCyazNl0X+cq4adIBpmlYBe+abXPgCTd3Eo59SqfFuTStx0qhxFq90J/VXiF3UhYyC3zvo47wHOTRAY9XoY3Zqq7GUHUESumSidmmV51zNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NZOkkI0v; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1BDB83F5B7
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725633307;
	bh=vVAyedH9CSkJs+YjMx3elnJrl6De9lkV+SRi3m1K9lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=NZOkkI0vlcwsIU0oIdCui1+3H5sq/AL0AbNjfUkMLEvyj/NfHbjpVZM4/oavxpB3h
	 HIaJz9XacJ7NRs4f6F7hdpnhGH+G7cKrFdsDQIjTDMPlnNOkjq6akRvbVcl+/LF9rX
	 dpNA4F7vRyMh9crZMrPFoP8F2RwFJOylq1cHj8wXGXQgs3LccHZaGHEIYsGxA9/Dd2
	 6W1PmgCvDiiiwMLDzTgX7sD5SzIejOQ/ivIZLxNK1wsJVlaPwg4mEsYkMnuuGaAqNs
	 8HKv21AlBaPkSeMxwI4LgQVZvHiiWB6rffhQGHiRNUelH+szze2IZppOmlW+eXvEe0
	 v0flbxv2oGBeg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8d1095442cso10470066b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 07:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633306; x=1726238106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVAyedH9CSkJs+YjMx3elnJrl6De9lkV+SRi3m1K9lQ=;
        b=leqW/9sZ+q10xE+XnG+JKN1ucCAVWob1ZUawQA9pTPf+15PgynCc+P6ZHjsmFI4fMZ
         t1e1/bw/MhtpZ78mkFJl/q/CkkrOtQSYyKHO8N6+T79XxcLQh/zwucAW39baP19qCrSg
         hC1kiNyWgHO81ffx/pRP6X9ns3fgefw+MDPfb7sRuLUXKhiVEUgfg0mTHQmYDpj6TNB/
         ZyFHDIYg0GI+OL6egj4MGrnr/BsXfCMUBubS7tnbDeaUZ4HdNkgXWCVfsKwUm60yvKxn
         V0lBlxb7HXLZjPDlMxyRjvan7actBDLeO30N40orbyXqA2l1I4nTQ23Mn/dIziWheZcL
         Mq4w==
X-Forwarded-Encrypted: i=1; AJvYcCUp+8/16Xonj3K7ZSgE4g+BG8q6I+mATdw6/vjubsiD9aJKeoqqMOKFAndysXv+talgTLNDIIdiGDqd6jtu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx30nfoOvr6ONMK5Igh1BMcf7SXAzm6bhAvLUxXLOlc8rE/9JXO
	LV296BsVZYSQv72uiKKfWTm6hkbnvunWXmJsaArHrc7aA+IWV4BYyaRR5B4IFJQDUkN3rEbwcdy
	5ChZcSxVX9T/2BB3KXnXcG28WzOUcfQIKfVBC2pYi8E5PCIuCe+c032nWmGIooyF7bOCkRgbL2/
	8kRmE=
X-Received: by 2002:a17:907:96a1:b0:a86:a7ef:5c9e with SMTP id a640c23a62f3a-a8a888d048fmr180478166b.59.1725633306341;
        Fri, 06 Sep 2024 07:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaDCxVgARkRpUsjaX0FAJO6glT8Qcp5RWHWQTtwxvVEnZ+tv3NLGsJxlxsKS0polGzAPOuOA==
X-Received: by 2002:a17:907:96a1:b0:a86:a7ef:5c9e with SMTP id a640c23a62f3a-a8a888d048fmr180476966b.59.1725633305874;
        Fri, 06 Sep 2024 07:35:05 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236cee0sm281787466b.101.2024.09.06.07.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:35:05 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Seth Forshee <sforshee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] fs/mnt_idmapping: introduce an invalid_mnt_idmap
Date: Fri,  6 Sep 2024 16:34:52 +0200
Message-Id: <20240906143453.179506-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link: https://lore.kernel.org/linux-fsdevel/20240904-baugrube-erhoben-b3c1c49a2645@brauner/
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/mnt_idmapping.c            | 22 ++++++++++++++++++++--
 include/linux/mnt_idmapping.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 3c60f1eaca61..cbca6500848e 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -32,6 +32,15 @@ struct mnt_idmap nop_mnt_idmap = {
 };
 EXPORT_SYMBOL_GPL(nop_mnt_idmap);
 
+/*
+ * Carries the invalid idmapping of a full 0-4294967295 {g,u}id range.
+ * This means that all {g,u}ids are mapped to INVALID_VFS{G,U}ID.
+ */
+struct mnt_idmap invalid_mnt_idmap = {
+	.count	= REFCOUNT_INIT(1),
+};
+EXPORT_SYMBOL_GPL(invalid_mnt_idmap);
+
 /**
  * initial_idmapping - check whether this is the initial mapping
  * @ns: idmapping to check
@@ -75,6 +84,8 @@ vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
 
 	if (idmap == &nop_mnt_idmap)
 		return VFSUIDT_INIT(kuid);
+	if (idmap == &invalid_mnt_idmap)
+		return INVALID_VFSUID;
 	if (initial_idmapping(fs_userns))
 		uid = __kuid_val(kuid);
 	else
@@ -112,6 +123,8 @@ vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
 
 	if (idmap == &nop_mnt_idmap)
 		return VFSGIDT_INIT(kgid);
+	if (idmap == &invalid_mnt_idmap)
+		return INVALID_VFSGID;
 	if (initial_idmapping(fs_userns))
 		gid = __kgid_val(kgid);
 	else
@@ -140,6 +153,8 @@ kuid_t from_vfsuid(struct mnt_idmap *idmap,
 
 	if (idmap == &nop_mnt_idmap)
 		return AS_KUIDT(vfsuid);
+	if (idmap == &invalid_mnt_idmap)
+		return INVALID_UID;
 	uid = map_id_up(&idmap->uid_map, __vfsuid_val(vfsuid));
 	if (uid == (uid_t)-1)
 		return INVALID_UID;
@@ -167,6 +182,8 @@ kgid_t from_vfsgid(struct mnt_idmap *idmap,
 
 	if (idmap == &nop_mnt_idmap)
 		return AS_KGIDT(vfsgid);
+	if (idmap == &invalid_mnt_idmap)
+		return INVALID_GID;
 	gid = map_id_up(&idmap->gid_map, __vfsgid_val(vfsgid));
 	if (gid == (gid_t)-1)
 		return INVALID_GID;
@@ -296,7 +313,7 @@ struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns)
  */
 struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap)
 {
-	if (idmap != &nop_mnt_idmap)
+	if (idmap != &nop_mnt_idmap && idmap != &invalid_mnt_idmap)
 		refcount_inc(&idmap->count);
 
 	return idmap;
@@ -312,7 +329,8 @@ EXPORT_SYMBOL_GPL(mnt_idmap_get);
  */
 void mnt_idmap_put(struct mnt_idmap *idmap)
 {
-	if (idmap != &nop_mnt_idmap && refcount_dec_and_test(&idmap->count))
+	if (idmap != &nop_mnt_idmap && idmap != &invalid_mnt_idmap &&
+	    refcount_dec_and_test(&idmap->count))
 		free_mnt_idmap(idmap);
 }
 EXPORT_SYMBOL_GPL(mnt_idmap_put);
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index cd4d5c8781f5..b1b219bc3422 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -9,6 +9,7 @@ struct mnt_idmap;
 struct user_namespace;
 
 extern struct mnt_idmap nop_mnt_idmap;
+extern struct mnt_idmap invalid_mnt_idmap;
 extern struct user_namespace init_user_ns;
 
 typedef struct {
-- 
2.34.1


