Return-Path: <linux-fsdevel+bounces-66449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B925EC1F84D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 11:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26B584E9B00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83915354AD4;
	Thu, 30 Oct 2025 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcU6vQfR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27353354ACD
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819928; cv=none; b=S/lvIj9UdKd8VlGAFmL6qj0/Ssky2MNvPFn6hVWwFsBubEilBDfG07ddFbHDJnAXXPZHwJbmTagVr8WNisKnOUGi1Cu7VHVwgevSVOpAE5IoSyHZmLENbmShDgeAPvQENXHP5I6iHrxwhZtaOM3nuaEVJ7dfn43qKYSkvSQ4cVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819928; c=relaxed/simple;
	bh=JJIWNnCoiCiguK9/rbFMg0f0XCv3XZGq85zbgk4m07s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXv0lrM8zsAYJex8czoDiTaSit3BurWMo3d0gKMm0kYvOvW8EGBDZ2mSetu5YggJ7Otusw7B0o1Dg56PIG6QLxfhB+dEgMmWirTSMy2R/TLCLm1BWEpiUvngbhYu7UjFmGP+Afrfp4DQ1pxyDP8TW466I5al54WKWj9HKIpBHYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcU6vQfR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso240846466b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761819924; x=1762424724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgOlSBWsltR3bwKZ0KqRU5bm8t/l2+tDWDnMT0PQAXc=;
        b=fcU6vQfR7+9qSnWQRvnD86md6lNKG5Pd/wTWJoW7Wg98i8LL3C2U1stMOizmJkJYQe
         Y8IcMIRergrEgRzZ3G+S2yrPfVKz5luZwBDVz7g8zLKSC6xKDYN60LZ3fpArJEphAcQ0
         WIjTVi0PG9jm/VGXYPauvzWEIjWEBFkLIUA2cGMIm7t92l6o1AXq1oo1//TeWLieg+k5
         khVPV4O8q1x78F6VH3cpUhTkRNW23Spi0Iv4Ypkz8UVMDv0D1cTZGn513If4v2iBRpQ9
         1UgjvL3+hspth9nRl86Ci4ltWRrUkzxc/zBnVdcffSEtIO+tiuIgrl5f24aAHgGXqZr0
         rHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761819924; x=1762424724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgOlSBWsltR3bwKZ0KqRU5bm8t/l2+tDWDnMT0PQAXc=;
        b=qLcbtPt7VgQzwCxc7EdSD29h+8fMq0y1Vd1LBjfc7OCvrC3ohCfcwJl1DZsnXUOopA
         ozLVBkxywCdCjSHLlz08Kni3+x4IpWuo3uU5AmjSb7S5OLC6HURG4HUkQK3/m7vGLyEs
         82fQgdqkmKomgfXImnUlJ5qVIc5K1ITuWEoGko2+XAHfTpoVQwdXz7VTOXpZm5NAGsSb
         G873WBpTFBjs1AT8fq+z8XLGaIh0aI8cxgAUThpZMf0lXQ2YOEgr5PdXxE4Gk3ZTqzV6
         KIngsHRck2to9ulvzpooJsjWVxKXBtFPIhZyGLUJkuNrRcTbW5NY/zioAAI2TEyAeIYq
         o9vw==
X-Forwarded-Encrypted: i=1; AJvYcCX7QYp4bBqFxf79ZVakRNQ/qFpkY2QwOVfLVdJnUknLwyLkhXbf2zUf5lNt7Q0/EMUtc0Wun0RL10pwyoTH@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJvhwYcCcZmBg6aLnNZX7BHIgUetI84gCLdm2jpEP9a+2EQon
	1dMsdEyi185TCmQpL2eZa1KR+bITLFQUwrC7lKOZzXvuPTTJDy+CFWb57gW3VI8CX/kI/olNbJ7
	YBtbtOH3RcZg/zDF1S8waQSNddEa6dyyglMOxv3Ix2w==
X-Gm-Gg: ASbGncsjJPbGX9dlCxuDgoBgClsTN9+PbvUrf4RNVjyyy9v8kXMWe6c32n34Omlp+ld
	WKJwBZucLPSGMoyWUGbuwKIykdkdzKRl0fEO2VwPBIbDHnYrwgbo1RI9VIMZ5hYqhPT4X4RUNdK
	wlApPI2PuRU9J91XEOzqaelOXbND4d8s1jIixdsa7Jk+R+Lpxxu62N5XrExalafJGGVNNkv9ync
	IMinSxB8qdUWRaDy8ZbOhXdsCeHOyCR6qA6rwZRilITS81vZddPtFX6eaBEqnGyX5cwWqHOIMlo
	yVQ9/gPI7CmPMPARSOE=
X-Google-Smtp-Source: AGHT+IG1s+J1qsSzRLjzHYiT/VYRPZob+nrmIAe/cGI1XD/nmjBEEnz4k4/6pM5ItnXuo6ggIslcbL4yDUTbDqlUHYY=
X-Received: by 2002:a17:907:1b1b:b0:b50:94d1:8395 with SMTP id
 a640c23a62f3a-b7051f6307dmr291641966b.9.1761819924384; Thu, 30 Oct 2025
 03:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs> <176169820405.1433624.15490165287670348975.stgit@frogsfrogsfrogs>
In-Reply-To: <176169820405.1433624.15490165287670348975.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Oct 2025 11:25:12 +0100
X-Gm-Features: AWmQ_bnLwEnVDgdX6KD058UE1kZn67zBdXIwzjqwbOoKyDUWo9XWQMSAUULwjQQ
Message-ID: <CAOQ4uxgQe5thjp_Pfmbwf-P+o9n7a93a7dzS4S0_Rnw--ULBfA@mail.gmail.com>
Subject: Re: [PATCH 23/33] generic/{409,410,411,589}: check for stacking mount support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:29=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> _get_mount depends on the ability for commands such as "mount /dev/sda
> /a/second/mountpoint -o per_mount_opts" to succeed when /dev/sda is
> already mounted elsewhere.
>
> The kernel isn't going to notice that /dev/sda is already mounted, so
> the mount(8) call won't do the right thing even if per_mount_opts match
> the existing mount options.
>
> If per_mount_opts doesn't match, we'd have to convey the new per-mount
> options to the kernel.  In theory we could make the fuse2fs argument
> parsing even more complex to support this use case, but for now fuse2fs
> doesn't know how to do that.
>
> Until that happens, let's _notrun these tests.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/rc         |   24 ++++++++++++++++++++++++
>  tests/generic/409 |    1 +
>  tests/generic/410 |    1 +
>  tests/generic/411 |    1 +
>  tests/generic/589 |    1 +
>  5 files changed, 28 insertions(+)
>
>
> diff --git a/common/rc b/common/rc
> index f5b10a280adec9..b6e76c03a12445 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -364,6 +364,30 @@ _clear_mount_stack()
>         MOUNTED_POINT_STACK=3D""
>  }
>
> +# Check that this filesystem supports stack mounts
> +_require_mount_stack()
> +{
> +       case "$FSTYP" in
> +       fuse.ext[234])
> +               # _get_mount depends on the ability for commands such as
> +               # "mount /dev/sda /a/second/mountpoint -o per_mount_opts"=
 to
> +               # succeed when /dev/sda is already mounted elsewhere.
> +               #
> +               # The kernel isn't going to notice that /dev/sda is alrea=
dy
> +               # mounted, so the mount(8) call won't do the right thing =
even
> +               # if per_mount_opts match the existing mount options.
> +               #
> +               # If per_mount_opts doesn't match, we'd have to convey th=
e new
> +               # per-mount options to the kernel.  In theory we could ma=
ke the
> +               # fuse2fs argument parsing even more complex to support t=
his
> +               # use case, but for now fuse2fs doesn't know how to do th=
at.
> +               _notrun "fuse2fs servers do not support stacking mounts"
> +               ;;

I believe this is true for fuse* in general. no?

Thanks,
Amir.

