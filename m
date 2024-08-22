Return-Path: <linux-fsdevel+bounces-26710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EE695B343
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 12:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3531F23AC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 10:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0809C183CAB;
	Thu, 22 Aug 2024 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Lvo/l6wE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E1166F3D
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324095; cv=none; b=DFCCP86d1Fyog5nh1vKRM6NFjn3Jk5v0QkTebvrgUkgMH05cG0ru/tlethVNzGEyFSlSzP/yBcfRZ3TJNAKCE9fn/PSsIIUl5Z8NVYX2cQDWVY89jbqAzGQw1jF9yjl2ixq9NBOYamookhz4lWYDhYPULPDPYST4igxtsPwvE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324095; c=relaxed/simple;
	bh=VKvAoRVIwZatDSscp2W+CVls5H0RGS+2D/3BZaLq8hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlPJtBaMlEvFGXTCmP5czW/pl4ylncX04Jx38Oso3hUF+CnXSh/bKpSUs61vv9i4uuFsE2Gvku7fWzaaUs4ciiekyY3nu9LFxIZ2oDUJSSLD0S5c+pRJ13Hgw+d8DcrNNoVAz9kxiRsnbL2kiJ1mB0VGs3tjZBIkJd9LD/uhbUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Lvo/l6wE; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-68d30057ae9so6659727b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 03:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724324092; x=1724928892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VKvAoRVIwZatDSscp2W+CVls5H0RGS+2D/3BZaLq8hE=;
        b=Lvo/l6wEcOZvMqxPABk2XKYhsOvAVg743heR8obyjUj+aOncZni/ipS2MqNXqcmkPk
         aBvnlgQfWxwhOqJUFwGiweJnmXIKVg6ZIrs9vgJ5kkcY+dWMCL54z7vre/iQ1XbyqBwY
         IcPvdCx8DwfCocGwxKCyJv6iYQNe1qtcypkFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724324092; x=1724928892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKvAoRVIwZatDSscp2W+CVls5H0RGS+2D/3BZaLq8hE=;
        b=cr/Ws1W23kOq1UiwOShKajKyQjRihxkSzC3yZJ6jwZ1bhIdXOI5kfhHKpI0sly9O4t
         GNx92czagpZboTv2nTYr3hH8K7bPCyo5GkDVhovMro8vf5HM+MZVW/389FZ1vwb24ZwM
         ua45TXU5iu/nx7yHSB+ubR4YOAYq9dSRG4DQc78xUU2wVHffKt79KN/HaH0Wx5FkpKMV
         hbn8NVFTEmQOdn6sSFtSG6S5yPblV/q+v3bkMayUwjkq36wofDJTbLF4I9HEfh7gSyVE
         rg2SML7CnEFB59yCGpsqHu8U//X5o3eHryMgqP64j8D+Ljo1m6YnTndu6zGGR/Fgf3pj
         8ddw==
X-Forwarded-Encrypted: i=1; AJvYcCXQywxBg/NhGSUEFmtD1gagAUdwNmplKLAG63BuZBGChDpaq7Yn7QBbsuYvYimZI9EQRsjlejqaLq0gs7Pg@vger.kernel.org
X-Gm-Message-State: AOJu0YxveWahRloiwEHWOX7QYrrqES7MD4g7eKaK9sI8KBX5AiiNIsIF
	qzLUp3+SxPNalQyCL2H3X+gJNyvOumxj30gVuSFyBR1c8pwO00aVeSS82GEd2ak9Bnnn90B7Tij
	moAlh7zt81SvWTh6bZiy38yGkApc7VB7shgK0vg==
X-Google-Smtp-Source: AGHT+IGq8avRqO3Yhdfy4Ro1xtudk9WnoZf9k+xIGG4xobVUXdbfMtkwVhA7FWxzmjfgYSdDzJ65J20nz7NEBTvtlWQ=
X-Received: by 2002:a05:690c:c8c:b0:6ae:34f0:8837 with SMTP id
 00721157ae682-6c3d60b8229mr17831087b3.39.1724324092669; Thu, 22 Aug 2024
 03:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819182417.504672-1-joannelkoong@gmail.com>
 <20240819182417.504672-2-joannelkoong@gmail.com> <CAJfpegswvvE5oid-hPXsSXQpFezq3NLVdJWTr_eb4shFLJ2j4A@mail.gmail.com>
 <6d1c802e-1635-414a-b0d7-ad5306bfaf8f@fastmail.fm> <CAJnrk1YkAggwb94bojbxhsLLcQj3TPM3CdO2v4h9H_y0firrwg@mail.gmail.com>
In-Reply-To: <CAJnrk1YkAggwb94bojbxhsLLcQj3TPM3CdO2v4h9H_y0firrwg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 12:54:39 +0200
Message-ID: <CAJfpegvvbEkXKhB95wqNTLTD5Mc=q0wkAmr7P3Uob7Sj2pn21g@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: update stats for pages in dropped aux writeback list
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 22:22, Joanne Koong <joannelkoong@gmail.com> wrote:

> I unfortunately don't have a repro, this was found by code review. I
> started looking at the writeback code after reading through this
> thread
> https://lore.kernel.org/all/495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com/#t

No problem, I was just curious.

Thanks,
Miklos

