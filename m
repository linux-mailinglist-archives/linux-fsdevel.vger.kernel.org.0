Return-Path: <linux-fsdevel+bounces-72206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF228CE81A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 21:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AFDD30184DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 20:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD766261595;
	Mon, 29 Dec 2025 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJqftLC3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSckxrhH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091211F3BA4
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767038856; cv=none; b=YGBIkROpwcjZYsH2tcoaeCb4B29v5EnxRWODfl9VgcXPy8JV34FACx12KhaVF9kXucictmvL3x41UreYOSl0lNnCx+4B+XJ37H9jvO5GO9kIVNYgPfqUp26HwKkzjcfV6jUpX7sNsPmdqAAI0GQXglpRC9zhd5orAXH12NzNuiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767038856; c=relaxed/simple;
	bh=qF0u5JM6ugKSuDNLWyUwccZ5LnezRU3BlReS8zYwn6Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nk0YzhFLzdYyEURCxyhXkCC8ZMJNAKjFI4t3wUP3PXl5Hczxjc0q/llATH/TAZDfDuw7lIscbL16SyuLpygdLSWZQCpdf1u3E+oHrjXAUClEscRtgwCylpAjqNCx8CYWK0GVlcrhVUNnlVEoX3Fba5yR7BfcieH9CLmd4JVRnx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJqftLC3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSckxrhH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767038849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCfuPUuAlnP3wZYoePb6hZeae28nyidc1LN1OxiXjBU=;
	b=UJqftLC3FknNRte4iXDOpBd5ynSe9K5HJyVUSCUb3gF6fDktbW4ZHgSF4sgDnaW2ZcaId0
	c1Di+bDihT6IXvmMMblFGIsWli/VCyyG0mbrILxfWUTUFh7QoxRwyjyhsLorYSaP6gLXpM
	x3t6qYTZXJk4yNxA/GNGlX9BdD6zHow=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-Gavpg6tPNqKFt9qZI6GJrg-1; Mon, 29 Dec 2025 15:07:28 -0500
X-MC-Unique: Gavpg6tPNqKFt9qZI6GJrg-1
X-Mimecast-MFC-AGG-ID: Gavpg6tPNqKFt9qZI6GJrg_1767038848
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7900ab6755fso44896817b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 12:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767038847; x=1767643647; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RCfuPUuAlnP3wZYoePb6hZeae28nyidc1LN1OxiXjBU=;
        b=GSckxrhH8yjW9cYRD1E8VtQ28qog8PdSYNk9kFMlFo2E7PDRM/BA64P8OICjcLJkbT
         oAqZIY9/I17Xh7AJlR0K+2HjVOo9Eph+oZxMrNkrFw4MoUuJOwRhuLiViZEDNWZxTpVw
         kCrOfeZcQb8X0A/IbmVK4sd12cduZAYXY5V0hSAMA/VMSrhEv5ukiSVk7wYF8Pbuj0Wg
         U5CZMjl6hPAsIYeeUgUEVGXqM8gRWaUS7pzE+CfaDhC84yWPER3wb3mtV3QThAQysGRx
         YVLkvAY0FNMWsm5R8Ve12JqImbbBiGphQMFV7Ygf/xzMs6SwbyNHtmc3IIeJM83VQEyz
         GQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767038847; x=1767643647;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCfuPUuAlnP3wZYoePb6hZeae28nyidc1LN1OxiXjBU=;
        b=pN/QPkmGTcSK90+5e2bOFUhQjSBfE+jDN2N8U3XzwFxilEr6pI9BfS1dohuvL2MaID
         ymbO+hII0Pp6fMoSASOL5brUNNAd2Y0tZFEMApEjs7cd8Zk8zaaOOPj08YElhdyIbuH8
         JjcPaqpZLMu2pd6RN+fZOS8JVMglLvJeMf6gO7AwIkeMwyiK4nUsdLxktBSJZegNfEju
         G5H7BFaOAA21JTKlHO0+a8kp5lCU7eYnyCtQhnstGsMkpPXerKS/mlR669R80BJMv2no
         +b6yAD5r4sCfnHrGJCn0LjrTUuktgflENaSW/qgDl5KZLQEu+okCE2Ifr3wYfKjwRMSr
         uliA==
X-Forwarded-Encrypted: i=1; AJvYcCUV6bj1/S6f2IzxK+FFckqSL2VGCIWgYRJV18uwIRjIRDCIUKUMmgk++Z74lbE6tBPBGsizNkXsLrkypANk@vger.kernel.org
X-Gm-Message-State: AOJu0YyBACwqG3dDRensBSz45YBpe66tsAJiUtXadCkhPhcLG0hMIPDV
	98/jC0OOgDXgNCmBAiyoIH7cAgnO+FG52K+0qacFdwcSijMIXWAxQgFRvZZm2ZMQXslACTabEq2
	ZuX/fr4N11X65ArlVdJ474g0hc77Bcuc5V+zM5sC/AHd+BqT8MZX8zOxD2LPxpDqwxNg=
X-Gm-Gg: AY/fxX4Seo2zXd2jFr4Kgf3xtBubdvMmwe+eUvBEiiehF9a/Wy6KzlErdz1L3h0s+Ap
	dS/bFeaVju0QlFhTcKf3JWom2c/Wjc4SScNbmwvJFlUHZvZpUhzzf3i+LvvpJkiGgibiW3hkIoN
	QzO0DCeU49gd2P04D95i5tmcV9DZA5W8OGaIjOHPUdiTajogoQLcd4LDXvTmOQZIjaOX+Ax7cA3
	AUrr5oEFv2SGZdsj821WNws0SpCr3p0RV1J/W5G4junTLgmPT1S8oLro2MT8ytsZQCLf+C8qLW1
	maQwV/HkS5Cz9c8hJh/VEOQyC0uZnye4ZP412sLRLmbX3LYwo4QOjP+uM03NNeS3HQtRySsMYYb
	jN9Vjpn9dFRarjL4hDFVb71Bf7jwZ9hXzxwAzmaif
X-Received: by 2002:a05:690c:893:b0:787:e3c1:92 with SMTP id 00721157ae682-78fb40922e3mr257742417b3.61.1767038847120;
        Mon, 29 Dec 2025 12:07:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTvla3VPIl/7uM+hbHF2dmFbPDpYohjWcq8FRTMuSDspuCs63yIOWf8mA3GAvU3IjWEft/KA==
X-Received: by 2002:a05:690c:893:b0:787:e3c1:92 with SMTP id 00721157ae682-78fb40922e3mr257742007b3.61.1767038846268;
        Mon, 29 Dec 2025 12:07:26 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4562df4sm117656377b3.55.2025.12.29.12.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 12:07:25 -0800 (PST)
Message-ID: <e2301eb9e41dc095f729daf59f08976280ed9a7a.camel@redhat.com>
Subject: Re: [PATCH v4 3/3] ceph: add subvolume metrics collection and
 reporting
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Mon, 29 Dec 2025 12:07:24 -0800
In-Reply-To: <20251223123510.796459-4-amarkuze@redhat.com>
References: <20251223123510.796459-1-amarkuze@redhat.com>
	 <20251223123510.796459-4-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-23 at 12:35 +0000, Alex Markuze wrote:
> Add complete subvolume metrics infrastructure for tracking and reporting
> per-subvolume I/O metrics to the MDS. This enables administrators to
> monitor I/O patterns at the subvolume granularity.
>=20
> The implementation includes:
>=20
> - New CEPHFS_FEATURE_SUBVOLUME_METRICS feature flag for MDS negotiation
> - Red-black tree based metrics tracker (subvolume_metrics.c/h)
> - Wire format encoding matching the MDS C++ AggregatedIOMetrics struct
> - Integration with the existing metrics reporting infrastructure
> - Recording of I/O operations from file read/write paths
> - Debugfs interface for monitoring collected metrics
>=20
> Metrics tracked per subvolume:
> - Read/write operation counts
> - Read/write byte counts
> - Read/write latency sums (for average calculation)
>=20
> The metrics are periodically sent to the MDS as part of the existing
> CLIENT_METRICS message when the MDS advertises support for the
> SUBVOLUME_METRICS feature.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/Makefile            |   2 +-
>  fs/ceph/addr.c              |  10 +
>  fs/ceph/debugfs.c           | 159 +++++++++++++
>  fs/ceph/file.c              |  68 +++++-
>  fs/ceph/inode.c             |  32 ++-
>  fs/ceph/mds_client.c        |  69 ++++--
>  fs/ceph/mds_client.h        |  13 +-
>  fs/ceph/metric.c            | 173 ++++++++++++++-
>  fs/ceph/metric.h            |  27 ++-
>  fs/ceph/subvolume_metrics.c | 432 ++++++++++++++++++++++++++++++++++++
>  fs/ceph/subvolume_metrics.h |  97 ++++++++
>  fs/ceph/super.c             |   8 +
>  fs/ceph/super.h             |  11 +-
>  13 files changed, 1064 insertions(+), 37 deletions(-)
>  create mode 100644 fs/ceph/subvolume_metrics.c
>  create mode 100644 fs/ceph/subvolume_metrics.h
>=20
> diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
> index 1f77ca04c426..ebb29d11ac22 100644
> --- a/fs/ceph/Makefile
> +++ b/fs/ceph/Makefile
> @@ -8,7 +8,7 @@ obj-$(CONFIG_CEPH_FS) +=3D ceph.o
>  ceph-y :=3D super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
>  	export.o caps.o snap.o xattr.o quota.o io.o \
>  	mds_client.o mdsmap.o strings.o ceph_frag.o \
> -	debugfs.o util.o metric.o
> +	debugfs.o util.o metric.o subvolume_metrics.o
> =20
>  ceph-$(CONFIG_CEPH_FSCACHE) +=3D cache.o
>  ceph-$(CONFIG_CEPH_FS_POSIX_ACL) +=3D acl.o
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 322ed268f14a..feae80dc2816 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -19,6 +19,7 @@
>  #include "mds_client.h"
>  #include "cache.h"
>  #include "metric.h"
> +#include "subvolume_metrics.h"
>  #include "crypto.h"
>  #include <linux/ceph/osd_client.h>
>  #include <linux/ceph/striper.h>
> @@ -823,6 +824,10 @@ static int write_folio_nounlock(struct folio *folio,
> =20
>  	ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
>  				  req->r_end_latency, len, err);
> +	if (err >=3D 0 && len > 0)
> +		ceph_subvolume_metrics_record_io(fsc->mdsc, ci, true, len,
> +						 req->r_start_latency,
> +						 req->r_end_latency);
>  	fscrypt_free_bounce_page(bounce_page);
>  	ceph_osdc_put_request(req);
>  	if (err =3D=3D 0)
> @@ -963,6 +968,11 @@ static void writepages_finish(struct ceph_osd_reques=
t *req)
>  	ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
>  				  req->r_end_latency, len, rc);
> =20
> +	if (rc >=3D 0 && len > 0)
> +		ceph_subvolume_metrics_record_io(mdsc, ci, true, len,
> +						 req->r_start_latency,
> +						 req->r_end_latency);
> +
>  	ceph_put_wrbuffer_cap_refs(ci, total_pages, snapc);
> =20
>  	osd_data =3D osd_req_op_extent_osd_data(req, 0);
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index f3fe786b4143..d49069a90f91 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -9,11 +9,13 @@
>  #include <linux/seq_file.h>
>  #include <linux/math64.h>
>  #include <linux/ktime.h>
> +#include <linux/atomic.h>
> =20
>  #include <linux/ceph/libceph.h>
>  #include <linux/ceph/mon_client.h>
>  #include <linux/ceph/auth.h>
>  #include <linux/ceph/debugfs.h>
> +#include <linux/ceph/decode.h>
> =20
>  #include "super.h"
> =20
> @@ -21,6 +23,38 @@
> =20
>  #include "mds_client.h"
>  #include "metric.h"
> +#include "subvolume_metrics.h"
> +
> +extern bool disable_send_metrics;
> +
> +/**
> + * struct ceph_session_feature_desc - Maps feature bits to names for deb=
ugfs
> + * @bit: Feature bit number from enum ceph_feature_type (see mds_client.=
h)
> + * @name: Human-readable feature name for debugfs output
> + *
> + * Used by metric_features_show() to display negotiated session features=
.
> + */
> +struct ceph_session_feature_desc {
> +	unsigned int bit;
> +	const char *name;
> +};
> +
> +static const struct ceph_session_feature_desc ceph_session_feature_table=
[] =3D {
> +	{ CEPHFS_FEATURE_METRIC_COLLECT, "METRIC_COLLECT" },
> +	{ CEPHFS_FEATURE_REPLY_ENCODING, "REPLY_ENCODING" },
> +	{ CEPHFS_FEATURE_RECLAIM_CLIENT, "RECLAIM_CLIENT" },
> +	{ CEPHFS_FEATURE_LAZY_CAP_WANTED, "LAZY_CAP_WANTED" },
> +	{ CEPHFS_FEATURE_MULTI_RECONNECT, "MULTI_RECONNECT" },
> +	{ CEPHFS_FEATURE_DELEG_INO, "DELEG_INO" },
> +	{ CEPHFS_FEATURE_ALTERNATE_NAME, "ALTERNATE_NAME" },
> +	{ CEPHFS_FEATURE_NOTIFY_SESSION_STATE, "NOTIFY_SESSION_STATE" },
> +	{ CEPHFS_FEATURE_OP_GETVXATTR, "OP_GETVXATTR" },
> +	{ CEPHFS_FEATURE_32BITS_RETRY_FWD, "32BITS_RETRY_FWD" },
> +	{ CEPHFS_FEATURE_NEW_SNAPREALM_INFO, "NEW_SNAPREALM_INFO" },
> +	{ CEPHFS_FEATURE_HAS_OWNER_UIDGID, "HAS_OWNER_UIDGID" },
> +	{ CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK, "MDS_AUTH_CAPS_CHECK" },
> +	{ CEPHFS_FEATURE_SUBVOLUME_METRICS, "SUBVOLUME_METRICS" },
> +};
> =20
>  static int mdsmap_show(struct seq_file *s, void *p)
>  {
> @@ -360,6 +394,59 @@ static int status_show(struct seq_file *s, void *p)
>  	return 0;
>  }
> =20
> +static int subvolume_metrics_show(struct seq_file *s, void *p)
> +{
> +	struct ceph_fs_client *fsc =3D s->private;
> +	struct ceph_mds_client *mdsc =3D fsc->mdsc;
> +	struct ceph_subvol_metric_snapshot *snapshot =3D NULL;
> +	u32 nr =3D 0;
> +	u64 total_sent =3D 0;
> +	u64 nonzero_sends =3D 0;
> +	u32 i;
> +
> +	if (!mdsc) {
> +		seq_puts(s, "mds client unavailable\n");
> +		return 0;
> +	}
> +
> +	mutex_lock(&mdsc->subvol_metrics_last_mutex);
> +	if (mdsc->subvol_metrics_last && mdsc->subvol_metrics_last_nr) {
> +		nr =3D mdsc->subvol_metrics_last_nr;
> +		snapshot =3D kmemdup_array(mdsc->subvol_metrics_last, nr,
> +					 sizeof(*snapshot), GFP_KERNEL);
> +		if (!snapshot)
> +			nr =3D 0;
> +	}
> +	total_sent =3D mdsc->subvol_metrics_sent;
> +	nonzero_sends =3D mdsc->subvol_metrics_nonzero_sends;
> +	mutex_unlock(&mdsc->subvol_metrics_last_mutex);
> +
> +	seq_puts(s, "Last sent subvolume metrics:\n");
> +	if (!nr) {
> +		seq_puts(s, "  (none)\n");
> +	} else {
> +		seq_puts(s, "  subvol_id          rd_ops    wr_ops    rd_bytes       w=
r_bytes       rd_lat_us      wr_lat_us\n");
> +		for (i =3D 0; i < nr; i++) {
> +			const struct ceph_subvol_metric_snapshot *e =3D &snapshot[i];
> +
> +			seq_printf(s, "  %-18llu %-9llu %-9llu %-14llu %-14llu %-14llu %-14ll=
u\n",
> +				   e->subvolume_id,
> +				   e->read_ops, e->write_ops,
> +				   e->read_bytes, e->write_bytes,
> +				   e->read_latency_us, e->write_latency_us);
> +		}
> +	}
> +	kfree(snapshot);
> +
> +	seq_puts(s, "\nStatistics:\n");
> +	seq_printf(s, "  entries_sent:      %llu\n", total_sent);
> +	seq_printf(s, "  non_zero_sends:    %llu\n", nonzero_sends);
> +
> +	seq_puts(s, "\nPending (unsent) subvolume metrics:\n");
> +	ceph_subvolume_metrics_dump(&mdsc->subvol_metrics, s);
> +	return 0;
> +}
> +
>  DEFINE_SHOW_ATTRIBUTE(mdsmap);
>  DEFINE_SHOW_ATTRIBUTE(mdsc);
>  DEFINE_SHOW_ATTRIBUTE(caps);
> @@ -369,7 +456,72 @@ DEFINE_SHOW_ATTRIBUTE(metrics_file);
>  DEFINE_SHOW_ATTRIBUTE(metrics_latency);
>  DEFINE_SHOW_ATTRIBUTE(metrics_size);
>  DEFINE_SHOW_ATTRIBUTE(metrics_caps);
> +DEFINE_SHOW_ATTRIBUTE(subvolume_metrics);
> +
> +static int metric_features_show(struct seq_file *s, void *p)
> +{
> +	struct ceph_fs_client *fsc =3D s->private;
> +	struct ceph_mds_client *mdsc =3D fsc->mdsc;
> +	unsigned long session_features =3D 0;
> +	bool have_session =3D false;
> +	bool metric_collect =3D false;
> +	bool subvol_support =3D false;
> +	bool metrics_enabled =3D false;
> +	bool subvol_enabled =3D false;
> +	int i;
> +
> +	if (!mdsc) {
> +		seq_puts(s, "mds client unavailable\n");
> +		return 0;
> +	}
> +
> +	mutex_lock(&mdsc->mutex);
> +	if (mdsc->metric.session) {
> +		have_session =3D true;
> +		session_features =3D mdsc->metric.session->s_features;
> +	}
> +	mutex_unlock(&mdsc->mutex);
> +
> +	if (have_session) {
> +		metric_collect =3D
> +			test_bit(CEPHFS_FEATURE_METRIC_COLLECT,
> +				 &session_features);
> +		subvol_support =3D
> +			test_bit(CEPHFS_FEATURE_SUBVOLUME_METRICS,
> +				 &session_features);
> +	}
> +
> +	metrics_enabled =3D !disable_send_metrics && have_session && metric_col=
lect;
> +	subvol_enabled =3D metrics_enabled && subvol_support;
> +
> +	seq_printf(s,
> +		   "metrics_enabled: %s (disable_send_metrics=3D%d, session=3D%s, metr=
ic_collect=3D%s)\n",
> +		   metrics_enabled ? "yes" : "no",
> +		   disable_send_metrics ? 1 : 0,
> +		   have_session ? "yes" : "no",
> +		   metric_collect ? "yes" : "no");
> +	seq_printf(s, "subvolume_metrics_enabled: %s\n",
> +		   subvol_enabled ? "yes" : "no");
> +	seq_printf(s, "session_feature_bits: 0x%lx\n", session_features);
> +
> +	if (!have_session) {
> +		seq_puts(s, "(no active MDS session for metrics)\n");
> +		return 0;
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ceph_session_feature_table); i++) {
> +		const struct ceph_session_feature_desc *desc =3D
> +			&ceph_session_feature_table[i];
> +		bool set =3D test_bit(desc->bit, &session_features);
> +
> +		seq_printf(s, "  %-24s : %s\n", desc->name,
> +			   set ? "yes" : "no");
> +	}
> +
> +	return 0;
> +}
> =20
> +DEFINE_SHOW_ATTRIBUTE(metric_features);
> =20
>  /*
>   * debugfs
> @@ -404,6 +556,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *f=
sc)
>  	debugfs_remove(fsc->debugfs_caps);
>  	debugfs_remove(fsc->debugfs_status);
>  	debugfs_remove(fsc->debugfs_mdsc);
> +	debugfs_remove(fsc->debugfs_subvolume_metrics);
>  	debugfs_remove_recursive(fsc->debugfs_metrics_dir);
>  	doutc(fsc->client, "done\n");
>  }
> @@ -468,6 +621,12 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc=
)
>  			    &metrics_size_fops);
>  	debugfs_create_file("caps", 0400, fsc->debugfs_metrics_dir, fsc,
>  			    &metrics_caps_fops);
> +	debugfs_create_file("metric_features", 0400, fsc->debugfs_metrics_dir,
> +			    fsc, &metric_features_fops);
> +	fsc->debugfs_subvolume_metrics =3D
> +		debugfs_create_file("subvolumes", 0400,
> +				    fsc->debugfs_metrics_dir, fsc,
> +				    &subvolume_metrics_fops);
>  	doutc(fsc->client, "done\n");
>  }
> =20
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 99b30f784ee2..8f4425fde171 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -19,6 +19,25 @@
>  #include "cache.h"
>  #include "io.h"
>  #include "metric.h"
> +#include "subvolume_metrics.h"
> +
> +/*
> + * Record I/O for subvolume metrics tracking.
> + *
> + * Callers must ensure bytes > 0 for reads (ret > 0 check) to avoid coun=
ting
> + * EOF as an I/O operation. For writes, the condition is (ret >=3D 0 && =
len > 0).
> + */
> +static inline void ceph_record_subvolume_io(struct inode *inode, bool is=
_write,
> +					    ktime_t start, ktime_t end,
> +					    size_t bytes)
> +{
> +	if (!bytes)
> +		return;
> +
> +	ceph_subvolume_metrics_record_io(ceph_sb_to_mdsc(inode->i_sb),
> +					 ceph_inode(inode),
> +					 is_write, bytes, start, end);
> +}
> =20
>  static __le32 ceph_flags_sys2wire(struct ceph_mds_client *mdsc, u32 flag=
s)
>  {
> @@ -1140,6 +1159,15 @@ ssize_t __ceph_sync_read(struct inode *inode, loff=
_t *ki_pos,
>  					 req->r_start_latency,
>  					 req->r_end_latency,
>  					 read_len, ret);
> +		/*
> +		 * Only record subvolume metrics for actual bytes read.
> +		 * ret =3D=3D 0 means EOF (no data), not an I/O operation.
> +		 */
> +		if (ret > 0)
> +			ceph_record_subvolume_io(inode, false,
> +						 req->r_start_latency,
> +						 req->r_end_latency,
> +						 ret);
> =20
>  		if (ret > 0)
>  			objver =3D req->r_version;
> @@ -1385,12 +1413,23 @@ static void ceph_aio_complete_req(struct ceph_osd=
_request *req)
> =20
>  	/* r_start_latency =3D=3D 0 means the request was not submitted */
>  	if (req->r_start_latency) {
> -		if (aio_req->write)
> +		if (aio_req->write) {
>  			ceph_update_write_metrics(metric, req->r_start_latency,
>  						  req->r_end_latency, len, rc);
> -		else
> +			if (rc >=3D 0 && len)
> +				ceph_record_subvolume_io(inode, true,
> +							 req->r_start_latency,
> +							 req->r_end_latency,
> +							 len);
> +		} else {
>  			ceph_update_read_metrics(metric, req->r_start_latency,
>  						 req->r_end_latency, len, rc);
> +			if (rc > 0)
> +				ceph_record_subvolume_io(inode, false,
> +							 req->r_start_latency,
> +							 req->r_end_latency,
> +							 rc);
> +		}
>  	}
> =20
>  	put_bvecs(osd_data->bvec_pos.bvecs, osd_data->num_bvecs,
> @@ -1614,12 +1653,23 @@ ceph_direct_read_write(struct kiocb *iocb, struct=
 iov_iter *iter,
>  		ceph_osdc_start_request(req->r_osdc, req);
>  		ret =3D ceph_osdc_wait_request(&fsc->client->osdc, req);
> =20
> -		if (write)
> +		if (write) {
>  			ceph_update_write_metrics(metric, req->r_start_latency,
>  						  req->r_end_latency, len, ret);
> -		else
> +			if (ret >=3D 0 && len)
> +				ceph_record_subvolume_io(inode, true,
> +							 req->r_start_latency,
> +							 req->r_end_latency,
> +							 len);
> +		} else {
>  			ceph_update_read_metrics(metric, req->r_start_latency,
>  						 req->r_end_latency, len, ret);
> +			if (ret > 0)
> +				ceph_record_subvolume_io(inode, false,
> +							 req->r_start_latency,
> +							 req->r_end_latency,
> +							 ret);
> +		}
> =20
>  		size =3D i_size_read(inode);
>  		if (!write) {
> @@ -1872,6 +1922,11 @@ ceph_sync_write(struct kiocb *iocb, struct iov_ite=
r *from, loff_t pos,
>  						 req->r_start_latency,
>  						 req->r_end_latency,
>  						 read_len, ret);
> +			if (ret > 0)
> +				ceph_record_subvolume_io(inode, false,
> +							 req->r_start_latency,
> +							 req->r_end_latency,
> +							 ret);
> =20
>  			/* Ok if object is not already present */
>  			if (ret =3D=3D -ENOENT) {
> @@ -2036,6 +2091,11 @@ ceph_sync_write(struct kiocb *iocb, struct iov_ite=
r *from, loff_t pos,
> =20
>  		ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
>  					  req->r_end_latency, len, ret);
> +		if (ret >=3D 0 && write_len)
> +			ceph_record_subvolume_io(inode, true,
> +						 req->r_start_latency,
> +						 req->r_end_latency,
> +						 write_len);
>  		ceph_osdc_put_request(req);
>  		if (ret !=3D 0) {
>  			doutc(cl, "osd write returned %d\n", ret);
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 835049004047..257b3e27b741 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -638,7 +638,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb=
)
> =20
>  	ci->i_max_bytes =3D 0;
>  	ci->i_max_files =3D 0;
> -	ci->i_subvolume_id =3D 0;
> +	ci->i_subvolume_id =3D CEPH_SUBVOLUME_ID_NONE;

It completely doesn't make sense to introduce:

+	ci->i_subvolume_id =3D 0;

in patch 2/3 and, then, re-write it in patch 3/3 by this:

+	ci->i_subvolume_id =3D CEPH_SUBVOLUME_ID_NONE;

> =20
>  	memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
>  	memset(&ci->i_cached_layout, 0, sizeof(ci->i_cached_layout));
> @@ -743,7 +743,7 @@ void ceph_evict_inode(struct inode *inode)
> =20
>  	percpu_counter_dec(&mdsc->metric.total_inodes);
> =20
> -	ci->i_subvolume_id =3D 0;
> +	ci->i_subvolume_id =3D CEPH_SUBVOLUME_ID_NONE;

Ditto.

> =20
>  	netfs_wait_for_outstanding_io(inode);
>  	truncate_inode_pages_final(&inode->i_data);
> @@ -877,19 +877,37 @@ int ceph_fill_file_size(struct inode *inode, int is=
sued,
>  }
> =20
>  /*
> - * Set the subvolume ID for an inode. Following the FUSE client conventi=
on,
> - * 0 means unknown/unset (MDS only sends non-zero IDs for subvolume inod=
es).
> + * Set the subvolume ID for an inode.
> + *
> + * The subvolume_id identifies which CephFS subvolume this inode belongs=
 to.
> + * CEPH_SUBVOLUME_ID_NONE (0) means unknown/unset - the MDS only sends
> + * non-zero IDs for inodes within subvolumes.
> + *
> + * An inode's subvolume membership is immutable - once an inode is creat=
ed
> + * in a subvolume, it stays there. Therefore, if we already have a valid
> + * (non-zero) subvolume_id and receive a different one, that indicates a=
 bug.
>   */
>  void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id)
>  {
>  	struct ceph_inode_info *ci;
> +	u64 old;
> =20
> -	if (!inode || !subvolume_id)
> +	if (!inode || subvolume_id =3D=3D CEPH_SUBVOLUME_ID_NONE)

Ditto.

>  		return;
> =20
>  	ci =3D ceph_inode(inode);
> -	if (READ_ONCE(ci->i_subvolume_id) !=3D subvolume_id)
> -		WRITE_ONCE(ci->i_subvolume_id, subvolume_id);
> +	old =3D READ_ONCE(ci->i_subvolume_id);
> +
> +	if (old =3D=3D subvolume_id)
> +		return;
> +
> +	if (old !=3D CEPH_SUBVOLUME_ID_NONE) {
> +		/* subvolume_id should not change once set */
> +		WARN_ON_ONCE(1);
> +		return;
> +	}
> +
> +	WRITE_ONCE(ci->i_subvolume_id, subvolume_id);
>  }
> =20
>  void ceph_fill_file_time(struct inode *inode, int issued,
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 099b8f22683b..f2a17e11fcef 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -67,6 +67,22 @@ static void ceph_cap_reclaim_work(struct work_struct *=
work);
> =20
>  static const struct ceph_connection_operations mds_con_ops;
> =20
> +static void ceph_metric_bind_session(struct ceph_mds_client *mdsc,
> +				     struct ceph_mds_session *session)
> +{
> +	struct ceph_mds_session *old;
> +
> +	if (!mdsc || !session || disable_send_metrics)
> +		return;
> +
> +	old =3D mdsc->metric.session;
> +	mdsc->metric.session =3D ceph_get_mds_session(session);
> +	if (old)
> +		ceph_put_mds_session(old);
> +
> +	metric_schedule_delayed(&mdsc->metric);
> +}
> +
> =20
>  /*
>   * mds reply parsing
> @@ -95,21 +111,20 @@ static int parse_reply_info_quota(void **p, void *en=
d,
>  	return -EIO;
>  }
> =20
> -/*
> - * parse individual inode info
> - */
>  static int parse_reply_info_in(void **p, void *end,
>  			       struct ceph_mds_reply_info_in *info,
> -			       u64 features)
> +			       u64 features,
> +			       struct ceph_mds_client *mdsc)
>  {
>  	int err =3D 0;
>  	u8 struct_v =3D 0;
> +	u8 struct_compat =3D 0;
> +	u32 struct_len =3D 0;
> +	struct ceph_client *cl =3D mdsc ? mdsc->fsc->client : NULL;
> =20
> -	info->subvolume_id =3D 0;
> +	info->subvolume_id =3D CEPH_SUBVOLUME_ID_NONE;

Ditto.

> =20
>  	if (features =3D=3D (u64)-1) {
> -		u32 struct_len;
> -		u8 struct_compat;
>  		ceph_decode_8_safe(p, end, struct_v, bad);
>  		ceph_decode_8_safe(p, end, struct_compat, bad);
>  		/* struct_v is expected to be >=3D 1. we only understand
> @@ -389,12 +404,13 @@ static int parse_reply_info_lease(void **p, void *e=
nd,
>   */
>  static int parse_reply_info_trace(void **p, void *end,
>  				  struct ceph_mds_reply_info_parsed *info,
> -				  u64 features)
> +				  u64 features,
> +				  struct ceph_mds_client *mdsc)
>  {
>  	int err;
> =20
>  	if (info->head->is_dentry) {
> -		err =3D parse_reply_info_in(p, end, &info->diri, features);
> +		err =3D parse_reply_info_in(p, end, &info->diri, features, mdsc);
>  		if (err < 0)
>  			goto out_bad;
> =20
> @@ -414,7 +430,8 @@ static int parse_reply_info_trace(void **p, void *end=
,
>  	}
> =20
>  	if (info->head->is_target) {
> -		err =3D parse_reply_info_in(p, end, &info->targeti, features);
> +		err =3D parse_reply_info_in(p, end, &info->targeti, features,
> +					  mdsc);
>  		if (err < 0)
>  			goto out_bad;
>  	}
> @@ -435,7 +452,8 @@ static int parse_reply_info_trace(void **p, void *end=
,
>   */
>  static int parse_reply_info_readdir(void **p, void *end,
>  				    struct ceph_mds_request *req,
> -				    u64 features)
> +				    u64 features,
> +				    struct ceph_mds_client *mdsc)
>  {
>  	struct ceph_mds_reply_info_parsed *info =3D &req->r_reply_info;
>  	struct ceph_client *cl =3D req->r_mdsc->fsc->client;
> @@ -550,7 +568,7 @@ static int parse_reply_info_readdir(void **p, void *e=
nd,
>  		rde->name_len =3D oname.len;
> =20
>  		/* inode */
> -		err =3D parse_reply_info_in(p, end, &rde->inode, features);
> +		err =3D parse_reply_info_in(p, end, &rde->inode, features, mdsc);
>  		if (err < 0)
>  			goto out_bad;
>  		/* ceph_readdir_prepopulate() will update it */
> @@ -758,7 +776,8 @@ static int parse_reply_info_extra(void **p, void *end=
,
>  	if (op =3D=3D CEPH_MDS_OP_GETFILELOCK)
>  		return parse_reply_info_filelock(p, end, info, features);
>  	else if (op =3D=3D CEPH_MDS_OP_READDIR || op =3D=3D CEPH_MDS_OP_LSSNAP)
> -		return parse_reply_info_readdir(p, end, req, features);
> +		return parse_reply_info_readdir(p, end, req, features,
> +						req->r_mdsc);
>  	else if (op =3D=3D CEPH_MDS_OP_CREATE)
>  		return parse_reply_info_create(p, end, info, features, s);
>  	else if (op =3D=3D CEPH_MDS_OP_GETVXATTR)
> @@ -787,7 +806,8 @@ static int parse_reply_info(struct ceph_mds_session *=
s, struct ceph_msg *msg,
>  	ceph_decode_32_safe(&p, end, len, bad);
>  	if (len > 0) {
>  		ceph_decode_need(&p, end, len, bad);
> -		err =3D parse_reply_info_trace(&p, p+len, info, features);
> +		err =3D parse_reply_info_trace(&p, p + len, info, features,
> +					     s->s_mdsc);
>  		if (err < 0)
>  			goto out_bad;
>  	}
> @@ -796,7 +816,7 @@ static int parse_reply_info(struct ceph_mds_session *=
s, struct ceph_msg *msg,
>  	ceph_decode_32_safe(&p, end, len, bad);
>  	if (len > 0) {
>  		ceph_decode_need(&p, end, len, bad);
> -		err =3D parse_reply_info_extra(&p, p+len, req, features, s);
> +		err =3D parse_reply_info_extra(&p, p + len, req, features, s);
>  		if (err < 0)
>  			goto out_bad;
>  	}
> @@ -4326,6 +4346,11 @@ static void handle_session(struct ceph_mds_session=
 *session,
>  		}
>  		mdsc->s_cap_auths_num =3D cap_auths_num;
>  		mdsc->s_cap_auths =3D cap_auths;
> +
> +		session->s_features =3D features;
> +		if (test_bit(CEPHFS_FEATURE_METRIC_COLLECT,
> +			     &session->s_features))
> +			ceph_metric_bind_session(mdsc, session);
>  	}
>  	if (op =3D=3D CEPH_SESSION_CLOSE) {
>  		ceph_get_mds_session(session);
> @@ -4352,7 +4377,11 @@ static void handle_session(struct ceph_mds_session=
 *session,
>  			pr_info_client(cl, "mds%d reconnect success\n",
>  				       session->s_mds);
> =20
> -		session->s_features =3D features;
> +		if (test_bit(CEPHFS_FEATURE_SUBVOLUME_METRICS,
> +			     &session->s_features))
> +			ceph_subvolume_metrics_enable(&mdsc->subvol_metrics, true);
> +		else
> +			ceph_subvolume_metrics_enable(&mdsc->subvol_metrics, false);
>  		if (session->s_state =3D=3D CEPH_MDS_SESSION_OPEN) {
>  			pr_notice_client(cl, "mds%d is already opened\n",
>  					 session->s_mds);
> @@ -5591,6 +5620,12 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>  	err =3D ceph_metric_init(&mdsc->metric);
>  	if (err)
>  		goto err_mdsmap;
> +	ceph_subvolume_metrics_init(&mdsc->subvol_metrics);
> +	mutex_init(&mdsc->subvol_metrics_last_mutex);
> +	mdsc->subvol_metrics_last =3D NULL;
> +	mdsc->subvol_metrics_last_nr =3D 0;
> +	mdsc->subvol_metrics_sent =3D 0;
> +	mdsc->subvol_metrics_nonzero_sends =3D 0;
> =20
>  	spin_lock_init(&mdsc->dentry_list_lock);
>  	INIT_LIST_HEAD(&mdsc->dentry_leases);
> @@ -6123,6 +6158,8 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
>  	ceph_mdsc_stop(mdsc);
> =20
>  	ceph_metric_destroy(&mdsc->metric);
> +	ceph_subvolume_metrics_destroy(&mdsc->subvol_metrics);
> +	kfree(mdsc->subvol_metrics_last);
> =20
>  	fsc->mdsc =3D NULL;
>  	kfree(mdsc);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index bd3690baa65c..4e6c87f8414c 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -18,6 +18,7 @@
> =20
>  #include "mdsmap.h"
>  #include "metric.h"
> +#include "subvolume_metrics.h"
>  #include "super.h"
> =20
>  /* The first 8 bits are reserved for old ceph releases */
> @@ -36,8 +37,9 @@ enum ceph_feature_type {
>  	CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
>  	CEPHFS_FEATURE_HAS_OWNER_UIDGID,
>  	CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,
> +	CEPHFS_FEATURE_SUBVOLUME_METRICS,
> =20
> -	CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,
> +	CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_SUBVOLUME_METRICS,
>  };
> =20
>  #define CEPHFS_FEATURES_CLIENT_SUPPORTED {	\
> @@ -54,6 +56,7 @@ enum ceph_feature_type {
>  	CEPHFS_FEATURE_32BITS_RETRY_FWD,	\
>  	CEPHFS_FEATURE_HAS_OWNER_UIDGID,	\
>  	CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,	\
> +	CEPHFS_FEATURE_SUBVOLUME_METRICS,	\
>  }
> =20
>  /*
> @@ -537,6 +540,14 @@ struct ceph_mds_client {
>  	struct list_head  dentry_dir_leases; /* lru list */
> =20
>  	struct ceph_client_metric metric;
> +	struct ceph_subvolume_metrics_tracker subvol_metrics;
> +
> +	/* Subvolume metrics send tracking */
> +	struct mutex		subvol_metrics_last_mutex;
> +	struct ceph_subvol_metric_snapshot *subvol_metrics_last;
> +	u32			subvol_metrics_last_nr;
> +	u64			subvol_metrics_sent;
> +	u64			subvol_metrics_nonzero_sends;
> =20
>  	spinlock_t		snapid_map_lock;
>  	struct rb_root		snapid_map_tree;
> diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
> index 871c1090e520..9bb357abc897 100644
> --- a/fs/ceph/metric.c
> +++ b/fs/ceph/metric.c
> @@ -4,10 +4,84 @@
>  #include <linux/types.h>
>  #include <linux/percpu_counter.h>
>  #include <linux/math64.h>
> +#include <linux/ratelimit.h>
> +
> +#include <linux/ceph/decode.h>
> =20
>  #include "metric.h"
>  #include "mds_client.h"
> =20
> +static bool metrics_disable_warned;
> +
> +static inline u32 ceph_subvolume_entry_payload_len(void)
> +{
> +	return sizeof(struct ceph_subvolume_metric_entry_wire);
> +}
> +
> +static inline u32 ceph_subvolume_entry_encoded_len(void)
> +{
> +	return CEPH_ENCODING_START_BLK_LEN +
> +		ceph_subvolume_entry_payload_len();
> +}
> +
> +static inline u32 ceph_subvolume_outer_payload_len(u32 nr_subvols)
> +{
> +	/* count is encoded as le64 (size_t on wire) to match FUSE client */
> +	return sizeof(__le64) +
> +		nr_subvols * ceph_subvolume_entry_encoded_len();
> +}
> +
> +static inline u32 ceph_subvolume_metric_data_len(u32 nr_subvols)
> +{
> +	return CEPH_ENCODING_START_BLK_LEN +
> +		ceph_subvolume_outer_payload_len(nr_subvols);
> +}
> +
> +static inline u32 ceph_subvolume_clamp_u32(u64 val)
> +{
> +	return val > U32_MAX ? U32_MAX : (u32)val;
> +}
> +
> +static void ceph_init_subvolume_wire_entry(
> +	struct ceph_subvolume_metric_entry_wire *dst,
> +	const struct ceph_subvol_metric_snapshot *src)
> +{
> +	dst->subvolume_id =3D cpu_to_le64(src->subvolume_id);
> +	dst->read_ops =3D cpu_to_le32(ceph_subvolume_clamp_u32(src->read_ops));
> +	dst->write_ops =3D cpu_to_le32(ceph_subvolume_clamp_u32(src->write_ops)=
);
> +	dst->read_bytes =3D cpu_to_le64(src->read_bytes);
> +	dst->write_bytes =3D cpu_to_le64(src->write_bytes);
> +	dst->read_latency_us =3D cpu_to_le64(src->read_latency_us);
> +	dst->write_latency_us =3D cpu_to_le64(src->write_latency_us);
> +	dst->time_stamp =3D 0;
> +}
> +
> +static int ceph_encode_subvolume_metrics(void **p, void *end,
> +					 struct ceph_subvol_metric_snapshot *subvols,
> +					 u32 nr_subvols)
> +{
> +	u32 i;
> +
> +	ceph_start_encoding(p, 1, 1,
> +			    ceph_subvolume_outer_payload_len(nr_subvols));
> +	/* count is encoded as le64 (size_t on wire) to match FUSE client */
> +	ceph_encode_64_safe(p, end, (u64)nr_subvols, enc_err);
> +
> +	for (i =3D 0; i < nr_subvols; i++) {
> +		struct ceph_subvolume_metric_entry_wire wire_entry;
> +
> +		ceph_init_subvolume_wire_entry(&wire_entry, &subvols[i]);
> +		ceph_start_encoding(p, 1, 1,
> +				    ceph_subvolume_entry_payload_len());
> +		ceph_encode_copy_safe(p, end, &wire_entry,
> +				      sizeof(wire_entry), enc_err);
> +	}
> +
> +	return 0;
> +enc_err:
> +	return -ERANGE;
> +}
> +
>  static void ktime_to_ceph_timespec(struct ceph_timespec *ts, ktime_t val=
)
>  {
>  	struct timespec64 t =3D ktime_to_timespec64(val);
> @@ -29,10 +103,14 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_c=
lient *mdsc,
>  	struct ceph_read_io_size *rsize;
>  	struct ceph_write_io_size *wsize;
>  	struct ceph_client_metric *m =3D &mdsc->metric;
> +	struct ceph_subvol_metric_snapshot *subvols =3D NULL;
>  	u64 nr_caps =3D atomic64_read(&m->total_caps);
>  	u32 header_len =3D sizeof(struct ceph_metric_header);
>  	struct ceph_client *cl =3D mdsc->fsc->client;
>  	struct ceph_msg *msg;
> +	u32 nr_subvols =3D 0;
> +	size_t subvol_len =3D 0;
> +	void *cursor;
>  	s64 sum;
>  	s32 items =3D 0;
>  	s32 len;
> @@ -45,15 +123,37 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_c=
lient *mdsc,
>  	}
>  	mutex_unlock(&mdsc->mutex);
> =20
> +	if (ceph_subvolume_metrics_enabled(&mdsc->subvol_metrics) &&
> +	    test_bit(CEPHFS_FEATURE_SUBVOLUME_METRICS, &s->s_features)) {
> +		int ret;
> +
> +		ret =3D ceph_subvolume_metrics_snapshot(&mdsc->subvol_metrics,
> +						      &subvols, &nr_subvols,
> +						      true);
> +		if (ret) {
> +			pr_warn_client(cl, "failed to snapshot subvolume metrics: %d\n",
> +				       ret);
> +			nr_subvols =3D 0;
> +			subvols =3D NULL;
> +		}
> +	}
> +
> +	if (nr_subvols) {
> +		/* type (le32) + ENCODE_START payload - no metric header */
> +		subvol_len =3D sizeof(__le32) +
> +			     ceph_subvolume_metric_data_len(nr_subvols);
> +	}
> +
>  	len =3D sizeof(*head) + sizeof(*cap) + sizeof(*read) + sizeof(*write)
>  	      + sizeof(*meta) + sizeof(*dlease) + sizeof(*files)
>  	      + sizeof(*icaps) + sizeof(*inodes) + sizeof(*rsize)
> -	      + sizeof(*wsize);
> +	      + sizeof(*wsize) + subvol_len;
> =20
>  	msg =3D ceph_msg_new(CEPH_MSG_CLIENT_METRICS, len, GFP_NOFS, true);
>  	if (!msg) {
>  		pr_err_client(cl, "to mds%d, failed to allocate message\n",
>  			      s->s_mds);
> +		kfree(subvols);
>  		return false;
>  	}
> =20
> @@ -172,13 +272,56 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_=
client *mdsc,
>  	wsize->total_size =3D cpu_to_le64(m->metric[METRIC_WRITE].size_sum);
>  	items++;
> =20
> +	cursor =3D wsize + 1;
> +
> +	if (nr_subvols) {
> +		void *payload;
> +		void *payload_end;
> +		int ret;
> +
> +		/* Emit only the type (le32), no ver/compat/data_len */
> +		ceph_encode_32(&cursor, CLIENT_METRIC_TYPE_SUBVOLUME_METRICS);
> +		items++;
> +
> +		payload =3D cursor;
> +		payload_end =3D (char *)payload +
> +			      ceph_subvolume_metric_data_len(nr_subvols);
> +
> +		ret =3D ceph_encode_subvolume_metrics(&payload, payload_end,
> +						    subvols, nr_subvols);
> +		if (ret) {
> +			pr_warn_client(cl,
> +				       "failed to encode subvolume metrics\n");
> +			kfree(subvols);
> +			ceph_msg_put(msg);
> +			return false;
> +		}
> +
> +		WARN_ON(payload !=3D payload_end);
> +		cursor =3D payload;
> +	}
> +
>  	put_unaligned_le32(items, &head->num);
> -	msg->front.iov_len =3D len;
> +	msg->front.iov_len =3D (char *)cursor - (char *)head;
>  	msg->hdr.version =3D cpu_to_le16(1);
>  	msg->hdr.compat_version =3D cpu_to_le16(1);
>  	msg->hdr.front_len =3D cpu_to_le32(msg->front.iov_len);
> +
>  	ceph_con_send(&s->s_con, msg);
> =20
> +	if (nr_subvols) {
> +		mutex_lock(&mdsc->subvol_metrics_last_mutex);
> +		kfree(mdsc->subvol_metrics_last);
> +		mdsc->subvol_metrics_last =3D subvols;
> +		mdsc->subvol_metrics_last_nr =3D nr_subvols;
> +		mdsc->subvol_metrics_sent +=3D nr_subvols;
> +		mdsc->subvol_metrics_nonzero_sends++;
> +		mutex_unlock(&mdsc->subvol_metrics_last_mutex);
> +
> +		subvols =3D NULL;
> +	}
> +	kfree(subvols);

This looks really confusing. I assume that common logic expects that if
nr_subvols > 0, then we need to free subvols. But if nr_subvols > 0, then w=
e
assign subvols =3D NULL. Do we have memory leak here?

> +
>  	return true;
>  }
> =20
> @@ -201,6 +344,12 @@ static void metric_get_session(struct ceph_mds_clien=
t *mdsc)
>  		 */
>  		if (check_session_state(s) &&
>  		    test_bit(CEPHFS_FEATURE_METRIC_COLLECT, &s->s_features)) {
> +			if (ceph_subvolume_metrics_enabled(&mdsc->subvol_metrics) &&
> +			    !test_bit(CEPHFS_FEATURE_SUBVOLUME_METRICS,
> +				      &s->s_features)) {
> +				ceph_put_mds_session(s);
> +				continue;
> +			}
>  			mdsc->metric.session =3D s;
>  			break;
>  		}
> @@ -217,8 +366,17 @@ static void metric_delayed_work(struct work_struct *=
work)
>  	struct ceph_mds_client *mdsc =3D
>  		container_of(m, struct ceph_mds_client, metric);
> =20
> -	if (mdsc->stopping || disable_send_metrics)
> +	if (mdsc->stopping)
> +		return;
> +
> +	if (disable_send_metrics) {
> +		if (!metrics_disable_warned) {
> +			pr_info("ceph: metrics sending disabled via module parameter\n");
> +			metrics_disable_warned =3D true;
> +		}
>  		return;
> +	}
> +	metrics_disable_warned =3D false;
> =20
>  	if (!m->session || !check_session_state(m->session)) {
>  		if (m->session) {
> @@ -227,10 +385,13 @@ static void metric_delayed_work(struct work_struct =
*work)
>  		}
>  		metric_get_session(mdsc);
>  	}
> -	if (m->session) {
> +
> +	if (m->session)
>  		ceph_mdsc_send_metrics(mdsc, m->session);
> -		metric_schedule_delayed(m);
> -	}
> +	else
> +		pr_warn_ratelimited("ceph: metrics worker has no MDS session\n");
> +
> +	metric_schedule_delayed(m);
>  }
> =20
>  int ceph_metric_init(struct ceph_client_metric *m)
> diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
> index 0d0c44bd3332..7e4aac63f6a6 100644
> --- a/fs/ceph/metric.h
> +++ b/fs/ceph/metric.h
> @@ -25,8 +25,9 @@ enum ceph_metric_type {
>  	CLIENT_METRIC_TYPE_STDEV_WRITE_LATENCY,
>  	CLIENT_METRIC_TYPE_AVG_METADATA_LATENCY,
>  	CLIENT_METRIC_TYPE_STDEV_METADATA_LATENCY,
> +	CLIENT_METRIC_TYPE_SUBVOLUME_METRICS,
> =20
> -	CLIENT_METRIC_TYPE_MAX =3D CLIENT_METRIC_TYPE_STDEV_METADATA_LATENCY,
> +	CLIENT_METRIC_TYPE_MAX =3D CLIENT_METRIC_TYPE_SUBVOLUME_METRICS,
>  };
> =20
>  /*
> @@ -50,6 +51,7 @@ enum ceph_metric_type {
>  	CLIENT_METRIC_TYPE_STDEV_WRITE_LATENCY,	   \
>  	CLIENT_METRIC_TYPE_AVG_METADATA_LATENCY,   \
>  	CLIENT_METRIC_TYPE_STDEV_METADATA_LATENCY, \
> +	CLIENT_METRIC_TYPE_SUBVOLUME_METRICS,	   \
>  						   \
>  	CLIENT_METRIC_TYPE_MAX,			   \
>  }
> @@ -139,6 +141,29 @@ struct ceph_write_io_size {
>  	__le64 total_size;
>  } __packed;
> =20
> +/* Wire format for subvolume metrics - matches C++ AggregatedIOMetrics *=
/

It will be good to have comments for every field here.

> +struct ceph_subvolume_metric_entry_wire {
> +	__le64 subvolume_id;
> +	__le32 read_ops;
> +	__le32 write_ops;
> +	__le64 read_bytes;
> +	__le64 write_bytes;
> +	__le64 read_latency_us;
> +	__le64 write_latency_us;
> +	__le64 time_stamp;
> +} __packed;
> +
> +/* Old struct kept for internal tracking, not used on wire */

Ditto.

> +struct ceph_subvolume_metric_entry {
> +	__le64 subvolume_id;
> +	__le64 read_ops;
> +	__le64 write_ops;
> +	__le64 read_bytes;
> +	__le64 write_bytes;
> +	__le64 read_latency_us;
> +	__le64 write_latency_us;
> +} __packed;
> +
>  struct ceph_metric_head {
>  	__le32 num;	/* the number of metrics that will be sent */
>  } __packed;
> diff --git a/fs/ceph/subvolume_metrics.c b/fs/ceph/subvolume_metrics.c
> new file mode 100644
> index 000000000000..37cbed5b52c3
> --- /dev/null
> +++ b/fs/ceph/subvolume_metrics.c
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/ceph/ceph_debug.h>
> +
> +#include <linux/math64.h>
> +#include <linux/slab.h>
> +#include <linux/seq_file.h>
> +
> +#include "subvolume_metrics.h"
> +#include "mds_client.h"
> +#include "super.h"
> +
> +struct ceph_subvol_metric_rb_entry {
> +	struct rb_node node;
> +	u64 subvolume_id;
> +	u64 read_ops;
> +	u64 write_ops;
> +	u64 read_bytes;
> +	u64 write_bytes;
> +	u64 read_latency_us;
> +	u64 write_latency_us;
> +};

It will be good to have comments for every field here.

> +
> +static struct kmem_cache *ceph_subvol_metric_entry_cachep;
> +
> +void ceph_subvolume_metrics_init(struct ceph_subvolume_metrics_tracker *=
tracker)
> +{
> +	spin_lock_init(&tracker->lock);
> +	tracker->tree =3D RB_ROOT_CACHED;
> +	tracker->nr_entries =3D 0;
> +	tracker->enabled =3D false;
> +	atomic64_set(&tracker->snapshot_attempts, 0);
> +	atomic64_set(&tracker->snapshot_empty, 0);
> +	atomic64_set(&tracker->snapshot_failures, 0);
> +	atomic64_set(&tracker->record_calls, 0);
> +	atomic64_set(&tracker->record_disabled, 0);
> +	atomic64_set(&tracker->record_no_subvol, 0);
> +	atomic64_set(&tracker->total_read_ops, 0);
> +	atomic64_set(&tracker->total_read_bytes, 0);
> +	atomic64_set(&tracker->total_write_ops, 0);
> +	atomic64_set(&tracker->total_write_bytes, 0);
> +}
> +
> +static struct ceph_subvol_metric_rb_entry *
> +__lookup_entry(struct ceph_subvolume_metrics_tracker *tracker, u64 subvo=
l_id)
> +{
> +	struct rb_node *node;
> +
> +	node =3D tracker->tree.rb_root.rb_node;
> +	while (node) {
> +		struct ceph_subvol_metric_rb_entry *entry =3D
> +			rb_entry(node, struct ceph_subvol_metric_rb_entry, node);
> +
> +		if (subvol_id < entry->subvolume_id)
> +			node =3D node->rb_left;
> +		else if (subvol_id > entry->subvolume_id)
> +			node =3D node->rb_right;
> +		else
> +			return entry;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct ceph_subvol_metric_rb_entry *
> +__insert_entry(struct ceph_subvolume_metrics_tracker *tracker,
> +	       struct ceph_subvol_metric_rb_entry *entry)
> +{
> +	struct rb_node **link =3D &tracker->tree.rb_root.rb_node;
> +	struct rb_node *parent =3D NULL;
> +	bool leftmost =3D true;
> +
> +	while (*link) {
> +		struct ceph_subvol_metric_rb_entry *cur =3D
> +			rb_entry(*link, struct ceph_subvol_metric_rb_entry, node);
> +
> +		parent =3D *link;
> +		if (entry->subvolume_id < cur->subvolume_id)
> +			link =3D &(*link)->rb_left;
> +		else if (entry->subvolume_id > cur->subvolume_id) {
> +			link =3D &(*link)->rb_right;
> +			leftmost =3D false;
> +		} else
> +			return cur;
> +	}
> +
> +	rb_link_node(&entry->node, parent, link);
> +	rb_insert_color_cached(&entry->node, &tracker->tree, leftmost);
> +	tracker->nr_entries++;
> +	return entry;
> +}
> +
> +static void ceph_subvolume_metrics_clear_locked(
> +		struct ceph_subvolume_metrics_tracker *tracker)
> +{
> +	struct rb_node *node =3D rb_first_cached(&tracker->tree);
> +
> +	while (node) {
> +		struct ceph_subvol_metric_rb_entry *entry =3D
> +			rb_entry(node, struct ceph_subvol_metric_rb_entry, node);
> +		struct rb_node *next =3D rb_next(node);
> +
> +		rb_erase_cached(&entry->node, &tracker->tree);
> +		tracker->nr_entries--;
> +		kmem_cache_free(ceph_subvol_metric_entry_cachep, entry);
> +		node =3D next;
> +	}
> +
> +	tracker->tree =3D RB_ROOT_CACHED;
> +}
> +
> +void ceph_subvolume_metrics_destroy(struct ceph_subvolume_metrics_tracke=
r *tracker)
> +{
> +	spin_lock(&tracker->lock);
> +	ceph_subvolume_metrics_clear_locked(tracker);
> +	tracker->enabled =3D false;
> +	spin_unlock(&tracker->lock);
> +}
> +
> +void ceph_subvolume_metrics_enable(struct ceph_subvolume_metrics_tracker=
 *tracker,
> +				   bool enable)
> +{
> +	spin_lock(&tracker->lock);
> +	if (enable) {
> +		tracker->enabled =3D true;
> +	} else {
> +		tracker->enabled =3D false;
> +		ceph_subvolume_metrics_clear_locked(tracker);
> +	}
> +	spin_unlock(&tracker->lock);
> +}
> +
> +void ceph_subvolume_metrics_record(struct ceph_subvolume_metrics_tracker=
 *tracker,
> +				   u64 subvol_id, bool is_write,
> +				   size_t size, u64 latency_us)
> +{
> +	struct ceph_subvol_metric_rb_entry *entry, *new_entry =3D NULL;
> +	bool retry =3D false;
> +
> +	/* CEPH_SUBVOLUME_ID_NONE (0) means unknown/unset subvolume */
> +	if (!READ_ONCE(tracker->enabled) ||
> +	    subvol_id =3D=3D CEPH_SUBVOLUME_ID_NONE || !size || !latency_us)
> +		return;
> +
> +	do {
> +		spin_lock(&tracker->lock);
> +		if (!tracker->enabled) {
> +			spin_unlock(&tracker->lock);
> +			kmem_cache_free(ceph_subvol_metric_entry_cachep, new_entry);
> +			return;
> +		}
> +
> +		entry =3D __lookup_entry(tracker, subvol_id);
> +		if (!entry) {
> +			if (!new_entry) {
> +				spin_unlock(&tracker->lock);
> +				new_entry =3D kmem_cache_zalloc(ceph_subvol_metric_entry_cachep,
> +						      GFP_NOFS);
> +				if (!new_entry)
> +					return;
> +				new_entry->subvolume_id =3D subvol_id;
> +				retry =3D true;
> +				continue;
> +			}
> +			entry =3D __insert_entry(tracker, new_entry);
> +			if (entry !=3D new_entry) {
> +				/* raced with another insert */
> +				spin_unlock(&tracker->lock);
> +				kmem_cache_free(ceph_subvol_metric_entry_cachep, new_entry);
> +				new_entry =3D NULL;
> +				retry =3D true;
> +				continue;
> +			}
> +			new_entry =3D NULL;
> +		}
> +
> +		if (is_write) {
> +			entry->write_ops++;
> +			entry->write_bytes +=3D size;
> +			entry->write_latency_us +=3D latency_us;
> +			atomic64_inc(&tracker->total_write_ops);
> +			atomic64_add(size, &tracker->total_write_bytes);
> +		} else {
> +			entry->read_ops++;
> +			entry->read_bytes +=3D size;
> +			entry->read_latency_us +=3D latency_us;
> +			atomic64_inc(&tracker->total_read_ops);
> +			atomic64_add(size, &tracker->total_read_bytes);
> +		}
> +		spin_unlock(&tracker->lock);
> +		kmem_cache_free(ceph_subvol_metric_entry_cachep, new_entry);
> +		return;
> +	} while (retry);
> +}
> +
> +int ceph_subvolume_metrics_snapshot(struct ceph_subvolume_metrics_tracke=
r *tracker,
> +				    struct ceph_subvol_metric_snapshot **out,
> +				    u32 *nr, bool consume)
> +{
> +	struct ceph_subvol_metric_snapshot *snap =3D NULL;
> +	struct rb_node *node;
> +	u32 count =3D 0, idx =3D 0;
> +	int ret =3D 0;
> +
> +	*out =3D NULL;
> +	*nr =3D 0;
> +
> +	if (!READ_ONCE(tracker->enabled))
> +		return 0;
> +
> +	atomic64_inc(&tracker->snapshot_attempts);
> +
> +	spin_lock(&tracker->lock);
> +	for (node =3D rb_first_cached(&tracker->tree); node; node =3D rb_next(n=
ode)) {
> +		struct ceph_subvol_metric_rb_entry *entry =3D
> +			rb_entry(node, struct ceph_subvol_metric_rb_entry, node);
> +
> +		/* Include entries with ANY I/O activity (read OR write) */
> +		if (entry->read_ops || entry->write_ops)
> +			count++;
> +	}
> +	spin_unlock(&tracker->lock);
> +
> +	if (!count) {
> +		atomic64_inc(&tracker->snapshot_empty);
> +		return 0;
> +	}
> +
> +	snap =3D kcalloc(count, sizeof(*snap), GFP_NOFS);
> +	if (!snap) {
> +		atomic64_inc(&tracker->snapshot_failures);
> +		return -ENOMEM;
> +	}
> +
> +	spin_lock(&tracker->lock);
> +	node =3D rb_first_cached(&tracker->tree);
> +	while (node) {
> +		struct ceph_subvol_metric_rb_entry *entry =3D
> +			rb_entry(node, struct ceph_subvol_metric_rb_entry, node);
> +		struct rb_node *next =3D rb_next(node);
> +
> +		/* Skip entries with NO I/O activity at all */
> +		if (!entry->read_ops && !entry->write_ops) {
> +			rb_erase_cached(&entry->node, &tracker->tree);
> +			tracker->nr_entries--;
> +			kmem_cache_free(ceph_subvol_metric_entry_cachep, entry);
> +			node =3D next;
> +			continue;
> +		}
> +
> +		if (idx >=3D count) {
> +			pr_warn("ceph: subvol metrics snapshot race (idx=3D%u count=3D%u)\n",
> +				idx, count);
> +			break;
> +		}
> +
> +		snap[idx].subvolume_id =3D entry->subvolume_id;
> +		snap[idx].read_ops =3D entry->read_ops;
> +		snap[idx].write_ops =3D entry->write_ops;
> +		snap[idx].read_bytes =3D entry->read_bytes;
> +		snap[idx].write_bytes =3D entry->write_bytes;
> +		snap[idx].read_latency_us =3D entry->read_latency_us;
> +		snap[idx].write_latency_us =3D entry->write_latency_us;
> +		idx++;
> +
> +		if (consume) {
> +			entry->read_ops =3D 0;
> +			entry->write_ops =3D 0;
> +			entry->read_bytes =3D 0;
> +			entry->write_bytes =3D 0;
> +			entry->read_latency_us =3D 0;
> +			entry->write_latency_us =3D 0;
> +			rb_erase_cached(&entry->node, &tracker->tree);
> +			tracker->nr_entries--;
> +			kmem_cache_free(ceph_subvol_metric_entry_cachep, entry);
> +		}
> +		node =3D next;
> +	}
> +	spin_unlock(&tracker->lock);
> +
> +	if (!idx) {
> +		kfree(snap);
> +		snap =3D NULL;
> +		ret =3D 0;
> +	} else {
> +		*nr =3D idx;
> +		*out =3D snap;
> +	}
> +
> +	return ret;
> +}
> +
> +void ceph_subvolume_metrics_free_snapshot(struct ceph_subvol_metric_snap=
shot *snapshot)
> +{
> +	kfree(snapshot);
> +}
> +
> +static u64 div_rem(u64 dividend, u64 divisor)
> +{
> +	return divisor ? div64_u64(dividend, divisor) : 0;
> +}

I still don't follow. Do we really need this method?

> +
> +/*
> + * Dump subvolume metrics to a seq_file for debugfs.
> + * This function does not return an error code because the seq_file API
> + * handles errors internally - any failures are tracked in the seq_file
> + * structure and reported to userspace when the file is read.
> + */
> +void ceph_subvolume_metrics_dump(struct ceph_subvolume_metrics_tracker *=
tracker,
> +				 struct seq_file *s)
> +{
> +	struct rb_node *node;
> +	struct ceph_subvol_metric_snapshot *snapshot =3D NULL;
> +	u32 count =3D 0, idx =3D 0;
> +
> +	spin_lock(&tracker->lock);
> +	if (!tracker->enabled) {
> +		spin_unlock(&tracker->lock);
> +		seq_puts(s, "subvolume metrics disabled\n");
> +		return;
> +	}
> +
> +	for (node =3D rb_first_cached(&tracker->tree); node; node =3D rb_next(n=
ode)) {
> +		struct ceph_subvol_metric_rb_entry *entry =3D
> +			rb_entry(node, struct ceph_subvol_metric_rb_entry, node);
> +
> +		if (entry->read_ops || entry->write_ops)
> +			count++;
> +	}
> +	spin_unlock(&tracker->lock);
> +
> +	if (!count) {
> +		seq_puts(s, "(no subvolume metrics collected)\n");
> +		return;
> +	}
> +
> +	snapshot =3D kcalloc(count, sizeof(*snapshot), GFP_KERNEL);

Do we really need to allocate the array? Could we simply dump snapshot by
snapshot without memory allocation?

Thanks,
Slava.

> +	if (!snapshot) {
> +		seq_puts(s, "(unable to allocate memory for snapshot)\n");
> +		return;
> +	}
> +
> +	spin_lock(&tracker->lock);
> +	for (node =3D rb_first_cached(&tracker->tree); node; node =3D rb_next(n=
ode)) {
> +		struct ceph_subvol_metric_rb_entry *entry =3D
> +			rb_entry(node, struct ceph_subvol_metric_rb_entry, node);
> +
> +		if (!entry->read_ops && !entry->write_ops)
> +			continue;
> +
> +		if (idx >=3D count)
> +			break;
> +
> +		snapshot[idx].subvolume_id =3D entry->subvolume_id;
> +		snapshot[idx].read_ops =3D entry->read_ops;
> +		snapshot[idx].write_ops =3D entry->write_ops;
> +		snapshot[idx].read_bytes =3D entry->read_bytes;
> +		snapshot[idx].write_bytes =3D entry->write_bytes;
> +		snapshot[idx].read_latency_us =3D entry->read_latency_us;
> +		snapshot[idx].write_latency_us =3D entry->write_latency_us;
> +		idx++;
> +	}
> +	spin_unlock(&tracker->lock);
> +
> +	seq_puts(s, "subvol_id       rd_ops    rd_bytes    rd_avg_lat_us  wr_op=
s    wr_bytes    wr_avg_lat_us\n");
> +	seq_puts(s, "----------------------------------------------------------=
--------------------------------------\n");
> +
> +	for (idx =3D 0; idx < count; idx++) {
> +		u64 avg_rd_lat =3D div_rem(snapshot[idx].read_latency_us,
> +					 snapshot[idx].read_ops);
> +		u64 avg_wr_lat =3D div_rem(snapshot[idx].write_latency_us,
> +					 snapshot[idx].write_ops);
> +
> +		seq_printf(s, "%-15llu%-10llu%-12llu%-16llu%-10llu%-12llu%-16llu\n",
> +			   snapshot[idx].subvolume_id,
> +			   snapshot[idx].read_ops,
> +			   snapshot[idx].read_bytes,
> +			   avg_rd_lat,
> +			   snapshot[idx].write_ops,
> +			   snapshot[idx].write_bytes,
> +			   avg_wr_lat);
> +	}
> +
> +	kfree(snapshot);
> +}
> +
> +void ceph_subvolume_metrics_record_io(struct ceph_mds_client *mdsc,
> +				      struct ceph_inode_info *ci,
> +				      bool is_write, size_t bytes,
> +				      ktime_t start, ktime_t end)
> +{
> +	struct ceph_subvolume_metrics_tracker *tracker;
> +	u64 subvol_id;
> +	s64 delta_us;
> +
> +	if (!mdsc || !ci || !bytes)
> +		return;
> +
> +	tracker =3D &mdsc->subvol_metrics;
> +	atomic64_inc(&tracker->record_calls);
> +
> +	if (!ceph_subvolume_metrics_enabled(tracker)) {
> +		atomic64_inc(&tracker->record_disabled);
> +		return;
> +	}
> +
> +	subvol_id =3D READ_ONCE(ci->i_subvolume_id);
> +	if (subvol_id =3D=3D CEPH_SUBVOLUME_ID_NONE) {
> +		atomic64_inc(&tracker->record_no_subvol);
> +		return;
> +	}
> +
> +	delta_us =3D ktime_to_us(ktime_sub(end, start));
> +	if (delta_us <=3D 0)
> +		delta_us =3D 1;
> +
> +	ceph_subvolume_metrics_record(tracker, subvol_id, is_write,
> +				      bytes, (u64)delta_us);
> +}
> +
> +int __init ceph_subvolume_metrics_cache_init(void)
> +{
> +	ceph_subvol_metric_entry_cachep =3D KMEM_CACHE(ceph_subvol_metric_rb_en=
try,
> +						    SLAB_RECLAIM_ACCOUNT);
> +	if (!ceph_subvol_metric_entry_cachep)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +void ceph_subvolume_metrics_cache_destroy(void)
> +{
> +	kmem_cache_destroy(ceph_subvol_metric_entry_cachep);
> +}
> diff --git a/fs/ceph/subvolume_metrics.h b/fs/ceph/subvolume_metrics.h
> new file mode 100644
> index 000000000000..6f53ff726c75
> --- /dev/null
> +++ b/fs/ceph/subvolume_metrics.h
> @@ -0,0 +1,97 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _FS_CEPH_SUBVOLUME_METRICS_H
> +#define _FS_CEPH_SUBVOLUME_METRICS_H
> +
> +#include <linux/types.h>
> +#include <linux/rbtree.h>
> +#include <linux/spinlock.h>
> +#include <linux/ktime.h>
> +#include <linux/atomic.h>
> +
> +struct seq_file;
> +struct ceph_mds_client;
> +struct ceph_inode_info;
> +
> +/**
> + * struct ceph_subvol_metric_snapshot - Point-in-time snapshot of subvol=
ume metrics
> + * @subvolume_id: Subvolume identifier (inode number of subvolume root)
> + * @read_ops: Number of read operations since last snapshot
> + * @write_ops: Number of write operations since last snapshot
> + * @read_bytes: Total bytes read since last snapshot
> + * @write_bytes: Total bytes written since last snapshot
> + * @read_latency_us: Sum of read latencies in microseconds (for avg calc=
ulation)
> + * @write_latency_us: Sum of write latencies in microseconds (for avg ca=
lculation)
> + */
> +struct ceph_subvol_metric_snapshot {
> +	u64 subvolume_id;
> +	u64 read_ops;
> +	u64 write_ops;
> +	u64 read_bytes;
> +	u64 write_bytes;
> +	u64 read_latency_us;
> +	u64 write_latency_us;
> +};
> +
> +/**
> + * struct ceph_subvolume_metrics_tracker - Tracks per-subvolume I/O metr=
ics
> + * @lock: Protects @tree and @nr_entries during concurrent access
> + * @tree: Red-black tree of per-subvolume entries, keyed by subvolume_id
> + * @nr_entries: Number of entries currently in @tree
> + * @enabled: Whether collection is enabled (requires MDS feature support=
)
> + * @snapshot_attempts: Debug counter: total ceph_subvolume_metrics_snaps=
hot() calls
> + * @snapshot_empty: Debug counter: snapshots that found no data to repor=
t
> + * @snapshot_failures: Debug counter: snapshots that failed to allocate =
memory
> + * @record_calls: Debug counter: total ceph_subvolume_metrics_record() c=
alls
> + * @record_disabled: Debug counter: record calls skipped because disable=
d
> + * @record_no_subvol: Debug counter: record calls skipped (no subvolume_=
id)
> + * @total_read_ops: Cumulative read ops across all snapshots (never rese=
t)
> + * @total_read_bytes: Cumulative bytes read across all snapshots (never =
reset)
> + * @total_write_ops: Cumulative write ops across all snapshots (never re=
set)
> + * @total_write_bytes: Cumulative bytes written across all snapshots (ne=
ver reset)
> + */
> +struct ceph_subvolume_metrics_tracker {
> +	spinlock_t lock;
> +	struct rb_root_cached tree;
> +	u32 nr_entries;
> +	bool enabled;
> +	atomic64_t snapshot_attempts;
> +	atomic64_t snapshot_empty;
> +	atomic64_t snapshot_failures;
> +	atomic64_t record_calls;
> +	atomic64_t record_disabled;
> +	atomic64_t record_no_subvol;
> +	atomic64_t total_read_ops;
> +	atomic64_t total_read_bytes;
> +	atomic64_t total_write_ops;
> +	atomic64_t total_write_bytes;
> +};
> +
> +void ceph_subvolume_metrics_init(struct ceph_subvolume_metrics_tracker *=
tracker);
> +void ceph_subvolume_metrics_destroy(struct ceph_subvolume_metrics_tracke=
r *tracker);
> +void ceph_subvolume_metrics_enable(struct ceph_subvolume_metrics_tracker=
 *tracker,
> +				   bool enable);
> +void ceph_subvolume_metrics_record(struct ceph_subvolume_metrics_tracker=
 *tracker,
> +				   u64 subvol_id, bool is_write,
> +				   size_t size, u64 latency_us);
> +int ceph_subvolume_metrics_snapshot(struct ceph_subvolume_metrics_tracke=
r *tracker,
> +				    struct ceph_subvol_metric_snapshot **out,
> +				    u32 *nr, bool consume);
> +void ceph_subvolume_metrics_free_snapshot(struct ceph_subvol_metric_snap=
shot *snapshot);
> +void ceph_subvolume_metrics_dump(struct ceph_subvolume_metrics_tracker *=
tracker,
> +				 struct seq_file *s);
> +
> +void ceph_subvolume_metrics_record_io(struct ceph_mds_client *mdsc,
> +				      struct ceph_inode_info *ci,
> +				      bool is_write, size_t bytes,
> +				      ktime_t start, ktime_t end);
> +
> +static inline bool ceph_subvolume_metrics_enabled(
> +		const struct ceph_subvolume_metrics_tracker *tracker)
> +{
> +	return READ_ONCE(tracker->enabled);
> +}
> +
> +int __init ceph_subvolume_metrics_cache_init(void);
> +void ceph_subvolume_metrics_cache_destroy(void);
> +
> +#endif /* _FS_CEPH_SUBVOLUME_METRICS_H */
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index f6bf24b5c683..a60f99b5c68a 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -21,6 +21,7 @@
>  #include "mds_client.h"
>  #include "cache.h"
>  #include "crypto.h"
> +#include "subvolume_metrics.h"
> =20
>  #include <linux/ceph/ceph_features.h>
>  #include <linux/ceph/decode.h>
> @@ -963,8 +964,14 @@ static int __init init_caches(void)
>  	if (!ceph_wb_pagevec_pool)
>  		goto bad_pagevec_pool;
> =20
> +	error =3D ceph_subvolume_metrics_cache_init();
> +	if (error)
> +		goto bad_subvol_metrics;
> +
>  	return 0;
> =20
> +bad_subvol_metrics:
> +	mempool_destroy(ceph_wb_pagevec_pool);
>  bad_pagevec_pool:
>  	kmem_cache_destroy(ceph_mds_request_cachep);
>  bad_mds_req:
> @@ -1001,6 +1008,7 @@ static void destroy_caches(void)
>  	kmem_cache_destroy(ceph_dir_file_cachep);
>  	kmem_cache_destroy(ceph_mds_request_cachep);
>  	mempool_destroy(ceph_wb_pagevec_pool);
> +	ceph_subvolume_metrics_cache_destroy();
>  }
> =20
>  static void __ceph_umount_begin(struct ceph_fs_client *fsc)
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index c0372a725960..731df0fcbcc8 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -167,6 +167,7 @@ struct ceph_fs_client {
>  	struct dentry *debugfs_status;
>  	struct dentry *debugfs_mds_sessions;
>  	struct dentry *debugfs_metrics_dir;
> +	struct dentry *debugfs_subvolume_metrics;
>  #endif
> =20
>  #ifdef CONFIG_CEPH_FSCACHE
> @@ -385,7 +386,15 @@ struct ceph_inode_info {
> =20
>  	/* quotas */
>  	u64 i_max_bytes, i_max_files;
> -	u64 i_subvolume_id;	/* 0 =3D unknown/unset, matches FUSE client */
> +
> +	/*
> +	 * Subvolume ID this inode belongs to. CEPH_SUBVOLUME_ID_NONE (0)
> +	 * means unknown/unset, matching the FUSE client convention.
> +	 * Once set to a valid (non-zero) value, it should not change
> +	 * during the inode's lifetime.
> +	 */
> +#define CEPH_SUBVOLUME_ID_NONE 0
> +	u64 i_subvolume_id;
> =20
>  	s32 i_dir_pin;
> =20


