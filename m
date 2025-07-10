Return-Path: <linux-fsdevel+bounces-54550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952F7B00DFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA88647B6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 21:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4A7291142;
	Thu, 10 Jul 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VSUdY6rQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4128D83B
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183635; cv=none; b=U3deV+EruGgw9Yp+qt79JXbVFMfywAe/BG5H/5Kqt3WNbKfKmyoRQWPtnpCWHe5mVLqZ5R6YbRvCQ5uRiNeeiuD+rfR/w98OE0NWaW+c65Nrqzf9TKQugr3k3Zm0xH8FsJNn9HWz0/94hsJ64NZl/l1PHleUQfaJHQN1/cvcOdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183635; c=relaxed/simple;
	bh=6wG3MiVJh0RcPO7dGyjbbquYVHNZCnHmFZCdF5hrjIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8FrAOJLB0RN27V42Ip2JdU9MC7ip8FYtJDToZuics/XRkupIqeL6bizSQScXwSFFbPdFKN2ExLYp2f7rzeCZd2FPEF9KGi7FIR5XofxdIMN4AOENegOEAlOJw2dSgqj62PwXdnp8/OcTAqJi1cMWbJ/WbPDCCD2zvAT58lansQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VSUdY6rQ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70a57a8ffc3so15735717b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752183633; x=1752788433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wG3MiVJh0RcPO7dGyjbbquYVHNZCnHmFZCdF5hrjIg=;
        b=VSUdY6rQrvB5SnmTJeTDDxuv1MqFK95JFGnvSKjfpNAQrAu9SV3ve1+dbTaNn2+/Im
         xMDQugq4NaD2p1uRKuYNYDjEGj4Sp/Sk3PAujTvvQv8dNjst/5BjrocZMQ0rf7/cXW2P
         P9yGYdNlEI7jv9027boah+y0CwtsmSnn5Be7mEPTA583IY2VCTnsjehv4VruZOMD56i6
         FK5vj/ehnLxd+aSfsPsLdC01WNHW2UVwUhXX74t8EdMug+Y8pN6c/mRgXo1X0z8BcpU9
         OTwuqBYZ32Sm9xwD8LXghM1RbJ3Yvq3Iqt3lQvV4tr8KjCK3tDB3M6Oy/tD68YZp/ikX
         +s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183633; x=1752788433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wG3MiVJh0RcPO7dGyjbbquYVHNZCnHmFZCdF5hrjIg=;
        b=KjjPnueZyAX6JHQDTn620FcLsFPolXZIK9LuxBx7LCNoSW9P9gDEah29iedJlH1Z5q
         fLSA+NlDd6EMVO01zqeFSqVFNwCW/6xPB4ffag0obj/2Wy2lbCL7MmtIZaK+aEZaK8g3
         oMirizt2QUb2cP4Wdhk5aVArOOni4hp3tQyMuC7XkEM3h7jk0D0AvKVn/FlFMEG0/Mmz
         BZ6Q96ZxiMBapIc0m1iUaVcENS+PzJVQMsnPW29fVPJYdk7wd/TGYJu69KdSibWyXjnH
         WowI/X52ZRLbvaju7wAVfWpzb7yE1XhEA/ymnH9cJYmICegIErWXP5N3+ifD0q+rjsdV
         qU1g==
X-Forwarded-Encrypted: i=1; AJvYcCVbvV0lzMVtA8oCoOD1eqZAb7LIGEB3lumo9T5uozGuO3s5WkWOAM8pJBNKnI9bwYLywpKT3BhpHooBh8Q2@vger.kernel.org
X-Gm-Message-State: AOJu0YwzZxtQgPMovuwi3hv89im9LswOR9K9QY4DSOU5vM2dqSAiwt9i
	Hd5derkgtXxos6QGgx/yWEUgvpzWTTZfWogu+O1U0OWE+UMQ4axVvfOr2EVw9LmSjOxWmGf8QnB
	r4w/KFrhRHG1E9C+A4JPPvr1nfmSbODi0L2VKKMLV
X-Gm-Gg: ASbGnctHQmYgZZK1B33QxAK2A2hMHXI4Y6MIr+qmzuG3JLT1z4yhyU45N7FFXkAR8SJ
	xoa/Lwr/EyTASrHcJGX8QDxgxq42JFC7Q4y4MHcPnSHNSpP/VTKB+fLmIyDqvTLnjWDBQoThelp
	/SsbPEpbeSKi5+gVCegnIl8wGAepeiznH2cdaiow4ts0rd2fWMBsJyl5IcibN1PDCgEssMYbPfJ
	rHi/VoHVc3vz+zPtw==
X-Google-Smtp-Source: AGHT+IEUNp7yAcXsQe/JR+irOSVx8v6wD/QnrcWD8zPh1FLoq9LoOpgHSEVTC/K3sabkCRfbQXhsH559rzftY5+dmIM=
X-Received: by 2002:a05:690c:63c6:b0:712:e516:2a30 with SMTP id
 00721157ae682-717d5e134b4mr20477787b3.28.1752183632871; Thu, 10 Jul 2025
 14:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708230504.3994335-1-song@kernel.org> <20250709102410.GU1880847@ZenIV>
 <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
 <1959367A-15AB-4332-B1BC-7BBCCA646636@meta.com> <20250710-roden-hosen-ba7f215706bb@brauner>
In-Reply-To: <20250710-roden-hosen-ba7f215706bb@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Jul 2025 17:40:19 -0400
X-Gm-Features: Ac12FXygeQp3no1_lmAy5tCkImjlkaS0qLNeFNCTV52hKWMKCGltsNt3Gzdmr0Q
Message-ID: <CAHC9VhTinnzXSw1757_yeFdyayXkpTr6jQk8kzETtB5r=WNaxw@mail.gmail.com>
Subject: Re: [RFC] vfs: security: Parse dev_name before calling security_sb_mount
To: Song Liu <songliubraving@meta.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>, 
	"selinux@vger.kernel.org" <selinux@vger.kernel.org>, 
	"tomoyo-users_en@lists.sourceforge.net" <tomoyo-users_en@lists.sourceforge.net>, 
	"tomoyo-users_ja@lists.sourceforge.net" <tomoyo-users_ja@lists.sourceforge.net>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "amir73il@gmail.com" <amir73il@gmail.com>, 
	"repnop@google.com" <repnop@google.com>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>, "m@maowtm.org" <m@maowtm.org>, 
	"john.johansen@canonical.com" <john.johansen@canonical.com>, "john@apparmor.net" <john@apparmor.net>, 
	"stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>, 
	"omosnace@redhat.com" <omosnace@redhat.com>, "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>, 
	"penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>, 
	"enlightened@chromium.org" <enlightened@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 7:46=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Wed, Jul 09, 2025 at 05:06:36PM +0000, Song Liu wrote:

...

> I'll happily review proposals. Fwiw, I'm pretty sure that this is
> something that Mickael is interested in as well.

As a gentle reminder, please be sure to include the LSM list on these
efforts, at the absolute least I want to review the patches, and I'm
sure the other individual LSM subsystem maintainers will surely want
to take a look too.

--=20
paul-moore.com

