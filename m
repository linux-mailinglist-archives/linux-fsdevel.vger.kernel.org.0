Return-Path: <linux-fsdevel+bounces-15699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E28924B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 20:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4CC1C2245F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 19:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890713AD31;
	Fri, 29 Mar 2024 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CBUkVwZr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB484AEDA
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742203; cv=none; b=TYbZvwyO8Wtdd9O45mE2X4LMfUbzgseHG7sWLNk7AjyYzDqqbLZhwFJGS5qnzpKWzJecNDCI/ITl8ftAohdpPhfzEer3WN4Pybum5Hzuyv4U6gXQNmNEh4OqsNje4ePKci74ZKtmk5Ya4mxHW1Du3rcG5/7ahnjBZBWk5PjyO9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742203; c=relaxed/simple;
	bh=kl3r4t6JEKPhRbXJ7T+YhSza5u8zPgVfF6ukpjkWUEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFST2pm7ldI1Y9d6lrn8DJBJWfAdWephKsbJyqb1MdqHEKZFImARIGBqwg8ekK0v76s0swj73F6oqGzaa8cc5ORvDKI+FnxsIUoUqH32QN/VMTUPS4mn66v/dZpIanzYzpJR4z7DP3nxwYw3yDKKUvXJEB+9DfKGSuRiovM/DKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CBUkVwZr; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61448d00c59so6027297b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 12:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711742199; x=1712346999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6A9jbG9CdaDPP1v6fWuwcIQF8qoPPnl16dGzz2qlT0=;
        b=CBUkVwZr6fDdpu1CS2Uchp+UMiOJJcC/5ubPJMrFby2ed8H/XnyFZX6xxLglV1czkg
         jFjntZNznVWUaqtNtoysFOUSv9fdkCv/c8qbMJE3ZDaHsq6bcs4zoWAkoHy9ueZYC+/U
         8IOkRJhBh1jpe5TAhnmnY6ROVaMK/0gJI4Q0Hb67GGwE8HUJxdCcQ8HkURjV20ZZ/B62
         CjDtw0YOQ/2z/R8VUhGf4XJ0REDeKDy11otkkCBXauFEf0MytH0KsL0G+MdbKF1xxh6K
         vSC5m1bC2bPGo7inX9ggy6BxfA8jsn25P8erH6YKdXs1sO4s/7m2XjuxqEyQ7W/rqj2p
         xL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742199; x=1712346999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6A9jbG9CdaDPP1v6fWuwcIQF8qoPPnl16dGzz2qlT0=;
        b=Q42vN5VAdTycSb40Qs0wr3wZfLfmAEYsHkduFB7fZX5ng5ltSW8HjJ4n8D4fzNmAja
         I8RVTjmQZfVL9GuBbp7WOEE2kDSrM6pRkN81dBG4TOyuYysnVkFTNhnXqR7/+9JxG0S5
         wlH83cf49mf2sE4DgtVA+liEegXOYvMR3rsuUoZJZcSBy8hqWwpCkoYisneBjL8Dv/0r
         fC21cEFsuZSM8gE0xdn3yh17xAA8bTXhPXfzvTq6cCbYb/hGXtqoMGL6O+bDPxmBgMv3
         7ja2tetJbDIf2LDWpEDYWxjq2Cr3Bex/ksOmVGcSZz9KDYUmCiJUk2vo1BysmY0zDUIY
         LT6w==
X-Forwarded-Encrypted: i=1; AJvYcCUXMx4B3/e5WIZVr/0VYbbIM3jWWhBFHy00lfe1ZKN/dFiaYpfSiNfnlwv+1EFCCI2uvw0+qDLHrkhg1hUXHKzdp+ZPCfu3NOzPDP2L4g==
X-Gm-Message-State: AOJu0Yw44Je3+vRWj0YQpdymfuNKdRXsDIjlAwFGNJ19cGV+5XaRJCfE
	gSeMy+NIowomici5o9FqPBjbiEQZoGv71MXLsZiH3ROl5bQa6ZDIsT1b/4R88wGty6tucN4VWSY
	6F/dYYTvs7lHcnV2jRgIctDJrjNC7t32WFtwt
X-Google-Smtp-Source: AGHT+IFxyLSFxbUR+gusm9UKIGf6amr40sayZYaOUaH9So5UHH1MFJgsFV6241YbxJom5p/x/nu93KVnKL1nyMhNoOY=
X-Received: by 2002:a81:494b:0:b0:60c:bdb0:cd28 with SMTP id
 w72-20020a81494b000000b0060cbdb0cd28mr3336888ywa.6.1711742199706; Fri, 29 Mar
 2024 12:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>
 <20240329105609.1566309-2-roberto.sassu@huaweicloud.com> <e9181ec0bc07a23fc694d47b4ed49635d1039d89.camel@linux.ibm.com>
 <CAHC9VhS49p-rffsP4gW5C-C6kOqFfBWJhLrfB_zunp7adXe2cQ@mail.gmail.com> <1fe6813db395563be658a9b557931cf4db949100.camel@linux.ibm.com>
In-Reply-To: <1fe6813db395563be658a9b557931cf4db949100.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 15:56:28 -0400
Message-ID: <CAHC9VhQaQErZyqe88wKvVwHKHDdgYB1SR11Z9iZC6VisgmiLpw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ima: evm: Rename *_post_path_mknod() to *_path_post_mknod()
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jmorris@namei.org, serge@hallyn.com, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, viro@zeniv.linux.org.uk, pc@manguebit.com, 
	christian@brauner.io, Roberto Sassu <roberto.sassu@huawei.com>, stable@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>, Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 3:28=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Fri, 2024-03-29 at 15:12 -0400, Paul Moore wrote:
> > Another important thing to keep in mind about 'Fixes' tags, unless
> > you've told the stable kernel folks to only take patches that you've
> > explicitly marked for stable, they are likely going to attempt to
> > backport anything with a 'Fixes' tag.
>
> How do we go about doing that?  Do we just send an email to stable?

When I asked for a change to the stable policy, it was an email
exchange with Greg where we setup what is essentially a shell glob to
filter out the files to skip unless explicitly tagged:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/ignore_list

> Is it disabled for security?

I asked for it to be disabled for the LSM layer, SELinux, and audit.
I sent a note about it last year to the mailing list:

https://lore.kernel.org/linux-security-module/CAHC9VhQgzshziG2tvaQMd9jchAVM=
u39M4Ym9RCComgbXj+WF0Q@mail.gmail.com

> I thought new functionality won't be backported.

One thing I noticed fairly consistently in the trees I maintained is
that commits marked with a 'Fixes' tag were generally backported
regardless of if they were marked for stable.

> Hopefully the changes for making IMA & EVM full fledged LSMs won't be
> automatically backported to stable.

I haven't seen that happening, and I wouldn't expect it in the future
as none of those patches were explicitly marked for stable or had a
'Fixes' tag.

--
paul-moore.com

