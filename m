Return-Path: <linux-fsdevel+bounces-61010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F64B5452E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514603A693B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 08:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C712BD034;
	Fri, 12 Sep 2025 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QtMGqQ5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE782DC780
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665434; cv=none; b=TLJ1DG2vvaeRoZnoiwc/+djAP64UCKjqS9XC1Pltn7MQ7PxVf3FGfdLU2uk/WKDoPJlve2pbh1O2TNKfLj0n+gwB8b1oBpDWZWlTFsq3wzGDqWB3snvNQgZ2yllBWCSDx2c1uZEaBHyVafsj77l8C2tpxVHJWwibNZ6wVQ5GdZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665434; c=relaxed/simple;
	bh=ONUk+n8LL10GLHeHPGFIXxr/Vb6xpEH57OYL/gmSgnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9ewzebN85JMgMj49ut+52/9Eqqmo3IveBkbqdPla68k8wdSEjmpysnFPzGQPENTakEnKxCcEP1VLVMz+1PCHiNt/R0LJpF2aWyKcSm1lye+K0Xb0ouSUiUsO6s2aZqGoyXjWiMwkR/YghvBF6ojXLGS42W9OmLXhD114ua8qo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QtMGqQ5y; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-81076e81a23so202729185a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1757665430; x=1758270230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dVhpMVnqHbkaxGF4PalYKy5kRXCwpWkMorLu1KxoQgY=;
        b=QtMGqQ5yvztpD3GxN1cpIkigyDt6344XrmHdXwyIrCykgOwukru+k3KzCvNylOpoNM
         2KjtqfiXXFVMgutZG1Kw1x9+vR6rBVmTDfx4jmzfw5H/PkJsfB2UQ1EfTXElz9cKYgBO
         S1/xxbBfIkNJA3ePi4wst2BtBGH5QJxaywI50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665430; x=1758270230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVhpMVnqHbkaxGF4PalYKy5kRXCwpWkMorLu1KxoQgY=;
        b=uFq5G5GLYSEjAN4hyqfczuv/h9YuO+sbGwS0x5dCo43azh4Yqky7aSOW30GuQ34tEQ
         csYfJK2uCD/0zifsazrzDz70JSQuVtx6qEZMner1upOue8tCgnY2BY2HoScuiyQCk9Oi
         GSObp1L0YWYVS8VCNyq6oUOwsSgG40rLEkrbDv8Z9Qdxm0sS8vyD4uAWzQfOmtinxSoA
         AfXmtQmTLmv9FVZirEYu94/mD0Y1w0pBPkExCTYYT+7r/Mzh9piKkzyHcKNUpBC8V3zE
         s5quWv5sPyuhhKLnES/3OjTkV3tUGYPVnXSwWw/78gmLdP/hgnJ62sRbKTusWZwO3oOW
         tRPg==
X-Forwarded-Encrypted: i=1; AJvYcCVb72Cp23JYE2QbVyFPQgxVGh4GhU/0LfHMUKqExYSghEWUeR12t+lsRmGWW8uclqzrbl/exyikvjEEdVfl@vger.kernel.org
X-Gm-Message-State: AOJu0YxTwRR2wRDgv95rlQKTJbf7LUN8dpMvQ7VQyKCoscEIL2AIwzKX
	FIDuYfvAnQVAHqyKwyawwpCTXhgukrOX1iZtE/9BGTawmhIMqDda3nzn8XwLJfExxDle0Viu+wn
	/Kpx4LWbWlvqc4vGUbxz4mGe0NkJXEFLY0OAuGlrtiC4LYaYBd1BQ6fc=
X-Gm-Gg: ASbGnctv92QUVRFtdtPCJOIH98hDuS/sOSo2Bwod7LES5o0Nd76FJVk43iK8t80E2FK
	LgLj/syLfhEPQZY14uqYI6TdW6LzLrHk7FbXbVtVgts4newIk4Kx1qH+w2GrzuX6SACniDO3MPz
	56J/wENadk40cTaI66NesNo8ncDMRGiuqH/Zvv99LqJ9spTVQfdMjiaAZPel/8HC66jhoxHqqzV
	O0IWE/Qsajq8ev0HQbT6ZTPuO03isR8K3o7Mk6F7LRNAOnQpcQp
X-Google-Smtp-Source: AGHT+IE/BR3JR1Svg+GWo5ExJEPr/5pbYF607q1pAEOOGEKn0/y68xI+ObX8iLpJanRCdDP7T56jcWSkefNiJXzNPbw=
X-Received: by 2002:a05:620a:4045:b0:80b:7801:dd98 with SMTP id
 af79cd13be357-82401a96aaamr245759985a.84.1757665430339; Fri, 12 Sep 2025
 01:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908090557.GJ31600@ZenIV> <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
 <20250910072423.GR31600@ZenIV> <20250912054907.GA2537338@ZenIV>
In-Reply-To: <20250912054907.GA2537338@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 12 Sep 2025 10:23:39 +0200
X-Gm-Features: Ac12FXzguuNRuC8K-EsP_vgR5gJIzJK93avDqmTFb2tnWT5YxyYlJVcUfByLBPk
Message-ID: <CAJfpeguqygkT0UsoSLrsSMod61goDoU6b3Bj2AGT6eYBcW8-ZQ@mail.gmail.com>
Subject: Re: ->atomic_open() fun (was Re: [RFC] a possible way of reducing the
 PITA of ->d_name audits)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 07:49, Al Viro <viro@zeniv.linux.org.uk> wrote:
> While we are at it, Miklos mentioned some plans for changing ->atomic_open()
> calling conventions.  Might be a good time to revisit that...  Miklos,
> could you give a braindump on those plans?

[Cc: Bernd]

What we want is ->atomic_open() being able to do an atomic revalidate
+ open (cached positive) case.  This is the only case currently that
can't be done with a single ATOMIC_OPEN request but needs two
roundtrips to the server.

The ->atomic_open() interface shouldn't need any changes, since it's
already allowed to use a different dentry from the supplied one.

Based on (flags & LOOKUP_OPEN) ->revalidate() needs to tell the caller
that it's expecting the subsequent ->atomic_open() call to do the
actual revalidation.  The proposed interface for that was to add a
D_REVALIDATE_ATOMIC =  2 constant to use as a return value in this
case.

Thanks,
Miklos

