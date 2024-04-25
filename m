Return-Path: <linux-fsdevel+bounces-17725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC6E8B1D32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 10:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECAE1F2154C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1607317C;
	Thu, 25 Apr 2024 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOT6e8NM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5028EB;
	Thu, 25 Apr 2024 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035541; cv=none; b=N5YLFRsPCPH68gKZWp5TBjARg5qLPviEQBKnBD9e27JCuLvvKlqqVNgtLCf2Gsj6ip0T/iOWYfIUwGkBumM89gUlNw8+R3+PWV2fRS9NHFk2mK1wiJN3OJswEkQbYNa8pk+CbABfv00uK0Ju+xTkPD37XyprULGTMwtNuN9sR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035541; c=relaxed/simple;
	bh=YK7ShB7E92bCi3UcUvC4mcp9ZVYQnxKhDnDlqvXCmPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWeHuBfwZXYBV6AIaG7ApgrTt+LKECjGoLN7g9vP8CJw4BJ9FOeva0nqVZF2y02jcHMiIVvlUh66KK465TnNPDG70LwDGllLTfTW7y3rh5vhhSHxQWCghnJSZb+cD43XQzT6HnTdSElE/7IeXGQo47EwgbcS1uUfWzemHTH7DA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOT6e8NM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51abf1a9332so926493e87.3;
        Thu, 25 Apr 2024 01:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714035538; x=1714640338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sfxe44V9t2yg9N+0gbjQFUEMdmVmtJlQMhym8A8MpW4=;
        b=fOT6e8NMVlBFjZ0ASOY6neKXhDov1xfbop0cg+UKvvT/Gsntqvmg15mq2DDpY6beyA
         K7bB+SFWj7y6UrqEp/2VSN92iG4oBaxf66WWtxL40kzA2psQL5g9KjMWJDMpGvEotQ0z
         BjKk/3Rze1H5kQ8N7qPy7HEDge+CUMfbVyuZKaQF0m17Sj5Lm5ySIexRTAU3V4nvkhNi
         jQEnWpd5HLoeNmX3HRifw2G94FZDySIsyJM8qAhq+qdxvv0Q5knrt407eniIv3WEJxE5
         awJ2Xkttf7lBO04JWdHRPzZiRN4z9/Sfp5T0PWkPWtOssFh6TUBu9h05oc9Aet2BVpws
         sVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714035538; x=1714640338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sfxe44V9t2yg9N+0gbjQFUEMdmVmtJlQMhym8A8MpW4=;
        b=PGi8MIe21dP9dC5SGipv1Jw7Xr1yLnwBvjVSiaRQLEUvt8jCK0tVXdo3wqlS3p2KpL
         6cFBLTdke+JuicjnjF+gE44D+ByEsLDDkxFBWjCytdofB3Y8bDPn2Iauk9Ku6xqtaGW6
         goAcpTQ3yZJZdxbKZ77aD2JnL9Sdf8PDcOGYlBtp9zUHMS5j00IOuxa1fb5rdgUR9f/o
         xTkydwnvyMS90icKXltUj3bxJMvK5DI4fVO/FbaysDE4Bh8nuO3TITAAaQchW25varAF
         zWR7yCK/lUEJmXPdcnYyZyRQk39eb48+/YX6XQ9hIiz8QfDDQpNNb3goGpRkZ+co/FGi
         /WuA==
X-Forwarded-Encrypted: i=1; AJvYcCUlt4GSRxi0KaKlQrrdkfgtkYpWkGsymV4Quac4LRgVn5OBNz7ZHdLmhhT3LIW39Ydhalh/ToaiYgXspXCU5GFL7MKL8rNLemY1zLEvFKhvy/Icwy74r3Lh6qPOx/QuoKt53ZdIA0cr38R1JqqHVMpedZrQwKdXvtqMKkXhzplO5JgmXjifKdkM
X-Gm-Message-State: AOJu0Yw5niitkm7Qp7uNBS33vxpAaTF33ys6IZHJfKvOxdLQExT1S7VT
	3oXt8W4hOTejtchJeYjsmUWVNQ/Xfo3E0m0ylLFqRqpLvlPCWt1kptTb6V+uuUxHj/WlCi7ny1R
	MMqJXnbeVWiVeJfvAOAFTVtWo9PxFgZPv
X-Google-Smtp-Source: AGHT+IE5biBv3UGL+AywnBs6s2USqbZyQg802ilweNQ4bB+NKACrkg3ggNfVeCa9yO08acO4qAWeCfnG9pDy7jhuT/Y=
X-Received: by 2002:a05:6512:68e:b0:51b:f632:41ce with SMTP id
 t14-20020a056512068e00b0051bf63241cemr3892109lfe.26.1714035538289; Thu, 25
 Apr 2024 01:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424182716.6024-1-konishi.ryusuke@gmail.com>
In-Reply-To: <20240424182716.6024-1-konishi.ryusuke@gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 25 Apr 2024 17:58:42 +0900
Message-ID: <CAKFNMo=2i6C2pUcvSuSuYFbkwnRxVKE3WnfjXTYTBRWXJ1MZtg@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: convert to use the new mount API
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 3:27=E2=80=AFAM Ryusuke Konishi wrote:
>
> From: Eric Sandeen <sandeen@redhat.com>
>
> Convert nilfs2 to use the new mount API.
>
> [konishi.ryusuke: fixed missing SB_RDONLY flag repair in nilfs_reconfigur=
e]
> Link: https://lkml.kernel.org/r/33d078a7-9072-4d8e-a3a9-dec23d4191da@redh=
at.com
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> ---
> Hi Andrew, please add this to the queue for the next merge window.
>
> As the title suggests, this patch transforms the implementation around
> nilfs2 mount/remount, so I reviewed all changes and tested all mount
> options and nilfs2-specific mount patterns (such as simultaneous
> mounting of snapshots and current tree).  This one passed those checks.
>
> Thanks,
> Ryusuke Konishi

Hi Andrew, please once drop this patch from the -mm tree.

I found one bug causing a kernel bug in additional fault injection
testing, and also received issue reports from the 0-DAY CI Kernel Test
Service.

I will fix these issues and resend you a revised patch.

Thanks,
Ryusuke Konishi

