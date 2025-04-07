Return-Path: <linux-fsdevel+bounces-45849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C82FA7DA63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B2B3AF830
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 09:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05E923315D;
	Mon,  7 Apr 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRmGVPbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA3B232786;
	Mon,  7 Apr 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019684; cv=none; b=LU/5d5JT4Fb+aocDggOjMJia/zKkeKkGZNH0yHKdThUmnhezcgXlL2F+KWk0EAfTCz51v6Qakq1hl9KyJKorAnqg3qgP6zsJzh8QuLsToLLOQ1EShnQfxi7bC3VaPdjU2WMP7y7nc5vEWF1LTWEdtyInLWIZNw9xDcT/GuzGWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019684; c=relaxed/simple;
	bh=J9CHe/ahjfMP60lzB1vrs6byIhUwN+MUGzR6IctlP3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NYZr1J8bHRkYbr8pxuI70iRUoV9F9MwXiK6pNPbWIX5Ef9Ov5B4oFrdjPLNDvm1iaihGqiJ1HRXZRratlO+hC/xyqirwe430zr6A2YZkoCM3K4ffkqr7/wJUolbPAXg0fOEAYkq01JGbfwYmOlwXni8g2REqircxs30IauMp+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRmGVPbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591FCC4CEEB;
	Mon,  7 Apr 2025 09:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744019684;
	bh=J9CHe/ahjfMP60lzB1vrs6byIhUwN+MUGzR6IctlP3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CRmGVPbzsmR8c0WDAXBhWRKvZ4AyZIU7RvO5V6w9Ir5DQ2PGZaitf+NxLKFIVESpH
	 P/qwNC88gLCc73CFF1fdeHbRcPcvOqcx/bSpQxX2/JZLwJGFZrh/mgMRHIkz69Y8wC
	 pkRtGJfZjugLLvuLd+1llp2OS/ay8on2mDxl8+FlXheYlae2juo9qNLJL+JPI2Vcpg
	 BwEtgTSbgeKVxsP+VK6CW23TKK3A5H1N6EEYxgOTFbBjluOTyaN0DfLTxluWSd9+Vr
	 xhUMio69R0Hpx22VU4YJGLe5MQqNZyArkUOPJo2VCheM0cNSpucUR9z4YicTh0yzr8
	 Reatp/CGf0QMQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 07 Apr 2025 11:54:17 +0200
Subject: [PATCH 3/9] anon_inode: explicitly block ->setattr()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-work-anon_inode-v1-3-53a44c20d44e@kernel.org>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
In-Reply-To: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, 
 Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
 Christian Brauner <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371; i=brauner@kernel.org;
 h=from:subject:message-id; bh=J9CHe/ahjfMP60lzB1vrs6byIhUwN+MUGzR6IctlP3g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/XnA9ekLCJPMqtqDupxwf9S/Nr584f4/c76f/f1kWf
 P+6Li1uQ0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBETnUy/OGNufpEfov+yiif
 ln07PyU+PL/QzU9hYuhZ/fshT316zLYx/A+c7hqncPDrF5EM7RMszzr7n+yZOO9EeC/juaSke/q
 a9twA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It is currently possible to change the mode and owner of the single
anonymous inode in the kernel:

int main(int argc, char *argv[])
{
        int ret, sfd;
        sigset_t mask;
        struct signalfd_siginfo fdsi;

        sigemptyset(&mask);
        sigaddset(&mask, SIGINT);
        sigaddset(&mask, SIGQUIT);

        ret = sigprocmask(SIG_BLOCK, &mask, NULL);
        if (ret < 0)
                _exit(1);

        sfd = signalfd(-1, &mask, 0);
        if (sfd < 0)
                _exit(2);

        ret = fchown(sfd, 5555, 5555);
        if (ret < 0)
                _exit(3);

        ret = fchmod(sfd, 0777);
        if (ret < 0)
                _exit(3);

        _exit(4);
}

This is a bug. It's not really a meaningful one because anonymous inodes
don't really figure into path lookup and they cannot be reopened via
/proc/<pid>/fd/<nr> and can't be used for lookup itself. So they can
only ever serve as direct references.

But it is still completely bogus to allow the mode and ownership or any
of the properties of the anonymous inode to be changed. Block this!

Cc: <stable@vger.kernel.org> # all LTS kernels
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/anon_inodes.c | 7 +++++++
 fs/internal.h    | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 42e4b9c34f89..cb51a90bece0 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -57,8 +57,15 @@ int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return 0;
 }
 
+int anon_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		       struct iattr *attr)
+{
+	return -EOPNOTSUPP;
+}
+
 static const struct inode_operations anon_inode_operations = {
 	.getattr = anon_inode_getattr,
+	.setattr = anon_inode_setattr,
 };
 
 /*
diff --git a/fs/internal.h b/fs/internal.h
index 717dc9eb6185..f545400ce607 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -346,3 +346,5 @@ int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, bool uid_
 int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
 		       struct kstat *stat, u32 request_mask,
 		       unsigned int query_flags);
+int anon_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		       struct iattr *attr);

-- 
2.47.2


