Return-Path: <linux-fsdevel+bounces-72964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 873F8D069A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 01:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4273005FF5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 00:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931CC1A9FAA;
	Fri,  9 Jan 2026 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I91xSesf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B50F157487
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767917902; cv=none; b=ZqKDiiUk76JZLZfsy89rWFqXt/Eijnm9WoWpdjop3YZTMHqx3+9JWBrYtiqxzJ3M2Kgkg5tHzZa7uib5xiSa7maY9eRpclzZednPRVOwecER6z7PyEc4wbBNlE3OPE0Rd1Qzbua3hnTzVOkbEEx3BAtpD/xICkIi0JgIbmoBMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767917902; c=relaxed/simple;
	bh=K4IJod5G8vYeUKHRLpvcEPjScAoL9onvSXBGxyMVDgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYj0CmQv1uwGYEvLXikUu0moG2/OWUfy5DtnyFloC4nQkrcLcLqoOaDotBHMZyk1AngxMfhktWkvJZDoQkKmqN+rLDiCKsNh9rYAB10XZWwSsIF0b0GJI8LUOspKUwBZ1l9lg45JPp8DEDtKXX8/YLShAY0JT/O3eeXdc0OX1lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I91xSesf; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8888a1c50e8so44396276d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 16:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767917899; x=1768522699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu52ro7KuGiY9LfkXX50YkcbjYYdhKundcvjp5YSdDQ=;
        b=I91xSesfk8zgga2J5pW00ggdBzeQzgwG7CDCOg5OP0vV5/J6A5RCxA+g9+wjJU27Hy
         nvmXyqBVrZUGyzdAUyGINgRNPJcHaYBG8gOs3GgepiuNC/t4zn/60Wcez/gw9gDhJG92
         rmgl9EbfCzVoPnrFwB3X+2xoEBH2VyhHlRXSssutJg9IHNn5GCgi+6u97GBxrPdy+top
         o07hmpS78YVv5RiDUzV0cilVJYtklRkiX3id5Xmf8XzyakGb8sSEceLf/XVL0PKZqfWh
         ajZv3BHw310pbczToSACA+vAxRPmxmstkpf2ji41AzZnPwuKi5uEhbf4wXUTLNzNAJXK
         G8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767917899; x=1768522699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xu52ro7KuGiY9LfkXX50YkcbjYYdhKundcvjp5YSdDQ=;
        b=OKGgWctotl8ZMMw8DGeCM2cZmYr0xc8uZ1Vm6sMxrgsGCZVAPYkzaHxaKeKh9bI8lN
         lT36NIyWg3WXrWUgsFj7nGqDZ+kiRiCtZhzLPG0tGXgeDTC7hV621jNkzXiu7QJ6PK68
         tiGnWaO1GV7WkOt0XNgvzGef+krgETZZsQrGzkYc/s+OggLQCp1b+fmg4bD08+DFIQRn
         q4vPclKzXJl9J8KAmAHxhjrxJQINfF60adA9g6/Mw5TB5mG1Ps1BjuZQqw3V/uQNHPHb
         0O6B/GHM5D7BITHdg2HfMo2at40O9rdz51YpTip4L+esgxYuqxocWRvaAN64LLJje045
         ShyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK8FSAem7pTEqn+3uktQcllrjqZ0+/R9yBXaGIiCKUJwAbLZju7ki4ODa8Kk9saZpHirDTr+O/lkNQr60B@vger.kernel.org
X-Gm-Message-State: AOJu0YzPiLFKmJsNrkH+o5g6uk/oHZ/araJ+SpMT8GU6LCLJP5AIYK8m
	twezfJaOEZgyaUr8pBRavwbdte2GRxqV1Lo340su71u4sqfuaz6xM7XIYiIcYpQSKKNokWxCCpd
	f8lc38laCW7tG+B+m2xsk2Q3Ut8Kj8E8=
X-Gm-Gg: AY/fxX795WI3ggPG3Qu2axiZMtiEQH/F7JY94lUsvUoPigrpefTvVHDlXwGAr9vGIud
	+CFIwtQC+jRUPpXZUYxJSu/8CfVEJsnU+UZvuihlxOrgxN9PPlNQdKbhli1piARKKi6w2LX5IER
	fkz61yIWza+lwkESqNq+dxoxnVcZmRffZl9UCWTT8sZ5tYCGI8M0j6un2msJAaQVCbVDY6mDrvy
	fWoG6XbMjf+Psdbv1brxUkLaEl1glVHluFzAnTaWYtCUom9hHfAIVCPfb/Xfg2NM6MAL6Mp7DBL
	p/yQ
X-Google-Smtp-Source: AGHT+IF/ehU5iCrwpXX2lrRAhqG+JPx5f5oyJZCWtahRS7GM5ptlj8PdgaMID3ay00640xAhZt9+rLe6spE4dJE/Iwg=
X-Received: by 2002:a05:622a:20a:b0:4ff:8da6:2289 with SMTP id
 d75a77b69052e-4ffb48a8a61mr98375591cf.27.1767917899476; Thu, 08 Jan 2026
 16:18:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
 <20251223003522.3055912-22-joannelkoong@gmail.com> <CADUfDZo56Bgv4PnKnE-nBbZ8WF1N-42RoBZ6DOXVRyqwksg2Xg@mail.gmail.com>
In-Reply-To: <CADUfDZo56Bgv4PnKnE-nBbZ8WF1N-42RoBZ6DOXVRyqwksg2Xg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 8 Jan 2026 16:18:08 -0800
X-Gm-Features: AQt7F2pOaaM6Jq6blHttXFFgbotWptYxleQIrdX77ONv8lB8L4BxsXRyWv-jKDg
Message-ID: <CAJnrk1Yt7yJL5RVZ=j+qAKb0A6SdhzYfu6P_Rxvf=eQBh+wJuw@mail.gmail.com>
Subject: Re: [PATCH v3 21/25] io_uring/rsrc: split io_buffer_register_request()
 logic
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 1:04=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Dec 22, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > Split the main initialization logic in io_buffer_register_request() int=
o
> > a helper function.
> >
> > This is a preparatory patch for supporting kernel-populated buffers in
> > fuse io-uring, which will be reusing this logic.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  io_uring/rsrc.c | 89 ++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 54 insertions(+), 35 deletions(-)
> >
> > diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> > index b25b418e5c11..5fe2695dafb6 100644
> > --- a/io_uring/rsrc.c
> > +++ b/io_uring/rsrc.c
> > @@ -936,67 +936,86 @@ int io_sqe_buffers_register(struct io_ring_ctx *c=
tx, void __user *arg,
> >         return ret;
> >  }
> >
> > -int io_buffer_register_request(struct io_uring_cmd *cmd, struct reques=
t *rq,
> > -                              void (*release)(void *), unsigned int in=
dex,
> > -                              unsigned int issue_flags)
> > +static struct io_mapped_ubuf *io_kernel_buffer_init(struct io_ring_ctx=
 *ctx,
> > +                                                   unsigned int nr_bve=
cs,
> > +                                                   unsigned int total_=
bytes,
> > +                                                   u8 dir,
> > +                                                   void (*release)(voi=
d *),
> > +                                                   void *priv,
> > +                                                   unsigned int index)
> >  {
> > -       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> >         struct io_rsrc_data *data =3D &ctx->buf_table;
> > -       struct req_iterator rq_iter;
> >         struct io_mapped_ubuf *imu;
> >         struct io_rsrc_node *node;
> > -       struct bio_vec bv;
> > -       unsigned int nr_bvecs =3D 0;
> > -       int ret =3D 0;
> >
> > -       io_ring_submit_lock(ctx, issue_flags);
> > -       if (index >=3D data->nr) {
> > -               ret =3D -EINVAL;
> > -               goto unlock;
> > -       }
> > +       if (index >=3D data->nr)
> > +               return ERR_PTR(-EINVAL);
> >         index =3D array_index_nospec(index, data->nr);
> >
> > -       if (data->nodes[index]) {
> > -               ret =3D -EBUSY;
> > -               goto unlock;
> > -       }
> > +       if (data->nodes[index])
> > +               return ERR_PTR(-EBUSY);
> >
> >         node =3D io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
> > -       if (!node) {
> > -               ret =3D -ENOMEM;
> > -               goto unlock;
> > -       }
> > +       if (!node)
> > +               return ERR_PTR(-ENOMEM);
> >
> > -       /*
> > -        * blk_rq_nr_phys_segments() may overestimate the number of bve=
cs
> > -        * but avoids needing to iterate over the bvecs
> > -        */
> > -       imu =3D io_alloc_imu(ctx, blk_rq_nr_phys_segments(rq));
> > +       imu =3D io_alloc_imu(ctx, nr_bvecs);
> >         if (!imu) {
> >                 kfree(node);
> > -               ret =3D -ENOMEM;
> > -               goto unlock;
> > +               return ERR_PTR(-ENOMEM);
> >         }
> >
> >         imu->ubuf =3D 0;
> > -       imu->len =3D blk_rq_bytes(rq);
> > +       imu->len =3D total_bytes;
> >         imu->acct_pages =3D 0;
> >         imu->folio_shift =3D PAGE_SHIFT;
> > +       imu->nr_bvecs =3D nr_bvecs;
> >         refcount_set(&imu->refs, 1);
> >         imu->release =3D release;
> > -       imu->priv =3D rq;
> > +       imu->priv =3D priv;
> >         imu->is_kbuf =3D true;
> > -       imu->dir =3D 1 << rq_data_dir(rq);
> > +       imu->dir =3D 1 << dir;
> >
> > +       node->buf =3D imu;
> > +       data->nodes[index] =3D node;
> > +
> > +       return imu;
> > +}
> > +
> > +int io_buffer_register_request(struct io_uring_cmd *cmd, struct reques=
t *rq,
> > +                              void (*release)(void *), unsigned int in=
dex,
> > +                              unsigned int issue_flags)
> > +{
> > +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> > +       struct req_iterator rq_iter;
> > +       struct io_mapped_ubuf *imu;
> > +       struct bio_vec bv;
> > +       unsigned int nr_bvecs;
> > +       unsigned int total_bytes;
> > +
> > +       /*
> > +        * blk_rq_nr_phys_segments() may overestimate the number of bve=
cs
> > +        * but avoids needing to iterate over the bvecs
> > +        */
> > +       nr_bvecs =3D blk_rq_nr_phys_segments(rq);
> > +       total_bytes =3D blk_rq_bytes(rq);
>
> Could combine these initializations with the variable declarations

I don't have a preference but was thinking it would look unaesthetic
with having that comment block in the declaration section. I don't
think it matters though, so I'm happy to combine the two sections for
v4.

>
> > +
> > +       io_ring_submit_lock(ctx, issue_flags);
> > +
> > +       imu =3D io_kernel_buffer_init(ctx, nr_bvecs, total_bytes, rq_da=
ta_dir(rq),
> > +                                   release, rq, index);
> > +       if (IS_ERR(imu)) {
> > +               io_ring_submit_unlock(ctx, issue_flags);
>
> I would prefer to leave the existing goto unlock; pattern. The goto
> pattern is easier to extend in the future with additional resource
> acquisitions. And keeping it would make the diff slightly smaller. For
> new functions with a single early return path, I don't feel all that
> strongly, but it seems like unnecessary refactoring of this existing
> code.

Sounds good, I'll leave in the existing goto unlock; pattern.

Thanks for reviewing this patchset.

>
> Other than that,
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
>
> > +               return PTR_ERR(imu);
> > +       }
> > +
> > +       nr_bvecs =3D 0;
> >         rq_for_each_bvec(bv, rq, rq_iter)
> >                 imu->bvec[nr_bvecs++] =3D bv;
> >         imu->nr_bvecs =3D nr_bvecs;
> >
> > -       node->buf =3D imu;
> > -       data->nodes[index] =3D node;
> > -unlock:
> >         io_ring_submit_unlock(ctx, issue_flags);
> > -       return ret;
> > +       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(io_buffer_register_request);
> >
> > --
> > 2.47.3
> >

