Return-Path: <linux-fsdevel+bounces-70757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7195FCA6401
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 07:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25CCF31A1F92
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 06:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC902EC553;
	Fri,  5 Dec 2025 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsFzn+sk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E72BE639
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764916787; cv=none; b=oUQgwN/LoVtn5ZvOeKE0wAvN9uLuDrgyO5+Vgv/vKGMDDNudyX+zP1T3/qUvqwEhyEbNuIhlgcHhd2KmzkRMkVXLhhwiTUwYGqmIxpcSyPRJKqGp/2s0Id4hdw9S3sviWWU9vnRJ2zHd8ji/eTf3oQrBPhUdFauvrlinZOrKxn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764916787; c=relaxed/simple;
	bh=3WBGjchHIhqGl3f6UUJQZOvG9cnxXcS8EToPfFW66Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf2PCYKOKkxNI/X8oiVsXocL/AkCGeSjfe8qrNjzCxd/xRRc9XMvbECLYv+w0TaXr2WB06Fe/rS/jmqZ/YH4yCMQlK/k9RB2VTEmKxtnaoLjssRlHCmiAN0HAeCHpLDXtIAPyCTIRjcMpYbPp7g6GSltWOjP8Kbzv8TdetzpcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsFzn+sk; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6597455d07aso900694eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 22:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764916785; x=1765521585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xos3/gKqsqARg566cAUpDT+mdSxuLsIU5NrhIm44L6M=;
        b=OsFzn+skYubCa8P93OtYuVT9/1OPBYxdZtZUGPG1XxVG/yw8owtamU2vniKoHoSsXu
         XtFjDyUNNPfOqZCcLD5/MhdCK+XSG+789lvXYXPcxd/bswUq1OyekSvIiUN5naRaVdYn
         V7FDkEt95y+9/6flS8dnkvMF5AOCsQ844riOg1vCpJfRcoo9soirMPpHFzLp5td7Robs
         jRrlbbxul2RneDRQDoH4vvlnK9WjRAdPVA/EA8ZdvoStaskoymGaSs7lYgI2nDsnFT8L
         k06hzRgJrKbqM1jzhndWxvnEA6exZGwKXOVGFaVrf6On4i/jsKmIpqqCH6rVBdpkSbos
         yOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764916785; x=1765521585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xos3/gKqsqARg566cAUpDT+mdSxuLsIU5NrhIm44L6M=;
        b=qbxM0kwaHzP0X4z/KsyCd9yYnvy8Ct3pWdHeqvMPivTiLIoNZavTi/PyBMVz4MRSP3
         1ja5OrVdXid1JLpw3oH76Pr5CdUGDJo8CZlFSdrapK0jh4WB2+kPaRtCH39qpg490h+y
         j4GD3rRqRECW/B0QvlAKU2SqG7qQfdZwV4KJlQX6FTB7hMM564zz4f7y2sJvAkRrQCz8
         QMbGddqVNtsoRZov4MF/e+FEAkss8apxQfNs9B0L59wEWvQOHNl3FTgsmpnXP1dYehBQ
         PFpTCHiOv03z2G4Uk9Lky6aTgsFYfRCgwWF4Q8CFCAHxz7GptC7W28M4I1ENYZhrNWDH
         ZKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXATgAocTlVs5jBOtkxdU7zprHCvdKZ2VX97hUoLaK2Bk02sZF8Ii0ILjcEbhPHiUFZ2D+KTO40ryAqglA6@vger.kernel.org
X-Gm-Message-State: AOJu0YzhAVKkazo8/Q/suc2UsLbazHIY4qAKsAjGhpIoqMMWWJ0JYZ1D
	Zrt+9qbiVcqsQj6pC/2ERUkunQGHRJ0ms4Tj4JE+br7KSdG37hgUu0W8EY9qV2Qd3iu6ud3xLQ7
	g07KH7srz8t5Ad7Exyo0yTnISsa1QISNyslDw2O0=
X-Gm-Gg: ASbGncuAPv6J7ZparQVFmgDu2PWlhGLMwYrEhad97gUzxpcFVEsS1WPCiUf0TZJeZ2D
	JlD3ZXjCSMRLZJXe4zdvAY+0PjkTuIG06RqM+3wMF0LwiKIFC5CLjQTAKhPbpXiOR3nJjNQuuS/
	YmKXsL2G6RUVS3fO4G/EQTQnESNxUWpwr/1/4sVUliJK51bcb40xqIaLIhzBpeiMHC2WXgpbQl8
	hvs5bFEIgjzkbogGnfGIALV66mjIQYEesyutQcag3kaQ/kAXzHzE6Pqa47BUVpL/zcsnKWR
X-Google-Smtp-Source: AGHT+IHbvPZzUKtzKOwSB0dGiwkv726da9NNiQT6QaR1QMK1BNnACaPRk9hA/hPZpkFIaQtQU42Cp1O5EiqTIF9MfqU=
X-Received: by 2002:a05:6808:6f87:b0:44f:fc93:f612 with SMTP id
 5614622812f47-45379dad9e6mr3120038b6e.32.1764916785070; Thu, 04 Dec 2025
 22:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205005841.3942668-1-avagin@google.com> <57a7d8c3-a911-4729-bc39-ba3a1d810990@huaweicloud.com>
In-Reply-To: <57a7d8c3-a911-4729-bc39-ba3a1d810990@huaweicloud.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Thu, 4 Dec 2025 22:39:33 -0800
X-Gm-Features: AWmQ_bmnaGxfuYW3uI63fXs7wkN5Gs-TsqIbCFxvBK_--CTpOzbn9u2q1u0Kpoo
Message-ID: <CANaxB-x5qVv_yYR7aYYdrd26uFRk=Zsd243+TeBWMn47wi++eA@mail.gmail.com>
Subject: Re: [PATCH 0/3] cgroup/misc: Add hwcap masks to the misc controller
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	criu@lists.linux.dev, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 6:52=E2=80=AFPM Chen Ridong <chenridong@huaweicloud.=
com> wrote:
>
>
>
> On 2025/12/5 8:58, Andrei Vagin wrote:
> > This patch series introduces a mechanism to mask hardware capabilities
> > (AT_HWCAP) reported to user-space processes via the misc cgroup
> > controller.
> >
> > To support C/R operations (snapshots, live migration) in heterogeneous
> > clusters, we must ensure that processes utilize CPU features available
> > on all potential target nodes. To solve this, we need to advertise a
> > common feature set across the cluster. This patchset allows users to
> > configure a mask for AT_HWCAP, AT_HWCAP2. This ensures that application=
s
> > within a container only detect and use features guaranteed to be
> > available on all potential target hosts.
> >
>
> Could you elaborate on how this mask mechanism would be used in practice?
>
> Based on my understanding of the implementation, the parent=E2=80=99s mas=
k is effectively a subset of the
> child=E2=80=99s mask, meaning the parent does not impose any additional r=
estrictions on its children. This
> behavior appears to differ from typical cgroup controllers, where childre=
n are further constrained
> by their parent=E2=80=99s settings. This raises the question: is the cgro=
up model an appropriate fit for
> this functionality?

Chen,

Thank you for the question. I think I was not clear enough in the
description.

The misc.mask file works by masking out available features; any feature
bit set in the mask will not be advertised to processes within that
cgroup. When a child cgroup is created, its effective mask is  a
combination of its own mask and its parent's effective mask. This means
any feature masked by either the parent or the child will be hidden from
processes in the child cgroup.

For example:
- If a parent cgroup masks out feature A (mask=3D0b001), processes in it
  won't see feature A.
- If we create a child cgroup under it and set its mask to hide feature
  B (mask=3D0b010), the effective mask for processes in the child cgroup
  becomes 0b011. They will see neither feature A nor B.

This ensures that a feature hidden by a parent cannot be re-enabled by a
child. A child can only impose further restrictions by masking out
additional features. I think this behaviour is well aligned with the cgroup
model.

Thanks,
Andrei

