Return-Path: <linux-fsdevel+bounces-26147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1173A9550B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 20:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEDC1C209E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4081C3796;
	Fri, 16 Aug 2024 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CyiR2xY0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6B31482F4
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832582; cv=none; b=U5ZygwNsRuQR3h2BXQJQzjzjQypuJ6aigrxxJ8bZWxfLff4WmFAc8rZQ6bnFPnyLpAtD2mx/CjCpfPCoDWc6nsSDNQlQetV6Yi9fPPKmtoiGw6UjlAXGlKcr5T8wOH4kX9/Z5+zd5DpGkXquNl2pAxZpu2hW+RlM5wONa/Ufh4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832582; c=relaxed/simple;
	bh=C/KPVQOdL61r1aj+fFYyQJ8nYW6G4L9oj+F7eqj0zxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WIwc0EpHY+nGcdVuwQLBmi1DF98sK4jk+K6n4/VjeovLXq23VliEFuDyoBJkQwSEXzII3yYYDXUo6i/1HWRNN5f56m8V5Huo0aCYcXmgdPdk15hml2jlDV/zXRn6toRjWgZ6vhsI6jx9jiVTMhwltFtLd42njVS+4fypTtz+wn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CyiR2xY0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e117c61d98cso2030660276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723832579; x=1724437379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Da+yOGUnAi9BrtxeKlOOzLVm+rCdCeLa2u69ZA1xPsY=;
        b=CyiR2xY0EqnCnwW5KUW0XZybvLPrnwZhEQH2T8zpbM7G6dOFUC92b0Jkj34jFfgJdI
         shYO1g0lX15CFBxLsw8nduXNJhHJDSEvuE8/fU/L7SZWPZyzDjo3Z+ZIf4YtL2tXkbl+
         eg9halxd/w28aSUXWxtXdXMG61yHN/ltToZ8//GQ8qDZBQ8qJsZaszW0dSSzdbFtvGgi
         gAAEsL2tQowcv1uxVbLPtNaBJEl9imscdeaUdzLH1yvOGeBjF5O+2haPHNxwD+PTi8ek
         7Immfc4GWmnzClq1y2mT2WSHYTpZSOu7+yPswSYz1t7O+Mj1QR+1Nn4CqJbgFx7E5IzU
         vrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723832579; x=1724437379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Da+yOGUnAi9BrtxeKlOOzLVm+rCdCeLa2u69ZA1xPsY=;
        b=FnoGwME86FZ+qgPsycZAqcndC4IWkEgpZHvh+psOzQOKDI30Q24tm5kRnjXcMCuCwf
         ETUBWgj2EiGpesIkHNx9R8JaKcIG2aXbYn9bhxGA3lIxZHnla2MwD0Tw4ib0QfU7XCzV
         2bSZLlcw6mSSIznnlOfB9lNtgfgW3TnUM3Ai2IM4pCID45Ur6xPNWCB7U7WqWAAbhBJq
         xs8tMdjR7rR46KpK0e2sa0iWgg0wXaREXfnguQJxVCNK3djLtphr9SKAMrx7J7OH4FQw
         lO9mOvnhdfHXzirN5CqWZJjgynqUaPVizRz1fmrnm9JdfSxAeA2ZpPX9nSu8XEfYh2np
         QqLw==
X-Forwarded-Encrypted: i=1; AJvYcCVVHe8yFIvBFUhz5IYgqGlfZmuChUreU2UzssCO7cLaci1f81X2m5S+ze99uJoC87d/ygbtlK92/sue1Ajy/Gju576izy4JyqFPC1H0ww==
X-Gm-Message-State: AOJu0Yyq0ni4jKfHkjvkGCdgyiKNFEcuwP7t2qPsUR4Sgsr7tGtPOSzv
	ae9bAX3CXVAEnEa3GqrW1/E5+kPCo1uhokmKIMaODqxlm9lB3VEtOB6Lq3rQzdEZep7NJAWTe93
	6iw==
X-Google-Smtp-Source: AGHT+IFfcTETiulkEGd1KSTGEzd2S0thNDH+lgRaKyP+72dCCah4oHM6tDo0fs41jUmb4XdaXCTSKTwY22o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:68ca:0:b0:e03:3cfa:1aa7 with SMTP id
 3f1490d57ef6-e1180e4a917mr5430276.1.1723832579587; Fri, 16 Aug 2024 11:22:59
 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:22:58 -0700
In-Reply-To: <000000000000fbce8506178da1e8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <000000000000fbce8506178da1e8@google.com>
Message-ID: <Zr-ZAsFVFiQuys7K@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in cleanup_srcu_struct (4)
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+6cf577c8ed4e23fe436b@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Fri, May 03, 2024, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14004498980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
> dashboard link: https://syzkaller.appspot.com/bug?extid=6cf577c8ed4e23fe436b
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1b4deeb2639b/disk-f03359bc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f3c3d98db8ef/vmlinux-f03359bc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6f79ee1ae20f/bzImage-f03359bc.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6cf577c8ed4e23fe436b@syzkaller.appspotmail.com

See https://lore.kernel.org/all/Zr-Ydj8FBpiqmY_c@google.com for an explanation.

#syz invalid

