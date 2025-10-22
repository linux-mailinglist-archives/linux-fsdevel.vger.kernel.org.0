Return-Path: <linux-fsdevel+bounces-65204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53344BFE185
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 21:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB83235538D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 19:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB42E2F83BA;
	Wed, 22 Oct 2025 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDDCCK5a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2802F60A2
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162668; cv=none; b=UG0XZ5UWIPb7cYBbH5pPuthiifowoV9gJUmhvaTBd+Y0iIjbg6ClqzAVbh/S9kv9jTtnZEsD1yi6ijMAlYGd+gUVa1T2XH3WFPDA+PbMzO8RqHWwOUrWedM9b/VR1YBI65h91wSbUyVPImPorE3clWWki18rVj6qxILedlSia9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162668; c=relaxed/simple;
	bh=SstUcV2ZpKMxVEws3v7qyscG0YkhYLLxRaSv8i1r0po=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QlT/7s+jOvXlP8jlZJEIqX1WA39NVUvTDR7mgnVnl98DkuGQPxzX0/MDHi7R6s3GKadrwHrxON9F87IIXx7NZ6ewCRJz3vzj8ldmDrAgI5Qa3FyexHdBmqQw/JKZSf5Q7N09Om0OJRaDxsRarEAPdJqPlClHjZ0SJ1q1RF7tDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDDCCK5a; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57bb7ee3142so13477e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761162664; x=1761767464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ZD1mq8gMBr2IRj7aFqJIJGCl9HbZeyMciW+Dg0MQqU=;
        b=MDDCCK5aOaKl02bpwbBXLsHaaqZLzK/uSaGRICMwjuoiMIqLeO9gyslz0zcjDeeovo
         VcCKE+ynynWw9rz0b9lWHsK7qxPZFlLlVyCbgWitd1SwA6oMagD6r/nHoYFg+QQ+lwnL
         xJU3GphcHdEwra10HFPUw5DtT2o4+XigVgfP8TFyXQCKkQAth+xqstWb3Od7rQXY4RGm
         XAM8NpNOM/KD3w+TPSKTy8OQjayQHgLhwTwMO4K3Oqz7k3x1JqUar9kftijyd34cvapa
         X3Cq7tChqOOB0k2TQhphUJVK5POs09PocCe5mchba+yrmJybbvAEDDw7ji4MQSGXmLVy
         7hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761162664; x=1761767464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ZD1mq8gMBr2IRj7aFqJIJGCl9HbZeyMciW+Dg0MQqU=;
        b=uOcZMAt2gsM5+vE8zef0/pPJzqfrXPiQDiyrG1kRf+b5UN2Jap+/dWqekO9q63wgzy
         y61JHmIPZotRAP3IrCInYCkE056HVvJcl+ZaZGFwCpHl9BsIMpK5xXkI6KEZ9zN4uAzP
         7LBloeSSWXkldDVfu+iTMhZPjg9Csua+XsBZSav43KK95N/2fghq3/Ero30gcGcdISXE
         3tq3VfeGdVlgOgJsvM2eAtVkdRsa0AOUcbmJbSGFz0nHguKxcXqdm5sCVs4bta1Z6k5j
         gbWxg/ZHgkzfPRieZIWZmYQkji4ZzlFRAwsTJh8PJ7EkaL3mDpsTNRrzCTO7r0+x/Uwr
         zUQg==
X-Forwarded-Encrypted: i=1; AJvYcCUUFcmiK2+IynGnjdQ+uQbPQG7v0n4s2EFT6/+nph4kHd0430JpyT3tWpC4Pkx8kl4vIRjHoA82NF2TqmCA@vger.kernel.org
X-Gm-Message-State: AOJu0YxO3aSur2AgLXC3nyQd3f9mYL917pKNWsSkQLY26r6NFuvTCzEK
	s4udEzdO4ca046f1VyjGXdhe5mnHCosEptik1daR9fKQXe9JZ8wyV1o5
X-Gm-Gg: ASbGncsqzYTQzPRGEF+/Wu8PH6Zy3DJeAGbAS4jCELLpZj9rtPN/lZ+Rja6ZsMnBeTX
	9AVHpHiuK4ubvI3c6ZKfaDtTV6JHFb3V+jBpIWrJHNev123vkZ09vcSVnFd9FN+UTBloagTF7qD
	NA9kft6yOQvSMYr589e8HBcbhHUosyw0hN+8EaKoNJY704GA43So8HYd/Pfk9DJFn0+i49uAZhd
	DHsaCGLguz1OMV5ciGQktEXYHru/D9OrLZItPFL42kH/JnYEVLRo/1kkMxVTbDpQTAuBH6cwSeP
	GhdLz11QivIuG2lkO2ouUdN6XAPxOaM2mHpIRx/8QvwIcVMts30G+1z+DhdHDY6Jhkjm1eQY04S
	wgV9yOQdinqo8A4bZOXuukkG4JAG92d7c17FF46gg5uyc+UmlSOlLvrJca8HbScCeC8Y+bAtsRm
	uV02i/uIbQnhVoZXwpc8F6cnb27tQgpJD/chGIxhP0SYq2EV4NyswIXi83hmaM1qo44DYW7jOHT
	wSE/FHROjiKrHl2SpIIzFk=
X-Google-Smtp-Source: AGHT+IEDPw7SHJLDgw9i/Vf5F7SC3HLiESsRJ1Ii9tuDw3dxdME/S3zTTk+J9dl4oUyuhbFokc8GGA==
X-Received: by 2002:a05:6512:239a:b0:57e:7040:9c77 with SMTP id 2adb3069b0e04-591d856d7d2mr6589814e87.38.1761162663350;
        Wed, 22 Oct 2025 12:51:03 -0700 (PDT)
Received: from t470.station.com (2001-14bb-6d3-208e-36a3-d115-fe36-2b4f.rev.dnainternet.fi. [2001:14bb:6d3:208e:36a3:d115:fe36:2b4f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d38714sm50764e87.105.2025.10.22.12.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 12:51:03 -0700 (PDT)
Message-ID: <95685a8d1b0bc73e5d9b926c5c9de983a0802c70.camel@gmail.com>
Subject: Re: [PATCH] afs: Fix dynamic lookup to fail on cell lookup failure
From: markus.suvanto@gmail.com
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, Christian Brauner
	 <christian@brauner.io>, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2025 22:51:02 +0300
In-Reply-To: <1784747.1761158912@warthog.procyon.org.uk>
References: <1784747.1761158912@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ke, 2025-10-22 kello 19:48 +0100, David Howells kirjoitti:
> When a process tries to access an entry in /afs, normally what happens is
> that an automount dentry is created by ->lookup() and then triggered, whi=
ch
> jumps through the ->d_automount() op.  Currently, afs_dynroot_lookup() do=
es
> not do cell DNS lookup, leaving that to afs_d_automount() to perform -
> however, it is possible to use access() or stat() on the automount point,
> which will always return successfully, have briefly created an afs_cell
> record if one did not already exist.
>=20
> This means that something like:
>=20
>         test -d "/afs/.west" && echo Directory exists
>=20
> will print "Directory exists" even though no such cell is configured.  Th=
is
> breaks the "west" python module available on PIP as it expects this acces=
s
> to fail.
>=20
> Now, it could be possible to make afs_dynroot_lookup() perform the DNS[*]
> lookup, but that would make "ls --color /afs" do this for each cell in /a=
fs
> that is listed but not yet probed.  kafs-client, probably wrongly, preloa=
ds
> the entire cell database and all the known cells are then listed in /afs =
-
> and doing ls /afs would be very, very slow, especially if any cell suppli=
ed
> addresses but was wholly inaccessible.
>=20
>  [*] When I say "DNS", actually read getaddrinfo(), which could use any o=
ne
>      of a host of mechanisms.  Could also use static configuration.
>=20
> To fix this, make the following changes:
>=20
>  (1) Create an enum to specify the origination point of a call to
>      afs_lookup_cell() and pass this value into that function in place of
>      the "excl" parameter (which can be derived from it).  There are six
>      points of origination:
>=20
>         - Cell preload through /proc/net/afs/cells
>         - Root cell config through /proc/net/afs/rootcell
>         - Lookup in dynamic root
>         - Automount trigger
>         - Direct mount with mount() syscall
>         - Alias check where YFS tells us the cell name is different
>=20
>  (2) Add an extra state into the afs_cell state machine to indicate a cel=
l
>      that's been initialised, but not yet looked up.  This is separate fr=
om
>      one that can be considered active and has been looked up at least
>      once.
>=20
>  (3) Make afs_lookup_cell() vary its behaviour more, depending on where i=
t
>      was called from:
>=20
>      If called from preload or root cell config, DNS lookup will not happ=
en
>      until we definitely want to use the cell (dynroot mount, automount,
>      direct mount or alias check).  The cell will appear in /afs but stat=
()
>      won't trigger DNS lookup.
>=20
>      If the cell already exists, dynroot will not wait for the DNS lookup
>      to complete.  If the cell did not already exist, dynroot will wait.
>=20
>      If called from automount, direct mount or alias check, it will wait
>      for the DNS lookup to complete.
>=20
>  (4) Make afs_lookup_cell() return an error if lookup failed in one way o=
r
>      another.  We try to return -ENOENT if the DNS says the cell does not
>      exist and -EDESTADDRREQ if we couldn't access the DNS.
>=20
> Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220685
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/cell.c     |   78 +++++++++++++++++++++++++++++++++++++++++++++--=
-------
>  fs/afs/dynroot.c  |    3 +-
>  fs/afs/internal.h |   12 +++++++-
>  fs/afs/mntpt.c    |    3 +-
>  fs/afs/proc.c     |    3 +-
>  fs/afs/super.c    |    2 -
>  fs/afs/vl_alias.c |    3 +-
>  7 files changed, 86 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/afs/cell.c b/fs/afs/cell.c
> index f31359922e98..d9b6fa1088b7 100644
> --- a/fs/afs/cell.c
> +++ b/fs/afs/cell.c
> @@ -229,7 +229,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net=
 *net,
>   * @name:	The name of the cell.
>   * @namesz:	The strlen of the cell name.
>   * @vllist:	A colon/comma separated list of numeric IP addresses or NULL=
.
> - * @excl:	T if an error should be given if the cell name already exists.
> + * @reason:	The reason we're doing the lookup
>   * @trace:	The reason to be logged if the lookup is successful.
>   *
>   * Look up a cell record by name and query the DNS for VL server address=
es if
> @@ -239,7 +239,8 @@ static struct afs_cell *afs_alloc_cell(struct afs_net=
 *net,
>   */
>  struct afs_cell *afs_lookup_cell(struct afs_net *net,
>  				 const char *name, unsigned int namesz,
> -				 const char *vllist, bool excl,
> +				 const char *vllist,
> +				 enum afs_lookup_cell_for reason,
>  				 enum afs_cell_trace trace)
>  {
>  	struct afs_cell *cell, *candidate, *cursor;
> @@ -247,12 +248,18 @@ struct afs_cell *afs_lookup_cell(struct afs_net *ne=
t,
>  	enum afs_cell_state state;
>  	int ret, n;
> =20
> -	_enter("%s,%s", name, vllist);
> +	_enter("%s,%s,%u", name, vllist, reason);
> =20
> -	if (!excl) {
> +	if (reason !=3D AFS_LOOKUP_CELL_PRELOAD) {
>  		cell =3D afs_find_cell(net, name, namesz, trace);
> -		if (!IS_ERR(cell))
> +		if (!IS_ERR(cell)) {
> +			if (reason =3D=3D AFS_LOOKUP_CELL_DYNROOT)
> +				goto no_wait;
> +			if (cell->state =3D=3D AFS_CELL_SETTING_UP ||
> +			    cell->state =3D=3D AFS_CELL_UNLOOKED)
> +				goto lookup_cell;
>  			goto wait_for_cell;
> +		}
>  	}
> =20
>  	/* Assume we're probably going to create a cell and preallocate and
> @@ -298,26 +305,69 @@ struct afs_cell *afs_lookup_cell(struct afs_net *ne=
t,
>  	rb_insert_color(&cell->net_node, &net->cells);
>  	up_write(&net->cells_lock);
> =20
> -	afs_queue_cell(cell, afs_cell_trace_queue_new);
> +lookup_cell:
> +	if (reason !=3D AFS_LOOKUP_CELL_PRELOAD &&
> +	    reason !=3D AFS_LOOKUP_CELL_ROOTCELL) {
> +		set_bit(AFS_CELL_FL_DO_LOOKUP, &cell->flags);
> +		afs_queue_cell(cell, afs_cell_trace_queue_new);
> +	}
> =20
>  wait_for_cell:
> -	_debug("wait_for_cell");
>  	state =3D smp_load_acquire(&cell->state); /* vs error */
> -	if (state !=3D AFS_CELL_ACTIVE &&
> -	    state !=3D AFS_CELL_DEAD) {
> +	switch (state) {
> +	case AFS_CELL_ACTIVE:
> +	case AFS_CELL_DEAD:
> +		break;
> +	case AFS_CELL_UNLOOKED:
> +	default:
> +		if (reason =3D=3D AFS_LOOKUP_CELL_PRELOAD ||
> +		    reason =3D=3D AFS_LOOKUP_CELL_ROOTCELL)
> +			break;
> +		_debug("wait_for_cell");
>  		afs_see_cell(cell, afs_cell_trace_wait);
>  		wait_var_event(&cell->state,
>  			       ({
>  				       state =3D smp_load_acquire(&cell->state); /* vs error */
>  				       state =3D=3D AFS_CELL_ACTIVE || state =3D=3D AFS_CELL_DEAD;
>  			       }));
> +		_debug("waited_for_cell %d %d", cell->state, cell->error);
>  	}
> =20
> +no_wait:
>  	/* Check the state obtained from the wait check. */
> +	state =3D smp_load_acquire(&cell->state); /* vs error */
>  	if (state =3D=3D AFS_CELL_DEAD) {
>  		ret =3D cell->error;
>  		goto error;
>  	}
> +	if (state =3D=3D AFS_CELL_ACTIVE) {
> +		switch (cell->dns_status) {
> +		case DNS_LOOKUP_NOT_DONE:
> +			if (cell->dns_source =3D=3D DNS_RECORD_FROM_CONFIG) {
> +				ret =3D 0;
> +				break;
> +			}
> +			fallthrough;
> +		default:
> +			ret =3D -EIO;
> +			goto error;
> +		case DNS_LOOKUP_GOOD:
> +		case DNS_LOOKUP_GOOD_WITH_BAD:
> +			ret =3D 0;
> +			break;
> +		case DNS_LOOKUP_GOT_NOT_FOUND:
> +			ret =3D -ENOENT;
> +			goto error;
> +		case DNS_LOOKUP_BAD:
> +			ret =3D -EREMOTEIO;
> +			goto error;
> +		case DNS_LOOKUP_GOT_LOCAL_FAILURE:
> +		case DNS_LOOKUP_GOT_TEMP_FAILURE:
> +		case DNS_LOOKUP_GOT_NS_FAILURE:
> +			ret =3D -EDESTADDRREQ;
> +			goto error;
> +		}
> +	}
> =20
>  	_leave(" =3D %p [cell]", cell);
>  	return cell;
> @@ -325,7 +375,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
>  cell_already_exists:
>  	_debug("cell exists");
>  	cell =3D cursor;
> -	if (excl) {
> +	if (reason =3D=3D AFS_LOOKUP_CELL_PRELOAD) {
>  		ret =3D -EEXIST;
>  	} else {
>  		afs_use_cell(cursor, trace);
> @@ -384,7 +434,8 @@ int afs_cell_init(struct afs_net *net, const char *ro=
otcell)
>  		return -EINVAL;
> =20
>  	/* allocate a cell record for the root/workstation cell */
> -	new_root =3D afs_lookup_cell(net, rootcell, len, vllist, false,
> +	new_root =3D afs_lookup_cell(net, rootcell, len, vllist,
> +				   AFS_LOOKUP_CELL_ROOTCELL,
>  				   afs_cell_trace_use_lookup_ws);
>  	if (IS_ERR(new_root)) {
>  		_leave(" =3D %ld", PTR_ERR(new_root));
> @@ -777,6 +828,7 @@ static bool afs_manage_cell(struct afs_cell *cell)
>  	switch (cell->state) {
>  	case AFS_CELL_SETTING_UP:
>  		goto set_up_cell;
> +	case AFS_CELL_UNLOOKED:
>  	case AFS_CELL_ACTIVE:
>  		goto cell_is_active;
>  	case AFS_CELL_REMOVING:
> @@ -797,7 +849,7 @@ static bool afs_manage_cell(struct afs_cell *cell)
>  		goto remove_cell;
>  	}
> =20
> -	afs_set_cell_state(cell, AFS_CELL_ACTIVE);
> +	afs_set_cell_state(cell, AFS_CELL_UNLOOKED);
> =20
>  cell_is_active:
>  	if (afs_has_cell_expired(cell, &next_manage))
> @@ -807,6 +859,8 @@ static bool afs_manage_cell(struct afs_cell *cell)
>  		ret =3D afs_update_cell(cell);
>  		if (ret < 0)
>  			cell->error =3D ret;
> +		if (cell->state =3D=3D AFS_CELL_UNLOOKED)
> +			afs_set_cell_state(cell, AFS_CELL_ACTIVE);
>  	}
> =20
>  	if (next_manage < TIME64_MAX && cell->net->live) {
> diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
> index 8c6130789fde..dc9d29e3739e 100644
> --- a/fs/afs/dynroot.c
> +++ b/fs/afs/dynroot.c
> @@ -108,7 +108,8 @@ static struct dentry *afs_dynroot_lookup_cell(struct =
inode *dir, struct dentry *
>  		dotted =3D true;
>  	}
> =20
> -	cell =3D afs_lookup_cell(net, name, len, NULL, false,
> +	cell =3D afs_lookup_cell(net, name, len, NULL,
> +			       AFS_LOOKUP_CELL_DYNROOT,
>  			       afs_cell_trace_use_lookup_dynroot);
>  	if (IS_ERR(cell)) {
>  		ret =3D PTR_ERR(cell);
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index bcbf828ba31f..a90b8ac56844 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -344,6 +344,7 @@ extern const char afs_init_sysname[];
> =20
>  enum afs_cell_state {
>  	AFS_CELL_SETTING_UP,
> +	AFS_CELL_UNLOOKED,
>  	AFS_CELL_ACTIVE,
>  	AFS_CELL_REMOVING,
>  	AFS_CELL_DEAD,
> @@ -1050,9 +1051,18 @@ static inline bool afs_cb_is_broken(unsigned int c=
b_break,
>  extern int afs_cell_init(struct afs_net *, const char *);
>  extern struct afs_cell *afs_find_cell(struct afs_net *, const char *, un=
signed,
>  				      enum afs_cell_trace);
> +enum afs_lookup_cell_for {
> +	AFS_LOOKUP_CELL_DYNROOT,
> +	AFS_LOOKUP_CELL_MOUNTPOINT,
> +	AFS_LOOKUP_CELL_DIRECT_MOUNT,
> +	AFS_LOOKUP_CELL_PRELOAD,
> +	AFS_LOOKUP_CELL_ROOTCELL,
> +	AFS_LOOKUP_CELL_ALIAS_CHECK,
> +};
>  struct afs_cell *afs_lookup_cell(struct afs_net *net,
>  				 const char *name, unsigned int namesz,
> -				 const char *vllist, bool excl,
> +				 const char *vllist,
> +				 enum afs_lookup_cell_for reason,
>  				 enum afs_cell_trace trace);
>  extern struct afs_cell *afs_use_cell(struct afs_cell *, enum afs_cell_tr=
ace);
>  void afs_unuse_cell(struct afs_cell *cell, enum afs_cell_trace reason);
> diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
> index 1ad048e6e164..57c204a3c04e 100644
> --- a/fs/afs/mntpt.c
> +++ b/fs/afs/mntpt.c
> @@ -107,7 +107,8 @@ static int afs_mntpt_set_params(struct fs_context *fc=
, struct dentry *mntpt)
>  		if (size > AFS_MAXCELLNAME)
>  			return -ENAMETOOLONG;
> =20
> -		cell =3D afs_lookup_cell(ctx->net, p, size, NULL, false,
> +		cell =3D afs_lookup_cell(ctx->net, p, size, NULL,
> +				       AFS_LOOKUP_CELL_MOUNTPOINT,
>  				       afs_cell_trace_use_lookup_mntpt);
>  		if (IS_ERR(cell)) {
>  			pr_err("kAFS: unable to lookup cell '%pd'\n", mntpt);
> diff --git a/fs/afs/proc.c b/fs/afs/proc.c
> index 40e879c8ca77..44520549b509 100644
> --- a/fs/afs/proc.c
> +++ b/fs/afs/proc.c
> @@ -122,7 +122,8 @@ static int afs_proc_cells_write(struct file *file, ch=
ar *buf, size_t size)
>  	if (strcmp(buf, "add") =3D=3D 0) {
>  		struct afs_cell *cell;
> =20
> -		cell =3D afs_lookup_cell(net, name, strlen(name), args, true,
> +		cell =3D afs_lookup_cell(net, name, strlen(name), args,
> +				       AFS_LOOKUP_CELL_PRELOAD,
>  				       afs_cell_trace_use_lookup_add);
>  		if (IS_ERR(cell)) {
>  			ret =3D PTR_ERR(cell);
> diff --git a/fs/afs/super.c b/fs/afs/super.c
> index 9b1d8ac39261..354090b3a7e7 100644
> --- a/fs/afs/super.c
> +++ b/fs/afs/super.c
> @@ -305,7 +305,7 @@ static int afs_parse_source(struct fs_context *fc, st=
ruct fs_parameter *param)
>  	/* lookup the cell record */
>  	if (cellname) {
>  		cell =3D afs_lookup_cell(ctx->net, cellname, cellnamesz,
> -				       NULL, false,
> +				       NULL, AFS_LOOKUP_CELL_DIRECT_MOUNT,
>  				       afs_cell_trace_use_lookup_mount);
>  		if (IS_ERR(cell)) {
>  			pr_err("kAFS: unable to lookup cell '%*.*s'\n",
> diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
> index 709b4cdb723e..fc9676abd252 100644
> --- a/fs/afs/vl_alias.c
> +++ b/fs/afs/vl_alias.c
> @@ -269,7 +269,8 @@ static int yfs_check_canonical_cell_name(struct afs_c=
ell *cell, struct key *key)
>  	if (!name_len || name_len > AFS_MAXCELLNAME)
>  		master =3D ERR_PTR(-EOPNOTSUPP);
>  	else
> -		master =3D afs_lookup_cell(cell->net, cell_name, name_len, NULL, false=
,
> +		master =3D afs_lookup_cell(cell->net, cell_name, name_len, NULL,
> +					 AFS_LOOKUP_CELL_ALIAS_CHECK,
>  					 afs_cell_trace_use_lookup_canonical);
>  	kfree(cell_name);
>  	if (IS_ERR(master))



Tested-by: Markus Suvanto <markus.suvanto@gmail.com>

