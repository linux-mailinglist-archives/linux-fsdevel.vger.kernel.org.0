Return-Path: <linux-fsdevel+bounces-72627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0F4CFE5FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 15:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B14BD3002153
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCCB33BBD4;
	Wed,  7 Jan 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYpAl51z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50F0330337;
	Wed,  7 Jan 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795649; cv=none; b=lDrAvATduEH2Dmo5BqYxe6FlZIg++2QkzJkyWkq8UODfB2xxtKU0cMe7BY7GO3lJh5SGmuavCvQpUnef7Uh8ZBV4Ub23eb6ooQswWsH+2RAzTEQSmiJYjZDW2PRCeCcQSLKg8QZLH/olTEfnsUkqyRe3MwokKwbuL9nT9WCfZuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795649; c=relaxed/simple;
	bh=swYePiPcFodsDh/67E0j7LPYSSE9pk5yCYXqd+3XH2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tIOvyb6T9JkIWnK2R9YPqo8Pg2TiYxzVUn3yrJ2voEPeI4DRk8xlsFVifZhwDAZeduACyFjyB4lmzl2mLG5o0xTGL084Y1niZ0dHSNX13Ls4oPj+GQkZdCM3Wjlizfb8Jyk+EKtdbdiSnZlzOp2rFYLmh9i71fpIQGSa9hgByMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYpAl51z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BB6C4CEF7;
	Wed,  7 Jan 2026 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795648;
	bh=swYePiPcFodsDh/67E0j7LPYSSE9pk5yCYXqd+3XH2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AYpAl51zYcKM5SOyIjkH+SRS+s1SgwbK+zEYQJ3vsaYluDtz4qEDKpTsvxJhEXyYG
	 UTSnn8T72uZwqIsFSSzWJpg7dyR9Ud+wjulGfX/BNnsSyQN5VqxkjvEzhOPn3xBvdS
	 LCMFm8wgeJZkQ0wLlBejx6ZpSrSAlxbbusu4Shito0wZh5nQNt/BK383ps9t+ivcoy
	 L8kbTGLPioQrGce25s9TlBD5CG9ZzO6VdZc7ulMRWtDD+/YBXOwhshvwLOZ28qOt0H
	 BruLv4TMRys0iitPAaeXQMTLHu+22xZ12Cobm2cGS5HYrIfGgDLaMRR01oocXXlv2H
	 gwgtatvghwDAg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 07 Jan 2026 09:20:14 -0500
Subject: [PATCH 6/6] vboxsf: don't allow delegations to be set on
 directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-setlease-6-19-v1-6-85f034abcc57@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=759; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=swYePiPcFodsDh/67E0j7LPYSSE9pk5yCYXqd+3XH2Y=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXmut4DdA0I/BS+hpNDcLM7DVrBk7ZZAAPZ+Zf
 eiWHvcBVXqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV5rrQAKCRAADmhBGVaC
 FQvRD/sHAd32Qf+FYYgxkOBSMrFu4x01VAu/CLJP7DaLx3Xn+Dv7QzwmKIVmYCMtXyFOxudfC8d
 0/BRqz6PP8PrWIBv5t3/l82lbaOo2STYUwHroFqZyapkFfE3L91jt84YXiW59+896fVi+QUgKwK
 25palCrATUG2xnKiUZZplJU9lXM62SDdqGM5DTVVvdEY0lwIi9fnv5eLDWr1NXBqFhJoxX4oh57
 m6wxwDen/kPliwyNVHTNAT7djbqx4ldSz3C+CUaFplPlbh3L6KChKePwFXIo+4VC2UUv5Sdt1FP
 XBg16+mvp1o4LBlXH/CBTXcQz6/9KV0KouDjeMx2TXaqyawt+0Y5jYrH54EaZxIaEJGCn+EjbtO
 UajPiRYeCzAbSdZrtPa5ZRlFAl9Xq7Q/8hyB9+kHKcxF1xRt0uD32QQd0Vw/vx73njrWMml//qB
 ysVrjW5ZuhjRPbMmrqv/MNoPVZlRtCshC8RRTAD/adxKsAEIN4x2dQX0Ffcb8r4MVxzF1XcZeeu
 wW7pqzU7lgPfsaapcTDth0br9AAubLK1XZkgzhivEL0lxl+lzHEkyIcpOuqns+SO8FtTVyJpUoY
 IHKx4DSCl2GAL2qiCalTXVkr7WyaOgB5itY2mwVEBaKxnHyV/MvdPFoVxkqxeAWKLL+HKSJVNYS
 hxfwPgeRb504faQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the advent of directory leases, it's necessary to set the
->setlease() handler in directory file_operations to properly deny them.

Fixes: e6d28ebc17eb ("filelock: push the S_ISREG check down to ->setlease handlers")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/vboxsf/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 42bedc4ec7af7709c564a7174805d185ce86f854..230d7589d15cc98f6bc7e930ba40ca5f7dbf7e18 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -186,6 +186,7 @@ const struct file_operations vboxsf_dir_fops = {
 	.release = vboxsf_dir_release,
 	.read = generic_read_dir,
 	.llseek = generic_file_llseek,
+	.setlease = simple_nosetlease,
 };
 
 /*

-- 
2.52.0


