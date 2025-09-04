Return-Path: <linux-fsdevel+bounces-60255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 691F0B4363B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 10:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CC43BB6F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 08:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A932D0600;
	Thu,  4 Sep 2025 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RzUaqi9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73A62264B1;
	Thu,  4 Sep 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975720; cv=none; b=MHmVY936uUlP14Btq3HN3M0iiFPJ5qUTZsq4532q9wj3tEKN1HSP4N0FVFIIorN9YYgydMUz+15M/0OSt5A4XyO502YukFF5TO8Ms4Ou7M7TbB5RGpZP33oKutD5RkydNsiyDwQZs4nMKxxrAAvejJw40uiQE/yELW+9YLHRzNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975720; c=relaxed/simple;
	bh=G0RpCOAOhFdq9v7VRfRhAk2CyCDixB39MJqHfxVnrNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OrWReKoy/hzAp2pXdtUCvLOeJ/IcDuG4FhaUqQRerX7IlHf0d3ISaPU0CKId4LyZy8ZWTBPU1F+wX1YHyBbEVoO++hE+SNC3NxQJ6I5zINAyEZHDb52DB6TzHCdMmjN7AbDJzO2ZvdYA+mJN/qWNy8Hzc68I4Ggm8H8ndQz1WbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RzUaqi9O; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=i047xJLuaw78I7Vo+tdDagy1+g/9ibRhxuzaPBbc2zU=; b=RzUaqi9O+4Y88I24uvOUW8rkoH
	s6eSdAcKMSw4BjKEzSuENSuAnJtH41iF+Wc1Xj04lEJqov7OCqae2RV+/zPKvR+mKeIjVfeNmeAr8
	x/uoPmH27lGVM48dX8CH7RR74UWXnVKBO3rhoVC7daDutp1KgEXY4htl9iqBf6kN7iSVhfpH6QuJv
	QiTx72Y7Q5gg8HsRt1bv/B6p9KwhJFPN+dh31DPc7x3Xd86JVunJDoVe3PVNIJ6iUxEH90toY8PUL
	Aojlh2wOxkUxbA8Pah/YZuLrz0XSsEc/Kpb8Ejva5oJ9ttpc6VKj1H9ZtKdiGyGQ8q21iS3r/O1uc
	9tXWDEyg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uu5GJ-006fYm-Qm; Thu, 04 Sep 2025 10:24:07 +0200
From: Luis Henriques <luis@igalia.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,  Miklos Szeredi
 <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel-dev@igalia.com
Subject: Re: [PATCH v2] fuse: prevent possible NULL pointer dereference in
 fuse_iomap_writeback_{range,submit}()
In-Reply-To: <CAJnrk1aa97AwixCq9+eGQT52LAfqL-S1Ci5fSUygfFOo-6kMHA@mail.gmail.com>
	(Joanne Koong's message of "Wed, 3 Sep 2025 15:32:40 -0700")
References: <20250903083453.26618-1-luis@igalia.com>
	<CAJnrk1aWaZLcZkQ_OZhQd8ZfHC=ix6_TZ8ZW270PWu0418gOmA@mail.gmail.com>
	<87ikhze1ub.fsf@wotan.olymp>
	<20250903204847.GQ1587915@frogsfrogsfrogs>
	<CAJnrk1aa97AwixCq9+eGQT52LAfqL-S1Ci5fSUygfFOo-6kMHA@mail.gmail.com>
Date: Thu, 04 Sep 2025 09:24:06 +0100
Message-ID: <878qiumxqx.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Wed, Sep 03 2025, Joanne Koong wrote:

> On Wed, Sep 3, 2025 at 1:48=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:

>> ...because if someone fails to set wpc->wb_ctx, this line will crash the
>> kernel at least as much as the WARN_ON would.  IOWs, the WARN_ONs aren't
>> necessary but I don't think they hurt much.
>>
>
> Oh, I see. Actually, this explanation makes a lot of sense. When I was
> looking at the other WARN_ON usages in fuse, I noticed they were also
> used even if it's logically proven that the code path can never be
> triggered. But I guess what you're saying is that WARN_ONs in general
> should be used if it's otherwise somehow undetectable / non-obvious
> that the condition is violated? That makes sense to me, and checks out
> with the other fuse WARN_ON uses.
>
> I'm fine with just removing the WARN_ON(!data) here and below. I think
> I added some more WARN_ONs in my other fuse iomap patchset, so I'll
> remove those as well when I send out a new version.

I don't have a preference between v1 and v2 of this patch.  v1 removed the
WARNs because I don't think they are useful:

1. the assertions are never true, but
2. if they are, they are useless because we'll hit a NULL pointer
   dereference anyway.

v2 tries to fix the code assuming the assertions can be triggered.

So, yeah I'll just leave the 3 options (v1, v2, or do nothing) on the
table :-)

Cheers,
--=20
Lu=C3=ADs

