Return-Path: <linux-fsdevel+bounces-52308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95AAE16DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 10:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4F13BC8AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035D627E04D;
	Fri, 20 Jun 2025 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VELAa85w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F06274660
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409935; cv=none; b=qtYFtj76LQH6onO7o/1dGq+NnYMgPmHZ7OFWIZOKzxlBw+czZ4VO+z3PTMhPbfHXPKvZBfQGIcPV0nDmPjxT6Za14QmpsOanYrBSgEWmd2PFs+p5gfbiw9Co/McUiOuPeKoIuTr7tKePYgPXnlptypLjw8m4Zpl+V2ceML2TMPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409935; c=relaxed/simple;
	bh=BpH0pHNPZm6LbbjEwIAiuSzrXdKhyBa5zujoGxkRqWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giBwaH27W/Y2AaSCRzKcXmUdKaXoEgr4iCiSm+V/zZ4Dft9JiD/ZDFdjVpJ9CnhW6Fxrl5NGfR5C8Ooh4ou3IsI2FStQxMrHXlzABpRc+H5xhE3Fpb3Jpad11ZzOSrz2Mu/TAgu3dJ7SfOWV+YyLZ4RncThd1K/YKD+jE/AhPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VELAa85w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750409932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QR8mG4qewbyLkZRi9qQoKnNeSih+x7nXiPiiahvnnPU=;
	b=VELAa85wPMTJ/HLyXk7FAHDK0I8iZ3RDtS7i0XP2D9E9Ocz2UPgoqhefhOZWzyfs8b9ssK
	s30O2MXPieRfegzuqUXf3kIijSEPtzBO6eI+dcdTXb1nKW0RPY9LPahRcllZhG0czBiHb0
	97xieqMrMMmSD4jfpuSvQ9Eo0NaIUYs=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-ik2B7ZuBM1e1uIN8kQtx2A-1; Fri, 20 Jun 2025 04:58:50 -0400
X-MC-Unique: ik2B7ZuBM1e1uIN8kQtx2A-1
X-Mimecast-MFC-AGG-ID: ik2B7ZuBM1e1uIN8kQtx2A_1750409930
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-60d60b8ef64so715996eaf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 01:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750409930; x=1751014730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QR8mG4qewbyLkZRi9qQoKnNeSih+x7nXiPiiahvnnPU=;
        b=daAhg9fl5wQR6sIiih5OvFihEU3KbdCLkgZtByh017MkpLIRxV2B8qY+NqaZELE65e
         haz3Ju01jKyEuG0HvFMxTxB1SmxitGgxGYZaL8b3+cp+8kIjJG3RUce7UYhXAWg0JqZ4
         TbG84L/MSRI+iIR1sibW/7AnyZZBykqSMZqzyLqleYJxCvtK32VdNnFo7qfsvDkkX6x8
         O8aQbntJ7bRwDNVvggzuGirK1YUBssMKIxu3G6UCEnPnb+YTkvQZ5/XSLMntCmPqM2LY
         cP4vr1vcn60LtNSIWml8vJBurELdvojdtiZtytpcn52J+JCZA4ZjDX8zecb7AgBjehYf
         dK5w==
X-Forwarded-Encrypted: i=1; AJvYcCVhSTP0+dPk8iAEVKcupQNFvAU3oUs7e36HMkhk03gq+7neGJ4HKE5OVS2RxwK8O0ENvm9vTBTehrNpFiaz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz++7BYhrvJGWMhBzcyOMXflxTsQTl2y9IGPghESbP6icT8lCjr
	YM9U05myrOBJTi7/AlHlV/Bft9OfKcYIS14bT+LhYwBU2WB4/Y2qoEkGYq3I1QGrLodmcoEXKnv
	+U5dpq8P4Jik5OQ05cjL+0ZUYV/kF9FH/XVG8E7jR41UlecIzGUIAf25McbHohGCTNhdE3kDEW3
	412c0TvMDZvOQD3gDMIlos5f/rh6qEkdfq2bJCucOivQ==
X-Gm-Gg: ASbGncu/w4fUw1vuD3qL/X9ST5iXgYIaDLmIhhzfVzkE+hQSb6YfGed8s7Nmsvfyty5
	8/5PX4GKlSAmsRYbH9GTR3MD45P+kvNN1lbhP9kpuEYEVOOOO280G9h1J50A0OivBvWI6lWInJR
	yAcL8uAVwiJCnlbrqkbYJiJ42BTMoq4nkwcA==
X-Received: by 2002:a4a:ee06:0:b0:611:2c55:3b39 with SMTP id 006d021491bc7-6115b9ba12amr1442283eaf.3.1750409930066;
        Fri, 20 Jun 2025 01:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYB/C7y/mW7YGXkvLHZEzdWmX38VA5n5djcLK7T96pX0N2F2a4uL6sDg7dqqL+loHHQ+T7nIi2xdcPKAFDbCQ=
X-Received: by 2002:a4a:ee06:0:b0:611:2c55:3b39 with SMTP id
 006d021491bc7-6115b9ba12amr1442272eaf.3.1750409929749; Fri, 20 Jun 2025
 01:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521235837.GB9688@frogsfrogsfrogs> <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs> <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
 <20250609223159.GB6138@frogsfrogsfrogs> <CAOQ4uxgUVOLs070MyBpfodt12E0zjUn_SvyaCSJcm_M3SW36Ug@mail.gmail.com>
 <20250610190026.GA6134@frogsfrogsfrogs> <20250611115629.GL784455@mit.edu>
In-Reply-To: <20250611115629.GL784455@mit.edu>
From: Allison Karlitskaya <lis@redhat.com>
Date: Fri, 20 Jun 2025 10:58:38 +0200
X-Gm-Features: Ac12FXzaDyHQsHgJ6iv0tV4BMxjkmezK6KxBuWvqs_fjsJwR-0Nnv7GswYhoT4g
Message-ID: <CAOYeF9W8OpAjSS9r_MO5set0ZoUCAnTmG2iB7NXvOiewtnrqLg@mail.gmail.com>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, bernd@bsbernd.com, 
	miklos@szeredi.hu, joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

hi Ted,

Sorry I didn't see this earlier.  I've been travelling.

On Wed, 11 Jun 2025 at 21:25, Theodore Ts'o <tytso@mit.edu> wrote:
> This may break the github actions for composefs-rs[1], but I'm going
> to assume that they can figure out a way to transition to Fuse3
> (hopefully by just using a newer version of Ubuntu, but I suppose it's
> possible that Rust bindings only exist for Fuse2, and not Fuse3).  But
> in any case, I don't think it makes sense to hold back fuse2fs
> development just for the sake of Ubuntu Focal (LTS 20.04).  And if
> necessary, composefs-rs can just stay back on e2fsprogs 1.47.N until
> they can get off of Fuse2 and/or Ubuntu 20.04.  Allison, does that
> sound fair to you?

To be honest, with a composefs-rs hat on, I don't care at all about
fuse support for ext2/3/4 (although I think it's cool that it exists).
We also use fuse in composefs-rs for unrelated reasons, but even there
we use the fuser rust crate which has a "pure rust" direct syscall
layer that no longer depends on libfuse.  Our use of e2fsprogs is
strictly related to building testing images in CI, and for that we
only use mkfs.ext4.  There's also no specific reason that we're using
old Ubuntu.  I probably just copy-pasted it from another project
without paying too much attention.

Thanks for asking, though!

lis


