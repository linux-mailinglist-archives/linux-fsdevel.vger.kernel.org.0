Return-Path: <linux-fsdevel+bounces-62062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC3EB82E5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 06:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C2F1C06C3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 04:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B0127147D;
	Thu, 18 Sep 2025 04:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PNBi5cJd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABF3A927
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 04:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170611; cv=none; b=VDQJVU6k4iV7ZYb4P3A76NayTFoV9ukzO9NjFgTBlQzydGBUtnhI10uWrIUJodBz1OvMZloKWvlKNe8QFZfPB36iaQ1aZ97NO1vkRzDMBBRBcvsgued07Fnsll2rCAoB5AUjDUqIGmuVdhCgAFU/NYonIX0Be3fn0iFtK1Zc9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170611; c=relaxed/simple;
	bh=bvQKqbZUHSmC9Cgyqlv2yW20y6m1kbKZ+PzcmlxuJdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLQLDc1ii6RAEOf2bvrAETAv3vCGahZrPojTvMSiBNaQWbLI+gv1IUjbHtF/QUp10MtCwLow3EN166gF1VQv0IqAOMi6V+XSB/SCY3To5zMuMkAsQPSYhQM5m/8HOh8bfMLg1qb6BzU4rEIv2qEAdCd07T/i+ll/juV8WKsrdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PNBi5cJd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7322da8so88486466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 21:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758170607; x=1758775407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF2mZRwJKtzsGK7DJVHcrnEuIs9i65jp/kWrZEcj7/k=;
        b=PNBi5cJdKb61AR69OvOnVOEoyrnSW+Jt3k9rfHifyaHDfqLk3ptS1BvpdF7s9Awy9F
         LYiAS9VDemdh4t0hw+LfbNvUgY2qs8iqsBlZOBQg1UvMHpeFuldby4a9vhaWZpii0PQh
         2F+hg/AVVZ53AiT+o+/XelJr35ZQECe/OM0sxGaXVxiVzGdn9QYzqhefC6pmCGEB8dXF
         KjpJr0Xz5SPKJMMVrqVGdfZ+4yFgyPdDLNP0RQXdi6oJumbGczqIEM2WgZfN148p0Xpk
         GLpu5lYnraC+JB4opqDja1lDF97artNDYpERNrjlEvCZ5T12gn6wrHXGP+BjEJzocwlV
         ODnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758170607; x=1758775407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FF2mZRwJKtzsGK7DJVHcrnEuIs9i65jp/kWrZEcj7/k=;
        b=HZophR+30T0FpAJwQGgUN7CPIEwQYAzRrTOeQ80YGzxB3QNPiLjedL6Vt8n34uBGpP
         uE4/tZ7XJJWh6w71CFdg1Lzhb1stdsJ81UuSLp4NcumZ5QNehp9ZZ07681ped+2ABVKD
         c3s3oxG36coLy3/PHpimoQvQ/M1eQH/T9qIbr9ACqlDWbar6pOwDjyFbAxlbDg5gSQM3
         YZTNkmFxkEHlaFgWIDd7Ei2UP5no3dAaA1JvHUlBDuLNa2/j04Wiue6+zyRdVwtkV3Ia
         HynAdHm7hQX9N1oNHcr/Jldania9S8Hb6CZuFFS5+/5ot+tXzXf0XU/VXAmmDmGrfa0x
         NR/w==
X-Forwarded-Encrypted: i=1; AJvYcCUw6oArhga0w89b9YKXCCWiggpiSQtNojc3IedfZze20rbAmq9eP4kOQSZcGJjIhMnjUckk4l/G4+yq5udN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv8onSqq72CF/1/ZH1TgKnn0Gxl0SakOLaJEGF9/MXGX/PtgA6
	jfuop79j8ZOtbwj6btcKCEnsVX+spRMXrqvQG2nObjwxh3glOnHQlc1TN21b0DhYmfZu7ozuHe+
	5lqPzU66YywR+VzClfxbWusyLDr9BSkh1ggpS+c7lhQ==
X-Gm-Gg: ASbGncubwnv2pcZ8WK+X0SkCbsvMmJqSB1EqbRuQcYoR0TimqQlmfyn5Umtx/WKIIeW
	H2xHTeTo1Nrh8/rpV+2s3ajoOgSL50keCKK8VEEM3K3R+GWwzxpvXMLC0vJLDJIMuenar0y6VUB
	v3XFP2I6RvesD9T+pzebMBI577/orIadwb3PAiIbf37i+dgR6j7DVTozXfNt41ksxC0sx+EiTH5
	eUYF1+FAIqXB6U03umU3dTvX7awy/RC16cmvuzHSdWARW8+1eUZMkM=
X-Google-Smtp-Source: AGHT+IFdanVNfWfNv8HWsgTltRUqGbgVYdYb/7YWgH/k9KVu04DfDvwoBsaR56HasWl+Vm1bcuV82HMzZ0TGHEI2ctM=
X-Received: by 2002:a17:906:4fca:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-b1bb17c9028mr565217566b.12.1758170607385; Wed, 17 Sep 2025
 21:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <aMs7WYubsgGrcSXB@dread.disaster.area>
In-Reply-To: <aMs7WYubsgGrcSXB@dread.disaster.area>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 18 Sep 2025 06:43:15 +0200
X-Gm-Features: AS18NWC_NdTi_yqxzEjcc4DGgSbWqBjqdGn8xuCbd_fnQdBXhfAk81_WXjHssKE
Message-ID: <CAKPOu+9io3n=PzwFPPgmGSE0moe3KDbyp7MXmwx=xU=Hsvqrvw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Dave Chinner <david@fromorbit.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, amarkuze@redhat.com, 
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Mateusz Guzik <mjguzik@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:51=E2=80=AFAM Dave Chinner <david@fromorbit.com>=
 wrote:
> - wait for Josef to finish his inode refcount rework patchset that
>   gets rid of this whole "writeback doesn't hold an inode reference"
>   problem that is the root cause of this the deadlock.

No, it is necessary to have a minimal fix that is eligible for stable backp=
orts.

Of course, my patch is a kludge; this problem is much larger and a
general, global solution should be preferred. But my patch is minimal,
easy to understand, doesn't add overhead and piggybacks on an existing
Ceph feature (per-inode work) that is considered mature and stable.
It can be backported easily to 6.12 and 6.6 (with minor conflicts due
to renamed netfs functions in adjacent lines).

