Return-Path: <linux-fsdevel+bounces-45470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D4A781AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 19:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6408B7A4616
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6871DA63D;
	Tue,  1 Apr 2025 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLM7CmWw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D753AC
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743529844; cv=none; b=s8G1oPQe9xYDTYjq+CeF2gf7VIBIieRnmLDGlYsKB1OUX6LlSBoICYyVG8wKdXOS3wk9MsbrFkCBqQtjWHPR7IKjpc+4Qn6uC2afDLghMyELdj2oa7JBRfs7srg9L4ohbk3+WJ5yosFsu1I+Am6905uHU6l9WCLVAmlQTaosZZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743529844; c=relaxed/simple;
	bh=4URA5JUkAja84JefUGv1UscyI0us/cjgYgZqf4d5nL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdIshdPVsT2qOiw+RtFAk7ODtil8wyJSsIt1ZbOkzoLzmEhmOKG8BWP7nnwHxqyh+7ptlNZvWijWmc0hPGy4rMTapDV3pNHnMUE7PdX/tlrrIJuV41dNxD/IFgG7rM9RLaB2B1hySHiP8sELaUIl3r1X03bq192dOC/bcGUEX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLM7CmWw; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c08f9d0ef3so344895485a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743529842; x=1744134642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arHymE9A7OsBiq3X5/eFQgCjgnLCXPV6L5AwKoWFkdQ=;
        b=HLM7CmWwiNgWutT5dvuXGDn3eIkwIp1/sOibXob/MM8tXLA/LB+Hkl9CZHkL+yUjQF
         IATmAlW7yuhJuliUUIiObNfxgReLq2GkPXM/S+Giwue9538mlhgcRAo1gTUeR/bPJJaN
         RTOcSXNyD5Xo0+0Vs7WvMRJTWwglcMSnYZ/QFWzfufu1rIOep2fLdVYcf4zul6oOSAPA
         +KarbU9avv1d0DpZ551STumAY5J+drXShUgG4rUJ5mPqE4n1lxyNlSUUftfIPE2VDgjR
         stKLsSgZzNhdr4/HtR+NN3ANCT8BOm+nH6Ahj65B9eh1z5QxLgcNVIN4XKMWD/JvFAWi
         DNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743529842; x=1744134642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arHymE9A7OsBiq3X5/eFQgCjgnLCXPV6L5AwKoWFkdQ=;
        b=qC9r7IfSJT8Do472GWaYjo1G20l0lCvwcAbG4DrElOlvWhkfHRs5vz4F7qSRFMeR+R
         65gK14RN4ZazA/y5nAhHDlNyR8yuPXDuHDo+gblx6VbxOkw5KtS5a5TqMJh538XIUWtY
         0NTETQIGf+qG/QKdmadLDAw9WcL9OzRayUOg+1xRUGKzjb1xO1h6k3mlGAJobreHVFkm
         n98+5XLGrrbQzR7mtLHbiWPR9gpjgryeIRB+xdkRwjzauW8lNT42bDIT24Q6zUm2vROK
         LH3cEDGp47I1VPcK4E6wWHL8Jkuzehgnm+f4eUDHmJgiIjllOWDpTh4bv/NPVO57p2Js
         uh7A==
X-Forwarded-Encrypted: i=1; AJvYcCXvWp3TRN0UbXWoB4k6uXXRrZ2qAfu+HyaWh+a5h0QbZMzzcV65bGtvz7FFVOEUuiWtIfLhiJ/1aoIJOvVJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwOaRW9lAt+v9Yl/6D+C6WidwC3bQCAf9MeJOWCiduC1vDhuTLL
	Bx6iL86XoqFXaDh6Z1CTra8DiUWemBYrEfLIoNaBfYLYNNM4pGgSfoo2GXRWKI+H5BFHG3Ir6v+
	qtyEEE7+Gr00y72FTUDCfSzCQNXo=
X-Gm-Gg: ASbGncuzO4L4v2Bff4+x57uGfJRraL7Rhy3Cbthgm0RDnzuUvg0vtxVTYl0ha+PWtVD
	Q1oWz9gKSqYIPYT8zlPKQ10FT2qoOmme4S72E07daZjPIiuAoKq4h47dh9HBK+2qQpZ4DyS7OR0
	pbKCEPwpwkwd5jr8zoQr/3lxIFVg==
X-Google-Smtp-Source: AGHT+IH017AVhgUApDuX1hqfbPHKHV5gM5yIudxXyreFBL7rfdttT7win+JVsRCCH76vvFdk+iCGbKm3aMa3SObKIgk=
X-Received: by 2002:a05:620a:2688:b0:7c5:5670:bd77 with SMTP id
 af79cd13be357-7c690895decmr2185277185a.55.1743529841948; Tue, 01 Apr 2025
 10:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331205709.1148069-1-joannelkoong@gmail.com>
 <CAJnrk1a4fzz=Z+yTtGXFUyWqkEhbfO1UjxcSk1t5sA7tr8Z-nw@mail.gmail.com> <c2ab84de-84b7-4948-8842-21dd8e8904b3@fastmail.fm>
In-Reply-To: <c2ab84de-84b7-4948-8842-21dd8e8904b3@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 1 Apr 2025 10:50:31 -0700
X-Gm-Features: AQ5f1JpwJfNKMKt4Uk-CKtdfHwNfA4F-D7bfmltn8H-WO-KvBiYBtT_cWQuRhKc
Message-ID: <CAJnrk1YgRVqQriykVRuburcGK5oN8bzGRNTvyKhr19P-siJ4xg@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: add numa affinity for uring queues
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 1:11=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 4/1/25 01:42, Joanne Koong wrote:
> > On Mon, Mar 31, 2025 at 1:57=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> >>
> >> There is a 1:1 mapping between cpus and queues. Allocate the queue on
> >> the numa node associated with the cpu to help reduce memory access
> >> latencies.
> >>
> >> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >> ---
> >>  fs/fuse/dev_uring.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >> index accdce2977c5..0762d6229ac6 100644
> >> --- a/fs/fuse/dev_uring.c
> >> +++ b/fs/fuse/dev_uring.c
> >> @@ -256,7 +256,7 @@ static struct fuse_ring_queue *fuse_uring_create_q=
ueue(struct fuse_ring *ring,
> >>         struct fuse_ring_queue *queue;
> >>         struct list_head *pq;
> >>
> >> -       queue =3D kzalloc(sizeof(*queue), GFP_KERNEL_ACCOUNT);
> >> +       queue =3D kzalloc_node(sizeof(*queue), GFP_KERNEL_ACCOUNT, cpu=
_to_node(qid));
> >>         if (!queue)
> >>                 return NULL;
> >>         pq =3D kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), GF=
P_KERNEL);
> >
> > On the same note I guess we should also allocate pq on the
> > corresponding numa node too.
>
> So this is supposed to be called from a thread that already runs on this
> numa node and then kmalloc will allocate anyway on the right node,
> afaik. Do you have a use case where this is called from another node? If
> you do, all allocations in this file should be changed.
>

I don't have a use case I'm using but imo it seems hardier to ensure
this at the kernel level for queue, pq, and ent allocations instead of
assuming userspace will always submit the registration from the thread
on the numa node corresponding to the qid it's registering. I don't
feel strongly about this though so if you think the responsibility
should be left to userspace, then that's fine with me.

Thanks,
Joanne

>
> Thanks,
> Bernd

