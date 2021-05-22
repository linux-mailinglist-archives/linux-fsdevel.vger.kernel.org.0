Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF438D29D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 02:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhEVAnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 20:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhEVAnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 20:43:02 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E65C06138A
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 17:41:37 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id f15-20020a17090aa78fb029015c411f061bso9386997pjq.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 17:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ozC5usJqVL5eCwVY7kOtsxenQ+7Cwr3eUkEjwwPVo1c=;
        b=lKd/YLfRlAqmAomXF4Ctcz2jryVPoSa9W12eBj/HYPTnS61IzqgQssSl0S+WU4AhCH
         e1v0scqSad4KFzN09V3MMswCVhLamfcC8HrJsopsWLujE28emOtDVqtRQ1dgvrMbCZVP
         oBKLawc1WGYGVMKAa89bOB07LFFqO0O7I7gP1gjzANqbVKaT8cU4T2uj1mIrirx5u2Sk
         Vc/lNFr9COTtFVYq1hWqCx1VF5lLlf303q717Q5qm5GAF0Y/KsB4g2g6UC3pYJp8mt0r
         TCVCUUgg4VFkXYYq4yOY/lywEy+KbJ5kyhC2HmhI9AJbwCpZ22PtX8IsBD6++zBrYTPX
         Gx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ozC5usJqVL5eCwVY7kOtsxenQ+7Cwr3eUkEjwwPVo1c=;
        b=pNTp0IfbBHrzecNS1WZCpsB0tJedOtfoi9VZCNffqLuHrl+PH48B4P/eHkhm2HDwGT
         SKKaVWK/jX62iFstvlSUwp6mNFTnn184e9t1NHmZS6QNP5dFTJkg3ngwwcFLlrmlR35q
         3D2TMg9ja1t3PIfbrEZ0Rlj6wPRdvaY3wLwoDBT6QgKV1EAbvvGAOur/392I7D3OfAg3
         mfj7vtduPqYO6QZKO8r3nwbhek17y4d9A6Bkv3b7OPdVtUADwRzh+UvPOWwjCzrx0Epr
         dWqECie3mB4hwllpzi9esZTSlXH70oS5TpqYV3YIvV7+S8Qc/rxAmFYAytYLb11+8BfL
         vSSg==
X-Gm-Message-State: AOAM531mu9xbR2OkisBdSW0IAXDSGvDlMHtZxS3TWEn9N5j4Ctk33Hoe
        8XwWJGa0wGypWieoBXEAUqCI2SgPylQ=
X-Google-Smtp-Source: ABdhPJzt80Ve0mGo9634BvBPrzyJI6mYke2STWtWfN2NkfJ5wbsvcmDfeuVGh7hFxJ4VsSvSSPx87+HNBcg=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a63:7e13:: with SMTP id z19mr1429012pgc.184.1621644097067;
 Fri, 21 May 2021 17:41:37 -0700 (PDT)
Date:   Sat, 22 May 2021 00:41:32 +0000
Message-Id: <20210522004132.2142563-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH] ext4: Fix no-key deletion for encrypt+casefold
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit 471fbbea7ff7 ("ext4: handle casefolding with encryption") is
missing a few checks for the encryption key which are needed to
support deleting enrypted casefolded files when the key is not
present.

Note from ebiggers:
(These checks for the encryption key are still racy since they happen
too late, but apparently they worked well enough...)

This bug made it impossible to delete encrypted+casefolded directories
without the encryption key, due to errors like:

    W         : EXT4-fs warning (device vdc): __ext4fs_dirhash:270: inode #49202: comm Binder:378_4: Siphash requires key

Repro steps in kvm-xfstests test appliance:
      mkfs.ext4 -F -E encoding=utf8 -O encrypt /dev/vdc
      mount /vdc
      mkdir /vdc/dir
      chattr +F /vdc/dir
      keyid=$(head -c 64 /dev/zero | xfs_io -c add_enckey /vdc | awk '{print $NF}')
      xfs_io -c "set_encpolicy $keyid" /vdc/dir
      for i in `seq 1 100`; do
          mkdir /vdc/dir/$i
      done
      xfs_io -c "rm_enckey $keyid" /vdc
      rm -rf /vdc/dir # fails with the bug

Fixes: 471fbbea7ff7 ("ext4: handle casefolding with encryption")
Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/ext4/namei.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index afb9d05a99ba..a4af26d4459a 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1376,7 +1376,8 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	struct dx_hash_info *hinfo = &name->hinfo;
 	int len;
 
-	if (!IS_CASEFOLDED(dir) || !dir->i_sb->s_encoding) {
+	if (!IS_CASEFOLDED(dir) || !dir->i_sb->s_encoding ||
+	    (IS_ENCRYPTED(dir) && !fscrypt_has_encryption_key(dir))) {
 		cf_name->name = NULL;
 		return 0;
 	}
@@ -1427,7 +1428,8 @@ static bool ext4_match(struct inode *parent,
 #endif
 
 #ifdef CONFIG_UNICODE
-	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent)) {
+	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
+	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
 		if (fname->cf_name.name) {
 			struct qstr cf = {.name = fname->cf_name.name,
 					  .len = fname->cf_name.len};
-- 
2.31.1.818.g46aad6cb9e-goog

