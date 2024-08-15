Return-Path: <linux-fsdevel+bounces-26026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D568952985
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 08:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EC91C21270
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 06:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A6C179647;
	Thu, 15 Aug 2024 06:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="astfi1z0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A67178CCA
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704717; cv=none; b=kgpFttNiCefq8cb4dM5RAv0vnYHXCX+q1YsTlhMfBrszFWxjRCUOC0X1FBUgu9arFmVj2cgH1iq1S1lsXbve2JG6cQUZ5o4XTgEbGrcZGiK96PdEztg1k2rUKxQld3MPgOXToAulSXPCQDkQy6TEaYErnrNK06eLKuhtoerpvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704717; c=relaxed/simple;
	bh=0O376AmDTnIhu2XjAYJviAVcadzxWHvjZloZj40UMts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4vnQFWc89emVpCZ8+le6jZb7wJ/4Ui8yqZ8R896n1pQujL+3ecCBsL+5a8T1rX8sv9GHScDJsg/hvMWHcSzD+/RWUtqrIyLtzyIgY14aBGubeBfPT48jlYv+pm4oxEoDzsb6L/72Ze3SlrNak8d6x9LZdRCQOfzx28lcdFdC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=astfi1z0; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52fc4388a64so813993e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 23:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723704713; x=1724309513; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JmIL7LdkrSJnWarm/Yb09EWfXk7ckLUYXr1SgfRr1lI=;
        b=astfi1z0oGxDQycX7mTE/MTeRe8gyI25bPMNcUfZISY5JqHlusEk74dxu73Gaa4oUr
         13Ym21xwhjYhT5YBf1BBHhbWodGVbgp9jUo6C+lM0fSrXudmS6TOz+Yo0L+F1KWzTCyM
         GpP63/0Wi/0As005HPI3M81fkr5FQMEax6pzfZxh0TJ6q8OSJ+dDoYGLY1PRjQ27aTUH
         UIEtPLGTektFYtczZCdIq1hWPicRMiV1pyor1TLPp4XnLlmYBJ2Jq5JvagTe39wtziJT
         azOaFFwcd/Ws+UJbM6OhwiEHxoLXUul89uV7RmeV/UfEKQ2oREULfU2Ty+dOQLppPgxh
         Rr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723704713; x=1724309513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JmIL7LdkrSJnWarm/Yb09EWfXk7ckLUYXr1SgfRr1lI=;
        b=oycDoye98VA7Tkzu8wHFPhwlh4YXJkFjKYZPtD1p83bMwpjY6Yfd29Ls8rTlEyAya9
         ztCWPWsEaAmfiiBmRtFwhUaAAZ8r11k/c1iKYX4iN7OfULXsD/xjF5fNwyTQMpY4BdRx
         kLv1QhEaj4rKvAceu6Q8Q7TFIdzjADJOCRe2AgSOvaQpMrbheIEuN9gNelX4+IQY1zQD
         ZjNsxslI+BBJ6Ffvk3jsHF6M+nBvCEs6FIUi9yu5ZhMM0SO3aFqwX7Tot6e0Dly/+gpJ
         SgLsetrROT1Oh8K/KXy8eTRapyRrH+Dw4w7TXb3fa9mMMJTSVwwSNjtuLiEGechUvk83
         1Xdg==
X-Forwarded-Encrypted: i=1; AJvYcCUbYrd+qIXwtCD11trqcPsRhDWu45G7qju3CU7nKw/5c4Otg3Nd5mlHKJht6y76l6nQijp4PfxPNjyH8c0uWncclrWmbJikr1TkRjTb5Q==
X-Gm-Message-State: AOJu0Yx6PZQwjJC9/MDKfDrTHpxQH2nPNDJhfQ6C6Fw20iVx+PpWXH4r
	1HVFVXVZCwHiUT9MXPdtzznMPhl1Kg46gEA1ywF3NnhWgIgJfbnYBBI5SqVTpa0=
X-Google-Smtp-Source: AGHT+IFwhq19K7ukguDKaa6fCaMlS2KrVMj1ZwOSqmmgXzCAC6R6TyEqxonkvPUbLbchw0OeA40EVw==
X-Received: by 2002:a05:6512:318a:b0:52e:9905:eb98 with SMTP id 2adb3069b0e04-532eda95c8amr3189049e87.35.1723704713255;
        Wed, 14 Aug 2024 23:51:53 -0700 (PDT)
Received: from localhost (109-81-83-166.rct.o2.cz. [109.81.83.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7e1c46fsm10404615e9.39.2024.08.14.23.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 23:51:52 -0700 (PDT)
Date: Thu, 15 Aug 2024 08:51:52 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	david@fromorbit.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Message-ID: <Zr2liCOFDqPiNk6_@tiehlicka>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
 <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org>
 <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <Zrxfy-F1ZkvQdhNR@tiehlicka>
 <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka>
 <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
 <Zr2eiFOT--CV5YsR@tiehlicka>
 <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>

On Thu 15-08-24 14:32:10, Yafang Shao wrote:
> On Thu, Aug 15, 2024 at 2:22 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Let me repeat, nested NOFAIL allocations will BUG_ON on failure.
> 
> The key question is whether it actually fails after we've already
> woken up kswapd. Have we encountered real issues, or is this just
> based on code review?

Depleting memory to the level that even min memory reserves is
insufficient is not a theoretical concern. OOMing the system is a real
thing!

> Instead of allowing it to fail, why not allocate
> from the reserve memory to prevent this from happening?

Because those memory reserves are shared and potentially required by
other more important users which cannot make forward progress without
them. And even with that, those can get depleted so the failure point is
just a matter of a specific memory consumption pattern. The failure
could be more rare but that also means much harder to predict and test
for. Really there are no ways around non sleeping GFP_NOFAIL, either you
disalow them or you just create a busy loop inside the allocator. We
have chosen the first option because that is a saner model to support.
-- 
Michal Hocko
SUSE Labs

