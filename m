Return-Path: <linux-fsdevel+bounces-71206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E60CB9876
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 19:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8019130A58D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FAE2F7AC4;
	Fri, 12 Dec 2025 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eIdAznC+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014602F656D;
	Fri, 12 Dec 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563196; cv=none; b=IwGoo2Pjwu9TPQuIzVICPP4klsItnqr3NldcSYwshDbLFxZ0Ic75X06tJ1QP95vwO3D3Bv7B+T6pSkRT+UwchF+MY5WIzb44BaJJM1VbfLsQIEScwLXQ19N9BzouLon8n7MHb98D+buj4ujUI6/zE9aAH+B4O+tTIeZF8lU1DAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563196; c=relaxed/simple;
	bh=Fqr8p6dEt9BCUCygt2MyGi4B2cKh3NVA/lEwqXnPm+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CSZ/EA55fxSIcGA2wLOwCjP7C44QZ9DvB5b7UAYYUdqwezQUdTgh4wmDB4RDw2q/tF4G14Eb3wzM0LwNMWZa3ZzhSn37+y7CBamCrBbLJNmELpRZeiTJuU9Ru9IzoCKYCF6P+ZaEo09tnPW4DTVYVSuVgRMY4kK8KyiO8QK41LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eIdAznC+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OSsYesECyjr5AbqJo0a/pN2iNQ7yWzVhD9H9umwshf4=; b=eIdAznC+rV3Ev0K9+o5RDfXHYE
	N0KO8m+c+HVdVOSoiCpltFPrU6GP51lv88qndxM0mI7kW1coSk6yb53H+EzKLJBbi3U3Z3IE8FUaJ
	f9ekpkg4uHhwWRLdPoFa+HdIQZ7H/CkSZBSezWi4lpNjW6fWGrbgTl9IRk6LlSDLSPmT8nlxUOUQp
	4ctASVuFL2yiUkFaC45n4TDxPslmD6O/jLN07+IR8iYQMy6n4yVu9zP8nCZ+lS3ekRjWtu047Tw70
	czC+BQ4bVwBiWtad7E3hiBTwP/XCC6g5C8yz3MZE0jL1O5P5gorKEwCnWU0+I8XKrRb37BLGIcbdp
	Qq4quykg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vU7dQ-00C796-Em; Fri, 12 Dec 2025 19:12:56 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Bernd Schubert <bschubert@ddn.com>,
	Kevin Chen <kchen@ddn.com>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v2 0/6] fuse: LOOKUP_HANDLE operation
Date: Fri, 12 Dec 2025 18:12:48 +0000
Message-ID: <20251212181254.59365-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

As I mentioned in the v1 cover letter, I've been working on implementing the
FUSE_LOOKUP_HANDLE operation.  As I also mentioned, this is being done in
the scope of a wider project, which is to be able to restart FUSE servers
without the need to unmount the file systems.  For context, here are the
links again: [0] [1].

This v2 tries to address (most of) the comments from Amir to v1[2].  I don't
think I'm addressing them all, but since a few weeks have already passed, I
decided it's time to send a new version anyway.

Here's what changed since v1:

- Handle assertion gracefully in create_new_entry() (Amir)
- Don't truncate handle in fuse_iget() if size is too large (Amir)
- Move NFS-related changes to a different patch (Amir)
  In fact, I ended-up moving all the NFS-related code to a different file
- Handle compat (still WIP)
- Fix out_argvar handling: variable length arguments are not always the last
  arg now, so a new patch is handling this
- Re-implemented NFS-related changes
  Still only lightly tested, and as Amir hinted, it should probably include
  an extra init flag to select between old vs new NFS handles format
- The usual bug fixes found during more testing

[0] https://lore.kernel.org/all/8734afp0ct.fsf@igalia.com
[1] https://lore.kernel.org/all/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com
[2] https://lore.kernel.org/all/20251120105535.13374-1-luis@igalia.com

Cheers,
--
Luis

Luis Henriques (6):
  fuse: store index of the variable length argument
  fuse: move fuse_entry_out structs out of the stack
  fuse: initial infrastructure for FUSE_LOOKUP_HANDLE support
  fuse: implementation of the FUSE_LOOKUP_HANDLE operation
  fuse: factor out NFS export related code
  fuse: implementation of export_operations with FUSE_LOOKUP_HANDLE

 fs/fuse/Makefile          |   2 +-
 fs/fuse/cuse.c            |   1 +
 fs/fuse/dev.c             |  20 ++-
 fs/fuse/dir.c             | 216 ++++++++++++++++++--------
 fs/fuse/export.c          | 318 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c            |   1 +
 fs/fuse/fuse_i.h          |  53 ++++++-
 fs/fuse/inode.c           | 230 +++++++++------------------
 fs/fuse/ioctl.c           |   1 +
 fs/fuse/readdir.c         |  10 +-
 fs/fuse/virtio_fs.c       |   6 +-
 fs/fuse/xattr.c           |   2 +
 include/linux/exportfs.h  |   7 +
 include/uapi/linux/fuse.h |  16 +-
 14 files changed, 645 insertions(+), 238 deletions(-)
 create mode 100644 fs/fuse/export.c


