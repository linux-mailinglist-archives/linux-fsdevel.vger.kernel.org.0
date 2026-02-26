Return-Path: <linux-fsdevel+bounces-78498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G10H4tWoGlLiQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:19:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AE61A763D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29AC13185225
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5261DE2D3;
	Thu, 26 Feb 2026 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiToQ7vX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6AMp2V5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911F3B8BAC
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114197; cv=pass; b=RWwLXmYgUgChkv9kt1pV+fJz2Vru/3zPDPbssiQjxNxPTaySYSCLYU5uATxWp6RT38r9IoRt5LxQDsI4NWbx+iAAw+6rLfx7WWYVYYKGsBlHMYQr+YQxeNqG6+XQoBFOGxpAJrIwGRj61qaykwfqHPGPzuDwoWT+2/+3C5E24cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114197; c=relaxed/simple;
	bh=1y9G44eykZXCRMbqWo4Gbo0Fu3X9DE/FOzp00Uhpy6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCME07qAfcEMe3SDimC8N2ODo2D7TzCEzZzBiahsg+XHQ4+st2g3vOg3g8Xn0H/FapMI0OsaJBseEQ92/Bw3gzFQLVTGF/dtdA4FnM8l7tbBeEoEAZivvXQZa9QwmyUvgdJpHpgXK+mp/ncwm4nnnmmt/mERGflf/GbB8DOez1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiToQ7vX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6AMp2V5; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772114193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pa40UGOtLEf+lUXJi+W2eAsZrpePRgbKwxqj2/6a6JM=;
	b=SiToQ7vXGoBXC77t76Rjevwkqo6gKLxzJ3y2eS1Ji2V+qfvg4z4eiL3lnyDpRQtTTduWWM
	xq7SGxPkK6f6w2Yx4E1s+Q+5hd6NKBdw+fNTRmsbivAETW5cK86tvoUhSjEkIr4gfga36T
	C4uKaJlVArDObLcLXffWhy5bL6vAbv0=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-8js_uHRHOZm2JaQ1HpmQAg-1; Thu, 26 Feb 2026 08:56:31 -0500
X-MC-Unique: 8js_uHRHOZm2JaQ1HpmQAg-1
X-Mimecast-MFC-AGG-ID: 8js_uHRHOZm2JaQ1HpmQAg_1772114191
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-94dde7a60edso847358241.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 05:56:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772114191; cv=none;
        d=google.com; s=arc-20240605;
        b=eJuOFt5LG09rx1lfBeVfNGInglE9uV0Whz8YchYhbpjgqQk2lxkK0zFZLcyhWRkCgN
         PgtJ/FOtBjJSy8b316EuPR4wYhNs1dug1LvkE6R4zy0bUunZ65ixnzZTB9U7Q1aNmNEk
         DLprHvFUvNok9tNpd9HfMmtLJjIBamF5BzOXe+NFV8pUqIacEDTjlRIi0DBYmh26YMWY
         1KFtE6BOHykPuZHhVLQmKgXLfZFLCUbtHRftJFcgWXlo6jrFm5KGW2W+TBlesWOYMkUO
         gzHrbflU33ZYYqKbrRJIrskc0aqcKIrSAE+jNKd7X1I5013tayGmpNPkD7T3cKYOaj5n
         ULMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pa40UGOtLEf+lUXJi+W2eAsZrpePRgbKwxqj2/6a6JM=;
        fh=iKo7VZ+xY4F1JwmLzdVYnscfvNTJZiMuJAnL+EUDHv4=;
        b=OyrS3wHPqSSeapai08eahL0KQg0Ouu42XNYt3Z863WuY3JqMFluWy4BMsPTaPsOJeG
         kejyDK/9sqfPtWxGRtVcRL+owcf8PttCZ/d11xWUiY6NLT8kmu+TpXiCI7rQhGHdfjkP
         Ik7hidDTebgGEMorVroJ6kz1WXf/J5CEERx2T0KnDRLE1x9x0l1cP0aDZAag4w/4j+M9
         54eeLRtJOSZ3z0tu5T9AxAzzUfNnaWhjTsKdN/bobF3MUqnz3JbvcenScsA7RguLWIyh
         kodQvZyhEwaMwBZKlxJ8/rpMiaw6a+ypnqGoqWfR4BZN9wfdDDT2hMlDgMVEAD+60Y0o
         AmJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772114191; x=1772718991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pa40UGOtLEf+lUXJi+W2eAsZrpePRgbKwxqj2/6a6JM=;
        b=S6AMp2V5pKKAKZtEwUynfZQ8zn3wFGhPrHl8vU68pmwPdpRDyzHREtQfB/t2jtuc41
         mTUitO2wHhOkhN7Kqr4GA+Uk0plS1SskrbZNIemBsHrX3s9nXeKuP63ymmF6nxbgu7dj
         Yly8inJ3mkwzagpvIA+bV+awnCzCjRz6dxXD1mywGjUrrfTlOmZtPfi7JOZhC95A9+lQ
         CVFZY9XX6H6K4Ham0aS66SwZFdpJBiQMTn4U+XN9Iq1Gdf9my6EyTlu3YxjQDgUsvEfM
         A/+H2ufomE7lFl5AxHHYvwzbS51Op85zKJKqN8IHfMho7x4IJbm6Mc7ovtyhm2tmCChG
         X2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772114191; x=1772718991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pa40UGOtLEf+lUXJi+W2eAsZrpePRgbKwxqj2/6a6JM=;
        b=tmiEH8Eot4U8s7rzAT6PxxpOixsxAzXJNch6/vIGN9B4IgePKaOrzu5OXoPHZ3guXX
         kyyBLrOkMn2MuPIpQpLHky1oICR8z2uZMivnf4XXzeWhIqEcHTQY/ewexzELAmyv8qyy
         yC0FE0BTC1UeDwK4nmuFHl2AHn8lw54GS+I7u7rXBAcVWZmMmE8ib6mgi6t65e8sty9O
         5y93/EnmkkyTUMUvvIKBpe1OPmAfYuAWjAcxylk/J18g2TqsvTCHUJwymFBuBs3CQ1pL
         huUqZrdkUcAMKPO+x98SClQq4wFFEbIFhYn11ZcwzRTAMUHHDZSlm9KI2UITQrLJZtiH
         NXqg==
X-Forwarded-Encrypted: i=1; AJvYcCWqDKUSKm8UNktRo9LaPSabLmIhGxr6XxX5fGsOLLYfothaN4oHss0+D76FW6wu4mu26oO4G0Qqt9JQFpj7@vger.kernel.org
X-Gm-Message-State: AOJu0YzRcD48d7lycc+MSu5+npkROacfHxz8yxPi7VvG/8vIPmEFaUVl
	w7vBOchthvyuzujL+jEOoySPV5/I4HeRfXCwCGFJUnItSgxEv6ktbTCoxh6iOjdkkz39eMJodXA
	/Bckcw4dQMrFNFkOtfmMBsSeQcfzyBvH4E8UC2aCjRHHoN6wHe1W5x2Xj5taSl7D05uPvNvc0UO
	uu44t3WmEnugoZQHwwfqzmuhOhZiidWe0tNYOCVCijaQ==
X-Gm-Gg: ATEYQzzeg0Um6coeQEu5Xs8YTk6RC0aq5gVWmbzb9YzM5jMBTPINFVbWGrV6wb5BUIx
	3X8fpcnwVTQ8HuB2mHjtLT6WuJLqSOgcJNyFG+D7z96h0ci6GNF0fqfCUbOLJL4unHNGIYiVcFx
	veHvTItvu9HUUFbfIkwdPDCpvCYxqXcyUUegIY6Bv5dGPbdS/HARXewR23JxLqRlPsDU5xEhoK2
	oc8cBKdBf8cdFOxcsE+oVT+
X-Received: by 2002:a05:6102:3a09:b0:5ff:20c5:cd6 with SMTP id ada2fe7eead31-5ff20c51797mr830106137.18.1772114191173;
        Thu, 26 Feb 2026 05:56:31 -0800 (PST)
X-Received: by 2002:a05:6102:3a09:b0:5ff:20c5:cd6 with SMTP id
 ada2fe7eead31-5ff20c51797mr830098137.18.1772114190749; Thu, 26 Feb 2026
 05:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225125907.53851-1-amarkuze@redhat.com> <20260225125907.53851-2-amarkuze@redhat.com>
 <9687495100c02050c09c503fad1b840ddbfa313c.camel@redhat.com>
In-Reply-To: <9687495100c02050c09c503fad1b840ddbfa313c.camel@redhat.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 26 Feb 2026 15:56:20 +0200
X-Gm-Features: AaiRm50aLyjCETwKDojvUJBPiNoCYBibDGxffgYMF-j2AYy83taMK9QDUr26TaE
Message-ID: <CAO8a2SinY_+Ysn4Sx30x_mntLOCTLot0x3psU=DdEJCJ=VNJug@mail.gmail.com>
Subject: Re: [EXTERNAL] [RFC PATCH v1 1/4] ceph: convert inode flags to named
 bit positions
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78498-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amarkuze@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 44AE61A763D
X-Rspamd-Action: no action

I think I remember reviewing it, now that you mention it.
Let's discuss offline, I'll set up a 1x1.

On Wed, Feb 25, 2026 at 10:56=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redha=
t.com> wrote:
>
> On Wed, 2026-02-25 at 12:59 +0000, Alex Markuze wrote:
> > Define all CEPH_I_* flags as named bit positions with derived
> > bitmask values, making them usable with test_bit/set_bit/clear_bit.
> > Previously only CEPH_I_ODIRECT_BIT and CEPH_ASYNC_CREATE_BIT had
> > named bit positions; the rest were bare bitmask constants.
> >
>
> As I remember, I've reworked all constants for having name for every bit.
> Probably, this patch has ignored and it has never been sent to upstream. =
And I
> converted pretty everything for using test_bit/set_bit/clear_bit. :) You =
did
> this work again. :)
>
> Thanks,
> Slava.
>
> > Convert CEPH_I_ERROR_WRITE and CEPH_I_ERROR_FILELOCK usage sites
> > to use atomic bit operations (test_bit, set_bit, clear_bit) via
> > the new _BIT constants.
> >
> > This is preparation for the client reset feature which needs
> > test_bit() on CEPH_I_ERROR_FILELOCK_BIT in reconnect paths.
> >
> > Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> > ---
> >  fs/ceph/locks.c      |  8 +++----
> >  fs/ceph/mds_client.c |  3 ++-
> >  fs/ceph/super.h      | 54 +++++++++++++++++++++++++++-----------------
> >  3 files changed, 38 insertions(+), 27 deletions(-)
> >
> > diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> > index dd764f9c64b9..2f21574dfb99 100644
> > --- a/fs/ceph/locks.c
> > +++ b/fs/ceph/locks.c
> > @@ -58,7 +58,7 @@ static void ceph_fl_release_lock(struct file_lock *fl=
)
> >       if (atomic_dec_and_test(&ci->i_filelock_ref)) {
> >               /* clear error when all locks are released */
> >               spin_lock(&ci->i_ceph_lock);
> > -             ci->i_ceph_flags &=3D ~CEPH_I_ERROR_FILELOCK;
> > +             clear_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
> >               spin_unlock(&ci->i_ceph_lock);
> >       }
> >       fl->fl_u.ceph.inode =3D NULL;
> > @@ -272,9 +272,8 @@ int ceph_lock(struct file *file, int cmd, struct fi=
le_lock *fl)
> >               wait =3D 1;
> >
> >       spin_lock(&ci->i_ceph_lock);
> > -     if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
> > +     if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
> >               err =3D -EIO;
> > -     }
> >       spin_unlock(&ci->i_ceph_lock);
> >       if (err < 0) {
> >               if (op =3D=3D CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(f=
l))
> > @@ -332,9 +331,8 @@ int ceph_flock(struct file *file, int cmd, struct f=
ile_lock *fl)
> >       doutc(cl, "fl_file: %p\n", fl->c.flc_file);
> >
> >       spin_lock(&ci->i_ceph_lock);
> > -     if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
> > +     if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
> >               err =3D -EIO;
> > -     }
> >       spin_unlock(&ci->i_ceph_lock);
> >       if (err < 0) {
> >               if (lock_is_unlock(fl))
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 23b6d00643c9..28bb27b09b40 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -3610,7 +3610,8 @@ static void __do_request(struct ceph_mds_client *=
mdsc,
> >
> >               spin_lock(&ci->i_ceph_lock);
> >               cap =3D ci->i_auth_cap;
> > -             if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE && mds !=3D ca=
p->mds) {
> > +             if (test_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags) &&
> > +                 mds !=3D cap->mds) {
> >                       doutc(cl, "session changed for auth cap %d -> %d\=
n",
> >                             cap->session->s_mds, session->s_mds);
> >
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index 29a980e22dc2..69a71848240f 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -655,23 +655,35 @@ static inline struct inode *ceph_find_inode(struc=
t super_block *sb,
> >  /*
> >   * Ceph inode.
> >   */
> > -#define CEPH_I_DIR_ORDERED   (1 << 0)  /* dentries in dir are ordered =
*/
> > -#define CEPH_I_FLUSH         (1 << 2)  /* do not delay flush of dirty =
metadata */
> > -#define CEPH_I_POOL_PERM     (1 << 3)  /* pool rd/wr bits are valid */
> > -#define CEPH_I_POOL_RD               (1 << 4)  /* can read from pool *=
/
> > -#define CEPH_I_POOL_WR               (1 << 5)  /* can write to pool */
> > -#define CEPH_I_SEC_INITED    (1 << 6)  /* security initialized */
> > -#define CEPH_I_KICK_FLUSH    (1 << 7)  /* kick flushing caps */
> > -#define CEPH_I_FLUSH_SNAPS   (1 << 8)  /* need flush snapss */
> > -#define CEPH_I_ERROR_WRITE   (1 << 9) /* have seen write errors */
> > -#define CEPH_I_ERROR_FILELOCK        (1 << 10) /* have seen file lock =
errors */
> > -#define CEPH_I_ODIRECT_BIT   (11) /* inode in direct I/O mode */
> > -#define CEPH_I_ODIRECT               (1 << CEPH_I_ODIRECT_BIT)
> > -#define CEPH_ASYNC_CREATE_BIT        (12)      /* async create in flig=
ht for this */
> > -#define CEPH_I_ASYNC_CREATE  (1 << CEPH_ASYNC_CREATE_BIT)
> > -#define CEPH_I_SHUTDOWN              (1 << 13) /* inode is no longer u=
sable */
> > -#define CEPH_I_ASYNC_CHECK_CAPS      (1 << 14) /* check caps immediate=
ly after async
> > -                                          creating finishes */
> > +#define CEPH_I_DIR_ORDERED_BIT               (0)  /* dentries in dir a=
re ordered */
> > +#define CEPH_I_FLUSH_BIT             (2)  /* do not delay flush of dir=
ty metadata */
> > +#define CEPH_I_POOL_PERM_BIT         (3)  /* pool rd/wr bits are valid=
 */
> > +#define CEPH_I_POOL_RD_BIT           (4)  /* can read from pool */
> > +#define CEPH_I_POOL_WR_BIT           (5)  /* can write to pool */
> > +#define CEPH_I_SEC_INITED_BIT                (6)  /* security initiali=
zed */
> > +#define CEPH_I_KICK_FLUSH_BIT                (7)  /* kick flushing cap=
s */
> > +#define CEPH_I_FLUSH_SNAPS_BIT               (8)  /* need flush snapss=
 */
> > +#define CEPH_I_ERROR_WRITE_BIT               (9)  /* have seen write e=
rrors */
> > +#define CEPH_I_ERROR_FILELOCK_BIT    (10) /* have seen file lock error=
s */
> > +#define CEPH_I_ODIRECT_BIT           (11) /* inode in direct I/O mode =
*/
> > +#define CEPH_ASYNC_CREATE_BIT                (12) /* async create in f=
light for this */
> > +#define CEPH_I_SHUTDOWN_BIT          (13) /* inode is no longer usable=
 */
> > +#define CEPH_I_ASYNC_CHECK_CAPS_BIT  (14) /* check caps after async cr=
eating finishes */
> > +
> > +#define CEPH_I_DIR_ORDERED           (1 << CEPH_I_DIR_ORDERED_BIT)
> > +#define CEPH_I_FLUSH                 (1 << CEPH_I_FLUSH_BIT)
> > +#define CEPH_I_POOL_PERM             (1 << CEPH_I_POOL_PERM_BIT)
> > +#define CEPH_I_POOL_RD                       (1 << CEPH_I_POOL_RD_BIT)
> > +#define CEPH_I_POOL_WR                       (1 << CEPH_I_POOL_WR_BIT)
> > +#define CEPH_I_SEC_INITED            (1 << CEPH_I_SEC_INITED_BIT)
> > +#define CEPH_I_KICK_FLUSH            (1 << CEPH_I_KICK_FLUSH_BIT)
> > +#define CEPH_I_FLUSH_SNAPS           (1 << CEPH_I_FLUSH_SNAPS_BIT)
> > +#define CEPH_I_ERROR_WRITE           (1 << CEPH_I_ERROR_WRITE_BIT)
> > +#define CEPH_I_ERROR_FILELOCK                (1 << CEPH_I_ERROR_FILELO=
CK_BIT)
> > +#define CEPH_I_ODIRECT                       (1 << CEPH_I_ODIRECT_BIT)
> > +#define CEPH_I_ASYNC_CREATE          (1 << CEPH_ASYNC_CREATE_BIT)
> > +#define CEPH_I_SHUTDOWN                      (1 << CEPH_I_SHUTDOWN_BIT=
)
> > +#define CEPH_I_ASYNC_CHECK_CAPS              (1 << CEPH_I_ASYNC_CHECK_=
CAPS_BIT)
> >
> >  /*
> >   * Masks of ceph inode work.
> > @@ -691,18 +703,18 @@ static inline struct inode *ceph_find_inode(struc=
t super_block *sb,
> >   */
> >  static inline void ceph_set_error_write(struct ceph_inode_info *ci)
> >  {
> > -     if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE)) {
> > +     if (!test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
> >               spin_lock(&ci->i_ceph_lock);
> > -             ci->i_ceph_flags |=3D CEPH_I_ERROR_WRITE;
> > +             set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
> >               spin_unlock(&ci->i_ceph_lock);
> >       }
> >  }
> >
> >  static inline void ceph_clear_error_write(struct ceph_inode_info *ci)
> >  {
> > -     if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE) {
> > +     if (test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
> >               spin_lock(&ci->i_ceph_lock);
> > -             ci->i_ceph_flags &=3D ~CEPH_I_ERROR_WRITE;
> > +             clear_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
> >               spin_unlock(&ci->i_ceph_lock);
> >       }
> >  }
>


