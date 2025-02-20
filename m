Return-Path: <linux-fsdevel+bounces-42161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCA6A3D6A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 11:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03B83A9403
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 10:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C901F460E;
	Thu, 20 Feb 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="e4iYBKC3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129B61F4179
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047200; cv=none; b=A4SgyUbUnr/P2wY3Dl2jjW+x8YpVH5ZfbOfDFoVES9Zx+bic27M6K44g+FocrcfO8Nrp2WPtOrKo1BdziiafPoHzq66mKoduqbaZytn1Sw16GdIgEgOm5QVvv1j5hEwe5SvdUuvX2Iy8r6v5Im06SYYQeLaPsEHKlx1jcZ30/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047200; c=relaxed/simple;
	bh=V6Edk5zgRNMwf0KPujPbDopnlgY19hikcQGsos6MIjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJpy/AijRNMs/pUuvrav9/0UoGbV2iG7zrxEpVUKdDdYbDCL3TkPhgG+krYAYqJtNvWHDFfBiQRWcCZGZGLbg1Q472Pxwc6gWpbSYcPBovdvJOghwqL+iL50ldoxiVDFnElgWnloxLBLJzjC4dxsoP+MvW/WWqaF0qm3HYmhPYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=e4iYBKC3; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471fabc5bf5so4207741cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 02:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740047197; x=1740651997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dQN0odTWLISUqAvDr2uAPDyL9eSldyN/znrIQtakkls=;
        b=e4iYBKC3OnhKqaB7cN20LrITrFWXV52bE45XqnUx4rIjHrRv9RX9aeYH8Vkn5LRSmv
         wZ8jLBtC2O75RXoA+Qsw31mCQkBz1bnDFuFdd5SgUJQ31ku0F4A/I6eRAHFJiEVPq+vU
         WwW1bsmkogjPXRwN5Kh57rJ3twpFmoq1ok/8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047197; x=1740651997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQN0odTWLISUqAvDr2uAPDyL9eSldyN/znrIQtakkls=;
        b=bwy0Tfdr4+IkyOR/uVu+XT4r6yCrWl5q1jhgr+g99hNdO2KHVqZtwVqmoIa1KB2K2C
         RE6VBs828TawroX8UwbUsWoNU7SRLrseiPdwhGT2RlN8yar/y19++BMMMj9MoZWUy/BV
         Nefzcik3FEhjYLneCHam4lsntXInwGaBzPZJdmnmJRzQmDPsu9UDYkLsc0i4w1X99LoS
         c5aQOq1DMvQLpMm63YEFi+OTk0WCVsIIN2rhNdYUoNJWjGIU/i1Gk/oIjZqhEvtoJZSL
         0tGWBLxSP7sYDO0Jn/TcSyQhuzddIDutm2XPPvEtGQ/d/K/qsomQ89DQ3inK3o9WEhSg
         rTWA==
X-Forwarded-Encrypted: i=1; AJvYcCVw2gNIRD/T7qT5i4hllKBOSTjm7D8qucm2DmHCilYb5ThmPPNZhW64YNaex1BucYqfHkHSKm6Rb33qXSYO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7UHHwTduJZmQd9BRp2ZtRrGhNSxbQnNgcKJQcMRWW1JBMIR8
	O8s8B2v0IBzwviRPlNMTk9+X4BdthLujoeplK0JpkXemY2/1hqRwMjZWpNnCbXWi8N0qNIVFJ7m
	93XM0LmDPlJAyzrjV7VtBcnlp1JFcj7cfaPB6+g==
X-Gm-Gg: ASbGncsQ3zdmy5OrWURDKYREAaY7y4ta779nB5AztiHFWKHYxvu3qW7GPDT9oUQT8ok
	sW1x0eItNQ2UjlaSEPsHMu89ZgPrE9UJz/OIesRDGTvfqMDd0lcUKdSVWP+rLM0PrI4r/m+Y=
X-Google-Smtp-Source: AGHT+IGRJPZMq9+Zsh04s2Bfc6SWMbuE4boAj+L9wxLBUA+rIxj2TODkRKrofCJjtslUaLNUdm768xTw5oFKjTnOaDs=
X-Received: by 2002:ac8:7c54:0:b0:471:f754:db41 with SMTP id
 d75a77b69052e-472082b9d93mr100755021cf.34.1740047196816; Thu, 20 Feb 2025
 02:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com> <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com> <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com> <CAOQ4uxi2w+S4yy3yiBvGpJYSqC6GOTAZQzzjygaH3TjH7Uc4+Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxi2w+S4yy3yiBvGpJYSqC6GOTAZQzzjygaH3TjH7Uc4+Q@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 20 Feb 2025 11:26:25 +0100
X-Gm-Features: AWEUYZkhiAj_8eHp38HnBlmuSiVR3xJYCPcNMjDk-xRXxKLPfZQW0XQJDNdCBM4
Message-ID: <CAJfpegv3ndPNZOLP2rPrVSMiomOiSJBjsBFwwrCcmfZT08PjpQ@mail.gmail.com>
Subject: Re: LOOKUP_HANDLE and FUSE passthrough (was: Persistent FUSE file handles)
To: Amir Goldstein <amir73il@gmail.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Hanna Reitz <hreitz@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 18:58, Amir Goldstein <amir73il@gmail.com> wrote:

> I circled back to this. I don't suppose you know of any patches
> in the works?

I'm not aware of any.


> I was thinking about LOOKUP_HANDLE in the context of our
> discussion at Plumbers on readdirplus passthrough.
>
> What we discussed is that kernel could instantiate some FUSE inodes
> (populated during readdirplus passthrough) and at some later time,
> kernel will notify server about those inodes via FUSE_INSTANTIATE
> or similar command, which will instantiate a fuse server inode with
> pre-defined nodeid.
>
> My thinking was to simplify a bit and require a 1-to-1 mapping
> of kernel-server inode numbers to enable the feature of
> FUSE_PASSTHOUGH_INODE (operations), meaning that
> every FUSE inode has at least a potential backing inode which
> reserves its inode number.
>
> But I think that 1-to-1 mapping of ino is not enough and to avoid
> races it is better to have 1-to-1 mapping of file handles so
> FUSE_INSTANTIATE would look a bit like LOOKUP_HANDLE
> but "found" server inode must match the kernel's file handle.
>
> Is any of this making any sense to you?

Not yet.  I remember you explaining why FUSE_INSTANTIATE is needed,
but I don't really remember.

Can you please remind me how exactly you envision readdir/lookup passthrough?

Thanks,
Miklos

