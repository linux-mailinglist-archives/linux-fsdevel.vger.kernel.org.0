Return-Path: <linux-fsdevel+bounces-49837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 230F1AC3A6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 09:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3461891AB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 07:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51081D63C6;
	Mon, 26 May 2025 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSzcsMD/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038014B08A
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748243899; cv=none; b=vFD4zjwzpvrJLAmsmYObfyfzNij3PG3RoSkb6b17ikn6TlN4/GreJW2ygkq1MMhFI6NhNwi9mHIJRSchfvJpA8ynzxd4bC/O3JAeswym8MLmvkPdOhdmrg67lVte0qW6MdX2yYi7H5qFvUBnjlEwTQL1If3aA8UdRg0kGtWQPhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748243899; c=relaxed/simple;
	bh=MhtabnpIavzkMr/utWlwx7zU8uMNLoiqTGpDuz06AMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zyl8ORfltH2I/4+2FeSPFj/wK4I/cEXoMavDwz3TVyYLLu9g5FKbIUlPz7Jozv5pSRMypABd9J9hC+h5oegZiJmpgoBMo7jFqEFYXQ7xLN8/H7SPYfSxiO4riSri5nvK2YH4UNHwlS08qYIXncp6KUJ+Pt2ndAVznik3upW/ThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSzcsMD/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748243896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhtabnpIavzkMr/utWlwx7zU8uMNLoiqTGpDuz06AMU=;
	b=LSzcsMD/44njBoMlZwxO+chyVfVM+n4mpUN3ir4Y5nOqKgqOF8cmWMg2IAASAe551JNcNR
	B074/taTZZFmExxEAjy2o9CT+P6mBF3MnPXFuAeNRkBaFiWBJ6xs3qKBf7vamZoJn9xFmm
	S3W+N9B2ATrC7Tanomn0+9taEDyxElw=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-R1M_p2erMeC3bS4vIfxWEw-1; Mon, 26 May 2025 03:18:14 -0400
X-MC-Unique: R1M_p2erMeC3bS4vIfxWEw-1
X-Mimecast-MFC-AGG-ID: R1M_p2erMeC3bS4vIfxWEw_1748243893
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6061f07465fso407563eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 00:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748243893; x=1748848693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhtabnpIavzkMr/utWlwx7zU8uMNLoiqTGpDuz06AMU=;
        b=vL5+B/EUcifbIoPnp+26F9BPW6F/ivh63Ge2R5VNEBQ28IKfCQXc/GHFbmc6HyuW0v
         QvSXE7J8lSz6CgCANyQWpaGYN2MwUV15NLk8EMb21ZFQeALwKzvzVk770FdHUcjalVM2
         BZ8kmm0IiE/yn3WibAbzVZ7HIoi0HsjObIcnSRkba55LyLKtTK8jpqf119x/Q3t9sO21
         1JGAaEzLSIWRQgNqUPoNa6SkRd7cm0+mbr6tNW5eC2F9G/IU8JMqDzBVU6W2bvCplONL
         F8bkTNWGNunavjSNb82euenqvP2kGRQPG9QOPCAkGSVc79vtNem3ywR3+lH4/tNFHhZH
         mvrA==
X-Forwarded-Encrypted: i=1; AJvYcCXKVnKcZw0Q1zkyS0K5NRQNV4NTc/Iw1Wvgix/15jcpOaz5crtmT1kAEibGjNoGzhP2teMN+d/r41IhoxqQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJ3dGKRC0vHQH3h5669h0nYDS7XKderTB1P1y5vIEnlql5rMC
	MmFS2qO3T8fc/vGsOP9uXCVBPMxy1iPJ2EI2rjZ8LUTU0XFPERDiB+IhX39XtNwzoRwFk89113e
	xIeDsD4Kzp3SMYSuAn8weV8grMYdNSdgtwuq+xS817HjaRJaJ3OYTbMB0zpC4+qlwQyBkwZCxQ5
	YxKyA5F+k/XAa/622ahG0mXzT/fRsmkBJ3g83jEHpcrQ==
X-Gm-Gg: ASbGncvuRQQMjRfIE5R4RfQg0vVRdOu60OIJ7jMqEBlN0Y/ZzqGpfEvNcSm7hGz5Szm
	M7MK6/OYVEwcUc9pnTNUd2QOCRpzKmOzYYEa77nKF7jiFIZxxKOQ7152gt0UdFOfjJ2n8XaHeym
	2iJ72+NPeHA0/3mVbxugZrU0w=
X-Received: by 2002:a05:6820:179a:b0:609:def7:b3a0 with SMTP id 006d021491bc7-60b9fbddbd2mr4246497eaf.5.1748243893449;
        Mon, 26 May 2025 00:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsoV8gB5SIRagHLbCrfEmIADwxDed0rjq+p+XpXyymxSganKkRG55aDK7f6rAuLjY3ykD0u36rT+5HHRnvjPE=
X-Received: by 2002:a05:6820:179a:b0:609:def7:b3a0 with SMTP id
 006d021491bc7-60b9fbddbd2mr4246490eaf.5.1748243893100; Mon, 26 May 2025
 00:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOYeF9WQhFDe+BGW=Dp5fK8oRy5AgZ6zokVyTj1Wp4EUiYgt4w@mail.gmail.com>
 <20250515-abhauen-geflecht-c7eb5df70b78@brauner> <20250523063238.GI2023217@ZenIV>
 <20250523-aufweichen-dreizehn-c69ee4529b8b@brauner> <20250523212958.GJ2023217@ZenIV>
 <20250523213735.GK2023217@ZenIV> <20250523232213.GL2023217@ZenIV>
In-Reply-To: <20250523232213.GL2023217@ZenIV>
From: Allison Karlitskaya <lis@redhat.com>
Date: Mon, 26 May 2025 09:18:02 +0200
X-Gm-Features: AX0GCFtO20r3v_JXWfRnDyTyH-R6zGdfPMXHNgtZHPNLr-YCMQla-eCFnXlYvLs
Message-ID: <CAOYeF9VepEnQJjjC4Ch1HTe8ahuTTcb_RJ-B56b+KHVzSULqGw@mail.gmail.com>
Subject: Re: Apparent mount behaviour change in 6.15
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

good morning,


On Sat, 24 May 2025 at 01:22, Al Viro <viro@zeniv.linux.org.uk> wrote:
> Said that, could somebody (original reporter) confirm that the variant
> in git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git #fixes (head at
> 63e90fcc1807) is OK with them?

I've tested the commit (and its parent) against my original usecase
that found the bug, along with the latest kernel in Fedora rawhide.
Here's the results:


broken:
Linux fedora 6.15.0-0.rc7.58.fc43.x86_64 #1 SMP PREEMPT_DYNAMIC Tue
May 20 14:10:49 UTC 2025 x86_64 GNU/Linux
(current kernel in rawhide)

broken:
d1ddc6f1d9f0 ("fix IS_MNT_PROPAGATING uses")
Linux fedora 6.15.0-rc5+ #8 SMP PREEMPT_DYNAMIC Mon May 26 09:14:09
CEST 2025 x86_64 GNU/Linux
(parent commit of the fix)

working:
63e90fcc1807 ("Don't propagate mounts into detached trees")
Linux fedora 6.15.0-rc5+ #7 SMP PREEMPT_DYNAMIC Mon May 26 09:12:43
CEST 2025 x86_64 GNU/Linux


tl;dr: Seems that the fix works as expected.

Thanks!

lis


