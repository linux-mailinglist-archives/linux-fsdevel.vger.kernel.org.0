Return-Path: <linux-fsdevel+bounces-26823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BECE195BD51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 19:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78905287FB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CE21CE704;
	Thu, 22 Aug 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxDXsgLn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC4487AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347894; cv=none; b=tf48GJWw2yh/2+uziYM98Sr+vLf/TtJvLGeq2lrGagOBFW7xVDoiifhQQOLO/6bxWyXSVREtkslX7yOU7jyxqI8/birBZ2eZzdDYINZh/fQulGX0k5bcuNo2mZ4KaL6P9nldJLbTeGQJeZm/FZBIPqQRT9583ZbRsCD2ho8UXog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347894; c=relaxed/simple;
	bh=c0nr403uwtt3kH4Pmjf2ebxnxMXxZ4y5Ky93Fq/haso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXzCP1cWPdv+4YQ6xRxyOl5iolQ1SUgeQgtyRWQ/xllLI2x9Kl89WR7xGONYRZkJ+zDYeIUX9tBn4geD4Vu6pHiTfna1NdJbcCrL/nWWhTKci0hxP+XVzWTdGuE2hV1BjIZSBQ855dzHwFrSkcIy3l5rkMdgSLAVu9u0wXaOPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxDXsgLn; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44fe9aa3bfaso6627221cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724347890; x=1724952690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2P5YaZZxw/xfoYA/EvziF0lrs4pwX/YSmpkaiL/oe4=;
        b=cxDXsgLn8K2SRpt2Kit/3gmJcCIboyTrHoGBmHbooiRM1MWljQbr5XYV633Cb9VXRb
         qnjR2bE56qpx3gT9SRv+p9Fnk6RKZODIYJq5voVW1OObkU1PxGAbbttKT18oNj8FRsNZ
         Z/Xb1l5oFbcpqisNDGpHdDJWtEyPSZzsjvqC38Y4us2A8F+osoRTK/0pKcpqMVB1GMli
         Qb16fIRDcnxVLjoAElRUoLUuVkSdVNo4XzC+wtGVWeFdyKjqMQP/c1yakHaDAXNDxZtv
         cnXYr+QsNZPePFAlfXAZVup4xirmwnzohEb9xAorVIRGQ6skBynccnJyYRz+tYitpze4
         //vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347890; x=1724952690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2P5YaZZxw/xfoYA/EvziF0lrs4pwX/YSmpkaiL/oe4=;
        b=XXyoYlY3cRhAgx9t9ao8G4pRo5Bhq26hDgCBOU5vmgqQgLgJX9yDO1Ja7PxtpT6x7G
         RmusCnJQftPevbBmyQjipXhsJINU30PfrP5ysaPH0XDZehXsarp5M/VPtBQRYO+LIFx7
         gbExUn0UXTJq1AzMZN4+eaBDwijZDJaJW4MSLMy74Q+G2sVH3PP0Io25ujSv/fZibej8
         zissXFyFDrRTAuz+1Z3fUqubWgK+xvfp2xNWxikU9RmTJZnd7y4cfE0Nec7ZUVaMSLYB
         KsXvVioHkZndZphIficgsG4662vwEiaClOaR4kQR356P4ForgOVhCcnVVUluFAqztNWN
         mfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+HOwrrPAeCgCcVNltgDiPqkrIwytxQdLce5yCoKoXsSMB2oNFGPf7KOfTLQ1ZFM+VoCOi4CZhE5G3UWs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5nZ0PklHjRRmS8pYL0R/yxYIy1awympd1puQahJmVGeBi9OYC
	c3IcRwppzQJPdiUjG93T4rtQfVU7eOADh4VoNUQygWj8xpH8RMYqdGisyiFN8cBuExMc2zKqEmo
	e3PnpV2jj7vCVKQqjnObJgMncfac=
X-Google-Smtp-Source: AGHT+IHaoXlBI+s3y9C0JWaEqQ7SkrvkMxXxrlthKHubNrY3rAonTNXKKm1+n/9xnwBsHcr+BOSGLs663Ilf6Q7vnZ8=
X-Received: by 2002:a05:622a:5c09:b0:453:5797:3658 with SMTP id
 d75a77b69052e-454f22819b2mr80037961cf.46.1724347890015; Thu, 22 Aug 2024
 10:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <CAJfpegvPMEsHFUCzV6rZ9C3hE7zyhMmCnhO6bUZk7BtG8Jt70w@mail.gmail.com>
 <20240821181130.GG1998418@perftesting> <CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JACFdgJJ_b8FdHw@mail.gmail.com>
 <CAJnrk1b7DUTMqprx1GNtV59umQh2G5cY8Qv7ExEXRP5fCA41PQ@mail.gmail.com> <CAJfpegsPvb6KLcpp8wuP96gFhV3cH4a4DfRp1ZztpeGwugz=UQ@mail.gmail.com>
In-Reply-To: <CAJfpegsPvb6KLcpp8wuP96gFhV3cH4a4DfRp1ZztpeGwugz=UQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 22 Aug 2024 10:31:19 -0700
Message-ID: <CAJnrk1b5_7ZAN8wiA_H5YgBb0j=hN4Mdzjcc1_t0L_Pj9BYGGA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] fuse: add timeout option for requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 3:52=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 21 Aug 2024 at 23:22, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > Without a kernel enforced timeout, the only way out of this is to
> > abort the connection. A userspace timeout wouldn't help in this case
> > with getting the server unstuck. With the kernel timeout, this forces
> > the kernel handling of the write request to proceed, whihc will drop
> > the folio lock and resume the server back to a functioning state.
> >
> > I don't think situations like this are uncommon. For example, it's not
> > obvious or clear to developers that fuse_lowlevel_notify_inval_inode()
> > shouldn't be called inside of a write handler in their server code.
>
> Documentation is definitely lacking.  In fact a simple rule is: never
> call a notification function from within a request handling function.
> Notifications are async events that should happen independently of
> handling regular operations.  Anything else is an abuse of the
> interface.
>
> >
> > For your concern about potential unintended side effects of timed out
> > requests without the server's knowledge, could you elaborate more on
> > the VFS locking example? In my mind, a request that times out is the
> > same thing as a request that behaves normally and completes with an
> > error code, but perhaps not?
>
> - user calls mknod(2) on fuse directory
> - VFS takes inode lock on parent directory
> - calls into fuse to create the file
> - fuse sends request to server
> - file creation is slow and times out in the kernel
> - fuse returns -ETIMEDOUT
> - VFS releases inode lock
> - meanwhile the server is still working on creating the file and has
> no idea that something went wrong
> - user calls the same mknod(2) again
> - same things happen as last time
> - server starts to create the file *again* knowing that the VFS takes
> care of concurrency
> - server crashes due to corruption

Thanks for the details.

For cases like these though, isn't the server already responsible for
handling errors properly to avoid potential corruption if their reply
to the request fails? In your example above, it seems like the server
would already need to have the error handling in place to roll back
the file creation if their fuse_reply_create() call returned an error
(eg -EIO if copying out args in the kernel had an issue). If the
request timed out, then the server would get back -ENOENT to their
reply.


Thanks,
Joanne

>
>
> > I think also, having some way for system admins to enforce request
> > timeouts across the board might be useful as well - for example, if a
> > malignant fuse server doesn't reply to any requests, the requests hog
> > memory until the server is killed.
>
> As I said, I'm not against enforcing a response time for fuse servers,
> as long as a timeout results in a complete abort and not just an error
> on the timed out request.
>
> Thanks,
> Miklos

