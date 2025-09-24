Return-Path: <linux-fsdevel+bounces-62577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F90EB99BEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 14:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0963E1898C79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2FC2FF175;
	Wed, 24 Sep 2025 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gI88R5Kb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219C2FE072
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715475; cv=none; b=DSD9BDSUkFxVUBj88GK2YCxhjD9JtEkaurogVO0+5mzqzqX6l1Q35gMhzEaZvl5oozA96JwEmqzcCWml+4Ii/fV38HbMj1EEE1HEUpqs3e8PZtfimpRy0ij28Gx6ti7uG9qHEsscVsRTV5t2GWUS9uE1nHyFFm0O9Wh5ssQG6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715475; c=relaxed/simple;
	bh=9ibOWPuNdaOplH+FBy5QoeKpS1t7hE49sJQ9OEcLq4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lvvoc2zJMP8OsscMGGnsiqY8klXTdAkqVpcpejyaRtoC1On9/tWtUIvY97VHTnitYf3/RYWeCNloe3iQZc9U2zNSYj6/aBHX80Z35venI0940o3tGg/GzwMkT3eQHDSEWiCwftKA3/2iPVkdCvSeh+ukiqASe82E03BRQxMeqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gI88R5Kb; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4d16cd01907so30898521cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758715472; x=1759320272; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ibOWPuNdaOplH+FBy5QoeKpS1t7hE49sJQ9OEcLq4o=;
        b=gI88R5KbwQep8XLJLqQ1ZJmLlTtTsZwRDdSdybaTdAofHOz79bHjwLnG0svWikFepS
         rYiXi19QelDa73KcZqFTVdRTD40ZuKEBg45FS/Qt5+9jOgn/VsW5uwccvH7B2N7UqdG/
         X0iTiTf5N6GX8E0hp2xH/yh2KLir+BG8g0yfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715472; x=1759320272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ibOWPuNdaOplH+FBy5QoeKpS1t7hE49sJQ9OEcLq4o=;
        b=TRxFiIoE9umclxLQKnykdQX7Rmi8lGbjhdpT33s2ZMRGtod07iXj2QrPZtKcHAq+9d
         RqjB9h++Kb/DFeUjw2kKmA047Wu/n8gG0ZAKxnbz0dxQux2I1B/4uwslNPOU+OyMwtn6
         upUH3EdQ7Tju4KAvsqM++evcPvl7okHrjQ/QdQBHY4NcOh4V5QUB2VjtiIx9LPRbe3fd
         7fUmUMoFqMDf5oFnoV5KZemDiq2Smf/YNYL0McVmClbIVFd7n2WhtmCIovxFPiUt1AxW
         p9IAiSxjsr7g15ncLbKbTf06qGgxpnlNHWvcA7NqnqqycuYYDwfsHEdifwlXPANZrs8o
         MGvw==
X-Forwarded-Encrypted: i=1; AJvYcCWtd2gZwEwJJ3rk7qYmJY/hYv38YLxsYiVgBQ+mpMS1sjsHedgRid9Uiq0wAAYa4fbNNUA6DW2u16NZPmCV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyskp5qUzHMXXXVw6SRixBsKge7UzX4YJtIwYEniY6mb6VWWSLl
	/3rm2a89n51U5OEPd93W9w9vnWkF0nrir/mzLwwDxg7USsGfqGRlOMJR3EctWcj7+pIw0KXhKYR
	vUTvRdbYOhFGZCGpJuqci8zFmfw2VOIjHn3TL5ubqvg==
X-Gm-Gg: ASbGnct+k1hLOSMdV2LjnOsFmL3t0Mbc8ttPLokUhJE7XMKWXZM4HQy+1aV9dMl9+pc
	JnFNX1Z0Tp3+r2DgZVQmC/A2MS/6mruiNg9BDG+IdKgWd0/SVLhz1gAZ0OFyz2gT5PYGn3JVvuE
	60QJlVIcdcmjd7sSt5xxfEydc2K49QFjwxSnZghfIr8WhbN3BuOOCdPj5jLFHGKWWM9Z4GvfAzH
	wasZnSSEWVjHUcZZrJhjYb9hW6ptVRkCbwhnwYBcJnnqceKRg==
X-Google-Smtp-Source: AGHT+IFzX+IW76Y9GPEZbQ1y6EX1pULnJsvnodAmkX3ktuNW0oM3kKJxbWcPTYg+rr2jPsvmhkcmNpkPJ/6Wb9P1WbQ=
X-Received: by 2002:a05:622a:1442:b0:4d3:55f7:ddcd with SMTP id
 d75a77b69052e-4d36fdef829mr76582171cf.59.1758715472064; Wed, 24 Sep 2025
 05:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150070.381990.9068347413538134501.stgit@frogsfrogsfrogs>
 <CAJfpegtW++UjUioZA3XqU3pXBs29ewoUOVys732jsusMo2GBDA@mail.gmail.com>
 <20250923145413.GH8117@frogsfrogsfrogs> <CAJfpegsytZbeQdO3aL+AScJa1Yr8b+_cWxZFqCuJBrV3yaoqNw@mail.gmail.com>
 <20250923205936.GI1587915@frogsfrogsfrogs> <20250923223447.GJ1587915@frogsfrogsfrogs>
In-Reply-To: <20250923223447.GJ1587915@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 24 Sep 2025 14:04:20 +0200
X-Gm-Features: AS18NWDcnShhwKGclrcwGUaZj51GkpVzLGQIL0hjgTsrUfuhKR0cDZo_FZLUM_g
Message-ID: <CAJfpegthiP32O=O5O8eAEjYbY2sAJ1SFA0nS8NGjM85YvWBNuA@mail.gmail.com>
Subject: Re: [PATCH 2/8] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net, 
	linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 00:34, Darrick J. Wong <djwong@kernel.org> wrote:

> Conclusion: The loop is necessary to avoid softlockup warnings while the
> fuse requests are processed by the server, but it is not necessary to
> touch the watchdog in the loop body.

I'm still confused.

What is the kernel message you get?

"watchdog: BUG: soft lockup - CPU#X stuck for NNs!"

or

"INFO: task PROC blocked for more than NN seconds."

Thanks,
Miklos

