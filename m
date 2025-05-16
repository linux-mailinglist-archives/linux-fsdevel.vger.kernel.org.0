Return-Path: <linux-fsdevel+bounces-49217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E50EAB9700
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 09:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C395012EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 07:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA0A21ADC6;
	Fri, 16 May 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jPj6Vsj5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65122A80E
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747382330; cv=none; b=Sh2h4D423giOX5MYhywxRYaxXpWFs/tPuxfh6TWTdnQHRhXqDDmDimN4lPqeUmceTZhabI18h9p4kjb8fx5M+1OSoergzgokJmTmcFMdH4jDpZ7kx39y5rTvvUirs88MPoOm/xkJIKRv6uog9suiUEk6NQyhX7tY/QiXaI5bgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747382330; c=relaxed/simple;
	bh=YmL2D7Er6F7l3Q5ukzLK6B5Pg9nF74OFkgOHhmlQ2Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQWsLKobybQE8kCWqC+2/fWHClJ3vXjB3I3UfoVU8Ckf7jS5jNs5kmZoH7Rn6lNDzbdagppvfRmuHrcpfvdSPjp5Q+Jnq8Bl1AAz+dpB6INSIqjYG9H5/OoV3PFj8Q9PmnKEG+MNEZd3lzZnehTyEHwEd7TmxSHvH1AOE+NnWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jPj6Vsj5; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so171746939f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 00:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747382327; x=1747987127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PFVgKp/dY3dqAEkCj0mC8AvL3gLOkml9a9KsWgEYU4M=;
        b=jPj6Vsj5yPhkU/FCs17rYu/65y9grkaiFt6XihazHkHzWRLoqjgIy5BujQ3ewLI9J1
         QVMHHo4FmjBcGbzRODEhkgSlvQAljslAdhEqY1fT8HuBimCvxB8sgy2bkirzTFIjQoPJ
         QPkVRNPiDvmLh6oc7ow2DpI9HobEwcVoxNxdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747382327; x=1747987127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFVgKp/dY3dqAEkCj0mC8AvL3gLOkml9a9KsWgEYU4M=;
        b=EF34h8wbwv1kSwLZs0A94TdAYFkmNWiOuck0epLwidOW8seT7ftdIk/B7daQWi+2oi
         U8PWjXjgVytW3WmL0N1qkCTL63cQaF1qElaLrDkLcaQrJtOgyK3r/yGCZ3Fm9wkXIqQB
         sXfc0UuMd3JV7KkMfdzLA2faMN8qXelagTGRlL69WCVMCi/z6pPxGRcFoTF7zunOeNM0
         KZVS8tYwtsQ/YJOeeDq7L2iIbXVnGgQUPIaOKFqkiYPpDlJFOqKNiqv6awh64A1pOk3i
         Kh2CuPTWVCORbIhvjA6Jgdjz03m0Qz/SE1o7lWvHFD+rh/tqJDJrFqdnUr80P2tFzX7t
         w14A==
X-Gm-Message-State: AOJu0YxxLKkbGDwD9FfoKWXRgsgzaPOJAHW5OETS0JDpiYBf385FjNwg
	FCA0b+UKg/u8DmuZRRB3KnyWR9T9g8ahXHR+KDJQMsib7OizgSo0tDDwuJ/c5kwan1xjAJX22nF
	vMy+aUhGQj+Vxv8WIeqECNQ9sqqVsBUvzxqxemUXlUVXpG6QZ5EqAqqU=
X-Gm-Gg: ASbGncvneQuCGm+QaYiv1wn/RUb/JOx5g74JhqOpgxHjebKvdpzkl6PXXn3fqZ1qDRn
	BLnxu76XdovnjVtYXcVHci793EvAKfbglJV19LmRnpLa/ddJYk3Lf/eFa1k3udeRFXgBwRChbKq
	wGBgICxtI0a7TpUJGujgxfuVlin+yA6hn/btlJmMgkQg==
X-Google-Smtp-Source: AGHT+IHYaMsPHgZcS2lfeLI0VKjgKHJ5XwjuFmQi2Cu4otbSVP2MF21iP69mMCCz+Ld5fFykaU3Uo87nHAp9lEa2nGk=
X-Received: by 2002:a05:622a:4c0a:b0:47b:4f3:b257 with SMTP id
 d75a77b69052e-494ae3a81d1mr44057981cf.31.1747382316518; Fri, 16 May 2025
 00:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422235607.3652064-1-joannelkoong@gmail.com>
 <CAJfpegsc8OHkv8wQrHSxXE-5Tq8DMhNnGWVpSnpu5+z5PBghFA@mail.gmail.com>
 <CAJnrk1ZXBOzMB69vyhzpqZWdSmpSxRcJuirVBVmPd6ynemt_SQ@mail.gmail.com>
 <CAJfpegsqCHX759fh1TPfrDE9fu-vj+XWVxRK6kXQz5__60aU=w@mail.gmail.com>
 <CAJnrk1Yz84j4Wq_HBhaCC8EkuFcJhYhLznwm1UQuiVWpQF8vMQ@mail.gmail.com>
 <CAJfpegv+Bu02Q1zNiXmnaPy0f2GK1J_nDCks62fq_9Dn-Wrq4w@mail.gmail.com>
 <CAJnrk1aX=GO07XP_ExNxPRj=G8kQPL5DZeg_SYWocK5w0MstMQ@mail.gmail.com>
 <CAJfpegvayjALR9F2mYxPiM2JKuJuvDdzS3gH4WvV12AdM0vU7w@mail.gmail.com> <CAJnrk1bibc9Zj-Khtb4si1-8v3-X-1nX1Jgxc_whLt_SOxuS0Q@mail.gmail.com>
In-Reply-To: <CAJnrk1bibc9Zj-Khtb4si1-8v3-X-1nX1Jgxc_whLt_SOxuS0Q@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 May 2025 09:58:25 +0200
X-Gm-Features: AX0GCFu2fOO9_kKT4DfQdUVMWPL4-utph466aa5QkYR4E2dvwsH0AF6Td3KqRBQ
Message-ID: <CAJfpegtFKC=SmYg7w3KDJgON5O3GFaLaUYuGu4VA2yv=aebeOg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use splice for reading user pages on servers
 that enable it
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	jlayton@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 21:16, Joanne Koong <joannelkoong@gmail.com> wrote:

> As I understand it, the zero copy uring api (I think the one you're
> talking about is the one discussed here [1]?) requires client-side
> changes in order to utilize it.
>
> [1] https://lore.kernel.org/linux-fsdevel/dc3a5c7d-b254-48ea-9749-2c464bfd3931@davidwei.uk/

No, that's not what I was thinking.  That sort of thing is out of
scope for fuse, I think.

Hmm, so you actually need "single copy" direct write.

 - there's the buffer that write(2) gets from application
 - it's copied into server's own buffer, at which point the write(2) can return
 - at some point this buffer is sent to the network and freed/reused

Currently this is not possible:

 - there's the buffer that write(2) gets from application
 - it's copied into libfuse's buffer, which is passed to the write callback
 - the server's write callback copies this to its own buffer, ...

What's preventing libfuse to allow the server to keep the buffer?  It
seems just a logistic problem, not some fundamental API issue.  Adding
a fuse_buf_clone() that just transfers ownership of the underlying
buffer is all that's needed on the API side.  As for the
implementation: libfuse would then need to handle the case of a buffer
that has been transferred.

Does this make sense?

Thanks,
Miklos

