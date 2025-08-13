Return-Path: <linux-fsdevel+bounces-57661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7221CB2443D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 10:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937D3169F42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4582EBDDD;
	Wed, 13 Aug 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rBZbJZHI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A02EBB98
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073490; cv=none; b=nPgq03F2qvIyWEs0mLKcAPR3tU3tnra5Du4UuEwXYB5PGMqn5hZkmgWuy+G+Oc8p27E1in5p41WXzCeBuGaIi99BXi9SkPARCNE32PfQIzzgIBogeRll8GTvSkVK8xhNT+7ONQXFCIiAe4meEWT8E9r+1NE3d6fk2AdGnV2zYWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073490; c=relaxed/simple;
	bh=z5u44ifKb1DRBesHZiFs7tczny3UxsMvaXgkz56QOiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuEmAp05/942P+/NgPcwzCEE/OQJOJXV1h5YnOCX2dGToS8NGbUnNz4hfDZ07Aax+fjAfKSCp0psrWVzEnHHYhy552KtHBnnfsGNeH9CHHXBO92mvU6xWjsTwCWVu3ChJTKu1bXwwRxvH+u5gAoP1hE6eaxWVo89/oKEFWlCdY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rBZbJZHI; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b06d6cb45fso77562321cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755073487; x=1755678287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ul8MgGaDDUDUiZCThY985q71dl9/YQWgcKDWHWS7mA=;
        b=rBZbJZHINm15iFhQZKo1XTl7yEJ/ydY/N7zYTzr8umvSxwJUZof3xKElpRyAl2H7qz
         FeafvLbH3dPagxNx7SNlT5e1RTeUqFVrleCtz41mONYw2cjcTq+yRdN+Q6GLWxM+bxjQ
         3gyQwAqYHEjAknZ2LGBgp1zIL88hquGdjPA8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755073487; x=1755678287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ul8MgGaDDUDUiZCThY985q71dl9/YQWgcKDWHWS7mA=;
        b=tcwmO9O7ML8NI7pW1UPzJBr/BfxqkntyhcVWp+PVHlWU/dMJrgvr2XTMW2rjvzH7qC
         krS2QURJ/Ot/Vwdz8qydbHM6jqmQjkZS7kZPXpQupvV6s7GxPenkpGvWMl+N3Pldw4dK
         9BcLnCFmffmrBtbbv7Y0G4oZXNXclzyc3QQzUc6TzF81UNdZX2nhM2/f0wfMewlzlWxd
         Ufqb8FH7VZrsfQDA1X+QYiki5CPWdjjKpI8XUlA+WxqpxKj+yyvbd4rJ02hJY7Yr2yOo
         wPt1YVRgs1rHO6nDbcHU/naPNMUTmdHbu93BlS4cIC4vudtZi8uJ/Nbg2JGRYwbFmBjt
         KY4g==
X-Forwarded-Encrypted: i=1; AJvYcCXwVHSpwi2y1E2cItA8WV9Je1WEjBUkLCOqhMgXqcvCmywskUSTU9Fd7JQA3iOcDJzI6wsABILljpbM4N29@vger.kernel.org
X-Gm-Message-State: AOJu0YzK1gKJbPl4T/tTYQztDq9PfAZrwXh5n+xsAReeGGDuwhG3ZE7f
	aTS1aFMiluUDZ31sja5e5iNjiAngC+HecIN+yIYkyJ+fU6k4Rae1ln4C9SO44bR1seA1NbPYqvh
	F0iqQCyD6dGD74si72D4rfFR1ZFslJKSOKvWty4LA5w==
X-Gm-Gg: ASbGnct3yVo8mEeIzkbm7iBsHfwcm/cmffvsP6G00Q0or2V/v7JIvg2BqmhPLzQr1X4
	kWdzXJhJ4N7CRMaa5BdP0Kux5tZlD7v0aNB/Rd9ky3Bl1LK5jsyM+o6kTZO53NxA1DGIdTOfXWm
	EGwoPC918o/Du2PU+qgV4o3ENIGv4+IbmX3rtPfQBy4rV+/ix6dtKLrf/zG0VR7S7f6r/3UKcEb
	CAv
X-Google-Smtp-Source: AGHT+IEGY9tEyNR+mEZVx8GB1HfPpTwtPWsVn4YUQX9RCl1+eaMebHjpTaP88Hq4tChTNup2se6WvCMv+E7Ii1OWUfk=
X-Received: by 2002:a05:622a:5512:b0:4ab:5c58:bb33 with SMTP id
 d75a77b69052e-4b0fc8a41cfmr27238611cf.49.1755073487395; Wed, 13 Aug 2025
 01:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807175015.515192-1-joannelkoong@gmail.com>
 <CAJfpeguCOxeVX88_zPd1hqziB_C+tmfuDhZP5qO2nKmnb-dTUA@mail.gmail.com>
 <20250812195922.GL7942@frogsfrogsfrogs> <CAJnrk1Zt9XoD2sPYGzFQwKsCHo_ityZ-4XzU_2Vii3g=w89bQg@mail.gmail.com>
In-Reply-To: <CAJnrk1Zt9XoD2sPYGzFQwKsCHo_ityZ-4XzU_2Vii3g=w89bQg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Aug 2025 10:24:36 +0200
X-Gm-Features: Ac12FXw8nIx1ovLhvPFH0dRnxL4d-KHg39xmGT80L2bTTX5vh3iKLuFBGCGqen4
Message-ID: <CAJfpeguN_Be4q0jxoS28zpd4Y8Ye6kqMhspAvJ=tuba97dPVVg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: keep inode->i_blkbits constant
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 at 22:44, Joanne Koong <joannelkoong@gmail.com> wrote:

> My understanding is that it's because in that path it uses cached stat
> values instead of fetching with another statx call to the server so it
> has to reflect the blocksize the server previously set. It took me a
> while to realize that the blocksize the server reports to the client
> is unrelated to whatever blocksize the kernel internally uses for the
> inode since the kernel doesn't do any block i/o for fuse; the commit
> message in commit 0e9663ee452ff ("fuse: add blksize field to
> fuse_attr") says the blocksize attribute is if "the filesystem might
> want to give a hint to the app about the optimal I/O size".

Right, that's what POSIX says:

  st_blksize A file system-specific preferred I/O block size for
                       this object. In some file system types, this may
                       vary from file to file.

Thanks,
Miklos

