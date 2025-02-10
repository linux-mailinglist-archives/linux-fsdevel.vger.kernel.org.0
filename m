Return-Path: <linux-fsdevel+bounces-41357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87853A2E37B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3F67A2E80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0839D18C008;
	Mon, 10 Feb 2025 05:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="k6uHerG0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ujMgz1H9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7943213FD86;
	Mon, 10 Feb 2025 05:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164881; cv=none; b=dsB54G+vrze2JGtERp+1hsYZhB2vAOcLtFpMc31JHPgVKxXCi8AV7WxKiEVgzMq0kvhCU6AvKPI3BKIWvXgWb/RosI6MWjuZ+Gxk4N7LB/f/Nnec5s0StQytnGemrm5EdhQ0LM67pUBkkMVWNxJGXFJRh2svdSF1uJzLRHvkwAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164881; c=relaxed/simple;
	bh=0KxQId9bTKtoK2s44heydkxZsinvfosJaAjLqTmIy8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dC7aOEbiRpdp3asWZGxZ76FbSgyaoKE04X+rdYpl2afcCtEWjk1KVuAC5WFlmj/pQDj0mMq3NDt8DA3RXsMMr0MqaXXtN9oYi9iursdRuLxFy8VzFAdKXUjALOhA9tuWxNRxiNNfY75vwCv/fLevPWV74rDFuvxvt2uNAICiLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=k6uHerG0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ujMgz1H9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 56F94138014C;
	Mon, 10 Feb 2025 00:21:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 10 Feb 2025 00:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739164878; x=
	1739251278; bh=GXDpGKMgcY+JAEBNv/Xlu0NnEc1xzI1Njjd5bVIHNog=; b=k
	6uHerG0uAjXSLWOUKvYLIp15nyfW55xmLcgDs4VenhADqANihgDDofcaAxs2/An+
	sybw63Ohs7W3j08QSOtzHonkFwXrtO6kMX9hI3D0Ishn+CRKW/VKso3T1c7O50WA
	c5+UHq2X0f57qjfd8oYImQuofrSE9PgLDIWQydDwV5aRcTM1ZGzTdgYOAvxmjQCh
	1YJKOgPjn8pDT6Ug//I3eXFzpBqM5QWmaUFfJbsC/boDjW3Co9KscoQHqD4gwkLO
	IDW7cwpIzAhJdHLVwlu3VkkWlYai6l4MiwEMYPA9HiaOuf8YbQ0TkZgFZMsijuKc
	9qypXnja74uMRwVaUAdsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1739164878; x=1739251278; bh=G
	XDpGKMgcY+JAEBNv/Xlu0NnEc1xzI1Njjd5bVIHNog=; b=ujMgz1H9c9dR6nVwm
	S/ULZTFRdroJX9QnzHpZ4GfMFwqhLbAI2ln8N6g4YhFb6Hp7EP5ZOlWeJYiEHbHR
	BDh4DbK8zOftSORlXZR2HOc4c+7EQRD0YonkGBIpI7FPP2Fi1jv70gbJOrBFX9Q8
	W4X0VPUSNoukzV1OW/5z04qhWpOnNyFFfs2vB9elNi0JPJhAeZIDEOBZKxPo+AQM
	pjW+7e8qVqIbseDOoA0+BW/7daM4fcWCX3cWlnD9WwV9wyOYd8zAVI4hKr83CKFK
	LDtugryCYfrbXp9V7KV1W2zqUUSQBNDnGV6PrB4VJl7odb5thFxKZEVoJTkuxb3C
	RZ5Xg==
X-ME-Sender: <xms:zoypZ5eOHdGqreM_SQWIdCRpG9QQqMCWcMVaYJz9Qc1-dH-nAeHDxw>
    <xme:zoypZ3N820R1HpK-lXkfDYvWfrzXYwJ3EuRwBHwFGV91KBX-aQAHTaIiARVPMRJYv
    6ohlzx1j-nEmo-V8GY>
X-ME-Received: <xmr:zoypZyinp-79rcTu1V3qR8YUMIJKZfHWhVsQ1GcjrvZksDOFOFjR4kDjiq_1DTihvK2ySsvafhvfKKM6pwXsCJiReau3MlxETyzpQ7MYJlFY9Fk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepudevteffveeuuddtkedtvedtteeutdefvdeg
    hffhjeeiveegvdetvdejteejleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhrvghgkhhhse
    hlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhrtghpthhtoheprhhoshht
    vgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdr
    uhhkpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrh
X-ME-Proxy: <xmx:zoypZy-IU0u4T3DONKl-ZJYVzvb-9LzTzlXooDV6bm7ayDQ1SVixNw>
    <xmx:zoypZ1v6gqhSVOednqTFibVOLiiVSYYh9hlHyggFacpRWz-03IOsSA>
    <xmx:zoypZxH3fKNcsM2I7yAkaL-SKQNkorxUikpvCyvkc8FfuuVKTW9hIA>
    <xmx:zoypZ8MJeNb1m44uStnF-8FsyqkZAciLkYChp6Bn02dB4txuFLbyxA>
    <xmx:zoypZ2nZ2PD2GZlXKZJSiUCkFtc1uQaXitbeFcjDEowzomtw_JZ_iKnv>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 00:21:16 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: David Reaver <me@davidreaver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/6] debugfs: Add temporary "#define debugfs_node dentry" directives
Date: Sun,  9 Feb 2025 21:20:21 -0800
Message-ID: <20250210052039.144513-2-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210052039.144513-1-me@davidreaver.com>
References: <20250210052039.144513-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some temporary "#define debugfs_node dentry" directives to facilitate
migrating debugfs APIs from dentry to a new opaque descriptor,
debugfs_node. Subsequent commits that replace dentry with debugfs_node rely
on these #defines until the final commit in this series removes them.

This is also added to dcache.h, right below struct dentry, so it is
available where dentry is transitively included.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 include/linux/dcache.h  | 2 ++
 include/linux/debugfs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4afb60365675..4b0c11cd3d50 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -127,6 +127,8 @@ struct dentry {
 	} d_u;
 };
 
+#define debugfs_node dentry
+
 /*
  * dentry->d_lock spinlock nesting subclasses:
  *
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index fa2568b4380d..e6ee571e8c36 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -21,6 +21,8 @@
 struct device;
 struct file_operations;
 
+#define debugfs_node dentry
+
 struct debugfs_blob_wrapper {
 	void *data;
 	unsigned long size;

