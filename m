Return-Path: <linux-fsdevel+bounces-57660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1702BB24436
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 10:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10224723FFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 08:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789A32ED166;
	Wed, 13 Aug 2025 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="aXsACMBc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C632ECD3C
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073255; cv=none; b=pYlgxV23s9Kl/X2bz2/8f9iot5OvDaMiGQT2MyyNLaQPUqEoKQEszXKUnQ4ZxZAvpr1RoxiQDAQAlmuF19Rks+FurFMi6Ts8ULvVGMCyag+LOBZdskHrYsI9bRA+wQCmiG1D5kb+wjceGyu/pdE29o9c/jWGySVnNZlNsowJfXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073255; c=relaxed/simple;
	bh=ZNQFTDprp4cvbhOAT512gDLXwnDCHb40xe7qVQe49to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKVdmOhecLavmIXe3ZLydKR3zEnH9BXVhwzjAfYGqMKZQYvkpdWKB4KgcAwTuKheAq12ZftbVayucuuGIM/tHxFF9toV07jB9bATjnp6HsxZQQWF46bcjCkfg4hSqxaxVZM8A44eYDEJ7sNR99mCbNt4JCBQIWnBD16AwlG8j4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=aXsACMBc; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b07275e0a4so80646791cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755073252; x=1755678052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9BkNwezE4A0GqCcdJ53HeSdL7UTHSte8nreLbwfKhlk=;
        b=aXsACMBc83uNbS12IvzIv5UGJXAe83l0TAfVDW3j5j3gxSKRUSOHDP+nAT7y+nSHgC
         dqCmJ8uWgQ3LBgPob9pC4k74fOHYv9HAGjbrw2TDcMkJi0i4Rx1p6KslzBbIqzRJJbUW
         omZS3w2q8+Wtmt6bcsQdO4qSMal/FwRCrtL4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755073252; x=1755678052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BkNwezE4A0GqCcdJ53HeSdL7UTHSte8nreLbwfKhlk=;
        b=Tq++CF4wDmPwskNwpYZB+nV29jUgkLWR0OWd75ZwbdtncQo05uDGKBIM/0LU5ABMVd
         8ZDeewyp8QF++EKanx8zesojwmezQy7sVTtrmvhWq6Du92yaIgDsuTeqycUG14PYp5qU
         RLuxDkH9QKwuwEgOMkoHpfxUNckuDYcvy9OHBGPs6M4JkjA7/dcaxbPUH0vGaMqNcjjj
         C+z4eATyCBqOs+DKVE4M1OaiEmON5QPKyOBdnrP31LtY15K0I1a2Xvwbg2SXhB51Ddx4
         +IUGpBAxlchMFDufY16HNMasjgAgeVFa5u5uJErpmCatQSdMfNZmzKg8F4xAqtNBKBoj
         7u0g==
X-Forwarded-Encrypted: i=1; AJvYcCVD8SbBcA4LcVInTkpDnjEBiz+af4av71jMraPFlM37OyYrPhgP4JlzjJBPTn/RVuHIXbIQDOONfIBA/IIB@vger.kernel.org
X-Gm-Message-State: AOJu0YyCiH3GKY/5l90DBYD5EvJeBs08IOGMmC9J8lFRf3sHqGq8D5CL
	V4NLZ6KcTJgu0VNAN4G1zgOZm2fwresV31CekqsBmF+ilxexY7VjOrIusNDDJeu4FCoIdXbd4SE
	9sroUYTloYTySLDjh9euCOLME946XgFW2ANx2rUauRA==
X-Gm-Gg: ASbGnctAPnEH++Y6Yw/DF4b6G23Rvk5gzJOqQxjrEBTgPbKs4WuAZyiUgeTnjGJRQIN
	dJ2cv2UhknTItN4zREzdzkPHGhrGriZRf1aG0xkDt4hN0uaxrnR8962eLXSJF5+cHG/kv5E6u5Z
	IzWW/h0KEgnxUNrWwyB3dIMyaTqkwYxa2DWUXU5bZfn2RJeaPoWJwMDBDXFQMzdTSOpuYtWqhnS
	gBq
X-Google-Smtp-Source: AGHT+IFEvwNI0gbGHjk/iFRG6QG6Y5LyDWIvew2hCmkW3GH1Xa54pDHLV3Gmkwi1xiI7BWK3SD7BYdR4dpWiY2Xycrk=
X-Received: by 2002:a05:622a:5e12:b0:4b0:dedc:1176 with SMTP id
 d75a77b69052e-4b0fc86076dmr24179581cf.49.1755073251642; Wed, 13 Aug 2025
 01:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811204008.3269665-1-joannelkoong@gmail.com>
 <CAJnrk1ZLxmgGerHrjqeK-srL7RtRhiiwfvaOc75UBpRuvatcNw@mail.gmail.com>
 <CAJfpegs_BH6GFdKuAFbtt2Z6c0SGEVnQnqMX0or9Ps1cO3j+LA@mail.gmail.com>
 <20250812193842.GJ7942@frogsfrogsfrogs> <CAJnrk1Y27jYLxORfTaVWvMxH1h2-TrpxrexxxqawSK1rOzdrYg@mail.gmail.com>
In-Reply-To: <CAJnrk1Y27jYLxORfTaVWvMxH1h2-TrpxrexxxqawSK1rOzdrYg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Aug 2025 10:20:40 +0200
X-Gm-Features: Ac12FXzy3-raVYwMJMZNmeltdPpHh0bfMgyI7Z4ih9tPcvfOMvP7encLeCEubwo
Message-ID: <CAJfpeguPhzQptvGmxzqxxJX8g5A1TNBiUp5UQDSwkhg-jU=Bpw@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, bernd.schubert@fastmail.fm, willy@infradead.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 01:02, Joanne Koong <joannelkoong@gmail.com> wrote:

> My understanding of strictlimit is that it's a way of preventing
> non-trusted filesystems from dirtying too many pages too quickly and
> thus taking up too much bandwidth. It imposes stricter / more
> conservative limits on how many pages a filesystem can dirty before it
> gets forcibly throttled (the bulk of the logic happens in
> balance_dirty_pages()). This is needed for fuse because fuse servers
> may be unprivileged and malicious or buggy. The feature was introduced
> in commit 5a53748568f7 ("mm/page-writeback.c: add strictlimit

Hmm, the commit message says that temp pages were causing the issues
that strictlimit is solving.  So maybe now that temp pages are gone,
strictlimit can also be removed?

Thanks,
Miklos

