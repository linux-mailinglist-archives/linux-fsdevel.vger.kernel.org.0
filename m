Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7BD5B5E68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiILQkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 12:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiILQkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:40:04 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5DD12D2D;
        Mon, 12 Sep 2022 09:40:02 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 3E1B22265;
        Mon, 12 Sep 2022 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1663000681;
        bh=1a2OBAbi4gKtku0aJDgWDysekTB5Toxc3MphEpcWgNc=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=E3UEcihC8pWHCDEEyN7d0HGaU1D2sJsQWeRwNydtJWpquUk4p+0bupa+SuVnnRw5W
         MVIcT+q7zUmTmeTg4Q+98d6lNoHzW9ghJlxjZOFS0wtQkxR2OondqQoALL1WaTWLKq
         AhgH+1HPsSB8IgdWZGDs2f4J+2ejgritX6L7RXqI=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 12 Sep 2022 19:40:00 +0300
Message-ID: <1194d7b9-658f-b724-93d4-2f2b02b569ca@paragon-software.com>
Date:   Mon, 12 Sep 2022 19:40:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 2/3] fs/ntfs3: Add hidedotfiles option
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <59960918-0adb-6d53-2d77-8172e666bf40@paragon-software.com>
In-Reply-To: <59960918-0adb-6d53-2d77-8172e666bf40@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With this option all files with filename[0] == '.'
will have FILE_ATTRIBUTE_HIDDEN attribute.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/inode.c   | 4 ++++
  fs/ntfs3/ntfs_fs.h | 1 +
  fs/ntfs3/super.c   | 5 +++++
  3 files changed, 10 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 51363d4e8636..40b8565815a2 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1257,6 +1257,10 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
  		fa = FILE_ATTRIBUTE_ARCHIVE;
  	}
  
+	/* If option "hidedotfiles" then set hidden attribute for dot files. */
+	if (sbi->options->hide_dot_files && name->name[0] == '.')
+		fa |= FILE_ATTRIBUTE_HIDDEN;
+
  	if (!(mode & 0222))
  		fa |= FILE_ATTRIBUTE_READONLY;
  
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 2c791222c4e2..cd680ada50ab 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -97,6 +97,7 @@ struct ntfs_mount_options {
  	unsigned sparse : 1; /* Create sparse files. */
  	unsigned showmeta : 1; /* Show meta files. */
  	unsigned nohidden : 1; /* Do not show hidden files. */
+	unsigned hide_dot_files : 1; /* Set hidden flag on dot files. */
  	unsigned force : 1; /* RW mount dirty volume. */
  	unsigned noacsrules : 1; /* Exclude acs rules. */
  	unsigned prealloc : 1; /* Preallocate space when file is growing. */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 86ff55133faf..067a0e9cf590 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -247,6 +247,7 @@ enum Opt {
  	Opt_force,
  	Opt_sparse,
  	Opt_nohidden,
+	Opt_hide_dot_files,
  	Opt_showmeta,
  	Opt_acl,
  	Opt_iocharset,
@@ -266,6 +267,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
  	fsparam_flag_no("force",		Opt_force),
  	fsparam_flag_no("sparse",		Opt_sparse),
  	fsparam_flag_no("hidden",		Opt_nohidden),
+	fsparam_flag_no("hidedotfiles",		Opt_hide_dot_files),
  	fsparam_flag_no("acl",			Opt_acl),
  	fsparam_flag_no("showmeta",		Opt_showmeta),
  	fsparam_flag_no("prealloc",		Opt_prealloc),
@@ -357,6 +359,9 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
  	case Opt_nohidden:
  		opts->nohidden = result.negated ? 1 : 0;
  		break;
+	case Opt_hide_dot_files:
+		opts->hide_dot_files = result.negated ? 1 : 0;
+		break;
  	case Opt_acl:
  		if (!result.negated)
  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
-- 
2.37.0


