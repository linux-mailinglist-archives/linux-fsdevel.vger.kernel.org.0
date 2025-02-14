Return-Path: <linux-fsdevel+bounces-41750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFA8A366A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 21:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7CD16F037
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 20:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7CE192D6B;
	Fri, 14 Feb 2025 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfCBvvH2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765315573F
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739563275; cv=none; b=txRfmF+X2+Cdt+s8hOypNGO2SK7EouekYXpMR+UKPqUTVmz0WXdn3crKWlVQ/GJTocMNn1Ce4mczBg+M1XFXrwOp0GxK2BdbTg4mgiz1pQaKt0TQCKG4/abDg36nQH2VwEOpUVukOOv0YAeQvnv0x5ynHhD4GE37E5YtxaL52fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739563275; c=relaxed/simple;
	bh=FieRenqOt4W4yLmCB98T5WhuZ9FRXLi8IOpssVyWOOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDThW+wg6AOIsgZYa5vNVqBP1Qb91y7vflJRRKXYuel+/yq3LXdImstdSiv+NX/spOD7VWK0RnZLCWTvzlo6dWpRGs2H8dX8vA3ZditiPBdOPtqdBCPbqwHf2+I3q+aCv3MOIU2VRBq07qChGT5KGxiiaNhnQ3LYWXmrT6/We0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfCBvvH2; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c068097157so328870285a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 12:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739563273; x=1740168073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35zuCQfFsNsezlvSupRdRHqL/3mJUTF2ZFVuYDMGtpQ=;
        b=DfCBvvH2rr8m8qzr8VViJ0rGzxJEDjYAkHMLxcinkR265NFrvrn8k8adfcGsQnIqBm
         +pm+5hrNOAzCinuGO9un2/URA2KkfGxJ8FMIga8zfAPgoD98z3X7PqRICIdYJ0xqx4st
         C3Nf5KQzcMOJ3nlcUPSfbcxtraPpq2ReRwyF4hBt3284H6F7Ed/LDs8fEA8GhPRWpOrs
         xnTQI00633j+NO8ss+CL+7kMNWOiSNvPso6Om4juOBHDGS/JihFnd5B6GqUYpi5RawED
         w02Z83SHX00G1vRpmodiBbyIS/rOEfMvk71g+PEpa8dxK5ZOcJ1FoW85dhSJU6Qo4rw5
         wAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739563273; x=1740168073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35zuCQfFsNsezlvSupRdRHqL/3mJUTF2ZFVuYDMGtpQ=;
        b=tcdR0cK9xXhqVZuXZfqdcJ4P4shtwjMhcJ8sBIIgofyvB1mmqU1gnBM72MTVQGRs77
         eHSwu6aT2M8rSi9vpUMeCqwgmigCfj6OBi5BA3GXBkC3/NwW4ObOm3Z/nok0ccPXtn6j
         HmkyPR6eotzvfymmU6XZAJTZKGz4Qmn3HjmwGW5qS1gUqfq5ddmzQHSen8YBWQEGbDZV
         mB1nGZTGxdCuN8t5+aCH1by6gQLRIjZPJcRG36BxqA58/apgtrkp/SiFqgTOkUFi21u9
         cHWrENXR4znDtiURygnKqDm9qHDPYiOR2gvllOruoaqGy0Lrgw3QyiiuFiZMq/gZsJcR
         +VRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFR3yA0kr6ulwWfHe7iRv2dPjuC29KjO6gvKG3aoyHAVYA+iRfRaLlI5eyyiBFo8D6gQFVfHACn1/NkpSG@vger.kernel.org
X-Gm-Message-State: AOJu0YwIMxYAAjEMu60cJAFHMpOw3Ou/Yn5U+F4ymhk+5u2XzRLcah9G
	lw9xnqJOxP3mr/iiH8OI0mROQh8CGVnJmJClNugWE4sz8XxhcAbgh7sCvN3TcoYdsPWPEdDZnId
	wVUPBQxayyzjloZJPeDieq6CtYC/SwlVi7/4=
X-Gm-Gg: ASbGncsEIjuOAP2UXEHv6FelXozsC3zwHaZBRpbQbFm8esujKFYvlmCOeoJMXT0rrdM
	YRdV3d9VBxEVolmm0TJ6+wFST3r+3tzpEUNcHbqmk5e0I+wzMaaPSaKp/klC48djSDOTdGtxaNQ
	==
X-Google-Smtp-Source: AGHT+IGD2oISe0DqW0aNnLrDaoUU4CH5awU/wfLOLolXyrNUyvCIOf97mWZaXiTSsIZM8X99He2hbBlAosgaZk9HX8Y=
X-Received: by 2002:ac8:7d41:0:b0:471:9541:413a with SMTP id
 d75a77b69052e-471c01db7cfmr131065651cf.18.1739563272749; Fri, 14 Feb 2025
 12:01:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820211735.2098951-1-bschubert@ddn.com> <CAJfpegvdXpkaxL9sdDCE=MePdDDoLVGfLsJrTafk=9L1iSQ0vg@mail.gmail.com>
 <38c1583f-aa19-4c8a-afb7-a0528d1035b0@fastmail.fm> <CAJfpegsFdWun1xZ-uHXnWBeRz3Bmyf0FSYWiX1pGYU8LEz12WA@mail.gmail.com>
In-Reply-To: <CAJfpegsFdWun1xZ-uHXnWBeRz3Bmyf0FSYWiX1pGYU8LEz12WA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 14 Feb 2025 12:01:01 -0800
X-Gm-Features: AWEUYZmQYmKpNyUnzfBYryp2XP-xiNeAZgchONlOy3uDX9ivw-6fq_-rrozIA18
Message-ID: <CAJnrk1YaE3O91hTjicR6UMcLYiXHSntyqMkRWngxWW58Uu0-4g@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add open-gettr for fuse-file-open
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Bernd Schubert <bschubert@ddn.com>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 8:04=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 21 Aug 2024 at 16:44, Bernd Schubert <bernd.schubert@fastmail.fm>=
 wrote:
>
> > struct atomic_open
> > {
> >         uint64_t atomic_open_flags;
> >         struct fuse_open_out open_out;
> >         uint8_t future_padding1[16];
> >         struct fuse_entry_out entry_out;
> >         uint8_t future_padding2[16];
> > }
> >
> >
> > What do you think?
>
> I'm wondering if something like the "compound procedure" in NFSv4
> would work for fuse as well?

Are compound requests still something that's planned to be added to
fuse given that fuse now has support for sending requests over uring,
which diminishes the overhead of kernel/userspace context switches for
sending multiple requests vs 1 big compound request?

The reason I ask is because the mitigation for the stale attributes
data corruption for servers backed by network filesystems we saw in
[1]  is dependent on this patch / compound requests. If compound
requests are no longer useful / planned, then what are your thoughts
on [1] as an acceptable solution?


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20240813212149.1909627-1-joannelk=
oong@gmail.com/

>
> Thanks,
> Miklos

