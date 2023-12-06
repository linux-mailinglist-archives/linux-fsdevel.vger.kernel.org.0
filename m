Return-Path: <linux-fsdevel+bounces-5035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0428C8077CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 19:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1D61F202CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95E3FE3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5o5AKQv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B1B2;
	Wed,  6 Dec 2023 08:53:29 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db632fef2dcso5351019276.1;
        Wed, 06 Dec 2023 08:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701881609; x=1702486409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIbDoWDGZzPGryjjQbO4uNmk+Z9wCOK+KNEROFMvLaQ=;
        b=k5o5AKQvuFgLpmD58q0yrITbCvHIuj8DFoZ2nsvgi05kC/4hiKWBQGrCS9356zGmxo
         f0+rvpjNsLNBE6wG+qS+NM/pm0Gx18UqVH9tn9acyKPwWb4da1U5Ixqp2aYyHP6KpcEF
         2d1w+aW5g9Xf2pT8iWSa42SczQMfrindrpODAY6hL46Gye00zQJ6ND4fpWx/B8DTzYOn
         8hdAQap/h6mcFTCcqQCEv1fhFHz5HfaKXQQMxrCduRNtUU2J0jmiRzQ2Yf22l36Z9T56
         6oZe3SoWUKBw/5lUdfh5hRV6Ze7/0ACsIgMh0KqdINXyHA9qAN8vi7iPZeeKHUmWcs+R
         6cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881609; x=1702486409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIbDoWDGZzPGryjjQbO4uNmk+Z9wCOK+KNEROFMvLaQ=;
        b=jh963ONmvNgAU30PUjyxVfvONV9mrCxkEpTNzAwdErglh/mRg5F1AOBAfWdwOJehSu
         AnV/utpkngO0j/Vhp+xijFp4UZ2+ribTRXV5E4giEM9knjQdVrqhvCEKv3KC2+cZ3J1e
         QubYFRn18WF+ql9B2UUC+VHjtIH0Ri6MiLGmNdSstPvAk7tEM125P6jFE6d9QWDrV2Ig
         95oMhtBPyQ4b7HzYdROnUwnBCpbrfh/ul82GYOVGxHyzSbaDyZWQOQvd0LBndpn4GF3V
         2+fTlAEMOncOiFGl4NTt/3o7o43JPUvrseY8iXx/UDPT084/WQDwYODyBKNbI5Itwi0W
         XjkA==
X-Gm-Message-State: AOJu0YwdhJj1cODfa7Be8fmVOYsNo0yN9PX63Rg2izu7s/1vrs76q/x/
	BaGLF4E4S7lSNH4q1AURxQU=
X-Google-Smtp-Source: AGHT+IHVHPSD+r3xJXIqpcARoAiwf4jvi2eJ/slaF1zVRei8FMbIBeOClVa5Rx6hCg4mEYcj/vkPwg==
X-Received: by 2002:a25:f402:0:b0:da0:cea9:2b3b with SMTP id q2-20020a25f402000000b00da0cea92b3bmr928071ybd.62.1701881608809;
        Wed, 06 Dec 2023 08:53:28 -0800 (PST)
Received: from firmament.. (h198-137-20-4.xnet.uga.edu. [198.137.20.4])
        by smtp.gmail.com with ESMTPSA id k18-20020a258c12000000b00d9a4aad7f40sm3859181ybl.24.2023.12.06.08.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:53:28 -0800 (PST)
From: Matthew House <mattlloydhouse@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: libc-alpha@sourceware.org,
	linux-man <linux-man@vger.kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	Florian Weimer <fweimer@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] proposed libc interface and man page for listmount
Date: Wed,  6 Dec 2023 11:53:14 -0500
Message-ID: <20231206165316.744646-1-mattlloydhouse@gmail.com>
In-Reply-To: <CAJfpegvUWH9uncnxWj50o7p9WGWgV3BL2=EnqKY28S=4J4ywHw@mail.gmail.com>
References: <CAJfpeguMViqawKfJtM7_M9=m+6WsTcPfa_18t_rM9iuMG096RA@mail.gmail.com> <20231205175117.686780-1-mattlloydhouse@gmail.com> <CAJfpegvUWH9uncnxWj50o7p9WGWgV3BL2=EnqKY28S=4J4ywHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 4:38 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Tue, 5 Dec 2023 at 18:51, Matthew House <mattlloydhouse@gmail.com> wro=
te:
> > One use case I've been thinking of involves inspecting the mount list
> > between syscall(__NR_clone3) and _exit(), so it has to be async-signal-
> > safe. It would be nice if there were a libc wrapper that accepted a use=
r-
> > provided buffer and was async-signal-safe, so that I wouldn't have to a=
dd
> > yet another syscall wrapper and redefine the kernel types just for this
> > use case. (I can't trust the libc not to make its own funny versions of=
 the
> > types' layouts for its own ends.)
>
> You can just #include <linux/mount.h> directly.

The problem with including the <linux/*> headers is that they conflict with
the regular libc headers. So for instance, if I try to include both
<linux/mount.h> (for the listmount(2) kernel types) and <sys/mount.h> (for
the mount(2) and umount2(2) wrappers) on glibc, then I'll get a conflicting
definition for every single MS_* macro.

I suppose I could try to put all the listmount(2) stuff in a separate file,
but that would still require manual redefinitions of the listmount(2)
flags, unless I trusted libc to have its own identical redefinitions in
<sys/mount.h> or whatever header the wrapper would end up in, instead of
shuffling stuff around and translating it. Also, my current style in C is
to put all related code into a single file as possible, which this would
interfere with. At that point, I might as well redefine the whole thing.

Thank you,
Matthew House

