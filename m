Return-Path: <linux-fsdevel+bounces-69825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A881AC8629B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D633B69E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3509E329E77;
	Tue, 25 Nov 2025 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hpd7N+Cw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26FA31A808
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090696; cv=none; b=OBbe87Xt0Aw71EasMiK9zLCVbVjt/doymuBtDO1twWvnALwV5UISzg4YFHF0UML0+1Hfn80roCkl4EaxoyalfpE+YJE9zNto5Quess8i3KdSn/BE5lnsvB1EMg4/T5DYTdkfvYyV9CxqNyu4S3+wnxqHuNYjKyZzYEKDR0qw/dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090696; c=relaxed/simple;
	bh=JkWJ8zMwNXflYHUTcGdd62JuAjDjnrq+DEJ9vwRn4/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiC7R8cMw+YkN6wJeHrxNv1a5EzizffS/3L5hT4yi509yQuT5xuGzrl2bPWGKllxjIME09pyAJgwXXhS8zaSJk7gHTyF6scgnuKwJtHWFXDbAcBxlNVQpwBWTz9OkhLFvVQ0wNkziKAjwayVZOhgin7jO/iCqgbPJrnywx9u8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=hpd7N+Cw; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-644fcafdce9so8995185a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 09:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764090692; x=1764695492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ly5LBt6mDypO/G6NdTT5RZY/q0zV3qr4fzhYNtYlqik=;
        b=hpd7N+Cwrilo4buSu4NL0TRonaHPBoJUMCs+jkijiY8JPnqvrDzRAWTK2aBR+JEW5j
         SDP/H4lrgtBUTHXCpS/nzM3QEZwOpwSh/l2b5F7K60T3C0V60Odv2W6jroQmG+7b1mxF
         HnMq0jv2sqAJP5yU4jEWEtutI5TEfaLcs1N0MyfwzUAxttbTtFI0X6Uwp6wI41zLBL6z
         5u/QagwB9x1HkdyEpV1xZqmQnLe4pz7F/kiLjJZAHCUzPQRk5aiobmnKEnDssMFWVX5G
         PrIRDDaa5E5xtS08w+ig75Rfi67otatGWITH7bPqWjtBxa65veJ3ze1QOcwc1/7nD45J
         yC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764090692; x=1764695492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ly5LBt6mDypO/G6NdTT5RZY/q0zV3qr4fzhYNtYlqik=;
        b=G74YlkeHWbXjyEI0UCGj67etZRfYMJMcTS+tK3KpIJbOPeP7fVbwEi0LzV3fwJZj3W
         0qs3NwB/Lpy0f6sDCw4Dsc6aPkZpJZAh37z1GOM2QQ0j79ilGd7+GEQ4xRana+7H89Wm
         ex9FFxBolPwPvwsu/0/d05DYTwiXzuD7lowBYUVItsfRLML442g0n68j0c6MLx7mYZNK
         Pab5r4mHCz32YzOzb2XWwDTTf5cpCXp3oDjFEqxsr3SqyNrbJH5ZjLPzLHDmiKJ6p7qZ
         ZLBiZjE0H6dvY1DAJDUZHuGsMg/b9JjIHFcGaYmx66VnH86+nw1CIGveP0q6TsHtqEOy
         irJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTqeKr2eMuaJBdMUYtkbop4B7XQaoAwTjHyVOtW+mA9LPU8JegjzoM4HWNmVATcIgrU3v5Qe8P5+WW7ad5@vger.kernel.org
X-Gm-Message-State: AOJu0YwevKuJreTkdNPWVCsv/KY4LVOYy/2yXoPCSN4J5UZOl5yu87uX
	8mJfwk6H7FYqcgXQbYqusgUnxZnZXZNzvSTileaHlvt4o+Em7Ifn+whcFA15MhSMrljjc5kLaMw
	ODjSa5o1aAybyj97zMa43LjEVFlHF/cDQLvX/f/tq7A==
X-Gm-Gg: ASbGncvN36+QL2gQD1Nzktm4ImhjHI45NPJevkVfoBBRRSkKinUUgp0/YrFv3EzYDqT
	vyGpwLjS6xh7ShP9nX0vqYiXwPXqQDMUkhNqicUpNLkj85L+A06GU7npEdoN8SVJ5CcziCEYq2S
	BUz+oPctVYeBBd6NLn5vUZl5q4v8Bb2xicAujgJynhJCm1LVnUGfgWlMK24sDIn4282wyeFLsdA
	3UpiZBf0jzkKD+Qdxx0EH1Ya4LkC/B5YY9YY+wemUbZvos1v8B93RkeWg9gERYeoAAr
X-Google-Smtp-Source: AGHT+IGrfsmrfzIW+aWRuJRmdKZisN9HOWvhufzxvxHfKz1E+SFLlkqO50B6RT0T1wYIyaZoNdq4RbNgdU/zWatA1zQ=
X-Received: by 2002:a05:6402:1469:b0:637:e2b8:605b with SMTP id
 4fb4d7f45d1cf-645eb23f94cmr3816071a12.5.1764090691966; Tue, 25 Nov 2025
 09:11:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-22-pasha.tatashin@soleen.com> <CALzav=f+=c5XH7Uw9EGVb2P6VxsnpF76e0DXAAXhM0gsWPxw2w@mail.gmail.com>
In-Reply-To: <CALzav=f+=c5XH7Uw9EGVb2P6VxsnpF76e0DXAAXhM0gsWPxw2w@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Nov 2025 12:10:54 -0500
X-Gm-Features: AWmQ_blUNJXGJsZNTyk-wstisxWf95tP1YO8_RTqL2T5TqXUElAOHsjvRUxN7S8
Message-ID: <CA+CK2bBXNkpkYFa8xX4L1redUAdyx40ggJhntysH4W=a2nh99A@mail.gmail.com>
Subject: Re: [PATCH v7 21/22] liveupdate: luo_flb: Introduce
 File-Lifecycle-Bound global state
To: David Matlack <dmatlack@google.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 6:45=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Sat, Nov 22, 2025 at 2:24=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
>
> > +int liveupdate_flb_incoming_locked(struct liveupdate_flb *flb, void **=
objp);
> > +void liveupdate_flb_incoming_unlock(struct liveupdate_flb *flb, void *=
obj);
> > +int liveupdate_flb_outgoing_locked(struct liveupdate_flb *flb, void **=
objp);
> > +void liveupdate_flb_outgoing_unlock(struct liveupdate_flb *flb, void *=
obj);
>
> nit: "locked" should be "lock". "locked" is used for situations where
> the lock must already be held by the caller.

I am going to clean-up this API, and remove locked/unlocked; just
return the object directly.

>
> > @@ -633,6 +639,7 @@ static void luo_file_finish_one(struct luo_file_set=
 *file_set,
> >         args.file =3D luo_file->file;
> >         args.serialized_data =3D luo_file->serialized_data;
> >         args.retrieved =3D luo_file->retrieved;
> > +       luo_flb_file_finish(luo_file->fh);
> >
> >         luo_file->fh->ops->finish(&args);
>
> I think luo_flb_file_finish() should be called after the file's
> finish() callback. Otherwise the FLB data will be cleaned just before
> the last file's finish() callback.
>
> i.e. The order should be
>
>   file1->finish()
>   file2->finish()
>   file3->finish() // last file
>   flb->finish()
>
> rather than
>
>   file1->finish()
>   file2->finish()
>   flb->finish()
>   file3->finish() // last file

Yes, I will make this change in the next version of FLB patch
(currently FLB has been dropped from LUO and will be sent separately
since there currently no in-kernel users beside the self-test)

>
> > +static void luo_flb_unlock(struct liveupdate_flb *flb, bool incoming,
> > +                          void *obj)
> > +{
> > +       struct luo_flb_private *private =3D luo_flb_get_private(flb);
> > +       struct luo_flb_private_state *state;
> > +
> > +       state =3D incoming ? &private->incoming : &private->outgoing;
> > +
> > +       lockdep_assert_held(&state->lock);
> > +       state->obj =3D obj;
>
> I tripped over this when developing the PCI FLB state. The following
> compiles fine and looks innocent enough:
>
>   liveupdate_flb_incoming_locked(&pci_liveupdate_flb, &ser);
>   ...
>   liveupdate_flb_incoming_unlock(&pci_liveupdate_flb, &ser);
>
> But this ends up corrupting state->obj.
>
> Do we have a use-case for replacing obj on unlock? If not I'd suggest
> dropping it.

I can remove internal obj updates.

