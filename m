Return-Path: <linux-fsdevel+bounces-72622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A137CFE74B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 16:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E378307B37F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B506C70810;
	Wed,  7 Jan 2026 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJRc65Eh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B5231A56D;
	Wed,  7 Jan 2026 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795635; cv=none; b=XzmFrpfqRlBCYk0ebf9GaI0A98ufgTZtlgqcJZwMgh/8wb+AigHwzhZNhzmypXPIYxhhieLFoJYbvFUQMvsD9ZmGhgyMPAkINDS8GrmAWc++7fBzuVFL8GqU/9XhRu93e9hsVcjJvk3Rad45NTb+IiUET7563YLJERbVM+iOEcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795635; c=relaxed/simple;
	bh=tkUtMumKw36UQhHrH7n1l5r+Vth05W6Tk5DQRZclMos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1u5fgXQistrKqRJy06xNWrE5sPqXJl4dsDoUVJQi7XwTET4auN46wEV8Tlp71bI4CBZCW/hsZZkS8klIczv3noNGonZ55pDHNzMqJ0rI3VuN/xldUXL2sqPqv1/9ryeY23H+DRuOMveGNikxJec5l1wMkqvYHaUU9Atfr37x/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJRc65Eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83829C19421;
	Wed,  7 Jan 2026 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795635;
	bh=tkUtMumKw36UQhHrH7n1l5r+Vth05W6Tk5DQRZclMos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gJRc65EhM+CoGdgtUcCCHQUHquGON7WfOakpDPhwU7kZoT6NgRkQLTzebiOgNPsih
	 Z3XFJQFUJCyOg9EB7GnFXh9keS0S5W5slW/P0fC4lrOtPk86MjEXUPhsXB8CATttmX
	 GURU0FARiG2XeRc28/+2CU8MsaGtz1J5c63hPGKUG41JCTD2fB3PrMUFUadwsC4hnk
	 lia/iyFdJXYYxfkCtORWwxPCP0bmYZauJkF6rztYEvHJAQlZTRBCdDCC3fX5v5ke0F
	 E9Hq3Dw0dyahHxZZJk/J5ZPnWSNJeWpt7hOsy5Ckx6IyY08RsTsdpYnNq4LrkHeqln
	 Rce8v60llcPJQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 07 Jan 2026 09:20:09 -0500
Subject: [PATCH 1/6] nfs: properly disallow delegation requests on
 directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-setlease-6-19-v1-1-85f034abcc57@kernel.org>
References: <20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org>
In-Reply-To: <20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Xiubo Li <xiubli@redhat.com>, 
 Ilya Dryomov <idryomov@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@infradead.org>, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, gfs2@lists.linux.dev, 
 ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tkUtMumKw36UQhHrH7n1l5r+Vth05W6Tk5DQRZclMos=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXmurGkP7toxFY3jKAO4v32OcZyFMTRKEDvXQd
 JpSxp4vRDWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV5rqwAKCRAADmhBGVaC
 FTJSEACmkBB7G9y/f0LVHuGDnP+jDnSPBvak4kEVurnaE4ki+rPuNqZGlb1a+7g8Af8qaX8ACA7
 sqgMNm5XxSfVFllZlRnfavXfkL6BoLncqs/nuMOBdwElX5nDGgDAIg8A7npclylIY/WhLN+cRMH
 7wqNux4Id5LrlkRSG/EyakGtWyYh3U9kjyS7YhMY/6fQ0FohvSl0jNexT3tJ7hLRa/SEKaGK/TR
 jmrSPP54QdLwrdYNl5UMc0X3ovBaL1rerOLecg0e+NgsHzcht7KitusEW27w6zNNeqn8Nwk2ZjD
 0rz8AXXPouQiJYD/6uZaVsNU2Dsp5uOab7Bej/STcGp0+kd5+0cZoeGG000asDvqCam/rzMVBWk
 RLtIAOA5uTm8FrMbnXmpL2nbms3rr3fKuM+k4KyylXlePhkn9USlvvL6vZxJncFIF+yTGth7kZR
 eeBqe4ME9WtvuGu483hUgIJ2Ec0uFhI2brGjxZ7AtNvckuh2KNaWplOk9wCQmcs8pPHYgH644q6
 9r9q5Vnn3j4mEqrgQ6yIUz1+VX/JC54vtU+T/xkUbWKjbLfXhRsYjqHwLJzCTQ3bbLIBtHNg45j
 BMqUWzcsgr+gw7a6bxSVsPSTsU1bJRbeKCAiBjPQA+4w0euocCsWD1xkrvUz6sV1SyVb0q5C2jZ
 ppEXuUmMIS4hNHQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Checking for S_ISREG() in nfs4_setlease() is incorrect, since that op is
never called for directories. The right way to deny lease requests on
directories is to set the ->setlease() operation to simple_nosetlease()
in the directory file_operations.

Fixes: e6d28ebc17eb ("filelock: push the S_ISREG check down to ->setlease handlers")
Reported-by: Christoph Hellwig <hch@infradead.org>
Closes: https://lore.kernel.org/linux-fsdevel/aV316LhsVSl0n9-E@infradead.org/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/dir.c      | 1 +
 fs/nfs/nfs4file.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 23a78a742b619dea8b76ddf28f4f59a1c8a015e2..71df279febf797880ded19e45528c3df4cea2dde 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -66,6 +66,7 @@ const struct file_operations nfs_dir_operations = {
 	.open		= nfs_opendir,
 	.release	= nfs_closedir,
 	.fsync		= nfs_fsync_dir,
+	.setlease	= simple_nosetlease,
 };
 
 const struct address_space_operations nfs_dir_aops = {
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 7317f26892c5782a39660cae87ec1afea24e36c0..7f43e890d3564a000dab9365048a3e17dc96395c 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -431,8 +431,6 @@ void nfs42_ssc_unregister_ops(void)
 static int nfs4_setlease(struct file *file, int arg, struct file_lease **lease,
 			 void **priv)
 {
-	if (!S_ISREG(file_inode(file)->i_mode))
-		return -EINVAL;
 	return nfs4_proc_setlease(file, arg, lease, priv);
 }
 

-- 
2.52.0


