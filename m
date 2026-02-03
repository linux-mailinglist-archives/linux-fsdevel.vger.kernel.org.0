Return-Path: <linux-fsdevel+bounces-76202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONJgCDYEgmmYNgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:20:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796BADA7B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA1A030E605F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64FF3A7F76;
	Tue,  3 Feb 2026 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPUDY13M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E003A7F69;
	Tue,  3 Feb 2026 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128279; cv=none; b=O/qqivuprUQjAYJ0+fCwercB2Mo1pC7ku/CHmtKlGqZfJxeKC0bNllXg4ekZYNSKWJeJj5m+ZacqF0V2xF1KapGxcFPq4QVBJoFJ4pJ56Q2V6g0U913R0RiWv41YJqhvXZEA5Xhls83psiM+2DY9KAmbEWl+FGsOg/N1kndxjng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128279; c=relaxed/simple;
	bh=Rd4SoUrM+mpVcKzD0klJ6jGA+8Zad8v98VVBCcMA8x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4ze+1CeI2tE30qIHfNNxKDKveZRREWAfPBtefAR9AUQ5R4lXextD4Ifx7P8+ATDV/PPsymh80Q6KNyIK0+qLS4a2XijHwUqi0zBGjoCBiDoA39WZmRj3ujM9Oz5N6K02BcaWN0kL4iKu/0iGVojWghMT/KtSXRx1O9ZY6KMYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPUDY13M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E821AC16AAE;
	Tue,  3 Feb 2026 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770128278;
	bh=Rd4SoUrM+mpVcKzD0klJ6jGA+8Zad8v98VVBCcMA8x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPUDY13MsjIOFid1x2iag1RBcv7wzi6+BHa5sKo+Ut7AwthLk2sRdC6XIe+ZgY8id
	 UtY96syrs/R2G+PsFrB6DiqHFoAk8sWPRxOvGrxmvV9AdiE6mkEUQnqaw/EfF774fg
	 CLK41jMGHDUkoyPhULBdjRm1+4Ebes0xa3egW7A0KsYxY/1s6TWaHyhKPu9ThEXL88
	 awmNUFBI+KFo45D6g2qXXPfPysUvtoSsP27O693XhrBojvrxlMYsWkyvJlESVN+E4B
	 dKdfJdfl+8Z/IjR0IkohXXx+F4R1N4q9bSEidyfkmI0qYjlZQWmQSrNqvf6RNDZeF5
	 DUaiWAkZaPedw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: add porting notes about readlink_copy()
Date: Tue,  3 Feb 2026 15:17:48 +0100
Message-ID: <20260203-buchhaltung-lehrgang-802188e9f1cc@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203130032.315177-1-mjguzik@gmail.com>
References: <20260203130032.315177-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=939; i=brauner@kernel.org; h=from:subject:message-id; bh=Rd4SoUrM+mpVcKzD0klJ6jGA+8Zad8v98VVBCcMA8x0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ2MU90tFm5yWHThaqck9aLWLac25bz4pbJRe+fsjt3L GaSeCTM1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRHVWMDD8mc/Sdnhqy7pnX RQGewF/qhy+rbcmc7pmxsLcyo2VjXRojw4ubAZxnOrdFq04I7HX8bPLCZTrnSoOVOydEL+Pls41 J4gAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76202-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 796BADA7B0
X-Rspamd-Action: no action

On Tue, 03 Feb 2026 14:00:31 +0100, Mateusz Guzik wrote:
> Calling convention has changed in  ea382199071931d1 ("vfs: support caching symlink lengths in inodes")
> 
> 

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] fs: add porting notes about readlink_copy()
      https://git.kernel.org/vfs/vfs/c/dedfae78f009

