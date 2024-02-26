Return-Path: <linux-fsdevel+bounces-12819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E1D867762
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 14:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2767E1F289DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB511292FF;
	Mon, 26 Feb 2024 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO1Bkx6Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65B128363
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955839; cv=none; b=efjXvA+I1krBxIT6dhfzv2RwSTvtI7gXX+ga27SHbovyUgj5feFjhvsbGJIX/ipPlm7Vej/sHQkhksH/uxaeWdgtGN+zMAmk9tGy4T/u59OejQPk5lh1LEUE5MIGuiGP2c0CYVVZKXx7CmDEnPmrDWtAMz+rE1k6xTgXVUILLk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955839; c=relaxed/simple;
	bh=9wI9c7a/f2/wOVyOUxJJiWp617ttV+LbNc1EnySHGKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUzTPaCEfaM4ZajZwn3mt4TAuWmoioWVwqHAu+DUt+lVRcDvWn1gL9SvS8fnH+2p6zNf/lpfvS3l+n2nFxxsfxRUY5FOIWlP1dHW6oHfwzDTlgkBNTsvpVZ1O03lRVnCi/lKG4gIfXFiQEUHK4fUfgYM+Jdj0U4sK0U8MRMZx0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO1Bkx6Q; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c199237eaeso1504113b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 05:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708955836; x=1709560636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qC451XfJl7DfgQqR5U2znK3IUgGVHljKK8SbXgGF/nA=;
        b=bO1Bkx6Q+BogIi8lQukbjSuA6OwIg/ob+fcYbNog0/6BbhUz5aB/YBG7auuMUvMCXO
         8jR0cj6ruIN96s/EYRrIFo/5i8Dccb4XaOBvGOHiJKVrTULd7GrXdXTy24yVXq2zQPdq
         G2EQw+sp2EKGN4Q1XJBVVFOGvhqNTIDOwUQ7/lCla5AR7uZjsAV/pGVG3hCAB2WDVMdV
         tOCavFyk7F1J2bqalHKeFXyMe8awQf+BXXM6tX78KxSABq1XCPY/OfN1OFRQcw3Ga0DB
         1N+CbQXaPfcldIDpX6ElU7dTK8kaxWdSSamVgg3epdhqUGHT5lnjhRaxsIvssbBqwEyI
         unGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708955836; x=1709560636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qC451XfJl7DfgQqR5U2znK3IUgGVHljKK8SbXgGF/nA=;
        b=VTSE19F20HcVm9Pp24ZQQCJwKVYeH0kfMOCHdaonvOT4jXlY+tGyjzVGgFm38rzk9v
         88EOARQRlO//Vhp5ksUG0yr3XAHllSzE72i/2rO8rBLNU9Q2Y9LNsQHEh56eLxM5q1l8
         PKQjqWM0P0Csg7z+dqKhoXBHjiXOE1UaylBeDpi8+howZWjJGm3D01Ieh64L6h3pJRL2
         F3zoSD7aD8F9Ix3wRpRApE5hxkoi3HE5Gl7PoY2B4lG3Q/qY5M2lQ3Rc4kD3R3fdMD9K
         wAaWXL5SN24lUKqQe2LyagK2BSgx4LnhndgL6egGoj4vbfxqq3rf+y60+H8Gqt5ecti6
         Jbig==
X-Forwarded-Encrypted: i=1; AJvYcCXioPIacTkJ1rsN5YzVrw9jRlp9JltZ1ydH1Zrpq9jSnI1i6rCHY3SXbkCjgW5l4MJyXvugOVtM0/g/YWRD22yvXwYh/ygT6th0etvneA==
X-Gm-Message-State: AOJu0YyUjfatYhe7D9y8J0JCFO5oW2Zs8xriFGCgN7dHQ8uJCllesMqg
	77K2UDBYNANeL2pl3+IJKpAPPHkOmvcZvsVx7no2wTSb7l2rF4jDHL0+Mc/OfNV9igFe//6qmW5
	QweyujFe/bfgd0W3NbRTLq1ErYfjARPBmS0eyP4cgBPE=
X-Google-Smtp-Source: AGHT+IEb4olJlN3OryR6Ex8+sM35mLGt60RHqCeCdEOTSqfJIPl0G8NxRtFP6YAVMJ/L+CJCz+Dt6hYZdHe8e9IyDBU=
X-Received: by 2002:a05:6808:988:b0:3c1:381a:f89c with SMTP id
 a8-20020a056808098800b003c1381af89cmr7161468oic.43.1708955836299; Mon, 26 Feb
 2024 05:57:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225114204.50459-1-laoar.shao@gmail.com> <ZdwQ0JXPG4aFHxeg@casper.infradead.org>
 <CALOAHbCaBkqZ1Z9WJ_FqjTkzvCOv2X0iBv9D=M2hkuEO4-8AeQ@mail.gmail.com> <ZdyPPiEykhffDEJZ@casper.infradead.org>
In-Reply-To: <ZdyPPiEykhffDEJZ@casper.infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 26 Feb 2024 21:56:39 +0800
Message-ID: <CALOAHbB2UiZ_XCPzhsHJF1HqOcDPjoJi+bA9yi7MnAgdEvNkUA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Add reclaim type to memory.reclaim
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeelb@google.com, muchun.song@linux.dev, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 9:16=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Feb 26, 2024 at 08:34:07PM +0800, Yafang Shao wrote:
> > Additionally, since this patch offers a straightforward solution to
> > address the issue in container environments, would it be feasible to
> > apply this patch initially?
>
> There are lot sof other problems with this patch, but since I disagree
> with the idea of this patch, I didn't enumerate them.

Could you please provide an enumeration of the issues you've
identified?  One issue is that the reclaimed bytes may not be optimal
for slab shrinking, particularly because many dentries are freed
deferredly.

--=20
Regards
Yafang

