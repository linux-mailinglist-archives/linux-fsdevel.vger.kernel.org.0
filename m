Return-Path: <linux-fsdevel+bounces-62271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE71CB8BA7A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 02:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06293B0024
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 00:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7AE2D8384;
	Sat, 20 Sep 2025 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="lX13+wix";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XgU0ovni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6032A2D7DF1
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Sep 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326416; cv=none; b=oOaqQOuhvOTpeYn762lfe6c8jn4woN3KpdCEfvqBal8tNoC5QYDo7sRgKiRKwGr42n96t0DxAtn9CWzBQVEWySRI2Gpfw39qntJuWGHHgDQgmXJPKQChNk+7nYe6lvL+U+vhUTL9cB9WhmcAIzBv5yFV7baFXro28xU2ungwgbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326416; c=relaxed/simple;
	bh=626BF3DV0/R7h0G+vY/iKkdnWOGZWgUFOi5Awzp/Og0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TWhjtDIPqkZduPUzGoK72eRXjAf4/CiDuYPzleTusqxGv7jOQnbckW6YhecCV6Cgopksyqxn8qGGuH4doxEynALS57tMLb/8HQKNAO8YhKUT8IsiHSczxdC9fLelvL281BY2Fn3zCZ7omLmhwMDU1qk/BHle/1vn+jqWj8Wbad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=lX13+wix; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XgU0ovni; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 42D0B7A01CB;
	Fri, 19 Sep 2025 20:00:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 19 Sep 2025 20:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758326412; x=1758412812; bh=o/7621/OW59yQv8KFmkkC9vGm4cXpFyikMe
	djJ80Xxk=; b=lX13+wixbmRLC8UkehsvtrsGQg5Aiu6BTLDcKCgbEY47nzuiOxk
	TTpm2OlyUGm//q87buSi0YfmNH9hiFRigJdjOc/GIgurcl5m+MHaE8KG28XesdTb
	90bxyuIvItBmcl2iNU0HYL/gWoLqs1ln2fi63UQz86Y/JI+SJkqxLfx3LbesS5tb
	EMqNZzfanJz7pXAX/rO0EeCQtMg24arZbuXcy+TDJstOpbUhBApj+4VHCHeVbECe
	6foaqEyLOJVZjSuq+K4VIVWw5R6mvpHrp0Ocx7J7xsJpey6qy/rcpKGE1cBYW2q2
	GPEDH58NsgPbwEdwGRJDFiN48dIRyFMxH6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758326412; x=
	1758412812; bh=o/7621/OW59yQv8KFmkkC9vGm4cXpFyikMedjJ80Xxk=; b=X
	gU0ovnicdzNxvs8R4WsBanKfGyz0UiE4ScfKK5TMRcmCC8NxMN0EkrrBPgUz/s43
	zr6luouSm0UG6o4sOdgFVJY3Mx+jIGUHQu9QDGalfiE2t2RZ6m5RByyqkYBHPMlF
	++nUOfPJ8TqhV44S5ktvaY6NDaNW/FI1oZ1v44eWyu6tnJRjF9ZTWczhStsJFiyd
	KtWTkPQneGH3n8+JYUvlv0W9fF+OoqqRSFx9M+y5P+2K86yaA/WmaxS/4CfIsNwC
	segZe8sXGd1yzJ2mXhAvaGmeI4sj3nae9zFFQazSuoq5jNUAoUfdxX1R18Pdct8U
	onAP1UickR0PDWasA26kQ==
X-ME-Sender: <xms:i-7NaKFl4HTecx7p1pEuvC1uj-sbxtYrPAGwqw-dq1OWz-kzrDkq0Q>
    <xme:i-7NaGP1GBtJaf9ylpfuzt8ius5tB5ifm0Mz0_olUt-KeSvQQR2Qi9nI5a7Alh4w3
    eX46AeaOE8Hfw>
X-ME-Received: <xmr:i-7NaL8timoQYmE_Wqn-h2PutiXoSNax60T37HtBN5qSXqp5IDoyKs10EpKFsPcmOqK7CsIeFWybPPW-Ld4BwZvivGZBLvIuk0hBD9GjBPCa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmshiivghrvgguihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:i-7NaCQi7b0NP510ZfRYWcYVyv9lZ69ara9GA9Tjr0_GzNZ91LaafA>
    <xmx:i-7NaFnv83RQ8DBEN1k2BX6d8kd7hSKGSbFlEoo5hN6TjTt12zgT4w>
    <xmx:i-7NaKQUNHZod3Gl4jCKuUXH5etvZStKxbQAiZDw5LlSer-JgUyafg>
    <xmx:i-7NaLNvfqyy0UKCD63lHjAgrkeKlcMXKU-UZNARx1YljCPtDQSZ6Q>
    <xmx:jO7NaAXNX9xxh2htTO8gIdhjNZnFQ3uoSG6zFPK_ShWj06YJ_LMYolYT>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 20:00:10 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Miklos Szeredi" <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, "Al Viro" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH] namei: fix revalidate vs. rename race
In-reply-to: <20250919081843.522786-1-mszeredi@redhat.com>
References: <20250919081843.522786-1-mszeredi@redhat.com>
Date: Sat, 20 Sep 2025 10:00:03 +1000
Message-id: <175832640326.1696783.9546171210030422213@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 19 Sep 2025, Miklos Szeredi wrote:
> If a path component is revalidated while a rename is in progress the
> filesystem might find the already exchanged files, while the kernel still
> has the old ones in dcache (d_revalidate may be called without any locks).
> This mismatch will cause the dentry to be invalidated (unhashed), resulting
> in "(deleted)" being appended to proc paths and submounts unmounted.
>=20
> Another race introduced by commit 5be1fa8abd7b ("Pass parent directory
> inode and expected name to ->d_revalidate()") is that the name passed to
> revalidate can be stale (rename succeeded after the dentry was looked up in
> the dcache).
>=20
> Solve this by
>=20
>  a) samping dentry->d_seq when the dentry is looked up from the cache
>=20
>  b) setting a DCACHE_RENAMING flag on the dentry during rename
>=20
>  c) verifying in d_invalidate() that the sequence number is unchanged and
>     no rename is happening
>=20
> This should also fix race with d_splice_alias() moving the dentry.

I think this makes sense.  The DCACHE_RENAMING flag is a good solution
of the fact that d_seq isn't changed until *after* the rename has
happened on the server.

However this change means that the dentry isn't invalidated where the
code currently expects that it will be.  i.e.  lookup_dcache() can
return NULL when there is still a perfectly valid dentry.
Does this matter?
It can only happen when the parent isn't locked and when it does happen,
current code will lock that parent and repeat the lookup.
So if we simplified the change to only call d_invalidate() if we have
the parent locked, then that will almost work.

The remaining gap is that directories can be renamed by d_splice_alias()
while the parent is locked shared.  I think that is a different problem
that would be best served with a different, more focused, solution.

So, at present, I would be in favour of duplicating lookup_dcache() to
lookup_dcache_locked() and call lookup_dcache() only when parent isn't
locked.
Then removed the d_invalidate() calls after a failing d_revalidate() in
cases where the parent isn't locked.

I think that is a simple solution that gets us most of what we need.

Then we can dig more into what we really want when a directory gets
moved on the server and how that gets noticed.

Thanks,
NeilBrown


>=20
> Suggested-by: NeilBrown <neil@brown.name>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/dcache.c            | 81 +++++++++++++++++++++++++++++++++++-------
>  fs/internal.h          |  3 +-
>  fs/namei.c             | 41 +++++++++++++++++----
>  include/linux/dcache.h |  5 +++
>  4 files changed, 110 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 60046ae23d51..60beeccf6bff 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1636,14 +1636,10 @@ static enum d_walk_ret find_submount(void *_data, s=
truct dentry *dentry)
>  	return D_WALK_CONTINUE;
>  }
> =20
> -/**
> - * d_invalidate - detach submounts, prune dcache, and drop
> - * @dentry: dentry to invalidate (aka detach, prune and drop)
> - */
> -void d_invalidate(struct dentry *dentry)
> +static void d_invalidate_locked(struct dentry *dentry)
>  {
>  	bool had_submounts =3D false;
> -	spin_lock(&dentry->d_lock);
> +
>  	if (d_unhashed(dentry)) {
>  		spin_unlock(&dentry->d_lock);
>  		return;
> @@ -1669,8 +1665,47 @@ void d_invalidate(struct dentry *dentry)
>  		dput(victim);
>  	}
>  }
> +
> +/**
> + * d_invalidate - detach submounts, prune dcache, and drop
> + * @dentry: dentry to invalidate (aka detach, prune and drop)
> + */
> +void d_invalidate(struct dentry *dentry)
> +{
> +	spin_lock(&dentry->d_lock);
> +	d_invalidate_locked(dentry);
> +}
>  EXPORT_SYMBOL(d_invalidate);
> =20
> +/**
> + * d_invalidate_reval - conditionally invalidate a dentry for revalidation
> + * @dentry: dentry to conditionally invalidate
> + * @seq: sequence number sampled during dentry lookup
> + *
> + * Check if the dentry has been renamed since the sequence number was samp=
led
> + * or if it's currently being renamed. If either condition is true, skip t=
he
> + * invalidation to avoid the race between dentry revalidation and renames.
> + */
> +void d_invalidate_reval(struct dentry *dentry, unsigned int seq)
> +{
> +	spin_lock(&dentry->d_lock);
> +
> +	/* Check if dentry is currently being renamed */
> +	if (dentry->d_flags & DCACHE_RENAMING) {
> +		spin_unlock(&dentry->d_lock);
> +		return;
> +	}
> +
> +	/* Check if dentry sequence has changed since sampling */
> +	if (read_seqcount_retry(&dentry->d_seq, seq)) {
> +		spin_unlock(&dentry->d_lock);
> +		return;
> +	}
> +
> +	/* Safe to invalidate - no rename race detected */
> +	d_invalidate_locked(dentry);
> +}
> +
>  /**
>   * __d_alloc	-	allocate a dcache entry
>   * @sb: filesystem it will belong to
> @@ -2329,19 +2364,24 @@ struct dentry *__d_lookup_rcu(const struct dentry *=
parent,
>   * dentry is returned. The caller must use dput to free the entry when it =
has
>   * finished using it. %NULL is returned if the dentry does not exist.
>   */
> -struct dentry *d_lookup(const struct dentry *parent, const struct qstr *na=
me)
> +struct dentry *d_lookup_seq(const struct dentry *parent, const struct qstr=
 *name, unsigned int *d_seq)
>  {
>  	struct dentry *dentry;
>  	unsigned seq;
> =20
>  	do {
>  		seq =3D read_seqbegin(&rename_lock);
> -		dentry =3D __d_lookup(parent, name);
> +		dentry =3D __d_lookup(parent, name, d_seq);
>  		if (dentry)
>  			break;
>  	} while (read_seqretry(&rename_lock, seq));
>  	return dentry;
>  }
> +
> +struct dentry *d_lookup(const struct dentry *parent, const struct qstr *na=
me)
> +{
> +	return d_lookup_seq(parent, name, NULL);
> +}
>  EXPORT_SYMBOL(d_lookup);
> =20
>  /**
> @@ -2359,7 +2399,8 @@ EXPORT_SYMBOL(d_lookup);
>   *
>   * __d_lookup callers must be commented.
>   */
> -struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *=
name)
> +struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *=
name,
> +			  unsigned int *seq)
>  {
>  	unsigned int hash =3D name->hash;
>  	struct hlist_bl_head *b =3D d_hash(hash);
> @@ -2404,6 +2445,8 @@ struct dentry *__d_lookup(const struct dentry *parent=
, const struct qstr *name)
>  			goto next;
> =20
>  		dentry->d_lockref.count++;
> +		if (seq)
> +			*seq =3D raw_seqcount_begin(&dentry->d_seq);
>  		found =3D dentry;
>  		spin_unlock(&dentry->d_lock);
>  		break;
> @@ -2539,9 +2582,10 @@ static void d_wait_lookup(struct dentry *dentry)
>  	}
>  }
> =20
> -struct dentry *d_alloc_parallel(struct dentry *parent,
> -				const struct qstr *name,
> -				wait_queue_head_t *wq)
> +struct dentry *__d_alloc_parallel(struct dentry *parent,
> +				  const struct qstr *name,
> +				  wait_queue_head_t *wq,
> +				  unsigned int *seqp)
>  {
>  	unsigned int hash =3D name->hash;
>  	struct hlist_bl_head *b =3D in_lookup_hash(parent, hash);
> @@ -2575,6 +2619,8 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>  			goto retry;
>  		}
>  		rcu_read_unlock();
> +		if (seqp)
> +			*seqp =3D d_seq;
>  		dput(new);
>  		return dentry;
>  	}
> @@ -2637,6 +2683,8 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>  		if (unlikely(!d_same_name(dentry, parent, name)))
>  			goto mismatch;
>  		/* OK, it *is* a hashed match; return it */
> +		if (seqp)
> +			*seqp =3D read_seqcount_begin(&dentry->d_seq);
>  		spin_unlock(&dentry->d_lock);
>  		dput(new);
>  		return dentry;
> @@ -2645,12 +2693,21 @@ struct dentry *d_alloc_parallel(struct dentry *pare=
nt,
>  	new->d_wait =3D wq;
>  	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
>  	hlist_bl_unlock(b);
> +	if (seqp)
> +		*seqp =3D read_seqcount_begin(&new->d_seq);
>  	return new;
>  mismatch:
>  	spin_unlock(&dentry->d_lock);
>  	dput(dentry);
>  	goto retry;
>  }
> +
> +struct dentry *d_alloc_parallel(struct dentry *parent,
> +				const struct qstr *name,
> +				wait_queue_head_t *wq)
> +{
> +	return __d_alloc_parallel(parent, name, wq, NULL);
> +}
>  EXPORT_SYMBOL(d_alloc_parallel);
> =20
>  /*
> diff --git a/fs/internal.h b/fs/internal.h
> index 38e8aab27bbd..99743525a24a 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -224,7 +224,8 @@ extern char *simple_dname(struct dentry *, char *, int);
>  extern void dput_to_list(struct dentry *, struct list_head *);
>  extern void shrink_dentry_list(struct list_head *);
>  extern void shrink_dcache_for_umount(struct super_block *);
> -extern struct dentry *__d_lookup(const struct dentry *, const struct qstr =
*);
> +extern struct dentry *__d_lookup(const struct dentry *parent,
> +				const struct qstr *name, unsigned int *seq);
>  extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
>  				const struct qstr *name, unsigned *seq);
>  extern void d_genocide(struct dentry *);
> diff --git a/fs/namei.c b/fs/namei.c
> index cd43ff89fbaa..e6fcdc60f075 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1652,12 +1652,15 @@ static struct dentry *lookup_dcache(const struct qs=
tr *name,
>  				    struct dentry *dir,
>  				    unsigned int flags)
>  {
> -	struct dentry *dentry =3D d_lookup(dir, name);
> +	struct dentry *dentry;
> +	unsigned int seq;
> +
> +	dentry =3D d_lookup_seq(dir, name, &seq);
>  	if (dentry) {
>  		int error =3D d_revalidate(dir->d_inode, name, dentry, flags);
>  		if (unlikely(error <=3D 0)) {
>  			if (!error)
> -				d_invalidate(dentry);
> +				d_invalidate_reval(dentry, seq);
>  			dput(dentry);
>  			return ERR_PTR(error);
>  		}
> @@ -1763,14 +1766,14 @@ static struct dentry *lookup_fast(struct nameidata =
*nd)
>  			status =3D d_revalidate(nd->inode, &nd->last,
>  					      dentry, nd->flags);
>  	} else {
> -		dentry =3D __d_lookup(parent, &nd->last);
> +		dentry =3D __d_lookup(parent, &nd->last, &nd->next_seq);
>  		if (unlikely(!dentry))
>  			return NULL;
>  		status =3D d_revalidate(nd->inode, &nd->last, dentry, nd->flags);
>  	}
>  	if (unlikely(status <=3D 0)) {
>  		if (!status)
> -			d_invalidate(dentry);
> +			d_invalidate_reval(dentry, nd->next_seq);
>  		dput(dentry);
>  		return ERR_PTR(status);
>  	}
> @@ -1784,20 +1787,21 @@ static struct dentry *__lookup_slow(const struct qs=
tr *name,
>  {
>  	struct dentry *dentry, *old;
>  	struct inode *inode =3D dir->d_inode;
> +	unsigned int seq;
>  	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
> =20
>  	/* Don't go there if it's already dead */
>  	if (unlikely(IS_DEADDIR(inode)))
>  		return ERR_PTR(-ENOENT);
>  again:
> -	dentry =3D d_alloc_parallel(dir, name, &wq);
> +	dentry =3D __d_alloc_parallel(dir, name, &wq, &seq);
>  	if (IS_ERR(dentry))
>  		return dentry;
>  	if (unlikely(!d_in_lookup(dentry))) {
>  		int error =3D d_revalidate(inode, name, dentry, flags);
>  		if (unlikely(error <=3D 0)) {
>  			if (!error) {
> -				d_invalidate(dentry);
> +				d_invalidate_reval(dentry, seq);
>  				dput(dentry);
>  				goto again;
>  			}
> @@ -4958,6 +4962,20 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, =
const char __user *, newname
>  	return do_linkat(AT_FDCWD, getname(oldname), AT_FDCWD, getname(newname), =
0);
>  }
> =20
> +static void dentry_set_renaming(struct dentry *dentry)
> +{
> +	spin_lock(&dentry->d_lock);
> +	dentry->d_flags |=3D DCACHE_RENAMING;
> +	spin_unlock(&dentry->d_lock);
> +}
> +
> +static void dentry_clear_renaming(struct dentry *dentry)
> +{
> +	spin_lock(&dentry->d_lock);
> +	dentry->d_flags &=3D ~DCACHE_RENAMING;
> +	spin_unlock(&dentry->d_lock);
> +}
> +
>  /**
>   * vfs_rename - rename a filesystem object
>   * @rd:		pointer to &struct renamedata info
> @@ -5126,10 +5144,15 @@ int vfs_rename(struct renamedata *rd)
>  		if (error)
>  			goto out;
>  	}
> +
> +	dentry_set_renaming(old_dentry);
> +	if (flags & RENAME_EXCHANGE)
> +		dentry_set_renaming(new_dentry);
> +
>  	error =3D old_dir->i_op->rename(rd->new_mnt_idmap, old_dir, old_dentry,
>  				      new_dir, new_dentry, flags);
>  	if (error)
> -		goto out;
> +		goto out_clear_renaming;
> =20
>  	if (!(flags & RENAME_EXCHANGE) && target) {
>  		if (is_dir) {
> @@ -5145,6 +5168,10 @@ int vfs_rename(struct renamedata *rd)
>  		else
>  			d_exchange(old_dentry, new_dentry);
>  	}
> +out_clear_renaming:
> +	dentry_clear_renaming(old_dentry);
> +	if (flags & RENAME_EXCHANGE)
> +		dentry_clear_renaming(new_dentry);
>  out:
>  	if (!is_dir || lock_old_subdir)
>  		inode_unlock(source);
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index cc3e1c1a3454..c9f415db243b 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -222,6 +222,7 @@ enum dentry_flags {
>  	DCACHE_PAR_LOOKUP		=3D BIT(24),	/* being looked up (with parent locked sh=
ared) */
>  	DCACHE_DENTRY_CURSOR		=3D BIT(25),
>  	DCACHE_NORCU			=3D BIT(26),	/* No RCU delay for freeing */
> +	DCACHE_RENAMING			=3D BIT(27),	/* dentry is being renamed */
>  };
> =20
>  #define DCACHE_MANAGED_DENTRY \
> @@ -243,6 +244,8 @@ extern struct dentry * d_alloc(struct dentry *, const s=
truct qstr *);
>  extern struct dentry * d_alloc_anon(struct super_block *);
>  extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr=
 *,
>  					wait_queue_head_t *);
> +extern struct dentry * __d_alloc_parallel(struct dentry *, const struct qs=
tr *,
> +					wait_queue_head_t *, unsigned int *);
>  extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
>  /* weird procfs mess; *NOT* exported */
>  extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
> @@ -256,6 +259,7 @@ extern struct dentry * d_obtain_root(struct inode *);
>  extern void shrink_dcache_sb(struct super_block *);
>  extern void shrink_dcache_parent(struct dentry *);
>  extern void d_invalidate(struct dentry *);
> +extern void d_invalidate_reval(struct dentry *, unsigned int);
> =20
>  /* only used at mount-time */
>  extern struct dentry * d_make_root(struct inode *);
> @@ -284,6 +288,7 @@ extern void d_exchange(struct dentry *, struct dentry *=
);
>  extern struct dentry *d_ancestor(struct dentry *, struct dentry *);
> =20
>  extern struct dentry *d_lookup(const struct dentry *, const struct qstr *);
> +extern struct dentry *d_lookup_seq(const struct dentry *parent, const stru=
ct qstr *name, unsigned int *d_seq);
> =20
>  static inline unsigned d_count(const struct dentry *dentry)
>  {
> --=20
> 2.51.0
>=20
>=20


