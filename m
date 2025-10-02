Return-Path: <linux-fsdevel+bounces-63270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE25DBB3771
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 11:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8020938055F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2512F656A;
	Thu,  2 Oct 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK3/yVk5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D42F5304
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397751; cv=none; b=mYvPh2Wcl/Xuna4fzoYRziVHsvC4M0WTfrQIeXZL8Bhu5KZjaW8ThP1Mf24yYjhL0P2OB7/zrpodgfIABLH08F/FEXpUtSzMMRd3I/vtcypowlksKGESPhwrY9YU8uUPvK2W1UqiPSzSIR7PoFWXgTlMGo5Y30igS4MObjRPExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397751; c=relaxed/simple;
	bh=dElR2MbhldR/r8DbeR+AIAoh2wDkvubQxNiuGnWifvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9Neqz8m1nTi3fVxjbLdNoR63lzxt7DCaRt+WuC3Daum8nY8IjCRJ8DMPd7cwOnyXUJY1IwEtj4LTFGFIv2CwBSz/SMWniaStgr2yf49gLdXIhMn1MyOirQaP5DultWWPzvz6G9h3H+xkBu2VY1toaLOZfDepyV/PnHj8MPNuhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK3/yVk5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so1663214a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759397747; x=1760002547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Op+CPbYu549XPiN9NlK83Zo8eiPN37NMy718uhPRPxs=;
        b=LK3/yVk5w7TQk8DtD3Qj2h7zJYX2S9HutXxTtd89R5yYa8ZBI47iyCLulptMKbuh3p
         Qos5KPJl1v1HRUJtwlqUYqsYfwqkav4WdxSVcgCmJ9NQRCr5F/OenHv+yGV9E/21chZx
         DZZG4rrRdBEzRyjwVaj7djFZCzGCReh4FGQv29+jdJKnX/f+G7QAVAL1wpZUhVDKeuMH
         wrFVhq5yDX2qhfGZ9NenBuCnX0ljMMLiFyLfDOh0wkvt3sUc38Yq3WmSR1ZWcn14zbHm
         114YmaxqemaaOX66cRx78i4nnWzGvo5JMUFnFDZxPS1bex4dmzjsHlc+7YgdanS3pqq9
         Lx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759397747; x=1760002547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Op+CPbYu549XPiN9NlK83Zo8eiPN37NMy718uhPRPxs=;
        b=xGuOuVIncUjXGGn21aCnyOXHaK6ZkxtB5Hm6oVgXR2gYkOfy9P2lgQGrUejtSTclUc
         Ekh0ClxyMxD86Kj5kLLd1wFtmnO0cQfLYXdo7WsyIjC0UrB+JQcyRNKFRuwP7tk4KDg2
         s0D9Orfmw/DsGSGcJOyqRkhtzsxEgzsFcbKTeg10qa0MTIKsHY5EKb7YydeQInDTUv0w
         +lP/Lyu6EboeoBhGV1Ip2duHsGJCRalAQO3BvZltXgbw+bq6w2oOrPUcUNN5i24ZiVYg
         cUUOBkccAE/9fTc/dbn1cFUzK+HvC685URjavtuZ7pWO9ICC1FXlVez8emd20KepofCi
         068A==
X-Forwarded-Encrypted: i=1; AJvYcCWDeWSC8YjwjeVoBQ0sMc8oEagCDGeFCT0yOChX0hme6qj/Mpb7eLcXYpGxo9JTqB8Nh0QTYCvQhFOQebbk@vger.kernel.org
X-Gm-Message-State: AOJu0YwY3wpOt1r/xOmA3yTNeEJaLioujU6AVWtpkl7QRLCnon5kIvjf
	dD0UkDa5ox1v2TUBPt2szxsxprcBhPDokl4QxdmOP2S9wfzBCWM2P7Ae2M7ukjgmsS0oIsVNVGW
	3XtVuLqg7OX7bb+xrMSoynwS8rsLPMMIqtLF8GAU=
X-Gm-Gg: ASbGncvINGS1/C4DzmBiJMUtue5Ig9eqqgSP1gvqwmjz+wTUrlDxa9uyk7xV36ctR4P
	buRERE76H4zhUILeV6CqoDfK1qpLpsBi27AySQ/DFs7LW8MXdvo4pg1z4UjczKeaBKPXVsSbRy4
	1btCjZ5qHQ9LzYpBFXQPXgq/FjFNApuaAqGi1BU09dt09qMZuDoJlhiY0gMwArUWku5W7Ibq72g
	Y7p4mY57OHhLrRDUXRc9WuyUx9wdOm3HUtp0c40cAFk1SWi1tiRo+0ZjcpX4EvUmhPW0gzRXTgX
X-Google-Smtp-Source: AGHT+IGpGY+cZLZOtUxO1F/zPCerGgq66TeZn0PbPSICkDx4DlCtlxCta6YKFlC2mavz9WjiuLNkON4srAu1bOoGEsg=
X-Received: by 2002:a17:907:9709:b0:b3f:3570:3405 with SMTP id
 a640c23a62f3a-b46e479100bmr717446066b.34.1759397747234; Thu, 02 Oct 2025
 02:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001145218.24219-2-jack@suse.cz>
In-Reply-To: <20251001145218.24219-2-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 2 Oct 2025 11:35:36 +0200
X-Gm-Features: AS18NWC9xBPxxo75duKFbyb6P675XGvRqya-3whm7pdCc8_cYLRrr50R5lIBj6o
Message-ID: <CAOQ4uxhzJ=1a+3FqO1p0AmuOYWKdGvq7cboo49RF2ngGCJi89w@mail.gmail.com>
Subject: Re: [PATCH] expfs: Fix exportfs_can_encode_fh() for EXPORT_FH_FID
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 4:52=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> After commit 5402c4d4d200 ("exportfs: require ->fh_to_parent() to encode
> connectable file handles") we will fail to create non-decodable file
> handles for filesystems without export operations. Fix it.
>
> Fixes: 5402c4d4d200 ("exportfs: require ->fh_to_parent() to encode connec=
table file handles")
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  include/linux/exportfs.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index cfb0dd1ea49c..b80286a73d0a 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -314,9 +314,6 @@ static inline bool exportfs_can_decode_fh(const struc=
t export_operations *nop)
>  static inline bool exportfs_can_encode_fh(const struct export_operations=
 *nop,
>                                           int fh_flags)
>  {
> -       if (!nop)
> -               return false;
> -
>         /*
>          * If a non-decodeable file handle was requested, we only need to=
 make
>          * sure that filesystem did not opt-out of encoding fid.
> @@ -324,6 +321,10 @@ static inline bool exportfs_can_encode_fh(const stru=
ct export_operations *nop,
>         if (fh_flags & EXPORT_FH_FID)
>                 return exportfs_can_encode_fid(nop);
>
> +       /* Normal file handles cannot be created without export ops */
> +       if (!nop)
> +               return false;
> +
>         /*
>          * If a connectable file handle was requested, we need to make su=
re that
>          * filesystem can also decode connected file handles.
> --
> 2.51.0
>

