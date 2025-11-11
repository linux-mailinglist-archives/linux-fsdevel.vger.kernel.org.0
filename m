Return-Path: <linux-fsdevel+bounces-67912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B04C4D607
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89B014F79B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322553546FB;
	Tue, 11 Nov 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVl1T59E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98ED34B1AF
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859639; cv=none; b=rMPfv0q/5d89olX4Oc9uudM6TlVN21RtIvSWb3OJE4F1enYXPR1qbpkOwbTd0+jE2B+tJkf9+NHctsnbPL5icnKyr7sgu3GnmV4VwMtzH1UnxbUK9iCE++0N8osTypvPL2utNSEbJti81PdiRc3BBrzzlJb6sPD/QQAPiBMl5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859639; c=relaxed/simple;
	bh=mfpxJized6ddPC3qHoBNdHGOU71qGPnLof2yVroAmRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=un48Hy01HayiOPaXuHkG+aKspOOlBNdwBq+gZ6ba1xaD4DX25o4A//XEe+o5D90k6qv6VWoUPyxUPGfKaWlruPzBguV2SMVo9ebhN454+aokr3BaizXkdKvjXyzQT2p6+exdoJIXP+fJu4ix+uOL01guzafPFqRLN9uKDwqzooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVl1T59E; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b472842981fso527624766b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 03:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762859636; x=1763464436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI0L2Ed/xTKonR94/9lycNCAUJYqkyjIqxvcRxrvF7Y=;
        b=JVl1T59Eq9WfU1MqgYtSBDr+hiCxT34sTKZLjD4yIRxZGniaBCiRjAvSBHzwBbIv45
         OLN6Gc9G6V0TItqECZ8UktcrUadOL7Cf2hffaGIfTNXrxrlTZvAmGkOtnXhmWt+5e/H5
         T2Z3Ut+jCo//8jPxJEtpLeSi7SWIg14OxNlyTlWZ0wNhfXi79EHvOI/smIvu79I1OY3H
         njXPj9LTcUVt61M/Vhb8/n0zYo56FVpfy3DgLTPAmwysYllMOUfXTRLdyojK64H67h5z
         F4748dSmKDhoh01WD7UCuG5AtHfl22/0tMKLAMdWSe9uo8vr/A84Ls/X33eHzukY5SNC
         qtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762859636; x=1763464436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qI0L2Ed/xTKonR94/9lycNCAUJYqkyjIqxvcRxrvF7Y=;
        b=qPCG+UzfYkK8HwSYpYFfBoxXlckU41AqsLAbIEgJNlGyHWn/+bjuXDtR3zqHhf7xDU
         /gXwJ9gMPRnPL34uMdZSIGYH+WFznzcaIv3beoXeBI6nWrnqSXEW99/FZrIaqslyesYt
         R9kauQQ+IPQ7rpeld9cZEEdcRgr9kWnRZDjPkueqM2rL7ae1gmtoL6Xta/bLFPI0cveS
         8QJAUo/FwAB/LjMAepQ8pfLRk2IJQuqij3QjW0vf2SapXbumetaXXFkHaw29xou/e9qi
         XRsKgNhBFM6wGRwyDaRaACxD1OBOf3xmHeJl83iO2wLCnaxlUcF1JSgco5lnA0UB/VuR
         tlrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8U/qujrnqQmc/99+xs3Rlv2P4pBWtIcQFXtyS8jPqpTV21WXwTRrdtvscjym+NrgLAkeYcCbaFitg9Hcg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg6Ov5lhriWm2oVAOrxqZCB5Wijto/t0UxhaDBqyVi9N2EwLjd
	Bw9oxY0tmnRU2hQpmawxQUDq2SxPf/8wvJKi/XlG+nE2zL6ZkVH32U6GMU5Gt9U8A/PuEiJbpuz
	z2wOatLYAghwnCVw74og00w10V+7Dp+0=
X-Gm-Gg: ASbGncu/qh0MXjoLuwzLQ2bK77C4rxq3WYv9KJpBGEKZ42U5vZ/Mo5RKhLcCDIm4p9A
	Wms9WjPNIzgSNYtgN4wZf5zqZgKcRXEhMqVIHir4xv5lPewX0Mh4+y+ZhTO7l8Ep4eM1OvxNkVM
	U8ith+azlZH3C9qA6XaWF7Y/Pxrl1Lb2BTdE1aAM0Fu0U51VRpadPjwMYPM5li//Tb0LpEeYpcb
	0MvCPb1Lx4diE2yVtUNIZ4xB6ChG9PQGBVaf91jmhfwQOTbUXdyPOTilqxy/sPKHkbtCK3Or4Kl
	QkxjSUqHU4f6ibAKnZVYGaU3sQ==
X-Google-Smtp-Source: AGHT+IFCERcs0ehjjKA/2M2GTFXwzqYa8iiT/pNklRVmaRpQgF44uW7J1kvaXulSj9Snkld7WJIal5/64pd1gpBwVGA=
X-Received: by 2002:a17:907:1c9f:b0:b72:7dbd:3c6 with SMTP id
 a640c23a62f3a-b72e05bd010mr1112366566b.55.1762859636167; Tue, 11 Nov 2025
 03:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110100503.1434167-1-mjguzik@gmail.com> <20251111-entkriminalisierung-chatbot-feeb7455fc74@brauner>
In-Reply-To: <20251111-entkriminalisierung-chatbot-feeb7455fc74@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Nov 2025 12:13:43 +0100
X-Gm-Features: AWmQ_bn1Oq353vLtOaM933qqCHZui_Cj9HtV86r-w72vSSCxVFbxshwkj6NlrZc
Message-ID: <CAGudoHHi7+gy5sRsOimLqSy02814cYKN6FQZ8hQcATue0PV8gg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: avoid calls to legitimize_links() if possible
To: Christian Brauner <brauner@kernel.org>
Cc: jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

this patch is obsolete, I posted a v3 (and later v4) with more
predicts in the area:
https://lore.kernel.org/linux-fsdevel/20251110165901.1491476-1-mjguzik@gmai=
l.com/

but that will require at least a v5 later

tl;dr please drop this patch

On Tue, Nov 11, 2025 at 10:47=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, 10 Nov 2025 11:05:03 +0100, Mateusz Guzik wrote:
> > The routine is always called towards the end of lookup.
> >
> > According to bpftrace on my boxen and boxen of people I asked, the dept=
h
> > count is almost always 0, thus the call can be avoided in the common ca=
se.
> >
> > one-liner:
> > bpftrace -e 'kprobe:legitimize_links { @[((struct nameidata *)arg0)->de=
pth] =3D count(); }'
> >
> > [...]
>
> Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.19.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.19.misc
>
> [1/1] fs: avoid calls to legitimize_links() if possible
>       https://git.kernel.org/vfs/vfs/c/ab328bc1eb61

