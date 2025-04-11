Return-Path: <linux-fsdevel+bounces-46296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A82FA86218
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 17:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB161B632C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B520D51D;
	Fri, 11 Apr 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Thvdrc8E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC8126C13
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386023; cv=none; b=OFpHbVnqCSuLtp4fMGbSKDU9TCYx4CozIGwYWncPD1uAl7Q46RHmFrrCIuDR1Y49Ik97Mp/IviU3iTkrfXFYVMGmOFbNHw99zxoQDzBCfC52ihJa0bsUsMyu4iWV7kjVcU20USMDY9v7jofWIdx85McjYqLbyTwJYQb79tO4kg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386023; c=relaxed/simple;
	bh=PYpqcucca94gDb7V62fvhEps9J6dyd0JbBoqY4fmaDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHk3nxejq8Uwc1tEyajxIj5M/nCMrzouTCPUOeMHy41ATRul5Ep1MiVs41E+zSILrsrZWHR3V0sAbNGDmKTv09WQeepc3S/0HFAmonW5CBDHF7NiC2PizVnlAjfxE1WbqcUSTrRSqQNrarP8b7whjD58jLjJYlY4lBuxzpZIjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Thvdrc8E; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476af5479feso20175181cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744386019; x=1744990819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+8S3EWUza/3tug8ZT34Czl6H3Kw1c1j/m5wHDgJSQRA=;
        b=Thvdrc8ESsfIVUb32uG4Fi+ioBBG8F/Qve4DfSUo0bwMRa9T1h36VXwuOjniU/Wpie
         aFqAtzXdkoPHNPjZ8UjdSYorPRmRXFqO6DVyNqoiH5Su0MmQinPMWHhGP64MmkTiLUDu
         zBLjwnjNYIEHWsGfffL70BsMf5SlWdXDUraJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744386019; x=1744990819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8S3EWUza/3tug8ZT34Czl6H3Kw1c1j/m5wHDgJSQRA=;
        b=YgcyWIwXAiFie6IP9QH1Rpp+IxkG2mZVM6d3UxAQo53vEbLursyPcgTNc+WcxakzeY
         FQW5K6hyBZQa6SLyBo2JQ1Nmg39kbMcBY1FwxJfGXLmVXekAixBm3RPtbv97r7uyCw6M
         QHVG6KqC/PEcT09W/GO7e0tDRgmoufn/B9SGdouDjLHWev+QZgUquUr0jxq4gnS36ASH
         GnfIKUTP7yV6n72dR3lZBIGFlJK02qKxQd4nhJEM/OXT5jymDZjzZdhg9+k0iu6IroDx
         5Hq+PRpY15hgAGP1hd9sxqfkkjo4oyxzev5KdmF9ZgXikAg/Z7W4HIyLvQmPjwtnut9l
         ou1Q==
X-Gm-Message-State: AOJu0YzsEcrlT1nOkWvDNETVsgv7TVvRlKicz14MdD1visrB9lX+yFKS
	pWFVfCfm9RYTZyKW2yoGyPjyqcs61dN6rkZJTKytvpv2OqHMj8Mk2k4HEmy6J79hRmvxZtGNQSM
	rh6o4JpevWAZ7rV2zu7j8GDZOEiQUX+rbZqyYgw==
X-Gm-Gg: ASbGnctA1aTxvZyTp9tHXYvr4vaAM6jtxPl8x1KLbytXQ7a+eJlmTMxkHQrrUmy+uqW
	XTimAuHSDUimUr3cTK1kEKvHn45XzXBONJ+xSO16LQ1ArzMCFo8fIgSMl/g+TnmRoHhyX4TzHw1
	gzz1dL7bq2LmUPkTXd+W4=
X-Google-Smtp-Source: AGHT+IFtAhC7HpWbZL/dfEJTFPYl5rK97SPx0lmRFLckg5rC5xIvaLnqno5llqi8NPSYB8n+BeWYWNsstPyI7LKxEug=
X-Received: by 2002:a05:622a:48e:b0:476:923a:ca79 with SMTP id
 d75a77b69052e-47977507fadmr37418091cf.7.1744386019227; Fri, 11 Apr 2025
 08:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
 <20250411-rennen-bleichen-894e4b8d86ac@brauner>
In-Reply-To: <20250411-rennen-bleichen-894e4b8d86ac@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 11 Apr 2025 17:40:08 +0200
X-Gm-Features: ATxdqUHIeeYOxQN-e6InRFxNpJBc1jeDhvLRyzRqLvivgRZXDxT6ZXuKYijy33E
Message-ID: <CAJfpegvaoreOeAMeK=Q_E8+3WHra5G4s_BoZDCN1yCwdzkdyJw@mail.gmail.com>
Subject: Re: bad things when too many negative dentries in a directory
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Apr 2025 at 16:47, Christian Brauner <brauner@kernel.org> wrote:

> Note that we have a new sysctl:
>
> /proc/sys/fs/dentry-negative
>
> that can be used to control the negative dentry policy because any
> generic change that we tried to make has always resulted in unacceptable
> regressions for someone's workload. Currently we only allow it to be set
> to 1 (default 0). If set to 1 it will not create negative dentries
> during unlink. If that's sufficient than recommend this to users that
> suffer from this problem if not consider adding another sensitive
> policy.

Okay, I'll forward that info.

However, hundreds of millions of negative dentries can be created
rather efficiently without unlink, though this one probably doesn't
happen under normal circumstances.  Allowing this to starve the
scheduler for an arbitrary long time is not a good idea in any case,
so the fsnotify problem needs some other solution, and I suspect that
it's not to disable negative caching completely, as that would be a
major bummer.

But the idea of leaving negative dentries off d_children is
independent of caching policy.  The lookup cache would work fine
without d_sib being chained, it only needs careful thought in

1) putting the dentry on d_children when it's turned into positive
2) getting the dentry off d_children when it's turned into negative.

Thanks,
Miklos

