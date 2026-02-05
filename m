Return-Path: <linux-fsdevel+bounces-76472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO9DCBDohGnb6QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 19:57:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B827F69F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 19:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AA163018D41
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B3309F0D;
	Thu,  5 Feb 2026 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UF0mkqcz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665CC263F4A
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317834; cv=none; b=sjQrzi+pXn5WwMsp0LVmG5R7rpqqeDougszhQERLHf9kppMO8NmIjeNt6GANFLr++eV2SRUHQ35cfy247VCg9TMNBazHSsaNX8QLBM3ehL3bHVZ6L6FHm22n5BV86t+DS1CIEMzUY+19Tvda479hgN4Knm/XJ0AV1qy5oIsrS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317834; c=relaxed/simple;
	bh=zBstFGRs7jbdtQb81ctKVTgCyqGpIXIRWCgDdJVGz7w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sJKwkvgdiyXpEN2ASnAWa8a09YqzpikiypkPAHKuTE+ytDykjeVlA7zO9hPuFmjIssAIxvAVw746NpPelISvK5syIuhKYz789wL+86n7WpCCbUZszlnEoACx/Yt2HcfoVzawjZhpDOLGuKT323H2geZ+SjHV3mltq3cxfxuDtbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UF0mkqcz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=y9/E2djBoZEDHug7PVnTXyyWCh+IhQ808jy8LPraeE4=; b=UF0mkqczYGwr9MO8PbGqII/Hca
	PIw2th22zoxiVDLr3+GyWsFbxdyAYO8Wjmx1MlQfd2jVD91S3JkaZSlJcIpfeRWPxOUShC3JQ0rus
	P60fVEoPn0w3mvNq6oOcBU/RwoIMMnUnHzTN2pu8bnipH6/SHVvHtA6MRF31Xvp5PTsAPaQAErLQ7
	97eZEMT5QRyO1lJpu6DOIDhA3Ctwysle0kfoUt2LErHa/iTAlX3ogFy3MyntYVBVCQAIjswll24de
	b0Y7uDMEhHq9ilFFP36wU4e256KVM3UhcIowloQlbEZIZ+mV2YPMfNFM/G3mOkbuTNXCaXWpPu7zm
	od6p48kQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vo4ZP-0000000308H-0IZI;
	Thu, 05 Feb 2026 18:59:15 +0000
Date: Thu, 5 Feb 2026 18:59:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [git pull] tree-in-dcache regression fixes (rust_binderfs and
 functionfs)
Message-ID: <20260205185915.GS3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76472-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B827F69F0
X-Rspamd-Action: no action

The following changes since commit 63804fed149a6750ffd28610c5c1c98cce6bd377:

  Linux 6.19-rc7 (2026-01-25 14:11:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 2005aabe94eaab8608879d98afb901bc99bc3a31:

  functionfs: use spinlock for FFS_DEACTIVATED/FFS_CLOSING transitions (2026-02-05 13:53:12 -0500)

----------------------------------------------------------------
a couple of regression fixes for tree-in-dcache series this cycle

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (2):
      rust_binderfs: fix a dentry leak
      functionfs: use spinlock for FFS_DEACTIVATED/FFS_CLOSING transitions

 drivers/android/binder/rust_binderfs.c |   9 +--
 drivers/usb/gadget/function/f_fs.c     | 108 ++++++++++++++++-----------------
 drivers/usb/gadget/function/u_fs.h     |   2 +-
 3 files changed, 55 insertions(+), 64 deletions(-)

