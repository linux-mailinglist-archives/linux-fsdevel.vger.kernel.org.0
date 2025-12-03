Return-Path: <linux-fsdevel+bounces-70578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 502C7C9FBF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 16:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F79630019F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48704344052;
	Wed,  3 Dec 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKOmkBU/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7BQxdJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D77343D83
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777480; cv=none; b=sfUIS6fWVm2KfipZrW5EB2VHUEjOghukVIc6pTeGjkO2+o+c5f24jg08HLvlg+4ghd6KIiIF+C2M47ZmmdF077aVsG/hJiG46gz4QqDqkMAgTbce4empVLL/uHFrczWvt5AxnQ8cTRVlJqFEZpVtC6VUpR0RJFe8M6jGb1DlAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777480; c=relaxed/simple;
	bh=O09GaZmtriSFnlQQAaOIgxX80uzQgnXAxjLiRpO2/A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqwDG4V0mLSDSVgYLwVPC5sDOzihbql8Ga3BP0tV8cvqW6hV5R4NXjrUC2O3jbZieNQwWbvm/NEHRqJEf5UGSgvNVEQu8dDQa3pH8F/p9UICfJw+KbeSFCv009FzICvEMPnQre9b2V2efdDOK4boXT8SHPuOUxHPsu+5naci+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKOmkBU/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7BQxdJl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764777475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NHwMvzlwz3w1/OmfC9NWsAj+7FyNST5MSTWOPp0LaTM=;
	b=eKOmkBU/bS3djRSGIzxXsNRflyda4hX4Uv00ygCObNMXDgVoCU6gogEdKvQUyYBY4coz19
	JfudeuaPK9QWS04xR3Daa8fXoRq4fM08akpc/Kuqs8rAzuF0v3hej+mCE9D4j/Q1TnyE3O
	/Hg9cpzKA0bgToZ9PiKV/G0Z8vpaMU0=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505--kDLpbUONaS-uZt8qpWxGg-1; Wed, 03 Dec 2025 10:57:54 -0500
X-MC-Unique: -kDLpbUONaS-uZt8qpWxGg-1
X-Mimecast-MFC-AGG-ID: -kDLpbUONaS-uZt8qpWxGg_1764777474
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-559597c717dso8762478e0c.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 07:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764777474; x=1765382274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHwMvzlwz3w1/OmfC9NWsAj+7FyNST5MSTWOPp0LaTM=;
        b=i7BQxdJlvBKG0wO9966k9J8uuQqK1JvNzZJ3Hvy0OsgwGWp0xBo4xDXiIWBE5AsqI7
         NkEz4NXrce3OIIrHmJDSlt3P2P1oPQRCTxkW7fn6GdQhwJjLEUUWktLgeUeYZZLjg7qw
         l0TlqyTG+nrn7MxGRCf858aqT73WP3RxTGYBy8cHv9HVM2bTdEmyIjx7F9wgyV4JsG6J
         e+f3KtXc9V+DeFX3oe4v0l2RdH3CLy1dhruHLYjLXlzNGZKzxuYj2k1lFeBn94b0c+yV
         Eg3VzVMNeg0gC3dLtuWoVOcGOwWnzKjYahjcbuqxXib3iRxpxGHJCV9L0ARPIipDFWvX
         60OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764777474; x=1765382274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHwMvzlwz3w1/OmfC9NWsAj+7FyNST5MSTWOPp0LaTM=;
        b=NNQCYwVzDQqKLVRC/ocV00MdtwjGrWMpY0EMwyY3y+j2LzdWDsn6Rt2ISsakt4303x
         SPLCG8lpItribgjEt3gf6alNYVWIJGm2jAFG+ZODkwCzQ/zJUDryAtDZzP68xn3b3DHs
         TC6e0q681DA5McTg1Uw9ssfkuOzxhL/+wYvCTRMvjXIytcI3r6ysoYqmF9DM5lRO+dW8
         xJ3iiiiEYpMm0ak0kvL3b1uNhTgW0eqShyYDooc/nit7urqu4mfp7azExxcfB/50kKLk
         hWLUL+uJASMn8zncisAWtbkBfBJy0MbIkmBY65QXrrvpBmVmSJ6YrCjnWd6Ho66oZjtW
         4cYw==
X-Forwarded-Encrypted: i=1; AJvYcCWa1tAKqcFPz9Ts5cpNm0KsalOSI+rfC8xw06522OthiWU8LLfKppt9zKKZ8suZSu1bsrYVQK4n2q60dXmf@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdkje72/Qell5gGTvQ/xJtSw23SJa1vi5G816o01H5aGG6hWu
	a4wLkroyVHiGyEbZNx+JHM6zQnmQMudmDqZdSFe+aFbFeQtLOqHgdUkL0j+sp4dNyNQ0MIQ7prX
	EhHH8OAyZ37uulrb/ChiQxfFbQ+TxLUxnSFJwAHLLG6Dsa5zsxRTwTIbtpGDprL/UAN6PlMKpcF
	o+s42qfxnLV8Tf+ynPYHw8lndanjh5ZTSmU86zTI2KP/LK8RhHztD/61n13Q==
X-Gm-Gg: ASbGnctEITv0HNpgTj1h7Ts1JcRdFiRwQNdYCkIdAlT5ncAN9GdEFmBNMmFB/YCYFi1
	UVCfRPsXfew2dLUDv65H7bCE5xGuGFhUeWqIDoRw6ZCzB6/Ag2i8y3TYfKFAyjOd8gheKoEi73n
	wbbPs2wHhoFAy2w2XCpkksPWnqT8iSsEaLmrIajo0ce/4QgIb8dRbcuvrd8FyWvLezluhZOGo5K
	UXDkddbZX2f
X-Received: by 2002:a05:6122:4b19:b0:559:3d91:5f2d with SMTP id 71dfb90a1353d-55e5beb48b4mr959556e0c.9.1764777473181;
        Wed, 03 Dec 2025 07:57:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzgiHz43IzCYUUo/i6vtv3tcAChwsSNwuDgV+wG/hGulRcdZKsxgSM/kce9+WhuCivnzjb7N6ICg6/GgaCTto=
X-Received: by 2002:a05:6122:4b19:b0:559:3d91:5f2d with SMTP id
 71dfb90a1353d-55e5beb48b4mr959538e0c.9.1764777472352; Wed, 03 Dec 2025
 07:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202155750.2565696-1-amarkuze@redhat.com> <20251202155750.2565696-4-amarkuze@redhat.com>
 <0011d9cc8b461616324a70211cc9e1b3b1ea5d0e.camel@ibm.com>
In-Reply-To: <0011d9cc8b461616324a70211cc9e1b3b1ea5d0e.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 3 Dec 2025 17:57:41 +0200
X-Gm-Features: AWmQ_blVwGnPN6Xa2cU8T4XQmxwdohwy0ABCLKjB6pQVJBUREGYSBPx0waQWWcg
Message-ID: <CAO8a2Sg5STbcq9Td1xYEkdQZfMFk6zL3C2nQ8WD0MVPvzT9P5Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ceph: add subvolume metrics collection and reporting
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 12:54=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Tue, 2025-12-02 at 15:57 +0000, Alex Markuze wrote:
> > Add complete subvolume metrics infrastructure for tracking and reportin=
g
> > per-subvolume I/O metrics to the MDS. This enables administrators to
> > monitor I/O patterns at the subvolume granularity.
> >
> > The implementation includes:
> >
> > - New CEPHFS_FEATURE_SUBVOLUME_METRICS feature flag for MDS negotiation
> > - Red-black tree based metrics tracker (subvolume_metrics.c/h)
> > - Wire format encoding matching the MDS C++ AggregatedIOMetrics struct
> > - Integration with the existing metrics reporting infrastructure
> > - Recording of I/O operations from file read/write paths
> > - Debugfs interface for monitoring collected metrics
> >
> > Metrics tracked per subvolume:
> > - Read/write operation counts
> > - Read/write byte counts
> > - Read/write latency sums (for average calculation)
> >
> > The metrics are periodically sent to the MDS as part of the existing
> > CLIENT_METRICS message when the MDS advertises support for the
> > SUBVOLUME_METRICS feature.
> >
> > Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> > ---
> >  fs/ceph/Makefile            |   2 +-
> >  fs/ceph/addr.c              |  10 +
> >  fs/ceph/debugfs.c           | 153 ++++++++++++++
> >  fs/ceph/file.c              |  58 ++++-
> >  fs/ceph/mds_client.c        |  70 +++++--
> >  fs/ceph/mds_client.h        |  13 +-
> >  fs/ceph/metric.c            | 172 ++++++++++++++-
> >  fs/ceph/metric.h            |  27 ++-
> >  fs/ceph/subvolume_metrics.c | 408 ++++++++++++++++++++++++++++++++++++
> >  fs/ceph/subvolume_metrics.h |  68 ++++++
> >  fs/ceph/super.c             |   1 +
> >  fs/ceph/super.h             |   1 +
> >  12 files changed, 957 insertions(+), 26 deletions(-)
> >  create mode 100644 fs/ceph/subvolume_metrics.c
> >  create mode 100644 fs/ceph/subvolume_metrics.h
> >
> > diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
> > index 1f77ca04c426..ebb29d11ac22 100644
> > --- a/fs/ceph/Makefile
> > +++ b/fs/ceph/Makefile
> > @@ -8,7 +8,7 @@ obj-$(CONFIG_CEPH_FS) +=3D ceph.o
> >  ceph-y :=3D super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
> >       export.o caps.o snap.o xattr.o quota.o io.o \
> >       mds_client.o mdsmap.o strings.o ceph_frag.o \
> > -     debugfs.o util.o metric.o
> > +     debugfs.o util.o metric.o subvolume_metrics.o
> >
> >  ceph-$(CONFIG_CEPH_FSCACHE) +=3D cache.o
> >  ceph-$(CONFIG_CEPH_FS_POSIX_ACL) +=3D acl.o
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 322ed268f14a..feae80dc2816 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -19,6 +19,7 @@
> >  #include "mds_client.h"
> >  #include "cache.h"
> >  #include "metric.h"
> > +#include "subvolume_metrics.h"
> >  #include "crypto.h"
> >  #include <linux/ceph/osd_client.h>
> >  #include <linux/ceph/striper.h>
> > @@ -823,6 +824,10 @@ static int write_folio_nounlock(struct folio *foli=
o,
> >
> >       ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latenc=
y,
> >                                 req->r_end_latency, len, err);
> > +     if (err >=3D 0 && len > 0)
>
> Do we really need to take into account the err value here?

Yes, we need to check rc/ret values:
   - For WRITES: We check `rc >=3D 0 && len > 0` because:
     * rc < 0 means the write failed - don't count failed I/O
     * len > 0 ensures we actually wrote something

   - For READS: We check `ret > 0` (not `ret >=3D 0`) because:
     * ret < 0 means the read failed
     * ret =3D=3D 0 means EOF (zero bytes read) - this is NOT an I/O operat=
ion
       to count in metrics, it's just "nothing to read"
     * ret > 0 means actual bytes were read

   This matches the existing ceph_update_read_metrics/ceph_update_write_met=
rics
   behavior which also filters on rc values (see metric.c line 514).
>
> > +             ceph_subvolume_metrics_record_io(fsc->mdsc, ci, true, len=
,
> > +                                              req->r_start_latency,
> > +                                              req->r_end_latency);
> >       fscrypt_free_bounce_page(bounce_page);
> >       ceph_osdc_put_request(req);
> >       if (err =3D=3D 0)
> > @@ -963,6 +968,11 @@ static void writepages_finish(struct ceph_osd_requ=
est *req)
> >       ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latenc=
y,
> >                                 req->r_end_latency, len, rc);
> >
> > +     if (rc >=3D 0 && len > 0)
>
> Ditto. Do we really need to take into account the rc value?
>
> > +             ceph_subvolume_metrics_record_io(mdsc, ci, true, len,
> > +                                              req->r_start_latency,
> > +                                              req->r_end_latency);
> > +
> >       ceph_put_wrbuffer_cap_refs(ci, total_pages, snapc);
> >
> >       osd_data =3D osd_req_op_extent_osd_data(req, 0);
> > diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> > index f3fe786b4143..a7b1c63783a1 100644
> > --- a/fs/ceph/debugfs.c
> > +++ b/fs/ceph/debugfs.c
> > @@ -9,11 +9,13 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/math64.h>
> >  #include <linux/ktime.h>
> > +#include <linux/atomic.h>
> >
> >  #include <linux/ceph/libceph.h>
> >  #include <linux/ceph/mon_client.h>
> >  #include <linux/ceph/auth.h>
> >  #include <linux/ceph/debugfs.h>
> > +#include <linux/ceph/decode.h>
> >
> >  #include "super.h"
> >
> > @@ -21,6 +23,31 @@
> >
> >  #include "mds_client.h"
> >  #include "metric.h"
> > +#include "subvolume_metrics.h"
> > +
> > +extern bool disable_send_metrics;
>
> Maybe, it should be part of some structure? This solution looks not very =
nice.

It's a module parameter that applies globally to all mounts/sessions.
   Moving it to a per-client struct would change semantics. The current
   approach matches how it was originally designed.

> > +
> > +struct ceph_session_feature_desc {
> > +     unsigned int bit;
>
> What bit means here? Maybe, it makes sense to have comments for the struc=
ture?

'bit' is the feature bit number from enum ceph_feature_type (e.g.,
   CEPHFS_FEATURE_METRIC_COLLECT). Will add comment.
> > +     const char *name;
> > +};
> > +
> > +static const struct ceph_session_feature_desc ceph_session_feature_tab=
le[] =3D {
> > +     { CEPHFS_FEATURE_METRIC_COLLECT, "METRIC_COLLECT" },
> > +     { CEPHFS_FEATURE_REPLY_ENCODING, "REPLY_ENCODING" },
> > +     { CEPHFS_FEATURE_RECLAIM_CLIENT, "RECLAIM_CLIENT" },
> > +     { CEPHFS_FEATURE_LAZY_CAP_WANTED, "LAZY_CAP_WANTED" },
> > +     { CEPHFS_FEATURE_MULTI_RECONNECT, "MULTI_RECONNECT" },
> > +     { CEPHFS_FEATURE_DELEG_INO, "DELEG_INO" },
> > +     { CEPHFS_FEATURE_ALTERNATE_NAME, "ALTERNATE_NAME" },
> > +     { CEPHFS_FEATURE_NOTIFY_SESSION_STATE, "NOTIFY_SESSION_STATE" },
> > +     { CEPHFS_FEATURE_OP_GETVXATTR, "OP_GETVXATTR" },
> > +     { CEPHFS_FEATURE_32BITS_RETRY_FWD, "32BITS_RETRY_FWD" },
> > +     { CEPHFS_FEATURE_NEW_SNAPREALM_INFO, "NEW_SNAPREALM_INFO" },
> > +     { CEPHFS_FEATURE_HAS_OWNER_UIDGID, "HAS_OWNER_UIDGID" },
> > +     { CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK, "MDS_AUTH_CAPS_CHECK" },
> > +     { CEPHFS_FEATURE_SUBVOLUME_METRICS, "SUBVOLUME_METRICS" },
> > +};
> >
> >  static int mdsmap_show(struct seq_file *s, void *p)
> >  {
> > @@ -360,6 +387,60 @@ static int status_show(struct seq_file *s, void *p=
)
> >       return 0;
> >  }
> >
> > +static int subvolume_metrics_show(struct seq_file *s, void *p)
> > +{
> > +     struct ceph_fs_client *fsc =3D s->private;
> > +     struct ceph_mds_client *mdsc =3D fsc->mdsc;
> > +     struct ceph_subvol_metric_snapshot *snapshot =3D NULL;
> > +     u32 nr =3D 0;
> > +     u64 total_sent =3D 0;
> > +     u64 nonzero_sends =3D 0;
> > +     u32 i;
> > +
> > +     if (!mdsc) {
>
> Does it really possible that mdsc could be not available? Could we have r=
ace
> conditions here? Because, I don't see any use of lock here.

The mdsc NULL check is defensive programming. In practice, if the debugfs
   file exists, mdsc should be valid. However, during mount/unmount transit=
ions
   there could theoretically be a window. The mutex protects the actual dat=
a
   access. The check is consistent with other debugfs functions in the file=
.
> > +             seq_puts(s, "mds client unavailable\n");
> > +             return 0;
> > +     }
> > +
> > +     mutex_lock(&mdsc->subvol_metrics_last_mutex);
> > +     if (mdsc->subvol_metrics_last && mdsc->subvol_metrics_last_nr) {
> > +             nr =3D mdsc->subvol_metrics_last_nr;
>
> Could be nr unreasonably huge enough here? Does it make sense to check th=
is
> value before kmemdup call?
>
> Maybe, kmemdup_array() will be more useful here?
>
> > +             snapshot =3D kmemdup(mdsc->subvol_metrics_last,
> > +                                nr * sizeof(*snapshot),
> > +                                GFP_KERNEL);
> > +             if (!snapshot)
> > +                     nr =3D 0;
> > +     }
> > +     total_sent =3D mdsc->subvol_metrics_sent;
> > +     nonzero_sends =3D mdsc->subvol_metrics_nonzero_sends;
> > +     mutex_unlock(&mdsc->subvol_metrics_last_mutex);
> > +
> > +     seq_puts(s, "Last sent subvolume metrics:\n");
> > +     if (!nr) {
> > +             seq_puts(s, "  (none)\n");
> > +     } else {
> > +             seq_puts(s, "  subvol_id          rd_ops    wr_ops    rd_=
bytes       wr_bytes       rd_lat_us      wr_lat_us\n");
> > +             for (i =3D 0; i < nr; i++) {
> > +                     const struct ceph_subvol_metric_snapshot *e =3D &=
snapshot[i];
> > +
> > +                     seq_printf(s, "  %-18llu %-9llu %-9llu %-14llu %-=
14llu %-14llu %-14llu\n",
> > +                                e->subvolume_id,
> > +                                e->read_ops, e->write_ops,
> > +                                e->read_bytes, e->write_bytes,
> > +                                e->read_latency_us, e->write_latency_u=
s);
> > +             }
> > +     }
> > +     kfree(snapshot);
> > +
> > +     seq_puts(s, "\nStatistics:\n");
> > +     seq_printf(s, "  entries_sent:      %llu\n", total_sent);
> > +     seq_printf(s, "  non_zero_sends:    %llu\n", nonzero_sends);
> > +
> > +     seq_puts(s, "\nPending (unsent) subvolume metrics:\n");
> > +     ceph_subvolume_metrics_dump(&mdsc->subvol_metrics, s);
> > +     return 0;
> > +}
> > +
> >  DEFINE_SHOW_ATTRIBUTE(mdsmap);
> >  DEFINE_SHOW_ATTRIBUTE(mdsc);
> >  DEFINE_SHOW_ATTRIBUTE(caps);
> > @@ -369,7 +450,72 @@ DEFINE_SHOW_ATTRIBUTE(metrics_file);
> >  DEFINE_SHOW_ATTRIBUTE(metrics_latency);
> >  DEFINE_SHOW_ATTRIBUTE(metrics_size);
> >  DEFINE_SHOW_ATTRIBUTE(metrics_caps);
> > +DEFINE_SHOW_ATTRIBUTE(subvolume_metrics);
> > +
> > +static int metric_features_show(struct seq_file *s, void *p)
> > +{
> > +     struct ceph_fs_client *fsc =3D s->private;
> > +     struct ceph_mds_client *mdsc =3D fsc->mdsc;
> > +     unsigned long session_features =3D 0;
> > +     bool have_session =3D false;
> > +     bool metric_collect =3D false;
> > +     bool subvol_support =3D false;
> > +     bool metrics_enabled =3D false;
> > +     bool subvol_enabled =3D false;
> > +     int i;
> > +
> > +     if (!mdsc) {
>
> Ditto. Please, see my questions above.
>
> > +             seq_puts(s, "mds client unavailable\n");
> > +             return 0;
> > +     }
> > +
> > +     mutex_lock(&mdsc->mutex);
> > +     if (mdsc->metric.session) {
> > +             have_session =3D true;
> > +             session_features =3D mdsc->metric.session->s_features;
> > +     }
> > +     mutex_unlock(&mdsc->mutex);
> > +
> > +     if (have_session) {
> > +             metric_collect =3D
> > +                     test_bit(CEPHFS_FEATURE_METRIC_COLLECT,
> > +                              &session_features);
> > +             subvol_support =3D
> > +                     test_bit(CEPHFS_FEATURE_SUBVOLUME_METRICS,
> > +                              &session_features);
> > +     }
> > +
> > +     metrics_enabled =3D !disable_send_metrics && have_session && metr=
ic_collect;
> > +     subvol_enabled =3D metrics_enabled && subvol_support;
>
> Maybe, static inline function can contain this check?
>
> > +
> > +     seq_printf(s,
> > +                "metrics_enabled: %s (disable_send_metrics=3D%d, sessi=
on=3D%s, metric_collect=3D%s)\n",
> > +                metrics_enabled ? "yes" : "no",
> > +                disable_send_metrics ? 1 : 0,
> > +                have_session ? "yes" : "no",
> > +                metric_collect ? "yes" : "no");
> > +     seq_printf(s, "subvolume_metrics_enabled: %s\n",
> > +                subvol_enabled ? "yes" : "no");
> > +     seq_printf(s, "session_feature_bits: 0x%lx\n", session_features);
> > +
> > +     if (!have_session) {
> > +             seq_puts(s, "(no active MDS session for metrics)\n");
> > +             return 0;
> > +     }
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(ceph_session_feature_table); i++) {
> > +             const struct ceph_session_feature_desc *desc =3D
> > +                     &ceph_session_feature_table[i];
> > +             bool set =3D test_bit(desc->bit, &session_features);
> > +
> > +             seq_printf(s, "  %-24s : %s\n", desc->name,
> > +                        set ? "yes" : "no");
> > +     }
> > +
> > +     return 0;
> > +}
> >
> > +DEFINE_SHOW_ATTRIBUTE(metric_features);
> >
> >  /*
> >   * debugfs
> > @@ -404,6 +550,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client =
*fsc)
> >       debugfs_remove(fsc->debugfs_caps);
> >       debugfs_remove(fsc->debugfs_status);
> >       debugfs_remove(fsc->debugfs_mdsc);
> > +     debugfs_remove(fsc->debugfs_subvolume_metrics);
> >       debugfs_remove_recursive(fsc->debugfs_metrics_dir);
> >       doutc(fsc->client, "done\n");
> >  }
> > @@ -468,6 +615,12 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *f=
sc)
> >                           &metrics_size_fops);
> >       debugfs_create_file("caps", 0400, fsc->debugfs_metrics_dir, fsc,
> >                           &metrics_caps_fops);
> > +     debugfs_create_file("metric_features", 0400, fsc->debugfs_metrics=
_dir,
> > +                         fsc, &metric_features_fops);
> > +     fsc->debugfs_subvolume_metrics =3D
> > +             debugfs_create_file("subvolumes", 0400,
> > +                                 fsc->debugfs_metrics_dir, fsc,
> > +                                 &subvolume_metrics_fops);
> >       doutc(fsc->client, "done\n");
> >  }
> >
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 99b30f784ee2..8c0e29c464b7 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -19,6 +19,19 @@
> >  #include "cache.h"
> >  #include "io.h"
> >  #include "metric.h"
> > +#include "subvolume_metrics.h"
> > +
> > +static inline void ceph_record_subvolume_io(struct inode *inode, bool =
is_write,
> > +                                         ktime_t start, ktime_t end,
> > +                                         size_t bytes)
> > +{
> > +     if (!bytes)
> > +             return;
> > +
> > +     ceph_subvolume_metrics_record_io(ceph_sb_to_mdsc(inode->i_sb),
> > +                                      ceph_inode(inode),
> > +                                      is_write, bytes, start, end);
> > +}
> >
> >  static __le32 ceph_flags_sys2wire(struct ceph_mds_client *mdsc, u32 fl=
ags)
> >  {
> > @@ -1140,6 +1153,11 @@ ssize_t __ceph_sync_read(struct inode *inode, lo=
ff_t *ki_pos,
> >                                        req->r_start_latency,
> >                                        req->r_end_latency,
> >                                        read_len, ret);
> > +             if (ret > 0)
>
> What's about ret =3D=3D 0? Do we need to take into account ret value at a=
ll?
>
> > +                     ceph_record_subvolume_io(inode, false,
> > +                                              req->r_start_latency,
> > +                                              req->r_end_latency,
> > +                                              ret);
> >
> >               if (ret > 0)
> >                       objver =3D req->r_version;
> > @@ -1385,12 +1403,23 @@ static void ceph_aio_complete_req(struct ceph_o=
sd_request *req)
> >
> >       /* r_start_latency =3D=3D 0 means the request was not submitted *=
/
> >       if (req->r_start_latency) {
> > -             if (aio_req->write)
> > +             if (aio_req->write) {
> >                       ceph_update_write_metrics(metric, req->r_start_la=
tency,
> >                                                 req->r_end_latency, len=
, rc);
> > -             else
> > +                     if (rc >=3D 0 && len)
> > +                             ceph_record_subvolume_io(inode, true,
> > +                                                      req->r_start_lat=
ency,
> > +                                                      req->r_end_laten=
cy,
> > +                                                      len);
> > +             } else {
> >                       ceph_update_read_metrics(metric, req->r_start_lat=
ency,
> >                                                req->r_end_latency, len,=
 rc);
> > +                     if (rc > 0)
>
> What's about rc =3D=3D 0?
>
> > +                             ceph_record_subvolume_io(inode, false,
> > +                                                      req->r_start_lat=
ency,
> > +                                                      req->r_end_laten=
cy,
> > +                                                      rc);
> > +             }
> >       }
> >
> >       put_bvecs(osd_data->bvec_pos.bvecs, osd_data->num_bvecs,
> > @@ -1614,12 +1643,23 @@ ceph_direct_read_write(struct kiocb *iocb, stru=
ct iov_iter *iter,
> >               ceph_osdc_start_request(req->r_osdc, req);
> >               ret =3D ceph_osdc_wait_request(&fsc->client->osdc, req);
> >
> > -             if (write)
> > +             if (write) {
> >                       ceph_update_write_metrics(metric, req->r_start_la=
tency,
> >                                                 req->r_end_latency, len=
, ret);
> > -             else
> > +                     if (ret >=3D 0 && len)
> > +                             ceph_record_subvolume_io(inode, true,
> > +                                                      req->r_start_lat=
ency,
> > +                                                      req->r_end_laten=
cy,
> > +                                                      len);
> > +             } else {
> >                       ceph_update_read_metrics(metric, req->r_start_lat=
ency,
> >                                                req->r_end_latency, len,=
 ret);
> > +                     if (ret > 0)
>
> What's about ret =3D=3D 0?
>
> > +                             ceph_record_subvolume_io(inode, false,
> > +                                                      req->r_start_lat=
ency,
> > +                                                      req->r_end_laten=
cy,
> > +                                                      ret);
> > +             }
> >
> >               size =3D i_size_read(inode);
> >               if (!write) {
> > @@ -1872,6 +1912,11 @@ ceph_sync_write(struct kiocb *iocb, struct iov_i=
ter *from, loff_t pos,
> >                                                req->r_start_latency,
> >                                                req->r_end_latency,
> >                                                read_len, ret);
> > +                     if (ret > 0)
>
> What's about ret =3D=3D 0?

es, we need to check rc/ret values:
   - For WRITES: We check `rc >=3D 0 && len > 0` because:
     * rc < 0 means the write failed - don't count failed I/O
     * len > 0 ensures we actually wrote something

   - For READS: We check `ret > 0` (not `ret >=3D 0`) because:
     * ret < 0 means the read failed
     * ret =3D=3D 0 means EOF (zero bytes read) - this is NOT an I/O operat=
ion
       to count in metrics, it's just "nothing to read"
     * ret > 0 means actual bytes were read

   This matches the existing ceph_update_read_metrics/ceph_update_write_met=
rics
   behavior which also filters on rc values (see metric.c line 514).

>
> > +                             ceph_record_subvolume_io(inode, false,
> > +                                                      req->r_start_lat=
ency,
> > +                                                      req->r_end_laten=
cy,
> > +                                                      ret);
> >
> >                       /* Ok if object is not already present */
> >                       if (ret =3D=3D -ENOENT) {
> > @@ -2036,6 +2081,11 @@ ceph_sync_write(struct kiocb *iocb, struct iov_i=
ter *from, loff_t pos,
> >
> >               ceph_update_write_metrics(&fsc->mdsc->metric, req->r_star=
t_latency,
> >                                         req->r_end_latency, len, ret);
> > +             if (ret >=3D 0 && write_len)
> > +                     ceph_record_subvolume_io(inode, true,
> > +                                              req->r_start_latency,
> > +                                              req->r_end_latency,
> > +                                              write_len);
> >               ceph_osdc_put_request(req);
> >               if (ret !=3D 0) {
> >                       doutc(cl, "osd write returned %d\n", ret);
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 099b8f22683b..2b831f48c844 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -67,6 +67,22 @@ static void ceph_cap_reclaim_work(struct work_struct=
 *work);
> >
> >  static const struct ceph_connection_operations mds_con_ops;
> >
> > +static void ceph_metric_bind_session(struct ceph_mds_client *mdsc,
> > +                                  struct ceph_mds_session *session)
> > +{
> > +     struct ceph_mds_session *old;
> > +
> > +     if (!mdsc || !session || disable_send_metrics)
>
> Maybe, disable_send_metrics could be the part of struct ceph_mds_session =
or
> struct ceph_mds_client?
disable_send_metrics is a module parameter that applies globally to
all mounts/sessions.
Moving it to a per-client struct would change semantics. Users would
need to configure it separately for each mount instead
of once globally via /sys/module/ceph/parameters/disable_send_metrics.
The current approach matches the original design of the metrics
infrastructure.

>
> > +             return;
> > +
> > +     old =3D mdsc->metric.session;
> > +     mdsc->metric.session =3D ceph_get_mds_session(session);
> > +     if (old)
> > +             ceph_put_mds_session(old);
> > +
> > +     metric_schedule_delayed(&mdsc->metric);
> > +}
> > +
> >
> >  /*
> >   * mds reply parsing
> > @@ -95,21 +111,23 @@ static int parse_reply_info_quota(void **p, void *=
end,
> >       return -EIO;
> >  }
> >
> > -/*
> > - * parse individual inode info
> > - */
> >  static int parse_reply_info_in(void **p, void *end,
> >                              struct ceph_mds_reply_info_in *info,
> > -                            u64 features)
> > +                            u64 features,
> > +                            struct ceph_mds_client *mdsc)
> >  {
> >       int err =3D 0;
> >       u8 struct_v =3D 0;
> > +     u8 struct_compat =3D 0;
> > +     u32 struct_len =3D 0;
> > +     struct ceph_client *cl =3D mdsc ? mdsc->fsc->client : NULL;
> > +
> > +     info->subvolume_id =3D 0;
> > +     doutc(cl, "subv_metric parse start features=3D0x%llx\n", features=
);
> >
> >       info->subvolume_id =3D 0;
> >
> >       if (features =3D=3D (u64)-1) {
> > -             u32 struct_len;
> > -             u8 struct_compat;
> >               ceph_decode_8_safe(p, end, struct_v, bad);
> >               ceph_decode_8_safe(p, end, struct_compat, bad);
> >               /* struct_v is expected to be >=3D 1. we only understand
> > @@ -389,12 +407,13 @@ static int parse_reply_info_lease(void **p, void =
*end,
> >   */
> >  static int parse_reply_info_trace(void **p, void *end,
> >                                 struct ceph_mds_reply_info_parsed *info=
,
> > -                               u64 features)
> > +                               u64 features,
> > +                               struct ceph_mds_client *mdsc)
> >  {
> >       int err;
> >
> >       if (info->head->is_dentry) {
> > -             err =3D parse_reply_info_in(p, end, &info->diri, features=
);
> > +             err =3D parse_reply_info_in(p, end, &info->diri, features=
, mdsc);
> >               if (err < 0)
> >                       goto out_bad;
> >
> > @@ -414,7 +433,8 @@ static int parse_reply_info_trace(void **p, void *e=
nd,
> >       }
> >
> >       if (info->head->is_target) {
> > -             err =3D parse_reply_info_in(p, end, &info->targeti, featu=
res);
> > +             err =3D parse_reply_info_in(p, end, &info->targeti, featu=
res,
> > +                                       mdsc);
> >               if (err < 0)
> >                       goto out_bad;
> >       }
> > @@ -435,7 +455,8 @@ static int parse_reply_info_trace(void **p, void *e=
nd,
> >   */
> >  static int parse_reply_info_readdir(void **p, void *end,
> >                                   struct ceph_mds_request *req,
> > -                                 u64 features)
> > +                                 u64 features,
> > +                                 struct ceph_mds_client *mdsc)
> >  {
> >       struct ceph_mds_reply_info_parsed *info =3D &req->r_reply_info;
> >       struct ceph_client *cl =3D req->r_mdsc->fsc->client;
> > @@ -550,7 +571,7 @@ static int parse_reply_info_readdir(void **p, void =
*end,
> >               rde->name_len =3D oname.len;
> >
> >               /* inode */
> > -             err =3D parse_reply_info_in(p, end, &rde->inode, features=
);
> > +             err =3D parse_reply_info_in(p, end, &rde->inode, features=
, mdsc);
> >               if (err < 0)
> >                       goto out_bad;
> >               /* ceph_readdir_prepopulate() will update it */
> > @@ -758,7 +779,8 @@ static int parse_reply_info_extra(void **p, void *e=
nd,
> >       if (op =3D=3D CEPH_MDS_OP_GETFILELOCK)
> >               return parse_reply_info_filelock(p, end, info, features);
> >       else if (op =3D=3D CEPH_MDS_OP_READDIR || op =3D=3D CEPH_MDS_OP_L=
SSNAP)
> > -             return parse_reply_info_readdir(p, end, req, features);
> > +             return parse_reply_info_readdir(p, end, req, features,
> > +                                             req->r_mdsc);
> >       else if (op =3D=3D CEPH_MDS_OP_CREATE)
> >               return parse_reply_info_create(p, end, info, features, s)=
;
> >       else if (op =3D=3D CEPH_MDS_OP_GETVXATTR)
> > @@ -787,7 +809,8 @@ static int parse_reply_info(struct ceph_mds_session=
 *s, struct ceph_msg *msg,
> >       ceph_decode_32_safe(&p, end, len, bad);
> >       if (len > 0) {
> >               ceph_decode_need(&p, end, len, bad);
> > -             err =3D parse_reply_info_trace(&p, p+len, info, features)=
;
> > +             err =3D parse_reply_info_trace(&p, p + len, info, feature=
s,
> > +                                          s->s_mdsc);
> >               if (err < 0)
> >                       goto out_bad;
> >       }
> > @@ -796,7 +819,7 @@ static int parse_reply_info(struct ceph_mds_session=
 *s, struct ceph_msg *msg,
> >       ceph_decode_32_safe(&p, end, len, bad);
> >       if (len > 0) {
> >               ceph_decode_need(&p, end, len, bad);
> > -             err =3D parse_reply_info_extra(&p, p+len, req, features, =
s);
> > +             err =3D parse_reply_info_extra(&p, p + len, req, features=
, s);
>
> Does this change really necessary? :)
>
> >               if (err < 0)
> >                       goto out_bad;
> >       }
> > @@ -4326,6 +4349,11 @@ static void handle_session(struct ceph_mds_sessi=
on *session,
> >               }
> >               mdsc->s_cap_auths_num =3D cap_auths_num;
> >               mdsc->s_cap_auths =3D cap_auths;
> > +
> > +             session->s_features =3D features;
> > +             if (test_bit(CEPHFS_FEATURE_METRIC_COLLECT,
> > +                          &session->s_features))
> > +                     ceph_metric_bind_session(mdsc, session);
> >       }
> >       if (op =3D=3D CEPH_SESSION_CLOSE) {
> >               ceph_get_mds_session(session);
> > @@ -4352,7 +4380,11 @@ static void handle_session(struct ceph_mds_sessi=
on *session,
> >                       pr_info_client(cl, "mds%d reconnect success\n",
> >                                      session->s_mds);
> >
> > -             session->s_features =3D features;
> > +             if (test_bit(CEPHFS_FEATURE_SUBVOLUME_METRICS,
> > +                          &session->s_features))
> > +                     ceph_subvolume_metrics_enable(&mdsc->subvol_metri=
cs, true);
> > +             else
> > +                     ceph_subvolume_metrics_enable(&mdsc->subvol_metri=
cs, false);
> >               if (session->s_state =3D=3D CEPH_MDS_SESSION_OPEN) {
> >                       pr_notice_client(cl, "mds%d is already opened\n",
> >                                        session->s_mds);
> > @@ -5591,6 +5623,12 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
> >       err =3D ceph_metric_init(&mdsc->metric);
> >       if (err)
> >               goto err_mdsmap;
> > +     ceph_subvolume_metrics_init(&mdsc->subvol_metrics);
> > +     mutex_init(&mdsc->subvol_metrics_last_mutex);
> > +     mdsc->subvol_metrics_last =3D NULL;
> > +     mdsc->subvol_metrics_last_nr =3D 0;
> > +     mdsc->subvol_metrics_sent =3D 0;
> > +     mdsc->subvol_metrics_nonzero_sends =3D 0;
> >
> >       spin_lock_init(&mdsc->dentry_list_lock);
> >       INIT_LIST_HEAD(&mdsc->dentry_leases);
> > @@ -6123,6 +6161,8 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc=
)
> >       ceph_mdsc_stop(mdsc);
> >
> >       ceph_metric_destroy(&mdsc->metric);
> > +     ceph_subvolume_metrics_destroy(&mdsc->subvol_metrics);
> > +     kfree(mdsc->subvol_metrics_last);
>
> Why do not free everything in ceph_subvolume_metrics_destroy()?
>
> >
> >       fsc->mdsc =3D NULL;
> >       kfree(mdsc);
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index bd3690baa65c..4e6c87f8414c 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -18,6 +18,7 @@
> >
> >  #include "mdsmap.h"
> >  #include "metric.h"
> > +#include "subvolume_metrics.h"
> >  #include "super.h"
> >
> >  /* The first 8 bits are reserved for old ceph releases */
> > @@ -36,8 +37,9 @@ enum ceph_feature_type {
> >       CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
> >       CEPHFS_FEATURE_HAS_OWNER_UIDGID,
> >       CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,
> > +     CEPHFS_FEATURE_SUBVOLUME_METRICS,
> >
> > -     CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,
> > +     CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_SUBVOLUME_METRICS,
> >  };
> >
> >  #define CEPHFS_FEATURES_CLIENT_SUPPORTED {   \
> > @@ -54,6 +56,7 @@ enum ceph_feature_type {
> >       CEPHFS_FEATURE_32BITS_RETRY_FWD,        \
> >       CEPHFS_FEATURE_HAS_OWNER_UIDGID,        \
> >       CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,     \
> > +     CEPHFS_FEATURE_SUBVOLUME_METRICS,       \
> >  }
> >
> >  /*
> > @@ -537,6 +540,14 @@ struct ceph_mds_client {
> >       struct list_head  dentry_dir_leases; /* lru list */
> >
> >       struct ceph_client_metric metric;
> > +     struct ceph_subvolume_metrics_tracker subvol_metrics;
> > +
> > +     /* Subvolume metrics send tracking */
> > +     struct mutex            subvol_metrics_last_mutex;
> > +     struct ceph_subvol_metric_snapshot *subvol_metrics_last;
> > +     u32                     subvol_metrics_last_nr;
> > +     u64                     subvol_metrics_sent;
> > +     u64                     subvol_metrics_nonzero_sends;
> >
> >       spinlock_t              snapid_map_lock;
> >       struct rb_root          snapid_map_tree;
> > diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
> > index 871c1090e520..8ff6bcb50bc4 100644
> > --- a/fs/ceph/metric.c
> > +++ b/fs/ceph/metric.c
> > @@ -4,10 +4,85 @@
> >  #include <linux/types.h>
> >  #include <linux/percpu_counter.h>
> >  #include <linux/math64.h>
> > +#include <linux/ratelimit.h>
> > +
> > +#include <linux/ceph/decode.h>
> >
> >  #include "metric.h"
> >  #include "mds_client.h"
> >
> > +static DEFINE_RATELIMIT_STATE(metrics_no_session_rs, HZ, 1);
> > +static bool metrics_disable_warned;
>
> Ditto. Why does it not the part of any structure?
>
> > +
> > +static inline u32 ceph_subvolume_entry_payload_len(void)
> > +{
> > +     return sizeof(struct ceph_subvolume_metric_entry_wire);
> > +}
> > +
> > +static inline u32 ceph_subvolume_entry_encoded_len(void)
> > +{
> > +     return CEPH_ENCODING_START_BLK_LEN +
> > +             ceph_subvolume_entry_payload_len();
> > +}
> > +
> > +static inline u32 ceph_subvolume_outer_payload_len(u32 nr_subvols)
> > +{
> > +     /* count is encoded as le64 (size_t on wire) to match FUSE client=
 */
> > +     return sizeof(__le64) +
> > +             nr_subvols * ceph_subvolume_entry_encoded_len();
> > +}
> > +
> > +static inline u32 ceph_subvolume_metric_data_len(u32 nr_subvols)
> > +{
> > +     return CEPH_ENCODING_START_BLK_LEN +
> > +             ceph_subvolume_outer_payload_len(nr_subvols);
> > +}
> > +
> > +static inline u32 ceph_subvolume_clamp_u32(u64 val)
>
> What is the point of such function?
>
> > +{
> > +     return val > U32_MAX ? U32_MAX : (u32)val;
> > +}
> > +
> > +static void ceph_init_subvolume_wire_entry(
> > +     struct ceph_subvolume_metric_entry_wire *dst,
> > +     const struct ceph_subvol_metric_snapshot *src)
> > +{
> > +     dst->subvolume_id =3D cpu_to_le64(src->subvolume_id);
> > +     dst->read_ops =3D cpu_to_le32(ceph_subvolume_clamp_u32(src->read_=
ops));
> > +     dst->write_ops =3D cpu_to_le32(ceph_subvolume_clamp_u32(src->writ=
e_ops));
> > +     dst->read_bytes =3D cpu_to_le64(src->read_bytes);
> > +     dst->write_bytes =3D cpu_to_le64(src->write_bytes);
> > +     dst->read_latency_us =3D cpu_to_le64(src->read_latency_us);
> > +     dst->write_latency_us =3D cpu_to_le64(src->write_latency_us);
> > +     dst->time_stamp =3D 0;
> > +}
> > +
> > +static int ceph_encode_subvolume_metrics(void **p, void *end,
> > +                                      struct ceph_subvol_metric_snapsh=
ot *subvols,
> > +                                      u32 nr_subvols)
> > +{
> > +     u32 i;
> > +
> > +     ceph_start_encoding(p, 1, 1,
> > +                         ceph_subvolume_outer_payload_len(nr_subvols))=
;
> > +     /* count is encoded as le64 (size_t on wire) to match FUSE client=
 */
> > +     ceph_encode_64_safe(p, end, (u64)nr_subvols, enc_err);
> > +
> > +     for (i =3D 0; i < nr_subvols; i++) {
> > +             struct ceph_subvolume_metric_entry_wire wire_entry;
> > +
> > +             ceph_init_subvolume_wire_entry(&wire_entry, &subvols[i]);
> > +             ceph_start_encoding(p, 1, 1,
> > +                                 ceph_subvolume_entry_payload_len());
> > +             ceph_encode_copy_safe(p, end, &wire_entry,
> > +                                   sizeof(wire_entry), enc_err);
> > +     }
> > +
> > +     return 0;
> > +enc_err:
> > +     return -ERANGE;
> > +}
> > +
> >  static void ktime_to_ceph_timespec(struct ceph_timespec *ts, ktime_t v=
al)
> >  {
> >       struct timespec64 t =3D ktime_to_timespec64(val);
> > @@ -29,10 +104,14 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds=
_client *mdsc,
> >       struct ceph_read_io_size *rsize;
> >       struct ceph_write_io_size *wsize;
> >       struct ceph_client_metric *m =3D &mdsc->metric;
> > +     struct ceph_subvol_metric_snapshot *subvols =3D NULL;
> >       u64 nr_caps =3D atomic64_read(&m->total_caps);
> >       u32 header_len =3D sizeof(struct ceph_metric_header);
> >       struct ceph_client *cl =3D mdsc->fsc->client;
> >       struct ceph_msg *msg;
> > +     u32 nr_subvols =3D 0;
> > +     size_t subvol_len =3D 0;
> > +     void *cursor;
> >       s64 sum;
> >       s32 items =3D 0;
> >       s32 len;
> > @@ -45,15 +124,37 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds=
_client *mdsc,
> >       }
> >       mutex_unlock(&mdsc->mutex);
> >
> > +     if (ceph_subvolume_metrics_enabled(&mdsc->subvol_metrics) &&
> > +         test_bit(CEPHFS_FEATURE_SUBVOLUME_METRICS, &s->s_features)) {
> > +             int ret;
> > +
> > +             ret =3D ceph_subvolume_metrics_snapshot(&mdsc->subvol_met=
rics,
> > +                                                   &subvols, &nr_subvo=
ls,
> > +                                                   true);
> > +             if (ret) {
> > +                     pr_warn_client(cl, "failed to snapshot subvolume =
metrics: %d\n",
> > +                                    ret);
> > +                     nr_subvols =3D 0;
> > +                     subvols =3D NULL;
> > +             }
> > +     }
> > +
> > +     if (nr_subvols) {
> > +             /* type (le32) + ENCODE_START payload - no metric header =
*/
> > +             subvol_len =3D sizeof(__le32) +
> > +                          ceph_subvolume_metric_data_len(nr_subvols);
> > +     }
> > +
> >       len =3D sizeof(*head) + sizeof(*cap) + sizeof(*read) + sizeof(*wr=
ite)
> >             + sizeof(*meta) + sizeof(*dlease) + sizeof(*files)
> >             + sizeof(*icaps) + sizeof(*inodes) + sizeof(*rsize)
> > -           + sizeof(*wsize);
> > +           + sizeof(*wsize) + subvol_len;
> >
> >       msg =3D ceph_msg_new(CEPH_MSG_CLIENT_METRICS, len, GFP_NOFS, true=
);
> >       if (!msg) {
> >               pr_err_client(cl, "to mds%d, failed to allocate message\n=
",
> >                             s->s_mds);
> > +             kfree(subvols);
>
> It is not clear here. Where subvols have been allocated before?
>
> >               return false;
> >       }
> >
> > @@ -172,13 +273,56 @@ static bool ceph_mdsc_send_metrics(struct ceph_md=
s_client *mdsc,
> >       wsize->total_size =3D cpu_to_le64(m->metric[METRIC_WRITE].size_su=
m);
> >       items++;
> >
> > +     cursor =3D wsize + 1;
> > +
> > +     if (nr_subvols) {
> > +             void *payload;
> > +             void *payload_end;
> > +             int ret;
> > +
> > +             /* Emit only the type (le32), no ver/compat/data_len */
> > +             ceph_encode_32(&cursor, CLIENT_METRIC_TYPE_SUBVOLUME_METR=
ICS);
> > +             items++;
> > +
> > +             payload =3D cursor;
> > +             payload_end =3D (char *)payload +
> > +                           ceph_subvolume_metric_data_len(nr_subvols);
> > +
> > +             ret =3D ceph_encode_subvolume_metrics(&payload, payload_e=
nd,
> > +                                                 subvols, nr_subvols);
> > +             if (ret) {
> > +                     pr_warn_client(cl,
> > +                                    "failed to encode subvolume metric=
s\n");
> > +                     kfree(subvols);
>
> Ditto.
>
> > +                     ceph_msg_put(msg);
> > +                     return false;
> > +             }
> > +
> > +             WARN_ON(payload !=3D payload_end);
> > +             cursor =3D payload;
> > +     }
> > +
> >       put_unaligned_le32(items, &head->num);
> > -     msg->front.iov_len =3D len;
> > +     msg->front.iov_len =3D (char *)cursor - (char *)head;
> >       msg->hdr.version =3D cpu_to_le16(1);
> >       msg->hdr.compat_version =3D cpu_to_le16(1);
> >       msg->hdr.front_len =3D cpu_to_le32(msg->front.iov_len);
> > +
> >       ceph_con_send(&s->s_con, msg);
> >
> > +     if (nr_subvols) {
> > +             mutex_lock(&mdsc->subvol_metrics_last_mutex);
> > +             kfree(mdsc->subvol_metrics_last);
> > +             mdsc->subvol_metrics_last =3D subvols;
> > +             mdsc->subvol_metrics_last_nr =3D nr_subvols;
> > +             mdsc->subvol_metrics_sent +=3D nr_subvols;
> > +             mdsc->subvol_metrics_nonzero_sends++;
> > +             mutex_unlock(&mdsc->subvol_metrics_last_mutex);
> > +
> > +             subvols =3D NULL;
> > +     }
> > +     kfree(subvols);
>
> Maybe, it makes sense to jump here from all places of calling kfree(subvo=
ls)?
>
> > +
> >       return true;
> >  }
> >
> > @@ -201,6 +345,12 @@ static void metric_get_session(struct ceph_mds_cli=
ent *mdsc)
> >                */
> >               if (check_session_state(s) &&
> >                   test_bit(CEPHFS_FEATURE_METRIC_COLLECT, &s->s_feature=
s)) {
> > +                     if (ceph_subvolume_metrics_enabled(&mdsc->subvol_=
metrics) &&
> > +                         !test_bit(CEPHFS_FEATURE_SUBVOLUME_METRICS,
> > +                                   &s->s_features)) {
> > +                             ceph_put_mds_session(s);
> > +                             continue;
> > +                     }
> >                       mdsc->metric.session =3D s;
> >                       break;
> >               }
> > @@ -217,8 +367,17 @@ static void metric_delayed_work(struct work_struct=
 *work)
> >       struct ceph_mds_client *mdsc =3D
> >               container_of(m, struct ceph_mds_client, metric);
> >
> > -     if (mdsc->stopping || disable_send_metrics)
> > +     if (mdsc->stopping)
> > +             return;
> > +
> > +     if (disable_send_metrics) {
> > +             if (!metrics_disable_warned) {
> > +                     pr_err("ceph: metrics worker disabled via module =
parameter\n");
>
> It looks like not error but why pr_err() was used here?
>
> > +                     metrics_disable_warned =3D true;
> > +             }
> >               return;
> > +     }
> > +     metrics_disable_warned =3D false;
> >
> >       if (!m->session || !check_session_state(m->session)) {
> >               if (m->session) {
> > @@ -227,10 +386,15 @@ static void metric_delayed_work(struct work_struc=
t *work)
> >               }
> >               metric_get_session(mdsc);
> >       }
> > +
> >       if (m->session) {
> >               ceph_mdsc_send_metrics(mdsc, m->session);
> > -             metric_schedule_delayed(m);
> > +     } else {
> > +             if (__ratelimit(&metrics_no_session_rs))
> > +                     pr_warn("ceph: metrics worker missing MDS session=
\n");
>
> Why not pr_warn_ratelimited()?
>
> >       }
> > +
> > +     metric_schedule_delayed(m);
> >  }
> >
> >  int ceph_metric_init(struct ceph_client_metric *m)
> > diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
> > index 0d0c44bd3332..7e4aac63f6a6 100644
> > --- a/fs/ceph/metric.h
> > +++ b/fs/ceph/metric.h
> > @@ -25,8 +25,9 @@ enum ceph_metric_type {
> >       CLIENT_METRIC_TYPE_STDEV_WRITE_LATENCY,
> >       CLIENT_METRIC_TYPE_AVG_METADATA_LATENCY,
> >       CLIENT_METRIC_TYPE_STDEV_METADATA_LATENCY,
> > +     CLIENT_METRIC_TYPE_SUBVOLUME_METRICS,
> >
> > -     CLIENT_METRIC_TYPE_MAX =3D CLIENT_METRIC_TYPE_STDEV_METADATA_LATE=
NCY,
> > +     CLIENT_METRIC_TYPE_MAX =3D CLIENT_METRIC_TYPE_SUBVOLUME_METRICS,
> >  };
> >
> >  /*
> > @@ -50,6 +51,7 @@ enum ceph_metric_type {
> >       CLIENT_METRIC_TYPE_STDEV_WRITE_LATENCY,    \
> >       CLIENT_METRIC_TYPE_AVG_METADATA_LATENCY,   \
> >       CLIENT_METRIC_TYPE_STDEV_METADATA_LATENCY, \
> > +     CLIENT_METRIC_TYPE_SUBVOLUME_METRICS,      \
> >                                                  \
> >       CLIENT_METRIC_TYPE_MAX,                    \
> >  }
> > @@ -139,6 +141,29 @@ struct ceph_write_io_size {
> >       __le64 total_size;
> >  } __packed;
> >
> > +/* Wire format for subvolume metrics - matches C++ AggregatedIOMetrics=
 */
> > +struct ceph_subvolume_metric_entry_wire {
> > +     __le64 subvolume_id;
> > +     __le32 read_ops;
> > +     __le32 write_ops;
> > +     __le64 read_bytes;
> > +     __le64 write_bytes;
> > +     __le64 read_latency_us;
> > +     __le64 write_latency_us;
> > +     __le64 time_stamp;
> > +} __packed;
>
> Why do we not provide detailed comments of fields?
>
> > +
> > +/* Old struct kept for internal tracking, not used on wire */
> > +struct ceph_subvolume_metric_entry {
> > +     __le64 subvolume_id;
> > +     __le64 read_ops;
> > +     __le64 write_ops;
> > +     __le64 read_bytes;
> > +     __le64 write_bytes;
> > +     __le64 read_latency_us;
> > +     __le64 write_latency_us;
> > +} __packed;
>
> Ditto.
>
> > +
> >  struct ceph_metric_head {
> >       __le32 num;     /* the number of metrics that will be sent */
> >  } __packed;
>
> Structure with one member?
>
> > diff --git a/fs/ceph/subvolume_metrics.c b/fs/ceph/subvolume_metrics.c
> > new file mode 100644
> > index 000000000000..7036ff5418ab
> > --- /dev/null
> > +++ b/fs/ceph/subvolume_metrics.c
> > @@ -0,0 +1,408 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/ceph/ceph_debug.h>
> > +
> > +#include <linux/math64.h>
> > +#include <linux/slab.h>
> > +#include <linux/seq_file.h>
> > +
> > +#include "subvolume_metrics.h"
> > +#include "mds_client.h"
> > +#include "super.h"
> > +
> > +struct ceph_subvol_metric_rb_entry {
> > +     struct rb_node node;
> > +     u64 subvolume_id;
> > +     u64 read_ops;
> > +     u64 write_ops;
> > +     u64 read_bytes;
> > +     u64 write_bytes;
> > +     u64 read_latency_us;
> > +     u64 write_latency_us;
> > +};
>
> What's about comments for fields?
>
> > +
> > +void ceph_subvolume_metrics_init(struct ceph_subvolume_metrics_tracker=
 *tracker)
> > +{
> > +     spin_lock_init(&tracker->lock);
> > +     tracker->tree =3D RB_ROOT_CACHED;
> > +     tracker->nr_entries =3D 0;
> > +     tracker->enabled =3D false;
> > +     atomic64_set(&tracker->snapshot_attempts, 0);
> > +     atomic64_set(&tracker->snapshot_empty, 0);
> > +     atomic64_set(&tracker->snapshot_failures, 0);
> > +     atomic64_set(&tracker->record_calls, 0);
> > +     atomic64_set(&tracker->record_disabled, 0);
> > +     atomic64_set(&tracker->record_no_subvol, 0);
> > +     atomic64_set(&tracker->total_read_ops, 0);
> > +     atomic64_set(&tracker->total_read_bytes, 0);
> > +     atomic64_set(&tracker->total_write_ops, 0);
> > +     atomic64_set(&tracker->total_write_bytes, 0);
> > +}
> > +
> > +static struct ceph_subvol_metric_rb_entry *
> > +__lookup_entry(struct ceph_subvolume_metrics_tracker *tracker, u64 sub=
vol_id)
> > +{
> > +     struct rb_node *node;
> > +
> > +     node =3D tracker->tree.rb_root.rb_node;
> > +     while (node) {
> > +             struct ceph_subvol_metric_rb_entry *entry =3D
> > +                     rb_entry(node, struct ceph_subvol_metric_rb_entry=
, node);
> > +
> > +             if (subvol_id < entry->subvolume_id)
> > +                     node =3D node->rb_left;
> > +             else if (subvol_id > entry->subvolume_id)
> > +                     node =3D node->rb_right;
> > +             else
> > +                     return entry;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +static struct ceph_subvol_metric_rb_entry *
> > +__insert_entry(struct ceph_subvolume_metrics_tracker *tracker,
> > +            struct ceph_subvol_metric_rb_entry *entry)
> > +{
> > +     struct rb_node **link =3D &tracker->tree.rb_root.rb_node;
> > +     struct rb_node *parent =3D NULL;
> > +     bool leftmost =3D true;
> > +
> > +     while (*link) {
> > +             struct ceph_subvol_metric_rb_entry *cur =3D
> > +                     rb_entry(*link, struct ceph_subvol_metric_rb_entr=
y, node);
> > +
> > +             parent =3D *link;
> > +             if (entry->subvolume_id < cur->subvolume_id)
> > +                     link =3D &(*link)->rb_left;
> > +             else if (entry->subvolume_id > cur->subvolume_id) {
> > +                     link =3D &(*link)->rb_right;
> > +                     leftmost =3D false;
> > +             } else
> > +                     return cur;
> > +     }
> > +
> > +     rb_link_node(&entry->node, parent, link);
> > +     rb_insert_color_cached(&entry->node, &tracker->tree, leftmost);
> > +     tracker->nr_entries++;
> > +     return entry;
> > +}
> > +
> > +static void ceph_subvolume_metrics_clear_locked(
> > +             struct ceph_subvolume_metrics_tracker *tracker)
> > +{
> > +     struct rb_node *node =3D rb_first_cached(&tracker->tree);
> > +
> > +     while (node) {
> > +             struct ceph_subvol_metric_rb_entry *entry =3D
> > +                     rb_entry(node, struct ceph_subvol_metric_rb_entry=
, node);
> > +             struct rb_node *next =3D rb_next(node);
> > +
> > +             rb_erase_cached(&entry->node, &tracker->tree);
> > +             tracker->nr_entries--;
> > +             kfree(entry);
> > +             node =3D next;
> > +     }
> > +
> > +     tracker->tree =3D RB_ROOT_CACHED;
> > +}
> > +
> > +void ceph_subvolume_metrics_destroy(struct ceph_subvolume_metrics_trac=
ker *tracker)
> > +{
> > +     spin_lock(&tracker->lock);
> > +     ceph_subvolume_metrics_clear_locked(tracker);
> > +     tracker->enabled =3D false;
> > +     spin_unlock(&tracker->lock);
> > +}
> > +
> > +void ceph_subvolume_metrics_enable(struct ceph_subvolume_metrics_track=
er *tracker,
> > +                                bool enable)
> > +{
> > +     spin_lock(&tracker->lock);
> > +     if (enable) {
>
> Probably, we don't need curly braces here.
>
> > +             tracker->enabled =3D true;
> > +     } else {
> > +             tracker->enabled =3D false;
> > +             ceph_subvolume_metrics_clear_locked(tracker);
> > +     }
> > +     spin_unlock(&tracker->lock);
> > +}
> > +
> > +void ceph_subvolume_metrics_record(struct ceph_subvolume_metrics_track=
er *tracker,
> > +                                u64 subvol_id, bool is_write,
> > +                                size_t size, u64 latency_us)
> > +{
> > +     struct ceph_subvol_metric_rb_entry *entry, *new_entry =3D NULL;
> > +     bool retry =3D false;
> > +
> > +     /* 0 means unknown/unset subvolume (matches FUSE client conventio=
n) */
> > +     if (!READ_ONCE(tracker->enabled) || !subvol_id || !size || !laten=
cy_us)
> > +             return;
> > +
> > +     do {
> > +             spin_lock(&tracker->lock);
> > +             if (!tracker->enabled) {
> > +                     spin_unlock(&tracker->lock);
> > +                     kfree(new_entry);
> > +                     return;
> > +             }
> > +
> > +             entry =3D __lookup_entry(tracker, subvol_id);
> > +             if (!entry) {
> > +                     if (!new_entry) {
> > +                             spin_unlock(&tracker->lock);
> > +                             new_entry =3D kzalloc(sizeof(*new_entry),=
 GFP_NOFS);
>
> Do we need kmem_cache here?
>
> > +                             if (!new_entry)
> > +                                     return;
> > +                             new_entry->subvolume_id =3D subvol_id;
> > +                             retry =3D true;
> > +                             continue;
> > +                     }
> > +                     entry =3D __insert_entry(tracker, new_entry);
> > +                     if (entry !=3D new_entry) {
> > +                             /* raced with another insert */
> > +                             spin_unlock(&tracker->lock);
> > +                             kfree(new_entry);
> > +                             new_entry =3D NULL;
> > +                             retry =3D true;
> > +                             continue;
> > +                     }
> > +                     new_entry =3D NULL;
> > +             }
> > +
> > +             if (is_write) {
> > +                     entry->write_ops++;
> > +                     entry->write_bytes +=3D size;
> > +                     entry->write_latency_us +=3D latency_us;
> > +                     atomic64_inc(&tracker->total_write_ops);
> > +                     atomic64_add(size, &tracker->total_write_bytes);
> > +             } else {
> > +                     entry->read_ops++;
> > +                     entry->read_bytes +=3D size;
> > +                     entry->read_latency_us +=3D latency_us;
> > +                     atomic64_inc(&tracker->total_read_ops);
> > +                     atomic64_add(size, &tracker->total_read_bytes);
> > +             }
> > +             spin_unlock(&tracker->lock);
> > +             kfree(new_entry);
> > +             return;
> > +     } while (retry);
> > +}
> > +
> > +int ceph_subvolume_metrics_snapshot(struct ceph_subvolume_metrics_trac=
ker *tracker,
> > +                                 struct ceph_subvol_metric_snapshot **=
out,
> > +                                 u32 *nr, bool consume)
> > +{
> > +     struct ceph_subvol_metric_snapshot *snap =3D NULL;
> > +     struct rb_node *node;
> > +     u32 count =3D 0, idx =3D 0;
> > +     int ret =3D 0;
> > +
> > +     *out =3D NULL;
> > +     *nr =3D 0;
> > +
> > +     if (!READ_ONCE(tracker->enabled))
> > +             return 0;
> > +
> > +     atomic64_inc(&tracker->snapshot_attempts);
> > +
> > +     spin_lock(&tracker->lock);
> > +     for (node =3D rb_first_cached(&tracker->tree); node; node =3D rb_=
next(node)) {
> > +             struct ceph_subvol_metric_rb_entry *entry =3D
> > +                     rb_entry(node, struct ceph_subvol_metric_rb_entry=
, node);
> > +
> > +             /* Include entries with ANY I/O activity (read OR write) =
*/
> > +             if (entry->read_ops || entry->write_ops)
> > +                     count++;
> > +     }
> > +     spin_unlock(&tracker->lock);
> > +
> > +     if (!count) {
> > +             atomic64_inc(&tracker->snapshot_empty);
> > +             return 0;
> > +     }
> > +
> > +     snap =3D kcalloc(count, sizeof(*snap), GFP_NOFS);
> > +     if (!snap) {
> > +             atomic64_inc(&tracker->snapshot_failures);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     spin_lock(&tracker->lock);
> > +     node =3D rb_first_cached(&tracker->tree);
> > +     while (node) {
> > +             struct ceph_subvol_metric_rb_entry *entry =3D
> > +                     rb_entry(node, struct ceph_subvol_metric_rb_entry=
, node);
> > +             struct rb_node *next =3D rb_next(node);
> > +
> > +             /* Skip entries with NO I/O activity at all */
> > +             if (!entry->read_ops && !entry->write_ops) {
> > +                     rb_erase_cached(&entry->node, &tracker->tree);
> > +                     tracker->nr_entries--;
> > +                     kfree(entry);
> > +                     node =3D next;
> > +                     continue;
> > +             }
> > +
> > +             if (idx >=3D count) {
> > +                     pr_warn("ceph: subvol metrics snapshot race (idx=
=3D%u count=3D%u)\n",
> > +                             idx, count);
> > +                     break;
> > +             }
> > +
> > +             snap[idx].subvolume_id =3D entry->subvolume_id;
> > +             snap[idx].read_ops =3D entry->read_ops;
> > +             snap[idx].write_ops =3D entry->write_ops;
> > +             snap[idx].read_bytes =3D entry->read_bytes;
> > +             snap[idx].write_bytes =3D entry->write_bytes;
> > +             snap[idx].read_latency_us =3D entry->read_latency_us;
> > +             snap[idx].write_latency_us =3D entry->write_latency_us;
> > +             idx++;
> > +
> > +             if (consume) {
> > +                     entry->read_ops =3D 0;
> > +                     entry->write_ops =3D 0;
> > +                     entry->read_bytes =3D 0;
> > +                     entry->write_bytes =3D 0;
> > +                     entry->read_latency_us =3D 0;
> > +                     entry->write_latency_us =3D 0;
> > +                     rb_erase_cached(&entry->node, &tracker->tree);
> > +                     tracker->nr_entries--;
> > +                     kfree(entry);
> > +             }
> > +             node =3D next;
> > +     }
> > +     spin_unlock(&tracker->lock);
> > +
> > +     if (!idx) {
> > +             kfree(snap);
> > +             snap =3D NULL;
> > +             ret =3D 0;
> > +     } else {
> > +             *nr =3D idx;
> > +             *out =3D snap;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +void ceph_subvolume_metrics_free_snapshot(struct ceph_subvol_metric_sn=
apshot *snapshot)
> > +{
> > +     kfree(snapshot);
> > +}
> > +
> > +static u64 div_rem(u64 dividend, u64 divisor)
>
> Do we really need to introduce such function?
>
> > +{
> > +     return divisor ? div64_u64(dividend, divisor) : 0;
> > +}
> > +
> > +void ceph_subvolume_metrics_dump(struct ceph_subvolume_metrics_tracker=
 *tracker,
> > +                              struct seq_file *s)
> > +{
> > +     struct rb_node *node;
> > +     struct ceph_subvol_metric_snapshot *snapshot =3D NULL;
> > +     u32 count =3D 0, idx =3D 0;
> > +
> > +     spin_lock(&tracker->lock);
> > +     if (!tracker->enabled) {
> > +             spin_unlock(&tracker->lock);
> > +             seq_puts(s, "subvolume metrics disabled\n");
> > +             return;
> > +     }
> > +
> > +     for (node =3D rb_first_cached(&tracker->tree); node; node =3D rb_=
next(node)) {
> > +             struct ceph_subvol_metric_rb_entry *entry =3D
> > +                     rb_entry(node, struct ceph_subvol_metric_rb_entry=
, node);
> > +
> > +             if (entry->read_ops || entry->write_ops)
> > +                     count++;
> > +     }
> > +     spin_unlock(&tracker->lock);
> > +
> > +     if (!count) {
> > +             seq_puts(s, "(no subvolume metrics collected)\n");
> > +             return;
> > +     }
> > +
>
> Maybe, it make sense to check the count value before trying to allocate m=
emory?
>
> > +     snapshot =3D kcalloc(count, sizeof(*snapshot), GFP_KERNEL);
> > +     if (!snapshot) {
> > +             seq_puts(s, "(unable to allocate memory for snapshot)\n")=
;
> > +             return;
>
> Why do we not return error code, finally?
>
> > +     }
> > +
> > +     spin_lock(&tracker->lock);
> > +     for (node =3D rb_first_cached(&tracker->tree); node; node =3D rb_=
next(node)) {
> > +             struct ceph_subvol_metric_rb_entry *entry =3D
> > +                     rb_entry(node, struct ceph_subvol_metric_rb_entry=
, node);
> > +
> > +             if (!entry->read_ops && !entry->write_ops)
> > +                     continue;
> > +
> > +             if (idx >=3D count)
> > +                     break;
> > +
> > +             snapshot[idx].subvolume_id =3D entry->subvolume_id;
> > +             snapshot[idx].read_ops =3D entry->read_ops;
> > +             snapshot[idx].write_ops =3D entry->write_ops;
> > +             snapshot[idx].read_bytes =3D entry->read_bytes;
> > +             snapshot[idx].write_bytes =3D entry->write_bytes;
> > +             snapshot[idx].read_latency_us =3D entry->read_latency_us;
> > +             snapshot[idx].write_latency_us =3D entry->write_latency_u=
s;
> > +             idx++;
> > +     }
> > +     spin_unlock(&tracker->lock);
> > +
> > +     seq_puts(s, "subvol_id       rd_ops    rd_bytes    rd_avg_lat_us =
 wr_ops    wr_bytes    wr_avg_lat_us\n");
> > +     seq_puts(s, "----------------------------------------------------=
--------------------------------------------\n");
> > +
> > +     for (idx =3D 0; idx < count; idx++) {
> > +             u64 avg_rd_lat =3D div_rem(snapshot[idx].read_latency_us,
> > +                                      snapshot[idx].read_ops);
> > +             u64 avg_wr_lat =3D div_rem(snapshot[idx].write_latency_us=
,
> > +                                      snapshot[idx].write_ops);
> > +
> > +             seq_printf(s, "%-15llu%-10llu%-12llu%-16llu%-10llu%-12llu=
%-16llu\n",
> > +                        snapshot[idx].subvolume_id,
> > +                        snapshot[idx].read_ops,
> > +                        snapshot[idx].read_bytes,
> > +                        avg_rd_lat,
> > +                        snapshot[idx].write_ops,
> > +                        snapshot[idx].write_bytes,
> > +                        avg_wr_lat);
> > +     }
> > +
> > +     kfree(snapshot);
> > +}
> > +
> > +void ceph_subvolume_metrics_record_io(struct ceph_mds_client *mdsc,
> > +                                   struct ceph_inode_info *ci,
> > +                                   bool is_write, size_t bytes,
> > +                                   ktime_t start, ktime_t end)
> > +{
> > +     struct ceph_subvolume_metrics_tracker *tracker;
> > +     u64 subvol_id;
> > +     s64 delta_us;
> > +
> > +     if (!mdsc || !ci || !bytes)
> > +             return;
> > +
> > +     tracker =3D &mdsc->subvol_metrics;
> > +     atomic64_inc(&tracker->record_calls);
> > +
> > +     if (!ceph_subvolume_metrics_enabled(tracker)) {
> > +             atomic64_inc(&tracker->record_disabled);
> > +             return;
> > +     }
> > +
> > +     subvol_id =3D READ_ONCE(ci->i_subvolume_id);
> > +     if (!subvol_id) {
> > +             atomic64_inc(&tracker->record_no_subvol);
> > +             return;
> > +     }
> > +
> > +     delta_us =3D ktime_to_us(ktime_sub(end, start));
> > +     if (delta_us <=3D 0)
> > +             delta_us =3D 1;
> > +
> > +     ceph_subvolume_metrics_record(tracker, subvol_id, is_write,
> > +                                   bytes, (u64)delta_us);
> > +}
> > diff --git a/fs/ceph/subvolume_metrics.h b/fs/ceph/subvolume_metrics.h
> > new file mode 100644
> > index 000000000000..872867c75c41
> > --- /dev/null
> > +++ b/fs/ceph/subvolume_metrics.h
> > @@ -0,0 +1,68 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _FS_CEPH_SUBVOLUME_METRICS_H
> > +#define _FS_CEPH_SUBVOLUME_METRICS_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/rbtree.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/ktime.h>
> > +#include <linux/atomic.h>
> > +
> > +struct seq_file;
> > +struct ceph_mds_client;
> > +struct ceph_inode_info;
> > +
> > +struct ceph_subvol_metric_snapshot {
> > +     u64 subvolume_id;
> > +     u64 read_ops;
> > +     u64 write_ops;
> > +     u64 read_bytes;
> > +     u64 write_bytes;
> > +     u64 read_latency_us;
> > +     u64 write_latency_us;
> > +};
>
> Why do we not provides comments for the fields?
>
> > +
> > +struct ceph_subvolume_metrics_tracker {
> > +     spinlock_t lock;
> > +     struct rb_root_cached tree;
> > +     u32 nr_entries;
> > +     bool enabled;
> > +     atomic64_t snapshot_attempts;
> > +     atomic64_t snapshot_empty;
> > +     atomic64_t snapshot_failures;
> > +     atomic64_t record_calls;
> > +     atomic64_t record_disabled;
> > +     atomic64_t record_no_subvol;
> > +     /* Cumulative counters (survive snapshots) */
> > +     atomic64_t total_read_ops;
> > +     atomic64_t total_read_bytes;
> > +     atomic64_t total_write_ops;
> > +     atomic64_t total_write_bytes;
> > +};
>
> Ditto.
>
> Thanks,
> Slava.
>
> > +
> > +void ceph_subvolume_metrics_init(struct ceph_subvolume_metrics_tracker=
 *tracker);
> > +void ceph_subvolume_metrics_destroy(struct ceph_subvolume_metrics_trac=
ker *tracker);
> > +void ceph_subvolume_metrics_enable(struct ceph_subvolume_metrics_track=
er *tracker,
> > +                                bool enable);
> > +void ceph_subvolume_metrics_record(struct ceph_subvolume_metrics_track=
er *tracker,
> > +                                u64 subvol_id, bool is_write,
> > +                                size_t size, u64 latency_us);
> > +int ceph_subvolume_metrics_snapshot(struct ceph_subvolume_metrics_trac=
ker *tracker,
> > +                                 struct ceph_subvol_metric_snapshot **=
out,
> > +                                 u32 *nr, bool consume);
> > +void ceph_subvolume_metrics_free_snapshot(struct ceph_subvol_metric_sn=
apshot *snapshot);
> > +void ceph_subvolume_metrics_dump(struct ceph_subvolume_metrics_tracker=
 *tracker,
> > +                              struct seq_file *s);
> > +
> > +void ceph_subvolume_metrics_record_io(struct ceph_mds_client *mdsc,
> > +                                   struct ceph_inode_info *ci,
> > +                                   bool is_write, size_t bytes,
> > +                                   ktime_t start, ktime_t end);
> > +
> > +static inline bool ceph_subvolume_metrics_enabled(
> > +             const struct ceph_subvolume_metrics_tracker *tracker)
> > +{
> > +     return READ_ONCE(tracker->enabled);
> > +}
> > +
> > +#endif /* _FS_CEPH_SUBVOLUME_METRICS_H */
> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > index f6bf24b5c683..528452aa8beb 100644
> > --- a/fs/ceph/super.c
> > +++ b/fs/ceph/super.c
> > @@ -21,6 +21,7 @@
> >  #include "mds_client.h"
> >  #include "cache.h"
> >  #include "crypto.h"
> > +#include "subvolume_metrics.h"
> >
> >  #include <linux/ceph/ceph_features.h>
> >  #include <linux/ceph/decode.h>
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index c0372a725960..a03c373efd52 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -167,6 +167,7 @@ struct ceph_fs_client {
> >       struct dentry *debugfs_status;
> >       struct dentry *debugfs_mds_sessions;
> >       struct dentry *debugfs_metrics_dir;
> > +     struct dentry *debugfs_subvolume_metrics;
> >  #endif
> >
> >  #ifdef CONFIG_CEPH_FSCACHE


