Return-Path: <linux-fsdevel+bounces-70913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 250B2CA9406
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 21:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE2533133AF8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 20:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FC8824BD;
	Fri,  5 Dec 2025 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSaCfoNk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71693A1D2
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965958; cv=none; b=RfrPdJtrKaXFbbOt7G8hnp1QAI/KiG02KOPydBf2nG8pHv8nfxI0w1/D0TYjyIVYJuaNIKRbIn0klQYbCjPV2a+TLuEzQpNWRgQ1KGigSJa1ki7bjUiVWoD/UxKgMPByEkXcw+I5K+R1jc4dujfO5EflJl6XLjgJB/xfI7oQ1z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965958; c=relaxed/simple;
	bh=xbmCLz3opi4qCplJYdsJdq7LZGwK2jPD8ZNEWPkmI5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajkSmOvJor+YbgJ1UgPK1UZ9yh5ySFwYZKwTgyNPm0uuvExLMbWkJKOLAphjn89uhDgizginrSfSTq3JgimbUecI/tPS0SM/0vtNihgXOQXfkhas+yq3OIQUj1R90sCRnaLtlzBM2h1vIBFzgEQrneUtPAylsPZtZrh+XeGQfZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSaCfoNk; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c6d13986f8so2354335a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 12:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764965956; x=1765570756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr12v+DMAImdfz1AowemFJusGQ0cnaEVxPJMDmqgRC0=;
        b=dSaCfoNkYjj/YgA3ca2Ot/TiL/N8s3rdGYEosLv1h6SXNRjCK3Rd5XvgTyqw34ifHG
         m+lj+g6sBVu8urUSb1VkzF26mcdUkIZHzj0dFJxLwcV7FaXha/duKiVl4Se8t1B2dkyt
         y84z5luSTjUeQ0JD5W9I5dlVc/jXNyoPutxBKQtcBl7s+tQ5gpnKRq/7XQHWD9AGbyP7
         e9s33VWhE1vKyLo0T1UNjOWLa8yStaOWSWUXRMIvtTqYJXjQgi+/1+fvVuqDjZhcQVbx
         YT18XBb7CGHs2aXFUfBOGlKi7Bcvq8y5M6+wKn239VkiscBws/SYCZvmVSZ0bi5KP7Oq
         9BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764965956; x=1765570756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yr12v+DMAImdfz1AowemFJusGQ0cnaEVxPJMDmqgRC0=;
        b=gZZ9pdIaz2NURq4VGVhWjsTuCsJJut+TgHsqm9e64+GzaRlcrLasQk22iJmh6BA98c
         Wc3c7lLydXKjpuOH+FBpHzm0codGdWEO6dg3MNBSruH24Jyjv1qeYi/r4vyLmLBBadJf
         AU/w7CT9KmaFKKal/VibQqVfYnRS0nRfOvSXNE3u2s4ros9U89cpUuFjrFYtoB8GGg51
         7oVFOQBaMZZ8MKqLILMzyYF9ZlawV7EH3wzkKz/xahVbcuWMOd6MsqdlxkXX06pKhEaJ
         VHO36Hcy4fjHEyOZzv+XRwtgLHQUb+I0PfKOyo8lANF+RC/YwBMN75n9xUloJct8u/uy
         W56w==
X-Forwarded-Encrypted: i=1; AJvYcCWmYbf3GMWbX8/XHM0gujwVWOBBSrFJoUodxpgEXo6RYXOxEyxNnJZJKf4npZ/IQlBWjGIYtZ/h+x1qHLvT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9yAuAgGOl+9G4gvpEfvhi44XjmXNOfWcxsMQkNRzNGO86LCqq
	AqEXM0MBdbngrHvoq6d4k7LChA9T1rX4VZd5UM8v1Sntbw86SlcrnQzMxyEn/JuH7cVRg7LZxOI
	uprA8dSEckAvdRZbZARCUYQvjWZ8L1K/ved6clYXVXw==
X-Gm-Gg: ASbGncuhehwUtu8Z3ifDUH6W7zjTqP0HoDdifdcO1ge1GsQxq+3UJFiQuFCq2mIT54r
	9JhJe2MaD+G7kw0XMPrOlfBmGeA3GuWQd/hs9m3xsDswryDVoH+X81ZQlN5Pl+zZ+5WeCEuP/w0
	FV85PEjSH2/O9ARPrAZBDwjD3fSVzM0PVywJ5DcxARxxs0FQDLm91hlXGyU5WH0D1GXD/S43++y
	s+FIJcCzENXHHNNWxqg74AgHF9oVY2z3S/6orgvg9PAgjVKP8UnWGbK3sB+7Mnj3itZnkOu
X-Google-Smtp-Source: AGHT+IHwv0zV6pf0Mi0jmonA9X7SJfjx0KLsoUJL8YTZFGl2SAkAT8InplvChGboPRk86xwWowBh1fy40GkX0WBFhW0=
X-Received: by 2002:a05:6830:6aa6:b0:7c7:ad8:68b3 with SMTP id
 46e09a7af769-7c957c80e69mr5451091a34.14.1764965955996; Fri, 05 Dec 2025
 12:19:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205005841.3942668-1-avagin@google.com> <57a7d8c3-a911-4729-bc39-ba3a1d810990@huaweicloud.com>
 <CANaxB-x5qVv_yYR7aYYdrd26uFRk=Zsd243+TeBWMn47wi++eA@mail.gmail.com> <bc10cdcb-840f-400e-85b8-3e8ae904f763@huaweicloud.com>
In-Reply-To: <bc10cdcb-840f-400e-85b8-3e8ae904f763@huaweicloud.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Fri, 5 Dec 2025 12:19:04 -0800
X-Gm-Features: AWmQ_blYzl1FsACJBYWFF_FwJThgem-zZm9ldZnV3CqkFL-uCbsmPxPlFX-i5Z4
Message-ID: <CANaxB-yOfS1KPZaZJ_4WG8XeZnB9M_shtWOOONTXQ2CW4mqsSA@mail.gmail.com>
Subject: Re: [PATCH 0/3] cgroup/misc: Add hwcap masks to the misc controller
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	criu@lists.linux.dev, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 2:04=E2=80=AFAM Chen Ridong <chenridong@huaweicloud.=
com> wrote:
>
>
>
> On 2025/12/5 14:39, Andrei Vagin wrote:
> > On Thu, Dec 4, 2025 at 6:52=E2=80=AFPM Chen Ridong <chenridong@huaweicl=
oud.com> wrote:
> >>
> >>
> >>
> >> On 2025/12/5 8:58, Andrei Vagin wrote:
> >>> This patch series introduces a mechanism to mask hardware capabilitie=
s
> >>> (AT_HWCAP) reported to user-space processes via the misc cgroup
> >>> controller.
> >>>
> >>> To support C/R operations (snapshots, live migration) in heterogeneou=
s
> >>> clusters, we must ensure that processes utilize CPU features availabl=
e
> >>> on all potential target nodes. To solve this, we need to advertise a
> >>> common feature set across the cluster. This patchset allows users to
> >>> configure a mask for AT_HWCAP, AT_HWCAP2. This ensures that applicati=
ons
> >>> within a container only detect and use features guaranteed to be
> >>> available on all potential target hosts.
> >>>
> >>
> >> Could you elaborate on how this mask mechanism would be used in practi=
ce?
> >>
> >> Based on my understanding of the implementation, the parent=E2=80=99s =
mask is effectively a subset of the
> >> child=E2=80=99s mask, meaning the parent does not impose any additiona=
l restrictions on its children. This
> >> behavior appears to differ from typical cgroup controllers, where chil=
dren are further constrained
> >> by their parent=E2=80=99s settings. This raises the question: is the c=
group model an appropriate fit for
> >> this functionality?
> >
> > Chen,
> >
> > Thank you for the question. I think I was not clear enough in the
> > description.
> >
> > The misc.mask file works by masking out available features; any feature
> > bit set in the mask will not be advertised to processes within that
> > cgroup. When a child cgroup is created, its effective mask is  a
> > combination of its own mask and its parent's effective mask. This means
> > any feature masked by either the parent or the child will be hidden fro=
m
> > processes in the child cgroup.
> >
> > For example:
> > - If a parent cgroup masks out feature A (mask=3D0b001), processes in i=
t
> >   won't see feature A.
> > - If we create a child cgroup under it and set its mask to hide feature
> >   B (mask=3D0b010), the effective mask for processes in the child cgrou=
p
> >   becomes 0b011. They will see neither feature A nor B.
> >
> Let me ask some basic questions:
>
> When is the misc.mask typically set? Is it only configured before startin=
g a container (e.g., before
> docker run), or can it be adjusted dynamically while processes are alread=
y running?

If we are talking about C/R use cases, it should be configured when
container is started. It can be adjusted dynamically, but all changes
will affect only new processes. The auxiliary vectors are set on execve.

>
> I'm concerned about a potential scenario: If a child process initially ha=
s access to a CPU feature,
> but then its parent cgroup masks that feature out, could the child proces=
s remain unaware of this
> change?
>
> Specifically, if a process has already cached or relied on a CPU capabili=
ty before the mask was
> applied, would it continue to assume it has that capability, leading to p=
otential issues if it
> attempts to use instructions that are now masked out?

I wouldn't classify this behavior as an issue; it's designed to function
this way. It's important to understand that this isn't enforcement, but
rather information for processes regarding which features are
"guaranteed" to them. A process can choose to utilize unexposed
features at its own risk, potentially encountering problems after
migration to a different host.

Thanks,
Andrei

