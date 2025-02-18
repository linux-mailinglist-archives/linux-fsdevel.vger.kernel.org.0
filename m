Return-Path: <linux-fsdevel+bounces-41968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C6AA396F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2767A3A3E7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE1B22F3BC;
	Tue, 18 Feb 2025 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WZTgsvIt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C61FFC48
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870139; cv=none; b=cLALkNtlKloYaMthMk2htq0Scbyol+QlRzW92g4Tdac+C++F399y4ekCLVURLR6PgEGPlWM9oiB7IuYUKwDEJNoY8eg5m2hb+Wo+89rGtdrA88qPNpPwQ3RFEH6G/k7Dp4WhJnul7oo80C2/cuokwm7LP+SUat6nm3QCGpeBzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870139; c=relaxed/simple;
	bh=iA9AGMXcymWk0aqUD2HB51dKBFnWqCxYYVvRaHqRk0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrT392B9MBNI19/aHGD4+Me/cjSJUtSl1kfNUlxCqRMPdtcN93+ehIs1hKDJ7xSOrIbrQLtyntJ6cUMXithDmV5btSKHtF225Q7lfE7G4AV0U4JWpFeqRAxD4C+w3RrenzxPVoD8MljsW5MWKtsg/CatWpaBEu+QlPhMVDTpj8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WZTgsvIt; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46fcbb96ba9so59310101cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 01:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739870137; x=1740474937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/9o60+wmpu1uSsdLe+fAGgKFk/Xz6Tn0Yptqhrl0H24=;
        b=WZTgsvItBLhqEE0bzy29A8rH0IS7Ma4m1qEmpMJg9/TzVG7qKWER+0AYmxKbiOs2tT
         9mS6fjiQgyWnFgQlotdjMdL9W6MfnfsoTtGOajV5iBXBqZsqBYzppoPF4ROAOICJCUl5
         9LpNtjrAOvLYpNp/cOBSHFd8KtynNd+Mrolpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739870137; x=1740474937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9o60+wmpu1uSsdLe+fAGgKFk/Xz6Tn0Yptqhrl0H24=;
        b=FxX4n1E12M8Ta92Id1d+wskRYhxhv8OxaOM9uFYiU/mVg/xEJ6Lqq2Yvj+zogFmOCm
         JF+K1Ws+cY6duAYvXYhcGSU46qadJmytvqqNrPI4KAWnyH5+EqTpL8VYqKst7F8wRDXG
         DZR/QOTjXa+1qVjg7CJCqfV0VIkaRQcFhqPzMm17MPz5gTfOx9ZxWuGFulryKM0L8cIp
         7ZP39p++chfgzBfBuMcYkt9UtBJtlJ2X/UIV8zVtnha/IHbi/H9mheJ4456n8Zya/rC9
         +PbrqYY4K7EWBVv1OvjIQTi3SH/9S0pMeQq7Bp2PSru9eWKfsW+z3ACsp3ERKQ9BEzDQ
         Hdlw==
X-Forwarded-Encrypted: i=1; AJvYcCWcgjwFYSA7pRYaOcbH0BEaWsAiVhXz5fRnsJPjpokPsi+ik2f7rO0rsXKCNEtz3kyBww5qnA6LRbsPoKgA@vger.kernel.org
X-Gm-Message-State: AOJu0YwUF8DS193lX6psahDpMndNiPXF9FhMObYT8Mv8OJ5PCrMQhwfh
	9488Spal9FyWMJW0Ak1V0WEBaWgrbI2lF1CTaSsF06Q+1p5JJiBMbuBy/I66Y4d8R7AbCEyJo59
	tdva80SyZtGBUFhQi+oQDiDiaHI4jF/VqtlmBng==
X-Gm-Gg: ASbGncs7Uc+tWw04X+Hp5Mz+2LNw5e2DsSm0pkU5lp1km30ZddrE30dphghwg0V8PM8
	Ec1yeUrmn+gcZGjtwhPdlU/HuG91Htql0sVCLsk0EBBeUTO2q5LB0WM8SskBQJaIKi7wAuLA=
X-Google-Smtp-Source: AGHT+IF7OXUuVZIvUWcHSkdB3EmL6eX0eRGEnz8G+dLsYP7tcuw3hlXDLltRlig3xpi6GmrpcVyeyIAffsvZWcWIA0M=
X-Received: by 2002:a05:622a:59c6:b0:471:f5d8:5f56 with SMTP id
 d75a77b69052e-471f5d86142mr83888681cf.1.1739870137132; Tue, 18 Feb 2025
 01:15:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217133228.24405-1-luis@igalia.com> <20250217133228.24405-3-luis@igalia.com>
 <Z7PaimnCjbGMi6EQ@dread.disaster.area>
In-Reply-To: <Z7PaimnCjbGMi6EQ@dread.disaster.area>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Feb 2025 10:15:26 +0100
X-Gm-Features: AWEUYZlMbyj79ggSvwhwNFRl4UDBvs13x_6taoPW6P6cYlPOsVcloafHbUopCZ4
Message-ID: <CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for all inodes
To: Dave Chinner <david@fromorbit.com>
Cc: Luis Henriques <luis@igalia.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 01:55, Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Feb 17, 2025 at 01:32:28PM +0000, Luis Henriques wrote:
> > Currently userspace is able to notify the kernel to invalidate the cache
> > for an inode.  This means that, if all the inodes in a filesystem need to
> > be invalidated, then userspace needs to iterate through all of them and do
> > this kernel notification separately.
> >
> > This patch adds a new option that allows userspace to invalidate all the
> > inodes with a single notification operation.  In addition to invalidate
> > all the inodes, it also shrinks the sb dcache.
>
> You still haven't justified why we should be exposing this
> functionality in a low level filesystem ioctl out of sight of the
> VFS.
>
> User driven VFS cache invalidation has long been considered a
> DOS-in-waiting, hence we don't allow user APIs to invalidate caches
> like this. This is one of the reasons that /proc/sys/vm/drop_caches
> requires root access - it's system debug and problem triage
> functionality, not a production system interface....
>
> Every other situation where filesystems invalidate vfs caches is
> during mount, remount or unmount operations.  Without actually
> explaining how this functionality is controlled and how user abuse
> is not possible (e.g. explain the permission model and/or how only
> root can run this operation), it is not really possible to determine
> whether we should unconditional allow VFS cache invalidation outside
> of the existing operation scope....

I think you are grabbing the wrong end of the stick here.

This is not about an arbitrary user being able to control caching
behavior of a fuse filesystem.  It's about the filesystem itself being
able to control caching behavior.

I'm not arguing for the validity of this particular patch, just saying
that something like this could be valid.  And as explained in my other
reply there's actually a real problem out there waiting for a
solution.

Thanks,
Miklos


>
> FInally, given that the VFS can only do best-effort invalidation
> and won't provide FUSE (or any other filesystem) with any cache
> invalidation guarantees outside of specific mount and unmount
> contexts, I'm not convinced that this is actually worth anything...
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com

