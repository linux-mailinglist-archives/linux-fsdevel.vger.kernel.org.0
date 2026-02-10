Return-Path: <linux-fsdevel+bounces-76872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGVZMByDi2lDVAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:12:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB9711E892
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C925B3042B62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB26332E6AB;
	Tue, 10 Feb 2026 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lr1Q7RGF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPGKDW4l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FBB32E69F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750674; cv=none; b=FrWCwkmoGrphUDsGMU1WT6Lcitq2TCEHP0mhyAMJFhmOjnMOPRSa1twZWycw65x0jC0hKPYH918K2HR3O6dBjyUEp3f2th5ihqvMNYAOt7gPwE7O+ZMSj9s9IxHUE+gUtL4vygVZK91FjYrqlI8Mnn5RFYl+7XCMru99ebvUfBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750674; c=relaxed/simple;
	bh=LNepzJNE9SpWEJXOZCqzpCs5MJEzTXNt49WjAzgCuY0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pgQ9bhiawdkIiZJR338lxsm66c0ShbMzWe4GCGNsHRe8oyk3e4X+pYRQ/npTFTpEu/rbKSxaY4fpA7UjcGnYm84pNpBaPh7AO666CExuZwoA7rTLv0qh4GM0c4LxzuEP7VKFo7Y8JFSEZPpJJjyl8e5kHbFBBn3L+9mr9fZynAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lr1Q7RGF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPGKDW4l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770750672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2Xf2m5pmbcGyim1nBI0IEwxlrJ12JH3NSxVXcGIlWo=;
	b=Lr1Q7RGFPVzzZWKdrFp178tWqMAznbhiUglllM5FBOTOjw3NNQKV2DXB4MLcndDuxKLTL/
	7aqeYDwrIgFHEHxWcd7Sk/nZlS389Tmn0LAz7ga2/ZBDlwpMzK6onNcRb2bSfkUBsDU/F4
	AYhnH081rTeLXQnljYTJLxH9uEtbj50=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-QByPKqHcO4mTA-mnvHxm_A-1; Tue, 10 Feb 2026 14:11:11 -0500
X-MC-Unique: QByPKqHcO4mTA-mnvHxm_A-1
X-Mimecast-MFC-AGG-ID: QByPKqHcO4mTA-mnvHxm_A_1770750670
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7964fed3b47so32635257b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 11:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770750670; x=1771355470; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r2Xf2m5pmbcGyim1nBI0IEwxlrJ12JH3NSxVXcGIlWo=;
        b=UPGKDW4lokmgUNo99h0u9T4B4Hro1Zm3oGixpj/t+I65Vrsdb+4JgzO9ghhHp9YzIw
         f9cxQvm6mIj+yDqCR+jCtgW2xEsVM3L3/t6laSaOLTqFtbFSBHv177mQm+uPrWYBvd21
         x6fs/zNsCdkAfpbVUB6JaOqt1ZScpyGwF7oopV2yJ9XN9zh0TDd1YNZ2y7wr6hWIYTxX
         IkKGAgiUG94CBktEK/vbPFXCgmdkMlAueITXhIEwJscU3GX1z53uLQK0J+jKGo7eF8Rx
         as8kmJPAEl3J2jPv8vUc4CO7o3+GlTPjDWUemj5qUT5yXvtkxQIviDpvjwodk3xzUY5S
         pFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770750670; x=1771355470;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2Xf2m5pmbcGyim1nBI0IEwxlrJ12JH3NSxVXcGIlWo=;
        b=JHmfqlexJndhG31Bgqzc//XvCa9wyYGIuB5j9hTxWPgBQvfY5Asp2jAcVm6hDxCI40
         3fT36D+km1oK+fJS5jAin5Fq0YObE7s9q1+3RW8qrsx47FFyd2DgVJ7XFlit+7ADaeer
         +GsC2GyCJ+DmBQ60DkR0uvHuFNjPKsGRJZS/7tkAsxjFh9r3rJZgMVEqGe8TJAeUOFu+
         aolIKKyQ9eAhR8wHi/XEaPyawaYh+5etYNqDDNPbF2Jj82AnGh6tYBmhMKpAYpGRi8j8
         zrY3EPrCD9DihwT9pzxcwhTPfLIKCjzX5I3aj92Y4LVv/VYuzhAbcjZQGxf+QO5uw9NF
         lbUg==
X-Forwarded-Encrypted: i=1; AJvYcCXSPDN+beZ6SA7GDpJHhevBKmkKk6ECTW9CmPeYeyf52DI6iG2XsHYw9At6tMiAOQsLGqH+4Hwq2iv8+Gaa@vger.kernel.org
X-Gm-Message-State: AOJu0YzBa6LHe/4/lcSnF7quTtSqCViM3rRt0i8x1DZAWOSg+zmKAcez
	iYrOgwOqcdeFRQbAHvoYhuqvUayoc8ZG3JSQvuI2o/xXX2ifC/Z39CS3d4f5LFcoFQwjVCCBAxC
	oGhvsSedQdhUFuFjylBYGy37I/O/m6hetiYl8BPS9/zaeoxOb36mT7ubCe55xo0bnppO+YE+MpC
	I=
X-Gm-Gg: AZuq6aLYYnO2qL4b/qIVqMKILieDdqKE3g5lAtlnvP6cm/uTnkLWAc302QFR2YkoX02
	/dmp31zzm+iBGDKgVL5G+fBwBQQYO5XePj9Y4PV+GXxXJWcNWnDhBFChjeHr2dvYM5UqC77vT5t
	ZgqodQp3cnW62hMr+n4wlUlf7OikTnm3QCdz2mkbIIyp4YLvJXBrcgnOKmyHMEgybDwv05D3MZz
	UnEPHjuVrAKtNZp1ph1rw57BgNhEuCpXzbK1iwtjB9+OdeAo2khYIUAcLa4148oeu3JA6ohQ57J
	AiKe0sFkEnurX9G7bP7cLqieBd0TSRVNxtfsjyA3KgtW4+lDFMY5jSr+yNfmvez/f4QGNzY0tx6
	ZLdO2eBeJlIYdSxz40saGOcAy7xFWHHNUC/SMY0MCiVzxrDTpe+Dl
X-Received: by 2002:a05:690c:b18:b0:796:3515:3aa8 with SMTP id 00721157ae682-7966aa83f07mr78487b3.43.1770750670184;
        Tue, 10 Feb 2026 11:11:10 -0800 (PST)
X-Received: by 2002:a05:690c:b18:b0:796:3515:3aa8 with SMTP id 00721157ae682-7966aa83f07mr78187b3.43.1770750669655;
        Tue, 10 Feb 2026 11:11:09 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-796211d1b81sm114096987b3.16.2026.02.10.11.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 11:11:09 -0800 (PST)
Message-ID: <3ed63c65a6f6910ece96a88b71f37ff1547b68c0.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v6 0/3] ceph: add subvolume metrics reporting
 support
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Tue, 10 Feb 2026 11:11:07 -0800
In-Reply-To: <20260210090626.1835644-1-amarkuze@redhat.com>
References: <20260210090626.1835644-1-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76872-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BB9711E892
X-Rspamd-Action: no action

On Tue, 2026-02-10 at 09:06 +0000, Alex Markuze wrote:
> This patch series adds support for per-subvolume I/O metrics collection
> and reporting to the MDS. This enables administrators to monitor I/O
> patterns at the subvolume granularity, which is useful for multi-tenant
> CephFS deployments where different subvolumes may be allocated to
> different users or applications.
>=20
> The implementation requires protocol changes to receive the subvolume_id
> from the MDS (InodeStat v9), and introduces a new metrics type
> (CLIENT_METRIC_TYPE_SUBVOLUME_METRICS) for reporting aggregated I/O
> statistics back to the MDS.
>=20
> Patch 1 adds forward-compatible handling for InodeStat v8, which
> introduces the versioned optmetadata field. The kernel client doesn't
> use this field but must skip it properly to parse subsequent fields.
>=20
> Patch 2 adds support for parsing the subvolume_id field from InodeStat
> v9 and storing it in the inode structure for later use. This patch also
> introduces CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset
> state and enforces subvolume_id immutability with WARN_ON_ONCE if
> attempting to change an already-set subvolume_id.
>=20
> Patch 3 adds the complete subvolume metrics infrastructure:
> - CEPHFS_FEATURE_SUBVOLUME_METRICS feature flag for MDS negotiation
> - Red-black tree based metrics tracker for efficient per-subvolume
>   aggregation with kmem_cache for entry allocations
> - Wire format encoding matching the MDS C++ AggregatedIOMetrics struct
> - Integration with the existing CLIENT_METRICS message
> - Recording of I/O operations from file read/write and writeback paths
> - Debugfs interfaces for monitoring
>=20
> Metrics tracked per subvolume include:
> - Read/write operation counts
> - Read/write byte counts
> - Read/write latency sums (for average calculation)
>=20
> The metrics are periodically sent to the MDS as part of the existing
> metrics reporting infrastructure when the MDS advertises support for
> the SUBVOLUME_METRICS feature.
>=20
> Debugfs additions in Patch 3:
> - metrics/subvolumes: displays last sent and pending subvolume metrics
> - metrics/metric_features: displays MDS session feature negotiation
>   status, showing which metric-related features are enabled (including
>   METRIC_COLLECT and SUBVOLUME_METRICS)
>=20
> Changes since v5:
> - Rebased onto latest kernel (resolved conflict with inode_state_read_onc=
e()
>   accessor change in fs/ceph/inode.c)
> - Re-added InodeStat v8 handling patch (patch 1) as it was not actually
>   in the base tree, making this a 3-patch series again
>=20
> Changes since v4:
> - Merged CEPH_SUBVOLUME_ID_NONE and WARN_ON_ONCE immutability check
>   into patch 1 (previously split across patches 2 and 3)
> - Removed unused 'cl' variable from parse_reply_info_in() that would
>   cause compiler warning
> - Added read I/O recording in finish_netfs_read() for netfs read path
> - Simplified subvolume_metrics_dump() to use direct rb-tree iteration
>   instead of intermediate snapshot allocation
> - InodeStat v8 patch now in base tree, reducing series from 3 to 2
>   patches
>=20
> Changes since v3:
> - merged CEPH_SUBVOLUME_ID_NONE patch into its predecessor
>=20
> Changes since v2:
> - Add CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset state
> - Add WARN_ON_ONCE if attempting to change already-set subvolume_id
> - Add documentation for struct ceph_session_feature_desc ('bit' field)
> - Change pr_err() to pr_info() for "metrics disabled" message
> - Use pr_warn_ratelimited() instead of manual __ratelimit()
> - Add documentation comments to ceph_subvol_metric_snapshot and
>   ceph_subvolume_metrics_tracker structs
> - Use kmemdup_array() instead of kmemdup() for overflow checking
> - Add comments explaining ret > 0 checks for read metrics (EOF handling)
> - Use kmem_cache for struct ceph_subvol_metric_rb_entry allocations
> - Add comment explaining seq_file error handling in dump function
>=20
> Changes since v1:
> - Fixed unused variable warnings (v8_struct_v, v8_struct_compat) by
>   using ceph_decode_skip_8() instead of ceph_decode_8_safe()
> - Added detailed comment explaining InodeStat encoding versions v1-v9
> - Clarified that "optmetadata" is the actual field name in MDS C++ code
> - Aligned subvolume_id handling with FUSE client convention (0 =3D unknow=
n)
>=20
> Alex Markuze (3):
>   ceph: handle InodeStat v8 versioned field in reply parsing
>   ceph: parse subvolume_id from InodeStat v9 and store in inode
>   ceph: add subvolume metrics collection and reporting
>=20
>  fs/ceph/Makefile            |   2 +-
>  fs/ceph/addr.c              |  14 ++
>  fs/ceph/debugfs.c           | 157 ++++++++++++++
>  fs/ceph/file.c              |  68 +++++-
>  fs/ceph/inode.c             |  41 ++++
>  fs/ceph/mds_client.c        |  92 ++++++--
>  fs/ceph/mds_client.h        |  14 +-
>  fs/ceph/metric.c            | 183 +++++++++++++++-
>  fs/ceph/metric.h            |  39 +++-
>  fs/ceph/subvolume_metrics.c | 416 ++++++++++++++++++++++++++++++++++++
>  fs/ceph/subvolume_metrics.h |  97 +++++++++
>  fs/ceph/super.c             |   8 +
>  fs/ceph/super.h             |  11 +
>  13 files changed, 1114 insertions(+), 28 deletions(-)
>  create mode 100644 fs/ceph/subvolume_metrics.c
>  create mode 100644 fs/ceph/subvolume_metrics.h
>=20
> --
> 2.34.1
>=20

Let me run xfstests for the patchset. I'll be back with the result ASAP.

Thanks,
Slava.


