Return-Path: <linux-fsdevel+bounces-72625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94359CFFE41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 21:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6B9D300533F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D2F33A715;
	Wed,  7 Jan 2026 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW1hwBJ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639F33893D;
	Wed,  7 Jan 2026 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795643; cv=none; b=D6NtyiJOVK6wWVAJO9zdGZbqX8sbaBiMknNWAFF0Hval2e33aWApJFokXpobSLhZ0A0mBFpJMgI70sOV4jm1AR7redKWVI7SnE260tyM+X8PoZ0nZQOODeJYnm54k7iiYrXz4SulsFD2/hBZOmo0b6QM4j2CljZ166ZIIz8h/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795643; c=relaxed/simple;
	bh=WOObDB36kX8/qufFSII94oHmtu/aTYmL2lv+jov+ZmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VniDj6Nctzy2wUzf6JpVpBzCcr6QnemOF3Qkv6A/zesGj3B1jDV4Hy2oOEoHMdjqQLx5ulaz78Ru+CPn+cUGdZRDNOjDVfidFYRdM69KgYkrFWWpiHPKsNWrvbClLZeMVMg2XpJ2NgdmR1RBf78CZnYmdp3qzNgojGiMCRgdCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hW1hwBJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B210C19425;
	Wed,  7 Jan 2026 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795643;
	bh=WOObDB36kX8/qufFSII94oHmtu/aTYmL2lv+jov+ZmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hW1hwBJ6L2Sc82JMpAHppzOF/u4ORRMdsFEbffGaAz3eHHfJ/pKGliS1vbuNkRbzA
	 CDG0x276T1iZUPAx/ygrRIZH4Z4ongqtKKs5I30tX9ZBoKHaU0UN60IWpPiQFwH1Yx
	 YnD4xds5h9wih4LxizeNZQX0+udKbN5sQ+kL24T4cOnATEi2u/MPILScUOU7iM5uq3
	 Ag6oqPji7MyCVy5Iy3bcch7Vg8AMNjtN3LkANWa2Qvch1j9kRAj7VaqPIzPZMM2FlI
	 78QF41BB4zQMokBB9HkvcZv4dZAiGaXJH3maeYsyWZ1PZxBpRnKrJv8RdbfjTDuRyF
	 fbLNJ2HT02c2A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 07 Jan 2026 09:20:12 -0500
Subject: [PATCH 4/6] gfs2: don't allow delegations to be set on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-setlease-6-19-v1-4-85f034abcc57@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=826; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WOObDB36kX8/qufFSII94oHmtu/aTYmL2lv+jov+ZmA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXmusNiNlSlsI6aV6lp0Xi1SIcHsWJueGpuTVl
 eQ6zJd8vWmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV5rrAAKCRAADmhBGVaC
 FahPEACuMe99DApaXMxkgM0GK98+vE+ljpvVbIEq2apnJZzzAfT0hyf/6gvBJNqqPgdcwGOIL1N
 Ialp+dOG1L5LZ4z/T8xu2lCmwQ5ZFZwiqyomq1SJ61zt2xGJiYKufOA6M/fn1EPifLmJM28gijH
 6U3tRVcffCpJDF0GGCvwkO1sVnIQzZDweIyiyXOv3bMIzYTidH7JgRtLOk9novnILuULmVNUmtl
 xu49xC/PrkkR9B2wto7SK2OWt4OPpTgJmpn002UwSOejzpH9MfAam6VxMQR1Jk56TID7BJZA4nJ
 EKEblKGq11SauGkJQB5Fm9inIwMzdw2Pmvj+0/z/VJhQQpjxY3UZTmNfF4ELGsHcEz9325r8ZSk
 nEUKDTf4v7IeupzNaRUmDsHgJi+mKJsc+w/PG7cR5P6NKXyG6VCmt+U4IeWPbJqzZRVBa43k8xu
 kVfYM2xu1j2OaO8ggJtf/u/50S72NZ4RW/RyFvFCxG0NMZ41hRm2BfcPeZXmL82aMXY4EyCxs9f
 J9GOEHg9Xia1+QtaJM8khb0pHiQKzSEDPiKm5F8UIZre9gbramIUQ3euPrvJugtOCf2lF4cWkSG
 MS+xHOVEAkdxuUKGpeKArHhvvJnOTHcqF0MdPMdJ4D/jaTHUsz6JO1SGGr4fxk84qJlU1KxCiFL
 /515RZqlOwF+x1w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the advent of directory leases, it's necessary to set the
->setlease() handler in directory file_operations to properly deny them.

In the "nolock" case however, there is no need to deny them.

Fixes: e6d28ebc17eb ("filelock: push the S_ISREG check down to ->setlease handlers")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/gfs2/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index b2d23c98c996553ee14f1969638e709a3d7ede1c..86376f0dbf3a553375b0064c9a1eff3bfa9651f5 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1608,6 +1608,7 @@ const struct file_operations gfs2_dir_fops = {
 	.lock		= gfs2_lock,
 	.flock		= gfs2_flock,
 	.llseek		= default_llseek,
+	.setlease	= simple_nosetlease,
 	.fop_flags	= FOP_ASYNC_LOCK,
 };
 

-- 
2.52.0


