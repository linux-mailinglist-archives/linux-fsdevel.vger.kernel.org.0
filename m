Return-Path: <linux-fsdevel+bounces-64703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C95CBF1807
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 15:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2EC4202B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402753164A4;
	Mon, 20 Oct 2025 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X3Cneh1G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150D1A5B92;
	Mon, 20 Oct 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966273; cv=none; b=IlCzgtHodqB4Y2u1ztNzQfRmAyKSRJACnLmfdF1+X3NVpbJSgp9Dh4n8ffqjv7popOpvHuvwENXaZDEA5JSKWhEIR1uTHwayAneci86vbLdzkd4L+4+pXbhIgz4oy+EyrXtqFivqmiyB203Sb1ycUuR+9rPnp64SSxCJXAZFTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966273; c=relaxed/simple;
	bh=aDB3dWTxjuQmVfsCYctiYUEz6j4eOMUa343QsR8QrK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hOGn3DfW+u0ahfwAZW6iuQh1MPix6+lR6KiDYHh979TTz7qALx4AhnvVlX5vpn286vwODZF3RBwIPYoxLz8emcStlHG+YoC+dsd2VuSk2llAhpxjRju67KV1zl78Vg3qtTVhAULjW0LxtmhGZs/o6r2RQ6nvQPX0OyqbVPgBJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=X3Cneh1G; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bg+X/nyARdqSzBSzzwAJ/Z2Vg6L7cqDDErI2lgU3ML0=; b=X3Cneh1GnOc/2kiCPXN86Q5QF5
	Yq5BlKFZ9BZkOgt74ok66sY1KyqUN+xTXJ5An+Ga9msHj7XXYC2hexmfQMSPpjbLcq1Q9KJV0Mhby
	ZxCmQjnCRIByNkn7PyZa7hU4N+uHtJUXxliTX8kl5ycreRvuBW9KgAvv90GnVpilHcvMGmhJy92Co
	OFCC9lLUz8FE8xmc3rC+8IsRFzKvPHxLgKKUbbykB1zJy2ne+gOlsUCwfE7bJ+5gk6TDlQZ1d/Tto
	VU5LpiUoGwdRaiyXy8a/cjeFFX2oFyWBcInpNeqlgcWEaN9wccZ2+OD6Z336VAue6lT/D7KlAzh1i
	CWYm08wQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vAplc-00C7Mu-13; Mon, 20 Oct 2025 15:17:40 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Laura Promberger
 <laura.promberger@cern.ch>,  Dave Chinner <david@fromorbit.com>,  Matt
 Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  kernel-dev@igalia.com,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 0/4] fuse: work queues to invalided dentries
In-Reply-To: <20250916135310.51177-1-luis@igalia.com> (Luis Henriques's
	message of "Tue, 16 Sep 2025 14:53:06 +0100")
References: <20250916135310.51177-1-luis@igalia.com>
Date: Mon, 20 Oct 2025 14:17:33 +0100
Message-ID: <877bwp4sr6.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Miklos,

On Tue, Sep 16 2025, Luis Henriques wrote:

> Hi Miklos,
>
> Here's a new version of the patchset to invalidate expired dentries.  Most
> of the changes (and there are a lot of them!) result from the v5 review.
> See below for details.

Just a gentle ping to make sure it doesn't fall through the cracks.

Cheers,
--=20
Lu=C3=ADs


> Changes since v5:
>
> - Changes to dcache: export shrink_dentry_list() and add new helper
>   d_dispose_if_unused()
> - Reduced hash lock array size
> - Set 'inval_wq' max value to USHRT_MAX to prevent a potential overflow in
>   secs_to_jiffies()
> - Updated 'inval_wq' parameter description and comment
> - Removed useless check in fuse_dentry_tree_del_node()
> - Make fuse_dentry_tree_work() use dcache helpers d_dispose_if_unused() a=
nd
>   shrink_dentry_list()
> - Fix usage of need_resched() (replaced with cond_resched())
> - fuse_dentry_tree_cleanup() now simply does a WARN_ON() if there are
>   non-empty trees
> - Removed TODO comment in fuse_conn_destroy() -- no need to prune trees
> - Have fuse_epoch_work() use of shrink_dcache_sb() instead of going throu=
gh
>   all the trees
> - Refactor fuse_conn_put() in a separate patch
> - Fix bug in fuse_dentry_tree_add_node() for cases where dentries have the
>   same timeout
> - Reword some of the commits text
>
> Changes since v4:
>=20=20
> - Dropped extra check in fuse_dentry_tree_add_node() (Chunsheng)
> - Make the dentries trees global instead of per fuse_conn (Miklos)
> - Protect trees with hashed locking instead of a single lock (Miklos)
> - Added new work queue (2nd patch) specifically to handle epoch (Miklos)
>=20=20
> Changes since v3:
>=20=20
> - Use of need_resched() instead of limiting the work queue to run for 5
>   seconds
> - Restore usage of union with rcu_head, in struct fuse_dentry
> - Minor changes in comments (e.g. s/workqueue/work queue/)
>=20=20
> Changes since v2:
>=20=20
> - Major rework, the dentries tree nodes are now in fuse_dentry and they a=
re
>   tied to the actual dentry lifetime
> - Mount option is now a module parameter
> - workqueue now runs for at most 5 seconds before rescheduling
>
> Luis Henriques (4):
>   dcache: export shrink_dentry_list() and new helper
>     d_dispose_if_unused()
>   fuse: new work queue to periodically invalidate expired dentries
>   fuse: new work queue to invalidate dentries from old epochs
>   fuse: refactor fuse_conn_put() to remove negative logic.
>
>  fs/dcache.c            |  18 ++--
>  fs/fuse/dev.c          |   7 +-
>  fs/fuse/dir.c          | 237 +++++++++++++++++++++++++++++++++++++----
>  fs/fuse/fuse_i.h       |  14 +++
>  fs/fuse/inode.c        |  44 ++++----
>  include/linux/dcache.h |   2 +
>  6 files changed, 273 insertions(+), 49 deletions(-)
>

