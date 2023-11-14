Return-Path: <linux-fsdevel+bounces-2820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B96D67EACB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 10:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9861C209FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE1168CF;
	Tue, 14 Nov 2023 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrtfkLH7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0D3168A5;
	Tue, 14 Nov 2023 09:12:51 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C50CDD;
	Tue, 14 Nov 2023 01:12:50 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc53d0030fso41769675ad.0;
        Tue, 14 Nov 2023 01:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699953170; x=1700557970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=58xYPyrF3qvTiCYCxLLJyLJdfQPrc9Z3bl/acJdiQZw=;
        b=OrtfkLH7hEAc4RfLguOdLgmdO1A91Y4Ot5/5BcJzCdlDpBFZbni3OoBuOVks5e60Ud
         u+u6j3QLB4ZTc721RWSU5qJx2Y+AO54wrR95YVOswrf0GuRFmjogTx8fdMIlcPJZcLRz
         HiuRT9DYPQ/eNFErXi+n6nQFV6TLtAmZ0aLAdmev8AojfiNjt9kvFFbCF8PCsYRaIUHF
         JKztQX0qw19TlVwUrMXfI2nFL2gzwJ2mJtsNTmH43Icr/06rmZls5jsyo9OPLiklwlJc
         hbtW3mBhMNmwtiN7ffz8fl0HGA949j7A2Dfzgqy8k2YM4MBwDnyGOzAkJgyktE4CWWqx
         +13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699953170; x=1700557970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58xYPyrF3qvTiCYCxLLJyLJdfQPrc9Z3bl/acJdiQZw=;
        b=fHf4hvPBlSVNItfTg8lXGHFLTL5U6BuHKGWPLuBds4JRWlPPoKHAiVJXEt+xXRFKQa
         3YeT4V9aVvD7QluZTSoTzXUWys0X07pLnNgJ2l4lDuE48J54Czz1re+zJAlhcbyQlcWJ
         ihpQJcLfEXYLqcchq4+742+B3H0aXNhPKE44idPZ+5JX0N9/Lg5pbjLpGUIbeclXqyWI
         T47n6ptUeXhdxujzwgHhxCraNrBbdIglTQRBnHcJ5uzpop4puwYd9XMELGXTxOwPHcKi
         B8eQeIcqqcwqr52DibMHLBrDwJSRo7d5LM6Rj8zbAOBOUkr0polubIux0Eywx198ebYy
         5DlQ==
X-Gm-Message-State: AOJu0YzSqAPfJiKkv6m4yzZY413j1ve3JDmnuc268B/4d6H0NL49sqO4
	9SUpjcJMkwL9S69TCb1hMrX+zza6n0khIg==
X-Google-Smtp-Source: AGHT+IFKn5h6y2TGrLqgTXyzZUSZ6HnULwzDYmsVuNEooE7rtGUDc7HazuhE/xyzOZNnv9s3PadmNw==
X-Received: by 2002:a17:902:6845:b0:1c9:dba6:417a with SMTP id f5-20020a170902684500b001c9dba6417amr2341713pln.9.1699953169712;
        Tue, 14 Nov 2023 01:12:49 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902c94400b001c61afa7009sm5258663pla.114.2023.11.14.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 01:12:49 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 7AA3B10206E62; Tue, 14 Nov 2023 16:12:46 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux KVM <kvm@vger.kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] fs: anon-inode: Prepend blank line separator to anon_inode_create_getfile() reasons list
Date: Tue, 14 Nov 2023 16:12:43 +0700
Message-ID: <20231114091243.32789-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=bagasdotme@gmail.com; h=from:subject; bh=VoxbFqKsb8UnObxPXwHrDuAI+PHAf+lBOWP8cTZ4neU=; b=kA0DAAoW9rmJSVVRTqMByyZiAGVTOWqjx1y6YRl+6RlRTeU0KIT+8B+nGngH5J5CUDWtSGHXj Ih1BAAWCgAdFiEEkmEOgsu6MhTQh61B9rmJSVVRTqMFAmVTOWoACgkQ9rmJSVVRTqOwKAD9ED/d tQzybUPKOmJhtYDjPeD5TeENGuYCW8hYQgsdlzQA/A5IIESPBedF8CU884M/aX+krg+BlmXglDV cDnHlN34E
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reported htmldocs warning when merging kvm tree:

Documentation/filesystems/api-summary:74: fs/anon_inodes.c:167: ERROR: Unexpected indentation.
Documentation/filesystems/api-summary:74: fs/anon_inodes.c:168: WARNING: Block quote ends without a blank line; unexpected unindent.

Fix them by prepending blank line separator to reasons list of
anon_inode_create_getfile() to render the list with correct items.

Fixes: e4c866e72563ed ("fs: Rename anon_inode_getfile_secure() and anon_inode_getfd_secure()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20231114141326.38a3dcd4@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/anon_inodes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index e02f4e2e2ecede..c9c02fc3bd0176 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -163,6 +163,7 @@ EXPORT_SYMBOL_GPL(anon_inode_getfile);
  *
  * Create a new anonymous inode and file pair.  This can be done for two
  * reasons:
+ *
  * - for the inode to have its own security context, so that LSMs can enforce
  *   policy on the inode's creation;
  * - if the caller needs a unique inode, for example in order to customize

base-commit: de7a3ded67802c419736e63f939d58fe7efcc9bd
-- 
An old man doll... just what I always wanted! - Clara


