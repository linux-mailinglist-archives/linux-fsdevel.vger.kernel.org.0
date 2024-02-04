Return-Path: <linux-fsdevel+bounces-10206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A73FA848A97
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE821C226AC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1843410A19;
	Sun,  4 Feb 2024 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MOvylI1s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211407494;
	Sun,  4 Feb 2024 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013064; cv=none; b=Mwefz59v8HdRyr/TXEpF8JB9wTMY2wxxjdnaSiBN3uZPrfpJ/lAyyB/q4tdjq4jTr2Sjc+3dlI5rq+8EGcJf3CNAEDthE1X2+sDY3+SrrawNPexoBYqNdogM7q3xRI/sBKTCzF2StrqPcyWSQC8yek1K3ud/wavFNlaDza658aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013064; c=relaxed/simple;
	bh=SRyqAW1bia3hA8WIBq/eWJxl2UkyBOHfh9gjJgn/9+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nl59LYbP2WLWFW/+YKCeBSaqJnpmaLZUzq4YJHisH4z7tKY2uoR6EKGHZbdNtM1SSZBMNYA0qa4m+Z8GI3URgPfGC3bJ4nTwWU/QS8il2hS6FSnnbS+T+Yq8CzlL/nt+CtC/rjDOBiGtdc66XfGB6lNODaJp5HMBcuutwa4eVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MOvylI1s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2MCHJybCgYaM+84/EVYU2f3B/ucLwt2OnRgR5X2eSlU=; b=MOvylI1sLs+VkTsnYxUlcCbdjL
	U50l+BmHsg3tffvDT9d+Smjpm0cjKfGXZSPSt3mG7t3Bb5+fFDcu84WFg+x72pucepx2+rF6GQ4Ey
	SiMfCD3rzV18SlgxemYbn0eb1WIznW5xyp4ReYtdeWxhUnBjwmUbQlf4GjbK2ev1UU7icsGP5sd+S
	GguhTeGgxzcmo4cGWHbHjDT49W1GnsR5je9PItjHESxyRME6ibDPEbNpU9UoB8MtHSFlwYrFaEf+D
	zV7qHDDsi61fysxfLLcPRSV0Uxs5QD6jzcfdWwQPhV7qMxZee2Ce+Hmm9ZPizVmc6OykF2silVbhj
	+M7GrRjw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS4j-004rDW-1V;
	Sun, 04 Feb 2024 02:17:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 10/13] procfs: make freeing proc_fs_info rcu-delayed
Date: Sun,  4 Feb 2024 02:17:36 +0000
Message-Id: <20240204021739.1157830-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

makes proc_pid_ns() safe from rcu pathwalk (put_pid_ns()
is still synchronous, but that's not a problem - it does
rcu-delay everything that needs to be)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/proc/root.c          | 2 +-
 include/linux/proc_fs.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index b55dbc70287b..06a297a27ba3 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -271,7 +271,7 @@ static void proc_kill_sb(struct super_block *sb)
 
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
-	kfree(fs_info);
+	kfree_rcu(fs_info, rcu);
 }
 
 static struct file_system_type proc_fs_type = {
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index de407e7c3b55..0b2a89854440 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -65,6 +65,7 @@ struct proc_fs_info {
 	kgid_t pid_gid;
 	enum proc_hidepid hide_pid;
 	enum proc_pidonly pidonly;
+	struct rcu_head rcu;
 };
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
-- 
2.39.2


