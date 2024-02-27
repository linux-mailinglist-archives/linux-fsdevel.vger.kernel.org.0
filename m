Return-Path: <linux-fsdevel+bounces-12906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030FF868559
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 01:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30BF2860F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 00:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0654D4A31;
	Tue, 27 Feb 2024 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spdX/faj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3311847;
	Tue, 27 Feb 2024 00:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995505; cv=none; b=Wcs52oVbZYxWviusC7mw6lgNJrZm9+4iBVqm+nAwNaWndWPi55FLBRVoCWM/RQcRKg7AYbq62obKLCLu1CuckEl2QdMiRrPBhMlAGkUW8wO6MJcbUTPsHh1LeRaIHkC+vTGBiwDg122TxoJb1a9CzI45XcV1DY0SDGYOrAUSOIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995505; c=relaxed/simple;
	bh=qaRGbZw3nMP//+JFjvNcVW+EqA2CwVdYh7gZL5mLkLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODuiojWSorSYvzZctFMT1bCaqWbzZyuRIqqwMU+GzeNQli+n89jie6WKKuGZe7KCQ2kMGPaysv9I+BYDOHsqQWjm2eP/KP63Cg2zJG3HMvPV0RNiu3y8ZU+Fbvwt8cWdONWsiGIcKOVxPpRjSnp2+JMlS++kqtfh7aOHsSSdd0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spdX/faj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36DAC43394;
	Tue, 27 Feb 2024 00:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708995504;
	bh=qaRGbZw3nMP//+JFjvNcVW+EqA2CwVdYh7gZL5mLkLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=spdX/fajxfIgjTyQMaNQ2X1LJ8aV2Fopwm1O6ldTSf/MhZk1FpJWOcwuIXQh7X3vU
	 919tq201q3FVeruH33Ej9unvbymjO/vB4vp6mcO6i0O6/LSChs9FrjviK3gPq4LCM8
	 yjrlNWKVWEyQjrCgref8LSGJvAbXxXBIz1THDnajacyTLJyvU354kMAgJDLW/S4Us+
	 e0GDFCqLfoMcYjZ/QyswH+13yXg5dLCiF4NdS30C9DfRBQc3bbCxs3Q0sesdoJz4Ja
	 l11CQaAdczcwGWZit/4XB8IRLWOOcHqzsuYUQO2sMrsptADdnA8Y64vyfMAK3XwUSb
	 g4x9RzckQmUOg==
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a4a932f4so13126155e9.0;
        Mon, 26 Feb 2024 16:58:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+dsz/OMX6ev6RtvZNmfzEZe4VvEzl3WJ/r6AVeFyfvqWhjFUJl+VgPYJEnzBgSq5l+3PD64SSNP0uLobQsGVgpfKflYt5Njqpo0CJkd2Pg/5Sm4EhB6o3u1lODsGXd8UWnu3gXjvevQRxU6tQ8/1aRM1ROhBQNErUKk/bJK1G7RQm3X+7Yq+dhaJFqN1UFmgmtDgE977/kOVLfno2GrIXNw==
X-Gm-Message-State: AOJu0YwFIh1AfOVQd5cEW22oaswSNlmmHRfoOsuNO4Mnv3rPNgR3an56
	sf01HVrIsjvcjt8fDxzAOkqPlC5sRzZlcdye3gw1RRMoCjF3ZzJA/RHRnUKlpthdaZ1wWJTGCxT
	Un8QXqtxFr7TLUk2H7vLhwpj7tDQ=
X-Google-Smtp-Source: AGHT+IFqjJgJkjMPawllVB8Z7vRbF30E2T+0rElmebjASihu2o/pZv4K7aKT/m1kXdVooPiQbMb0WJiPbiiC5Pfh6/A=
X-Received: by 2002:a05:600c:a07:b0:412:955e:90e0 with SMTP id
 z7-20020a05600c0a0700b00412955e90e0mr5714587wmp.34.1708995503389; Mon, 26 Feb
 2024 16:58:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708709155.git.john@groves.net> <ZdkzJM6sze-p3EWP@bombadil.infradead.org>
 <cc2pabb3szzpm5jxxeku276csqu5vwqgzitkwevfluagx7akiv@h45faer5zpru>
 <Zdy0CGL6e0ri8LiC@bombadil.infradead.org> <w5cqtmdgqtjvbnrg5okdgmxe45vjg5evaxh6gg3gs6kwfqmn5p@wgakpqcumrbt>
In-Reply-To: <w5cqtmdgqtjvbnrg5okdgmxe45vjg5evaxh6gg3gs6kwfqmn5p@wgakpqcumrbt>
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Mon, 26 Feb 2024 16:58:09 -0800
X-Gmail-Original-Message-ID: <CAB=NE6UvHSvTJJCq-YuBEZNo8F5Kg25aK+2im=V7DgEsTJ8wPg@mail.gmail.com>
Message-ID: <CAB=NE6UvHSvTJJCq-YuBEZNo8F5Kg25aK+2im=V7DgEsTJ8wPg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
To: John Groves <John@groves.net>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, 
	gregory.price@memverge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 1:16=E2=80=AFPM John Groves <John@groves.net> wrote=
:
>
> On 24/02/26 07:53AM, Luis Chamberlain wrote:
> > On Mon, Feb 26, 2024 at 07:27:18AM -0600, John Groves wrote:
> > > Run status group 0 (all jobs):
> > >   WRITE: bw=3D29.6GiB/s (31.8GB/s), 29.6GiB/s-29.6GiB/s (31.8GB/s-31.=
8GB/s), io=3D44.7GiB (48.0GB), run=3D1511-1511msec
> >
> > > This is run on an xfs file system on a SATA ssd.
> >
> > To compare more closer apples to apples, wouldn't it make more sense
> > to try this with XFS on pmem (with fio -direct=3D1)?
> >
> >   Luis
>
> Makes sense. Here is the same command line I used with xfs before, but
> now it's on /dev/pmem0 (the same 128G, but converted from devdax to pmem
> because xfs requires that.
>
> fio -name=3Dten-256m-per-thread --nrfiles=3D10 -bs=3D2M --group_reporting=
=3D1 --alloc-size=3D1048576 --filesize=3D256MiB --readwrite=3Dwrite --fallo=
cate=3Dnone --numjobs=3D48 --create_on_open=3D0 --ioengine=3Dio_uring --dir=
ect=3D1 --directory=3D/mnt/xfs

Could you try with mkfs.xfs -d agcount=3D1024

 Luis

