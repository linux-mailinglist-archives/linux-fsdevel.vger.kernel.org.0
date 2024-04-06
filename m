Return-Path: <linux-fsdevel+bounces-16251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FAD89A8EA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 06:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576D51C21224
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 04:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586121BC46;
	Sat,  6 Apr 2024 04:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YyU0HWD4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496422914
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 04:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712379431; cv=none; b=GFamPpbP3wXcx/CJUlda+x72GGQB9ByF7nObyiKFN1EpxniJkTc+WK3XUSDTDCL7UYB+4Kf2yXZZuyCajuizjKDF9RcA/eroqZKwzCG+87nOfw06FYh1NJP88/rf5XnyTUfJRw32fBd4GgLSY6m5/JByTlaNWbKFjujFuw1KyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712379431; c=relaxed/simple;
	bh=sJweHKopMO47UxvxaTZOae60HH2Lz9neUc+4VRu8R0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsAIKVwoUgHaXSyeWCBmZGDywz59dm5RrpyvnVEUs728Lbsyjv94ggwLx/945PG1oHiivllYmTSFgvx7DlVDAPzRxMsDa39U/CdLdEV75yIuE22XaB0P/vpPkzz4wxtHPzcreN/qS5uriiKv2MqPhHUfiEHLGpcLeMhsLU3JHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YyU0HWD4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YLOYsjaot/pQqeiI+112iAE+LpXiTY7lGDwpSJmbOYk=; b=YyU0HWD4CJ+MUd7zhGAsj+v+Ye
	SFjOVWF/jONtVSQ7gIpb8XDzZUvecCzSW2fgjCkuWMbMU17zo941dXITFZ3a52jG8jbrxcS+QimbN
	uyQzfTDUTz4rtO/M2Ero2m69CDRU1hqlMIS/DA2L4MwXYAEgqX7IqUwmAg6IUQzWNztRRFvXwEhOv
	ilIg7M9E8rsfA6PO4entLo/UgNB5sWotpWg6MvLFOpGFdPcI/BGi/aJHhC8Mil9NyJkaGRK1YJ4ic
	/aUi63qg+7NRIqO9NLcfWaVQr4wtBsH9dGSNgKFwCa8aZqPgFvRsUYkAGvB52Y26DG6Hr/qp85irI
	SjQLSJrQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsy71-006qgo-1Q;
	Sat, 06 Apr 2024 04:57:07 +0000
Date: Sat, 6 Apr 2024 05:57:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <christian@brauner.io>
Subject: [PATCH 1/6] close_on_exec(): pass files_struct instead of fdtable
Message-ID: <20240406045707.GA1632446@ZenIV>
References: <20240406045622.GY538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406045622.GY538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

both callers are happier that way...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c               |  5 +----
 fs/proc/fd.c            |  4 +---
 include/linux/fdtable.h | 10 +++++-----
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 3b683b9101d8..eff5ce79f66a 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1219,12 +1219,9 @@ void set_close_on_exec(unsigned int fd, int flag)
 
 bool get_close_on_exec(unsigned int fd)
 {
-	struct files_struct *files = current->files;
-	struct fdtable *fdt;
 	bool res;
 	rcu_read_lock();
-	fdt = files_fdtable(files);
-	res = close_on_exec(fd, fdt);
+	res = close_on_exec(fd, current->files);
 	rcu_read_unlock();
 	return res;
 }
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 6e72e5ad42bc..0139aae19651 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -39,10 +39,8 @@ static int seq_show(struct seq_file *m, void *v)
 		spin_lock(&files->file_lock);
 		file = files_lookup_fd_locked(files, fd);
 		if (file) {
-			struct fdtable *fdt = files_fdtable(files);
-
 			f_flags = file->f_flags;
-			if (close_on_exec(fd, fdt))
+			if (close_on_exec(fd, files))
 				f_flags |= O_CLOEXEC;
 
 			get_file(file);
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 78c8326d74ae..cc060b20502b 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -33,11 +33,6 @@ struct fdtable {
 	struct rcu_head rcu;
 };
 
-static inline bool close_on_exec(unsigned int fd, const struct fdtable *fdt)
-{
-	return test_bit(fd, fdt->close_on_exec);
-}
-
 static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
 {
 	return test_bit(fd, fdt->open_fds);
@@ -107,6 +102,11 @@ struct file *lookup_fdget_rcu(unsigned int fd);
 struct file *task_lookup_fdget_rcu(struct task_struct *task, unsigned int fd);
 struct file *task_lookup_next_fdget_rcu(struct task_struct *task, unsigned int *fd);
 
+static inline bool close_on_exec(unsigned int fd, const struct files_struct *files)
+{
+	return test_bit(fd, files_fdtable(files)->close_on_exec);
+}
+
 struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
-- 
2.39.2


