Return-Path: <linux-fsdevel+bounces-28385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85355969FC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F83F1F256BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3C2AE75;
	Tue,  3 Sep 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HhZAkg4I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987D61CA68F
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372241; cv=none; b=CEJMUNCnixsSX8mmkv7QnmVds3EaMAatoSwwQ7IUneFiJBF0uA5nVVGnw1w3l7xikA85OX2eFfiLF3+UnrRp4vr8CrHCbRZGE8jMkg+dnki/4bqVYRVep0XpsI9GulTRVBJt3dhljM1SII7G41MJ1gIR8WO4KhnTRlzdzF6cCwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372241; c=relaxed/simple;
	bh=FX0cPWOEoOR5wj58khecoQrWHJsP+Hji0B0qfFTe4nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuZ2gz3TQAWe4tPAwi5XqHYOv8S8sDA3a9YMSRptfTkm8IMwERj3i29JbadpCVKw6sSOj0I/EmH5VPOluVDLIjw+vwtKFhZ8iu9ADc7FIoGDjyeemgIztMF1+e6cUa8p8jt632m1AYM49xuqOUrPop+BUfjRFZLCJpZnFNF7l6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HhZAkg4I; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f3f90295a9so61438251fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725372238; x=1725977038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4kZV7sylO482dTZcl3SB+t2bxHcHNDfXt4kPi8kfl8=;
        b=HhZAkg4Ixicf6xDueEUAavfW028+/6tIUPPZuhS2dgtprFF3oqqWktsOiGg/IN8/NN
         xgwt+4u4CVDde4sI8GeSDO2AcN2U3JMGs3Cu2fNw87RNS5Lvt8of8UUD1Jp1tHxzykVO
         P7bTZoKATqdCc3WD2KRld5LNKYotkY6G7DKUxWimY/S5ZeftnHbPpYXbZJxYpEaKDXZg
         hdQJNVZbzXln2b4Ulov7uKNhqwpv5Tmfh3MlzHr9lvVmYIkwb40ttVpvrSaGIDVk2pzp
         qJ47qoFfDlu1MhplAEzxszxN9d/X7Jkh7iuiiNww6y+v+gCH6oZMwsWs8xUde68HOdQ1
         4skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372238; x=1725977038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4kZV7sylO482dTZcl3SB+t2bxHcHNDfXt4kPi8kfl8=;
        b=Wy7ZFSRi7tcu/vTqQ4g5I6y1ZdXAxhPNsKNKsCHbS573bnKrx50MQbdcUtC3aBwNB5
         t/w0P76Oy4XhUarOFLQdFiAIajYxdEO/ZghNCwlcqVzDS2vfaR/sB7ASKKPQUA8SmGuV
         5hvi5BLdSrLqUbRkLKZhzSjK3DSsXm8sN9bXryx6wx+EFxraAkO2tKw167VCctRAcNgY
         Az3ift0Hd4vZK0rZW0/tgc1ZPu18RbUZr7OHU9uF3MOqFRiyKZMJ93oRIMofZZGgDqJ1
         BG2mDXuAby6RqNSt6oBnwwnMyWlDyoJ+ERmcVV3YrZGKSUvwgCIMwj8U904a/iVE9bsj
         dT+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+2Ugmb/3i4QpCsYQ0UJ94I5d8GxhMEIWD/kk5zcnc5OoFYdK5nbqxRTIgRp/nRpzpfDV6dbKYMcYNZSo/@vger.kernel.org
X-Gm-Message-State: AOJu0YzGY8FxSSviTsOl/Afstx27fqMOsCcZ4qNvmUDkag88icT2v8DJ
	rCsS9a7mA+/Z97VeTkzcsqginsmlmvIm0ZnVyvR94NzU+2IfQ6A9/foE61qb8Ms=
X-Google-Smtp-Source: AGHT+IFzD+eY4sNRW/2ZIQH2AIKlAmIhsXltUfopKsrNXJ8WlkE/Cqluh7S5xLrhLL6tkfBv7gk8+A==
X-Received: by 2002:a05:651c:1a0c:b0:2ef:2ef5:ae98 with SMTP id 38308e7fff4ca-2f636a7fec3mr40816641fa.34.1725372236951;
        Tue, 03 Sep 2024 07:03:56 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c24372d393sm4407310a12.23.2024.09.03.07.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:03:56 -0700 (PDT)
Date: Tue, 3 Sep 2024 16:03:56 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <ZtcXTAs2t0tM4qaA@tiehlicka>
References: <ZtCFP5w6yv/aykui@dread.disaster.area>
 <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
 <ZtPhAdqZgq6s4zmk@dread.disaster.area>
 <CALOAHbBEF=i7e+Zet-L3vEyQRcwmOn7b6vmut0-ae8_DQipOAw@mail.gmail.com>
 <ZtVzP2wfQoJrBXjF@tiehlicka>
 <CALOAHbAbzJL31jeGfXnbXmbXMpPv-Ak3o3t0tusjs-N-NHisiQ@mail.gmail.com>
 <ZtWArlHgX8JnZjFm@tiehlicka>
 <CALOAHbD=mzSBoNqCVf5TTOge4oTZq7Foxdv4H2U1zfBwjNoVKA@mail.gmail.com>
 <20240903124416.GE424729@mit.edu>
 <CALOAHbCAN8KwgxoSw4Rg2Uuwp0=LcGY8WRMqLbpEP5MkW4H_XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCAN8KwgxoSw4Rg2Uuwp0=LcGY8WRMqLbpEP5MkW4H_XQ@mail.gmail.com>

On Tue 03-09-24 21:15:59, Yafang Shao wrote:
[...]
> I completely agree with your point. However, in the real world, things
> don't always work as expected, which is why it's crucial to ensure the
> OOM killer is effective during system thrashing. Unfortunately, the
> kernel's OOM killer doesn't always perform as expected, particularly
> under heavy thrashing. This is one reason why user-space OOM killers
> like oomd exist.

I do undestand your point. On the other hand over a long time seeing all
different usecases we have concluded that the OOM killer should be
really conservative last resort. More agressive OOM policies should be
implemented by userspace to prevent from regressions in other usecases.

That doesn't really mean improvements to the kernel oom killer are not
welcome or impossible. The bar is just quite hard as the wide variety of
workloads is really hard to support. Heavy trashing is one example.
Different workloads will have a different understanding what that means
actually.
-- 
Michal Hocko
SUSE Labs

