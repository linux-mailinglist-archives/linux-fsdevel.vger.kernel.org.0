Return-Path: <linux-fsdevel+bounces-69222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B03C7396A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 11:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C2FFF30003
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F076330311;
	Thu, 20 Nov 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OGLok3IV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D697732ED40;
	Thu, 20 Nov 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636161; cv=none; b=dqG5myd20GqHi1PCzf0j8TizSj2jUQ0qzT9LVuoeWyKVvltF05tUSzYTNo02uW5/L9CTOwCpfRxmhrUYwW9zHMe2hjk7FXj7W6/nLNNQ+ltk5UR9+twcGuwhmuBa1vFG2Mpfkm0EHFrndfmuSqhvjTm04zVOtjajvItOBQ5dZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636161; c=relaxed/simple;
	bh=I9VuJRgwZUH1zKsRsrGvRoExT8+mXunRQ81n1Dz/+dM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urdTdLSfBjYv/GuPR6Yg7Yo6nNf6a5b/aXoClh5nQncwtwRO9cs/OqwncpivetVWLwCYm1ZNr8oWWdoLXeh9kMwTO8cd6C3chCQDzSlf2wLEKU9Jt/r/1theFdfrbjaTbU53hbPoanOykmlncJ6Rgkyk11Vxh1J/uq69VwVYtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OGLok3IV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aDZzYdeIaM+kvlJBBYNd98FAfq2/VclZNn7daDmArhs=; b=OGLok3IVjqWxqVbw+Vt2OPf43W
	hr1AxEyamx1D4T8Q4q/aRk4jcIbLNlEMSYIg/qM0y4b6T+sJYKmm1GWz4zg0xzghcqSEVe7Rb1UrN
	xMmvEAkOGTIuBod18vSlDKoI/DCH9h5pYs+wot6DGTTsODu/PJc3n1A5fMPSkVXxy3NvmTO7/gXka
	bNNZZD/oo5gE4GjHdcwttsLM6UExoXskrdqDRVowV/AwmIC4Z2Pwy5NxAXEGwToICuRdVQ6ZBcyiJ
	ifpjJX7Y1gQITvnzugyoUjQ90cqy2fs2woP20cIRvxYwvOUSLMHUBVgUAFEEC7A3HFDscknFUHewp
	TTBR/j5g==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vM2KE-003CK7-33; Thu, 20 Nov 2025 11:55:41 +0100
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
Subject: [RFC PATCH v1 0/3] fuse: LOOKUP_HANDLE operation
Date: Thu, 20 Nov 2025 10:55:32 +0000
Message-ID: <20251120105535.13374-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

In the scope of a wider project -- that of being able to restart a FUSE
server -- it has been already identified some time ago that one of the
missing pieces is the FUSE_LOOKUP_HANDLE operation.  For context, please
see [0] and [1].

I've been playing a bit with this operation implementation, and I decided to
share a very early (and not particularly neat) draft of it.  Because it
needs to touch several different areas, it's quite possible that I'm doing
it totally wrong and some early feedback would be great to help me fixing
that.  Also, please note that this patchset isn't complete, there are
several things still missing.  For example, handling compat is missing.
Also, I haven't tried to include the optimisation suggested by Amir[2], to
use a trick similar to the one used by fanotify_fid_event so that the fuse
inodes could inline small file handles.

I'm not sharing (yet) the user-space I've used along with this patchset, as
it's probably not relevant at this stage.  Also note that this is barely
tested, and the nfs-related changes in particular (export_operations) are
not tested _at_all_.

Anyway, I hope this RFC can be used to support the discussion I started with
the thread already mentioned above [0].

(And by the way, I understand there's probably a lot of useful information
in the two threads [0] and [1] that is missing in the patches descriptions.)

Cheers,
-- 
Luis

[0] https://lore.kernel.org/all/8734afp0ct.fsf@igalia.com
[1] https://lore.kernel.org/all/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com
[2] https://lore.kernel.org/all/CAOQ4uxjZ0B5TwV+HiWsUpBuFuZJZ_e4Bm_QfNn4crDoVAfkA9Q@mail.gmail.com

Luis Henriques (3):
  fuse: initial infrastructure for FUSE_LOOKUP_HANDLE support
  fuse: move fuse_entry_out structs out of the stack
  fuse: implementation of the FUSE_LOOKUP_HANDLE operation

 fs/fuse/dev.c             |   1 +
 fs/fuse/dir.c             | 202 ++++++++++++++++++++++++++------------
 fs/fuse/fuse_i.h          |  45 ++++++++-
 fs/fuse/inode.c           | 164 +++++++++++++++++++++++++++----
 fs/fuse/readdir.c         |  10 +-
 include/uapi/linux/fuse.h |  16 ++-
 6 files changed, 348 insertions(+), 90 deletions(-)


