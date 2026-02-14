Return-Path: <linux-fsdevel+bounces-77202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMWBIm1okGk7ZQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:19:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF13513BD45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 953BD30226A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 12:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCF430ACFB;
	Sat, 14 Feb 2026 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRG5ML6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B79D54758;
	Sat, 14 Feb 2026 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771071575; cv=none; b=eJhijjpDCoBVlWyiHVjoBq5Wh4u9ZyJbW0SqxUSXwp4oJlTMXp4zYW4oUKwfRoeC9PlIKmIY3T5KoqXpiD7wSrCAKwsaIe3cuxFVShllDSMnqjrZACZ2aiBgF/KI8ZbE6uYrGr2c9HJavRyC7Z94kr80AJcDK7nBekEH1A76OvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771071575; c=relaxed/simple;
	bh=kBEBGdCKgbGG1Rcl7N+2ft0nAy+bcs36GklMcZCOljQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTAl3HuLCl0ejAiCvzPPJUomhNULkBWjSXC0hDiDYtNMt7oy2eSU7atx6okg8N3MBW+Y0Okr3vebLhum7SmquHT1FbDu8GKAVcGqFwZlAHlFWe7B6F8cvZV9TOMyn9unU7+9LQW1dUBuaxqg78MXQU/ZZnWaCKMcNiFv7nyj5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRG5ML6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8595CC16AAE;
	Sat, 14 Feb 2026 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771071575;
	bh=kBEBGdCKgbGG1Rcl7N+2ft0nAy+bcs36GklMcZCOljQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRG5ML6wM5uXoXy1C7n/xfLe9nx83iVY+FCX3I+bbzlshMs2h5Q5iy3KdISInceFp
	 iqQuFebYldl41N1L/P2Vs1rL83/Shb1ZvInH44dXvcr8pfUCGiV8a+sX7x0kNGQD/c
	 OgKsTfVH1m5mdG5cwjMWZw57owmf3VimldTdGt3a3084pY0trk3SJTvmp9ohrQGtw4
	 goC1xPg7QNH7aKZqdmkHRW99moX8ULeXxi/dWg/0UZa6Uvqh5V6DATEZH4lKHcHrTO
	 L7uQ9aGGfhUD9DB6F7dp3W58F/X7hyHcsS6YARUtQu8CHQ6w7jWAL6dbIWYOa/XWcu
	 i+v+hdJKcqdMA==
From: Christian Brauner <brauner@kernel.org>
To: Qing Wang <wangqing7171@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3] statmount: Fix the null-ptr-deref in do_statmount()
Date: Sat, 14 Feb 2026 13:19:21 +0100
Message-ID: <20260214-biochemie-nervlich-4d07b1676fc0@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213103006.2472569-1-wangqing7171@gmail.com>
References: <20260213103006.2472569-1-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1015; i=brauner@kernel.org; h=from:subject:message-id; bh=kBEBGdCKgbGG1Rcl7N+2ft0nAy+bcs36GklMcZCOljQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROyAg8GGXPLP86fkLoynuTFNz7rl08NJVt4Vz9vrRrD m4pqzwZOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYy9RfDbzan84y2R2PVcvku JLo+WRa6UXMO18WvXCuO/93Tdn3TxpmMDE/i1t7bcJEp9fWfS6Zm0RnPj0/3V7/BUMZybXeymtD b92wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77202-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,syzkaller.appspotmail.com,zeniv.linux.org.uk,suse.cz,virtuozzo.com,gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,9e03a9535ea65f687a44];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF13513BD45
X-Rspamd-Action: no action

On Fri, 13 Feb 2026 18:30:06 +0800, Qing Wang wrote:
> If the mount is internal, it's mnt_ns will be MNT_NS_INTERNAL, which is
> defined as ERR_PTR(-EINVAL). So, in the do_statmount(), need to check ns
> of mount by IS_ERR() and return.
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] statmount: Fix the null-ptr-deref in do_statmount()
      https://git.kernel.org/vfs/vfs/c/81f16c9778d7

