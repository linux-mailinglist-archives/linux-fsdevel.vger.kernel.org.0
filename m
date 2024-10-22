Return-Path: <linux-fsdevel+bounces-32588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3607F9AB19A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 17:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB67E28395F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCAC1A2C0E;
	Tue, 22 Oct 2024 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qwleVX3b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5341A262D
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609435; cv=none; b=sVIPBrWq88aRoj9ZSCHj5ENhElkNFNJrjUNv6j3COJemIpwNVbdKmsxWzZEFugUbhbqyn5eJT3OjXOEub4Ghu8Jw/uTy2qNIZD4NmDwziGhPwJ5EHznoUBKqXdFLRet6uas1VTMHAQF5NNUzHvlk9hMSf0obuncTSGqoO1JmZGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609435; c=relaxed/simple;
	bh=6Az0llcXji2XYryfjGep3NF3TX8+ihnC6GfdlHBR/Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G54H1NEk9fz/fQYBYImAS7TdGGcOYhElAlb3DFoerwi1xtg4F74PQd9dpW29sB/GnfzODxjSee4zX0vJpsjvn/JV8Ok78x4QVh2seDGeKWI556A/NFYTm1moJi0yKfzKePynWzhGzzIHmVbhpu7Ap+E9Vo3iv375/nEr1yBJ+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qwleVX3b; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460b04e4b1cso31562071cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729609432; x=1730214232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MDj8TRUfcYbvYwEX9Zu3aIkjezyldztneIFRm/JjlG4=;
        b=qwleVX3bQ2OkfE7C7jeNHQ5mslP3wtfXg6rlbEqvROdmr5Ciw5B65RToDooh0qd0B2
         ZvTygla+ObeStzB/omvChuclX1x2olZnUceF+ZHsuU542yGijKEq/sGQNg5iXcjqd1t6
         nwb3/PQjcYb8OdrU0OzmzSpASgP4P/GDEpCeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729609432; x=1730214232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDj8TRUfcYbvYwEX9Zu3aIkjezyldztneIFRm/JjlG4=;
        b=RfmzqyfptlAQz9UzPsLvqg7c0htfXfXo5E+NSZJUdWQu+18cUs7BL1xQcYAgxJ6pbs
         uXLIDxnrg9FPZDNfY6013BLimHH+PKCIFCKM2Va9s4O2DuXs3KYcbSX3wx/EMucE3vRO
         EW/xUJ7U8GaJT8QPCsMTYRUgwoMKMUU6BklWHg/+id8/Dr0U7PXQlpRXqtfaazIryIBR
         DOP/o+2f2isupF+6PBMJT7ASnihyGsefKQOcMopO7oD9GOZipSQ7bZfZC8oX/7MK+rLF
         tbslEVlyQlVfzDY/N0NBx1/Ev/bjC0ghSU76Ii99maOoAJUQz/3WDmT9nlBj+m2WS6ST
         O24Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHx0IbmqLZxM66Hggr4EOuVueRVhS68DbbxCq3j85WDQiAuAHUWV1txPVuRjS0Y3Kos1bYRra0OxzLr1wb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8wP0YBDDVDHrtNJzbtFYuE1fIKBA3+AO44/VFgGjoyfEbIFEk
	av/ovTcVcvRQUCXT/m8JwRFLNG9xxbFjjqI+07q3nbEK2pIaHppUpopbKCQ8Iuxn8V+PDIoGLvs
	k4RGOPqyG7yjxvkabRpMGEjWU7KlAYf4mHCKuPQ==
X-Google-Smtp-Source: AGHT+IFPR0yEyV5DhrBV6Isorq9THKS+ClYIDOL7reOhKaJuShFmZ5cUVdlET0d6jWN+Wa5nLKikkHx/fOWHgQXKX0I=
X-Received: by 2002:a05:622a:152:b0:460:8faf:c3a1 with SMTP id
 d75a77b69052e-460aee2bd21mr193873251cf.37.1729609431635; Tue, 22 Oct 2024
 08:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
 <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
 <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com> <egn6ds56teqq6i2dgn37oa6rmy7u5xtvvv3y277ul6ldhgdnsl@fdhkkxvznwkb>
In-Reply-To: <egn6ds56teqq6i2dgn37oa6rmy7u5xtvvv3y277ul6ldhgdnsl@fdhkkxvznwkb>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 22 Oct 2024 17:03:40 +0200
Message-ID: <CAJfpegsXbxsg-5rdSQXec__dvO8dOcbnZVoBsmZK_-Dwbzz0Zg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 19:01, Shakeel Butt <shakeel.butt@linux.dev> wrote:

> Thanks Miklos for the response. Just to be clear on where we disagree, let
> me point out what I think is right and please tell me where you
> disagree:
>
> 1. Fuse server should never access fuse folios (and files, directories,
>    mounts, etc) directly it is providing.

Correct.

> 2. Fuse server should not get blocked indirectly on the fuse folios (and
>    related objects). This series is removing one such scenario caused
>    due to reclaim.

Correct.

>
> 3. Non fuse server processes can be blocked on fuse folios (and related
>    objects) directly and indirectly.

Agree on the direct access part, but disagree about allowing to block
unrelated tasks.

Accessing a fuse backed object is basically agreeing to give the fuse
server extra privileges.  Documentation/filesystems/fuse.rst explains
this below "How do non-privileged mounts work?".

Thanks,
Miklos

