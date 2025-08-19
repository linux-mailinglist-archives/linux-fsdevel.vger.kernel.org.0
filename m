Return-Path: <linux-fsdevel+bounces-58315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF5EB2C7F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 17:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A15A1C2470D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD68283C82;
	Tue, 19 Aug 2025 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TU4HywSC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1B27F756
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615691; cv=none; b=tijBdWcDJT7ijwI/vsBQ1fhTx5pz6kTpAY96USUTRaID2MtUyWoKGRTR34Mud088kdS+BZDgr2L1LBCPhUopjezoiSwFnNrm9HLGhbJtQOBBBbGi4ikJcaxMw3CQxqgoLuJbASPqdqCqAlBRGV8fDgNjtCecvMETTA6KGm2U37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615691; c=relaxed/simple;
	bh=WSsXGqpmRDalxXqO2Wzrhn3PeUWutq66MwjCiXm62+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W35W8Qt5oZLR1U55UyBLd5j5kuHrBsUvSqIt+GnpU7oLMF6fV8j+ZkYQZDkeAjV0cn8oUezVtjvYMN9JlzJVw+vwftjLIOhImLcSF/tuKzZsBFyOqa42hUwn0TDUTbxznVmv+q4NEigsxFh+GI8Et5X2piRbbKCFOaohfqxsvE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=TU4HywSC; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e864c4615aso634500085a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755615689; x=1756220489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nTJ0UNaR6a9J0y81cdJx1tnJU4FJPFaXkbwhwF9z9TQ=;
        b=TU4HywSCApx1VuZaa2suucSJbBzlsUOqFDXcDuQS8iBXQyv4xT8qsPStAt+Z1Dm0gF
         U31HxxCkzAs3A6vT8F1LRPeQO2dzueMSgqLGCdmL1rjiU15irSZSUExMGciMWVEkwjqw
         iJWGmPhhxtngZ/W5gQlTWxl9mBUzF5ctmDPSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615689; x=1756220489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTJ0UNaR6a9J0y81cdJx1tnJU4FJPFaXkbwhwF9z9TQ=;
        b=xCjM36JmxI45e0AU959bEwzJQASurjcPGSLs61uEK317H7hplN7QvGK/5IjiKf6Vm4
         0plECCwYiKYldDOAK6QrwmeIzNFJwoLNOB5+xrAE+VmI6W2y9FVfhc8jbT+SkNmQ8aAp
         KrOc8IbYaU1zXeaJ4Q57TMhki5hVxwxmVtDK63ImuQ5gWungvPhw1Glqb0i2NtUyqkWL
         gbDsAQXA6MAqUZq8rm6yVxJrvmhi2ngExd28bDGwu+iDwIJsukc5KFCQZVpERjHph2n1
         Nwe+RnOlpkOoWlM19BvfTvHvtWftRbVudYpwNmCXa/s0owvbSZgQwoPh3yjPtecaniML
         jnpg==
X-Gm-Message-State: AOJu0Yy7SMasJfnDamJ3jXRZBT4wrV214yaSJsod0Vpt0nxGaFpAF9JI
	LXAGbk6CHll0h3G39pMqAyyonO7CAtnwT8qDgWwUNuRinNMtGymA9VnTexxsjr03Z0uP81zfWmI
	H6sHzkiDN5FHifTq2w7ifEYUcdIURtWELftyT7wt2Qw==
X-Gm-Gg: ASbGncvHA4aW2hL0WGdMSuot3onMO0ClAuXw7hPYpvcdBtazbmJrsn054kY22Ct7ODU
	F7vhYY266XFBURYFMek3dazeFGUe+ygkvMJ+wqLN0YJ/eoGRVpIHNRd+hGzmI2rbQPG9b5E3lYD
	xC4frbXHwg2pCqIq57UDApj0aqMZN0wwTYFvRbV1PKx/5HJG1JZjHSh/IqDtTFbFEDxlKcbp/hx
	Sb83HAuxg==
X-Google-Smtp-Source: AGHT+IEEukgQj6SXAn5U7Xe99t+W1yhMxZF5S2qBCAwZV+/yhYZ28bvW2698OKelrNqqKY2sGw0sk5CE5u4tsFyQyLs=
X-Received: by 2002:a05:620a:bd6:b0:7e8:7a7b:5723 with SMTP id
 af79cd13be357-7e9f45d4940mr238348585a.22.1755615686827; Tue, 19 Aug 2025
 08:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
 <CAJfpegvwGw_y1rXZtmMf_8xJ9S6D7OUeN7YK-RU5mSaOtMciqA@mail.gmail.com> <20250818200155.GA7942@frogsfrogsfrogs>
In-Reply-To: <20250818200155.GA7942@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Aug 2025 17:01:15 +0200
X-Gm-Features: Ac12FXyhlp48dp2JupeI46dy1scpnR7RPpW4wix3bN2X0uYDK7WjUgUl-dBKEHU
Message-ID: <CAJfpegtC4Ry0FeZb_13DJuTWWezFuqR=B8s=Y7GogLLj-=k4Sg@mail.gmail.com>
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net, 
	bernd@bsbernd.com, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 22:01, Darrick J. Wong <djwong@kernel.org> wrote:

> In theory only specialty programs are going to be interested in directio
> or atomic writes, and only userspace nfs servers and backup programs are
> going to care about subvolumes, so I don't know if it's really worth the
> trouble to cache all that.
>
> The dio/atomic fields are 7x u32, and the subvol id is u64.  That's 40
> bytes per inode, which is kind of a lot.

Agreed.  This should also depend on the sync mode.

AT_STATX_DONT_SYNC: anything not cached should be cleared from the mask.

AT_STATX_FORCE_SYNC: cached values should be ignored and FUSE_STATX
request sent.

AT_STATX_SYNC_AS_STAT: ???

Thanks,
Miklos

