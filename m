Return-Path: <linux-fsdevel+bounces-36681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3769E7B2F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 22:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AF1169A83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 21:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FFC1C5495;
	Fri,  6 Dec 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okswx+Q3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810C22C6C3
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733521946; cv=none; b=dXZOASekYkVj/RUJycYLSamhxFC1lpyaYaZJiYhjzOuK1tXO+eGm3g2tuFkH5sZKAB/3O2TgclhCOWfmtneQ79ZYwJaqTxD1EEjHzm1agcl1Lky3TVpv4fubtU8zJLxlZg6uJPaod/4zQEOrj6PbeWZzL2xb7oeV2PGZQL2H5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733521946; c=relaxed/simple;
	bh=0tyieHhUWiZuMxSZaGFMYpsjGwkchYd4WsOtXjTW/6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPzMuBm/OF5O0eScAta9x247iBVlGky7Sd20SrudWNIKpg3+T038+W0Bo4u6myvFJIT05YFFAattBwg5BVIJ7vKglepmPSjqmXT9Nmihw8i7P48g0e4vv0eNXRLA3B1E0PbC9vcR9NrKVFzGv1+H6ysRdAojxNagRbAhEfi2G+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Okswx+Q3; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4668f208f10so24304201cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733521943; x=1734126743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwJKcBgQvi5ECd/YLMryMnYiLcRCCw4F+MGKUKrSxUs=;
        b=Okswx+Q3v6yPnnfthy6Sf8K2U5QNAxpUvxCbMfOnWLn4LrS0k8O8HvIX6tuYxgMXfO
         +qMzRFGb+BloDaykamh4hq8yOENXj2o8L+2x8fP88iTGfx4NGadS9wWqj2mU2oSOyUln
         Z4K3rEBh4dF4P1GN/EgtNF7CY9crU3rKdBE80OuUcqIfca9Z/j2CZ4ERKqGV763MmTnV
         aA0ywPn7c7s+AB9J/8CgeKOdb2dhaUpyqcY6j3s05XT1osu0Oh4Zd2XOXR3tFl6HU6AK
         hFvgE7haI+mn7HFhlwMkAYvV6lPbcfHkhSjtWX5gN4pbxV+wk+wDSrt91rbPQrpP3sCF
         g9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733521943; x=1734126743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwJKcBgQvi5ECd/YLMryMnYiLcRCCw4F+MGKUKrSxUs=;
        b=ViO2A+AIkue3fW9HEDMD7HF9gDe6KYoC/Wi4OyZNjg9ePEAeRIoAvw5obvwBRwwQ9C
         OWKWrOHhLQsBlVQK7OIVPQMm0ZyTBqsJ4lkcpCtzkyqEakYl1/7CGOOzmFaFQxKNKe4j
         xc9knE32xRNdIth1BSOKWgivTCnJmSnFZ3i7AJp0k0UA0gTJ/MkDNV9bKKs8SRhaSxY0
         fSIx3IXt5o4nuJRoYThEiy46goW1aT5/8d7HymcFrE64VUmHD1F/ZATfNFjvI0hQx/FS
         E1pXFTwdkG9NineFKzS77i82t8LmF0/uDP7GzwahEXALdvy9GTKKEYAe2MzFNOigQdCN
         2MVA==
X-Forwarded-Encrypted: i=1; AJvYcCVzVgLtc3hxLfsSLwyk1nvS/SetSuzowjOX+N8pqTqfZYiWF7F3Vn62qiq17xPxdDzE77XBCzSHeQsFvIoI@vger.kernel.org
X-Gm-Message-State: AOJu0YxBIaNffpKGkslLF7qHhKJoIRnl5SdPkXo27uGhEiomO5w7f+op
	oMZ+3m42Ebv76hri9pNfmveO0tCfvwqycCtaGhziy8usBsWUXRO9JaLxOwZloRJAx2OexQ2cMt4
	/VPO+DrryDIJFHyIHgT1W2be97+I=
X-Gm-Gg: ASbGncsCI2F8eQU7JrbEUPpmJZMtSsdE6F/X0JWu1nn4D5m40xc9ZJXDPnjbTKr0XPn
	pq7TSHTiWV/KRPcW6Ndx+/+OAcwfb8bNECyHU0gsopXjPrCE=
X-Google-Smtp-Source: AGHT+IF7ICzroEAZgSU67dIqP3oY9uoDZeC9FOgWaehxDpyBSWj+tpqLDU7FVg8z5u+ia1gFXCO+VzoTSIuG0nxptm4=
X-Received: by 2002:ac8:57cb:0:b0:467:1f3c:4d22 with SMTP id
 d75a77b69052e-46734e26188mr110540341cf.52.1733521943478; Fri, 06 Dec 2024
 13:52:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com> <CAJnrk1Yc2VN-NZb4NfDNrvMmhP3AdioRoHOB0HxmyR_8aBNXRQ@mail.gmail.com>
 <CAMHPp_Rk4ai0psCtodxb7pNsRQ5r1p7i2y635QzmRcVSxd3eBw@mail.gmail.com>
In-Reply-To: <CAMHPp_Rk4ai0psCtodxb7pNsRQ5r1p7i2y635QzmRcVSxd3eBw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 6 Dec 2024 13:52:12 -0800
Message-ID: <CAJnrk1bA+uRzSiTVeJ_t+jp+X7ixj3MEk8nBe7nO29tG0+Ld3w@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Etienne <etmartin4313@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, bschubert@ddn.com, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, kernel-team@meta.com, laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:56=E2=80=AFAM Etienne <etmartin4313@gmail.com> wr=
ote:
>
> > > I tried this V9 patchset and realized that upon max_request_timeout t=
he connection will be dropped irrespectively if the task is in D state or n=
ot. I guess this is expected behavior.
> >
> > Yes, the connection will be dropped regardless of what state the task i=
s in.
> Thanks for confirmation
>
> >
> > > To me the concerning aspect is when tasks are going in D state becaus=
e of the consequence when running with hung_task_timeout_secs and hung_task=
_panic=3D1.
> >
> > Could you elaborate on this a bit more? When running with
> > hung_task_timeout_secs and hung_task_panic=3D1, how does it cause the
> > task to go into D state?
>
> Sorry for the confusion. It doesn't cause tasks to go in D state.
> What I meant is that I've been looking for a way to terminate tasks
> stuck in D state because we have hung_task_panic=3D1 and this is causing
> bad consequences when they trigger the hung task timer.

Gotcha, thanks for clarifying!
>
> > > Here this timer may get queued and if echo 1 > /sys/fs/fuse/connectio=
ns/'nn'/abort is done at more or less the same time over the same connectio=
n I'm wondering what will happen?
> > > At least I think we may need timer_delete_sync() instead of timer_del=
ete() in fuse_abort_conn() and potentially call it from the top of fuse_abo=
rt_conn() instead.
> >
> > I don't think this is an issue because there's still a reference on
> > the "struct fuse_conn" when fuse_abort_conn() is called. The fuse_conn
> > struct is freed in fuse_conn_put() when the last refcount is dropped,
> > and in fuse_conn_put() there's this line
> >
> > if (fc->timeout.req_timeout)
> >   timer_shutdown_sync(&fc->timeout.timer);
> >
> > that guarantees the timer is not queued / callback of timer is not
> > running / cannot be rearmed.
>
> Got it. I missed that last part in fuse_conn_put()
> Thanks

