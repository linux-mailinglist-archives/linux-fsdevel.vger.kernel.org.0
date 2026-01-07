Return-Path: <linux-fsdevel+bounces-72626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B075CFE674
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 15:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B08AD30B3727
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CEC33B6F7;
	Wed,  7 Jan 2026 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om1avZwO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08FE335083;
	Wed,  7 Jan 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795646; cv=none; b=k+bEaLvuSuPq7suJZn8l2FelzLxbUwU+v6uPHwP6Eoo9hDaYxyo6gO7Sq+Gh2qgdegQvck7It+VjFfyzvwVr+gTzmsdWLR3hn+UGYBf/g3zI/9aPw4AAxmgR/4AaQ3O1yp1Pj4FUe8wTN9UDgoAC4iBuNf0Tt4pa12BiJNJuAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795646; c=relaxed/simple;
	bh=ds534lCWLHpMcwlbbHzQlr9A4OTNCTKxUOGRXEYJFsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YYCtGYxB95KP4eVynLt1JBPUyC+Eq1ZBSUp+vZYV0B0dzNJD+kR6vHpJXhrTsmlKQeE0LZM6UfGxf6ninB4ErpZt4UBncwW8chs+Dbnk5lMXtDsg7qt8F6rF9T8/ZsXbNPLtGhddBq16qTDtK1QB33a1sCd4urhGHuzLN16Jed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om1avZwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5187CC4CEF1;
	Wed,  7 Jan 2026 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795645;
	bh=ds534lCWLHpMcwlbbHzQlr9A4OTNCTKxUOGRXEYJFsk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Om1avZwOyGZK1QoUdSEsiJgpPi472rFu0IAN0zkdiPMzJ4BvbGzfley1DhAWnG2C3
	 G8ixMQtZRot+v/5m1M65/j82ZHMJot75PhBjzpDgvuAxf34mTGPXUspjL+4GKB0kIr
	 kGEmh5XKQtAt1CVCb6658nXe/efMrySPCMPVTWkfu0WXjz1MLfO6Lzo8gvwfT9SGOx
	 urOznDaYtVu7VGDAoU76p+ThuRL6yCjktUyRTao58HrG3PGY2X2fPOM470qZix2muR
	 EXaQwkL8xl2xUfJp+ugLsF2p2yeBLmyWCa4upLWY00jZy9e8T0kHiX9Wu2HLCLsx82
	 vLlA4XLdE9u7A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 07 Jan 2026 09:20:13 -0500
Subject: [PATCH 5/6] ceph: don't allow delegations to be set on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-setlease-6-19-v1-5-85f034abcc57@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ds534lCWLHpMcwlbbHzQlr9A4OTNCTKxUOGRXEYJFsk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXmus9It2N5iLf/AgDcoMLsotEuVTaIoiBt4fz
 bKZ8HLxxsyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV5rrAAKCRAADmhBGVaC
 FQHeD/9txKErTu2VqtOJBvCZywuVpA7nlv7Mc+Nh5b9kO1zC+TXiaR/2dUGLqVEaj5MYbwfn+Ht
 5yRd1VcJi2i1rHid8YpNOv7RZCrVcO/Mz+FnYuA0gVewTmN8agXMeAFtqt7QCaybU+0udZN/RkR
 snXrcKefpJ9N/qAVoDX/DZMuYWcJG144xBsX+/sVJMmOa+mhr7+WRfvBbObi3eQ0VymOUbEqe0r
 QYi12klOvTv6W3Q/Gwk5Ruo6SiMs3zeLsFAJAmv8scWkFdDe9ljZOdL/+BSYnRKjp21sENFkOps
 AbvtKNI5KgysVvY3+p+k+JiXsX9O+5UyVkhRjMdtcD9NLpdtfXX4OMDZ75jcujoNEPu9UH8/gxN
 GgxxZzuA9y/K60cSjgq7CohOuIeScQa224rO9fGpfo1A3gtqrz+erRgSivICligUaMi5zdoBQJ5
 Ne6fzCv6W6LwubIif9qUZv/oNtoxsw2qlSRqTtYCpHyk9R4fgxAlLIfTahfapFrvAO8POJqEjCI
 Hp9SrkxNjYgq2yxzB+/sGct0LAfr4WhzE7Su6G6fmJFeZpHP9nnmE/f2j8KPBZ6crxn6CrPrvSf
 5MXQXnMGDUZZViMBxOhhFiTo97cq8JZzdhhMjK8QaAT22o2AxgCelf/OABrLVSCy6H/FANcDjqk
 iYN6ErEMQ+lshww==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the advent of directory leases, it's necessary to set the
->setlease() handler in directory file_operations to properly deny them.

Fixes: e6d28ebc17eb ("filelock: push the S_ISREG check down to ->setlease handlers")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 86d7aa594ea99335af3e91a95c0a418fdc1b8a8a..804588524cd570078ba59bf38d2460950ca67daf 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -2214,6 +2214,7 @@ const struct file_operations ceph_dir_fops = {
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
 	.flock = ceph_flock,
+	.setlease = simple_nosetlease,
 };
 
 const struct file_operations ceph_snapdir_fops = {
@@ -2221,6 +2222,7 @@ const struct file_operations ceph_snapdir_fops = {
 	.llseek = ceph_dir_llseek,
 	.open = ceph_open,
 	.release = ceph_release,
+	.setlease = simple_nosetlease,
 };
 
 const struct inode_operations ceph_dir_iops = {

-- 
2.52.0


