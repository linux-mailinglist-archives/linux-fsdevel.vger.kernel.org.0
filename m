Return-Path: <linux-fsdevel+bounces-38557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F55CA03D1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 11:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE493A02C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 10:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A671E47C8;
	Tue,  7 Jan 2025 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JDaiiKuo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A978A1E0DE5
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736247531; cv=none; b=HgAEFAoLdyWm1eFcMNswKfTVVbfqWkfzkoCa+Pqm7TG+bOk0HB6eXOYpNSHvYuT32dN91yz9amJDLBgG00lJHAkHCa51TddNBK4wfU8Lkm5PUieneNg1GN6mFXO7J1lVWev59EpyLR5kpBFO8Q7uGubx4MgYCRlCkh1PAdjgVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736247531; c=relaxed/simple;
	bh=r9cba/X2LZ+xXzIfLu11VdFcsGQUaqpTLxJ+TPcAd0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHttpOHS8c2E9IFkLlbloLx0NKLj+abELuNA3+Im7WfBcORADAOmsfbSmJZnaUaiKNC8lZeZr7ACN2489hndRoESo1naAxhaEZYBK3Ye0n5EEvZ+psAGNPpy8GVjH4kjxvvxlW0sLolxUh3RYQ7INSgSLsqZ6FeCkkMFv96Scgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JDaiiKuo; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf8f0ea963so17011566b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2025 02:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1736247528; x=1736852328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9cba/X2LZ+xXzIfLu11VdFcsGQUaqpTLxJ+TPcAd0U=;
        b=JDaiiKuoEelj/wmzgsTFui/5L8T5ICx3rdx3iW2fQPSSa7HW7hTp2S9a8kpZnFWJcq
         IIAJRjsEEtOToWny0BMfGb4xKfLWIODHpqaAj775aXgBaiPr/gxxbUSeH6f77s4hUfN/
         d/x8u2dWD0F9yThZmnQMR5gt2m8vbQkxLXkyK+SRRml6n0qe5JdLY+AK7/ilBquaiAwn
         hMc5E8bKAC8/Ks1HJK+fTEcPSHg883pg89YMknsqSgaZD1jLkFWQb/FeB0WdXZON3Q8l
         6lGgUjiwfr7kPQKDk/jGILrcvkDZHGfDbP0VVQBvoHLx9bHC4D7dEpFmMD/noRGfJzkm
         uIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736247528; x=1736852328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9cba/X2LZ+xXzIfLu11VdFcsGQUaqpTLxJ+TPcAd0U=;
        b=UYC8ddZyBlM3vWimIy2+pHSUlPRKkNZnjtMDdPYaOkO+zOPI0jaLnVzQxODi1sNTf5
         boEx1/P/UAQidccCkKEj5AA/CSjGiy3/xDCoJgPMSDg5yuQG+rxbnjg8MA1RecLhiXlq
         gIrXm/RVrd8TZJRyhCPMV2tzqE6jhiNoOsLQLK16lS0GUjgUzJtcteLsRlFVCQwBbdVH
         yb6AqzCe5aeN7UF5tlGdZciFM4zjwM0fKCXf7R0qD9LowQWn2mZN0750An4+OYqsOTRj
         aVa/E1JOihphjBTIjQnsq92/tYwvabqdLG8UPMg3rcLKIZUxyzOBubGlc5CO3O/+gqaJ
         fWDw==
X-Forwarded-Encrypted: i=1; AJvYcCWMPNU48hMvHhAv2CYSTHBdsvouaE3j0j9kDgsYMifxCvjlB12wNnDHkfG55fs4M5waBAFb6Qtouqqa/din@vger.kernel.org
X-Gm-Message-State: AOJu0YybdX7BBYx0lyxmYrzAPYFSLuKuRt54NJdaTKVhnmmBxV6IPMCs
	UnEJ0wHCSkeg1jFRkOVll6zlQ1vGzRxfADF6+6aMoqZqmin2jdVuh+RsvDwJV5b74Nuu6jBBXkX
	tUfI/DUd4N9x20WEoHFzjZrDvkm84M4lJhnW9Kw==
X-Gm-Gg: ASbGncu2TRtRtXnyb8KX6L52y5zXt86qmDSGMBw+vPfnFghVvUvRfS8dMLPQU0mbSO8
	TEJsrzuCDTFFTdZn9oVhvw5UUWWQdhVsT00ZAak5nIVbydV3ym+yxv2QwbsmFAc7+Kvs=
X-Google-Smtp-Source: AGHT+IETZOmNG/e0pTEpYkVhrwGsLepWld2hp3oIZEoqxA3MiEDxyRVbckh1TvXsfUQviSS2Bg03tqiW0zDp2s9kgt8=
X-Received: by 2002:a17:907:1c10:b0:aab:eefd:4ceb with SMTP id
 a640c23a62f3a-aac27025de5mr5732340766b.10.1736247528011; Tue, 07 Jan 2025
 02:58:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk> <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
 <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com>
 <CAKPOu+_OamJ-0wsJB3GOYu5v76ZwFr+N2L92dYH6NLBzzhDfOQ@mail.gmail.com>
 <1995560.1733519609@warthog.procyon.org.uk> <CAKPOu+8a6EW_Ao65+aK-0ougWEzy_0yuwf3Dit89LuU8vEsJ2Q@mail.gmail.com>
 <CAKPOu+-h2B0mw0k_XiHJ1u69draDLTLqJhRmr3ksk2-ozzXiTg@mail.gmail.com>
 <2117977.1733750054@warthog.procyon.org.uk> <CAKPOu+-Bpds7-Ocb-tBMs1==YzVhhx01+FaiokiGR3A-W9t_gQ@mail.gmail.com>
 <2787700.1734019232@warthog.procyon.org.uk>
In-Reply-To: <2787700.1734019232@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 7 Jan 2025 11:58:37 +0100
Message-ID: <CAKPOu+-O4NVRO-oEsSv_GG__q5tdC-X8zPUnLkJ+9iDaVp_UyA@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix ceph copy to cache on write-begin
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:00=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> How about if you add the attached?

Still no change, first try led to hang, as always.

(Sorry for the late reply, I was offline on vacation)

