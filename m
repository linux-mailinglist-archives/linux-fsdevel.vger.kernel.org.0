Return-Path: <linux-fsdevel+bounces-9950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80292846628
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 03:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38891C22A3B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 02:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E80BCA67;
	Fri,  2 Feb 2024 02:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AAt+T796"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E8B659
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842754; cv=none; b=kORTbcKHoLENBz0ZV96vAyhVJc3TxQbkYOrYjtH4vZCe41i6zk06latYlzxABzNWvq1fOTVUeCBDRiSiIaLWHRp2Qb8dsnMAeFoUYOVhH4IBlGBV6m2ptPOkeVt+R6wj63jTstYnsJyclPM5SRf65Go5m3TPf/7quztt1h5D+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842754; c=relaxed/simple;
	bh=3z9prfnNE6KbllL7JBa22QDsRc93s+EZn8OPdvRTgtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUO0HOWP231xnkrxLQEQsOK59Ya6/6kf5tc1Q7MhvViJGGM/ufzA7LQt+iV1nw9Vvz4JgkUlINgZtKdpWSHEPTmx2psPOgEhMEbk2bBxUf1caaUlNQYehjM/Ddtqxj37TfEXGs9skfxAJ3z9Qez0VWmCRrNB68tJ7A6thYy7aXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AAt+T796; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so2340148a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 18:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706842749; x=1707447549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3A/r4oKTDxJsFL1Anlh777Z6f2eiMJhC1iris26H3M=;
        b=AAt+T7961dx/lh3ikpotIzNOAKXtCzZi6W9njeBfjlqUHYoZ117CmL/l5syKzQBls8
         8ydQ6yGjn1oJT4yAfJ1veQaItmRrqGAfq/o7Pa4w88L1+B+NjYlrauLFFwjI8ZfmaJlw
         ezgnsJ6ipugqY80TIpJkvLc1XF4BfyzUa822A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706842749; x=1707447549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3A/r4oKTDxJsFL1Anlh777Z6f2eiMJhC1iris26H3M=;
        b=cx5+fufAHZdz8TZ+y/SYF3s+BQcfxZ+jYvOQJ6KvP40HHwiS6eI0+7qQtiavV6RhJK
         HHhIivd8VXUfTKRyftHqTlNyzWBKjn50932mcZ9HTR8jIbnCRPg1PvBFw5RTO7OUed+5
         4FbWo4eSoOjTEhpYXsMgYWlC2j3CJ+bNd1NMOgQDZjOdzlyGZW5m2sGImw4Vi9Z4gVoR
         uzzEQ7nhY4J5d8UDo0EgHR3r/JpENr1jdFFD81Q/DIxy2c68EOFxWjLdZkKn9zuFG03v
         Cr7+MCKgINOPZpLKsRMT/2iucN790tmtRPtgXQzUL1JWb2dptKWpemNy3Ovna3in/RQ0
         fxXQ==
X-Gm-Message-State: AOJu0Yy8ovCgcGcZsyYg9Vc5t+WRfxMGTNFu2EFWUiMs6Nj24Mp4YFV/
	5sOiIfoAVNrW42e/1oKv/WKJeNsYKUWZwS3/d6ogO0NQZhEgxnmp8agsT/1nfgKRgI4vmGycSjU
	n+w==
X-Google-Smtp-Source: AGHT+IF5uDhDZr3uLzzqT8BdkF860dPR5/WZPdaoSQAEO4ItXooxvhL3seOC/UDQ4sAcjo3p9N1p/A==
X-Received: by 2002:a17:906:3ad1:b0:a36:84f5:5186 with SMTP id z17-20020a1709063ad100b00a3684f55186mr494242ejd.77.1706842749031;
        Thu, 01 Feb 2024 18:59:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXoHR5+tzF/QPtTekdLfx5RmqgCA5o3JAay3BYo7vTLu+CBVuD9xyeLswgQMP3WLtNnbrPPCDhTZq4e+HfCoEi7c3C2fhD9FBDIfWD/tg==
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id t9-20020a1709060c4900b00a363809ef08sm384201ejf.117.2024.02.01.18.59.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 18:59:08 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fc5e5ed44so14865e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 18:59:08 -0800 (PST)
X-Received: by 2002:a05:600c:3d92:b0:40f:c436:3982 with SMTP id
 bi18-20020a05600c3d9200b0040fc4363982mr62363wmb.2.1706842747629; Thu, 01 Feb
 2024 18:59:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <ZbxEWyl5Zh_3VwLb@casper.infradead.org>
In-Reply-To: <ZbxEWyl5Zh_3VwLb@casper.infradead.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 1 Feb 2024 18:58:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UoF7PGSevH1+Bk04gczjCaVioq4dXaPHDSc2Bk1NcJLw@mail.gmail.com>
Message-ID: <CAD=FV=UoF7PGSevH1+Bk04gczjCaVioq4dXaPHDSc2Bk1NcJLw@mail.gmail.com>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 1, 2024 at 5:24=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Thu, Feb 01, 2024 at 05:12:03PM -0800, Douglas Anderson wrote:
> > While browsing through ChromeOS crash reports, I found one with an
> > allocation failure that looked like this:
> >
> >   chrome: page allocation failure: order:7,
> >           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
> >         nodemask=3D(null),cpuset=3Durgent,mems_allowed=3D0
>
> That does seem bad ...
>
> > @@ -16,14 +17,14 @@ static int __regset_get(struct task_struct *target,
> >       if (size > regset->n * regset->size)
> >               size =3D regset->n * regset->size;
> >       if (!p) {
> > -             to_free =3D p =3D kzalloc(size, GFP_KERNEL);
> > +             to_free =3D p =3D vmalloc(size);
>
> It's my impression that sometimes this size might be relatively small?
> Perhaps we should make this kvmalloc so that we can satisfy it from the
> slab allocator if it is small?

Right. Sometimes it's small. It feels sad to me that somehow vmalloc()
of small sizes would be much less efficient than kvmalloc() of small
sizes, but I can change it to that if you want. It feels like we
should use kmalloc() if we need it to be contiguous, kvmalloc() if we
know that there will be big efficiency gains with things being
contiguous but we can get by with non-contiguous, and vmalloc() if we
just don't care. ;-)

...anyway, I'll spin v2 with kvmalloc().


> Also, I assume that we don't rely on this memory being physically
> contiguous; we don't, for example, do I/O on it?

As far as I can tell we don't. I had never looked at or thought about
this code before today and so all I have is ~an hour of code analysis
behind me, so if someone tells me I'm wrong then I'll believe them.

-Doug

