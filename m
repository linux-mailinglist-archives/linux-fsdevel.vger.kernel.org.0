Return-Path: <linux-fsdevel+bounces-27174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7843B95F290
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 15:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9DA1C21CED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45262185E7B;
	Mon, 26 Aug 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2aFi+kO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA7183CDA;
	Mon, 26 Aug 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678035; cv=none; b=MaE+grUPrJEEJMVMHdk3eOZ9e3pg0cx2Qd8eRUwajSOH+a5KCm0ADGSzJc/I6xLHFXXuQi92163T1AtDskj16pHx7pVNut4ij08+TX+KpL86m4ToCVo90r1sRPIJ8RCX0cgOX8m2AK8XarWPK3WjccDoMeVn9GN6fhd6I0Fa4uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678035; c=relaxed/simple;
	bh=uXndQDCUvnx0Z+cralt3H9P3W4x5FKSzMQBt52DRN90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbdsifLh+Bssk78WABghf0ZWcZlft1NCMo5ruWx+BdIOSp0jjY8SSJa1dGiGVwfjQNe6ylAQodlwTXOtw5aYRqwy/tRgDKjEcuMOxv6dXQUrO75ZzfF0qve0NAmOU1nJr4DtmAMBmjRMUlBg5jedcBn9S1RQjVD3DVyZMvpkYoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2aFi+kO; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bf7f4a133aso23042536d6.2;
        Mon, 26 Aug 2024 06:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724678033; x=1725282833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSwJhEnVRbE/lc1fBQhKHoYSdjJMMB9ydQkFXZg7Wl0=;
        b=G2aFi+kOco8F7A7ev4siqM77VYWHD1SS+N9xARzk9mXa5Z7M7vt+omxkuFb8DdcgF9
         zXPRGYJqqrzBLfS1Cas03+0K4qYSKwBBSFD6Bq8nRK5EbZZGNqT1lbQ/l6U/SvIXMV9j
         zAUTSlgkhhszD4hIHfQENG1EIfyG8eEdi7xPlkqHtO8XHwk4RVSJ1YKHnKCVfbqr2oh0
         94NBVtwYwm2YjN16k5guBkdrWHDmxpSOXoczIq3F3cCVhfkpkcuLHzyd3pFmkT7n5/8d
         nKZJUf38vCZMggus3JMlzpoKge0iV5vKealnTfCY5EFgt2EQ4Cr7H76zd3KoY9/DLw/N
         +WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724678033; x=1725282833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSwJhEnVRbE/lc1fBQhKHoYSdjJMMB9ydQkFXZg7Wl0=;
        b=gs+3hEUa9f7CI0POgR9qS3NcEjGNtCssdrN7CQtTayV1nVcalh9QryoctEctsPGZ7k
         TMnab61DgsArompmA7uydEewDQEVdPkhyEpACrVSA3cvM0VnmPbYy40RFSvY2dOjZix0
         EdNPod7kn1rKtxhD7lQbxdKtF58khDCTdW+g/43qcvg6OXDvoML/AyiuNFITehpqZSAT
         UN4ly2vaWvFM67ugLDggFVAFAsnj3XuMXyJpYUCBxSOfZkGZFpj7OSGmWjPFV4kOKFQb
         iYzV9BxXE4c2hXNxHU2OUvNHu/YZu/dTQUcGegzQQkp8GiisvUSsI0NTVD5txLNpIkV0
         6e7w==
X-Forwarded-Encrypted: i=1; AJvYcCU/ClygvLS3mjyt7se83bpFk5tbJjFXdDmm1opJ3v9PS74Ejhon0MuuTu2wAiMKGu+FIFeOQdbbiNK6yco6/saFzwWf@vger.kernel.org, AJvYcCU3p4xPq/zisqMnlMG5IMvdjAz49G7QtULEcD3tBDNl2cYIdDvsqvVN5mRDS4Q/D+T9BQ0+nTIX4e4JT/x7i8eS//EycQeV@vger.kernel.org, AJvYcCULhyl27VLZnSINwLuse687eE1Z/m7G6b14F1vuZoX3UfjlRC1VGsj4tKnVU5lwAM8UpJgpvX4GpMBrHPS8EA==@vger.kernel.org, AJvYcCUsKzmbvn/BTyybb5sUYnPxC7bFDTMi9woll1o+j9UMd+lscRYrkUkRc/R9eogDBA2XpB7rlnFj@vger.kernel.org, AJvYcCVzfSzxNbPxr0OBavXpBvqeNWuUQ2ESoDPgqDH6V7OwMSYs6YPgo18hAXk6YbSQSJwKoNgd@vger.kernel.org, AJvYcCWLflpr/Iba5wwF+1l+jBHBfSCEaqjX5whECpSSKCxyMJdlHDkCoECIltQBoJuSixUsIFAzSQ==@vger.kernel.org, AJvYcCWQK4kkZj9NqeYD7EQUF7bmfLR2E5exJYll96FnCkTFB/FdyajKDqYcLCN5vpsT52zSDxm46O1O3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw65lRZS6hAqREgZ7Haf0AsuxNGiOYB3+S7CQT4ie0ifahAt/LB
	mF9Mwmduu48rJe9NQh4rLK+cxc9GOcB8FXMX+nO8xnSYy3QJgk8XAd07fYBNa407ZxvtyZoojN5
	tzehKJK7BU1WH6jxTTMmeYk0CUw4=
X-Google-Smtp-Source: AGHT+IEMzX23pNCTwUB3oEFnjtXMwQslYwQseElwS5dsww3heTV7mBPQDdBjGem5UqseBxKdUwlhHXFriIKrdvm/EEk=
X-Received: by 2002:a05:6214:2b82:b0:6bf:78e1:74e7 with SMTP id
 6a1803df08f44-6c16deb3b70mr122308516d6.50.1724678032741; Mon, 26 Aug 2024
 06:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817025624.13157-1-laoar.shao@gmail.com> <20240817025624.13157-7-laoar.shao@gmail.com>
 <nmhexn3mkwhgu5e6o3i7gvipboisbuwdoloshf64ulgzdxr5nv@3gwujx2y5jre> <ep44ahlsa2krmpjcqrsvoi5vfoesvnvly44icavup7dsfolewm@flnm5rl23diz>
In-Reply-To: <ep44ahlsa2krmpjcqrsvoi5vfoesvnvly44icavup7dsfolewm@flnm5rl23diz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 26 Aug 2024 21:13:16 +0800
Message-ID: <CALOAHbA5VDjRYcoMOMKcLMVR0=ZwTz5FBTvQZExi6w8We9JPHg@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
To: Alejandro Colomar <alx@kernel.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Simon Horman <horms@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:25=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> Hi Yafang,
>
> On Sat, Aug 17, 2024 at 10:58:02AM GMT, Alejandro Colomar wrote:
> > Hi Yafang,
> >
> > On Sat, Aug 17, 2024 at 10:56:22AM GMT, Yafang Shao wrote:
> > > These three functions follow the same pattern. To deduplicate the cod=
e,
> > > let's introduce a common helper __kmemdup_nul().
> > >
> > > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > Cc: Simon Horman <horms@kernel.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > ---
> > >  mm/util.c | 67 +++++++++++++++++++++--------------------------------=
--
> > >  1 file changed, 26 insertions(+), 41 deletions(-)
> > >
> > > diff --git a/mm/util.c b/mm/util.c
> > > index 4542d8a800d9..310c7735c617 100644
> > > --- a/mm/util.c
> > > +++ b/mm/util.c
> > > @@ -45,33 +45,40 @@ void kfree_const(const void *x)
> > >  EXPORT_SYMBOL(kfree_const);
> > >
> > >  /**
> > > - * kstrdup - allocate space for and copy an existing string
> > > - * @s: the string to duplicate
> > > + * __kmemdup_nul - Create a NUL-terminated string from @s, which mig=
ht be unterminated.
> > > + * @s: The data to copy
> > > + * @len: The size of the data, including the null terminator
> > >   * @gfp: the GFP mask used in the kmalloc() call when allocating mem=
ory
> > >   *
> > > - * Return: newly allocated copy of @s or %NULL in case of error
> > > + * Return: newly allocated copy of @s with NUL-termination or %NULL =
in
> > > + * case of error
> > >   */
> > > -noinline
> > > -char *kstrdup(const char *s, gfp_t gfp)
> > > +static __always_inline char *__kmemdup_nul(const char *s, size_t len=
, gfp_t gfp)
> > >  {
> > > -   size_t len;
> > >     char *buf;
> > >
> > > -   if (!s)
> > > +   buf =3D kmalloc_track_caller(len, gfp);
> > > +   if (!buf)
> > >             return NULL;
> > >
> > > -   len =3D strlen(s) + 1;
> > > -   buf =3D kmalloc_track_caller(len, gfp);
> > > -   if (buf) {
> > > -           memcpy(buf, s, len);
> > > -           /* During memcpy(), the string might be updated to a new =
value,
> > > -            * which could be longer than the string when strlen() is
> > > -            * called. Therefore, we need to add a null termimator.
> > > -            */
> > > -           buf[len - 1] =3D '\0';
> > > -   }
> > > +   memcpy(buf, s, len);
> > > +   /* Ensure the buf is always NUL-terminated, regardless of @s. */
> > > +   buf[len - 1] =3D '\0';
> > >     return buf;
> > >  }
> > > +
> > > +/**
> > > + * kstrdup - allocate space for and copy an existing string
> > > + * @s: the string to duplicate
> > > + * @gfp: the GFP mask used in the kmalloc() call when allocating mem=
ory
> > > + *
> > > + * Return: newly allocated copy of @s or %NULL in case of error
> > > + */
> > > +noinline
> > > +char *kstrdup(const char *s, gfp_t gfp)
> > > +{
> > > +   return s ? __kmemdup_nul(s, strlen(s) + 1, gfp) : NULL;
> > > +}
> > >  EXPORT_SYMBOL(kstrdup);
> > >
> > >  /**
> > > @@ -106,19 +113,7 @@ EXPORT_SYMBOL(kstrdup_const);
> > >   */
> > >  char *kstrndup(const char *s, size_t max, gfp_t gfp)
> > >  {
> > > -   size_t len;
> > > -   char *buf;
> > > -
> > > -   if (!s)
> > > -           return NULL;
> > > -
> > > -   len =3D strnlen(s, max);
> > > -   buf =3D kmalloc_track_caller(len+1, gfp);
> > > -   if (buf) {
> > > -           memcpy(buf, s, len);
> > > -           buf[len] =3D '\0';
> > > -   }
> > > -   return buf;
> > > +   return s ? __kmemdup_nul(s, strnlen(s, max) + 1, gfp) : NULL;
> > >  }
> > >  EXPORT_SYMBOL(kstrndup);
> > >
> > > @@ -192,17 +187,7 @@ EXPORT_SYMBOL(kvmemdup);
> > >   */
> > >  char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
> > >  {
> > > -   char *buf;
> > > -
> > > -   if (!s)
> > > -           return NULL;
> > > -
> > > -   buf =3D kmalloc_track_caller(len + 1, gfp);
> > > -   if (buf) {
> > > -           memcpy(buf, s, len);
> > > -           buf[len] =3D '\0';
> > > -   }
> > > -   return buf;
> > > +   return s ? __kmemdup_nul(s, len + 1, gfp) : NULL;
> > >  }
> > >  EXPORT_SYMBOL(kmemdup_nul);
> >
> > I like the idea of the patch, but it's plagued with all those +1 and -1=
.
> > I think that's due to a bad choice of value being passed by.  If you
> > pass the actual length of the string (as suggested in my reply to the
> > previous patch) you should end up with a cleaner set of APIs.
> >
> > The only remaining +1 is for kmalloc_track_caller(), which I ignore wha=
t
> > it does.
> >
> >       char *
> >       __kmemdup_nul(const char *s, size_t len, gfp_t gfp)
> >       {
> >               char *buf;
> >
> >               buf =3D kmalloc_track_caller(len + 1, gfp);
> >               if (!buf)
> >                       return NULL;
> >
> >               strcpy(mempcpy(buf, s, len), "");
>
> Changing these strcpy(, "") to the usual; =3D'\0' or =3D0, but I'd still
> recommend the rest of the changes, that is, changing the value passed in
> len, to remove several +1 and -1s.
>
> What do you think?

I will update it. Thanks for your suggestion.

--=20
Regards
Yafang

