Return-Path: <linux-fsdevel+bounces-72624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5403CFFE3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 21:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F239300898F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A03D337BA2;
	Wed,  7 Jan 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMaMO7WG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1291337686;
	Wed,  7 Jan 2026 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795640; cv=none; b=aFSnDuFCG32ptQvX9ly945G0HZl7h9TsnwMZvrMiuKXkLiPlu8aR8+x1gQLnoZA5Shvx70oNZzo8+0O69UnL/+xv89WC/ZqxwXmmJsPSeC/6TvJotzfWc6tzbVfU9rRd4WfOX4lOzEOiYiu/snRcwDXKFLMsQdfsCsnu4b4gl4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795640; c=relaxed/simple;
	bh=kEkvQ9NQX8PYeQ1rYCmj8d2YBAwnJXpHvKctygKYYLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RlKZHnTKjHDQ3k8wjwphXY+zubDxqADSjAN7UzTl2wFC139KSX/HzQleaoOvGbXp0nv/U6KhJLs2hyl3LAtMw++WwD5geaxaQR0alDMNPG60Gmk/G9+8PuIED8mfmPI3uSVSp9m8evQe/KLcpip8NRLZCgSOpbkTM9jshQY0GzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMaMO7WG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4211C19421;
	Wed,  7 Jan 2026 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795640;
	bh=kEkvQ9NQX8PYeQ1rYCmj8d2YBAwnJXpHvKctygKYYLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tMaMO7WG6JQhtw/hjE2heFOQVqZg8m9u5mOJk8GHSYuYqtLXGFT+QUckJbHV9GTXF
	 l1+IH9jE2kxotMlq1CFMLvL2S25sDzp3RZt+YMmAXgRz4TcNIKLlJBXPQoVjUwJHtq
	 dfdr8JNozaLjMuivAvuKpg4DY14hkbMXeB88vuHJB1RiJqGCCfnWy2u9D6Gc7NYj21
	 2Pf2No971PU+wx5L4w1tPzsWIx9TS0cZRGxFcdIxPakokvkm5+I5PGCqDoaaq1bFW9
	 XuVxHaNAqOkASACOpIW7FDhKCIjqatsbuzvfse+v6YsX4Qp8Ixx9gfrQyPxG34gewd
	 63LbQMsYkLMTQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 07 Jan 2026 09:20:11 -0500
Subject: [PATCH 3/6] 9p: don't allow delegations to be set on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-setlease-6-19-v1-3-85f034abcc57@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kEkvQ9NQX8PYeQ1rYCmj8d2YBAwnJXpHvKctygKYYLE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXmusFABXCuzBzy1mQmp7JWrenTQAfrgA1JQp8
 OqxhqtVIYKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV5rrAAKCRAADmhBGVaC
 FTfjD/wNogu8cq8DRl9tjq+zSkAMYAM++zEaDaPvKxwfExuQJ4iUCAvP+ZMG14K799qKk6rnzyD
 GGcpO7zJtgg5d3Ae2B/4I8tXitDrgsiiBUsisxdmWzkG3QT344FwzDRaLCpAndlEjvew4rc6jwg
 5hog3xLPo+RJv9f9D9Q+YiHP6G0hkn3uI1P+Kh2MAErNM1w2F0EjOGKoFbW+WWCkGVTYo6hiE6Y
 VWXWVY359KrHGq9TYZAPJO3kBWGxwqtvTkV8OA3nAiP2a4trCbFxgi/Cn1lsfF2vrl7HuEGXvlI
 J9JEOD2ZUy3l9xajY89qg6Us3nS/E6S/9BL3AR6YTslqBc3g4TWd7u8E4OXDajuyZNS5WPfbtES
 cGl76WgXitBQ6ScvKAz7I3/op6aeqZnwl+vWGPGkku5BEMP/9u/Pns/4BW38JGmd9rJv6fgpw75
 l4noDgGaBUZjPbvhtpCNu266GcIuZjREGxHbT42mbJcQCf9BhH4QjebrGYFc4XiTLtiL12sG2Lb
 wiH2A/Fkb2GgRXQnVd2oTcEpx0aPAu09Mqn0E3yNJzghCU3QTKYyFy/ILBaVyuvOujsdc39z/Pl
 UGcD39cVDUmjcL4fYoti+ZQL6IKnhUk7iTWzkzSor+aGy7ihb0B4sAOhHlGDXXsqeJuePcbfp/v
 ACInyCk/xwIXBGA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the advent of directory leases, it's necessary to set the
->setlease() handler in directory file_operations to properly deny them.

Fixes: e6d28ebc17eb ("filelock: push the S_ISREG check down to ->setlease handlers")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/9p/vfs_dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076e3b1a6c5ed07a3e009a50c9fa2a9..af7f72abbb76aaff934b80d4002f32e3b0d17b6d 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -242,6 +242,7 @@ const struct file_operations v9fs_dir_operations = {
 	.iterate_shared = v9fs_dir_readdir,
 	.open = v9fs_file_open,
 	.release = v9fs_dir_release,
+	.setlease = simple_nosetlease,
 };
 
 const struct file_operations v9fs_dir_operations_dotl = {
@@ -251,4 +252,5 @@ const struct file_operations v9fs_dir_operations_dotl = {
 	.open = v9fs_file_open,
 	.release = v9fs_dir_release,
 	.fsync = v9fs_file_fsync_dotl,
+	.setlease = simple_nosetlease,
 };

-- 
2.52.0


