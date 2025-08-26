Return-Path: <linux-fsdevel+bounces-59151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4604FB35108
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 03:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F47F7A5C97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 01:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DF11E260A;
	Tue, 26 Aug 2025 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tIhx/ecN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dLBCqLWY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tIhx/ecN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dLBCqLWY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F910191F84
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172086; cv=none; b=k7zW3e9Bq9evJi3O/iMXXPCOD9pA9YnpM+U5xJJ5UbXaZq/+eY+PWcVk6TMljYAlPV326o4TGFFKRl7v81TvIjSy/8jmezAoZPmfwG28sg4uTCsQ5L7Fqivtz78nkY3SqPbiqD58C2hYV3x715tpyE89F7MkMDSVYTu3XHrj1pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172086; c=relaxed/simple;
	bh=1ODpnc6C8gY4QAQvtxMyl7chRw4iJGQvqewebENgdBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p7luS6HQO9rEgeg2w0TE++2B9va4zrwIV5tEDyODFNT5o8H/L193zYRU4hXVZs7qeLZJeMgL9NO9HE64DOjotY6RcfWBknlt5LeLDV9WHx1SpULot0ujpLQf91+Ho8yuBfGCtqPVEgUxNpglM8rZaRwh4c/1vNOy+Xoy+Mj/rLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tIhx/ecN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dLBCqLWY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tIhx/ecN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dLBCqLWY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 535EE21191;
	Tue, 26 Aug 2025 01:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756172081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHvHcw3Z/vFZJd6svodwbRUo8SUNrPMHM72Hc/AOxbY=;
	b=tIhx/ecNkC/amFqXA4LwBvGplspKJbV8/Z608EJo7zxtCnDTR95WeVgQXgJLBui4Pa1D/P
	lOnfoSJpN4mkEaT7N73HQ62tVxSxM7kHrznltIKOqM+yAd9hGFEpqV3oMRxEeK7059gKvQ
	RqoYS2KiQBHPCyb9K5aCE5ZhhXY+Crw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756172081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHvHcw3Z/vFZJd6svodwbRUo8SUNrPMHM72Hc/AOxbY=;
	b=dLBCqLWY3izrK/bPtKSs8Tsz6fMZGVcO0JPsvPqIqNWP/qZc2Rwsan0Y24cGkaOhoVytlk
	zQguy6mKnJ4hEDCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756172081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHvHcw3Z/vFZJd6svodwbRUo8SUNrPMHM72Hc/AOxbY=;
	b=tIhx/ecNkC/amFqXA4LwBvGplspKJbV8/Z608EJo7zxtCnDTR95WeVgQXgJLBui4Pa1D/P
	lOnfoSJpN4mkEaT7N73HQ62tVxSxM7kHrznltIKOqM+yAd9hGFEpqV3oMRxEeK7059gKvQ
	RqoYS2KiQBHPCyb9K5aCE5ZhhXY+Crw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756172081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHvHcw3Z/vFZJd6svodwbRUo8SUNrPMHM72Hc/AOxbY=;
	b=dLBCqLWY3izrK/bPtKSs8Tsz6fMZGVcO0JPsvPqIqNWP/qZc2Rwsan0Y24cGkaOhoVytlk
	zQguy6mKnJ4hEDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E931813697;
	Tue, 26 Aug 2025 01:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AYLtLTAPrWidZgAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 26 Aug 2025 01:34:40 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,  Miklos Szeredi
 <miklos@szeredi.hu>,  Theodore Tso <tytso@mit.edu>,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  kernel-dev@igalia.com
Subject: Re: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded
 strncmp()
In-Reply-To: <871poz4983.fsf@mailhost.krisman.be> (Gabriel Krisman Bertazi's
	message of "Mon, 25 Aug 2025 13:11:40 -0400")
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
	<20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com>
	<875xeb64ks.fsf@mailhost.krisman.be>
	<CAOQ4uxiHQx=_d_22RBUvr9FSbtF-+DJMnoRi0QnODXRR=c47gA@mail.gmail.com>
	<CAOQ4uxgaefXzkjpHgjL0AZrOn_ZMP=b1TKp-KDh53q-4borUZw@mail.gmail.com>
	<871poz4983.fsf@mailhost.krisman.be>
Date: Mon, 25 Aug 2025 21:34:35 -0400
Message-ID: <87plci3lxw.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

Gabriel Krisman Bertazi <gabriel@krisman.be> writes:

> Amir Goldstein <amir73il@gmail.com> writes:
>
>> On Mon, Aug 25, 2025 at 5:27=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
>>>
>>> On Mon, Aug 25, 2025 at 1:09=E2=80=AFPM Gabriel Krisman Bertazi
>>> <gabriel@krisman.be> wrote:
>>> >
>>> > Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:
>>> >
>>> > > To add overlayfs support casefold layers, create a new function
>>> > > ovl_casefold(), to be able to do case-insensitive strncmp().
>>> > >
>>> > > ovl_casefold() allocates a new buffer and stores the casefolded ver=
sion
>>> > > of the string on it. If the allocation or the casefold operation fa=
ils,
>>> > > fallback to use the original string.
>>> > >
>>> > > The case-insentive name is then used in the rb-tree search/insertion
>>> > > operation. If the name is found in the rb-tree, the name can be
>>> > > discarded and the buffer is freed. If the name isn't found, it's th=
en
>>> > > stored at struct ovl_cache_entry to be used later.
>>> > >
>>> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>>> > > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>>> > > ---
>>> > > Changes from v6:
>>> > >  - Last version was using `strncmp(... tmp->len)` which was causing
>>> > >    regressions. It should be `strncmp(... len)`.
>>> > >  - Rename cf_len to c_len
>>> > >  - Use c_len for tree operation: (cmp < 0 || len < tmp->c_len)
>>> > >  - Remove needless kfree(cf_name)
>>> > > ---
>>> > >  fs/overlayfs/readdir.c | 113 +++++++++++++++++++++++++++++++++++++=
+++---------
>>> > >  1 file changed, 94 insertions(+), 19 deletions(-)
>>> > >
>>> > > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
>>> > > index b65cdfce31ce27172d28d879559f1008b9c87320..dfc661b7bc3f87efbf1=
4991e97cee169400d823b 100644
>>> > > --- a/fs/overlayfs/readdir.c
>>> > > +++ b/fs/overlayfs/readdir.c
>>> > > @@ -27,6 +27,8 @@ struct ovl_cache_entry {
>>> > >       bool is_upper;
>>> > >       bool is_whiteout;
>>> > >       bool check_xwhiteout;
>>> > > +     const char *c_name;
>>> > > +     int c_len;
>>> > >       char name[];
>>> > >  };
>>> > >
>>> > > @@ -45,6 +47,7 @@ struct ovl_readdir_data {
>>> > >       struct list_head *list;
>>> > >       struct list_head middle;
>>> > >       struct ovl_cache_entry *first_maybe_whiteout;
>>> > > +     struct unicode_map *map;
>>> > >       int count;
>>> > >       int err;
>>> > >       bool is_upper;
>>> > > @@ -66,6 +69,27 @@ static struct ovl_cache_entry *ovl_cache_entry_f=
rom_node(struct rb_node *n)
>>> > >       return rb_entry(n, struct ovl_cache_entry, node);
>>> > >  }
>>> > >
>>> > > +static int ovl_casefold(struct unicode_map *map, const char *str, =
int len, char **dst)
>>> > > +{
>>> > > +     const struct qstr qstr =3D { .name =3D str, .len =3D len };
>>> > > +     int cf_len;
>>> > > +
>>> > > +     if (!IS_ENABLED(CONFIG_UNICODE) || !map || is_dot_dotdot(str,=
 len))
>>> > > +             return 0;
>>> > > +
>>> > > +     *dst =3D kmalloc(NAME_MAX, GFP_KERNEL);
>>> > > +
>>> > > +     if (dst) {
>>> > > +             cf_len =3D utf8_casefold(map, &qstr, *dst, NAME_MAX);
>>> > > +
>>> > > +             if (cf_len > 0)
>>> > > +                     return cf_len;
>>> > > +     }
>>> > > +
>>> > > +     kfree(*dst);
>>> > > +     return 0;
>>> > > +}
>>> >
>>> > Hi,
>>> >
>>> > I should just note this does not differentiates allocation errors from
>>> > casefolding errors (invalid encoding).  It might be just a theoretical
>>> > error because GFP_KERNEL shouldn't fail (wink, wink) and the rest of =
the
>>> > operation is likely to fail too, but if you have an allocation failur=
e, you
>>> > can end up with an inconsistent cache, because a file is added under =
the
>>> > !casefolded name and a later successful lookup will look for the
>>> > casefolded version.
>>>
>>> Good point.
>>> I will fix this in my tree.
>>
>> wait why should we not fail to fill the cache for both allocation
>> and encoding errors?
>>
>
> We shouldn't fail the cache for encoding errors, just for allocation erro=
rs.
>
> Perhaps I am misreading the code, so please correct me if I'm wrong.  if
> ovl_casefold fails, the non-casefolded name is used in the cache.  That
> makes sense if the reason utf8_casefold failed is because the string
> cannot be casefolded (i.e. an invalid utf-8 string). For those strings,
> everything is fine.  But on an allocation failure, the string might have
> a real casefolded version.  If we fallback to the original string as the
> key, a cache lookup won't find the entry, since we compare with memcmp.

I was thinking again about this and I suspect I misunderstood your
question.  let me try to answer it again:

Ext4, f2fs and tmpfs all allow invalid utf8-encoded strings in a
casefolded directory when running on non-strict-mode.  They are treated
as non-encoded byte-sequences, as if they were seen on a case-Sensitive
directory.  They can't collide with other filenames because they
basically "fold" to themselves.

Now I suspect there is another problem with this series: I don't see how
it implements the semantics of strict mode.  What happens if upper and
lower are in strict mode (which is valid, same encoding_flags) but there
is an invalid name in the lower?  overlayfs should reject the dentry,
because any attempt to create it to the upper will fail.

Andr=C3=A9, did you consider this scenario?  You can test by creating a file
with an invalid-encoded name in a casefolded directory of a
non-strict-mode filesystem and then flip the strict-mode flag in the
superblock.  I can give it a try tomorrow too.

Thanks,

--=20
Gabriel Krisman Bertazi

