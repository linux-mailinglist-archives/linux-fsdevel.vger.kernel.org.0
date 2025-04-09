Return-Path: <linux-fsdevel+bounces-46118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A5FA82CDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 18:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CDF4420C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C1726FDB0;
	Wed,  9 Apr 2025 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="RcZCvVTX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA21552EB;
	Wed,  9 Apr 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217566; cv=none; b=gi1KqMMZucz+wBNkwLNEwW9foFEjCSnY7yRxPopxtOrCgMo5WCYLpZmIiAzD9LhvwRM/hKLgw7QJLwO+5WMHbfDzxqhHzz2Ic8PgktWq3tduEmEIE+Ingw0qkCVaf1T533UwG9PcM2yM3pfnfd7kIgiFzH7cQrhn8w58WLzhnYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217566; c=relaxed/simple;
	bh=obcPkLgnSbGrm5CefTwDI7VegcN2cHEoIUn425E7JJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ND6qupKXZJ874pIy40okUyg7LJQBQFjXnfDzMUpt/c76dXTyC+sl8YyCB1o+U7Thfyf1oerbgVTal5zDx8wNmbMRtPD2YI7nxgkh0l8Z9lpNS+NHIUq4OmcnZL7ewmP9f6naZH1FgAWNN6oE2xirvs7DIzvCvSxjjTLMq4G3+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=RcZCvVTX; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42FA644509;
	Wed,  9 Apr 2025 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1744217561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lka4EV0ThAd+Rt37FBIFAmnVZ8R6mxrwhqcTrFtj/k8=;
	b=RcZCvVTXrKMwdF3ETKRZN2tGXA6qIm3HE0gA7fNkc6kfkSpYOkl6u18XmaB/WbbPax6Upu
	iZ312LTmsxK1x3IYMpAX2JAMcEhqj3M65ZQjLyQB+o0ea5QDt2l1LMe32MsAgR18TsSH9E
	mSg7mv7ArbW+M4lvAJs5qRm09qYkwzTdvYHPmoneVtsfott+ucXW4zMLB9d/leD6l7qlS0
	Ghva9BL7tWCvWv1/S3rzSlXH4A+embOrDfSMWzQzesmmuSQjFDjExNhLa6i0kOifKXb4Dr
	3ZshVanWHAujI9B8f/syuZFOY1qiESeZb620GYIII3fWDabXjneqd4KGh9Upig==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Theodore Tso <tytso@mit.edu>,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  kernel-dev@igalia.com
Subject: Re: [PATCH 0/3] ovl: Enable support for casefold filesystems
In-Reply-To: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Wed, 09 Apr 2025 12:00:40 -0300")
References: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
Date: Wed, 09 Apr 2025 12:52:38 -0400
Message-ID: <871pu1b7l5.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeiheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthhqredttderjeenucfhrhhomhepifgrsghrihgvlhcumfhrihhsmhgrnhcuuegvrhhtrgiiihcuoehgrggsrhhivghlsehkrhhishhmrghnrdgsvgeqnecuggftrfgrthhtvghrnhepfedtvdehffevtddujeffffejudeuuefgvdeujeduhedtgfehkeefheegjefgueeknecukfhppeduleekrdehkedrudegfedrvdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleekrdehkedrudegfedrvdefuddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghgrsghrihgvlheskhhrihhsmhgrnhdrsggvpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrnhgurhgvrghlmhgvihgusehighgrlhhirgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhug
 idqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Hi all,
>
> We would like to support the usage of casefold filesystems with
> overlayfs. This patchset do some of the work needed for that, but I'm
> sure there are more places that need to be tweaked so please share your
> feedback for this work.

I didn't look the patches yet, but this is going to be quite tricky.
For a start, consider the semantics when mixing volumes with different
case settings for lower/upper/work directories.  And that could be any
setting, such as whether the directory has +F, the encoding version and
the encoding flags (strict mode).  Any mismatch will look bonkers and
you want to forbid the mount.

Consider upperdir is case-sensitive but lowerdir is not.  In this case,
I suspect the case-exact name would be hidden by the upper, but the
inexact-case would still resolve from the lower when it shouldn't, and
can't be raised again.  If we have the other way around, the upper
will hide more than one file from the lower and it is a matter of luck
which file we are getting.

In addition, if we have a case-insensitive on top of a case-sensitive,
there is no way we can do the case-insensitive lookup on the lower
without doing a sequential search across the entire directory.  Then it
is again a matter of luck which file we are getting.

The issue can appear even on the same volume, since case-insensitiveness
is actually per-directory and can be flipped when a directory is empty.
If something like the below is possible, we are in the same situation
again:

mkdir lower/ci
chattr +F lower/ci
touch lower/ci/BLA
mount -o overlay none upperdir=3Dupper,lowerdir=3Dlower,workdir=3Dwork merg=
ed
rm -r merged/ci/BLA    // creates a whiteout in upper
                       // merged looks empty and should be allowed to drop =
+F
chattr -F merged/ci

So we'd also need to always forbid clearing the +F attribute and perhaps
forbid it from ever being set on the merged directory.  We also want to
require the encoding version and flags to match.

> * Implementation
>
> The most obvious place that required change was the strncmp() inside of
> ovl_cache_entry_find(), that I managed to convert to use d_same_name(),
> that will then call the generic_ci_d_compare function if it's set for
> the dentry. There are more strncmp() around ovl, but I would rather hear
> feedback about this approach first than already implementing this around
> the code.

I'd suggest marking it as an RFC since it is not a functional
implementation yet, IIUC.

>> * Testing
> sudo mount -t tmpfs -o casefold tmpfs mnt/
> cd mnt/
> mkdir dir
> chattr +F dir
> cd dir/
> mkdir upper lower
> mkdir lower/A lower/b lower/c
> mkdir upper/a upper/b upper/d
> mkdir merged work
> sudo mount -t overlay overlay -olowerdir=3Dlower,upperdir=3Dupper,workdir=
=3Dwork, merged
> ls /tmp/mnt/dir/merged/
> a  b  c  d
>
> And ovl is respecting the equivalent names. `a` points to a merged dir
> between `A` and `a`, but giving that upperdir has a lowercase `a`, this
> is the name displayed here.

Did you try fstests generic/556?  It might require some work to make it
run over ovl, but it will exercise several cases that are quite
hard to spot.


--=20
Gabriel Krisman Bertazi

