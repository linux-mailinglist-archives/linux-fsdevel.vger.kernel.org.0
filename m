Return-Path: <linux-fsdevel+bounces-71655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F11CCB6CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 11:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26ACF301848E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 10:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863832F755;
	Thu, 18 Dec 2025 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAQf9yXP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B52F617D
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054243; cv=none; b=X9OFa16SilAPztBFHv5aOOtBTGS0sF35+6HUA3x0N8TEPPhpaJDvjrqxeKoCZjCKeKGmKhmKudMWPdMIvtVVgK94ZcFAk4YB74/gUfuO5Mo9kLKsBuYdmNRXe/P3FF0dqwqch/sOYgMl/uJD7zHD0b1tO6Egafcqf2PxeYfQjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054243; c=relaxed/simple;
	bh=IuOTfb3lLj0gtabV7omSu2xz0+Bp2f5JB0yCBLcuQSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DU+InvDCsr6o6BRh2udUoZiA+ToHSkksMWIWhoFh2kEByZry5MkYKHuYTS2vfxwb67HE8b6fs/pyAaRqW3sPyHrV6gYhwvv3rOZLHffDefWIFRw9uArBqWBgcNiM+rCcj6/3Eh3OnJT1UjTMOH1+2qgh/oft2+dGcXSDe/Ew9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAQf9yXP; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bf1b402fa3cso488949a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 02:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766054242; x=1766659042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z75uRcgro6LKMAAGXHvWW3/RKLL5y/yTiUe9tOAv4zs=;
        b=LAQf9yXPBI9k3UVD9HoA1CgG6Va3gDPyyVZYISt2LEEBLoCqQaiQCK19BdH7+2HNEy
         1rlHMtBsK/FGW6J6ycxCm2nrycvZ7OeXjw/D46Ol+D8HmwtRwaLmTnWIQqJldTjIhenM
         j6LzblNeciV7M5Iu4xhl5uLs4U17n0s3xpB4WlemPbX/7Q3guky56cCW+Xr0ESmLnet3
         iK/DN7kjZl+RHSYON23Wzsfx6EmhmTz3Y2uojNbFQhrYKLX/2Sl5T2JRF67jO0i76JSX
         +1fRjJOs+IJ/Y/ik2ZuLV5sieuNuTs82g5vrnygWsSVqUWUtpv9T8SVBOFVLXw3eDo2D
         GaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766054242; x=1766659042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z75uRcgro6LKMAAGXHvWW3/RKLL5y/yTiUe9tOAv4zs=;
        b=lrDDWRDPVGl/JpTCdfqaq9nzANeuI77dlVZShw7+U4wPMQ3wcwRYHS9ywRbj3RdIus
         5a/EZo+OOr9vvezI68XXP1Lj/opLwz/BEYE07gWNFFIzdwKEOjPqGE0QvJiViI2/523S
         Y3JbvuEOCeIJywwfPuPX7S8EA5ffsC/nJqbsO79SZiJ3c/ktNhRH8c0K/XvbuFrisITo
         LVFUCUV3paNZ4pJYvfa5lL9OJmfOUpHq6DB+YePzd6x/VnzBA0UNSenoCIe3NxpXlFoS
         uhvZlsdDrCivSRQy0OURzcSOu2XEmu2PbE2wY23H7rIlGim6g/Sz+huAbuf7eCfJenDK
         UFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVogNE5Fnwj3p6ng9Y8Air24BNzoVh/Zo5oidtGteTkPlM6I+iKEFjT2MwpePgyrzObPxmz1p6jMFS+QJli@vger.kernel.org
X-Gm-Message-State: AOJu0YxUercGS/uTgGOg6j9xOacC3hAXFRnko/a8T6hKqqH+RQ5OuE2y
	GvY8G3B3g80kmrgj/VwPZ37G1tgPQ7y7zYBw0ejQA359IN553Su7p31LhdFAe0GdhyJzjrviMMP
	fuU36DIjk0gVRfcPhlqE8el24Dmk3lEY=
X-Gm-Gg: AY/fxX4YBCSE1mU66gHBbCVdeFfs4qFPB3z8LSv2d5iDSy8CWYFxXAX2e9lul88i3Pg
	boxiR2ySIFYmmuSJSSMvB9sagIsZRGdAvJ3vuFl6HSbo1aihEktuBOKctxPsuFTjCtoWX2EbTGe
	FAPazO6WgawJoJm3WBOfprj0RVbKstssMSnQvxg+cu1aY1BxTav0yDx8ia1H16W/Plc6qc/8aXF
	M2+3MC0TTY8YRPIls7wAF6OSnSeC9I7K9rop7QF+hkqMHNAorSzgcsAPVKqhmm8ehkMnSQ=
X-Google-Smtp-Source: AGHT+IF5UZcHGl6F1FKSYKUt2aGFnGQgfg/iINjTf635blGax4A17hhn2ud4VDyWJCoj6evsChYwN6fyjxpqsLdtklE=
X-Received: by 2002:a05:7022:b8a:b0:11b:d211:3a64 with SMTP id
 a92af1059eb24-11f34863cd1mr19121836c88.0.1766054241600; Thu, 18 Dec 2025
 02:37:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216200005.16281-2-slava@dubeyko.com>
In-Reply-To: <20251216200005.16281-2-slava@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 18 Dec 2025 11:37:10 +0100
X-Gm-Features: AQt7F2q9n6B06XMlN9W0DzGnhk5ayXYGI6LMPtZE9i0PYNPDhUkMyTdX7TwL5NI
Message-ID: <CAOi1vP88-aV+EXyVEgfiqUoSuqmaJnZ457uG6QrnOG34kimE7w@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: rework co-maintainers list in MAINTAINERS file
To: Viacheslav Dubeyko <slava@dubeyko.com>, amarkuze@redhat.com, Xiubo Li <xiubli@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pdonnell@redhat.com, Slava.Dubeyko@ibm.com, vdubeyko@redhat.com, 
	Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 9:00=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> This patch reworks the list of co-mainteainers for
> Ceph file system in MAINTAINERS file.
>
> Fixes: d74d6c0e9895 ("ceph: add bug tracking system info to MAINTAINERS")
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..f17933667828 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5801,7 +5801,8 @@ F:        drivers/power/supply/cw2015_battery.c
>
>  CEPH COMMON CODE (LIBCEPH)
>  M:     Ilya Dryomov <idryomov@gmail.com>
> -M:     Xiubo Li <xiubli@redhat.com>
> +M:     Alex Markuze <amarkuze@redhat.com>
> +M:     Viacheslav Dubeyko <slava@dubeyko.com>
>  L:     ceph-devel@vger.kernel.org
>  S:     Supported
>  W:     http://ceph.com/
> @@ -5812,8 +5813,9 @@ F:        include/linux/crush/
>  F:     net/ceph/
>
>  CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)
> -M:     Xiubo Li <xiubli@redhat.com>
>  M:     Ilya Dryomov <idryomov@gmail.com>
> +M:     Alex Markuze <amarkuze@redhat.com>
> +M:     Viacheslav Dubeyko <slava@dubeyko.com>
>  L:     ceph-devel@vger.kernel.org
>  S:     Supported
>  W:     http://ceph.com/
> --
> 2.52.0
>

Hi Alex and Xiubo,

Could you please send your Acked-by?

(Please ignore the Fixes tag -- commit d74d6c0e9895 isn't really
related to this patch.)

Thanks,

                Ilya

