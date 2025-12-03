Return-Path: <linux-fsdevel+bounces-70574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0F8CA10CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 19:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB45D33F2050
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 17:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E2316194;
	Wed,  3 Dec 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLKlm+ZZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGCNznX5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD01730FC1C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776921; cv=none; b=iWBE1RgRn304OmjXJeHCzfpi8ICNMi1n1rXdbkiOAfshFfk8sK+I5tqydRRu2NREGqqNRREaZvGwX1zH327DSbdB+CjwQrCH/ec5xjNKaU42WjzECid55if+6rgpQKq9gecpcgH2DedRts6swkbP6P5lTgqoKYllQ6iHGBF/uD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776921; c=relaxed/simple;
	bh=aIBGphgzhXUaZAk2/5WLGnGnPKSfrVonY0aSeETgTH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAjansimfwG54zcgsaJjSA5uZS5MQxkrHWAHE9JryFWwEPuIn3DvLoV+aOaIfQz2bWAQAFk6yJ+DT0oMBFjhptff8NxYe8qwaZ0RhGf4R/cWxmgAtWhjN4MAilw0LWseAq9aOpyJYGi5oYA8FiZPSwclHoDfoTgezShiCTlQTUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLKlm+ZZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGCNznX5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764776918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5NehO+FQRW1r4UMp3vb40IEuBMxJiCnyJz7p6o1+P0=;
	b=RLKlm+ZZf4W4Ye34q29kazw83SI7aME+BbJscJ1MVrjnsSO33xsQi55ujOHhqEQ6JP7l5f
	72oqOvTFiS5MBI7RWsDfIB2e17dIdaO9FxTu7eCj39/uKQTU/wrr46EeGANxzjGvNP/Mfh
	wAsbrYWZnXIUbwk+SdcSU59pxoMbLSg=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-iY28yVPmPrG_-zBKlNwzqQ-1; Wed, 03 Dec 2025 10:48:36 -0500
X-MC-Unique: iY28yVPmPrG_-zBKlNwzqQ-1
X-Mimecast-MFC-AGG-ID: iY28yVPmPrG_-zBKlNwzqQ_1764776916
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9375f8d5f1cso2598369241.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 07:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764776916; x=1765381716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5NehO+FQRW1r4UMp3vb40IEuBMxJiCnyJz7p6o1+P0=;
        b=aGCNznX5pbT7x7xap8ZiCSSlEvdJAHBny8H2IFzuXZKttJVZcpI4bfLOwZTfhR1pMv
         DQVo/mI923qav5UpMsYi+ry2WecWTQO5GBulbRgMT8QNTlf7UPYqjgXnNtb77UeTKH1t
         CMOZCnTHnc0LP8goUVMYpTmJXW7wqGYvyE3bS913rfJvaLX03BMDpRq0bPD7uUye/+Mj
         HyP09svnSogfipkVI9MM1Yjh51yWfakHPS+0EL2dsW8IEXp4/yecN0yOz9u3y+canNTh
         6LypVL5lSNAAD22QbocorqTEZSK3etenS/o9PqBbS7FocpvudjzCwnq4WxbpqlWLo4cF
         q4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764776916; x=1765381716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R5NehO+FQRW1r4UMp3vb40IEuBMxJiCnyJz7p6o1+P0=;
        b=MTT0FDwu964CauX2g4tGksGGgjqBkUZ4usKlvnlzL4x4bMhJq4N6ZDCAcIcvlbe0dJ
         YAe41WjS9yd9aXp56hXIVBdfYZn9gm1crp7Rg1kGOmKYAr4fc66vtG4QE80wxJC2+XyM
         k1bAAJDmwhEMPjbbxKZLjQ5E3iHvWW13zbYqpd4ANhdSKRyMs1kUc+q5UZJHHIfMUObm
         TYdweiYNzc/zkbfGhT5X9zHwyZkZO/M3iNC5nWwRSkFIlTkWkHjliQfPkq+Jw963csSs
         MBQ7HB6vccVqiDE2GIlVpYACEKr/YMjA8O4AmqHFl3FPxTsMjYHVrZfHZQYhOCqtT1F+
         XsmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyS92aLTWMHqXZuP4Ol04XMUUEpodhx/sjwJ4EySpQ8tlg7VqvaMNqKGp+dk31WHlMCHPPe19SOp/LcSSm@vger.kernel.org
X-Gm-Message-State: AOJu0YzQdSINcH6WK+6BoFMg0gcxRtSPAxgNBvb4PNv80F/2X/XRdxKZ
	ryon1EI15ushmHi56Mj4QjPdxpXBfboGTzf62/SedvQXJ8O4Gd68Wfjgc7lMYaYOWOLUE8ZVLxn
	6icRnGRtp/dfWmPktypNzBmPs79tkOUYw/F/4dROzd10NqNFowsyZyBEATMDtHkOp5zMqMGIUQc
	+/yIm5dgrfTPdM1MLgdVO/hulJ6fFQ/Yaw726Jw0VdoA==
X-Gm-Gg: ASbGncvf9RvNBZjeBCUZHGZx39Nf2doA1NhARdRHO3rJNjmlzdaQIT97dtfdpXizTir
	SD3VvOCF3rJS4yv94JRR+eUMe2K4snUBewOXL2mrbsUUlxZ21wDdElQXOexGSJyhOfNPsj9zs7/
	VbSqIi0btoHfu1RWuOYF34w9RKh6gCw7391tCEZrWNItu+QkGRp2a2DR1hIAwroIQUlF0BamDQ4
	t9uQXq4KaoQ
X-Received: by 2002:a05:6102:3753:b0:535:2f14:ea5e with SMTP id ada2fe7eead31-5e48e2824eamr717591137.8.1764776915963;
        Wed, 03 Dec 2025 07:48:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGySNhutiBYFLf2Pw7nlBwRJE7vpGcU6Y6OdS9tLpm8LznqaNDceiaPzsviFUDlKRSGc8dEemxRbv38q0tnOsY=
X-Received: by 2002:a05:6102:3753:b0:535:2f14:ea5e with SMTP id
 ada2fe7eead31-5e48e2824eamr717582137.8.1764776915526; Wed, 03 Dec 2025
 07:48:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202155750.2565696-1-amarkuze@redhat.com> <20251202155750.2565696-3-amarkuze@redhat.com>
 <c41cdb3ac27d04bf79d6b22705ec045c11df4798.camel@ibm.com>
In-Reply-To: <c41cdb3ac27d04bf79d6b22705ec045c11df4798.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 3 Dec 2025 17:48:24 +0200
X-Gm-Features: AWmQ_blGP93nZz6T4edWBT8pQTqh5m397kCIlwTBteRz-BlrmdbDWDo8M68H9sk
Message-ID: <CAO8a2SjFeuLBbYwBE7AUQziVPonquz80u=6DCKAhRrqy_Fi6kQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ceph: parse subvolume_id from InodeStat v9 and
 store in inode
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

SUBVOLUME MEMBERSHIP IS IMMUTABLE. Once an inode is created in a subvolume,
   it stays there forever. The MDS will always send the same subvolume_id f=
or
   the same inode.

   The ceph_inode_set_subvolume() function is called multiple times because=
:
   - fill_inode() is called whenever we get fresh inode info from MDS
   - The MDS sends subvolume_id with every reply containing inode info

   Expected behavior:
   - First call: sets the value (from 0 to actual subvolume_id)
   - Subsequent calls: should see the SAME value (no-op, early return)
   - If we ever get a DIFFERENT non-zero value: that's a BUG

   The current code handles this correctly:
   - We check if old =3D=3D subvolume_id and return early (no-op case)
   - We check if old !=3D CEPH_SUBVOLUME_ID_NONE and WARN_ON_ONCE + return
     (this catches the bug case where subvolume_id would change)

   CEPH_SUBVOLUME_ID_NONE (0) is already defined in super.h and used
   throughout the code. This follows the FUSE client convention where
   0 means "unknown/unset".

On Tue, Dec 2, 2025 at 10:50=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Tue, 2025-12-02 at 15:57 +0000, Alex Markuze wrote:
> > Add support for parsing the subvolume_id field from InodeStat v9 and
> > storing it in the inode for later use by subvolume metrics tracking.
> >
> > The subvolume_id identifies which CephFS subvolume an inode belongs to,
> > enabling per-subvolume I/O metrics collection and reporting.
> >
> > This patch:
> > - Adds subvolume_id field to struct ceph_mds_reply_info_in
> > - Adds i_subvolume_id field to struct ceph_inode_info
> > - Parses subvolume_id from v9 InodeStat in parse_reply_info_in()
> > - Adds ceph_inode_set_subvolume() helper to propagate the ID to inodes
> > - Initializes i_subvolume_id in inode allocation and clears on destroy
> >
> > Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> > ---
> >  fs/ceph/inode.c      | 23 +++++++++++++++++++++++
> >  fs/ceph/mds_client.c |  7 +++++++
> >  fs/ceph/mds_client.h |  1 +
> >  fs/ceph/super.h      |  2 ++
> >  4 files changed, 33 insertions(+)
> >
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index a6e260d9e420..835049004047 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -638,6 +638,7 @@ struct inode *ceph_alloc_inode(struct super_block *=
sb)
> >
> >       ci->i_max_bytes =3D 0;
> >       ci->i_max_files =3D 0;
> > +     ci->i_subvolume_id =3D 0;
> >
> >       memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
> >       memset(&ci->i_cached_layout, 0, sizeof(ci->i_cached_layout));
> > @@ -742,6 +743,8 @@ void ceph_evict_inode(struct inode *inode)
> >
> >       percpu_counter_dec(&mdsc->metric.total_inodes);
> >
> > +     ci->i_subvolume_id =3D 0;
> > +
> >       netfs_wait_for_outstanding_io(inode);
> >       truncate_inode_pages_final(&inode->i_data);
> >       if (inode->i_state & I_PINNING_NETFS_WB)
> > @@ -873,6 +876,22 @@ int ceph_fill_file_size(struct inode *inode, int i=
ssued,
> >       return queue_trunc;
> >  }
> >
> > +/*
> > + * Set the subvolume ID for an inode. Following the FUSE client conven=
tion,
> > + * 0 means unknown/unset (MDS only sends non-zero IDs for subvolume in=
odes).
> > + */
> > +void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id)
> > +{
> > +     struct ceph_inode_info *ci;
> > +
> > +     if (!inode || !subvolume_id)
> > +             return;
> > +
> > +     ci =3D ceph_inode(inode);
> > +     if (READ_ONCE(ci->i_subvolume_id) !=3D subvolume_id)
> > +             WRITE_ONCE(ci->i_subvolume_id, subvolume_id);
> > +}
> > +
> >  void ceph_fill_file_time(struct inode *inode, int issued,
> >                        u64 time_warp_seq, struct timespec64 *ctime,
> >                        struct timespec64 *mtime, struct timespec64 *ati=
me)
> > @@ -1087,6 +1106,7 @@ int ceph_fill_inode(struct inode *inode, struct p=
age *locked_page,
> >       new_issued =3D ~issued & info_caps;
> >
> >       __ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
> > +     ceph_inode_set_subvolume(inode, iinfo->subvolume_id);
>
> I still don't quite follow. Is it normal or not to reset the subvolume_id=
? If we
> already had the subvolume_id, then how valid is reset operation? Could we=
 have
> bugs here?
>
> >
> >  #ifdef CONFIG_FS_ENCRYPTION
> >       if (iinfo->fscrypt_auth_len &&
> > @@ -1594,6 +1614,8 @@ int ceph_fill_trace(struct super_block *sb, struc=
t ceph_mds_request *req)
> >                       goto done;
> >               }
> >               if (parent_dir) {
> > +                     ceph_inode_set_subvolume(parent_dir,
> > +                                              rinfo->diri.subvolume_id=
);
> >                       err =3D ceph_fill_inode(parent_dir, NULL, &rinfo-=
>diri,
> >                                             rinfo->dirfrag, session, -1=
,
> >                                             &req->r_caps_reservation);
> > @@ -1682,6 +1704,7 @@ int ceph_fill_trace(struct super_block *sb, struc=
t ceph_mds_request *req)
> >               BUG_ON(!req->r_target_inode);
> >
> >               in =3D req->r_target_inode;
> > +             ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id)=
;
> >               err =3D ceph_fill_inode(in, req->r_locked_page, &rinfo->t=
argeti,
> >                               NULL, session,
> >                               (!test_bit(CEPH_MDS_R_ABORTED, &req->r_re=
q_flags) &&
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index d7d8178e1f9a..099b8f22683b 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -105,6 +105,8 @@ static int parse_reply_info_in(void **p, void *end,
> >       int err =3D 0;
> >       u8 struct_v =3D 0;
> >
> > +     info->subvolume_id =3D 0;
> > +
> >       if (features =3D=3D (u64)-1) {
> >               u32 struct_len;
> >               u8 struct_compat;
> > @@ -251,6 +253,10 @@ static int parse_reply_info_in(void **p, void *end=
,
> >                       ceph_decode_skip_n(p, end, v8_struct_len, bad);
> >               }
> >
> > +             /* struct_v 9 added subvolume_id */
> > +             if (struct_v >=3D 9)
> > +                     ceph_decode_64_safe(p, end, info->subvolume_id, b=
ad);
> > +
> >               *p =3D end;
> >       } else {
> >               /* legacy (unversioned) struct */
> > @@ -3970,6 +3976,7 @@ static void handle_reply(struct ceph_mds_session =
*session, struct ceph_msg *msg)
> >                       goto out_err;
> >               }
> >               req->r_target_inode =3D in;
> > +             ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id)=
;
> >       }
> >
> >       mutex_lock(&session->s_mutex);
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index 0428a5eaf28c..bd3690baa65c 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -118,6 +118,7 @@ struct ceph_mds_reply_info_in {
> >       u32 fscrypt_file_len;
> >       u64 rsnaps;
> >       u64 change_attr;
> > +     u64 subvolume_id;
> >  };
> >
> >  struct ceph_mds_reply_dir_entry {
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index a1f781c46b41..c0372a725960 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -385,6 +385,7 @@ struct ceph_inode_info {
> >
> >       /* quotas */
> >       u64 i_max_bytes, i_max_files;
> > +     u64 i_subvolume_id;     /* 0 =3D unknown/unset, matches FUSE clie=
nt */
>
> I still believe that it makes sense to introduce the named constant with =
the
> goal not to make confused by zero value and not to guess if it is correct=
 value
> or not.
>
> Thanks,
> Slava.
>
> >
> >       s32 i_dir_pin;
> >
> > @@ -1057,6 +1058,7 @@ extern struct inode *ceph_get_inode(struct super_=
block *sb,
> >  extern struct inode *ceph_get_snapdir(struct inode *parent);
> >  extern int ceph_fill_file_size(struct inode *inode, int issued,
> >                              u32 truncate_seq, u64 truncate_size, u64 s=
ize);
> > +extern void ceph_inode_set_subvolume(struct inode *inode, u64 subvolum=
e_id);
> >  extern void ceph_fill_file_time(struct inode *inode, int issued,
> >                               u64 time_warp_seq, struct timespec64 *cti=
me,
> >                               struct timespec64 *mtime,


