Return-Path: <linux-fsdevel+bounces-52794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94949AE6DAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 19:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B113B8A4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 17:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB12E613D;
	Tue, 24 Jun 2025 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8cGsNaW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498AC2222D2;
	Tue, 24 Jun 2025 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786669; cv=none; b=t0OoCVeKblDgfs1F1tkbgV5h4OqTb/iKmfX9k3qSY6MojgmiQooDbgQMUAe6dk1Gp/wrAadIW4MHKLDThSFlbLk+90E9kzz0wVLw+3VCXiycXKLrgv+RrnGTBOv6NIQjTeeJ9sS9/ARVMuly0Ot4gGlk3vRpJ97XsZF2WI5kklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786669; c=relaxed/simple;
	bh=a5PVovFsmpphhcC1hWSRAtIoVL1Eo6VMJ/WYND+fSEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsMysS9km7xlg149r+sYW+D1bl8lvihjsUbH+MStAGXwnV9jk92LTETjqOM5/bzmjUBEQkZfoZcSrAiaa2vXSd+xmEF7/y6Zg+0fkWhvmUxb4QnPbMc30AxPMXY1l4gRIwiNOWBt4+H/aTB0Zw2xh6Z/YpGcQz8BdXe51m6/5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8cGsNaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFD0C4CEE3;
	Tue, 24 Jun 2025 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750786669;
	bh=a5PVovFsmpphhcC1hWSRAtIoVL1Eo6VMJ/WYND+fSEw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c8cGsNaWX0fVjLDqhSwlSne+Kyd6+LJLh5qhacvj0X6mFJuLHg+C9m57qwBDPRfZ3
	 rqgygKXQcSa/x8Z75ECE7OZGL/yiYeNeMAX3s3gg5dN1YHTOR9YSKLshkHmVGLCoy/
	 YgeZ+O1sPAsxMhBNsKJzquiGANTOfxaaPdDYEAubc0U4uUYsetpWRhk6Vil6T0Lj91
	 cOfdKwHFltAJrMDKXsZ9oqoOGvqz1gc4oU4EacJjUgt7NTZQRAd1UdZybzZ0+TXoEP
	 BJGw9DylKyBS87f6VgKEH4N7rAdsX7OdTvPEO1ArkGcnuT4GDyeInsvI9X6FYMK9Hi
	 m+oqoCGQTKZAQ==
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a43afb04a7so40811221cf.0;
        Tue, 24 Jun 2025 10:37:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvjUQ5kZ28r6/9dwx2ZN+3psXNwe5oxrUhGI+AjGLjePHIOD8bj6A1cr/r9Xu/TqzvSeBlhE/OU66QtN9/@vger.kernel.org, AJvYcCVvlB9qBoor/XRDUMwI+Q3peEaiA+TfNymgYpDN1AUvsOvMTA2lO5jAYOdnpOeUom1Wo0SrDFC0Y0t4o5QdCG+xn0qneZoL@vger.kernel.org, AJvYcCXiGYVc4gXZk93ADE1g/Fz1Ucvl6BnYjK+9cOd+1LJTNmJx/LN5lZ1fZTNMVcURVfiAj7woGCzKihopWUFb@vger.kernel.org
X-Gm-Message-State: AOJu0YxrtIohEGsYHfsCXxVRcaekKbEet5gMBl2f/J03UM4hX0uGI31x
	uSqKm3gbDq5NIOZeEXrcNpqlga/Y3eA7c80i+M4Bm0hdJoZwNslDBPkLQxmo9Elbc21iPrRgoYN
	Y6hOUPMSSow3aC0ds19bKmaQn9kppClI=
X-Google-Smtp-Source: AGHT+IHrLg1ZHp9UwVuJJHNbLnUi5fWv+f+FjuAnJJGFt+bl5ul6NjqhpyEZp+PcNDwB+wrEAEizIr5VdXAFoiU6IZY=
X-Received: by 2002:a05:622a:1310:b0:4a7:146b:c5e5 with SMTP id
 d75a77b69052e-4a7c06cbaf9mr3336251cf.21.1750786668241; Tue, 24 Jun 2025
 10:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617061116.3681325-1-song@kernel.org> <20250617061116.3681325-2-song@kernel.org>
 <htn4tupeslsrhyzrqt7pi34tye7tpp7amziiwflfpluj3u2nhs@e2axcpfuucv5>
In-Reply-To: <htn4tupeslsrhyzrqt7pi34tye7tpp7amziiwflfpluj3u2nhs@e2axcpfuucv5>
From: Song Liu <song@kernel.org>
Date: Tue, 24 Jun 2025 10:37:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5GKn=0HWDKkmOMTge_rCEJ+UMRNnmo7HpT-gwtURHpiw@mail.gmail.com>
X-Gm-Features: AX0GCFtrQZFESJoWau6EG2iZopaA5_plWDAcACcPjqKr1AYhYf7Gc2RQxxN8qhg
Message-ID: <CAPhsuW5GKn=0HWDKkmOMTge_rCEJ+UMRNnmo7HpT-gwtURHpiw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/5] namei: Introduce new helper function path_walk_parent()
To: Jan Kara <jack@suse.cz>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com, 
	m@maowtm.org, neil@brown.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Tue, Jun 24, 2025 at 5:18=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 16-06-25 23:11:12, Song Liu wrote:
> > This helper walks an input path to its parent. Logic are added to handl=
e
> > walking across mount tree.
> >
> > This will be used by landlock, and BPF LSM.
> >
> > Suggested-by: Neil Brown <neil@brown.name>
> > Signed-off-by: Song Liu <song@kernel.org>
>
> Looks good to me. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks for the review!

[...]

> > + *
> > + * Returns: either an ERR_PTR() or the chosen parent which will have h=
ad
> > + * the refcount incremented.
> > + */
>
> The behavior with LOOKUP_NO_XDEV is kind of odd (not your fault) and
> interestingly I wasn't able to find a place that would depend on the path
> being updated in that case. So either I'm missing some subtle detail (qui=
te
> possible) or we can clean that up in the future.

We have RESOLVE_NO_XDEV in uapi/linux/openat2.h, so I guess we
cannot really remove it?

Thanks,
Song

[...]

