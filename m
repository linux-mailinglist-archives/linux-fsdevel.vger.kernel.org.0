Return-Path: <linux-fsdevel+bounces-66446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9DFC1F6A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A913B37E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A6834DB59;
	Thu, 30 Oct 2025 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq8XkqIW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187A34DB5B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818357; cv=none; b=L8aQIubF+KF82PMkJevUx/SFXG5Z6VlMT/T9XDhOP0OG9LyBG2nEYU5lfb1nDGIxoNICmScVG0SlVDIO5vspzUE9B7Cf3aPLnX3CFguli9f4dRMw5R0ZpXTGFLCMPrxtx6t0qmPeFpCO32hFG1IcvTS5ZhFKop1pr2NlGT9hprw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818357; c=relaxed/simple;
	bh=iDV5DK22WuCEdY4AmQ57XnULBuur6osRYOXSSnG+UVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMG1rgNqf0GI3iEb0pTN1y4fQt9rHlCSBZNxGj7YfNSIpfUwH54msa9Xgrlf/36IohrTFfun9Q7fxkXoHsAH4ttTIAWsKlE6kV42WhcZw/eyHpNtSMHSRCK448JiGKwaKxC5uyDJjJ7ravoy73pygbOc2Fu5VtFuXSkjzbYf81w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fq8XkqIW; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c0eb94ac3so1306551a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 02:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761818354; x=1762423154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpD3k61NnOSNSTsaTIxb5ljjk9GVG9n/8so0r6X17qo=;
        b=Fq8XkqIWvmQn+lz1wd/Ms9Xze6o+D9Lpr3DbWk5MFo5dZw2Gzsn+jb9xQyMivcpRM9
         TmggoqaUfSydoIUjYkE1BtcIcn6lufdMBy+W/jWiSDcFmyZH1rOWH2i7c3uczjqaGKK5
         HPvmDVneKT1oi8B1yBX9+L1WAQLLuBsd4mOiA+ZJhOsnHRrh918M8B3ZXquuL15uyEac
         e1F7QqBt4f0SR4v8JL2D+OowSLOulFQDAKZ6/PM4a7YQPmIsb58Edh0x0zvKPOw4JUDT
         rO783bRdmUMDeAkYiR4bkM7uMUVxTwZ8hwI7tr2SoinQR4XHl4h50jN1TX37v85lQw1M
         SpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761818354; x=1762423154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpD3k61NnOSNSTsaTIxb5ljjk9GVG9n/8so0r6X17qo=;
        b=WcoWpVZYFH4ZZabNMd85TJXr6LVL4Ywpc1ZyPTFoYayiVTVfeN5IGS/KAUMuLfELM7
         Gj15lPTTSLllGfT0cQtKZ8KKi5yjr3c+wOQIU57jUkmo/MhRURgf9K7hgSUhhyPI2quC
         E3N53I4O+nami3eMaNDmz4XTeGbCOWi2zivepgiHWEWg3ZyISYt7wg4URkXTkoCPUMy9
         /ND+V8FtJRgzMhgn46swCNG7Z7bd+m6wHK6sSo6hzh3MwRxkPw365DC2Xc5/8Kf8sNtm
         zWc95cXvP6QrAdtalRMPvhnh2mYbLHCyzxL/EMVyP4A+SsB5MZh1klCfNuIfdf2B9OZ4
         2UuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYSYxGQ9nMCk2us0tVdjl1zwV4rK04/M6xCZv8kCYPa2E0DVxikxc1wNvnBotzsdbO9g01jie5zXYViCeg@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMHGu9ThsSmHN+NHVxHvSIYpHkoJ2EYbq4chGAWWCijhgjXqi
	i+/PtTXF2L8eGqlOpXgnlgrEY6okhxOKvZBHw5CMDLJzY9W8Fc6TK0Q0XrhOXuPq9sKJ9jnO0FD
	oZvbzLJTX6a7OtribtcTSsXwfAJzu5As=
X-Gm-Gg: ASbGncs6dW3q2AJYD5t0SEs8hffiz1nKsDWwYs+7cTw+KxpwE4q1phiO2le16f+c/Xp
	r7Z8Xs6sMGgfEirj4p9zzOKnrKfNgerPsXzlB9BO6QpdXIyNXszaODCJdOoemgyeQ6OcEiqC6X/
	9ksUnUrFUss80fnYm/fNO6ssTVE2hDcipmCtnYL0ymJxpniwXwiwhvvnSuT1iAvUOIseW3d6UCH
	6AY5CzxmSGJkNhsmMsg7VG56wduRuJr+Op3+mc2kKhAAluJW6+QKPMUKUDSahQUryoSDkbDNR4W
	XPfK4Zs4irAc9/Reu24=
X-Google-Smtp-Source: AGHT+IECfW0AowktC7rpAR9jOUVHVTrAcUQI3EsdlHuCld6RbMqb0p9GvCyLoJJPmFsCmzlPOxfbwbARyp6O94HXv94=
X-Received: by 2002:a05:6402:2794:b0:63c:1e46:75c8 with SMTP id
 4fb4d7f45d1cf-640441abfdfmr4652253a12.10.1761818354101; Thu, 30 Oct 2025
 02:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs> <176169820014.1433624.17059077666167415725.stgit@frogsfrogsfrogs>
In-Reply-To: <176169820014.1433624.17059077666167415725.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Oct 2025 10:59:00 +0100
X-Gm-Features: AWmQ_bmywm88Ipii2p-8p9X04wBzjPV1_YRjjWyLqxG47uKKxElN83Mj_Aaq1LY
Message-ID: <CAOQ4uxhgCqf8pj-ebUiC_HNG4VLyv7UEOausCt5Cs831_AnGUg@mail.gmail.com>
Subject: Re: [PATCH 02/33] generic/740: don't run this test for fuse ext* implementations
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:30=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> mke2fs disables foreign filesystem detection no matter what type you
> pass in, so we need to block this for both fuse server variants.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/rc         |    2 +-
>  tests/generic/740 |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
>
> diff --git a/common/rc b/common/rc
> index 3fe6f53758c05b..18d11e2c5cad3a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1889,7 +1889,7 @@ _do()
>  #
>  _exclude_fs()
>  {
> -       [ "$1" =3D "$FSTYP" ] && \
> +       [[ $FSTYP =3D~ $1 ]] && \
>                 _notrun "not suitable for this filesystem type: $FSTYP"

If you accept my previous suggestion of MKFSTYP, then could add:

       [[ $MKFSTYP =3D~ $1 ]] && \
               _notrun "not suitable for this filesystem on-disk
format: $MKFSTYP"


>  }
>
> diff --git a/tests/generic/740 b/tests/generic/740
> index 83a16052a8a252..e26ae047127985 100755
> --- a/tests/generic/740
> +++ b/tests/generic/740
> @@ -17,6 +17,7 @@ _begin_fstest mkfs auto quick
>  _exclude_fs ext2
>  _exclude_fs ext3
>  _exclude_fs ext4
> +_exclude_fs fuse.ext[234]
>  _exclude_fs jfs
>  _exclude_fs ocfs2
>  _exclude_fs udf
>
>

And then you wont need to add fuse.ext[234] to exclude list

At the (very faint) risk of having a test that only wants to exclude ext4 a=
nd
does not want to exclude fuse.ext4, I think this is worth it.

Thanks,
Amir.

