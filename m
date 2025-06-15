Return-Path: <linux-fsdevel+bounces-51678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309C6ADA070
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 02:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649093B4525
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 00:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5242E659;
	Sun, 15 Jun 2025 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KiNwADhi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2633C28EB;
	Sun, 15 Jun 2025 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749948442; cv=none; b=EgNRh0Fq8sUsKQqLka28ww13KdulGwOlXvMC3HNQUzfk/WOU5qi8OAcz68FEd2LUw+gvAuL9wb6Eer93ydWIXobJ+LjBxTRtMoyhVkSltZG76sizC0xpSUO3+gBai9bBFCPYaR/VIQNfyHFRBOypBMGdJ3pmuoOuDDsZY+C9dKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749948442; c=relaxed/simple;
	bh=PTAC1rmoxxqDtDPyZ9wFnHW3Rmw7wCFiU51TtUkhBqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlPHioeZ526CITRZXHsrPEnFRK468EbSB3bkY8rumJz/hxhx6TfSaPeq6T1pATeELoTy/vmVFSRvnfQfg28+R9KXeWn2ZUcuVmNVoOMYXox2EBYVX6D/2Uw1Dl/WxRglHt+lvQFfQM6zsx8r00DAA3TRBQ95lykUNcxsXrG7odQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KiNwADhi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RAkhQVDjAssyyIalBm4YtnfniE7oZf/ItqEztDaO6MU=; b=KiNwADhilk2jl6QODvMeJVWZ7j
	hvrxxp8HJy0MOOZ9o+H9JDYI44HM6RjejuecLgRU7pbtm0B+obDnz5RUOdBXbSmiItU5b/zOZlurQ
	G6LbVovOBe97eWNznBmzmENgrwoLW1xRoPrdFO9fIaf6WsmUFLyksLOFw/x24aIUchujP6eaZ12ya
	FNT1j2aE5DhJSYgA2LqmpSRpCSvQL0ZcHhXMhrM4GoRMx2QzV8ugCrmJ0vKCs66BEjI1yj3RyZ9iL
	Sd7FADhWgrCFUWTNUd7gQhkKNvzqvaVZ8B3f7ROo6XdYZGUB3NYQI7sMwcMuohDHmZKnNoyGDu3zl
	/lrRSI6A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQbWp-0000000CoVX-1S8m;
	Sun, 15 Jun 2025 00:47:19 +0000
Date: Sun, 15 Jun 2025 01:47:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org
Subject: [bpf_iter] get rid of redundant 3rd argument of prepare_seq_file()
Message-ID: <20250615004719.GE3011112@ZenIV>
References: <20250615003011.GD1880847@ZenIV>
 <20250615003110.GA3011112@ZenIV>
 <20250615003216.GB3011112@ZenIV>
 <20250615003321.GC3011112@ZenIV>
 <20250615003507.GD3011112@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615003507.GD3011112@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[don't really care which tree that goes through; right now it's
in viro/vfs.git #work.misc, but if somebody prefers to grab it
through a different tree, just say so]
always equal to __get_seq_info(2nd argument)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/bpf/bpf_iter.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 380e9a7cac75..303ab1f42d3a 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -38,8 +38,7 @@ static DEFINE_MUTEX(link_mutex);
 /* incremented on every opened seq_file */
 static atomic64_t session_id;
 
-static int prepare_seq_file(struct file *file, struct bpf_iter_link *link,
-			    const struct bpf_iter_seq_info *seq_info);
+static int prepare_seq_file(struct file *file, struct bpf_iter_link *link);
 
 static void bpf_iter_inc_seq_num(struct seq_file *seq)
 {
@@ -257,7 +256,7 @@ static int iter_open(struct inode *inode, struct file *file)
 {
 	struct bpf_iter_link *link = inode->i_private;
 
-	return prepare_seq_file(file, link, __get_seq_info(link));
+	return prepare_seq_file(file, link);
 }
 
 static int iter_release(struct inode *inode, struct file *file)
@@ -586,9 +585,9 @@ static void init_seq_meta(struct bpf_iter_priv_data *priv_data,
 	priv_data->done_stop = false;
 }
 
-static int prepare_seq_file(struct file *file, struct bpf_iter_link *link,
-			    const struct bpf_iter_seq_info *seq_info)
+static int prepare_seq_file(struct file *file, struct bpf_iter_link *link)
 {
+	const struct bpf_iter_seq_info *seq_info = __get_seq_info(link);
 	struct bpf_iter_priv_data *priv_data;
 	struct bpf_iter_target_info *tinfo;
 	struct bpf_prog *prog;
@@ -653,7 +652,7 @@ int bpf_iter_new_fd(struct bpf_link *link)
 	}
 
 	iter_link = container_of(link, struct bpf_iter_link, link);
-	err = prepare_seq_file(file, iter_link, __get_seq_info(iter_link));
+	err = prepare_seq_file(file, iter_link);
 	if (err)
 		goto free_file;
 
-- 
2.39.5


