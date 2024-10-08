Return-Path: <linux-fsdevel+bounces-31267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA8993BF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 02:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6CA1F252E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 00:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225F214A82;
	Tue,  8 Oct 2024 00:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NdaZhrdV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA822EAD0
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728348878; cv=none; b=SdcFRzQA4KsaseH/4JdiKlreI1j570DL0S2GU/HDenu3cXPXh5qHDLvI5H2XhLwFU5MrYVms8erOth+XuGeVhsvF3N1NzPlWqYyMuLsYgKgilKJSet70+PL59QDpq77vSxeb3iI0XCTMcoLRZKYUIsG6XA7LohNA5oNRb7rPEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728348878; c=relaxed/simple;
	bh=NqYO63ftG4Vh81Um6zsjfmC5SEgFzFYHUlSf+opM8ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4LzzznWe+5dr1gl90C2yMRhgjHwiFP2agYIJaZxPHmAR5O2k3BK/3dhG2C7ne42e4usR+wkjcxJtzaYT1gxPFLKWTodiiBMk/PeQPwshh0abgerCYJi/iRC6fE2ZrPhEJj+UHx/sZtiJ8s5RoP74mTZV/S3LC0PDal/d85+53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NdaZhrdV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5398b589032so7584460e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 17:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728348874; x=1728953674; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tnmN82gruhjoauaDPVFxp6c7gOVhPQGFyw+79HJzqU8=;
        b=NdaZhrdVGnvC+ynbG0T9KCf7DMjktaeRH4d4I6bNUmXk6Ilf1uLQo+62QMJeoeYD/O
         t/anE2EUJPZC+Jg3HfplLd1VxFoiK1cbfEqGiVFasyiWbSZH9caf/Y2rwIbjw0BG4tR8
         e4AvmBDn0+VOW6eArHhZ20eckBBH4xwa3Qdec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728348874; x=1728953674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnmN82gruhjoauaDPVFxp6c7gOVhPQGFyw+79HJzqU8=;
        b=viHWXOpvymI/wwpOo2Jw5CdmJFg3F/AYH3VFyE1851A8mw+y0fDB8hEtnBuxaAfzs7
         dGGKYg+nvHsmZOv0vsRWaG752OMNgnGqXXH7PONiYh3L6yWklWWLMvjDis21iKBNDBvD
         HhD9ba3Fm706tHyfF2m4u6FO90nh714++WySqxEYnvaD5+AAPgkidv/NsEsUXcROdkl2
         xdoh6rRQvYfcBb4NeT43jkms5E1elA6WpPzblcsKmjKnmzwANSCKdWYgAtkBSDsLwgIi
         DXidrugSfuqPp+B5dRpq91Dp3mFKm1E4DJYhtXobqM1YvzCxqthz103Qn5UQQdTncdnN
         9x8g==
X-Forwarded-Encrypted: i=1; AJvYcCXYSgBaEOpMfTCeD8HKUoXbHgRD/YoFBKxinb88c0SLva/KPi3mEMjdGAV/0uTLQxCsjQ3XaC1I+Pzk/m73@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0pOGMlAVKs2UrmMTNMtPQh/TGR7iyiVEw52l6qN4PD3U0NCa
	gP+09KOb21hysbBkGxsbGyxE5DIrGAXgqE3e3sQN3HniVJjrf5xST9WuhmnVZyrYvMNSsWAA7Ex
	ypsgTEg==
X-Google-Smtp-Source: AGHT+IHYRC2Ndut457k9qg+HhjzXYZh+FaFGVwC/6C5gnl/aIz8hLbkfh/KyP6a694nHNb5IcRTs8w==
X-Received: by 2002:a05:6512:304d:b0:539:8d9b:b61c with SMTP id 2adb3069b0e04-539ab9e5fadmr8133052e87.51.1728348874537;
        Mon, 07 Oct 2024 17:54:34 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec12f4sm1012137e87.56.2024.10.07.17.54.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 17:54:33 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53991d05416so6069374e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 17:54:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDbvFRHGSHFM0acjijlAdQEfZOQnhQWN0GmRtbjX8va/SUGaiWftsZa94N6fmP5Qsge5Oes4fd83201j5U@vger.kernel.org
X-Received: by 2002:a05:6512:3d07:b0:52e:fa5f:b6a7 with SMTP id
 2adb3069b0e04-539ab8659c5mr8118408e87.13.1728348872429; Mon, 07 Oct 2024
 17:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002014017.3801899-1-david@fromorbit.com> <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org> <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3> <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area> <CAHk-=wi5ZpW73nLn5h46Jxcng6wn_bCUxj6JjxyyEMAGzF5KZg@mail.gmail.com>
In-Reply-To: <CAHk-=wi5ZpW73nLn5h46Jxcng6wn_bCUxj6JjxyyEMAGzF5KZg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Oct 2024 17:54:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW0RspdggU630JYUe5CyzNi5MHT4UEfx2+yZKoeezawg@mail.gmail.com>
Message-ID: <CAHk-=wgW0RspdggU630JYUe5CyzNi5MHT4UEfx2+yZKoeezawg@mail.gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert sb->s_inodes
 iteration to super_iter_inodes()
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	kent.overstreet@linux.dev, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 17:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And yes, this changes the timing on when fsnotify events happen, but
> what I'm actually hoping for is that Jan will agree that it doesn't
> actually matter semantically.

.. and yes, I realize it might actually matter. fsnotify does do
'ihold()' to hold an inode ref, and with this that would actually be
more or less pointless, because the mark would be removed _despite_
such a ref.

So maybe it's not an option to do what I suggested. I don't know the
users well enough.

         Linus

