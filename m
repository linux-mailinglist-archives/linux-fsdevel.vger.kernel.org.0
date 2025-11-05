Return-Path: <linux-fsdevel+bounces-67185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C6C375E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 19:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE313B5580
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6442989BC;
	Wed,  5 Nov 2025 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gisM+4T3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2974F261B8C
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368032; cv=none; b=hBxM3UN0TJkG70H/794g/pK/8sPZUtYzlBNuIiJsHmiFAGvAUUfUqzPbYHvzokLhtQWRiGpDxmRGSvC2RrRRt2717LtfRuiU6tzSvQcQPx9dhlIwDhgiZGGzFk6clohJ/UjaRU6s6ZUGaDEzN6O0ruOVAn41XVRWkGZ+UQxs2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368032; c=relaxed/simple;
	bh=AvBw7pIapYDjfqbEZ1bgncfbRO2NgqW+PZq/6jkqGM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhBnBItRbnW3+AlUPc8tBZx0Gk7FGheqZRQ5Urq5ExWry3QgZPmcWiDJdqyieUge8hJfBxlsDw5SiiIk9zg2s9QhYen7lwl6+9h7dDiKg8moGQ7wXUjTm4P/0lCY01noMuP7/OiuH3dc0i3/kgDIXdjO9U56Tav9c1RpagrpS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gisM+4T3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so127743f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762368027; x=1762972827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XIyQJV0BoOq8cM6bW2Nc4tys93TVUqC9F2FCguuU5Y4=;
        b=gisM+4T3Q9267eqJ1ys58qBqAdKRrmOcVQb1cdNiSx2qEd6cyvWlRcW8mUU8WvIePz
         1HrZfi4mV+sXAsV/7HQHl1PJQmjJb667uvzaCzODUDwSeMD9VZv76Ye7JZyc5T2nSzp5
         ZuXCqKHPHPXQra6fPgpeIB7w9aXpQPJXACBYR8fWFMxgSz3Kvs1JAboHCMbeQB3C+2Wa
         0wLyX1yRhzSG1+7YSeGI9RNx8iAFDkUmKxSncp8mB7DrF06FvWOqzhpmJHKiIkynBLsw
         w+I38X/mNLUSVaukwi4bauaUP0xoBjL5uqF+s80cMD7Shg2gfpNSm5mfzEXHN4hEEUy7
         X7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762368027; x=1762972827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIyQJV0BoOq8cM6bW2Nc4tys93TVUqC9F2FCguuU5Y4=;
        b=AlRRqZK+xLZvTeK6WuwhGcv8CCSRuREE2VlW8BDotRjiv+Z1FXtPK8gFtgpgcFdrtk
         hGE+eOf1gfRCFbwogqVrtpqT92YY9UVXYv1u6K7x/1mJyri5U1WcgtSYAoiwLQV+KWHQ
         hKB0Dff0ZF1T5Lh5Op5P9/elCWc/HLgzcYVXxnUwTUWV57Q/ca2gIfW5a9wJLeCkq00F
         ABLMT/ID/AiV0vxZyBIySsdQaOCOk5uPuSbIUYLZC1/bOsCgY9t3fmolP6QZJRC4o3/V
         ZjgFwow4rZ4Gjrh2Xe16VMnyTAruNcn73WBhm0KpAeU1vR9MAGrtsfUs3Nw96T5YTj5T
         XK2w==
X-Gm-Message-State: AOJu0YzlP26IPqBQoKtVdUA7ktZ3Gred60wLwYSYisgDWZGHHNUhhq6v
	9gItztoEdJcictaV0JQV1IIQWDDkezv00C4X02JIM7wm/E+yIknuLDGA0kFmSI3AYMIZMy3w3Ph
	s6XzR2+4WoV05ystSKJjcS2COh9bIGTUEKJsxopviWw==
X-Gm-Gg: ASbGncsWnpXSBiXlmIb9QzysFB32KB3SxwnFThCyni7j63b9p22nXAoUz/oWAahcW4l
	4AmuM9xk034X0s9nWIUDdvGd1mRr1MyutbXe4xL3gAPEntuqdwQaCeT5grIUuKHqmG75f4L3Spm
	JyXEqTA/xFTfxlrswrBo2d5/hu+4cFzhxON7Od/WoNZ2QzQ2Js5mqfZajdP98PMMxGLz828fpxV
	8q/8IC3nhYCAYFoaWfqADZYJiK0eP0CJnX+RwzpIxuovAitdPWc7mmcBy744fpuMaKi2/PldH8N
	kEaR97vb1YbOhLXpMNLoQlFaNjZxbKnVnTge47+/tNTe+vW/66l1Rd6+zw==
X-Google-Smtp-Source: AGHT+IE7JHWAjENwi47IGOpfVP4yA/c0uXNjUPhrOCm2JpvPKV7uVzx/cwlCOY7h0IJ+8GoTWuRVpHEfcxcTPv30XiU=
X-Received: by 2002:a05:6000:2184:b0:429:b8f9:a87e with SMTP id
 ffacd0b85a97d-429e32e9348mr2957432f8f.20.1762368027493; Wed, 05 Nov 2025
 10:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org> <20251104-work-guards-v1-8-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-8-5108ac78a171@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 19:40:16 +0100
X-Gm-Features: AWmQ_blzod4RW1ZTgCh0cBumT4ZK5h0yfmsbksJOvdN6HEySSPMcZBN44FECEdQ
Message-ID: <CAPjX3FfyQ4wDD54_=wz62OBsSO30C2f7dmXZcKEu2JgpuER_KQ@mail.gmail.com>
Subject: Re: [PATCH RFC 8/8] xfs: use super write guard in xfs_file_ioctl()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 13:17, Christian Brauner <brauner@kernel.org> wrote:
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/xfs/xfs_ioctl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index a6bb7ee7a27a..f72e96f54cb5 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1408,10 +1408,8 @@ xfs_file_ioctl(
>
>                 trace_xfs_ioc_free_eofblocks(mp, &icw, _RET_IP_);
>
> -               sb_start_write(mp->m_super);
> -               error = xfs_blockgc_free_space(mp, &icw);
> -               sb_end_write(mp->m_super);
> -               return error;
> +               scoped_guard(super_write, mp->m_super)
> +                       return xfs_blockgc_free_space(mp, &icw);

Again, scope_guard where not needed, right?

--nX

>         }
>
>         case XFS_IOC_EXCHANGE_RANGE:
>
> --
> 2.47.3
>
>

