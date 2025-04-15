Return-Path: <linux-fsdevel+bounces-46456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E5A89A81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344B11890DED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C2428B4E3;
	Tue, 15 Apr 2025 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MP26a7eG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEADE28A1CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713714; cv=none; b=sKgc7ellCHw64I/E2DASFjkNO7TlFNfd3SDcdPm0qnFxerDi8bNkjaLC/0NETQNYmXsl1OcXEdINeFZjRVYOfxAtMdBTfjdyZwlDQO+K8ItTw4mBfwPlfv1eovs4S7aX0lTZjCMs51fGfX9eKOu6TrOxIYWW32+eYf6KFG/2Z2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713714; c=relaxed/simple;
	bh=slg7c+OwYEPiVTqYZh9JE5dbAOFa3MV3zpSJsTIDzhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxfFGdtccLB2BHxjUAFuCQhMDjq4yb2/nAhYSFt4cviyqIUqH+q03p68ZUkJvTM0/8/hTpvEkEZ7MkdxI5VPLXpHnBAjmn+uHlBeWUtnGBslM2UD+1E5ZKfqMt056i20A5ujXrgxHMqJgTW1LykPa7iZoK6MmBtuwIh9KsMYb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MP26a7eG; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476805acddaso49805731cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744713712; x=1745318512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tlNdaGqrZvHHyFNoPaHaidkue74jgXWiZBGhEUlePLE=;
        b=MP26a7eGMXMOb4MDGv0CYO/RXHbilIsiJbuPwxuFkzHA8dinGOwa2emkUbYEk4pXyF
         8X/99zaq/1/zzsc9201rrGpLmfJWuAXqwsHUJ8cWPEuZoChnW5GQz99PjEl+gV/b3nZK
         8a2Kh96j8Y8KX1Bs1TVAn6El80sy1CCM70FEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744713712; x=1745318512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlNdaGqrZvHHyFNoPaHaidkue74jgXWiZBGhEUlePLE=;
        b=AFHNcEPas2gFmOMDGZLkhBPG8CUlMJQECaU2bdkaQHNklwMq3axpebAEcpEA0n+EIY
         Ttd6UL7beatU7AizX23Tivve0GhXhhcsXRQQ/OCv5JuRH4+Tx+24hDikAjk7mQqNQqXz
         m4RtIWlOeh5a90Vq+v3LEiokxaSUlKBdJNf3OV17bpO0qKU9BSRZ0UZzw1nN3MHbPgEq
         OSAJ91XNbD9PCll/vAMO/cXwoCa1Mt+YSxLZYyQLnyko2vPrREnIAugAAvgtOj++n9gV
         ExD7DUTjtkEjSx8b8ISOCPlEVH73G4D2kk9hNWOKhXW91oCEpbYaPgZ5tc2VjMa0HTnV
         bVVA==
X-Forwarded-Encrypted: i=1; AJvYcCXWVPjgld1PbkZXW6Md2ncfhtBt5HXN9z/UjXQPMCYehbcQSS/N9u5VJwj5XsofUzDw1zlKmKeFsJF/qbYT@vger.kernel.org
X-Gm-Message-State: AOJu0YxBIPD7pVqxbFt3RjJSUOq+oaw8+ntF65Ey3V/j4Sw/GcPymlub
	94J5E8rlUQPwpFktSpDamWEPV6D7NO9Lw3cs7TL5f4rWMOZOf6I8+PdVQtMCv/G+QH0GdxDSBeI
	JJJSoJvBJ/OV+1tUfm9NIvn5DcVXPUWet5UExUx6tSF3AsDla
X-Gm-Gg: ASbGnctfVnYUkGRHGYuX2mYz9bphY34z1Zlzv3EB9KqtL12Sw5g9criwKVKcUAVqf1N
	bZhgoxGDRHV+H+EqAVfPKx2Db4Fxp4cz4rofYxE9m7BkGn60+poLx+XbGfUTk4PbPbXIhk4SJ/5
	ZZ+1uphrDHYwEkfTWEWg5G
X-Google-Smtp-Source: AGHT+IH9UI/UhPy54GeNvnTe9atyu1HNtj14wjE2Bm1Mwbi9lUJkD7h9pfk/VJxl/1e3iysNlBwz8zoXaiI3WOGJy38=
X-Received: by 2002:ac8:5815:0:b0:476:8412:9275 with SMTP id
 d75a77b69052e-479775cccb9mr237595451cf.35.1744713711656; Tue, 15 Apr 2025
 03:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226091451.11899-1-luis@igalia.com> <87msdwrh72.fsf@igalia.com>
 <CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
 <875xk7zyjm.fsf@igalia.com> <GV0P278MB07182F4A1BDFD2506E2F58AC85B62@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
 <87r01tn269.fsf@igalia.com>
In-Reply-To: <87r01tn269.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 15 Apr 2025 12:41:40 +0200
X-Gm-Features: ATxdqUEFTLBmokoYvwc9c4wLOoyP5IyQ5tosHezckOvV3BMgdRkVR_C0mYzgXVA
Message-ID: <CAJfpegu-x88d+DGa=x_EfvWWCjnkZYjO8MwjAc4bGQky8kBi3g@mail.gmail.com>
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation behaviour
To: Luis Henriques <luis@igalia.com>
Cc: Laura Promberger <laura.promberger@cern.ch>, Bernd Schubert <bschubert@ddn.com>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Apr 2025 at 12:34, Luis Henriques <luis@igalia.com> wrote:
>
> Hi Laura,
>
> On Fri, Apr 11 2025, Laura Promberger wrote:
>
> > Hello Miklos, Luis,
> >
> > I tested Luis NOTIFY_INC_EPOCH patch (kernel, libfuse, cvmfs) on RHEL9 and can
> > confirm that in combination with your fix to the symlink truncate it solves all
> > the problem we had with cvmfs when applying a new revision and at the same time
> > hammering a symlink with readlink() that would change its target. (
> > https://github.com/cvmfs/cvmfs/issues/3626 )
> >
> > With those two patches we no longer end up with corrupted symlinks or get stuck on an old revision.
> > (old revision was possible because the kernel started caching the old one again during the update due to the high access rate and the asynchronous evict of inodes)
> >
> > As such we would be very happy if this patch could be accepted.
>
> Even though this patch and the one that fixed the symlinks corruption [1]
> aren't really related, it's always good to have extra testing.  Thanks a
> lot for your help, Laura.
>
> In the meantime, I hope to send a refreshed v9 of this patch soon (maybe
> today) as it doesn't apply cleanly to current master anymore.  And I also
> plan to send v2 of the (RFC) patch that adds the workqueue to clean-up
> expired cache entries.

Don't bother, I just applied the patch with the conflicts fixed up.

Thanks,
Miklois

