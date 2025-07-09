Return-Path: <linux-fsdevel+bounces-54347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3803AFE5B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 12:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3E97B97FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201528C862;
	Wed,  9 Jul 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="D1JWyogI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF428BAB1
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056792; cv=none; b=O7FDQjavfhJG7N+0lTtaFhYiXCI85i+ogGOlBpG2Tqvu1xbB9Ef/QE/9BCleQAB4mth4nz/JAV656XAq2nkmouGtrpYwoIh3/J6awfXW4PYugjEcqVtgKHDpcQDuA/8vnig5/+s3HqNOcEeOe1humg89gr0fFm6Im6PhCkwQRGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056792; c=relaxed/simple;
	bh=wbnVGbjHNz2co8d+fXBHn4JejafVFSAL2G4zjFDrvs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egWx+lpa3/lMltN1kQslpTi/BvR6L0sxfMp73tjXDjJ13RTsTpaCvKlJLnhlCX26aicUp2u5JwR1suoHzCmbd4sWlzV62TYPAfvIF+GyApJKcKttsxK85qWZxfpCREEOoz8wTYjYVru4PD8x1T7Te+lNzknYoWQmZ9/0L/HTr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=D1JWyogI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-acb5ec407b1so936917966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 03:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752056788; x=1752661588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q7WBoHo27tCDa77Ry5M8MzBflIzY6f9OMpHwiXcLHSs=;
        b=D1JWyogIFCQUnqEHsgjBo5v8xFFmdw5nxvVF5+3jX7gn+gUeOqTuFIeiKGdQrPcuOe
         M4yWynuUfuCTAH6wUj4MplmTKljf3gHKXGf5xfcILfPbR3pFLhuFmcHc96MVKzh8NgV7
         aCT5PhNylYrNh35vuWZlau4iA0PQuT8a3ep3zn67Y6EUw3Iw80wrBCmMxtpAKaAvi0wf
         AdaERMFYNNo2PU9A1D8OA2KB+ZWwEwkSETbmCrFxUq1+GUwplKL3RB2p7bjd8t3u7zyM
         u3ahRHR1TCPLt5wdiucAaBLkAf47HkvJYZJVDlhCBoyY4Oyq/P8dK9RL9f3Qpa21B3jD
         g7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752056788; x=1752661588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7WBoHo27tCDa77Ry5M8MzBflIzY6f9OMpHwiXcLHSs=;
        b=GQOgr16Ru8pEkRncRQYiCmBIKOONNzHQDK8qxQJmnEqignR5/asbToirdcTegrD3sj
         G/6FDo46uymchqJAZblANIHDWhWK3vmQ6OHVHe4CdXOGUCuUa3vkBwcGQFISx2/YKWZa
         /8nw64DyIcENJHlrCHzcmD60kSndRsx7tR7PNU2G73D7cjXvZitBJ+T4itxg+GL/NicF
         mNycZNEczE+N8wx4Y0EVApN0xSm56UJ6B98l8lS/s2gGnuRCUjIa3q6ez+/Aafv+HHFC
         /BPNb7+mamuvkr9/TcdMZzXBU1mpcaYCey0v1RrxknZbM8h3bdSVErX6tUEV0pxUe94u
         4HAA==
X-Forwarded-Encrypted: i=1; AJvYcCUV2Meg/XQtFbvpro1dNU0nQlfJ64hRB12qB5O/JkjVcElhSsl72bcw/8F+UadYLmWCXoTHeqaz5oYW1yfd@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHzOI+ZCck4fwxqwzwGuqnbvByGHK/SALnMRle47y0UT2pQGt
	nsGyyJEKpom9drJQ/2h83DIk7ZLdiEjtPisAHLzNy7o90sax1/Mr+A6IEgEqKFmE+44BuOY4aI3
	gH7Q5sOJxKOTOQ5oh3PkcdNP/mVYe0n46nYG7zCPKSw==
X-Gm-Gg: ASbGncvzAJCpkMp2yX9SAlDdDbAfBRSBx5NG4vDWOY9m06ogGhZv8DF4QpNN7tD/PZo
	cM9f3dLxmlC3sNLTL6CRWPGlpya0LO5j24O7W+/7IQ37g43mGlMFqd9JIfHNRJTUwd+6XI5Wa8Q
	1p+BleiQxLUsAPJZna5AtXk6qouB1IzTeLQjCC83nSBS3rUCD/LIW4SZWSXLl3KNNYc/AZfp+Ae
	oQev1Osrg==
X-Google-Smtp-Source: AGHT+IGbqwygDCctWSd13zB7txA8nj1LhT4JGyQ85VQ1ULmFhI635wDH8IR1PaEr0MvmBrrgrCIFH+uxlqg39uXxl9g=
X-Received: by 2002:a17:907:1c15:b0:ae0:bdc2:9957 with SMTP id
 a640c23a62f3a-ae6cfbd985amr185279366b.61.1752056788493; Wed, 09 Jul 2025
 03:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com>
In-Reply-To: <20250701163852.2171681-1-dhowells@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Jul 2025 12:26:17 +0200
X-Gm-Features: Ac12FXwp4fbGLXVwqf6tAOr1y42YQrXGTBI6Q0Kfy3_DmIljAuOKBpuGHKZXSZ0
Message-ID: <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

David Howells <dhowells@redhat.com> wrote:
> Here are some miscellaneous fixes and changes for netfslib and cifs, if you
> could consider pulling them.  All the bugs fixed were observed in cifs, so
> they should probably go through the cifs tree unless Christian would much
> prefer for them to go through the VFS tree.

Hi David,

your commit 2b1424cd131c ("netfs: Fix wait/wake to be consistent about
the waitqueue used") has given me serious headaches; it has caused
outages in our web hosting clusters (yet again - all Linux versions
since 6.9 had serious netfs regressions). Your patch was backported to
6.15 as commit 329ba1cb402a in 6.15.3 (why oh why??), and therefore
the bugs it has caused will be "available" to all Linux stable users.

The problem we had is that writing to certain files never finishes. It
looks like it has to do with the cachefiles subrequest never reporting
completion. (We use Ceph with cachefiles)

I have tried applying the fixes in this pull request, which sounded
promising, but the problem is still there. The only thing that helps
is reverting 2b1424cd131c completely - everything is fine with 6.15.5
plus the revert.

What do you need from me in order to analyze the bug?

Max

