Return-Path: <linux-fsdevel+bounces-36642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A79E7350
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5E61698FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27061FCD11;
	Fri,  6 Dec 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Q3y3ioCO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF3145A16
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498325; cv=none; b=nCV5C5w7ewWI86hX3JWNVzagWLRNAlcp3gznPGptAGh+xhWgE16nq6+0oDUs3J1ppFFLeoQCTMq6xt7QPN/Ju8lOqWBhWSDpV5J0t+Gnd4cFUXeDDHKG3dy0KHLKGHFVjBhpreNalQGGqGfj3e0GqBcvrZ+WXjoIqaS54ywRuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498325; c=relaxed/simple;
	bh=Kjfd3uWJy1RQ+uBgsWcKOZ8c2LJHYfpGQVptGp1scCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/R9xvxp4an17XwKcY1Ym6oGKNskKs07IEv5TndeD4Nk712gTQwVjZD1DeivDQUvyKmNhmskU7KmIinuYB9KQjD2T+aud7cKNgxxf0Wu88FXuxH/f+XXC7eNF9W0zAoikU3SI0ZQB9H6IxCjmZwBgwoqbmGokZdZ2UgMoeyHdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Q3y3ioCO; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46375ac25fbso20718541cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 07:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1733498320; x=1734103120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lvufyFHcePBpydTUMD+1cHmYYAsA2el+HCALn6Q708M=;
        b=Q3y3ioCOpLFig/Bj3k07XE/nShNE/59oOerLr9K53PB9X0DAD4pNagsU6L07HQr3Hx
         9IwjMEYSOp+QmBc8o6o7OU3wCQXrtf0phjdMlev011kxRECf6Af8LCWnENFVOBGMdrrY
         aQK1Qh8xvSg2Psy0ID57RGeH5CGMGein0BV9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498320; x=1734103120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvufyFHcePBpydTUMD+1cHmYYAsA2el+HCALn6Q708M=;
        b=H0PSfRig2KwUtfhJyQjugKFGPpDUjbcZPXRByARmPCzYckMmj9CUPAxtvDfyi+mffh
         S+mzMKNtzK6y1W4utJoyKPIaKL9fFJYrC3NYSCaoqrGkX7JLr8ZcqDqLhFo8nfNhVZse
         cW0fYv0xjU+GJ98Iy5KYEPe5EhMjTzfRouSm6/+qThofcQpQ8x7qyVE7SBhd9R64G2wt
         x7vl+RIF7djWDEFqVGObMHKw+O51p4hJSNg8nj6660QOZC08z/DRGkpxNhtVO4/O77ZX
         p++oJHhuh5DDoefNBa2e9oK0WFWXXCQJgYh06TM2QFZqFae4zaIPMo41iry4Nx8dsxS3
         ChBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv+ah73qnJRtnaNQANiw/rx2TEp8J7pNBeZUUitWl7p7a3tQxffSpEiIUFt7Stq4NEAcSxAzMRNnSzWW25@vger.kernel.org
X-Gm-Message-State: AOJu0YzRglzDuB1LVrFJQ9fGXOqZqYHut3Rm9PV4u4p5xRFuc+JD9+ze
	UwDSD/O1U8MLpIHaQuDQ66jHKjoY2XkdU/MPUv+Wsx3TxXFZAU3EUaEhfgDbwWZJSJ1Q1RSwDM5
	AeFLpLdlfhGaQlD6aitYMO8Gqj4B7Ts4/eQNygg==
X-Gm-Gg: ASbGncvL3S224uMmBRHVdgmaursWAx4MxUtDu2LYDHDuvcNQVnXeKC4VZq3dkc4hNQ2
	t6jRfmFSZ6e1nv6AuJnuiKlX3D8zuc6g=
X-Google-Smtp-Source: AGHT+IGDf1jiMdYKaBAAijU28URIDeRUfxt4UibMMmgvtSE5s5FcISBnz2fAVlaIry2duzNuf5X2Tx3o/YMv9xnlMyI=
X-Received: by 2002:a05:622a:15ce:b0:461:22e9:5c54 with SMTP id
 d75a77b69052e-46734ce2238mr58989081cf.26.1733498320018; Fri, 06 Dec 2024
 07:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128144002.42121-1-mszeredi@redhat.com> <dqeiphslkdqyxevprnv7rb6l5baj32euh3v3drdq4db56cpgu3@oalgjntkdgol>
 <CAOQ4uxh0QevMgHur1MOOL2uXjivGEneyW2UfD+QOWj1Ozz5B1g@mail.gmail.com>
 <20241203164204.nfscpnxbfwvfpmts@quack3> <20241204-neudefinition-zitat-57bb2e9baa13@brauner>
In-Reply-To: <20241204-neudefinition-zitat-57bb2e9baa13@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 6 Dec 2024 16:18:28 +0100
Message-ID: <CAJfpeguPHaO6wc1eXufrT+1yXecHtW-un+fFyd9csbVYqvAbcA@mail.gmail.com>
Subject: Re: [RFC PATCH] fanotify: notify on mount attach and detach
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 13:04, Christian Brauner <brauner@kernel.org> wrote:

> > > What should be possible is to set a mark on the mount namespace
> > > to get all the mount attach/detach events in the mount namespace
> > > and let userspace filter out the events that are not relevant to the
> > > subtree of interest.
>
> Yes, that's what I've been arguing for at LSFMM.

Okay, done this.   We can add submount based notification later if it
turns out to be useful.

I think all comments are addressed in v2.  There remain a few FIXME
items, selinux in particular is one I have no clue about.

Thanks,
Miklos

