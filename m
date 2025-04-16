Return-Path: <linux-fsdevel+bounces-46590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF6A90D1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 22:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE03188F03C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 20:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA0C22D4E9;
	Wed, 16 Apr 2025 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTuMOFXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A62F22ACEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744835215; cv=none; b=PmPVNZTerJwMbUc18xKFYoUGOFMgWXtoe7Tm+eu2yu3O8o/obhKjFpFUSGqLaQJh/UxwA4LAbXt7FkL1tRMHZpAGlbyomVV8cflpe0XiOO6c2Fy5ZwSffZQfIsB7AAkddSJVAHlPebMSY0e00wD/3VMFDdOtSdwJyHtz+CsEJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744835215; c=relaxed/simple;
	bh=+NVEIDajjOa6S0mwO8uDhLAW9+C2KQqJgF0nDKTn3hM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mr0SR+aXfffpfcUhbS89+/wyWXyIgMjmV30duvOkRDntvhbzsmUYaGdao4Ozl0K99PMO80EmlB0YKT5aeCPqGXi6guNkHEuYBD8VWJ/brJMfROntyoVbYdIY874hRTSIBAFHygzyt0XM1Uj3l4dYYkBWXp1cSDnVCGAGU4kjxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTuMOFXV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744835212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6AVDplNPTi289CSbOZ9ARQJAN0z0vy8/1A9VIws9D4=;
	b=LTuMOFXVp2y/fyLkhE5C/W7nV3vj0wgfRBr1Q6DnkM/0L6r6Jzu3fTw0ICCfWXB9DziUpY
	dAdbJhmAnqIrL+OqoFHRR92+nBQtwvemwkuE7iNXodZFL+ynZBLj8EELn/C553c0jKl9IO
	UBYLzlDshiTI1xfnf1VeDxNJdeGrSlE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-Osg3EeknNQqVty3taWib7A-1; Wed, 16 Apr 2025 16:26:50 -0400
X-MC-Unique: Osg3EeknNQqVty3taWib7A-1
X-Mimecast-MFC-AGG-ID: Osg3EeknNQqVty3taWib7A_1744835210
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b4d893399so685039f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 13:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744835210; x=1745440010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6AVDplNPTi289CSbOZ9ARQJAN0z0vy8/1A9VIws9D4=;
        b=ImNH306vnUV25o8Ofc/Dz2xxfqCmAtSBrH+AFZ4bsrLjGxiPMB6PTWQxN3S+NchIm4
         EeBFafxx4VF0AxRhCsm0njBEoIcVnJHW4xCNl3eTlmN0YtwnwITA0pVkhQnIkidHW64R
         7++ih5ac+WzIIJxkoHsB1rP7NeLzCdn46+c4+feIK7PPSho++8TFd3SJuzEY3mtmtSGp
         FSkeZ8FgNVkslTqNfDwLLVaIy8zCwz13H/f83k0FHCQg4Ini/gMpLYkE8TtR8Mly2G7Y
         QBM4LyemgKaOQMbO8dofy5tZea5VjuACE9/W1C5yZNiiGwZBNR2PngpGH/roE/pw1U3L
         Wzfg==
X-Forwarded-Encrypted: i=1; AJvYcCXiTV1KZjkSkFRM5IXKLjQVr8s6lppvI+MEWsMAhJB+v/vj1CYHN2v6WU5JaSpMxY/onCH/ZArTbsHj/pnn@vger.kernel.org
X-Gm-Message-State: AOJu0YxsgoBPYfwH2hOz/QaV4MPKvbo9/NH03myMTDTg4OPgL9Uxm7bK
	eSTOPVcOx3xRWiBBI4BpPtVb3/Uc5Y8zsDEu83mgeg0zsYRXt4UgHQ664sqlnRtFrs9Z5XX8BR2
	Q1UIu96AKUjZnz4Bfo07hY6yueF7Kc7Y9ZRb64DDC065DnkNZoRwLqiW+sr/EVGI=
X-Gm-Gg: ASbGnctoq91MZQvSzlrWRqCErSWAYx+Fbbu26ZtLDUgcpb15pLudO6T4niy7NwvePuz
	CmuUfglvR++Ewoqmy5t3dSsEP9zj774Zc038QKQ4RaWCl9hi+lPenAOZuFsWCOGgDEXSbihuvTw
	U9oN1SiyWxXx+vY2cvbO0QLGRYvSxeN6uCxUafP3QMHcgzlwxyySa107IBqRksdkzokdmTfgq1i
	EEWdxm8Alwm16ge7Nt4w3lxJ8c3FK3C6ibUNfyov/9FookkQ7g0VrspYpC+2QBXqrt7TgnYWqhe
	GlGigikN7CqNNgs=
X-Received: by 2002:a05:6602:1583:b0:856:2a52:ea02 with SMTP id ca18e2360f4ac-861cc5cfb48mr34533439f.5.1744835209675;
        Wed, 16 Apr 2025 13:26:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdbc3yXRCu1SxHof01X2wIaipkMkSkrZJncD3XrTLmdj2ulJ1ktFsxzmI+33GyeGFuM7i9VQ==
X-Received: by 2002:a05:6602:1583:b0:856:2a52:ea02 with SMTP id ca18e2360f4ac-861cc5cfb48mr34532239f.5.1744835209342;
        Wed, 16 Apr 2025 13:26:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8616522d048sm306863539f.1.2025.04.16.13.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 13:26:48 -0700 (PDT)
Date: Wed, 16 Apr 2025 14:26:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig
 <hch@infradead.org>, David Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe
 <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jeff Layton
 <jlayton@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Logan Gunthorpe
 <logang@deltatee.com>, Hillf Danton <hdanton@sina.com>, Christian Brauner
 <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Sasha
 Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 regressions@lists.linux.dev, table@vger.kernel.org, Bernd Rinn
 <bb@rinn.ch>, Karri =?UTF-8?B?SMOkbcOkbMOkaW5lbg==?=
 <kh.bugreport@outlook.com>, Milan Broz <gmazyland@gmail.com>, Cameron
 Davidson <bugs@davidsoncj.id.au>, Markus <markus@fritz.box>
Subject: Re: [regression 6.1.y] Regression from 476c1dfefab8 ("mm: Don't pin
 ZERO_PAGE in pin_user_pages()") with pci-passthrough for both KVM VMs and
 booting in xen DomU
Message-ID: <20250416142645.4392a644.alex.williamson@redhat.com>
In-Reply-To: <Z_6sh7Byddqdk1Z-@eldamar.lan>
References: <Z_6sh7Byddqdk1Z-@eldamar.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 20:59:19 +0200
Salvatore Bonaccorso <carnil@debian.org> wrote:

> Hi
> 
> [Apologies if this has been reported already but I have not found an
> already filled corresponding report]
> 
> After updating from the 6.1.129 based version to 6.1.133, various
> users have reported that their VMs do not boot anymore up (both KVM
> and under Xen) if pci-passthrough is involved. The reports are at:
> 
> https://bugs.debian.org/1102889
> https://bugs.debian.org/1102914
> https://bugs.debian.org/1103153
> 
> Milan Broz bisected the issues and found that the commit introducing
> the problems can be tracked down to backport of c8070b787519 ("mm:
> Don't pin ZERO_PAGE in pin_user_pages()") from 6.5-rc1 which got
> backported as 476c1dfefab8 ("mm: Don't pin ZERO_PAGE in
> pin_user_pages()") in 6.1.130. See https://bugs.debian.org/1102914#60
> 
> #regzbot introduced: 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774
> 
> 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774 is the first bad commit
> commit 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri May 26 22:41:40 2023 +0100
> 
>     mm: Don't pin ZERO_PAGE in pin_user_pages()
> 
>     [ Upstream commit c8070b78751955e59b42457b974bea4a4fe00187 ]

It's a bad backport, I've debugged and posted the fix for stable here:

https://lore.kernel.org/all/20250416202441.3911142-1-alex.williamson@redhat.com/

Thanks,
Alex


