Return-Path: <linux-fsdevel+bounces-22723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AD391B575
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 05:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33C41F226A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 03:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E3F1CF8D;
	Fri, 28 Jun 2024 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A81MQMDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E91C6A4
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719545360; cv=none; b=kZ/xcsFh6MwEeVEgl5bCxJDmlYozYRI2g0TCgPKb2NPegCBo2K1ri+/MYQ2vWbVBaIb+aIjUEmgRG1AzznUOYRFyxixsDYfNZjUeEKiAU5MArgt2whGsKnVwbeStqHQMAUPGXTqT/QshCUdy8uvnbuK/oncEgbQHbi/dRXvmIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719545360; c=relaxed/simple;
	bh=eJXoADUsKZMimdxWocx/WkvVwc6sHSFgcf9k7AofelI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWxsZ66CCLsnN43Z8zott4TAGgrWm1pmKTF4mh0ON2ihNKK0V1itQDHN3QTForSCt+F+t9YcdYIrp/F2iOf/vhi/w8N0Z7A+skZ99pRWSXQZyDKGZdiW8VOEeL2LSJh+cWpnD+un6wgUEQTBSYb+EXViaDG/J63l7/seKPmTUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A81MQMDt; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-64546605546so1758757b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 20:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719545357; x=1720150157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJXoADUsKZMimdxWocx/WkvVwc6sHSFgcf9k7AofelI=;
        b=A81MQMDtingnuHjKJguAWPLHu1sCtq4V1ZR/nmO1+cRRZEKNzacAkMM64yls8CPK/Y
         ZKUsyS3FB5tY1/HDrjj6dQcQnHgnUwvHnVCGxlmaJVw6wMflJe1Q64YIzZmAs3Lx5cdJ
         jSSoke13ET6R7ffYnaDYsSYjF9sjg+gqk/LaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719545357; x=1720150157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJXoADUsKZMimdxWocx/WkvVwc6sHSFgcf9k7AofelI=;
        b=GeJqiszj1VM8VD6MEYmRjS94BMClu9uuTvBsJsraRqBplUwijUdNQ2QB5a6D3vab2J
         /rsmHeWJYtMaSuFadvDKm5lqapypG+Sk/cl6XmrT5RaHm9JxbqpVgSvHSAF+Pb7UOuWd
         81/ySH3jfPM73qlan/s8uDcHEqSwide54rWlshhAGssXooa8MN7zwovBf6xA2NXfqm1Y
         SXGFl/aMgN4bn5mfHUl7tqCShQX0OLEIL1MC9sUrMwWTleETpKq/1t9wNJ/pir2bSxaq
         zFZHN87c6xhVDp69ljrsfUryt9gsTBvujMKwXufaEgw5ISoVqFZbjf+6IlPyXEM8pPhe
         dIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHrE9A9VL/0aRl0XJAGPu7TJfn6J5ysPMhM+4qAjl6YOAMNo04UsKaPviM4DXFDgE/rfNaSiR1suKcwKzGn9jY0PiZPiMzahal+RFyxQ==
X-Gm-Message-State: AOJu0Yycat09XhWphpVmhsY0aE0iMmn+u1xGW2J1J0ghGn8ruNryfhkX
	ng+aXIiLBinynsveEqVfdDMMJlpirykyO/wSk/4z/w5ImV+AjS4zbWvCmlH9v/vhJf/KqMJS0ml
	CjM1wMktT9Xys9Ts0/jSQHRiuGYKusZn64fnj
X-Google-Smtp-Source: AGHT+IFagIXQzIbY7lZbQTWRffUJhXxWmEgTHoqjhJcGAchyoydX9DqZ9sKXXWJjPG0EBC6MQX6XpiANhcNqm0ydIAc=
X-Received: by 2002:a81:5c06:0:b0:649:fa54:1f91 with SMTP id
 00721157ae682-649fa542026mr30277807b3.44.1719545357548; Thu, 27 Jun 2024
 20:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD90Vcbt-GE6gP3tNZAUEd8-eP4NVUfET51oGA-CVvcH4=EAAA@mail.gmail.com>
 <20240619135732.GA57867@fedora.redhat.com>
In-Reply-To: <20240619135732.GA57867@fedora.redhat.com>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Fri, 28 Jun 2024 12:29:05 +0900
Message-ID: <CAD90VcbVFm7YVsrubQs_B_baDHp432v4BuaAZ382VfT2XQ-hHQ@mail.gmail.com>
Subject: Re: virtio-blk/ext4 error handling for host-side ENOSPC
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: dverkamp@chromium.org, linux-fsdevel@vger.kernel.org, takayas@chromium.org, 
	tytso@mit.edu, uekawa@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

Thanks for sharing QEMU's approach!
We also have a similar early notification mechanism to avoid low-disk
conditions.
However, the approach I would like to propose is to prevent pausing
the guest by allowing the guest retry requests after a while.

On Wed, Jun 19, 2024 at 10:57=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> > What do you think of this idea? Also, has anything similar been attempt=
ed yet?
>
> Hi Keiichi,
> Yes, there is an existing approach that is related but not identical to
> what you are exploring:
>
> QEMU has an option to pause the guest and raise a notification to the
> management tool that ENOSPC has been reached. The guest is unable to
> resolve ENOSPC itself and guest applications are likely to fail the disk
> becomes unavailable, hence the guest is simply paused.
>
> In systems that expect to hit this condition, this pause behavior can be
> combined with an early notification when a free space watermark is hit.
> This way guest are almost never paused because free space can be added
> before ENOSPC is reached. QEMU has a write watermark feature that works
> well on top of qcow2 images (they grow incrementally so it's trivial to
> monitor how much space is being consumed).
>
> I wanted to share this existing approach in case you think it would work
> nicely for your use case.
>
> The other thought I had was: how does the new ENOSPC error fit into the
> block device model? Hopefully this behavior is not virtio-blk-specific
> behavior but rather something general that other storage protocols like
> NVMe and SCSI support too. That way file systems can handle this in a
> generic fashion.
>
> The place I would check is Logical Block Provisioning in SCSI and NVMe.
> Perhaps there are features in these protocols for reporting low
> resources? (Sorry, I didn't have time to check.)

For scsi, THIN_PROVISIONING_SOFT_THRESHOLD_REACHED looks like the one.
For NVMe, NVME_SC_CAPACITY_EXCEEDED looks like this.

I guess we can add a new error state in ext4 layer. Le'ts say it's
"HOST_NOSPACE" in ext4. This should be used when virtio-blk returns
ENOSPACE or virtio-scsi returns
THIN_PROVISIONING_SOFT_THRESHOLD_REACHED. I'm not sure if there is a
case where NVME_SC_CAPACITY_EXCEEDED is translated to this state
because we don't have virito-nvme.
If ext4 is in the state of HOST_NOSPACE, ext4 will periodically try to
write to the disk (=3D virtio-blk or virtio-scsi) several times. If this
fails a certain number of times, the guest will report a disk error.
What do you think?

Best,
Keiichi


>
> Stefan

