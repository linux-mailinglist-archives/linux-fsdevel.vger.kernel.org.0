Return-Path: <linux-fsdevel+bounces-13095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55D886B28D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887A61F21498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2282D15B0F4;
	Wed, 28 Feb 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WXq1eLlZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1942064
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132495; cv=none; b=chi2mEuTAGEkRENav0JGrgt98oZK/+UvsnqQThYGopC9N1P1zpnz185OCDxmNNDxkGkmF9R9bF6+IqaE8VCzcjH+zR7rT2jZC2K/G9RQscJ+3Jm4p1fo8Vv/B2bJ3xTPEOQnfyIwXPgYO2UGpgGGeH4UjeCGKbV1KFhumFXvOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132495; c=relaxed/simple;
	bh=CZ7p5PAi/LirAtQ5sPCp+doCSe3WwN/mEDG06H9UhJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e93j9iVNg36x2XWwYTOYSRJw/EiKZGqX/hAl/5ofEtaKrDQ9lk011yGa4txjgx/aE+D9bqb/yJ4cWizaT3wq1NT0trhKgbhfOdtZxW1lbZ7t4zztOMyJgPucRVGCeR0Icg1x02C1lkNr7NYWIiNE6uKod8oHpf36fJojcgxiqgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WXq1eLlZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3d484a58f6so794801366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 07:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709132489; x=1709737289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6xfpdTQAq4N7F4hR1arfVubb/UEzKrOMk4N9rJ6i/Xk=;
        b=WXq1eLlZt4KJ/BT8g/3ejLnNLOw4dEtdRs9Km8L9PMfHjvKKG3fEwDzBuMDUaFbJ3K
         k/eciEoZk3z5EJJtmWj2pdG2x3F+H1OOBRyEE4kQgPh76Z20JQtK3DsozvMpXI1SSL5f
         34aHntJqbt6MHpf+DXIOesub3/4NE6AN+iUvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709132489; x=1709737289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xfpdTQAq4N7F4hR1arfVubb/UEzKrOMk4N9rJ6i/Xk=;
        b=flQHGd/cKVa0JOnKo7WUAFl/skEJebj0v+/YTmdqQhzv/NfRBa+duSft0Y6FZucO0O
         oJtGWBf4K1QTXsUhS9wa8OQUnvj/XAsVwlw8hJTrkWqF9aRYjMpArpVGtMZQSp9eYws5
         4FVgE230aqoil0h/Eqd13VZf7co/wJjzBgryr0Geaf/Az0dox8eydeQngz0VWOwG8tyb
         6Pj4Aj6W4GYa9dcGHFHhn3L8Fdva+vuOAWJ8W/fRNLKpSK7V20ugZot3cW8U/KAmO681
         EvguIj1Gk3DjfGVDyJRFQqCVmDgxgavE7yhXrOwcuDDv6IjqvjDozWcPCT8kfheLEui7
         ACAA==
X-Forwarded-Encrypted: i=1; AJvYcCWra63cj4MD7uyoawrlUl4KkqFOjMih/7mfnxYcDg9cTPg1tcIvlw6mwlFvkIYvh0AdWu0ALKfY5q8T7ty9zs2cMTLtvFEOI/9ZeOdbbg==
X-Gm-Message-State: AOJu0Yw/F6DGVq0YxBaXobCdVZguOfNQNozoJyqcXeP/naJbAgpFZCud
	Ta2RiCS/P9gYK6FsUiTDjxzSy3uK6e/e/yxZ1X7fGn0mTQIhqy/A1GGNn2cOiOEtqnJQXjFO0uq
	RuIDBnC9go5q+CNU+sTRQHpbLXvlImsBwaDXroA==
X-Google-Smtp-Source: AGHT+IFBMfY49BQgh2Tb5yTn8UvNbXKzbYAPOT1TpnvoUggc5GN6IAoxuevSLM6hdnQqS8GfgZN31YAH5IhissVyIaA=
X-Received: by 2002:a17:906:c34b:b0:a43:f341:d21e with SMTP id
 ci11-20020a170906c34b00b00a43f341d21emr1437389ejb.34.1709132489123; Wed, 28
 Feb 2024 07:01:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206142453.1906268-1-amir73il@gmail.com> <20240206142453.1906268-4-amir73il@gmail.com>
 <450d8b2d-c1d0-4d53-b998-74495e9eca3f@linux.alibaba.com> <CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com>
 <CAJfpegu3_sUtTC1uCD7kFehJWTivkN_OjcQGsSAMkzEdub=XTw@mail.gmail.com>
 <CAOQ4uxji-yzWFeQYP9FKvVXg473GP6tC2pyHUbEPoYxT+qDYsA@mail.gmail.com> <4e3d80ad-3c61-4adf-b74f-0c62e468eb54@kernel.dk>
In-Reply-To: <4e3d80ad-3c61-4adf-b74f-0c62e468eb54@kernel.dk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Feb 2024 16:01:17 +0100
Message-ID: <CAJfpegsAs3V8jU2UWyJUB33FCbmoFiOSp9Cjzrgc9+XcomN0Uw@mail.gmail.com>
Subject: Re: [PATCH v15 3/9] fuse: implement ioctls to manage backing files
To: Jens Axboe <axboe@kernel.dk>
Cc: Amir Goldstein <amir73il@gmail.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Alessio Balsini <balsini@android.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 15:32, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/28/24 4:28 AM, Amir Goldstein wrote:

> > Are fixed files visible to lsof?
>
> lsof won't show them, but you can read the fdinfo of the io_uring fd to
> see them. Would probably be possible to make lsof find and show them
> too, but haven't looked into that.

Okay, that approach could be used with fuse as well.  This isn't
perfect, but we can think improving the interface for both.

> > Do they get accounted in rlimit? of which user?
>
> The fixed file table is limited in size by RLIMIT_NOFILE by the user
> that registers it.

That's different for fuse as the server wouldn't register the whole
file table in one go.  The number of used slots could be limited by
RLIMIT_NOFILE, I think.

Thanks,
Miklos

