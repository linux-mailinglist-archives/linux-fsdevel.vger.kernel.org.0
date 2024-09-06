Return-Path: <linux-fsdevel+bounces-28807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C9596E6F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 02:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45D81F24BB8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 00:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278CB17579;
	Fri,  6 Sep 2024 00:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQNho9XV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070DD17991;
	Fri,  6 Sep 2024 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725583615; cv=none; b=cq6WfG0zP0lJYAL/hWlLnGUeQLKmPfWlTqcV6zGCkJ7+WLXKmwxVC/k+Ghuvl0lZgb9vleIGqN0ZMyE1W0tRiPPWbvAlWO27eMEQX6SoUNnj5ywkkmoPll9IdahZowMBeAvM2uqoyCqQ3W/+f9z54PTmRxIMxsthj/W9sJBmI7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725583615; c=relaxed/simple;
	bh=wraag6XcvA/xrmjSnurt8z/qaMokfuBHSFiv3OYVrrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GH4zA5AYmnnedcWIgdOz/YeIrSgC9OjPaEafo99R97hcNSfeksAUdn9r+WsihggFay0qAIFoRC5iRkUm9LBCXgM6+TfiOweVfnh7YBcuOXz4/BqESAeKzIy/4xAezkYkNzPa2AeC/hPpFg1zkgUMOEpVTbJpFHogbh4tZnTbLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQNho9XV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53568ffc525so1885991e87.0;
        Thu, 05 Sep 2024 17:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725583612; x=1726188412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjzXiDfPjHYS2m3qWrFYZULU3Lh4847YGs1rex0AjD8=;
        b=WQNho9XVtoujQH7psXpzJlfLDLGcPJ8Wo0OwGU7Mi33+4jUYMQKfidKsHdqvRvWfxO
         7YUVI6SM6QJERGvx3IKtnQG8PSt/ArYeXGMBBGGwiH3xIvH4mjLnfUhzD0FCuWn26m/f
         PyGu0AKSbzoYBGdQpBXI+2CRNjLwB1u6ZCev/68+40ts/4J5roL1X2NUW8ZI2YNZWI2W
         +SWX3gbi+lKCxPFR16Ijgxjc4VxFfZTjXUwr49/k18Eu9CipU28wDphx3i3lipAsPUtR
         9/LejdduF69QwU0CpCnttofOTjLQllkzaQjLH5da/w7JkmB2HpWh4uTt5Sh0J1m4LmhC
         VIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725583612; x=1726188412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjzXiDfPjHYS2m3qWrFYZULU3Lh4847YGs1rex0AjD8=;
        b=v7a6jJEKAmR/iOVlodv4ochs4G8Amu6Hc9zuJEfBjeeFvjsPlEFwOAVCT5trHq4Z/t
         rkl6QRPW2UOhVXQYL35nKmTBR2dpqW+CTkabZ/94Q3XXD8K2z8u77GEhXV7cD5FWfAsV
         E00JAUk4Trxn1brPH0wG7ctMceD/1fUVfuDiyUvjajlygSCOWje6lbYySSlOPLwoKCaY
         Ac6AYcOTeUbr8H4d+FjHCvjGuQQa+GI8l2r9EFAa+XzylsLVI3/Kai4Wp0pBOw9APQ3s
         a5FDOLygLyyHo1qclgFVfNKMwDfvC5M/PjvgyL2qH2chGflvUfY22GlEsrmGpF/S1kh1
         lTPw==
X-Forwarded-Encrypted: i=1; AJvYcCUXOLJlNUL0Rl71346vNalVmG6rZCdxr0ffk9nGm1anWYc/D7oeLn91uwLbM0IIAs/3c/v+7OzEHTeo@vger.kernel.org, AJvYcCVo3Cjittz6Yo6sSNNMSn1DTud99/FKcGi9tOxhDwuRvgjZKbcLwIbzp+8Gvdc8qBwEClM8VwBQ6CLWQIwP5Q==@vger.kernel.org, AJvYcCXYffpWljWkcrpF8qXRXgRyDnCjS24cJaQQHZOAGNv3eTdsBKmFOJqinVzM1rSi2zJY2HX9M8uU@vger.kernel.org
X-Gm-Message-State: AOJu0YyvRMVdC31dUwSl68F4XOhKx6lyxBSgrrZ3gXfRkV76UtPeKwKh
	RjxMtmZC4oh7hgv6SMxv4s6uLoxp6Mx4dhn/W4LZyjoZkikQeORyypjG9h3Q6TP0o5zXhlEo4Yt
	AoeQGZKnY5N11WhpGL99G8trdpSA=
X-Google-Smtp-Source: AGHT+IEqxH77xXmK7syoAkYdIL6i1q/zug9U1ZFp27ffeFb72Ar8f0dZqbEwFB1SbaA5SwPNImYC6xhXy2zChgDKHnM=
X-Received: by 2002:a05:6512:ea6:b0:52e:9c69:b25b with SMTP id
 2adb3069b0e04-536587b4390mr331788e87.28.1725583611619; Thu, 05 Sep 2024
 17:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1dihdj9avrsvritngbtie92i5udsf28168@sonic.net> <pv2lcjhveti4sfua95o0u6r4i73r39srra@sonic.net>
 <2450249.1725487311@warthog.procyon.org.uk> <6jnidjladjose5gvv7nmofs008dlrd4cn3@sonic.net>
In-Reply-To: <6jnidjladjose5gvv7nmofs008dlrd4cn3@sonic.net>
From: Steve French <smfrench@gmail.com>
Date: Thu, 5 Sep 2024 19:46:40 -0500
Message-ID: <CAH2r5muWjARBd67oXMCgZAkOekEd=naX6x_4aDhb8YXYBMm5Cw@mail.gmail.com>
Subject: Re: [REGRESSION] cifs: triggers bad flatpak & ostree signatures,
 corrupts ffmpeg & mkvmerge outputs
To: Forest <forestix@nom.one>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Shyam Prasad N <nspmangalore@gmail.com>, Rohith Surabattula <rohiths.msft@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:32=E2=80=AFAM Forest <forestix@nom.one> wrote:
>
> On Wed, 04 Sep 2024 23:01:51 +0100, David Howells wrote:
>
> >Forest <forestix@nom.one> wrote:
> >
> >> Write corruption still exists in 6.11.0-rc6.
> >
> >Can you try adding this:
> >
> >       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3Dc26096ee0278c5e765009c5eee427bbafe6dc090
>
>
> That patch looks promising. With it, I've run my tests 2-3 times more tha=
n
> usual, and there has been no sign of the corrupt writes so far. Thank you=
!
>
> >Unfortunately, it managed to miss -rc6 because Linus released early befo=
re the
> >PR could be sent to him.
>
> Will these fixes be applied to the 6.10 series as well?

It is queued for 6.10 stable based on recent email from Greg KH - see
email titled:

[PATCH 6.10 181/184] mm: Fix filemap_invalidate_inode() to use
invalidate_inode_pages2_range()

--=20
Thanks,

Steve

