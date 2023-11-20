Return-Path: <linux-fsdevel+bounces-3271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B577F21D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 01:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B122826EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 00:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B4E3B7BF;
	Tue, 21 Nov 2023 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y5licVVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F0FBE
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 16:00:00 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9fcfd2a069aso247028766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 16:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700524799; x=1701129599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvy2CV8CQ1z8xyF0eqyyieG0M3+ja1/tOprJQEZU3U0=;
        b=Y5licVVAyPYKD/k20MMZkSMbBgiQ++7QRIuNqG+xiuB0SnUHTKl3SoFGXT9oOR1BFC
         6te8qwB6pW5OllpzSlBA9GOtTqW+jpPSILGsKwRrY8KLEvYpVbUVFoqRZkoGqV7rnhFC
         aZyf/bNkojtKE+Jy9BzgucSosPFunWOnts5Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700524799; x=1701129599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvy2CV8CQ1z8xyF0eqyyieG0M3+ja1/tOprJQEZU3U0=;
        b=sMXDs1zvVIa8GBfp+2P/M83xcz5DBcUvgLgWtBUlM+L46AUYr6W5OgfINu/iNPfOa+
         tXdcPrKm1ImffPpO4HvlDv6SmSQA7M33NKnQR9CPUzg38yIvGOHeRDXxzNrVwEQevZ+j
         CP9sTJjgM2v0iBvzPpNyLYBqZLLHHYNUEFDx6117Q83BpVh3cZF1R7W2lJxAFMIHLL5f
         uOwb/PG3jOq+vmP56tEBXP5Rskgg355QeZFKK542rC3PN2RlhP0Dq+G0aNumKOXd9Ulb
         YhD3fWrBNDSa+VLM7iA9vFK8yQ0ooaPM2b1ijkSQvM60lCfgQf/iq2YXEbc5VyUXkpXK
         m7Ow==
X-Gm-Message-State: AOJu0YzFS+8omVKcFOhEN5jmYhb5SzuymUseGteLOD2reHRytQqshfTM
	xeQJSDyixCf87jbWek2mmDn97YgMCYhljnRuRQ1K4w==
X-Google-Smtp-Source: AGHT+IGS/DMjLcVARh7/W+3Xwjr7CBqtoFkp2YHIj8I+RchJwxdGIbnk77jU2LOk1Rw8ir/jKvddnwjVTa6iwN+tqTI=
X-Received: by 2002:a17:906:5904:b0:9be:e90:5016 with SMTP id
 h4-20020a170906590400b009be0e905016mr6390836ejq.24.1700524799291; Mon, 20 Nov
 2023 15:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
 <ZU7RVKJIzm8ExGGH@dread.disaster.area> <CAG9=OMPFEV9He+ggq2mcLULnUZ2jm8fGU=4ca8kBoWtvqYcGVg@mail.gmail.com>
 <ZVvCsPelezZesshx@dread.disaster.area>
In-Reply-To: <ZVvCsPelezZesshx@dread.disaster.area>
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
Date: Mon, 20 Nov 2023 15:59:48 -0800
Message-ID: <CAG9=OMMar0shTijQfehFSktir2vsvRkvH8t69gREzVyLKyPH4A@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] [PATCH v9 0/3] Introduce provisioning primitives
To: Dave Chinner <david@fromorbit.com>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 12:33=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Mon, Nov 13, 2023 at 01:26:51PM -0800, Sarthak Kukreti wrote:
> > On Fri, Nov 10, 2023 at 4:56=E2=80=AFPM Dave Chinner <david@fromorbit.c=
om> wrote:
> > >
> > > On Thu, Nov 09, 2023 at 05:01:35PM -0800, Sarthak Kukreti wrote:
> > > > Hi,
> > > >
> > > > This patch series is version 9 of the patch series to introduce
> > > > block-level provisioning mechanism (original [1]), which is useful =
for
> > > > provisioning space across thinly provisioned storage architectures =
(loop
> > > > devices backed by sparse files, dm-thin devices, virtio-blk). This
> > > > series has minimal changes over v8[2], with a couple of patches dro=
pped
> > > > (suggested by Dave).
> > > >
> > > > This patch series is rebased from the linux-dm/dm-6.5-provision-sup=
port
> > > > [3] on to (a12deb44f973 Merge tag 'input-for-v6.7-rc0' ...). The fi=
nal
> > > > patch in the series is a blktest (suggested by Dave in 4) which was=
 used
> > > > to test out the provisioning flow for loop devices on sparse files =
on an
> > > > ext4 filesystem.
> > >
> > > What happened to the XFS patch I sent to support provisioning for
> > > fallocate() operations through XFS?
> > >
> > Apologies, I missed out on mentioning that the XFS patches work well
> > with loop devices.
> >
> > I might have misunderstood: were those patches only for sanity testing
> > or would you prefer that I send those out as a part of this series? I
> > can whip up a quick v10 if so!
>
> I was implying that if you are going to be adding support to random
> block devices for people to actually test out, then you should be
> adding support to filesystems and writing new -fstests- to ensure
> that loop devices are actually provisioning blocks at exactly the
> locations that correspond to the physical file extents the
> filesystem provisioned, too.
>

Fair enough, let me work on an additional fstests patch to validate that.

Best
Sarthak

> -Dave.
> --
> Dave Chinner
> david@fromorbit.com

