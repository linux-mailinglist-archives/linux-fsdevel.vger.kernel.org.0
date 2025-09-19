Return-Path: <linux-fsdevel+bounces-62204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22564B88325
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 09:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BFE16AC07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 07:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0096C2D1F42;
	Fri, 19 Sep 2025 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IVyHIPov"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11EA2D46B5
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267260; cv=none; b=FrF+5IAXJpCcRm8d+uWHKgubpVYril6i24FuHadKX3XApHG7B0pNE4oPghBuh19vkkxbZfgrOQMMgfubjPkCAvzkCxk6umk/s5awK2UrTWTO/D4IrrC+DuUnf6EpnzHo8nkiKaFLy5icsaFwCbW+j03o5dJSx25+L2MJKpc64sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267260; c=relaxed/simple;
	bh=UDbgq5I7/fiN9GyHTHOeYNojRIjPFBceV29A28/FmKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObH6yq0V1NAyyo4yj63+HkOQtTDCYzrS8Vuj6CiwgB0EGTyzZ+qGLce6FhLQWyGKGt6aPpy7b0dW0a/G8+Ybg12wEiPntvq1jWWj4YivxMvlfVE1tOSkW8HvK5b09gHW1QeZFovUb/bOLbpLrnaUZeFk+c5zhdZNTzlIScWdT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=IVyHIPov; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8287fa098e8so179629885a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758267257; x=1758872057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1RChfYMo6l3NlpB1CtytFiCPlXnFT8/eeYYewFlQyV0=;
        b=IVyHIPovg6fIybeWuYJk3D6SVydMvkoKvdKP2HGgSJbeuqsLPHKEHK1zaxocvpapHD
         LH4/tLRdB7jOOkOs35t21z/rss58mqp8vXqemb/bHZqnmmdkT/rKssfDWRj4ToCAgQqV
         hQZbSI/HO4zq9Z86UU8aIuokWmbqo9VBDKBCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267257; x=1758872057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RChfYMo6l3NlpB1CtytFiCPlXnFT8/eeYYewFlQyV0=;
        b=j2SkWzbMfLgixzo7VCyVyaid34kmqAzmtwJCX9bMg0fVhZIX+EjjFK/9Jk7a66CEIs
         hott0UhH4k4yG87GnoQ4+YsO4Y1HSky0G7unefejqMEZxxVokScuKz7XuVNChXZWG6we
         ZeZevrJ5J2dNBuGYfWyEhUqFFZ+SV/9+ARHoZW04YTgcsQWAqFXsUUvbYEmGWX6ZjXJh
         wg9QRvUm/BcbR5Ms3B6gtZufFrIfskmWLMOqB53iMwF3XbasxcC1bNKCaroB1zOFAob4
         OwRVFEFURjy85ZoQt7NnpoJpusO5+d5e3q6j8pXp/WSArm1EnC0j4lygeOHPaa5MCxN6
         qcvA==
X-Forwarded-Encrypted: i=1; AJvYcCW6sT/4OEXeujgixjxgbS0ucdfqFgmPO0T49jhpkKWnmOxmyR24lpEo4ra6jC1aWfHHtzhJ7ISvOSWxvLHZ@vger.kernel.org
X-Gm-Message-State: AOJu0YysMwugffYeKBtk8VwWTFthBp9G/vlZRZM1NkdNmI0ckUiMC+GX
	0VvuAX//fdTFFV2QNG6GyXtz/ggPL5m0SuhyVlD3lnQ40iRRsVSJjovO9MPRG9F5/fuemIltcJS
	xrwnTSKbhs+S7m+N4mnschvhn8iBDC7cGErJoT4iAFw==
X-Gm-Gg: ASbGncu8SEl4g3MNbf64qR1BTBy39vyb4GWQYwJi65ov4exd0Z9Ge5BnItjZyVlY7Fw
	PXKCqpLqY3Msj25CU16mY/DqY3EWzOXNtV8zrwHnyuEAvTm0hkBxefuHlG34PkZI/3old5Mo2Vp
	5wfduXDKZaD2y1g6ZtiDa+Gn3AAtEfrEJ6Vx4ab/S8sCaiZpSzAVGnW8UjKDr1GZvItnQdZ1Wpp
	Zkd2Fu2QqFOGSWOFo8DapPLkDR+JJRzU4/Zd+Mm9QLBopcsCA==
X-Google-Smtp-Source: AGHT+IFH6/yIRQX6FHwVT74Oelgtb0ePNHcn9mX2qFQVBfBdaPpXLeRzP/soCW4TNqD+cygmZmF7/8DbipcgqrdjYnY=
X-Received: by 2002:a05:620a:4b48:b0:817:d6c5:41ea with SMTP id
 af79cd13be357-83babfe7d1amr196695285a.51.1758267257515; Fri, 19 Sep 2025
 00:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs>
 <175798150773.382479.13993075040890328659.stgit@frogsfrogsfrogs>
 <CAOQ4uxigBL4pCDXjRYX0ftCMyQibRPuRJP7+KhC7Jr=yEM=DUw@mail.gmail.com> <20250918180226.GZ8117@frogsfrogsfrogs>
In-Reply-To: <20250918180226.GZ8117@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Sep 2025 09:34:06 +0200
X-Gm-Features: AS18NWDnMUFDnNKztB29fevuAtOKBB3TGWjBAViz5bbTsRot9HiaHDnPQnmtPns
Message-ID: <CAJfpegsN32gJohjiqdqKqLqwnu7BOchfqrjJEKVo33M1gMgmgg@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: move the passthrough-specific code back to passthrough.c
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 20:02, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Wed, Sep 17, 2025 at 04:47:19AM +0200, Amir Goldstein wrote:

> > I think at this point in time FUSE_PASSTHROUGH and
> > FUSE_IOMAP should be mutually exclusive and
> > fuse_backing_ops could be set at fc level.
> > If we want to move them for per fuse_backing later
> > we can always do that when the use cases and tests arrive.
>
> With Miklos' ok I'll constrain fuse not to allow passthrough and iomap
> files on the same filesystem, but as it is now there's no technical
> reason to make it so that they can't coexist.

Is there a good reason to add the restriction?   If restricting it
doesn't simplify anything or even makes it more complex, then I'd opt
for leaving it more general, even if it doesn't seem to make sense.

Thanks,
Miklos

