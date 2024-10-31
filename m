Return-Path: <linux-fsdevel+bounces-33382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5479B861C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 23:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E90FB21954
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 22:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4E7198E92;
	Thu, 31 Oct 2024 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QlbTAgeq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6171E481
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730413895; cv=none; b=DshFmJSH9uc9Bi5egxiYQaVYLUSt+kqmZTgSb2YFckigMz1Vl3iA3/ekypd37dyH/xID58UFbUCa8LSRhg9lFNOdS30CQBMQq8HCRsGG3+4CwyFV+Rww1zp5x92zqvmCWvFbykykgqAtYraK9UACg4TcylhAood3gnoQTfXm1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730413895; c=relaxed/simple;
	bh=cDuoc2DbnabuGy6kujaW5gQX296NQBcwojY+mB7I+qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeToh/03WYfl6+/kayOR/9WM0ZIHL58WHMTmQWxf7w66x+NWwwLzOHtiJMdBPa9vkg6lfIlQ7zK154Kq3YAs1/VQjDN6VkcnLtdileblZOXNkqKnU/DCrdHM9FFybZgkTSt5cf5g1dWo1/cbDpKp1XS4tqvlr/pCnqqLJWQSbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QlbTAgeq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso209774766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730413886; x=1731018686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aPrsbsESg6WEz1IGnWhlhy79B2qMOnvbfBQvH6axyXM=;
        b=QlbTAgeqajrDPimUKs4Ozs2XJtQxYRKdXcuGnUtJGgYF4gQ1dHdaczZvHZNJguQXVi
         DqgS2VCyq9biFuVBfoKBNNb+c1kKcuUgebJDpPSP2YR2hiE3MtCquq9Id2t6Rk5PRaho
         njxn6DWYQJwsBgZnJrg+e1AVxM+Y2V/l72OMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730413886; x=1731018686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPrsbsESg6WEz1IGnWhlhy79B2qMOnvbfBQvH6axyXM=;
        b=wdUe/hrzjpuhOScaJCutP46eoz/TipTKew6zoK64Gl5kJy8twAITlWdrNHp+gRBPfe
         qV6JiSSHG23Xqvzq9S/wpAyieF0Aexg+/ORFdgD3VGz5ApEPt8RwG7Tl3q/UuM3NfWq1
         htNhW9xOvxxyxD14TTU0lWE1Nwzui7+J4oRx/zuP1lES16NiI7WW/uop+mFzwjwp28eA
         Nq4io+njHRazTV1lIzMzf7eg7p/gzVn4duXvFxX1ng2AXT5GXagmI42TsFinBu9J+mef
         ry4bKKHwMcKmR5FSFxx3NWbLDCChLNn1FvtWaKmlQMM/28K7pKWHPLihqCLG5Q7gWKzy
         n95Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNFXh5yiJLDBfB+tDwNePT/V1C8B5OnTbMvmV31N0ToxYy49WquynOYEjrBMNGESzzgwEFy15T0hYuiMAa@vger.kernel.org
X-Gm-Message-State: AOJu0YyqBymqhZJHPfLOpHjvEJiPFHZFFweogcZy9rQDLpT0wUYP8h+d
	pdozCHOHZhycRd4T1FJATWpcyjkyt+BfbQuZk4SSNyFoIXlTp/EbpcaORVgfUowdtpEM1LygbaN
	m+68=
X-Google-Smtp-Source: AGHT+IGl8du/BVmLHuoyvAoBg+NVbTENQ2FlQwUsOahRAS1ChX+l8L7c1UvN4jFsyTU+MNqZ++e3dg==
X-Received: by 2002:a17:907:2d91:b0:a9a:80cc:c972 with SMTP id a640c23a62f3a-a9e655a8980mr144627466b.27.1730413885728;
        Thu, 31 Oct 2024 15:31:25 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56494068sm111984166b.31.2024.10.31.15.31.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 15:31:25 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so1787706a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 15:31:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqDkjdNoSSb8dsL5ykvqv8kE9v44Xhgy5ludHGbIZo9/PgT/8zUrstZWEMKvpNKgkzhGHg3rC2cT94NaDP@vger.kernel.org
X-Received: by 2002:a17:907:94ce:b0:a99:4ebc:82d4 with SMTP id
 a640c23a62f3a-a9e658bdd6bmr139492866b.55.1730413884264; Thu, 31 Oct 2024
 15:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner> <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 Oct 2024 12:31:06 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
Message-ID: <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 12:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I still get a fair number of calls to make_vfsuid() even with my patch
> - I guess I'll have to look into why. This is my regular "full build
> of an already built kernel", which I *expected* to be mainly just a
> lot of fstat() calls by 'make' which I would have thought almost
> always hit the fast case.
>
> I might have messed something up.

Added some stats, and on my load (reading email in the web browser,
some xterms and running an allmodconfig kernel build), I get about a
45% hit-rate for the fast-case: out of 44M calls to
generic_permission(), about 20M hit the fast-case path.

So it's noticeable, but not *quite* as noticeable as I would have
hoped for. I suspect there are a fair number of owner calls for write,
and then because permissions are 0644, the code actually has to check
the owner.

              Linus

