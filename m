Return-Path: <linux-fsdevel+bounces-44370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F04A67F3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 23:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF7E423CDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 22:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B852063EB;
	Tue, 18 Mar 2025 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQoyYtGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EF2F9DA
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335598; cv=none; b=g/hzhvGg+FbLCQ57M8i4gPfV/BJGJPalhW184vBIle2GD+Ka1uM5753o1swcLTJLZ2fnX3mo8drKKzVBIa/Ol8O+PbwXnWp/ElihanG0EpOLu4BTLF0AiCTMwfZJkIKis2zNunxiy2I3ryLgvII9sYD2LKx31ARfm6i39c9iNIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335598; c=relaxed/simple;
	bh=Io+JdtUIBffFZ1B6iHUYRfDu77sJLK+ELx7zZn8Qs80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+xRG9vU5cv1cLvSYkxlI2dMb9iadL08rZFswJjdnSuWPa3gfSZcNj2EITpSTmWqqHI8cpr+yXct479MOV+6JkZXXyj8snFrVHLqqhomkljgFiH9Uui5Zbq3a9L7cvbCS2QcdHAdFoFdS5HVMicI6ncjdIE4BcGXyanjBLfJJWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQoyYtGK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46fcbb96ba9so44468401cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742335596; x=1742940396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvDGPTmu7K4ToDRV3WafsmIL0EJSnBnQZmuv1af418g=;
        b=BQoyYtGKybJUie51jjOc/6T6JFpZzQfWZ10FUpcaXKlTdA+mJHwTri4E1S88wOlSvK
         Ws5Z3ewU1YxXj3PNelwKL1gkdFa2ThbHxU+l1rNWor/+8KZsUVou4En7aUzXfYzK2SXo
         unhML1aq+7enG0UIdLIfwdPr4VJyfvaLQHcE2p6B5jyneauAwHwEq7D0lpJXt0LDEUEF
         BRsziT7izGl3CIBOTCmtvf9CSB5zOpsb0ti05qFmXk5lTEUGlngkhtpdTOU+FFIISTmc
         NxYerisXfZkPOVFw8MXDslIcITNqt7mYy9QpFkL7SCg0t/QETiQ5uRXNdE66fa/8m8RU
         f03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742335596; x=1742940396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvDGPTmu7K4ToDRV3WafsmIL0EJSnBnQZmuv1af418g=;
        b=oZb/hUnTCjtD2KdstEN/oLtqhqdUBxupaqWN6kGblseR+CCL0i4eXISxkAe0WeiAUG
         Br/P8oBXISxFIgABul1S5dDLH3v5iYiFZkZKPfQ49lTEiuHTdilT4yFysamVuMWEUek8
         2Ciku8PRyBNeI7spj3QGe+rdQmL+KoOLT/3jLNSX8x5HVC5rNw63Quv/Mf6g8EN7pkgO
         D/L+C4ohDSQzh42o1J6lnJ0/MRUeeeqizwrkcEkIFMYD1CfqoUc74faJ+OFN1HEdOt/j
         84FUgt22OFP/EQ6t3DK0SW2IIccE3RBOczcfJa2D6WFBwxC530y7s2nZag7vtD0VVFbM
         xA+g==
X-Forwarded-Encrypted: i=1; AJvYcCWEpAa/6JdZyP3hhY9kRHW1QT+R0Z8rdTQtnKRSHIFL5MeosmLasKJn8dvh7q30qnjua3B98H59XwmmxtTW@vger.kernel.org
X-Gm-Message-State: AOJu0YzHZ37MUpG/CHQrLPauUZrQmHy7VhxDhW/EP5VtwNvLd5MEoXLO
	OyGy0LgBSfSrKDaG2g+GumcBUtuDe46wIjEPfhDjkCiZHcfrtLwpKmD0VZjjx4vkjQ6uy4kW/aM
	Y19HTwrbZXBRS12zjXaiINj7wh44=
X-Gm-Gg: ASbGncvBuUzfJsoR9RWbxBywzZPyp3HrEAJKBHH7xQhbMwCpJGlMZycXfMYZ76ZrVJB
	SgYR23eYHn/cuim6L9qlkVZxH3ediop5n3UuOXBMXKLqVqjeOEX5MFkqUPLRoNsBkvwJ0psbi5Y
	UTqYSExXmXQqwF8n+Fuy1TB6KhrepOha6FsQwaYIcbtA==
X-Google-Smtp-Source: AGHT+IFK0/SA0aYfCLP4fSto+MFaqvl0/79ShZWkCjR20V0K8QM6RoXUZoqwww25Xka7qPkzDI85JHe4ozoEvge5i8Y=
X-Received: by 2002:a05:622a:5a90:b0:476:add4:d2bf with SMTP id
 d75a77b69052e-47708336219mr9898581cf.22.1742335595700; Tue, 18 Mar 2025
 15:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318003028.3330599-1-joannelkoong@gmail.com> <fd9ba4b3-319a-443c-966e-b34eaca8d24c@fastmail.fm>
In-Reply-To: <fd9ba4b3-319a-443c-966e-b34eaca8d24c@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 18 Mar 2025 15:06:24 -0700
X-Gm-Features: AQ5f1Jr949FlosjITKRbXI_fT61Ix0RQpMbej-4F5K7FOIK_MtolxdZzu6fzEww
Message-ID: <CAJnrk1ZHQVGZ+UZHQ_QpSDVZvjmp3uySEZ6o0wneRHS+zQU=jg@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: fix uring race condition for null dereference of fc
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 3:38=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 3/18/25 01:30, Joanne Koong wrote:
> > There is a race condition leading to a kernel crash from a null
> > dereference when attemping to access fc->lock in
> > fuse_uring_create_queue(). fc may be NULL in the case where another
> > thread is creating the uring in fuse_uring_create() and has set
> > fc->ring but has not yet set ring->fc when fuse_uring_create_queue()
> > reads ring->fc. There is another race condition as well where in
> > fuse_uring_register(), ring->nr_queues may still be 0 and not yet set
> > to the new value when we compare qid against it.
> >
> > This fix sets fc->ring only after ring->fc and ring->nr_queues have bee=
n
> > set, which guarantees now that ring->fc is a proper pointer when any
> > queues are created and ring->nr_queues reflects the right number of
> > queues if ring is not NULL. We must use smp_store_release() and
> > smp_load_acquire() semantics to ensure the ordering will remain correct
> > where fc->ring is assigned only after ring->fc and ring->nr_queues have
> > been assigned.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands"=
)
> >
> > ---
> >
> > Changes between v2 -> v3:
> > * v2 implementation still has race condition for ring->nr_queues
> > *link to v2: https://lore.kernel.org/linux-fsdevel/20250314205033.76264=
1-1-joannelkoong@gmail.com/
> >
> > Changes between v1 -> v2:
> > * v1 implementation may be reordered by compiler (Bernd)
> > * link to v1: https://lore.kernel.org/linux-fsdevel/20250314191334.2157=
41-1-joannelkoong@gmail.com/
> >
> > ---
> >  fs/fuse/dev_uring.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index ab8c26042aa8..97e6d31479e0 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -235,11 +235,11 @@ static struct fuse_ring *fuse_uring_create(struct=
 fuse_conn *fc)
> >
> >       init_waitqueue_head(&ring->stop_waitq);
> >
> > -     fc->ring =3D ring;
> >       ring->nr_queues =3D nr_queues;
> >       ring->fc =3D fc;
> >       ring->max_payload_sz =3D max_payload_size;
> >       atomic_set(&ring->queue_refs, 0);
> > +     smp_store_release(&fc->ring, ring);
> >
> >       spin_unlock(&fc->lock);
> >       return ring;
> > @@ -1068,7 +1068,7 @@ static int fuse_uring_register(struct io_uring_cm=
d *cmd,
> >                              unsigned int issue_flags, struct fuse_conn=
 *fc)
> >  {
> >       const struct fuse_uring_cmd_req *cmd_req =3D io_uring_sqe_cmd(cmd=
->sqe);
> > -     struct fuse_ring *ring =3D fc->ring;
> > +     struct fuse_ring *ring =3D smp_load_acquire(&fc->ring);
> >       struct fuse_ring_queue *queue;
> >       struct fuse_ring_ent *ent;
> >       int err;
>
> I was actually debating with myself that smp_load_acquire() on Friday.
> I think we do not need it, because if the ring is not found, it will
> go into the spin lock. But it does not hurt either and it might
> cleaner to have a pair of smp_store_release() and smp_load_acquire().
>

I think the problem is that if we don't have it, then ring may be
non-null but the ring->nr_queues value we read in "if (qid >=3D
ring->nr_queues)" might still be the stale value, which would make the
uring registration fail with -EINVAL.

Thanks,
Joanne

>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>

