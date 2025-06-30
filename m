Return-Path: <linux-fsdevel+bounces-53377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DACEAAEE3BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CB418937EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7AF290D94;
	Mon, 30 Jun 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHd/RAdp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B017BED0
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299613; cv=none; b=X14O6LQhi1Cg2hEJwObQo5YQi0PK9ONYLx+eLjMWh+U2m+xMYizERaz+34wyM+fsPzKBEAgKb3ISF0cpAJsHD+k1GlnZz/0KpC8L9/3YdCqN8l7WKA6bSEK0CawK3KlDdZFZCF30DuevX+BGsYqsj9XzYcZ08K9hzTJjvoU00uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299613; c=relaxed/simple;
	bh=N4aZpzqD/qS13LE+koBWhKGv7GfLhZE5PWwKGtz3i1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRafKMxxN0I7TgUHXWUdDmVTLAIkVCPKgm037uCK9TKyxeIKhPjagirrFaGCyT7CmKBM4xQOUVBTnS1ANHny29f65uN+KC20XTFrAXHRZ0T3l/JuxqO39I9tNS/QeXwKkHKX6SM3hrjjcNy8fv1RFJMRwvzFeLGkcoF/PxWQTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHd/RAdp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ade5a0442dfso887712666b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751299610; x=1751904410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4aZpzqD/qS13LE+koBWhKGv7GfLhZE5PWwKGtz3i1w=;
        b=jHd/RAdpLEtUPm2apOazELLp8fRS90JrdpU6e10LDltAxjwPSNF6vEo2RgLGbf1dax
         2RuHvXwY74cgW1sNTxqlZeKXqX/dBLQPcjYXHrIbqYA+3YhJdvzrGrKDOLs5ZexJ7e+Q
         mKExlcWTZmBpVuFJRew6eU+9vpQmHpC6S8JBLd68Rvv5oazXMWYcEPJQKVocBvYgpU1g
         QKk2Zi13p9p4VgNXqHRj2BJ69hn3b00iiE4DMA13MwI7QI/n4oLqmqLJ7VJBmVF9J6+Q
         PAMDfPNGuO3/PGNYzzXlIB6nIwUES3RSDzSiSqKqm+ycGD7lp+g+Br9A/SqJtoRE9nYt
         Vi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751299610; x=1751904410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4aZpzqD/qS13LE+koBWhKGv7GfLhZE5PWwKGtz3i1w=;
        b=hTcxJND2Y+ydkN6S8yvB8NtSGhsjaQzgoW3E4Lp4k2oHE9zkktYnWwTYCCDiuVXCKs
         XZ+5kySNkTLDB41HZadnZT/UPfY25OvTodCjWv6vOp5r+6G2jJMc7WX9VS6Uww5Q6lZT
         NjDE3K+CkVSu0epchn99tDDvlGYturKHEuQM4ezUdLIPm4pNI2dAuLGmP7h8zWn8wPj7
         /PTf7fRRqtgtkxnuAx2MYDqJ2Gdu7yA9PrIasbK+V4WUbgr0hG5gBJ6T56v5BNoJKAYX
         vGBnuSVhKE1zK/OPdny62F5RhmHk8lL/jwcEk4+zP0RC0uBeXoUJ0MuR7pHVlgvltH1D
         EZ3A==
X-Forwarded-Encrypted: i=1; AJvYcCXh1GivofkDvwCHaYylBR76eYE9yE3MFOtC0tASHpwdEQKDfZlfkyeQFy3uw8eP29lxXu6+YJgBgC253S+h@vger.kernel.org
X-Gm-Message-State: AOJu0YyprL9GSUw4VMV0iu6dcRkR417u4m79QZRr3de+yJw27bt8l7Vt
	veHYJCytJmy6vT1XXaOovY0ajbJNOPpfk2cecKX4+ZP3OVC8tM0mYJSoFw74egHZBu3JQhCdj+d
	9WRVFiBZS4f4DszRGDKPJz7hJUEWVNOE=
X-Gm-Gg: ASbGnctjLppzuH77cP8GTWf3HkOvPqQI6noKbEpQchFr72qSANl3uGx7VaM9B1ins3c
	RMtsi9EEM1S97TIzSqr2bERxk/F+Jo8FAmdCJzTNe3z2yssN2NCuyV/rVtFLdyPuT3rg0xxOuGp
	9WYwlgFnYvO6TUx+wgqEvLg1IKAN1gpEbovEyIPqWGy70gy5YeJGaeJA==
X-Google-Smtp-Source: AGHT+IHmPpPeBqfN91Kz9iLpxIEh48Sj027gONGUmYRePIo3WYZfwgEQLfClyB/T68EGyWnaOVH5dqkbLPnHFevsYmc=
X-Received: by 2002:a17:907:96a5:b0:ae0:d804:236a with SMTP id
 a640c23a62f3a-ae34fd306cdmr1358849166b.3.1751299609752; Mon, 30 Jun 2025
 09:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxivt3h80Vzt_Udc1+uYDPr_5HU=E6SB53WXqpuqmo5zEQ@mail.gmail.com>
 <20250629062247.1758376-1-ibrahimjirdeh@meta.com> <CAOQ4uxjiSepuQE-oorRFmVmVwOieteh8Nb2pfe5jjV2ud3MMWQ@mail.gmail.com>
 <tq2wacm3zv34ijao4grcf2l6sqni6rnflarrfgcvutxbdyj5c3@33osrlevefq3>
In-Reply-To: <tq2wacm3zv34ijao4grcf2l6sqni6rnflarrfgcvutxbdyj5c3@33osrlevefq3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 30 Jun 2025 18:06:37 +0200
X-Gm-Features: Ac12FXwkmyl0jACkqExNVvyePnthtfIFuEJsZy0AUUf7-Z8WooGjHDHHJs4zKD8
Message-ID: <CAOQ4uxi8xjfhKLc7T0WGjOmtO4wRQT6b5MLUdaST2KE01BsKBg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: introduce unique event identifier
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 4:50=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hi!
>
> I agree expanding fanotify_event_metadata painful. After all that's the
> reason why we've invented the additional info records in the first place =
:).
> So I agree with putting the id either in a separate info record or overlo=
ad
> something in fanotify_event_metadata.
>
> On Sun 29-06-25 08:50:05, Amir Goldstein wrote:
> > I may have mentioned this before, but I'll bring it up again.
> > If we want to overload event->fd with response id I would consider
> > allocating response_id with idr_alloc_cyclic() that starts at 256
> > and then set event->fd =3D -response_id.
> > We want to skip the range -1..-255 because it is used to report
> > fd open errors with FAN_REPORT_FD_ERROR.
>
> I kind of like this. It looks elegant. The only reason I'm hesitating is
> that as you mentioned with persistent notifications we'll likely need
> 64-bit type for identifying event. But OTOH requirements there are unclea=
r
> and I can imagine even userspace assigning the ID. In the worst case we
> could add info record for this persistent event id.

Yes, those persistent id's are inherently different from the response key,
so I am not really worried about duplicity.

> So ok, let's do it as you suggest.

Cool.

I don't think that we even need an explicit FAN_REPORT_EVENT_ID,
because it is enough to say that (fid_mode !=3D 0) always means that
event->fd cannot be >=3D 0 (like it does today), but with pre-content event=
s
event->fd can be a key < -255?

Ibrahim,

Feel free to post the patches from my branch, if you want
post the event->fd =3D -response_id implementation.

I also plan to post them myself when I complete the pre-dir-content patches=
.

Thanks,
Amir.

