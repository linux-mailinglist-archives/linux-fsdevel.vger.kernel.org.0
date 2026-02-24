Return-Path: <linux-fsdevel+bounces-78319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEf4Lbclnmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:27:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352CA18D28B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AE31305272B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12423346AD5;
	Tue, 24 Feb 2026 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="evYF/qXJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cdt6E8pE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F7833A9C4;
	Tue, 24 Feb 2026 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971985; cv=none; b=AvifmwYx6oAzvSEh/hXR+WmKYsJNjruHiJpuVNOjV7PYXJNGb5oy3sr1Rh+niI6KKHDr0qSdiDJCDOnr3xFOe/EEDgSUojL+cHZm2aGUsQ7zRABfq5DiWybD/x9jdNI/0pvQKt11Zsim8PwfuPZ0WxoewOrG4sCPmsINI/G9AhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971985; c=relaxed/simple;
	bh=OIzbQUjzzrfzG2AR3C+81QVfuL+PWhXQpta3pAbRqyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3H42quSDLgd0zY4okNCfe3H0tipcmY/OqR6knwpujgKlS1m2cW+dWsvkGtmBNuIiLTMAxRbvkDqUQqC7ezGEk7BlHXuUvHksqsKAVPGKm6xJg7HQVanAVlromGT4ygFV1SPsw/EJQFU32PMIVcWFW4cILXjbUZ0h2/jqQhqdIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=evYF/qXJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cdt6E8pE; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id CF4A5138052C;
	Tue, 24 Feb 2026 17:26:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 17:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771971983;
	 x=1771979183; bh=5Q3jCmGh6Jb3Gjy9NudY+872UTbORvggbK9OGnafF7A=; b=
	evYF/qXJrvbeSkmRxelWl90RX65c2IF72hU1n9xzwLX5JwSjdqGtNZf7C599IiwF
	DV6SR/d2JC8EWNogO4lOFIT0zYJzecAlRYPtbRahrqqX0hbO7E+7CJBklCGQpnus
	WBWqvWkr8VXvuBv8rtjdGTHJF7X//bOLk4bVwBacItg3Kk1jGpihXHUhp1gw9TZq
	zRxl0pQEI9IvRqhkB9HoOyQsY114IiInFx32YbcnlMPURtG1pNuSDso9JFDjf/6F
	MvqUvSWgiZYZYIIQeUoKa7yBJGqaH7Sj03Qm+5k6mOfFJCEPNxaF9iW+35cHa/bV
	4WJT703PWIcSNjsiCbJXMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771971983; x=1771979183; bh=5
	Q3jCmGh6Jb3Gjy9NudY+872UTbORvggbK9OGnafF7A=; b=cdt6E8pER3vWa0h8n
	gL13z5rBUmIu4c3dgieu76uILJFzG9DnB8Ly77oleUrTRkVUJcuQR6+Kr/XcFy5F
	i+B5XEFYG2zocYYwODjd9zLhMklvpvYJYYJ9hok9Ralaoyq8LLukxcs1QLygHaDP
	AYIBX0XHwm28nQVHC6OEo5BYc8R/VZq8vcb34dWeQTlhpIc1WMqBeyWZwTBcRbuT
	31dxRddY4vrQJaTa/msdTOTl7YD/Cz6MrLaPR9xqxgGJcEicklbMP8iMlDtEC0ly
	B7TElwxykmAHtX9XuhAunOfj+8ttr6QmTXpliit0q1+5Tw17Wv+bYk52AxTZxBVK
	IUp5g==
X-ME-Sender: <xms:jyWeaUXqIKYUsNZiSVWmrPYu1Eq6sJVoVp4ulGFj6Mx28yuyPcbhxA>
    <xme:jyWeacgEROquSuh6J9Igfb02ZnmRpHl-_2mR1A3jYz2ePoMmMJ1WzWCwEW76JpKPG
    IR4j5lXw8AsIYWHw18B7uvJlkF7O5ij3mCwv8qQmFqRrWjsYw>
X-ME-Received: <xmr:jyWeaQ75Xvz4mDdZ6wmFRYvb-sDqkK-HDqE5Kbo5OQctFMKEj-qLdGT32bLqwcD9_yxnmAlzmCaQgfPkoiG0TxE3o67z2fyKq4GY9yB8BT0T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:jyWeac6v9vYv83TfTMGECessVXZnLBrwrV9CN21pNq7Z54U_cYPVnQ>
    <xmx:jyWeaWFBrE3rcQ4gsLO2HPF7qap94vUeU4LGOEUitLP5e4GYFn4W9A>
    <xmx:jyWeaSwOyjdGV_7QTm0FYacM-5DK_fXff5aHjsv4SlvsZ4WPm51qNQ>
    <xmx:jyWeae22RNJ1NvwrQ2LIdL56iiErz_M8a53pqK7RFQFu3_bcS3KR9g>
    <xmx:jyWeaXeoQvbJZVbQYPHwBUaUT7cMBeiLl9mvr8F9PjaC-mXHYngsC2bY>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:26:17 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v3 03/15] VFS: move the start_dirop() kerndoc comment to before start_dirop()
Date: Wed, 25 Feb 2026 09:16:48 +1100
Message-ID: <20260224222542.3458677-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260224222542.3458677-1-neilb@ownmail.net>
References: <20260224222542.3458677-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-78319-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brown.name:replyto,brown.name:email,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: 352CA18D28B
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

This kerneldoc comment was always meant for start_dirop(), not for
__start_dirop() which is a static function and doesn't need
documentation.

It was in the wrong place and was then incorrectly renamed (instead of
moved) and useless "documentation" was added for "@state" was provided.

This patch reverts the name, removes the mention of @state, and moves
the comment to where it belongs.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6f595f58acfe..11c9a4a6c396 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2893,20 +2893,6 @@ static int filename_parentat(int dfd, struct filename *name,
 	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
 }
 
-/**
- * __start_dirop - begin a create or remove dirop, performing locking and lookup
- * @parent:       the dentry of the parent in which the operation will occur
- * @name:         a qstr holding the name within that parent
- * @lookup_flags: intent and other lookup flags.
- * @state:        task state bitmask
- *
- * The lookup is performed and necessary locks are taken so that, on success,
- * the returned dentry can be operated on safely.
- * The qstr must already have the hash value calculated.
- *
- * Returns: a locked dentry, or an error.
- *
- */
 static struct dentry *__start_dirop(struct dentry *parent, struct qstr *name,
 				    unsigned int lookup_flags,
 				    unsigned int state)
@@ -2928,6 +2914,19 @@ static struct dentry *__start_dirop(struct dentry *parent, struct qstr *name,
 	return dentry;
 }
 
+/**
+ * start_dirop - begin a create or remove dirop, performing locking and lookup
+ * @parent:       the dentry of the parent in which the operation will occur
+ * @name:         a qstr holding the name within that parent
+ * @lookup_flags: intent and other lookup flags.
+ *
+ * The lookup is performed and necessary locks are taken so that, on success,
+ * the returned dentry can be operated on safely.
+ * The qstr must already have the hash value calculated.
+ *
+ * Returns: a locked dentry, or an error.
+ *
+ */
 struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
 			   unsigned int lookup_flags)
 {
-- 
2.50.0.107.gf914562f5916.dirty


