Return-Path: <linux-fsdevel+bounces-55667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDC2B0D970
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38EEAA3044
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76D42E9EAA;
	Tue, 22 Jul 2025 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGG+/9Bh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6E2E92B1
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186795; cv=none; b=ERun/E96OTSDvkdaK1cc7j1qlamNmb10Z92fd51rCFw9nZIEb6aHTiD1x26124m6Clc5nTwRQTP2fRBrIFktXP78FRz+FeLeOkXfTpvjLSdzjNE4CW2cC2GG0eQ5Sxe/LQrP0IOHBsOpTVV/9PshuB+5s2D1fAN+3CpR8RbZpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186795; c=relaxed/simple;
	bh=zfLyhbChwVVeeY5lYB9E4Ys7lJFoRjDHbCfIOZnAWOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDdtFlwZ5sCQWWLReVaNAh5TypKUuN8PzRWarcqjiautbmjysgWitSWc+RQBnEFk8p50J4KWhUvMn2mueA5+jSlR3QXuswGRkHAqTcxL9o1O98HKeLQ7lfCPN6dgQicRMsqmGxU6moC+QzInHiEHnOvJHM1+8qp5GGqMWe9W1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGG+/9Bh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753186791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ChV8arQrMQSJi89/NCGPfMeYqktq5h11pl5AQ2NWhNw=;
	b=LGG+/9BhVNbVhCHSNsCprrt0N+cKKmqs6yazAJQt81sXIauqF4K9Z5FNpw2MkQlBkACjb1
	r68JyDGstvnidtxQBiklLurVi324TOXaShBDXJFqSSlmBRjGAd9nHMjWZKMg8avzPWTspd
	bLtT+Zg6zr02V88qoNzJT2SUPnEZx8o=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-C8zvcWCbMPOK7GBzOgbGOA-1; Tue, 22 Jul 2025 08:19:50 -0400
X-MC-Unique: C8zvcWCbMPOK7GBzOgbGOA-1
X-Mimecast-MFC-AGG-ID: C8zvcWCbMPOK7GBzOgbGOA_1753186790
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4ef3f3e12f0so315348137.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 05:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753186789; x=1753791589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChV8arQrMQSJi89/NCGPfMeYqktq5h11pl5AQ2NWhNw=;
        b=evgPoIae6IL41Rk0Ktonk0QAo5sX6ikhfflZvhSyWrohWpfF5DqQl63u12xPyeapf8
         drbQIZdgemaQeiVrNH6X0kKwQ24+aZTg9kWC5+tnhZfgdOWlzotMMpKnrhPgWa9hjp7+
         JPzy7oLLohSFWZJ5dhjYcxcMzxwVGlWRA3R9GH7GFsm9l4kPrHvQ/C+R/bF7i1uvIJzz
         Wk2ctwc+W9sozWPmMczVbOI+AATGdhNWUerSUNjHU3i6oLLSGENq+bMVs1z5JfYOSUsI
         CQTjTcdQBJZHr47lYcFGWPI0CcJ+gL6/faRhOsvAAX68ofSm881K2l7Nq6TW6dkIekah
         wxLg==
X-Forwarded-Encrypted: i=1; AJvYcCXA8pnfLjudAOlZVnK2upoXXpEF9MonheYjaRK8h9ofge46E2sJl7uEvoPGrdbt/IjfKZOf6ttXwwLhe3Gf@vger.kernel.org
X-Gm-Message-State: AOJu0YynU+wShcE3hI0osxOKSPxrDaA2m89Rno5rgVPcS3jaKGdKyYC3
	2DwhikwhfdTtam4y7LDSALHdsiWuKBAT1AP8fw1ykb3SsCUXHjubbMmWdqINDMvrSj6WZr6H/Ph
	1IK/xlRjpFZ1KGRY77E+Rg1uxFD8wznviFoX4Q/HP+Wb3HlEc/+8dajHKlPzAMdwYog/jU/7OM5
	Nv8++1Y5r+PV71LAnPde0semFBkalV6oKp9PLY3j8n9w==
X-Gm-Gg: ASbGncvigftyotSJ9GDghVBZunCqE4Nx+jk9qpN/xVedXyicGp9JFul37CMab5cO2pM
	7d/A0MZj52MEqU0PLJGzGdius2Ip3zWrPS9b8tHNbQDmY88oU8GAm4XMiqePaSfq9b1QF+ZjLcF
	umu3PIM6tHwcHn7tGJjPEY
X-Received: by 2002:a05:6102:508e:b0:4e5:980a:d164 with SMTP id ada2fe7eead31-4f997d25158mr11871054137.0.1753186789562;
        Tue, 22 Jul 2025 05:19:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVWd7OdP74xeiYuFXtx1VFeGyOgV3ps2F4IzvY0B2mSzAXwy8C/Ctjn/V1TY8U0DqSfNcyheEsg4MoSQETA4A=
X-Received: by 2002:a05:6102:508e:b0:4e5:980a:d164 with SMTP id
 ada2fe7eead31-4f997d25158mr11871038137.0.1753186789151; Tue, 22 Jul 2025
 05:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721221606.1011604-1-slava@dubeyko.com>
In-Reply-To: <20250721221606.1011604-1-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Tue, 22 Jul 2025 16:19:38 +0400
X-Gm-Features: Ac12FXy7iodGS58yhxJqNKGQqA0mSGjYwB7zM_87afP6u_vMVYbJhtYIGjM9G-0
Message-ID: <CAO8a2ShpORYPW6XewdgaBCvc8qW=FJ_AwJj--foGJcx2UG9LtA@mail.gmail.com>
Subject: Re: [PATCH] ceph: cleanup of processing ci->i_ceph_flags bits in caps.c
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Slava,

Thanks for the patch.

The fix for the race condition in ceph_check_delayed_caps() is correct
and necessary. The systematic change to use atomic bit operations like
set_bit() and clear_bit() with the proper memory barriers is a
significant improvement for safety and readability.

One minor critique for a follow-up patch:

The refactoring in fs/ceph/super.h to use named _BIT definitions is a
great idea, but the cleanup is incomplete. Several definitions were
not converted and still use hardcoded bit-shift numbers . For example,

CEPH_I_POOL_RD, CEPH_I_POOL_WR, and CEPH_I_ODIRECT still use (1 << 4),
(1 << 5), and (1 << 11) respectively. It would be good to finish this
refactoring for consistency.


On Tue, Jul 22, 2025 at 2:16=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The Coverity Scan service has detected potential
> race condition in ceph_check_delayed_caps() [1].
>
> The CID 1590633 contains explanation: "Accessing
> ci->i_ceph_flags without holding lock
> ceph_inode_info.i_ceph_lock. The value of the shared data
> will be determined by the interleaving of thread execution.
> Thread shared data is accessed without holding an appropriate
> lock, possibly causing a race condition (CWE-366)".
>
> The patch reworks the logic of accessing ci->i_ceph_flags.
> At first, it removes ci item from a mdsc->cap_delay_list.
> Then it unlocks mdsc->cap_delay_lock and it locks
> ci->i_ceph_lock. Then, it calls smp_mb__before_atomic()
> to be sure that ci->i_ceph_flags has consistent state of
> the bits. The is_metadata_under_flush variable stores
> the state of CEPH_I_FLUSH_BIT. Finally, it unlocks
> the ci->i_ceph_lock and it locks the mdsc->cap_delay_lock.
> The is_metadata_under_flush is used to check the condition
> that ci needs to be removed from mdsc->cap_delay_list.
> If it is not the case, then ci will be added into the head of
> mdsc->cap_delay_list.
>
> This patch reworks the logic of checking the CEPH_I_FLUSH_BIT,
> CEPH_I_FLUSH_SNAPS_BIT, CEPH_I_KICK_FLUSH_BIT,
> CEPH_ASYNC_CREATE_BIT, CEPH_I_ERROR_FILELOCK_BIT by test_bit()
> method and calling smp_mb__before_atomic() to ensure that
> bit state is consistent. It switches on calling the set_bit(),
> clear_bit() for these bits, and calling smp_mb__after_atomic()
> after these methods to ensure that modified bit is visible.
>
> Additionally, __must_hold() has been added for
> __cap_delay_requeue(), __cap_delay_requeue_front(), and
> __prep_cap() to help the sparse with lock checking and
> it was commented that caller of __cap_delay_requeue_front()
> and __prep_cap() must lock the ci->i_ceph_lock.
>
> [1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIs=
sue=3D1590633
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/caps.c  | 132 +++++++++++++++++++++++++++++++++++++-----------
>  fs/ceph/super.h |  38 ++++++++------
>  2 files changed, 125 insertions(+), 45 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index a8d8b56cf9d2..9c82cda33ee5 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -516,6 +516,7 @@ static void __cap_set_timeouts(struct ceph_mds_client=
 *mdsc,
>   */
>  static void __cap_delay_requeue(struct ceph_mds_client *mdsc,
>                                 struct ceph_inode_info *ci)
> +               __must_hold(ci->i_ceph_lock)
>  {
>         struct inode *inode =3D &ci->netfs.inode;
>
> @@ -525,7 +526,9 @@ static void __cap_delay_requeue(struct ceph_mds_clien=
t *mdsc,
>         if (!mdsc->stopping) {
>                 spin_lock(&mdsc->cap_delay_lock);
>                 if (!list_empty(&ci->i_cap_delay_list)) {
> -                       if (ci->i_ceph_flags & CEPH_I_FLUSH)
> +                       /* ensure that bit state is consistent */
> +                       smp_mb__before_atomic();
> +                       if (test_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags)=
)
>                                 goto no_change;
>                         list_del_init(&ci->i_cap_delay_list);
>                 }
> @@ -540,15 +543,20 @@ static void __cap_delay_requeue(struct ceph_mds_cli=
ent *mdsc,
>   * Queue an inode for immediate writeback.  Mark inode with I_FLUSH,
>   * indicating we should send a cap message to flush dirty metadata
>   * asap, and move to the front of the delayed cap list.
> + *
> + * Caller must hold i_ceph_lock.
>   */
>  static void __cap_delay_requeue_front(struct ceph_mds_client *mdsc,
>                                       struct ceph_inode_info *ci)
> +               __must_hold(ci->i_ceph_lock)
>  {
>         struct inode *inode =3D &ci->netfs.inode;
>
>         doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode, ceph_vinop(inod=
e));
>         spin_lock(&mdsc->cap_delay_lock);
> -       ci->i_ceph_flags |=3D CEPH_I_FLUSH;
> +       set_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
> +       /* ensure modified bit is visible */
> +       smp_mb__after_atomic();
>         if (!list_empty(&ci->i_cap_delay_list))
>                 list_del_init(&ci->i_cap_delay_list);
>         list_add(&ci->i_cap_delay_list, &mdsc->cap_delay_list);
> @@ -1386,10 +1394,13 @@ void __ceph_remove_caps(struct ceph_inode_info *c=
i)
>   *
>   * Make note of max_size reported/requested from mds, revoked caps
>   * that have now been implemented.
> + *
> + * Caller must hold i_ceph_lock.
>   */
>  static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
>                        int op, int flags, int used, int want, int retain,
>                        int flushing, u64 flush_tid, u64 oldest_flush_tid)
> +               __must_hold(ci->i_ceph_lock)
>  {
>         struct ceph_inode_info *ci =3D cap->ci;
>         struct inode *inode =3D &ci->netfs.inode;
> @@ -1408,7 +1419,9 @@ static void __prep_cap(struct cap_msg_args *arg, st=
ruct ceph_cap *cap,
>               ceph_cap_string(revoking));
>         BUG_ON((retain & CEPH_CAP_PIN) =3D=3D 0);
>
> -       ci->i_ceph_flags &=3D ~CEPH_I_FLUSH;
> +       clear_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
> +       /* ensure modified bit is visible */
> +       smp_mb__after_atomic();
>
>         cap->issued &=3D retain;  /* drop bits we don't want */
>         /*
> @@ -1665,7 +1678,9 @@ static void __ceph_flush_snaps(struct ceph_inode_in=
fo *ci,
>                 last_tid =3D capsnap->cap_flush.tid;
>         }
>
> -       ci->i_ceph_flags &=3D ~CEPH_I_FLUSH_SNAPS;
> +       clear_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
> +       /* ensure modified bit is visible */
> +       smp_mb__after_atomic();
>
>         while (first_tid <=3D last_tid) {
>                 struct ceph_cap *cap =3D ci->i_auth_cap;
> @@ -1728,7 +1743,9 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
>                 session =3D *psession;
>  retry:
>         spin_lock(&ci->i_ceph_lock);
> -       if (!(ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS)) {
> +       /* ensure that bit state is consistent */
> +       smp_mb__before_atomic();
> +       if (!test_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags)) {
>                 doutc(cl, " no capsnap needs flush, doing nothing\n");
>                 goto out;
>         }
> @@ -1752,7 +1769,9 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
>         }
>
>         // make sure flushsnap messages are sent in proper order.
> -       if (ci->i_ceph_flags & CEPH_I_KICK_FLUSH)
> +       /* ensure that bit state is consistent */
> +       smp_mb__before_atomic();
> +       if (test_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags))
>                 __kick_flushing_caps(mdsc, session, ci, 0);
>
>         __ceph_flush_snaps(ci, session);
> @@ -2024,15 +2043,21 @@ void ceph_check_caps(struct ceph_inode_info *ci, =
int flags)
>         struct ceph_mds_session *session =3D NULL;
>
>         spin_lock(&ci->i_ceph_lock);
> -       if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
> -               ci->i_ceph_flags |=3D CEPH_I_ASYNC_CHECK_CAPS;
> +       /* ensure that bit state is consistent */
> +       smp_mb__before_atomic();
> +       if (test_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags)) {
> +               set_bit(CEPH_I_ASYNC_CHECK_CAPS_BIT, &ci->i_ceph_flags);
> +               /* ensure modified bit is visible */
> +               smp_mb__after_atomic();
>
>                 /* Don't send messages until we get async create reply */
>                 spin_unlock(&ci->i_ceph_lock);
>                 return;
>         }
>
> -       if (ci->i_ceph_flags & CEPH_I_FLUSH)
> +       /* ensure that bit state is consistent */
> +       smp_mb__before_atomic();
> +       if (test_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags))
>                 flags |=3D CHECK_CAPS_FLUSH;
>  retry:
>         /* Caps wanted by virtue of active open files. */
> @@ -2196,7 +2221,10 @@ void ceph_check_caps(struct ceph_inode_info *ci, i=
nt flags)
>                                 doutc(cl, "flushing dirty caps\n");
>                                 goto ack;
>                         }
> -                       if (ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS) {
> +
> +                       /* ensure that bit state is consistent */
> +                       smp_mb__before_atomic();
> +                       if (test_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_=
flags)) {
>                                 doutc(cl, "flushing snap caps\n");
>                                 goto ack;
>                         }
> @@ -2220,12 +2248,14 @@ void ceph_check_caps(struct ceph_inode_info *ci, =
int flags)
>
>                 /* kick flushing and flush snaps before sending normal
>                  * cap message */
> +               /* ensure that bit state is consistent */
> +               smp_mb__before_atomic();
>                 if (cap =3D=3D ci->i_auth_cap &&
>                     (ci->i_ceph_flags &
>                      (CEPH_I_KICK_FLUSH | CEPH_I_FLUSH_SNAPS))) {
> -                       if (ci->i_ceph_flags & CEPH_I_KICK_FLUSH)
> +                       if (test_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_f=
lags))
>                                 __kick_flushing_caps(mdsc, session, ci, 0=
);
> -                       if (ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS)
> +                       if (test_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_=
flags))
>                                 __ceph_flush_snaps(ci, session);
>
>                         goto retry;
> @@ -2297,11 +2327,17 @@ static int try_flush_caps(struct inode *inode, u6=
4 *ptid)
>                         goto out;
>                 }
>
> +               /* ensure that bit state is consistent */
> +               smp_mb__before_atomic();
>                 if (ci->i_ceph_flags &
>                     (CEPH_I_KICK_FLUSH | CEPH_I_FLUSH_SNAPS)) {
> -                       if (ci->i_ceph_flags & CEPH_I_KICK_FLUSH)
> +                       /* ensure that bit state is consistent */
> +                       smp_mb__before_atomic();
> +                       if (test_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_f=
lags))
>                                 __kick_flushing_caps(mdsc, session, ci, 0=
);
> -                       if (ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS)
> +                       /* ensure that bit state is consistent */
> +                       smp_mb__before_atomic();
> +                       if (test_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_=
flags))
>                                 __ceph_flush_snaps(ci, session);
>                         goto retry_locked;
>                 }
> @@ -2573,10 +2609,14 @@ static void __kick_flushing_caps(struct ceph_mds_=
client *mdsc,
>         u64 last_snap_flush =3D 0;
>
>         /* Don't do anything until create reply comes in */
> -       if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE)
> +       /* ensure that bit state is consistent */
> +       smp_mb__before_atomic();
> +       if (test_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags))
>                 return;
>
> -       ci->i_ceph_flags &=3D ~CEPH_I_KICK_FLUSH;
> +       clear_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags);
> +       /* ensure modified bit is visible */
> +       smp_mb__after_atomic();
>
>         list_for_each_entry_reverse(cf, &ci->i_cap_flush_list, i_list) {
>                 if (cf->is_capsnap) {
> @@ -2685,7 +2725,9 @@ void ceph_early_kick_flushing_caps(struct ceph_mds_=
client *mdsc,
>                         __kick_flushing_caps(mdsc, session, ci,
>                                              oldest_flush_tid);
>                 } else {
> -                       ci->i_ceph_flags |=3D CEPH_I_KICK_FLUSH;
> +                       set_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags)=
;
> +                       /* ensure modified bit is visible */
> +                       smp_mb__after_atomic();
>                 }
>
>                 spin_unlock(&ci->i_ceph_lock);
> @@ -2720,7 +2762,10 @@ void ceph_kick_flushing_caps(struct ceph_mds_clien=
t *mdsc,
>                         spin_unlock(&ci->i_ceph_lock);
>                         continue;
>                 }
> -               if (ci->i_ceph_flags & CEPH_I_KICK_FLUSH) {
> +
> +               /* ensure that bit state is consistent */
> +               smp_mb__before_atomic();
> +               if (test_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags)) {
>                         __kick_flushing_caps(mdsc, session, ci,
>                                              oldest_flush_tid);
>                 }
> @@ -2827,8 +2872,10 @@ static int try_get_cap_refs(struct inode *inode, i=
nt need, int want,
>  again:
>         spin_lock(&ci->i_ceph_lock);
>
> +       /* ensure that bit state is consistent */
> +       smp_mb__before_atomic();
>         if ((flags & CHECK_FILELOCK) &&
> -           (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK)) {
> +           test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
>                 doutc(cl, "%p %llx.%llx error filelock\n", inode,
>                       ceph_vinop(inode));
>                 ret =3D -EIO;
> @@ -3205,8 +3252,11 @@ static int ceph_try_drop_cap_snap(struct ceph_inod=
e_info *ci,
>                 doutc(cl, "%p follows %llu\n", capsnap, capsnap->follows)=
;
>                 BUG_ON(capsnap->cap_flush.tid > 0);
>                 ceph_put_snap_context(capsnap->context);
> -               if (!list_is_last(&capsnap->ci_item, &ci->i_cap_snaps))
> -                       ci->i_ceph_flags |=3D CEPH_I_FLUSH_SNAPS;
> +               if (!list_is_last(&capsnap->ci_item, &ci->i_cap_snaps)) {
> +                       set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags=
);
> +                       /* ensure modified bit is visible */
> +                       smp_mb__after_atomic();
> +               }
>
>                 list_del(&capsnap->ci_item);
>                 ceph_put_cap_snap(capsnap);
> @@ -3395,7 +3445,10 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_=
info *ci, int nr,
>                                 if (ceph_try_drop_cap_snap(ci, capsnap)) =
{
>                                         put++;
>                                 } else {
> -                                       ci->i_ceph_flags |=3D CEPH_I_FLUS=
H_SNAPS;
> +                                       set_bit(CEPH_I_FLUSH_SNAPS_BIT,
> +                                               &ci->i_ceph_flags);
> +                                       /* ensure modified bit is visible=
 */
> +                                       smp_mb__after_atomic();
>                                         flush_snaps =3D true;
>                                 }
>                         }
> @@ -3646,8 +3699,11 @@ static void handle_cap_grant(struct inode *inode,
>                 rcu_assign_pointer(ci->i_layout.pool_ns, extra_info->pool=
_ns);
>
>                 if (ci->i_layout.pool_id !=3D old_pool ||
> -                   extra_info->pool_ns !=3D old_ns)
> -                       ci->i_ceph_flags &=3D ~CEPH_I_POOL_PERM;
> +                   extra_info->pool_ns !=3D old_ns) {
> +                       clear_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags=
);
> +                       /* ensure modified bit is visible */
> +                       smp_mb__after_atomic();
> +               }
>
>                 extra_info->pool_ns =3D old_ns;
>
> @@ -4613,6 +4669,7 @@ unsigned long ceph_check_delayed_caps(struct ceph_m=
ds_client *mdsc)
>         unsigned long delay_max =3D opt->caps_wanted_delay_max * HZ;
>         unsigned long loop_start =3D jiffies;
>         unsigned long delay =3D 0;
> +       bool is_metadata_under_flush;
>
>         doutc(cl, "begin\n");
>         spin_lock(&mdsc->cap_delay_lock);
> @@ -4625,11 +4682,24 @@ unsigned long ceph_check_delayed_caps(struct ceph=
_mds_client *mdsc)
>                         delay =3D ci->i_hold_caps_max;
>                         break;
>                 }
> -               if ((ci->i_ceph_flags & CEPH_I_FLUSH) =3D=3D 0 &&
> -                   time_before(jiffies, ci->i_hold_caps_max))
> -                       break;
> +
>                 list_del_init(&ci->i_cap_delay_list);
>
> +               spin_unlock(&mdsc->cap_delay_lock);
> +               spin_lock(&ci->i_ceph_lock);
> +               /* ensure that bit state is consistent */
> +               smp_mb__before_atomic();
> +               is_metadata_under_flush =3D
> +                       test_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
> +               spin_unlock(&ci->i_ceph_lock);
> +               spin_lock(&mdsc->cap_delay_lock);
> +
> +               if (!is_metadata_under_flush &&
> +                   time_before(jiffies, ci->i_hold_caps_max)) {
> +                       list_add(&ci->i_cap_delay_list, &mdsc->cap_delay_=
list);
> +                       break;
> +               }
> +
>                 inode =3D igrab(&ci->netfs.inode);
>                 if (inode) {
>                         spin_unlock(&mdsc->cap_delay_lock);
> @@ -4811,7 +4881,9 @@ int ceph_drop_caps_for_unlink(struct inode *inode)
>                         doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode,
>                               ceph_vinop(inode));
>                         spin_lock(&mdsc->cap_delay_lock);
> -                       ci->i_ceph_flags |=3D CEPH_I_FLUSH;
> +                       set_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
> +                       /* ensure modified bit is visible */
> +                       smp_mb__after_atomic();
>                         if (!list_empty(&ci->i_cap_delay_list))
>                                 list_del_init(&ci->i_cap_delay_list);
>                         list_add_tail(&ci->i_cap_delay_list,
> @@ -5080,7 +5152,9 @@ int ceph_purge_inode_cap(struct inode *inode, struc=
t ceph_cap *cap, bool *invali
>
>                 if (atomic_read(&ci->i_filelock_ref) > 0) {
>                         /* make further file lock syscall return -EIO */
> -                       ci->i_ceph_flags |=3D CEPH_I_ERROR_FILELOCK;
> +                       set_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_fl=
ags);
> +                       /* ensure modified bit is visible */
> +                       smp_mb__after_atomic();
>                         pr_warn_ratelimited_client(cl,
>                                 " dropping file locks for %p %llx.%llx\n"=
,
>                                 inode, ceph_vinop(inode));
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index bb0db0cc8003..3921fefe4481 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -628,22 +628,28 @@ static inline struct inode *ceph_find_inode(struct =
super_block *sb,
>  /*
>   * Ceph inode.
>   */
> -#define CEPH_I_DIR_ORDERED     (1 << 0)  /* dentries in dir are ordered =
*/
> -#define CEPH_I_FLUSH           (1 << 2)  /* do not delay flush of dirty =
metadata */
> -#define CEPH_I_POOL_PERM       (1 << 3)  /* pool rd/wr bits are valid */
> -#define CEPH_I_POOL_RD         (1 << 4)  /* can read from pool */
> -#define CEPH_I_POOL_WR         (1 << 5)  /* can write to pool */
> -#define CEPH_I_SEC_INITED      (1 << 6)  /* security initialized */
> -#define CEPH_I_KICK_FLUSH      (1 << 7)  /* kick flushing caps */
> -#define CEPH_I_FLUSH_SNAPS     (1 << 8)  /* need flush snapss */
> -#define CEPH_I_ERROR_WRITE     (1 << 9) /* have seen write errors */
> -#define CEPH_I_ERROR_FILELOCK  (1 << 10) /* have seen file lock errors *=
/
> -#define CEPH_I_ODIRECT         (1 << 11) /* inode in direct I/O mode */
> -#define CEPH_ASYNC_CREATE_BIT  (12)      /* async create in flight for t=
his */
> -#define CEPH_I_ASYNC_CREATE    (1 << CEPH_ASYNC_CREATE_BIT)
> -#define CEPH_I_SHUTDOWN                (1 << 13) /* inode is no longer u=
sable */
> -#define CEPH_I_ASYNC_CHECK_CAPS        (1 << 14) /* check caps immediate=
ly after async
> -                                            creating finishes */
> +#define CEPH_I_DIR_ORDERED             (1 << 0)  /* dentries in dir are =
ordered */
> +#define CEPH_I_FLUSH_BIT               (2)       /* do not delay flush o=
f dirty metadata */
> +#define CEPH_I_FLUSH                   (1 << CEPH_I_FLUSH_BIT)
> +#define CEPH_I_POOL_PERM_BIT           (3)  /* pool rd/wr bits are valid=
 */
> +#define CEPH_I_POOL_PERM               (1 << CEPH_I_POOL_PERM_BIT)
> +#define CEPH_I_POOL_RD                 (1 << 4)  /* can read from pool *=
/
> +#define CEPH_I_POOL_WR                 (1 << 5)  /* can write to pool */
> +#define CEPH_I_SEC_INITED              (1 << 6)  /* security initialized=
 */
> +#define CEPH_I_KICK_FLUSH_BIT          (7)  /* kick flushing caps */
> +#define CEPH_I_KICK_FLUSH              (1 << CEPH_I_KICK_FLUSH_BIT)
> +#define CEPH_I_FLUSH_SNAPS_BIT         (8)  /* need flush snapss */
> +#define CEPH_I_FLUSH_SNAPS             (1 << CEPH_I_FLUSH_SNAPS_BIT)
> +#define CEPH_I_ERROR_WRITE             (1 << 9) /* have seen write error=
s */
> +#define CEPH_I_ERROR_FILELOCK_BIT      (10) /* have seen file lock error=
s */
> +#define CEPH_I_ERROR_FILELOCK          (1 << CEPH_I_ERROR_FILELOCK_BIT)
> +#define CEPH_I_ODIRECT                 (1 << 11) /* inode in direct I/O =
mode */
> +#define CEPH_ASYNC_CREATE_BIT          (12)      /* async create in flig=
ht for this */
> +#define CEPH_I_ASYNC_CREATE            (1 << CEPH_ASYNC_CREATE_BIT)
> +#define CEPH_I_SHUTDOWN                        (1 << 13) /* inode is no =
longer usable */
> +#define CEPH_I_ASYNC_CHECK_CAPS_BIT    (14) /* check caps immediately af=
ter async
> +                                               creating finishes */
> +#define CEPH_I_ASYNC_CHECK_CAPS                (1 << CEPH_I_ASYNC_CHECK_=
CAPS_BIT)
>
>  /*
>   * Masks of ceph inode work.
> --
> 2.50.1
>


