Return-Path: <linux-fsdevel+bounces-52945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A92AE8A96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F875A273F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C052EB5B9;
	Wed, 25 Jun 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hG+sE3Av"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD72E9ECB
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869794; cv=none; b=OZQjF6u/RaGpYZDgpQC6RBDKaBvyfMUhuAtmEtCXkSWMdyl7SNyUsZtj0wNIck9N11UI4y/dUZxT8E0Zd/Wr/PzupxdX0RkSDGxZ1E3qkE4fEflEFI1Ug+vKgX0vlE2XYl9KVTO0vghOb9if3wXW6trLHIl9sutHt4dTxn1giUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869794; c=relaxed/simple;
	bh=AliD1klfeZmgo/JTUsJ7G3JGESX3QkE+j7pa6SVp2lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKVtOV2gVS9bQ9bgd0FZBtuXlXjPWuwEjz8/UBkI//6QxUZjczAdta6GQze5L2uGJE3fML5AL553SybVpUVsVVPvaZLDSqUJJ2ieW8Q1qh6Xsn4yvxlmTnoUdxtBsa10orDU2CKqzynqnFmJsTocRHwKrGIVqeMuGTXfEF7Q7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hG+sE3Av; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750869792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCzPzgmppSzHAEtxjqlIXf8IEb60t649a5zwc5vulFQ=;
	b=hG+sE3Av63QUau+DLHRpV6iPxBLMX09ql0POvhlJO6Mjbo1i4ve1+57T1os04DFuquXyYr
	uiXOY+sUUMGwB1cS20ct4n1B7Tt6td5epDuWRatavQvJD/XgFebjszY7SOVEm6fGrvKb5v
	2gFUvFFV6XATIzyl6P8Q7l0TkEHxrFI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-52K8xfSSOnORCP1C4Wa6QA-1; Wed,
 25 Jun 2025 12:43:10 -0400
X-MC-Unique: 52K8xfSSOnORCP1C4Wa6QA-1
X-Mimecast-MFC-AGG-ID: 52K8xfSSOnORCP1C4Wa6QA_1750869788
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21CA1180120D;
	Wed, 25 Jun 2025 16:43:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E557118003FC;
	Wed, 25 Jun 2025 16:43:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	stable@vger.kernel.org,
	Remy Monsen <monsen@monsen.cc>,
	Pierguido Lambri <plambri@redhat.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH v2 09/16] smb: client: fix regression with native SMB symlinks
Date: Wed, 25 Jun 2025 17:42:04 +0100
Message-ID: <20250625164213.1408754-10-dhowells@redhat.com>
In-Reply-To: <20250625164213.1408754-1-dhowells@redhat.com>
References: <20250625164213.1408754-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Paulo Alcantara <pc@manguebit.org>

Some users and customers reported that their backup/copy tools started
to fail when the directory being copied contained symlink targets that
the client couldn't parse - even when those symlinks weren't followed.

Fix this by allowing lstat(2) and readlink(2) to succeed even when the
client can't resolve the symlink target, restoring old behavior.

Cc: linux-cifs@vger.kernel.org
Cc: stable@vger.kernel.org
Reported-by: Remy Monsen <monsen@monsen.cc>
Closes: https://lore.kernel.org/r/CAN+tdP7y=jqw3pBndZAGjQv0ObFq8Q=+PUDHgB36HdEz9QA6FQ@mail.gmail.com
Reported-by: Pierguido Lambri <plambri@redhat.com>
Fixes: 12b466eb52d9 ("cifs: Fix creating and resolving absolute NT-style symlinks")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/smb/client/reparse.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 511611206dab..1c40e42e4d89 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -875,15 +875,8 @@ int smb2_parse_native_symlink(char **target, const char *buf, unsigned int len,
 			abs_path += sizeof("\\DosDevices\\")-1;
 		else if (strstarts(abs_path, "\\GLOBAL??\\"))
 			abs_path += sizeof("\\GLOBAL??\\")-1;
-		else {
-			/* Unhandled absolute symlink, points outside of DOS/Win32 */
-			cifs_dbg(VFS,
-				 "absolute symlink '%s' cannot be converted from NT format "
-				 "because points to unknown target\n",
-				 smb_target);
-			rc = -EIO;
-			goto out;
-		}
+		else
+			goto out_unhandled_target;
 
 		/* Sometimes path separator after \?? is double backslash */
 		if (abs_path[0] == '\\')
@@ -910,13 +903,7 @@ int smb2_parse_native_symlink(char **target, const char *buf, unsigned int len,
 			abs_path++;
 			abs_path[0] = drive_letter;
 		} else {
-			/* Unhandled absolute symlink. Report an error. */
-			cifs_dbg(VFS,
-				 "absolute symlink '%s' cannot be converted from NT format "
-				 "because points to unknown target\n",
-				 smb_target);
-			rc = -EIO;
-			goto out;
+			goto out_unhandled_target;
 		}
 
 		abs_path_len = strlen(abs_path)+1;
@@ -966,6 +953,7 @@ int smb2_parse_native_symlink(char **target, const char *buf, unsigned int len,
 		 * These paths have same format as Linux symlinks, so no
 		 * conversion is needed.
 		 */
+out_unhandled_target:
 		linux_target = smb_target;
 		smb_target = NULL;
 	}


