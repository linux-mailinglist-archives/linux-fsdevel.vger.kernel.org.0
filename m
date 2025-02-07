Return-Path: <linux-fsdevel+bounces-41178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B9FA2C0C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 11:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4227A50C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 10:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7DA1DED43;
	Fri,  7 Feb 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="n7fZoZqD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B761C1DE3C7
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925004; cv=none; b=fKCdt+/sac+Is2Q4/hDBLqpiwURiZQQBgm2B4mGw34CVOW7eFFFohHJSLutCHykV5W4vUcCg3VcaaWvRFpS8mLJDn4DBNslJ+t4PoASVrDPVACOIoBJKUUnyjcae+/GPT9Uzgjv7iEIVEGGnzbVSk27n8s12Na+g7MMQiSojhxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925004; c=relaxed/simple;
	bh=Owr0YKtHdkqN7+hjoDD8i2kaaYELxg9xOxfJ6jW9Nv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhteeB8KjRNuULhIzyhFaKZPNhgS3truyqbh9ZYy24waP9YqaEdh8YQm9SqWHNxDG7KrKn84YkUXDMFmwTPwpIXBnlYFtNmVGwHD7UvmMh73YvKT3arn3MMIw9/Yp3s0LixZLYVOcSQg8gi0aBp98lqG/RQfdGwnzRKnt3KAJEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=n7fZoZqD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46c7855df10so33279051cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 02:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738925001; x=1739529801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Owr0YKtHdkqN7+hjoDD8i2kaaYELxg9xOxfJ6jW9Nv4=;
        b=n7fZoZqDT4vk+0bdMrtxd/YI7dimv8kuM/grOemUcOVHkYMX0UpaO9EqD9YfsVmdyL
         FC7iG983FWjBUWh8Y1zA9gBM7qzwDNoTq6cbBzbpPqwFPgEFi7PGGJhnNvPmlwlA3vRN
         I4FHJFVQ6SfWOagLUSCAmaWejnU3QIVCudSZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738925001; x=1739529801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Owr0YKtHdkqN7+hjoDD8i2kaaYELxg9xOxfJ6jW9Nv4=;
        b=JKQxHARVZthF/T1tRpga8JF2TAt5S/rPHzL6HWLeqSX4/A25GWjPcaZNqNJhlHfiNQ
         Zx4aMhkr9T5QK71eqgKufG+1dVUPMWhT7hG25jqGfu2GlNt3DlyPPC847DVnpQOSKsQf
         e2Nbaf0vsuZfXVz/vXYiiO6quy1gIM0SpPtIZJElKE5y/4fBJH60jqo+3ANQbzY366W5
         pqYRwpvrxsNR1dzEqYSLk7eV6SoQtgg4GUAlG0ZjqK1gfbFJJqS4gtV0GlzeQ/Yo4tFd
         xusc4tNGDnvBah6oEO05GE26J3bmWUBypApLOvXXaYUdlIzLzllQg+bvtW+qu3XyBPwK
         huyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6HXwuJOu2Fvz4y4V7NTcket+dWZs3tgfaByFsF2wVjIv+Af2QEcpyuqNAL8EwpIxd8MGhOzgyDjE2p5KQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyltHq5W6CDPo/IQAiQ4aKeaN5ynbfx/XRX73lc+Z9hWBOZQdR5
	WIu5kLh0p5dXcYQ7ixbwFJUToUFEmhr+zJqakSctE2X8isuY92OAGGHtu7IPn9gRCbg3zl5TS1c
	3KXrR9iosBoYqwEOtRCrYOPZwlNP8yoQwFVzCaA==
X-Gm-Gg: ASbGncs9ZcO8a1j5Qul0/4OHfF8mTF5wohnDpep+yopOyIeS4gEVGppETuHOfTH10BD
	/Tdob/NSQXnza29E00gNk9ukF6qTodEOYkSwxOxw3lPq4LWCIftuickfeBKn4395CEYkg1A==
X-Google-Smtp-Source: AGHT+IGkFRBaRLP1f7W9gqHW6Q2AKQLytp/hmZC95VfJ6xO6/ON3OM06vkit9Bhnsvf31fWFt29Royhe6fq1H0cZIa8=
X-Received: by 2002:a05:622a:4887:b0:467:6486:beea with SMTP id
 d75a77b69052e-47167ae4440mr41388981cf.38.1738925001678; Fri, 07 Feb 2025
 02:43:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <Z6XWVU6ZTCIl3jnc@casper.infradead.org> <03eb13ad-03a2-4982-9545-0a5506e043d0@suse.cz>
In-Reply-To: <03eb13ad-03a2-4982-9545-0a5506e043d0@suse.cz>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 7 Feb 2025 11:43:11 +0100
X-Gm-Features: AWEUYZlIBtfn2RHJWB88UL-DRtlyctc8WdFktH0eXJTCByl5CkmXjOsWS504hvk
Message-ID: <CAJfpegtvy0N8dNK-jY1W-LX=TyGQxQTxHkgNJjFbWADUmzb6xA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, Christian Heusel <christian@heusel.eu>, 
	Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Feb 2025 at 11:25, Vlastimil Babka <vbabka@suse.cz> wrote:

> Could be a use-after free of the page, which sets PG_lru again. The list
> corruptions in __rmqueue_pcplist also suggest some page manipulation after
> free. The -1 refcount suggests somebody was using the page while it was
> freed due to refcount dropping to 0 and then did a put_page()?

Can you suggest any debug options that could help pinpoint the offender?

Thanks,
Miklos

