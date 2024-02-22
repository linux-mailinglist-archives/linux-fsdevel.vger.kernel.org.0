Return-Path: <linux-fsdevel+bounces-12444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE1685F68E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93D7284167
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C023FE2A;
	Thu, 22 Feb 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Sr7jgVvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98F17597
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600205; cv=none; b=p3OBPZ2vTDvIlau/7OhodGbw2X8meL970FD3q71kFHMNuMhBarerk6mfw7BcumF0udIsgNfUNSASaVBJeYxQR/8rqTStKssiAnWW3803fnhlDwqTD+KXp8yPQ4Xj78bHA86igbBRbk/56ZZ9nmF/AyOlNVqLyP+jrr/Vur30Pzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600205; c=relaxed/simple;
	bh=Bu7lvofasTW9d5Bh4CSqrChZUdm21wNt51NcCaR0PH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIqgVPeF5AkM7Avcsoj3dBJ19VyLihELF66htfHYwYec16ChtbWjB2AjUGjflPAxCBfEEqsWBaoMKoRqCgdGHhHl5+KeK3Ukea3T/T73z7c7PrrjRNqTbhB42yl0MvmMnZl4deE1Z2d9m4n38ZW0zFUVqP+iHnPIk2nBGTVKxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Sr7jgVvT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so204772366b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 03:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708600202; x=1709205002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fxkD4d19CdTWZhnnGtoPS2DW1jSoJCTR/Pok21JwV2U=;
        b=Sr7jgVvTuvD/mTGK+wXDCx46fkSDgLAKhq57LKl3nZjW5IEMfwpH2w0v9BUFTdCZiI
         zNcvWVAwJz5W4DAH5Bo2wwrk7iK+ByzrOAaBEk7cjCmEHcKjQBh1x9YtZEo7oi8IjtEf
         GRc8Cx06j6eV8OQa1KDFnFS6rbooe7pVzyMng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708600202; x=1709205002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxkD4d19CdTWZhnnGtoPS2DW1jSoJCTR/Pok21JwV2U=;
        b=D41skoZhZmPxzL6XaETaPVSl35TS1FlbDMw46CEwylzvPJdzg0xe0bSOWhQtj4Kzcy
         W44OwRJAxq9Vr7T+2a+3XfCO4Five/cRMHuN//r4BSpgNK/UCU63pLCgCBxZIDF/6Hs8
         5stoDdjWyuyjl/UKSXarzN3h+a4qGSuyKDxLITxsRserH0wpnKrDTJiAOH7s94e7AiG0
         AEwyLBGpCM58AwofA6ETxXPaFFGGkh80XCl4Qj91AlCvdvrUE8x/5nadcvAueG6j5EYt
         JhUofpFvFv1Rn1IvWz6T6Hy/x0+GafOY/BO6FyPIlBN8vk+m9y3t6AbxTj3U1DHKEHd6
         F+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVwQ00BStIeeY5JoTVcwKfjb5bVrSQo3xbSs1e+2kE4bclm/LTo2SosN7CE0bznyV0WOtuoLXYhG73Q+t/WsWMcDkDk562NPyp/h5JSUw==
X-Gm-Message-State: AOJu0YxzXuwbAwanXRw3j9xA7c34b3cUPnOD+hUjoRP2UteT2OIe9bqa
	gYvtbyY4CgM71muIUUEdfHPoI1XkPrBFx2u4xdxzW9Y6rYIcDc2WDcRTBPCFglaTn3O0l2F1jkX
	is5hflthSovpEoO0rvk+MVYWLTizAD8lYcL211g==
X-Google-Smtp-Source: AGHT+IHsvOCX4ayg9b6VZxHjaOakGaF6gj23Si5x85CarUnVRpuCrMncvrHtXLv1jkyxyqc+jPa61eTG7gGMINk4q+I=
X-Received: by 2002:a17:906:3e15:b0:a3e:d450:d3e2 with SMTP id
 k21-20020a1709063e1500b00a3ed450d3e2mr6619029eji.47.1708600201092; Thu, 22
 Feb 2024 03:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
 <CAOQ4uxgZR4OtCkdrpcDGCK-MqZEHcrx+RY4G94saqaXVkL4cKA@mail.gmail.com>
 <23a6120a-e417-4ba8-9988-19304d4bd229@spawn.link> <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm>
 <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
 <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com>
 <5b7139d5-52fd-4fd0-8fa0-df0a38d96a33@spawn.link> <CAJfpeguvX1W2M9kY-4Tx9oJhSYE2+nHQuGXDNPw+1_9jtMO7zA@mail.gmail.com>
 <CAJfpegssrySj4Yssu4roFHZn1jSPZ-FLfb=HX4VDsTP2jY5BLA@mail.gmail.com> <6fb38202-4017-4acd-8fb8-673eee7182b9@spawn.link>
In-Reply-To: <6fb38202-4017-4acd-8fb8-673eee7182b9@spawn.link>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Feb 2024 12:09:49 +0100
Message-ID: <CAJfpegscxYn9drVRkbVhRztL-+V0+oge8ZqPhgt4BAnvzaPzwQ@mail.gmail.com>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 02:26, Antonio SJ Musumeci <trapexit@spawn.link> wrote:

> I'll try it when I get some cycles in the next week or so but... I'm not
> sure I see how this would address it.  Is this not still marking the
> inode bad. So while it won't forget it perhaps it will still error out.
> How does this keep ".." of root being looked up?
>
> I don't know the code well but I'd have thought the reason for the
> forget was because the lookup of the parent fails.

It shouldn't be looking up the parent of root.   Root should always be
there, and the only way I see root disappearing is by marking it bad.

If the patch makes a difference, then you need to find out why the
root is marked bad, since the filesystem will still fail in that case.
But at least the kernel won't do stupid things.

I think the patch is correct and is needed regardless of the outcome
of your test.  But there might be other kernel bugs involved, so
definitely need to see what happens.

Thanks,
Miklos

