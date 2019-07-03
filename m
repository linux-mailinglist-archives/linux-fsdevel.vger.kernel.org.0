Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 192A35E46A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 14:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfGCMrd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 08:47:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38380 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCMrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:47:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so2669592wro.5;
        Wed, 03 Jul 2019 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qXfAEOlH4aIpQXeFgILadkKYn01/VlG4XvVZEcPkJYY=;
        b=fu9RPMVgXVFj4PgV3KF4+X0OrajMT8XRxnmdpd+teMNXTQldmYy+3On3v8YbjNRcoh
         y8pu8JWKMBygejEkjCVH3FFo7TeUWFChx553OzBSnX7wB17SO+47EMJ25asq7QkekJRS
         lEmerh2nRBiytWP6hWYZoku/WlMGJmLTtXi4MAqZ+3BWzctnGkUN5K92UzspI6a0gvCe
         w2s98oiKc0aK9YThQsqY+9Mx/Fd0CP0NKNqfxWpVjuW191RQYzyMeInreFxiLzqT8ZB2
         +WGt3/jdTI/5XUXWLMgohdHyulxJeidi4kLtVf6eg5Z9CewOrJyC/2f3DLPzGUQQI0gM
         tXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qXfAEOlH4aIpQXeFgILadkKYn01/VlG4XvVZEcPkJYY=;
        b=k0U3aESoKtWqiIQMY6rxjgd7/jHC1QoEnH9934TBVkPRinVnvQqKwV/KD/+vIfCoYb
         0rXVFjZyTdizShANKG4wVTbHBVHt4uKJynB9yFvfUkSjR6xbCiDsbgcIZIXtca/xx7kC
         KJ0OhH7hyz04Vbi0WxwTJlL37mAvc+ptRn8FushRsDqW/7xFLIASmEcx+hyJh7Zr40iX
         vnGQTIAqbKwvy4K4rYrbk2vB/YjbV1jIrbBU7tpjARbK4AZP6ufPQCpLeL1OeC7FFy9s
         dRvYy9iVn8fEpK/YEdnZZCkG5JzfbAi8nF+et1vNKKm74/0zPJrAjAP0DIkGqaD1avgb
         3qmw==
X-Gm-Message-State: APjAAAUH2rD5XV19NwrwPUCDanWzQd1qyCeXAfZk4IDcg1RavfWAHRQq
        p+mr/ziGpY/zYHmD1HSsGg9ETkkBAmo=
X-Google-Smtp-Source: APXvYqxD6K+0ugAMNC/aj/0XoFB4rhxYFEfIRruIudKKenQi9Fn9L+MVPP9fnwZ3jnR+ZtZPVdDKtA==
X-Received: by 2002:a5d:5186:: with SMTP id k6mr31267862wrv.30.1562158050417;
        Wed, 03 Jul 2019 05:47:30 -0700 (PDT)
Received: from heron.blarg.de (p200300DC6F443A000000000000000FD2.dip0.t-ipconnect.de. [2003:dc:6f44:3a00::fd2])
        by smtp.gmail.com with ESMTPSA id o24sm5480588wmh.2.2019.07.03.05.47.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 05:47:29 -0700 (PDT)
From:   Max Kellermann <max.kellermann@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com, bfields@redhat.com,
        gregkh@linuxfoundation.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, hughd@google.com,
        anna.schumaker@netapp.com
Cc:     linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@gmail.com>
Subject: [PATCH 4/4] nfs/super: check NFS_CAP_ACLS instead of the NFS version
Date:   Wed,  3 Jul 2019 14:47:15 +0200
Message-Id: <20190703124715.4319-4-max.kellermann@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703124715.4319-1-max.kellermann@gmail.com>
References: <20190703124715.4319-1-max.kellermann@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This sets MS_POSIXACL only if ACL support is really enabled, instead
of always setting MS_POSIXACL if the NFS protocol version
theoretically supports ACL.

The code comment says "We will [apply the umask] ourselves", but that
happens in posix_acl_create() only if the kernel has POSIX ACL
support.  Without it, posix_acl_create() is an empty dummy function.

So let's not pretend we will apply the umask if we can already know
that we will never.

This fixes a problem where the umask is always ignored in the NFS
client when compiled without CONFIG_FS_POSIX_ACL.  This is a 4 year
old regression caused by commit 013cdf1088d723 which itself was not
completely wrong, but failed to consider all the side effects by
misdesigned VFS code.

Signed-off-by: Max Kellermann <max.kellermann@gmail.com>
---
 fs/nfs/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index c27ac96a95bd..e799296941ec 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2343,11 +2343,14 @@ void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *mount_info)
 	if (data && data->bsize)
 		sb->s_blocksize = nfs_block_size(data->bsize, &sb->s_blocksize_bits);
 
-	if (server->nfs_client->rpc_ops->version != 2) {
+	if (NFS_SB(sb)->caps & NFS_CAP_ACLS) {
 		/* The VFS shouldn't apply the umask to mode bits. We will do
 		 * so ourselves when necessary.
 		 */
 		sb->s_flags |= SB_POSIXACL;
+	}
+
+	if (server->nfs_client->rpc_ops->version != 2) {
 		sb->s_time_gran = 1;
 		sb->s_export_op = &nfs_export_ops;
 	}
@@ -2373,7 +2376,7 @@ static void nfs_clone_super(struct super_block *sb,
 	sb->s_time_gran = 1;
 	sb->s_export_op = old_sb->s_export_op;
 
-	if (server->nfs_client->rpc_ops->version != 2) {
+	if (NFS_SB(sb)->caps & NFS_CAP_ACLS) {
 		/* The VFS shouldn't apply the umask to mode bits. We will do
 		 * so ourselves when necessary.
 		 */
-- 
2.20.1

