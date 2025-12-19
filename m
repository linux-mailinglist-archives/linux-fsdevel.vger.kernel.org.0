Return-Path: <linux-fsdevel+bounces-71768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2526ECD137C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 18:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1254302878E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 17:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D634214F;
	Fri, 19 Dec 2025 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3HiN4an"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66F33CEB5
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166147; cv=none; b=Mgq84Sxiw+FLmusrjT0OKiFQ9dw1SB/d/H1oWsFdW/9nHzGjH1rPMBtiteKynHCcYnqcsewqYRVrXS2TxeFYQtHxpfumbV0czyx7cG1dxzb1uaFJzWOjjsa3Hyn8MnH8+SIJiBukS6pF3ZLqMHozxPqft7QuIjoZcQ/w7FaXn8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166147; c=relaxed/simple;
	bh=ijXQWykGOGL2TDj17B557+scMQWaX05VsSV+vuQBmIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2OqZYo3pLo2ncYT1jwlktrEwZOfgXf27wg2K01+z8OfLl9calDw9/SkjMkcmcKZ42FKLT5DrBUz8MNQuV3qWpx0m9aaFASKz83BFogH1O8b6pagV8boDHID+3xFL4TRY5deSM/5MWfygRM/zVJ1wMKvaKkTQGKWVIQA53a4SKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3HiN4an; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso1610714a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 09:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766166146; x=1766770946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW8x981xzKG4MFNW1u7R47ZafSPsRMNXeILtwJPy3Eo=;
        b=a3HiN4anjqEKYe5mOkDveGPEmeYEkiik25NphNw377w339CsOYEdNkoKEslzQGN6g6
         XHed/8fc4BWUAo5nw9oliAs7FeHqfwboXV8AhdClHP3qHYZtJqevDOCa5r5IwxxR9yfT
         J1Owhwd9K3Lajl+SpFKVxjfJXnOsJKf3ENcH/f0vK01a7nUrXPW01a9YvvSFyGZrhv//
         NWMrqhH3AvXtam/gEERHpv0Y/4H8rVkoKpaRS5RFSCsJVBMHYRgIUbkCiYxwAyO+GcC+
         SH80++rufbd4oPP569t+6fs4SIAlTIKPjx7l3BcDQ71Qj4CYC8RCeZfWNa9Ttihr2oTX
         +HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766166146; x=1766770946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JW8x981xzKG4MFNW1u7R47ZafSPsRMNXeILtwJPy3Eo=;
        b=DZ/va9cgiT2VYMF4hpQy4pGl5UJCiXtE/sCoQRBfUhmTfTzv1tbcG++ixwv9+BSsht
         EPDUhPRhL1NKvvFK+oNq8hI3tPofoSDxyPwOeXYJzmUurXeQubLeXmBE7HIOcYdSIej0
         H6cxGwrS+fEo4c+fdnGou0dawLP+5dKyzUk62kULeg2MM5lMjL6XYuOkbxg/mzovwi+W
         L/j/nFF2kU2ecQ79H8HzfkKORVK6nxtGPMFXyxr1nAuGBaLW6JTitF8eNXspwoHdirWB
         LC4sQS3VWeP+BgfwUB5HLlfZrLxYyZwvbXaSmq9Fm4BCaUZQoxZVuvfyq2rQyW9pwoKQ
         fWYA==
X-Forwarded-Encrypted: i=1; AJvYcCVaF+ZdmpBifI7JSkpXEyTbY0b7Zmq5GktJokYcsGpPOnlqx3se4pZfypc1woG5aBZGxjI7pT8JqtgnMDN6@vger.kernel.org
X-Gm-Message-State: AOJu0YyxsIjKlmDe3EjAaEV7s9MXhPrys2+2QFH2ExfMVfhVd99ue4hm
	DoUJEeSo7Sv1xevxQzPajUWYwU0j8fwWTIHackXfmqLDo0Zw+XbBNhWew8rbHb+U1/px/a32k7P
	6W6vPAZ5scXkCmiXDxpLPpaK0e03wPN8=
X-Gm-Gg: AY/fxX5ptXQzH70aQpGd+gkidbHD0Y46AxoYcj08aeyRFykxlgFxmB3F8ECSN7sxxbU
	g6eTaQA+8pVWlOioPMtP1ByW4c8ETlnw0lFWM/LP10vxHDFv+gFSTWoJEAuYkwQBr7p7qOulCal
	PJjoJ8XSkL0BNe3DI/KzFKaUiw73xop9ju5NNFbAyft5SKrbvvPxb9CV8IPXUWbBLAzwx7Bna03
	lx00YfvIuMmqch4MGABZC7XxyRgpWDC6TFAzqOLl7BAtzFPsOY6o4qoe8x3NKwnJr7euQc=
X-Google-Smtp-Source: AGHT+IHpINJuwfKifBLEq1prr5FrJkIDHltFeoo+6LV09TLdfIop0tuY4u1d1V1PT4Cd13YrZszjS9knwymVFnKkxe8=
X-Received: by 2002:a17:90b:3c8d:b0:34e:6e7d:7e73 with SMTP id
 98e67ed59e1d1-34e71e0910emr5359098a91.11.1766166145554; Fri, 19 Dec 2025
 09:42:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218205505.2415840-1-shakeel.butt@linux.dev>
 <aUSUe9jHnYJ577Gh@casper.infradead.org> <3lf3ed3xn2oaenvlqjmypuewtm6gakzbecc7kgqsadggyvdtkr@uyw4boj6igqu>
 <aUTPl35UPcjc66l3@casper.infradead.org> <64muytpsnwmjcnc5szbz4gfnh2owgorsfdl5zmomtykptfry4s@tuajoyqmulqc>
In-Reply-To: <64muytpsnwmjcnc5szbz4gfnh2owgorsfdl5zmomtykptfry4s@tuajoyqmulqc>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 09:42:13 -0800
X-Gm-Features: AQt7F2rfNtQWCgEkml7MtGjiHiq38CyNWFSgjhPC7t5q8T4gXasMjJ76tzv38qA
Message-ID: <CAEf4BzY2YYJJsMx8BgkKk7BG67pj52stv_GRGwZkj3jnuipw+Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2] lib/buildid: use __kernel_read() for sleepable context
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Shaurya Rane <ssrane_b23@ee.vjti.ac.in>, 
	"Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 9:59=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Dec 19, 2025 at 04:07:51AM +0000, Matthew Wilcox wrote:
> > On Thu, Dec 18, 2025 at 04:16:40PM -0800, Shakeel Butt wrote:
> > > On Thu, Dec 18, 2025 at 11:55:39PM +0000, Matthew Wilcox wrote:
> > > > On Thu, Dec 18, 2025 at 12:55:05PM -0800, Shakeel Butt wrote:
> > > > > +       do {
> > > > > +               ret =3D __kernel_read(r->file, buf, sz, &pos);
> > > > > +               if (ret <=3D 0) {
> > > > > +                       r->err =3D ret ?: -EIO;
> > > > > +                       return NULL;
> > > > > +               }
> > > > > +               buf +=3D ret;
> > > > > +               sz -=3D ret;
> > > > > +       } while (sz > 0);
> > > >
> > > > Why are you doing a loop around __kernel_read()?  eg kernel_read() =
does
> > > > not do a read around __kernel_read().  The callers of kernel_read()
> > > > don't do a loop either.  So what makes you think it needs to have a=
 loop
> > > > around it?
> > >
> > > I am assuming that __kernel_read() can return less data than the
> > > requested. Is that assumption incorrect?
> >
> > I think it can, but I don't think a second call will get any more data.
> > For example, it could hit EOF.  What led you to think that calling it i=
n
> > a loop was the right approach?
>
> I am kind of following the convention of a userspace application doing
> read() syscall i.e. repeatedly call read() until you hit an error or EOF
> in which case 0 will be returned or you successfully read the amount of
> data you want. I am handling negative error and 0 and for 0, I am
> returning -EIO as that would be unexpected end of an ELF file.
>
> Anyways the question is if __kernel_read() returns less amount of data
> than requested, should we return error instead of retrying? I looked
> couple of callers of __kernel_read() & kernel_read(). Some are erroring
> out if received data is less than requested (e.g. big_key_read()) and
> some are calling in the loop (e.g. kernel_read_file()).

From a user perspective, I'd very much appreciate it if I get exactly
the requested amount of bytes from freader_fetch_sync(), so yeah,
let's please keep the loop. It does seem that ret <=3D 0 handling is
correct and should not result in an endless loop.

