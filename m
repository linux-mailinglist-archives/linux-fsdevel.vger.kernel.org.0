Return-Path: <linux-fsdevel+bounces-74302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF080D392D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 06:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 632BC3013C4B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 05:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A863126CA;
	Sun, 18 Jan 2026 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEIbQJY+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DBB2EC095
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768712472; cv=none; b=D9lSGMiV77/nixhqEPu5PF5j+Xrb7CanT4QDwPfh9T6FsFUlMBk+zcqaILwLfS1pfEVv5wbHGlTFFzESLeq2HFVQoytwUd+Yluavf2gfopPjsVWpLsxGCJ31HcIn+mX4MrCBoX5vDUDQjNLEn5S5yqBjFk4EUQf0JOmhUlW/t5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768712472; c=relaxed/simple;
	bh=Fj5bgVc/zFfWNfWOwNji7V9vGFB2kuEn4NabgB2F58A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFfRRGLS5ZOhYpR8QpyaqAH3HqNdvr+5y26iLql0yMbn/Px4bPbZweXwuUdeBsy0Wx76B9gEAY4foGyRl5rXr1DUmIoJ1p0MR4Ynqh5r/f9BBQZi0J+va3A5Q/uemyCaWa6Dg8tYQ8/vgyRMsQ1G+sA2R78f8rKJFNQMGIhTNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEIbQJY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C37C2BC87
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768712471;
	bh=Fj5bgVc/zFfWNfWOwNji7V9vGFB2kuEn4NabgB2F58A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WEIbQJY+pVAyFPp4he7RaDMxgkoOJiE1kYbSvIGyTGFOToqu/rXRmJ1EGIwrWhlF9
	 U6yzjSMTDdIIetLkYhfxnwjZow/FZy2Xy2qAE/mwgUf7QSNjzbmIJJ9019cnODmsZ5
	 wnPOP2kylOKA8sSfRBFYhcKCV6x+zN7W4+Q/Z2UKoyDAKA8gK0KZZXmODBUDUyo1+6
	 Q2VK7GmAXHNbQ7NuBN2ZMijFkZXOGfDqIu7iH2bX7gYK01lUf/k9bjMiD8QtbCt4bN
	 mQ/K0LpJY3AO4I+fVuijkYsw1jmcmkpyshEPy+2VtrZ81mhhhC/G8ZcNiFKjioQEEK
	 L7pnfNH7LL9PA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so6228291a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 21:01:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMsSBFaXkqRkthFnnv+slF6pL1BJK7z+vu0MRxzqngI/G+pv2dIjtjQwpe0qm75M6iM5TaW+Hgs3NmIRpn@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6KegWm5YrQ2PRUziYmFa8Ldn4ja8AuU6LCBK8itIAa3Acj6m
	mKfMXqUFihPjkTDMlLtXVDPYOeh8arBWWDltb7hH9enTZwGy0apgkGoWuK56T3+iqzdq0ZRac81
	dtVCaKsaci5WJFsq2rt8NqGydHjpHtQM=
X-Received: by 2002:a05:6402:40d1:b0:64d:540e:c68e with SMTP id
 4fb4d7f45d1cf-65452bcc2bdmr5765061a12.26.1768712469866; Sat, 17 Jan 2026
 21:01:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-12-linkinjeon@kernel.org>
 <20260116092833.GB21396@lst.de>
In-Reply-To: <20260116092833.GB21396@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 18 Jan 2026 14:00:57 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9zzgaWzdi6uz+NtkdUSeKWzgbZxqnkLGoF4vDWHXtmog@mail.gmail.com>
X-Gm-Features: AZwV_QjoK2kARk85rW1iBU9vVFXtTLNHbRhfMxsiHmg9jM4QYigq-bjygwcgegQ
Message-ID: <CAKYAXd9zzgaWzdi6uz+NtkdUSeKWzgbZxqnkLGoF4vDWHXtmog@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] ntfs: update misc operations
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 6:28=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Jan 11, 2026 at 11:03:41PM +0900, Namjae Jeon wrote:
> > +     if ((data1_len !=3D data2_len) || (data1_len <=3D 0) || (data1_le=
n & 3)) {
>
> Nit: all the inner braces are superfluous.
>
> Also why allow passing negative values at all and not pass unsigned
> length values?
Right, I will fix it.
>
> > +             ntfs_error(vol->sb, "data1_len or data2_len not valid\n")=
;
> > +             return -1;
> > +     }
> > +
> > +     p1 =3D (const __le32 *)data1;
> > +     p2 =3D (const __le32 *)data2;
> > +     len =3D data1_len;
>
> I don't think any of these casts is needed.  Also the variables could
> easily be initialized at declaration time.
agreed. I will fix it.
>
> > +     do {
> > +             d1 =3D le32_to_cpup(p1);
> > +             p1++;
> > +             d2 =3D le32_to_cpup(p2);
> > +             p2++;
> > +     } while ((d1 =3D=3D d2) && ((len -=3D 4) > 0));
>
> More superfluous races.
Okay.
>
> > +     if (d1 < d2)
> > +             rc =3D -1;
> >
> > +     else {
> > +             if (d1 =3D=3D d2)
> > +                     rc =3D 0;
> > +             else
> > +                     rc =3D 1;
> > +     }
> > +     ntfs_debug("Done, returning %i.", rc);
> > +     return rc;
>
> Just return directly using cmp_int() and skip the very verbose debugging?
Okay.
>
>         return cmp_int(d1, d2);
>
> > +/**
> > + * ntfs_collate_file_name - Which of two filenames should be listed fi=
rst
> > + */
> > +static int ntfs_collate_file_name(struct ntfs_volume *vol,
> > +             const void *data1, const int __always_unused data1_len,
> > +             const void *data2, const int __always_unused data2_len)
>
> Do we need these annotations for indirectly called callbacks now?
Okay, I will remove them.
>
> > +     if (cr !=3D COLLATION_BINARY && cr !=3D COLLATION_NTOFS_ULONG &&
> > +         cr !=3D COLLATION_FILE_NAME && cr !=3D COLLATION_NTOFS_ULONGS=
)
> > +             return -EINVAL;
>
> Turn this into a switch to make it more obvious?
Okay.
>
> > +
> >       i =3D le32_to_cpu(cr);
> > -     BUG_ON(i < 0);
> > +     if (i < 0)
> > +             return -1;
> >       if (i <=3D 0x02)
> >               return ntfs_do_collate0x0[i](vol, data1, data1_len,
> >                               data2, data2_len);
> > -     BUG_ON(i < 0x10);
> > +     if (i < 0x10)
> > +             return -1;
> >       i -=3D 0x10;
> >       if (likely(i <=3D 3))
> >               return ntfs_do_collate0x1[i](vol, data1, data1_len,
> >                               data2, data2_len);
> > -     BUG();
>
> .. and then maybe use the switch to untangle this as well, which
> smells like just a bit too much deep magic..
Okay, I will do that.
>
> > -void __ntfs_error(const char *function, const struct super_block *sb,
> > +void __ntfs_error(const char *function, struct super_block *sb,
>
> Why does this drop the const?
The const was dropped because __ntfs_error() calls
ntfs_handle_error(), which can modify sb->s_flags.
>
> > +#ifndef DEBUG
> > +     if (sb)
> > +             pr_err_ratelimited("(device %s): %s(): %pV\n",
> > +                    sb->s_id, flen ? function : "", &vaf);
> > +     else
> > +             pr_err_ratelimited("%s(): %pV\n", flen ? function : "", &=
vaf);
> > +#else
> >       if (sb)
> >               pr_err("(device %s): %s(): %pV\n",
> >                      sb->s_id, flen ? function : "", &vaf);
> >       else
> >               pr_err("%s(): %pV\n", flen ? function : "", &vaf);
> > +#endif
>
> Usually if you have cpp conditions with an else, I'd use ifdef instead
> of the negated version.
Okay, I will fix it.
Thanks for the review!
>

