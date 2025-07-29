Return-Path: <linux-fsdevel+bounces-56233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02604B14965
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 09:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A7F5461A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBF026A0C7;
	Tue, 29 Jul 2025 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA0w2EE6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064B26A0E7
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775446; cv=none; b=mX4fiXJneZAJkEV7YOs03zwIsBYTIGo+mwBIgL274S5THC40fQ7PX6qF6EdSnX2BkBJPzg4FCjEl79Nc1cspiIMjQnvciKGKUlGH5XUV1jDzLojQcx+KfVN1A7EVhPyUEPvNdrdu+sGeQyVvAe8k6I5vrUHb+Y9pIP3/Gsak/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775446; c=relaxed/simple;
	bh=6LcS44nKnwSnf86ehAJ+NKMcc/RjMF5HFFQe3QGGFfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfJTnkOZCwopbONMlKeVJfzM4mFq7TrlcBHwXsDPIPLMF5nehjQJjx6IoAdjfCNfaEVdPHKREoAcQMn+2RJunICm/DpnlULOninuzonEgJWOfSoPlFIPcqqHlZO+pKqQHZv+fqStViTq2SIEhUJej6UzUQrXQrTqByCN1l2CwdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA0w2EE6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aef575ad59eso833912966b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 00:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753775442; x=1754380242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8bC3kKxVkVl6Ykh3xtGRYbWkyrMC+H5qa4FL5jQxMU=;
        b=YA0w2EE6JH8ZgIoAbO8t3GSc2ZXpYZciFiKDWHTINY56a2tPjmMY7IuSAObUw+QUzV
         OiojWxfdHeoaqiAdOo4DhEcCv4zks9CWMrA+tUyrNiqO/kORBCfjG49m61UX9G/ZfOnT
         m0n5/ObITahIJejOYgVWls2fpkJDDDxwm7J5IEXj6eBvLtzBZDdDKQEWIRfW0GwizwVK
         zkbe8CHmq4+cVNgdxRtyHMghFV++Z5FjZDJl8D7kpyEZ1gF1nuKyyrZFMQ6IZlDGe86H
         RKQCyLDPU+DbJt20/QhEFHryk2YsHjCj84CYjTnRBO6XtYP8F6eH+cy2MzFUCpauzMHv
         aM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753775442; x=1754380242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8bC3kKxVkVl6Ykh3xtGRYbWkyrMC+H5qa4FL5jQxMU=;
        b=OKIwOE9+/D/dbEJj/PrwHkDJtCZjYnBhlCs0CDe+h0k3IlwWvLbx5paFhsdWMvi+wd
         7HIpTLkSS7AygkwV4R4reBrbOv0J5bo8p5gSaBwsvyXt39lQnS8KfSZT2Ezaf1WP1dFA
         F0MOoRr5cU8MYgNcUond+6qfDZgK2oUgO1EhM3UphaMG7jy20VBeTRX08O2eNO5ONp1m
         gV7fO5LmRNzMqkSmrMMME+PmK7BFfWF0hcQYsRXZi+SX17GeLD52JMP80QwEPg4TFnHF
         kA77ZbKOIiEglX3KKggbSP2XnduCtSKAWY08gaCtzNEdFC2PkkJfdMmn6Bh+nVy74u0I
         MK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRhlwjPahcq6XLwJayHiI1qU9ceCRqTTNxzZiJzW5UVf1e32TKmlui21FzqSGlTnAQrxe0MpdzpUfRaQBC@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ3xnM+GzbRh3O5+y0Z89hulG6W1z2S2VwyBsM6x4TOCjUccyF
	35zCjB29jwwxtr7KRWXXUsxAO8uIWxZ0FEY8jM9koWxc+qm+nvsG6aHgUOuCtj//cHuIdMs8p/1
	bcHHPz69B+ugYWwyH3marVKG4yJM8GTo=
X-Gm-Gg: ASbGncvOHKE8h82P9mFCpkDswo4KPZ6gow4Xch4FlZ22i+mwUMrMlXpT0VEMb3toRx5
	qagt4M0TrAWK4V4sb7d/5yl/wMK7/zB8YMv/hIqTMi5R+HR9GqtqhaAjduiXFptZFf54D1igFj6
	9SsKOK6R209b8QMmC3yNkl7meDwKua0M4sY24dHaFFrWW6gjWbSFuNDF7gXSVGURhliGa6TnxGQ
	QVGG4M=
X-Google-Smtp-Source: AGHT+IHNHkxrCtJrQjI5EYqML92MCCcx44RYCB6KhdcPhko06H2NTy3A+YdKi3m/h7r+oZMJHEpi68IuWA80tXL/egU=
X-Received: by 2002:a17:907:971f:b0:ad8:8529:4f8f with SMTP id
 a640c23a62f3a-af61d37c54amr1584856366b.45.1753775442205; Tue, 29 Jul 2025
 00:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
 <175279459875.714161.9108157061004962886.stgit@frogsfrogsfrogs>
 <CAOQ4uxjRjssQr4M0JQShQHkDh_kh7Risj4BhkfTdfQuBVKY8LQ@mail.gmail.com>
 <20250718155514.GS2672029@frogsfrogsfrogs> <fa6b51a1-f2d9-4bf6-b20e-6ab4fd4fb3f0@ddn.com>
 <20250723175031.GJ2672029@frogsfrogsfrogs> <CAOQ4uxi8hTbhAB4a1z-Wsnp0px3HG4rM0j-Q7LTt_-zd1UsqeQ@mail.gmail.com>
 <20250729053533.GS2672029@frogsfrogsfrogs>
In-Reply-To: <20250729053533.GS2672029@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 29 Jul 2025 09:50:30 +0200
X-Gm-Features: Ac12FXw5Ji62GqF1aTZQwq2IX9lHjT13BHEmV0gpHRsV-Xwc9lwGP3l4rRubA2s
Message-ID: <CAOQ4uxjwVnD9X6=LtcV7A+_peFs36YHm3tJO2ak+1OSxC36e9Q@mail.gmail.com>
Subject: Re: [PATCH 08/14] libfuse: connect high level fuse library to fuse_reply_attr_iflags
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bernd Schubert <bschubert@ddn.com>, "John@groves.net" <John@groves.net>, 
	"joannelkoong@gmail.com" <joannelkoong@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "bernd@bsbernd.com" <bernd@bsbernd.com>, 
	"neal@gompa.dev" <neal@gompa.dev>, "miklos@szeredi.hu" <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 7:35=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Jul 24, 2025 at 09:56:16PM +0200, Amir Goldstein wrote:
> > > > Also a bit surprising to see all your lowlevel work and then fuse h=
igh
> > > > level coming ;)
> > >
> > > Right now fuse2fs is a high level fuse server, so I hacked whatever I
> > > needed into fuse.c to make it sort of work, awkwardly.  That stuff
> > > doesn't need to live forever.
> > >
> > > In the long run, the lowlevel server will probably have better
> > > performance because fuse2fs++ can pass ext2 inode numbers to the kern=
el
> > > as the nodeids, and libext2fs can look up inodes via nodeid.  No more
> > > path construction overhead!
> > >
> >
> > I was wondering how well an LLM would be in the mechanical task of
> > converting fuse2fs to a low level fuse fs, so I was tempted to try.
> >
> > Feel free to use it or lose it or use as a reference, because at least
> > for basic testing it seems to works:
> > https://github.com/amir73il/e2fsprogs/commits/fuse4fs/
>
> Heh, I'll take a closer look in the morning, but it looks like a
> reasonable conversion.  Are you willing to add a "Co-developed-by" tag
> per Sasha's recent proposal[1] if I pull it in?
>
> [1] https://lore.kernel.org/lkml/20250727195802.2222764-1-sashal@kernel.o=
rg/
>

Sure. Added and pushed.

FYI, some behind the scenes for the interested:
- The commit titles roughly align to the LLM prompts that I used
- One liner commit message "LLM aided conversion" means it's mostly hands o=
ff
- Anything other than the one liner commit message suggests human intervent=
ion,
  that was usually done to make the code more human friendly, the patches
  diffstat smaller and frankly, to match my human preferences
- I did not let the agent touch git at all and I took care of applying
fixes into
  respective patches manually when needed
- The code compiles, but obviously does not work mid series
- The most interesting part was the last commit of tests, when the agent
  was testing and fixing its own conversion. This comes with some nice
  observations about machine-human collaboration in this context, for examp=
le:
- The machine figured out the need to convert
  EXT2_ROOT_INO <=3D> FUSE_ROOT_INO by itself from self testing,
  created the conversion helpers and used them in lookup and some other
  methods
- Obviously, it would have figured out that the conversion helpers need to
  be used for all methods sooner or later during self testing, but its self
  reflecting cycles can be so long and tedious for an observation that
  look so trivial, so a nudge from human "convert all methods" really helps
  speeding things up, at least with the agent/model/version that I used

I think that language/API conversion is one of the tasks where LLM
can contribute most to humans, as long the work is meticulously
reviewed by a human that has good knowledge of both source and
target language/dialect.

Thanks,
Amir.

