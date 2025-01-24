Return-Path: <linux-fsdevel+bounces-40034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C627A1B36F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 11:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE2516D54A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 10:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F01219A8D;
	Fri, 24 Jan 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="K4sgEcnj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0C13D520
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737714337; cv=none; b=S3LW3FQo7cJcP0ak+vKNeXhrrALzhVr5Y8wDQzck86a7ym640AqjqnOuW1ZLUdKASSG+9XbMXxqGydYzNhUgS0KncodzbVUs510YnENxLX2zJ6mz+9mwXidMcLMpOfHg5nuMlE/p+4ohotzbLJyNgDqcS8hlZp3LIKy67VZFDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737714337; c=relaxed/simple;
	bh=KOvu4wt1sHz2bsXGq/ahMprc+V9B9OedXVdHBjPYN3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xp+Cb/DYN0r/XzU5cBbdA4ONRjHegpjUogWh26Hp7yuQeT7OCuK02q66qZM+dM4g7slcIh7GGFfgXPUgZL/TBjK6IgbMS3tpEBHJ/A8w5mfGCkaJ19X+TGMEK3jQ7iAwGk5CMvcW67tiEI6UhILEol1/JfFnIwO4/Y7LOVh6jDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=K4sgEcnj; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8e8cb8605so9809946d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 02:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1737714332; x=1738319132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F4V3eb8LYTRhzjY8vCWHrGo6/FwXu4T7NUJvP0dkNFU=;
        b=K4sgEcnjlzivUes6Ya02GpVapqXe8WKEIyI16JhiKputZwNkciYoK3nyx1gpz3QRPv
         +0bdpe84UHPgQjnBrx0ucEtLEgmaJ3jXI2WAAfC0V0VU+XbUucS5cs1uACKdNTKmznXp
         YRU9Bz3Fxg8UvJ4hU2EO16ydtHU2KLIzwevKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737714332; x=1738319132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4V3eb8LYTRhzjY8vCWHrGo6/FwXu4T7NUJvP0dkNFU=;
        b=wuZJnjFLWKd/t2WyXgogbtUyUC8DdqQZFCoVjkDItxnB4y2oqkOzBcY+NKbBkz3v8D
         xdUWj/NDYcEP2evwAuueEqaduIlsTyTAU7pTmgVquc+ZKJ17PJP47iS6aZupIA5+UFOT
         zWts21CKQXIJsCfAddsq3nyCu9PNBBIyjZkRSrE5zgeLb71c4OqXFEaLU6juVKaM7ip9
         5t7p495AipaJ0j+QenbAafhpSeZkQJ0BlFDZccfAem/8lMb4WpvGztLhWyAuqhKvAfVE
         s9R2ggP4NpSeC4ZnE3q3nQE6Pl6FHhW2CmPa+A1rtHrCvqoinLdBUqnUmrFY5PDlc83A
         1o7g==
X-Forwarded-Encrypted: i=1; AJvYcCUJAvp3DmMhpzcR2mgtgEk384WeFBXtl6Hacr6/2FfnCQhzPL3sPSozWsQfDHcXbt+Wo5JmzjQGeTips8Jv@vger.kernel.org
X-Gm-Message-State: AOJu0YziPqnwa8HIMYGwQJCrOlJs4vuUu3ZhXT35tI1CrzYDr0vMz4MM
	co5mD6e4x3JdnKkncOF4O7tfKxCQzyRKw4yiFj4lmkVTGcEIAxH5kX6lW8oaodKMQahfWeo7DLc
	0PrmmX1/BeTTrXTkh0ZzUM9sQo0ldpewHmDUZmSi/3dt2LWG4
X-Gm-Gg: ASbGncuwBIku4oHoNOSV/a+CG6WxVsLZWUKgtz0bhHk41WRFIXGrXMuXnmOfTokXDtO
	2qcMCdKKD6OTWMsGcDJ5xf6JczX87JoIci6O9z/xrVhZa6YBUMfipmQbKNOxR
X-Google-Smtp-Source: AGHT+IEZkYaan3GIoBxbBLrH12ytueSAQUzjNmEc4307BVTfqX+3x11kh8QVe/B1CMQ4CKQ/d6NOzH0lFgk2dDa3Gzs=
X-Received: by 2002:a05:6214:2586:b0:6d4:b1e:5418 with SMTP id
 6a1803df08f44-6e1b21c46b2mr418381936d6.33.1737714331032; Fri, 24 Jan 2025
 02:25:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
 <8734h8poxi.fsf@igalia.com>
In-Reply-To: <8734h8poxi.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 24 Jan 2025 11:25:20 +0100
X-Gm-Features: AWEUYZnMoVLJVyV6td0GzVh663eMVqqRNGi1LG43U6jGmMhCIiVxL6mUkJt8bRc
Message-ID: <CAJfpegsBFBQoiLreevP_Xmbmjgnii7KS_6_i+pKfMixSw65wiQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] fuse: over-io-uring fixes
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Jan 2025 at 10:00, Luis Henriques <luis@igalia.com> wrote:

> Anyway, they all look good, and probably they should simply be squashed
> into the respective patches they are fixing.  If they are kept separately,
> feel free to add my

I folded these fixes, except the enable_uring fix, which has no obvious target.

> Reviewed-by: Luis Henriques <luis@igalia.com>

Luis, you seem to have done a though review of the patches (thank
you!)  May I add your RVB to the complete patchset?

Thanks,
Miklos

