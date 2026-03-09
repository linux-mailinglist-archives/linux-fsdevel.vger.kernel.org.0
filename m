Return-Path: <linux-fsdevel+bounces-79744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKJ4L6GIrmnKFgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 09:45:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3A9235A51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 09:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3476F304D949
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 08:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6947A335BBB;
	Mon,  9 Mar 2026 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9vzEqn9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8D309DDB;
	Mon,  9 Mar 2026 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773045813; cv=none; b=KLU7xL3dhdNnahorS4dtYw8qXDBaRdaeB7Vy93ZaavFiPmO0fE/rfrliublQj52BdyYordVgH/mpp4nAadlTv9BrLd9s0Yj+PpG/s39pXSC/+rIXm0yPn4w79G/M0lG+PKouXI+H/OJh/2Y9xg8q32fxPkqV/8cg48jewizfySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773045813; c=relaxed/simple;
	bh=gWqdkhYkbwmWU6R89018XFPGLsD6YIoMVWMHNNFNIjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDinT/6O0jufoVCNmxue/Um+55P/I6XtVdiCxm8UYxl7mmms/vczgSUR1qHR7LfB/vkUqSOgK9tTR8PgFLYeuGkDylS4fa6lRqd4dfWpwTGxkEjeJqRS4XkTjQYm458WEosoOHgyPebvDOWNtBdXs8DLeR5bvB4dH9s8iQvxYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9vzEqn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E055C4CEF7;
	Mon,  9 Mar 2026 08:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773045812;
	bh=gWqdkhYkbwmWU6R89018XFPGLsD6YIoMVWMHNNFNIjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9vzEqn9kc0ui4yBsdwdBMUgAyweBD3Kr29vk19sY7bOzDSmvn0Jfj+cXsffDIRsQ
	 iJKTXhJJGgq1IOUTgjmsZu1gxY4soe3V/gdyjvNLo325waAwG2AvVm2ZrUWF5XSdcb
	 3H9tsnIPkW3+hxeNohicMtbEOPYryEudTq59JqqLdXrAxDcEWzQ33vM7iwvU4Ldi9B
	 aSjIUycqKtgtnXu8ST2y+yc/6KHr71rJwChT83ACfzO50C6ywsXyC7rbfEEZPqniF6
	 LTOjfcFZ5rnd1FlYCZD5lftA+F1D8umsJ7AQZRuVV56RV+u9YHVc0QL77ZjLXnQjUL
	 dPAp2uCJFJrRA==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Christian Brauner <brauner@kernel.org>,
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
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH] FIXUP: cachefiles: change cachefiles_bury_object to use start_renaming_dentry()
Date: Mon,  9 Mar 2026 09:43:15 +0100
Message-ID: <20260309-verdacht-parkhaus-3a9cde4d4a7a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <177300347820.5556.314358492166337403@noble.neil.brown.name>
References: <177300347820.5556.314358492166337403@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=brauner@kernel.org; h=from:subject:message-id; bh=gWqdkhYkbwmWU6R89018XFPGLsD6YIoMVWMHNNFNIjY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSu69DZnyF4wTameb/Gop+1zYqeihL/n+0/9eUU78Y9m xon6mp97ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIxh5Ghi15q6cvCuLe6h/e fjUrftKlq7NWZQqF3T258sqfEMElemGMDDu3L9sfnCOirm+sOl3uzbdtL/xvKr2/H6t/ZLtHv9C F11wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C3A9235A51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ownmail.net];
	TAGGED_FROM(0.00)[bounces-79744-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.415];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 09 Mar 2026 07:57:58 +1100, NeilBrown wrote:
> [[This fixup for f242581e611e in vfs/vfs-7.1.directory provides a new
> commit description has preserves the error returns and log message, and
> importantly calls cachefiles_io_error() in exactly the same
> circumstances as the original - thanks]]
> 
> Rather then using lock_rename() and lookup_one() etc we can use
> the new start_renaming_dentry().  This is part of centralising dir
> locking and lookup so that locking rules can be changed.
> 
> [...]

Applied to the vfs-7.1.directory branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.directory branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.directory

[1/1] FIXUP: cachefiles: change cachefiles_bury_object to use start_renaming_dentry()
      (fixup)

