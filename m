Return-Path: <linux-fsdevel+bounces-36282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5E69E0D25
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 21:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16B21651FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 20:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A882B1DF24A;
	Mon,  2 Dec 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDLOnpsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707581DEFC7;
	Mon,  2 Dec 2024 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172030; cv=none; b=ZO1z0nvwtrrV+B/lARN3bznn7TNBljvxkm4yNATf3YuzIVK3/wT6LemEjJozuZPGF7vwGM4pJJBXFiD5PKe6H91nLFgVKjdk0dngyJDpDvJfRsX4LfdQFYBcPsLzh/1XTekgNeGmmHwvChv5kcrwKK2p3irgrjgSyQsBjjnvDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172030; c=relaxed/simple;
	bh=acPLnXf1i8ia07iNsomd5ZYgV7y8bgpJHhsKhg/amdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgX8noWsCAxMmhDGjow97IT2Fpk3EgH6A/nnzbHs0hdxPwZ8dAU+r5kGiCyWOQA2I+zMtfVbiTns/gCEwKmvDD3Y2vq8Xu5Jxao/f2vsbt6RB0kLzD4DZdWGSZlzDnzVobre/ghSJk1jjzVF1822uHl6mRlUYRx2ZLz+L9o+7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDLOnpsM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46686a258f7so45438581cf.1;
        Mon, 02 Dec 2024 12:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733172027; x=1733776827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJzYRHGrM4fQi49Zqib0i2zY9is9beuUhOSrZpSJwNk=;
        b=TDLOnpsMnNmZTM1WmHvJdU/t3/38elCxshfEMuAFYabRa8aGNrTB6aJRLtzj5bc1R9
         ZVp9lXN2LezJ61I9M53W96x1/ui3ZnQtLu9kF8GwHSIG0jj9EeXkT56J3ZIeh/jJ+zIi
         JfFIh0ZBT5BxK6+qfycD7GGi8cSXHiD8IZT6uUA4n7JZ7Xn84huAC0yKoBFoorLGX1pR
         jDgAE6kYDB5qoAxLLxVcMDzfONNUs3RVozSbyDApz5rS1VLJEYMGOQvTSZHvZvj/i66U
         e+wh/6ECbqiLXWK+qqLQh+yIv62skGKXGAnbornpaotKGFG2XnKvL4TnH0fcjdODneIb
         cdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733172027; x=1733776827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJzYRHGrM4fQi49Zqib0i2zY9is9beuUhOSrZpSJwNk=;
        b=Em7zszsBnRZqsgtTFn3QKEQIPCz06TTrqLeMQJVzOxU4AWPXR9SUSWS5ZUoS88Nlvw
         T9QwMX1rZ8iQ3nkY6xTDtk2wRTTKCV7O7l9V6h3J/UmtMAu5mxfXbFetFLr0wtKKRpCc
         Iig/5ec8LUguSFVSjSN0AYAbniOyen1a1R5JgHk3UQE9rgxMD9jgKmuqwWtdvfoOeuLC
         BaKA/5sTijToZtzs4G0ZKQyGKCu/EI00eofvL3ev2/mxIzX0d1el64i1PGpV+ofeXvpv
         5h7T14l4EgZ9kN01eh3QmDREFHmUB/ICid66JITh+6yTBeqW0JEU4kVhqWCRAKrcZ7xd
         Mb0A==
X-Forwarded-Encrypted: i=1; AJvYcCUqO+JwFgmQWm2bzCObfK9UusllG4mQvqf/0J67m498cpamPoobuPtM2UWKdarO/msD8yS8ZW7r/vCGGZe/@vger.kernel.org, AJvYcCV4B//P8LchMafS8jRo7zjjX17l/sz2wjK236kWJ9QpXY+hvkfl70WD+q1+OBCSyAFOayDI6zf8N3b7Ikly@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAjkHUMAzk4vkJapwwGoFwD8G/we8maX6bV7Or175ztpQHOLV
	Ie0xguelD+JplkPw3aPmHA6XNSudywpXzOJD0WVGZENwty41wMDMPx5y6gj48WYcgTMfeqjDTMO
	UqloEtZ/Fzau5MPv7XWsj2mdE2Z8=
X-Gm-Gg: ASbGnctI0bUzmKLU2i36KZfauENIpVGl4ZKUtqRTJGWLflBvxuX+iohlGn2fUw4d89u
	nm3TLoDw0dxPJu+mIPI6WUwaX289WP4Om/TLkb4jGOa0PmTQ=
X-Google-Smtp-Source: AGHT+IHx9pQSSUrRr6swBEQGXWXCJIgjyyV8BmKZStLy0exVB684kUT2ZdY3mPLc0d1H2HJTe+VrZ0RZEa9nP2l+PN8=
X-Received: by 2002:a05:622a:181c:b0:460:f34c:12b6 with SMTP id
 d75a77b69052e-466b366ef55mr382212701cf.44.1733172027102; Mon, 02 Dec 2024
 12:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130065118.539620-1-niharchaithanya@gmail.com> <8806fcd7-8db3-4f9e-ae58-d9a2c7c55702@fastmail.fm>
In-Reply-To: <8806fcd7-8db3-4f9e-ae58-d9a2c7c55702@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 2 Dec 2024 12:40:16 -0800
Message-ID: <CAJnrk1b1zM=Zyn+LiV2bLbShQoCj4z5b++W2H4h7zR0QbTdZjg@mail.gmail.com>
Subject: Re: [PATCH] fuse: add a null-ptr check
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, 
	syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 12:22=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 11/30/24 07:51, Nihar Chaithanya wrote:

Hi Nihar and Bernd,

> > The bug KASAN: null-ptr-deref is triggered due to *val being
> > dereferenced when it is null in fuse_copy_do() when performing
> > memcpy().

It's not clear to me that syzbot's "null-ptr-deref" complaint is about
*val being dereferenced when val is NULL.

The stack trace [1] points to the 2nd memcpy in fuse_copy_do():

/* Do as much copy to/from userspace buffer as we can */
static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *s=
ize)
{
        unsigned ncpy =3D min(*size, cs->len);
        if (val) {
                void *pgaddr =3D kmap_local_page(cs->pg);
                void *buf =3D pgaddr + cs->offset;

                if (cs->write)
                        memcpy(buf, *val, ncpy);
                else
                        memcpy(*val, buf, ncpy);

                kunmap_local(pgaddr);
                *val +=3D ncpy;
        }
...
}

but AFAICT, if val is NULL then we never try to deref val since it's
guarded by the "if (val)" check.

It seems like syzbot is either complaining about buf being NULL / *val
being NULL and then trying to deference those inside the memcpy call,
or maybe it actually is (mistakenly) complaining about val being NULL.

It's not clear to me either how the "fuse: convert direct io to use
folios" patch (on the fuse tree, it's commit 3b97c36) [2] directly
causes this.

If I'm remembering correctly, it's possible to add debug printks to a
patch and syzbot will print out the debug messages as it triggers the
issue? It'd be interesting to see which request opcode triggers this,
and what exactly is being deref-ed here that is NULL. I need to look
at this more deeply but so far, nothing stands out as to what could be
the culprit.


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/67475f25.050a0220.253251.005b.GAE=
@google.com/
[2] https://lore.kernel.org/linux-fsdevel/20241024171809.3142801-13-joannel=
koong@gmail.com/

> > Add a check in fuse_copy_one() to prevent this.
> >
> > Reported-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D87b8e6ed25dbc41759f7
> > Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
> > Tested-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
> > Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
> > ---
> >  fs/fuse/dev.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 563a0bfa0e95..9c93759ac14b 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -1070,6 +1070,9 @@ static int fuse_copy_pages(struct fuse_copy_state=
 *cs, unsigned nbytes,
> >  /* Copy a single argument in the request to/from userspace buffer */
> >  static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsign=
ed size)
> >  {
> > +     if (!val)
> > +             return -EINVAL;
> > +
> >       while (size) {
> >               if (!cs->len) {
> >                       int err =3D fuse_copy_fill(cs);
>
> I'm going to read through Joannes patches in the evening. Without
> further explanation I find it unusual to have size, but no value.
>
>
> Thanks,
> Bernd

