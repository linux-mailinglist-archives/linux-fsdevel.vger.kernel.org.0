Return-Path: <linux-fsdevel+bounces-22990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF32A924D21
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 03:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F12283D4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 01:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3184683;
	Wed,  3 Jul 2024 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL6RtaIb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434651373
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719969595; cv=none; b=LbBmyQWShi/go1rgyRCoiGtH3W9H1jKv9EXjdmGc76gMCYuTJ5EZw3s2Iby1JpqgyxX3vpMSzU8GTiREa2Md8PAEFMTttlDuq9xbAAihy5gI29vTH6syvcduHZg64urRHELtakxPFF5w7q9oK/D1eH8GFv0NCHLlgWzcfLbwvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719969595; c=relaxed/simple;
	bh=icvHM6vHx5tc35KsWjVeZnOUrDfdLw9A4yDiG4jpE1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8gLFls3b/qWTwpJH4c7JNuLCc0nPGKG1Lw9H+Q1eq2xFsJ1KjQoh69FCV7s8TlSiq3izdr0wVp77FYPamwh8VFzElOngeHAWwIdT50CNh3ModrwYIYJwLP4BKZ2eMqDKWwB42kYw3TveMBUkZWUNLvdwZki18eKYClkOzZmIUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FL6RtaIb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719969591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icvHM6vHx5tc35KsWjVeZnOUrDfdLw9A4yDiG4jpE1M=;
	b=FL6RtaIbTmYUr+pKRYUsAnGGDEy0Ix9rAvL9lktvMOpNi/TJJKQdEB5E8G0+o8CoXMmFI/
	g/lIwChyn0apmG3dqg+gWwuYoK/IrO9TIaBEIhMQT2gnqGmEW0EqaupQIJMr8gcDILgBus
	MJ7ta8NFtnbBK/lI5N5/7vkljddIU4g=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-Ovl-czW4MXG1VM6I8bsmeA-1; Tue, 02 Jul 2024 21:19:49 -0400
X-MC-Unique: Ovl-czW4MXG1VM6I8bsmeA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee847979c4so1343231fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 18:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719969588; x=1720574388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icvHM6vHx5tc35KsWjVeZnOUrDfdLw9A4yDiG4jpE1M=;
        b=EYyIatjHENBBbmYaUBxHjvwF+hrRI+x9UOXvxiR6qFiZ9q/itV8yCriPUGjpfAbQJO
         Fuy8IGVASkb+RJVkfc2eFn+yXzg+lBONuaUirpwlv5jvTvWjBu9a591FdrCpsEL+nLKj
         HVbLCc+6AJiruwUNpZ5tu3jiuQl6xHlGCDGeitZvt3iKn0AxYkwh6w9KZbTVS+WLFbjD
         UCjGvmSFT4d6gSGc/aWJ6CuMwK91OkG8pI8YuiMYdVR23/u8BF2AVJm3ZRpbfl0oW46U
         8i7DAZQPNxn0n+T9Qmvu2MMx0L6f9qWc48Ga5mfPYSOi2oVGza5KhMGiThpEPvqTObWJ
         RcEg==
X-Forwarded-Encrypted: i=1; AJvYcCWa9CeZ74PfI36CCv9bBPUTIzAyLl1PHGrqgaJuKYEGW7zGPpFkZAqqdLpHc0iYnu/19hWBCg2Vcqd1OD9fwtS4i6aHbSNIjw+Fmv10Bw==
X-Gm-Message-State: AOJu0Ywx1gKZy8HNOlIDf0RCV6nMj6a7154g4svL+iJZSMIeeNZgqCKn
	bECS3Nh2ukCFjjTbPjIMHJKDwn0ya2B+CVwQJ7FnM88pJerM4dpxZpZ16JScm7Dpkf3NYC2CneS
	//QoCGc4lWHoVzt58JNeWXv6sktNWQoBB+acYDN5rY+yrUdxpowMo6FmSRn19hX0BuxQ5bpDaCh
	hvh5Jd6uk5Y4dKzmBZGuUa3Uc8Elw3O5w5zS4RCA==
X-Received: by 2002:a2e:87da:0:b0:2ee:84af:dfc4 with SMTP id 38308e7fff4ca-2ee84afe254mr1112301fa.43.1719969588354;
        Tue, 02 Jul 2024 18:19:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpSlLCK3MniAmeHCNTRdpfutNVFg4NqDVwYsLGRYKV+Sfjk7uWrrnhbyYN8jIK9spnz0JpXL33Bgon8txPAoQ=
X-Received: by 2002:a2e:87da:0:b0:2ee:84af:dfc4 with SMTP id
 38308e7fff4ca-2ee84afe254mr1112141fa.43.1719969587971; Tue, 02 Jul 2024
 18:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-filelock-6-10-v1-1-96e766aadc98@kernel.org>
In-Reply-To: <20240702-filelock-6-10-v1-1-96e766aadc98@kernel.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 2 Jul 2024 21:19:36 -0400
Message-ID: <CAK-6q+hCQNg8XK7v86hhgsgPu2c_aN_+xRZBzTG7DQ-fee8vRg@mail.gmail.com>
Subject: Re: [PATCH] filelock: fix potential use-after-free in posix_lock_inode
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	=?UTF-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 2, 2024 at 6:45=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> Light Hsieh reported a KASAN UAF warning in trace_posix_lock_inode().
> The request pointer had been changed earlier to point to a lock entry
> that was added to the inode's list. However, before the tracepoint could
> fire, another task raced in and freed that lock.
>
> Fix this by moving the tracepoint inside the spinlock, which should
> ensure that this doesn't happen.
>

makes sense to me. Thanks.

Reviewed-by: Alexander Aring <aahringo@redhat.com>

- Alex


