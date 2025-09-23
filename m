Return-Path: <linux-fsdevel+bounces-62500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64B2B9588B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 12:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A704A3BFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 10:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462D132145B;
	Tue, 23 Sep 2025 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="obz8Q7fe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF132128E
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625048; cv=none; b=IH0j62HDPtewztlnSuDi0KFkvR7QNJVRyWMAJy0X/aiU+9w630Hvj/mohgh1X47MEUxNTVPGGuKJKGjV9iHMViY52oEI9B/w3vSShtEhRDc/tMzFGr8sBmfRZ0lNm5WuPvZ4SRx+Q3kZel7gt25ywJlyK1A3ME9ryTMPP6PSrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625048; c=relaxed/simple;
	bh=2MeXdCvURTAzTkx6QMrHRp3S9A86YdzLDwHjZbC85GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYQTtRawZ73NuSViJLt9TcTrg/UIVL+Q/ZDVmc2mr/CFvE8xww83sV5AGLkibPEhdv3KAFLsbw8lZytS528wenE15plkXqWOelkn1Lb/sFAE2OOBQLOhCM1ZrARn81ZVeJUQA6z1yc24FGW9hSGD3oY4NTmGVM4iob2fgUk6A/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=obz8Q7fe; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4d41154079aso3399021cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758625045; x=1759229845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2MeXdCvURTAzTkx6QMrHRp3S9A86YdzLDwHjZbC85GA=;
        b=obz8Q7fe5LBkTIYZ3NmPerF6qas5s+UrHsjnvSndrBrgV0iPTJ74xVIMWZCpy7Fw6F
         EhRej21X55jgkWuxaSbt5uRPqlxK/vN9ZH1q9JU3lgduw9d+iBWeVbfqswDjlKvJIUQl
         kwseM2zeOykEi93MJYTkti7Sx8c17uOI17Weg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625045; x=1759229845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MeXdCvURTAzTkx6QMrHRp3S9A86YdzLDwHjZbC85GA=;
        b=bQP4fYoiMnbxqolJtUvVMQvQ4S6yrJ6hVklRFmuSoOOHHBdBUko7Et9eSRwgpzkHSE
         vQOqr6EVwXwzHcggcVaAAqlVHJhlr3UUMBjea6+UyONf+2Lq2S4uBWNg9IBLxvyF4xs6
         rq4p7wbcx4aBrypoaX6K5j/JMDHqtwZyMu2Qk+JG8HU3Yj5mMe4xVlkFanmeQouAGaeN
         DuH+tDQFbqAEmt0CoT6yFzBM/EuvuhIDXZQxQkcE6bzmNp263MFiZ/LNthOFdEHuVsLi
         hD/YyhF1m+ZgmbTd1tpnojEY2m4eKg9xabiA8Mt19UWb3VPKqxszWGwfxjLFWWBEQs7j
         rnNA==
X-Forwarded-Encrypted: i=1; AJvYcCWaLKxDGXurC8xv2sBOyPmnq5evpMK24VM6vgArPIHVpsMCeIXaivKYMPI24oj8vLYWyKlUe6dKOGNcU0Nt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu0ewxrL4KDeUJR2ootZ4jhHVvmskRc/8H23+6de0GkxVP3pTR
	j0NPzqpTZDJEhzSZQeaFP4W1Z2dO1SiFQEQjmxqcjccUhFynwcGUJos7g2bos4Wlw7mJPKVjO63
	QSDTkOrqEe73DBrN8Dx3C3ioMCiHeF/FZ9Y8DoCJ+vA==
X-Gm-Gg: ASbGncthViTzUhTPvI5qB95HyyumR7xsR1hjgiiENqgOELowZvNe9v8EqgbUz0sBNjo
	4mGq9bcpCyKvCTGLQGOaqIHrqqVyFHEMedQL/D0f8MQf0kXfXgU7NgDTVMepyJjLRa7T25D88dE
	J8zAlGv7nydjSD51y+wZEoLcjxVUsyJz7/EsOu+sxCBw3WSDXM3xV5Jb08vsvIfC8T6hcJFjjCL
	VEgWYqLR6BvpQbM7XXod6rP3xyu19Fhr32VUEk=
X-Google-Smtp-Source: AGHT+IEX2FQnjqBT2nQROo/GmnwQJfhYdbUuQlAtXjIqq8yTbxUzJNVyAUEw1AzJLuqsGAuVc3X8Dzc7i/5z5z12nKQ=
X-Received: by 2002:a05:622a:1ba7:b0:4b7:964d:a473 with SMTP id
 d75a77b69052e-4d36e7cf86dmr22388341cf.52.1758625045299; Tue, 23 Sep 2025
 03:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs> <175798150049.381990.18237050995359031628.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150049.381990.18237050995359031628.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Sep 2025 12:57:14 +0200
X-Gm-Features: AS18NWDgcLlZa783VDIvuFp9dEh3HG2MSYk9_Y7d4QE4zvlotxO9EgkDJG273xY
Message-ID: <CAJfpegvQogdf_NaiOk2GqCBYYL0qwOrJRLOV-b8HnUj0iPPXGQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] fuse: fix livelock in synchronous file put from
 fuseblk workers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: stable@vger.kernel.org, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 02:24, Darrick J. Wong <djwong@kernel.org> wrote:

> Fix this by only using asynchronous fputs when closing files, and leave
> a comment explaining why.
>
> Cc: <stable@vger.kernel.org> # v2.6.38
> Fixes: 5a18ec176c934c ("fuse: fix hang of single threaded fuseblk filesystem")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Applied, thanks.

Miklos

