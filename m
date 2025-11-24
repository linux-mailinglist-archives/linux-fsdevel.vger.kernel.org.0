Return-Path: <linux-fsdevel+bounces-69616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20ACC7ECD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 03:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEC33A4F44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 02:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074612773C1;
	Mon, 24 Nov 2025 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXRnBiLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6CB26F291
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763950076; cv=none; b=Dk3OiFQFK+mcsddvfhlL2vQKmoJh5Q7Ul+09LvmUKVKWP46/zb5Xe2EDdzJHN/+88v+rvTpBcch7Roo/fPhiasqrLyJbpa4uh0n/W/IpNSAEpWmlUkYQfyyj5MPy+0O3t7nWrm7G0vPYE0Q9+w6p4TRyYio4ZuV0RiEG4GLO/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763950076; c=relaxed/simple;
	bh=nDSl1rf872vF+vs2chU5zrYxtLKFWia5n6STQ5uHYUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odCi4lWs/ObZoOrfNRqjSlcsb2wEbf1SFRJVa/Yu033OqjqvATdYyJizqXgQRKOxGQE8N2M8hNLuCv+9Xg4nHN8HQotKtwVKA5xAWKkB+oJDl3Vj//6T9J7QR+rSpmgDI78q3GZz+QaBxV1XVkAHdjiEdKcIo3kSwq+UvV8r/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXRnBiLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA516C116B1
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 02:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763950075;
	bh=nDSl1rf872vF+vs2chU5zrYxtLKFWia5n6STQ5uHYUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aXRnBiLLFy7wYfXN7fKm5GHTXAbOk7mk2qsYlP2LA9mElOUMZbV4WaIp0sM2Y74U/
	 nf7BziG1Svc2jO5ZSqOa340sNPlfQKfDmDvDt/kpZSyUISRK0j4VvobK46MCb0TKNe
	 KLxZYFdCCxDa/GdOvaJH9IpHXyG91Pv/eWW89oJyh4K/jFIuRf6dmcBEy0tDyxzjXr
	 znvEof5PuS/0SKwoY/dfwmeQLvUAGUZIFCWH7N8ka0HDC2Mm/vS+tyGMyhpuXYSAb5
	 77zGD4hGcf3I0vaNkUSwVbpI/TmsVG74g3qhpLwuhm+kSYgIQlMry1f1pA2mTTQtfv
	 Uvkg0x22UWt1w==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so5553031a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 18:07:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIRKXxOtF3hlmr68oK/w9UJHUUE6fyr6vp9bT1G8rLk9mgSxA9F9IAxh1ZNmT6m0+k8T7Sxm2GoKDkh4qX@vger.kernel.org
X-Gm-Message-State: AOJu0YweTY6ebaYpEUCsP4xrLc7CG8foRdeHYED66m0dPDeoqFUsVIUW
	XnMyY3bjbPW+a14ijry45T4LqM18zllBQHoudkd/m/LjCOi4xTrALWHb/SsGZl4W6xR589O5/LW
	ktnK6DrBG36hBX0V9DvJZH/rXl64fc94=
X-Google-Smtp-Source: AGHT+IEahpzshk92mAoiOwK+Mrr+bskxyB612Q6EILmSeOiXB+m9/uERCPPXjAm+SVdXsPB/9RJwaqDNh70YNsLHFuY=
X-Received: by 2002:a05:6402:348f:b0:643:18c2:124e with SMTP id
 4fb4d7f45d1cf-6455431c8bamr7343290a12.7.1763950074417; Sun, 23 Nov 2025
 18:07:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251123121339.25501-1-anmuxixixi@gmail.com>
In-Reply-To: <20251123121339.25501-1-anmuxixixi@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 24 Nov 2025 11:07:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-XUoQ-7vxGY8ZVt8_jP8E3Gnf-KkyfGWF6T6fNzOdz1A@mail.gmail.com>
X-Gm-Features: AWmQ_bkip5a466WFzC2USULtfPPXKvHh57G_TB6elEGWzIhEozcqFWW0DWw96Fs
Message-ID: <CAKYAXd-XUoQ-7vxGY8ZVt8_jP8E3Gnf-KkyfGWF6T6fNzOdz1A@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix memory leak in exfat_fill_super
To: YangWen <anmuxixixi@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 9:13=E2=80=AFPM YangWen <anmuxixixi@gmail.com> wrot=
e:
>
> If exFAT encounters errors during multiple mount operations, 'sbi' and 'n=
ls' will not be released,
> which will cause a memory leak.
delayed_free() will free them.
Please check it.
Thanks.
>
> Fixes: 719c1e1829166 ("exfat: add super block operations")
> Signed-off-by: YangWen <anmuxixixi@gmail.com>

