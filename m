Return-Path: <linux-fsdevel+bounces-78398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EV6LbFin2lRagQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 21:59:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B01E19D829
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 21:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E5F93009FAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 20:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82324288C2D;
	Wed, 25 Feb 2026 20:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJQi2ySd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMUkClaw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62C421B192
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053001; cv=none; b=tm7BS92DNLAYdoEO4Ccincoek8hJQw1JqIsLF6uIOtKXbJ6g2gP9c7KtFMhMVkT69/P5HDNuh+sQ22Xr79pe300JOwLjTx7YyTWT1nUuJRPoilz+TlFieDYqjZule+EB0CXFkFxE0d8sx8/JvCe7NOK3wAoGzZ1Ma/6AkMzzpz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053001; c=relaxed/simple;
	bh=rhCq4+9Wz3PUOBm64nh1Ke6+bQXt5cAvl09cJd4qqw0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l5YUGZ96eiqiWATvZo3djXRIkiJ7fX90cgXctwrwXyefflV92ZT6MdBVROPtqBFnl9qmIQIVwejzW9HXRAxVAdX/7fN2QmEjfEasd1uZq7qJvEq6e/UuiqDbfe8tHs6h/Q/KYYf986+Lqw+AVaRlawLpBEGJnEgnfSWZU2cwaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJQi2ySd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMUkClaw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772052998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m2YEZi7KcbD8SQA6LwyRyL7mxfRFNp+QIg8lXjiTFBU=;
	b=bJQi2ySdE80F5GgNSI7iZHWuNYUrhsaJBsh93yee+EB9NM2Fr+51yt9M8Ae+IUkUIf5XMi
	CTrqw3o3OP8QOYxk0S0VB9SDsPwH+Hm0clSgyp2ik2rlcRmH1LZPAmHe/lVMoLbeV/4Q+6
	sc+vYKj5pMFQ5v3nqytdjrgbNkkQ77A=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-rC85Lu56N7Of9nnsq30gzw-1; Wed, 25 Feb 2026 15:56:37 -0500
X-MC-Unique: rC85Lu56N7Of9nnsq30gzw-1
X-Mimecast-MFC-AGG-ID: rC85Lu56N7Of9nnsq30gzw_1772052995
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-463a075e0f5so2421690b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 12:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772052995; x=1772657795; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m2YEZi7KcbD8SQA6LwyRyL7mxfRFNp+QIg8lXjiTFBU=;
        b=ZMUkClawT7WZnZ9iFOV8bAaEeIDnHiI1Yd+vD3j1V/elOLbZ6Uq+9c13NHSEyc5ZXB
         g3eTSxiThp7q4O+Z3g8LUXEWnpyd7iisUyb1c/dSpaTuF3vXWcMK6TzeNSuTFUDti9IQ
         8avqMvQ0Dv3QtY+KP/E0lL9be7xm/UjcTY2dnOMzJfphV5FbwYSY9p5+h+cDZbbf+itO
         qqIUSMwGbeE9uuvX/bR4IMGfWSSfT3T6bhsDuC9QJkO0eZxQPK+BiWp61iDWO+rqJIkK
         RDIsC3LCAC+BJpVjNgkqig2dvbFXaoPUgm+rQdiXD1NVYsYmxWcdYefqNGlPQzG8KzoF
         ZEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772052995; x=1772657795;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2YEZi7KcbD8SQA6LwyRyL7mxfRFNp+QIg8lXjiTFBU=;
        b=AqjcoiaaJuADhlGjcqcPPqzgCq+2LDQ7YbsFzoKDUjcOe7IBSwk9Nav5S4VNFcxhcj
         /j3x7XdsZhy3uJ5v6UQ2DSWkr0xZtPw3Z6IIOlxAvweYbebVmM4uK7sP3W1PWbo0SzMj
         IhKxZuwaU1+n/+/SeKfPxtFFP4S5c3HuSmmoWycLwmuoetQfFxH8SqwtQVgP40ZD9+/9
         0rBFnWsTAqL329TqXFTfzMgeMhIy+5aFSoinfH4FJRThhkPqKAXZkfOUN6sRKYSHrExL
         4t/ws59yR7bVKiUBlcoRiEwnHWtcpd9vWHs7eqiIDIjkJaxl+kv+5wcjoTeSU9bHZHos
         9B/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqCaRDy/sgqrGfgb8wDLmzd8qeCy+/jKiS7r3NhjvG/gKi264sMvyUXqlycpt9B1moozCaZ0tisNxKh/zf@vger.kernel.org
X-Gm-Message-State: AOJu0YwSG6P4qXwuiseOTK4FYexjGHVIeQkfahPJdX3hP7zJWeNJnagQ
	G+pqtwiSTFOX+pS22x+Q0ye39dr2v1WuxgOsTVrSdYOz9Si8OWD1L5pXXEZdvcF36iGBT8AC542
	Z9ls4G20Mtl5RK47VVXao84zugxVnTtG+cJzrTa/hepX+ThcOIx6y3wd8VY+uhNU0rfw=
X-Gm-Gg: ATEYQzzf5eq6PJUY9iVYO3XC3dr4MyySSXTM0XXVULLt0AkNTBgpt9CT2LIYiHHpvZz
	9At9uNHBSrFHypUR85kJ+oFTb29SNmP7GTcq91npLb+uQ/7fBy8zUMPKfZ/6Q+qI1Qza5kbDQ5q
	BHRhzm25h+6g6gZPQ3qti93E2pzeSh0xIX/12MUSvaqFPn1NidmEdrj9p45r5YMmUvdwtfoLf25
	gcRRJNtXuMLOToRa55gjcTDB32VwOgXGmbelgzZsjOmO60BPQjVs9ZDo/xC+20085WfyDYP0ArL
	QsvlN2e99NcGWp8BMAHW9L/qpj6tC8CqilxNhoX7UvBOQDLUjTt3kuk5jvRhqEFmS4qVxHBRPfJ
	0BairAOIwbnrESB2gVWXqd8nvCFzsT/tzenc2flaIaZ2DS0eFVesh
X-Received: by 2002:a05:6808:14c8:b0:441:c8a2:ba26 with SMTP id 5614622812f47-464a5d9a776mr262123b6e.7.1772052995514;
        Wed, 25 Feb 2026 12:56:35 -0800 (PST)
X-Received: by 2002:a05:6808:14c8:b0:441:c8a2:ba26 with SMTP id 5614622812f47-464a5d9a776mr262114b6e.7.1772052995116;
        Wed, 25 Feb 2026 12:56:35 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46449fd7a0asm9721165b6e.1.2026.02.25.12.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:56:34 -0800 (PST)
Message-ID: <9687495100c02050c09c503fad1b840ddbfa313c.camel@redhat.com>
Subject: Re: [EXTERNAL] [RFC PATCH v1 1/4] ceph: convert inode flags to
 named bit positions
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Wed, 25 Feb 2026 12:56:33 -0800
In-Reply-To: <20260225125907.53851-2-amarkuze@redhat.com>
References: <20260225125907.53851-1-amarkuze@redhat.com>
	 <20260225125907.53851-2-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78398-lists,linux-fsdevel=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B01E19D829
X-Rspamd-Action: no action

On Wed, 2026-02-25 at 12:59 +0000, Alex Markuze wrote:
> Define all CEPH_I_* flags as named bit positions with derived
> bitmask values, making them usable with test_bit/set_bit/clear_bit.
> Previously only CEPH_I_ODIRECT_BIT and CEPH_ASYNC_CREATE_BIT had
> named bit positions; the rest were bare bitmask constants.
>=20

As I remember, I've reworked all constants for having name for every bit.
Probably, this patch has ignored and it has never been sent to upstream. An=
d I
converted pretty everything for using test_bit/set_bit/clear_bit. :) You di=
d
this work again. :)

Thanks,
Slava.

> Convert CEPH_I_ERROR_WRITE and CEPH_I_ERROR_FILELOCK usage sites
> to use atomic bit operations (test_bit, set_bit, clear_bit) via
> the new _BIT constants.
>=20
> This is preparation for the client reset feature which needs
> test_bit() on CEPH_I_ERROR_FILELOCK_BIT in reconnect paths.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/locks.c      |  8 +++----
>  fs/ceph/mds_client.c |  3 ++-
>  fs/ceph/super.h      | 54 +++++++++++++++++++++++++++-----------------
>  3 files changed, 38 insertions(+), 27 deletions(-)
>=20
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index dd764f9c64b9..2f21574dfb99 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -58,7 +58,7 @@ static void ceph_fl_release_lock(struct file_lock *fl)
>  	if (atomic_dec_and_test(&ci->i_filelock_ref)) {
>  		/* clear error when all locks are released */
>  		spin_lock(&ci->i_ceph_lock);
> -		ci->i_ceph_flags &=3D ~CEPH_I_ERROR_FILELOCK;
> +		clear_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
>  		spin_unlock(&ci->i_ceph_lock);
>  	}
>  	fl->fl_u.ceph.inode =3D NULL;
> @@ -272,9 +272,8 @@ int ceph_lock(struct file *file, int cmd, struct file=
_lock *fl)
>  		wait =3D 1;
> =20
>  	spin_lock(&ci->i_ceph_lock);
> -	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
> +	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
>  		err =3D -EIO;
> -	}
>  	spin_unlock(&ci->i_ceph_lock);
>  	if (err < 0) {
>  		if (op =3D=3D CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(fl))
> @@ -332,9 +331,8 @@ int ceph_flock(struct file *file, int cmd, struct fil=
e_lock *fl)
>  	doutc(cl, "fl_file: %p\n", fl->c.flc_file);
> =20
>  	spin_lock(&ci->i_ceph_lock);
> -	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
> +	if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
>  		err =3D -EIO;
> -	}
>  	spin_unlock(&ci->i_ceph_lock);
>  	if (err < 0) {
>  		if (lock_is_unlock(fl))
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 23b6d00643c9..28bb27b09b40 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3610,7 +3610,8 @@ static void __do_request(struct ceph_mds_client *md=
sc,
> =20
>  		spin_lock(&ci->i_ceph_lock);
>  		cap =3D ci->i_auth_cap;
> -		if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE && mds !=3D cap->mds) {
> +		if (test_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags) &&
> +		    mds !=3D cap->mds) {
>  			doutc(cl, "session changed for auth cap %d -> %d\n",
>  			      cap->session->s_mds, session->s_mds);
> =20
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 29a980e22dc2..69a71848240f 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -655,23 +655,35 @@ static inline struct inode *ceph_find_inode(struct =
super_block *sb,
>  /*
>   * Ceph inode.
>   */
> -#define CEPH_I_DIR_ORDERED	(1 << 0)  /* dentries in dir are ordered */
> -#define CEPH_I_FLUSH		(1 << 2)  /* do not delay flush of dirty metadata =
*/
> -#define CEPH_I_POOL_PERM	(1 << 3)  /* pool rd/wr bits are valid */
> -#define CEPH_I_POOL_RD		(1 << 4)  /* can read from pool */
> -#define CEPH_I_POOL_WR		(1 << 5)  /* can write to pool */
> -#define CEPH_I_SEC_INITED	(1 << 6)  /* security initialized */
> -#define CEPH_I_KICK_FLUSH	(1 << 7)  /* kick flushing caps */
> -#define CEPH_I_FLUSH_SNAPS	(1 << 8)  /* need flush snapss */
> -#define CEPH_I_ERROR_WRITE	(1 << 9) /* have seen write errors */
> -#define CEPH_I_ERROR_FILELOCK	(1 << 10) /* have seen file lock errors */
> -#define CEPH_I_ODIRECT_BIT	(11) /* inode in direct I/O mode */
> -#define CEPH_I_ODIRECT		(1 << CEPH_I_ODIRECT_BIT)
> -#define CEPH_ASYNC_CREATE_BIT	(12)	  /* async create in flight for this =
*/
> -#define CEPH_I_ASYNC_CREATE	(1 << CEPH_ASYNC_CREATE_BIT)
> -#define CEPH_I_SHUTDOWN		(1 << 13) /* inode is no longer usable */
> -#define CEPH_I_ASYNC_CHECK_CAPS	(1 << 14) /* check caps immediately afte=
r async
> -					     creating finishes */
> +#define CEPH_I_DIR_ORDERED_BIT		(0)  /* dentries in dir are ordered */
> +#define CEPH_I_FLUSH_BIT		(2)  /* do not delay flush of dirty metadata *=
/
> +#define CEPH_I_POOL_PERM_BIT		(3)  /* pool rd/wr bits are valid */
> +#define CEPH_I_POOL_RD_BIT		(4)  /* can read from pool */
> +#define CEPH_I_POOL_WR_BIT		(5)  /* can write to pool */
> +#define CEPH_I_SEC_INITED_BIT		(6)  /* security initialized */
> +#define CEPH_I_KICK_FLUSH_BIT		(7)  /* kick flushing caps */
> +#define CEPH_I_FLUSH_SNAPS_BIT		(8)  /* need flush snapss */
> +#define CEPH_I_ERROR_WRITE_BIT		(9)  /* have seen write errors */
> +#define CEPH_I_ERROR_FILELOCK_BIT	(10) /* have seen file lock errors */
> +#define CEPH_I_ODIRECT_BIT		(11) /* inode in direct I/O mode */
> +#define CEPH_ASYNC_CREATE_BIT		(12) /* async create in flight for this *=
/
> +#define CEPH_I_SHUTDOWN_BIT		(13) /* inode is no longer usable */
> +#define CEPH_I_ASYNC_CHECK_CAPS_BIT	(14) /* check caps after async creat=
ing finishes */
> +
> +#define CEPH_I_DIR_ORDERED		(1 << CEPH_I_DIR_ORDERED_BIT)
> +#define CEPH_I_FLUSH			(1 << CEPH_I_FLUSH_BIT)
> +#define CEPH_I_POOL_PERM		(1 << CEPH_I_POOL_PERM_BIT)
> +#define CEPH_I_POOL_RD			(1 << CEPH_I_POOL_RD_BIT)
> +#define CEPH_I_POOL_WR			(1 << CEPH_I_POOL_WR_BIT)
> +#define CEPH_I_SEC_INITED		(1 << CEPH_I_SEC_INITED_BIT)
> +#define CEPH_I_KICK_FLUSH		(1 << CEPH_I_KICK_FLUSH_BIT)
> +#define CEPH_I_FLUSH_SNAPS		(1 << CEPH_I_FLUSH_SNAPS_BIT)
> +#define CEPH_I_ERROR_WRITE		(1 << CEPH_I_ERROR_WRITE_BIT)
> +#define CEPH_I_ERROR_FILELOCK		(1 << CEPH_I_ERROR_FILELOCK_BIT)
> +#define CEPH_I_ODIRECT			(1 << CEPH_I_ODIRECT_BIT)
> +#define CEPH_I_ASYNC_CREATE		(1 << CEPH_ASYNC_CREATE_BIT)
> +#define CEPH_I_SHUTDOWN			(1 << CEPH_I_SHUTDOWN_BIT)
> +#define CEPH_I_ASYNC_CHECK_CAPS		(1 << CEPH_I_ASYNC_CHECK_CAPS_BIT)
> =20
>  /*
>   * Masks of ceph inode work.
> @@ -691,18 +703,18 @@ static inline struct inode *ceph_find_inode(struct =
super_block *sb,
>   */
>  static inline void ceph_set_error_write(struct ceph_inode_info *ci)
>  {
> -	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE)) {
> +	if (!test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
>  		spin_lock(&ci->i_ceph_lock);
> -		ci->i_ceph_flags |=3D CEPH_I_ERROR_WRITE;
> +		set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
>  		spin_unlock(&ci->i_ceph_lock);
>  	}
>  }
> =20
>  static inline void ceph_clear_error_write(struct ceph_inode_info *ci)
>  {
> -	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE) {
> +	if (test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
>  		spin_lock(&ci->i_ceph_lock);
> -		ci->i_ceph_flags &=3D ~CEPH_I_ERROR_WRITE;
> +		clear_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
>  		spin_unlock(&ci->i_ceph_lock);
>  	}
>  }


