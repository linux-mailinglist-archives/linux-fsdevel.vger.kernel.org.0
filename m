Return-Path: <linux-fsdevel+bounces-41515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E12A30BC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 13:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF02B165F00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 12:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05391FCFE5;
	Tue, 11 Feb 2025 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dLUnV9Fw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955EC1E5B8D
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739277267; cv=none; b=odraAxN/s8FbENojCQw8r4O5IWS7+kw+e0Q+uTg9xzgizZ7lriMOjCcm4o+8b8dvILXe8TAUMfaxtF0pFER5bNRFxi/17Y98BptLo0OelZwu+j7QbwfZkNkKSrgWvIiQMwZWhFStAEBemLQaDvJhZC4cNEndCJqQGJ4xyxO5xtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739277267; c=relaxed/simple;
	bh=1GMpC8GzPN7He92KH3FqGLSxjeb+6D0O/Fw9gYQLRf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdJI7zzHulaKc6mH+n1aAC3i3diM4+2YuRP1XWrUlDZ1YXct/Zk2lwfva50d7HEsIs03X+32IhCSKNk6dgyMtCosVQjkGJ3OcBFtt9EM5yPxcobKlGPIjFQd9lhNtT8wZKGSGo6m/SaaOQocF3t7zQKrv8qhPAhHcW2aPq2LRxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dLUnV9Fw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-471a25753a4so6857581cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 04:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739277264; x=1739882064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wumgzwh+yCJeJjW9Ubiwef4L4mKQ4r1o+D6YExE/ZAM=;
        b=dLUnV9Fwz6finpM1PAlddHmMxHX/GSUllcTEtscPiMrD7IeXaKGXxvrj3DI38hYQsr
         LmD7s8ucVkhKMO7mCA8SAcRH7TRtWOcQ8nbhgu29bsvHaHL8LjTiJaAyqlB6vR+F95Xv
         +XXMJMwsaq2anCuDTG292ndCAdY65cVryEZzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739277264; x=1739882064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wumgzwh+yCJeJjW9Ubiwef4L4mKQ4r1o+D6YExE/ZAM=;
        b=OaDF9W0uh3COuIByCLmE5m7zFCTz+JN1HclKEjwtBWjy6Bgc3yV9LVpRhI3DI32Ulm
         Pbv2SWSA3FaQgrWgyFIFY8E7UzpeC4odiQlW62HCdQcS/ZkKnVAqiiTzWpLzyNqLK6sI
         qeUBjNvPIwVdbxKs0fOoahM5so9WVr/sIxOIxpUbTpfZpypCdY1nJl48+SvLEYySdxCx
         YCPpVCBLMwH1C3YDeR9XXVhEOE7dmEZjFOKrwivYNJrJqqZ1T2+8ceJDWEePdX+9k41b
         ZsBDuw5ZOIgU3P8JhXb0KxJtUyPhJ1Y/Ez/i7ipI4KhjCqLPeThRK35ZLxQuasrUJHq1
         sBgg==
X-Forwarded-Encrypted: i=1; AJvYcCUATB0R0QVdu6zRX0HKyOzploFY3hjvrmL38Vs30zgR0XLiBOrq0rX0yR9BKo7vIOEjRzvG06Oz/bjlCASU@vger.kernel.org
X-Gm-Message-State: AOJu0YxvT15PW5g4UgH9vQ+ihEiuIq7NP8EvCcdvFG75mLvLUvhWU12F
	2SKswSIEwOLqSz/SXd2AThXnbyPclmhj8VLJ1Td8r+yLT8SHWsJAA7EpPUI2XQoxs71hF8896SD
	x7gjM6bzTIHo4DVv80HImTzQERg19E3d07mSwMA==
X-Gm-Gg: ASbGncvoOTG6mxKNSaPPxaQiheG6FLbf+36+mTKY7UyO2JXQdIeqIXgYqgEabPEkwKC
	HiadhsHs9oqMOJ++OBFpTLx67oqdTBh0UrwBTJzaMBLQWW/FY3zL1NlSgf57X/wPAUsA+6g==
X-Google-Smtp-Source: AGHT+IHozEj9gx89foscCa7JXUMl12FuGx+Az1IuaZwmHCkw+oG4JmiEFd4xJmOVYC0MTBAfFa3t6L6/hbTtBALPdo0=
X-Received: by 2002:a05:622a:cc:b0:471:9016:71f6 with SMTP id
 d75a77b69052e-471a070eeddmr54508521cf.38.1739277264462; Tue, 11 Feb 2025
 04:34:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-3-mszeredi@redhat.com>
 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
 <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com> <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Feb 2025 13:34:13 +0100
X-Gm-Features: AWEUYZmtDkURhfMAUEr39zOqPbJ0A7HA5QI3PQUEOtK2gQ2uHWdo4gsFv9jvmnY
Message-ID: <CAJfpegsuN+C4YiA9PAuY3+-BJ959aSAaXTYBwKNCjEnhXVw0pg@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 13:01, Amir Goldstein <amir73il@gmail.com> wrote:

> Really? I looked at the next patch before suggesting this
> I did not see the breakage. Can you point it out?

When lookup "falls off" of the normal lower layers while in metacopy
mode with an absolute redirect, then it jumps to the data-only layers.
The above suggestion imitates this falling off when it's really a
permission problem, which would result in weird behavior, AFAICS.

> BTW, this patch is adding consistency to following upperredirect
> but the case of upperredirect and uppermetacopy read from
> index still does not check metacopy/redirect config.

True.  Also that case should probably "loop back" to verifying that
the redirection indeed results in the same origin as pointed to by the
index, right?

> Looking closer at ovl_maybe_validate_verity(), it's actually
> worse - if you create an upper without metacopy above
> a lower with metacopy, ovl_validate_verity() will only check
> the metacopy xattr on metapath, which is the uppermost
> and find no md5digest, so create an upper above a metacopy
> lower is a way to avert verity check.

I need to dig into how verity is supposed to work as I'm not seeing it
clearly yet...

> So I think lookup code needs to disallow finding metacopy
> in middle layer and need to enforce that also when upper is found
> via index.

That's the hard link case.  I.e. with metacopy=on,index=on it's
possible that one link is metacopyied up, and the other one is then
found through the index.  Metacopy *should* work in this case, no?

Thanks,
Miklos

