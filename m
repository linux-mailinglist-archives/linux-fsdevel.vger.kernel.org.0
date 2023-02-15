Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E947C697D9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjBONkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBONkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:40:07 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033EB17176;
        Wed, 15 Feb 2023 05:40:00 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 9EA59214E;
        Wed, 15 Feb 2023 13:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676468148;
        bh=rB9oY1q3nHZkv8dcWTH7MJPs0yxT5yMPWcoRYJN6cPo=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=cn/LgCeql+gT9wllgjxGK/meqSHPBA+zy76Kk67JJ9quCUT8HpNBYuHa9A6eGrnr+
         EVOphhOgRmHkX8fZqsmB4/OgHRWFXezDR+Ng6RRmNiJW0APD2RuDWahNLcxnACTlPs
         wVvPpX9sN+e+uhQ7g4bhxjSJ9zLBwy9CU/jPrIDY=
Received: from [192.168.211.36] (192.168.211.36) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Feb 2023 16:39:58 +0300
Message-ID: <6551ad6b-9d90-edc3-920c-347a43216cd3@paragon-software.com>
Date:   Wed, 15 Feb 2023 17:39:57 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH 10/11] fs/ntfs3: Add missed "nocase" in ntfs_show_options
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <d7c91201-5e09-5c06-3283-7887f5a5b7f1@paragon-software.com>
In-Reply-To: <d7c91201-5e09-5c06-3283-7887f5a5b7f1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.36]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sort processing ntfs3's mount options in same order they declared.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/super.c | 40 +++++++++++++++++++++-------------------
  1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 6a412826b43d..521ce31d67a1 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -270,11 +270,11 @@ static const struct fs_parameter_spec 
ntfs_fs_parameters[] = {
      fsparam_flag_no("hidden",        Opt_nohidden),
      fsparam_flag_no("hide_dot_files",    Opt_hide_dot_files),
      fsparam_flag_no("windows_names",    Opt_windows_names),
-    fsparam_flag_no("acl",            Opt_acl),
      fsparam_flag_no("showmeta",        Opt_showmeta),
+    fsparam_flag_no("acl",            Opt_acl),
+    fsparam_string("iocharset",        Opt_iocharset),
      fsparam_flag_no("prealloc",        Opt_prealloc),
      fsparam_flag_no("nocase",        Opt_nocase),
-    fsparam_string("iocharset",        Opt_iocharset),
      {}
  };

@@ -364,6 +364,9 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
      case Opt_windows_names:
          opts->windows_names = result.negated ? 0 : 1;
          break;
+    case Opt_showmeta:
+        opts->showmeta = result.negated ? 0 : 1;
+        break;
      case Opt_acl:
          if (!result.negated)
  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
@@ -375,9 +378,6 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
          else
              fc->sb_flags &= ~SB_POSIXACL;
          break;
-    case Opt_showmeta:
-        opts->showmeta = result.negated ? 0 : 1;
-        break;
      case Opt_iocharset:
          kfree(opts->nls_name);
          opts->nls_name = param->string;
@@ -547,34 +547,36 @@ static int ntfs_show_options(struct seq_file *m, 
struct dentry *root)

      seq_printf(m, ",uid=%u", from_kuid_munged(user_ns, opts->fs_uid));
      seq_printf(m, ",gid=%u", from_kgid_munged(user_ns, opts->fs_gid));
-    if (opts->fmask)
-        seq_printf(m, ",fmask=%04o", opts->fs_fmask_inv ^ 0xffff);
      if (opts->dmask)
          seq_printf(m, ",dmask=%04o", opts->fs_dmask_inv ^ 0xffff);
-    if (opts->nls)
-        seq_printf(m, ",iocharset=%s", opts->nls->charset);
-    else
-        seq_puts(m, ",iocharset=utf8");
+    if (opts->fmask)
+        seq_printf(m, ",fmask=%04o", opts->fs_fmask_inv ^ 0xffff);
      if (opts->sys_immutable)
          seq_puts(m, ",sys_immutable");
      if (opts->discard)
          seq_puts(m, ",discard");
+    if (opts->force)
+        seq_puts(m, ",force");
      if (opts->sparse)
          seq_puts(m, ",sparse");
-    if (opts->showmeta)
-        seq_puts(m, ",showmeta");
      if (opts->nohidden)
          seq_puts(m, ",nohidden");
-    if (opts->windows_names)
-        seq_puts(m, ",windows_names");
      if (opts->hide_dot_files)
          seq_puts(m, ",hide_dot_files");
-    if (opts->force)
-        seq_puts(m, ",force");
-    if (opts->prealloc)
-        seq_puts(m, ",prealloc");
+    if (opts->windows_names)
+        seq_puts(m, ",windows_names");
+    if (opts->showmeta)
+        seq_puts(m, ",showmeta");
      if (sb->s_flags & SB_POSIXACL)
          seq_puts(m, ",acl");
+    if (opts->nls)
+        seq_printf(m, ",iocharset=%s", opts->nls->charset);
+    else
+        seq_puts(m, ",iocharset=utf8");
+    if (opts->prealloc)
+        seq_puts(m, ",prealloc");
+    if (opts->nocase)
+        seq_puts(m, ",nocase");

      return 0;
  }
-- 
2.34.1

