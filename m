Return-Path: <linux-fsdevel+bounces-74761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKzsFEsecGlRVwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:31:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E86CE4E85D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C675502A62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EB429DB86;
	Wed, 21 Jan 2026 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6SZd6Mo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ishrvz1Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40729346F
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955435; cv=none; b=j2tbmykLDo+snFjeyTOrYmCSTS6lhlQdrUD7tty+MpaTofsP2fTB7ve7KF27Rm6gHdMLL4q20Hf2NoGLKHfIozHqqHPHMgVDE8f6k0vUo48kOLQsIlwIZj8+7Ekx0ZLOIrGr/Qym5tLmKfmthzauyVLWVzVOhhvaOPJKmJSuvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955435; c=relaxed/simple;
	bh=kqA7hFp0b5pOlAT5k4slsR0tFyV4F1zhBk7jCl4+Sk8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bF8BkEBqXWc7VMqdv6FJd4i2upmJZFwxaB7bKVAKaC38e8JZtKUXY0txUXXhZ34nA8PTndkUOkmDLzbUjONJF+NwwFa5udTDKewpDNcx7S239WRyGmR9UJyG8DRK48Qbq5Z+8OCbo1FiXTxKfhjJ2wuEh0NyuVCNxJ1aH1znzZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6SZd6Mo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ishrvz1Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768955432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nxjbXT0xnBHhhZgM6DIUEflr+8xamjmOI0ttVCQ4KI=;
	b=V6SZd6MoIjgiU/LqJJAfKZ4fCORJ91KkgyVHW/GMqiLJoHEaox0/axQUaDctvWYbs3ycd3
	S2xi2GL8ixVl44qQ53OX0kwTFvHX9k+GvvQDqgGIqNFDfJPQHSFAMBs7MffWsqwpkh7RMx
	e+J1zkS5AX2IP9rSKN0KPML46PdXG3c=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-rdMjo5maPCaWf-aAqXZfQA-1; Tue, 20 Jan 2026 19:30:30 -0500
X-MC-Unique: rdMjo5maPCaWf-aAqXZfQA-1
X-Mimecast-MFC-AGG-ID: rdMjo5maPCaWf-aAqXZfQA_1768955430
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-78f9d077d9cso35643767b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 16:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768955430; x=1769560230; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5nxjbXT0xnBHhhZgM6DIUEflr+8xamjmOI0ttVCQ4KI=;
        b=Ishrvz1QqY2yHzLGZxecr21latunvaF3VSBorqdACzmeit3PAUHt5Div/GTiE4a6R+
         M3js5Q1XQU3OjwQjY7f4I73y6HeYZ3sigDVtfavneElIB+QGDqQ+nsYN/lf/63jbWGa/
         AkR1QpsHYDdWObUR5El0F4rhclAYiXWGJ0M/cVmkpMBIGNI2iBy8z4gLxtnvBcS4FXS4
         jGi+i/tSEcHQk4kdd3KvKKde1+iuv8rSgxb6oZEwzY9bXrLKv7b07GQ2Rw5quAAC6pkq
         wycMrBSXZq5W0wI0ERgGam2EwtE9ZTfn7L5+JZcj1f0tD/Gq2MvOyV+cN8VlUtoKfyBY
         ViJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768955430; x=1769560230;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nxjbXT0xnBHhhZgM6DIUEflr+8xamjmOI0ttVCQ4KI=;
        b=Kd4HQJJY91LG9u11iEw/6jJ2UuvlNyAVmYTHa3tnk9VuJv++BXZjVUgrCpdqdcTK3M
         CP3KZMSpcQscrvZADntPJMUMys7yx/V7TZd8nBGuQh+z2pzH0DI5HVZKZq6tom2Z3g8H
         yf0N/yIb6KovfIQ9qjUgey1msirTyMhoY6TMN/SffRC/GmRxG5pp6ry1gGYLlJyns++E
         lWocvt3y7p3fCRzTamPfeaOZhhUWY50Epgp3KcGQJwbVqNNlOXkA0DI8iUO5orkj85ey
         Ejn+8WvsYF5cfAJK8ZlHKX5FTYoFT1QL+nLa4ntLKDB5uHYuXGuqUFFZ/qQ0QZOn1quT
         KHKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnGQ/mI7BS2ruUV61esJ7nkwnaqZZvZq675dkT7lHUskgcSKIBL/r5mv/bRQQ5BcY1iUT7KIXtTVb/YlYM@vger.kernel.org
X-Gm-Message-State: AOJu0YztLKEJOLkaT4P3jnt1HrhxY6Z8I0xu/nMPyVKMKU1bG3cw4b+n
	SNo12JETDzHef9Kzo/Bx3PxeCiNvpNUATyTq1SSgpNSlp6zaui30fsWqayez8o85pn+yjneZ6aB
	lJHPLn3xaONFlQ9B3/FvhiregqCufU7Or8BBldM4SEB2nb1OB1Jd9wv9Bwm0658hgjJk=
X-Gm-Gg: AZuq6aKMM6ks+JmL/lEyYh9qUElVVvAFPW8xoiWCmQxsMdGOWcCaIj0ue4NmT20Kg21
	OQNQlEu8H9bD5hA+1sHFQanigjbUAcLARiD7WPPTr8S23vYgnLRj0GFb8Q28d1zopqnpU5f5eBs
	UBegqRVC6sr6l84QH523LbFn2VaN7zrAeJlqxx9KhU42pLSV4Jf3g9Wy6Rte/s+OZNSp9uPLzBz
	F4hau00oSI1F/2eow/10u2wQ1QRHIFN/ARLSfis/ogh3VQbkCxDQSJRihDzQ+OyoReU0xYFsxGl
	9C+X7lyjkEF46ltzv7ArHSKuluqNdoFJwB0XHaaeVB4CBHi+VJaGJ37p4MPnvLa4eVdqnQqwlfF
	3/FVdABWVKtt6QAfnt8ONMxaFmAX6/6Lq4KYkOR+Z
X-Received: by 2002:a05:690c:4b85:b0:793:d0b5:9bcb with SMTP id 00721157ae682-7940a153cf5mr30151097b3.24.1768955429900;
        Tue, 20 Jan 2026 16:30:29 -0800 (PST)
X-Received: by 2002:a05:690c:4b85:b0:793:d0b5:9bcb with SMTP id 00721157ae682-7940a153cf5mr30150937b3.24.1768955429529;
        Tue, 20 Jan 2026 16:30:29 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c70f4sm59096427b3.7.2026.01.20.16.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 16:30:29 -0800 (PST)
Message-ID: <8dce90cb96a33a123e5baa1613fde06658523495.camel@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5 0/2] ceph: add subvolume metrics
 reporting support
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Tue, 20 Jan 2026 16:30:28 -0800
In-Reply-To: <721bc15d532ea4dd03e079bd516f332208fa48c2.camel@redhat.com>
References: <20260118182446.3514417-1-amarkuze@redhat.com>
	 <721bc15d532ea4dd03e079bd516f332208fa48c2.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74761-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E86CE4E85D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-01-20 at 16:18 -0800, Viacheslav Dubeyko wrote:
> On Sun, 2026-01-18 at 18:24 +0000, Alex Markuze wrote:
> > This patch series adds support for per-subvolume I/O metrics collection
> > and reporting to the MDS. This enables administrators to monitor I/O
> > patterns at the subvolume granularity, which is useful for multi-tenant
> > CephFS deployments where different subvolumes may be allocated to
> > different users or applications.
> >=20
> > The implementation requires protocol changes to receive the subvolume_i=
d
> > from the MDS (InodeStat v9), and introduces a new metrics type
> > (CLIENT_METRIC_TYPE_SUBVOLUME_METRICS) for reporting aggregated I/O
> > statistics back to the MDS.
> >=20
> > Note: The InodeStat v8 handling patch (forward-compatible handling for
> > the versioned optmetadata field) is now in the base tree, so this serie=
s
> > starts with v9 parsing.
> >=20
> > Patch 1 adds support for parsing the subvolume_id field from InodeStat
> > v9 and storing it in the inode structure for later use. This patch also
> > introduces CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset
> > state and enforces subvolume_id immutability with WARN_ON_ONCE if
> > attempting to change an already-set subvolume_id.
> >=20
> > Patch 2 adds the complete subvolume metrics infrastructure:
> > - CEPHFS_FEATURE_SUBVOLUME_METRICS feature flag for MDS negotiation
> > - Red-black tree based metrics tracker for efficient per-subvolume
> >   aggregation with kmem_cache for entry allocations
> > - Wire format encoding matching the MDS C++ AggregatedIOMetrics struct
> > - Integration with the existing CLIENT_METRICS message
> > - Recording of I/O operations from file read/write and writeback paths
> > - Debugfs interfaces for monitoring
> >=20
> > Metrics tracked per subvolume include:
> > - Read/write operation counts
> > - Read/write byte counts
> > - Read/write latency sums (for average calculation)
> >=20
> > The metrics are periodically sent to the MDS as part of the existing
> > metrics reporting infrastructure when the MDS advertises support for
> > the SUBVOLUME_METRICS feature.
> >=20
> > Debugfs additions in Patch 2:
> > - metrics/subvolumes: displays last sent and pending subvolume metrics
> > - metrics/metric_features: displays MDS session feature negotiation
> >   status, showing which metric-related features are enabled (including
> >   METRIC_COLLECT and SUBVOLUME_METRICS)
> >=20
> > Changes since v4:
> > - Merged CEPH_SUBVOLUME_ID_NONE and WARN_ON_ONCE immutability check
> >   into patch 1 (previously split across patches 2 and 3)
> > - Removed unused 'cl' variable from parse_reply_info_in() that would
> >   cause compiler warning
> > - Added read I/O recording in finish_netfs_read() for netfs read path
> > - Simplified subvolume_metrics_dump() to use direct rb-tree iteration
> >   instead of intermediate snapshot allocation
> > - InodeStat v8 patch now in base tree, reducing series from 3 to 2
> >   patches
> >=20
> > Changes since v3:
> > - merged CEPH_SUBVOLUME_ID_NONE patch into its predecessor
> >=20
> > Changes since v2:
> > - Add CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset state
> > - Add WARN_ON_ONCE if attempting to change already-set subvolume_id
> > - Add documentation for struct ceph_session_feature_desc ('bit' field)
> > - Change pr_err() to pr_info() for "metrics disabled" message
> > - Use pr_warn_ratelimited() instead of manual __ratelimit()
> > - Add documentation comments to ceph_subvol_metric_snapshot and
> >   ceph_subvolume_metrics_tracker structs
> > - Use kmemdup_array() instead of kmemdup() for overflow checking
> > - Add comments explaining ret > 0 checks for read metrics (EOF handling=
)
> > - Use kmem_cache for struct ceph_subvol_metric_rb_entry allocations
> > - Add comment explaining seq_file error handling in dump function
> >=20
> > Changes since v1:
> > - Fixed unused variable warnings (v8_struct_v, v8_struct_compat) by
> >   using ceph_decode_skip_8() instead of ceph_decode_8_safe()
> > - Added detailed comment explaining InodeStat encoding versions v1-v9
> > - Clarified that "optmetadata" is the actual field name in MDS C++ code
> > - Aligned subvolume_id handling with FUSE client convention (0 =3D unkn=
own)
> >=20
> >=20
> > Alex Markuze (2):
> >   ceph: parse subvolume_id from InodeStat v9 and store in inode
> >   ceph: add subvolume metrics collection and reporting
> >=20
> >  fs/ceph/Makefile            |   2 +-
> >  fs/ceph/addr.c              |  14 ++
> >  fs/ceph/debugfs.c           | 157 +++++++++++++++++
> >  fs/ceph/file.c              |  68 +++++++-
> >  fs/ceph/inode.c             |  41 +++++
> >  fs/ceph/mds_client.c        |  72 ++++++--
> >  fs/ceph/mds_client.h        |  14 +-
> >  fs/ceph/metric.c            | 183 ++++++++++++++++++-
> >  fs/ceph/metric.h            |  39 ++++-
> >  fs/ceph/subvolume_metrics.c | 416 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  fs/ceph/subvolume_metrics.h |  97 +++++++++++
> >  fs/ceph/super.c             |   8 +
> >  fs/ceph/super.h             |  11 ++
> >  13 files changed, 1094 insertions(+), 28 deletions(-)
> >  create mode 100644 fs/ceph/subvolume_metrics.c
> >  create mode 100644 fs/ceph/subvolume_metrics.h
> >=20
> > --
> > 2.34.1
>=20
> Let me run xfstests on the patchset. I'll be back with the results ASAP.
>=20

I have troubles to apply your pathset on Linux kernel 6.19-rc6:

git am ./v5_20260118_amarkuze_ceph_add_subvolume_metrics_reporting_support.=
mbx
Applying: ceph: handle InodeStat v8 versioned field in reply parsing
Applying: ceph: parse subvolume_id from InodeStat v9 and store in inode
error: patch failed: fs/ceph/inode.c:742
error: fs/ceph/inode.c: patch does not apply
Patch failed at 0002 ceph: parse subvolume_id from InodeStat v9 and store i=
n
inode
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Which is your code base? Which branch have you used as base one?

Thanks,
Slava.


