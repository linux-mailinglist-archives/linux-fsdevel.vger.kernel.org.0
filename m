Return-Path: <linux-fsdevel+bounces-51083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FDDAD2AFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 02:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1750167F5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 00:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B68118E02A;
	Tue, 10 Jun 2025 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="uMIybKf1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0251A18785D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 00:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749516464; cv=none; b=MHey9Z8E4jrWEQ4EK3VSMLihQRKHzy0LAaNkaR5wLkft6BeV903t7OVC9whPOSWAQYbhF0UzQg1qJyJ25vfFya+YlnekN6Gm9NpRsDNj7VY+2upTn+HsQ8mLPsScU8312Q65DA20KoLgHw5XfZWHkpjuBfOgL10iSPQr45VfCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749516464; c=relaxed/simple;
	bh=wzCk96ikWwU44bte0lQ98/7tlYNX7MGlFlWnTbV3Q3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0DVoE9TgXyfBWLeoCxMYjeruYp0fANu2eo7+EajMpaN4rETD260E1OER0zGLo3oDMUI/Le19ltqUmO0ZWSHhic8BBE5OBMIHVqbcyyXgbC3NuoVC+6hZZrX7wLGhqTTWAzzUnNO0CIncREd53RhF4/GiK0YpDzpjg7uUo+TPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=uMIybKf1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af51596da56so3375487a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jun 2025 17:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1749516462; x=1750121262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3HFQjv+s6bpttilWu2xjAJePsr0RPP9RK118a+zBXU=;
        b=uMIybKf1b//Z5997zuzeoGNpGaNsTam+DaY+5pDAPutrDYI+enowiFpR6bUi4QUWDY
         K/zQGdKcwdhV6FjeJOpJWhbgI9Y0kIjZcCMP/nsdu90G8wbq/BtHvi75t5OnaXVhD/zm
         1xbn1tw6uitcP/yNju6laDVve3ZBg7vIMav4KGUYw7LDi/+Ge+x8uk8MKGUOrfUL+GFq
         QDIBCWfE/ig4qvbYEJTBigz0T9vOKbem1ynktoTiKa+/I9DGKklebYQLEKRMvAOSA0ne
         c4sl0QlJA18L5yE6+uISuW+y0dDXXak9nC4RsAvWQysjAk02nEUBeItLm7Z9fQ1lo2YO
         LcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749516462; x=1750121262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3HFQjv+s6bpttilWu2xjAJePsr0RPP9RK118a+zBXU=;
        b=D9yltkUdxbphcK5Gq9dvRHO2GFPlwyWL8xcd9ejEqPc4TwD4CjlOjFFKJLFAqDsvVo
         ZpOTFIfczOvd9u2DE/vyM+qIwPgJ+xUIKgZ8/hraXlh0purvvuZzIPacw6A5lK8kOgqv
         CtYq/yfRDwRU5VQW1cdXJ+jbkSNP3jJJZuLz39zr9t9HyseBvt560+GGOM5ILZM4DhFT
         xia1niRbjsHiP8lj91l3TBPBpYA23JqZ7w7UJWpWEVJElX2hntds5i3YaI+HvyyuOe9L
         /c+gTdQjfUzLfhuPsaS2CwMziuaR+Z1OR4T+RJJmMv9QR/56IJ87htZkPTGOcninFMI9
         s1Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWkWW1tJpn3sOH94+4+uzDJJdSGy7xfEOumdkfCS6rp/Uy+bx8J61rslSxSTcm9TU3U+kLAgYWjWHqNj957@vger.kernel.org
X-Gm-Message-State: AOJu0YwyShKVhVzngoCE4enTsWIhbk/5AfYpF6V5STnLEjC6q+8ph3E7
	zke4KLj46WwOk6imRRDZfSafXnqclD+i31b+AIavPD/+TpQNv43zT1vV9c1CCbkW5gU=
X-Gm-Gg: ASbGnctLjqa4mOCH4vLLbsnPZyroqTkXLngOkIyuFigsrR9+gUUqHbAkf6LnhwJv08F
	+1djo1Yyhg1MQm2VbA5dv3YQqOWO9m+UQzQ+oJSsZi0VxXKrHgaAK/0zDuhYWJRIwWphz31CS+K
	iu/ZCkO0XK7nehxqj4YIwdGPZhizD8DEnCwLRc/6cLdGw8Vs9q3WXa3MP6wcIh2E1m4i0Kdz/S7
	a5/tcyXK+eNR1e3+dYcrrqDwbczHZxIcZd7mGYYRknQhQdP5vaAd6FVqWIkA1KKugV7MRgHEmtK
	EZkOhvAduF15zMl8wE6fUXYkITnxZvgiRau5gEAQGzo/L/T90tTJn10t+F/cvkTc3B6vN4GtYb2
	iamAdsXpKbtjf6dRa9/p1FBH/B7OzZLGWLfPpFQ==
X-Google-Smtp-Source: AGHT+IF+GE/zQiGzNIgbWcPCTdnSM7Z+WH7gcF6pxHsgZod9kavZI1l2guNjvkN7v2RhFEDFr+ZVDA==
X-Received: by 2002:a17:90b:540c:b0:311:c1ec:7d0a with SMTP id 98e67ed59e1d1-3134768fa6emr21220493a91.25.1749516462202;
        Mon, 09 Jun 2025 17:47:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b13b45dsm6829912a91.37.2025.06.09.17.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 17:47:41 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uOn9P-0000000ERff-0bxu;
	Tue, 10 Jun 2025 10:47:39 +1000
Date: Tue, 10 Jun 2025 10:47:39 +1000
From: Dave Chinner <david@fromorbit.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 0/8] fuse: use iomap for buffered writes + writeback
Message-ID: <aEeAqxUfFxepmQle@dread.disaster.area>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606233803.1421259-1-joannelkoong@gmail.com>

On Fri, Jun 06, 2025 at 04:37:55PM -0700, Joanne Koong wrote:
> This series adds fuse iomap support for buffered writes and dirty folio
> writeback. This is needed so that granular dirty tracking can be used in
> fuse when large folios are enabled so that if only a few bytes in a large
> folio are dirty, only a smaller portion is written out instead of the entire
> folio.
> 
> In order to do so, a new iomap type, IOMAP_IN_MEM, is added that is more
> generic and does not depend on the block layer. The parts of iomap buffer io
> that depend on bios and CONFIG_BLOCK is moved to a separate file,
> buffered-io-bio.c, in order to allow filesystems that do not have CONFIG_BLOCK
> set to use IOMAP_IN_MEM buffered io.
> 
> This series was run through fstests with large folios enabled and through
> some quick sanity checks on passthrough_hp with a) writing 1 GB in 1 MB chunks
> and then going back and dirtying a few bytes in each chunk and b) writing 50 MB
> in 1 MB chunks and going through dirtying the entire chunk for several runs.
> a) showed about a 40% speedup increase with iomap support added and b) showed
> roughly the same performance.
> 
> This patchset does not enable large folios yet. That will be sent out in a
> separate future patchset.
> 
> 
> Thanks,
> Joanne
> 
> Joanne Koong (8):
>   iomap: move buffered io bio logic into separate file
>   iomap: add IOMAP_IN_MEM iomap type
>   iomap: add buffered write support for IOMAP_IN_MEM iomaps
>   iomap: add writepages support for IOMAP_IN_MEM iomaps

AFAICT, this is just adding a synchronous "read folio" and "write
folio" hooks into iomapi that bypass the existing "map and pack"
bio-based infrastructure. i.e. there is no actual "iomapping" being
done, it's adding special case IO hooks into the IO back end
iomap bio interfaces.

Is that a fair summary of what this is doing?

If so, given that FUSE is actually a request/response protocol,
why wasn't netfs chosen as the back end infrastructure to support
large folios in the FUSE pagecache?

It's specifically designed for request/response IO interfaces that
are not block IO based, and it has infrastructure such as local file
caching built into it for optimising performance on high latency/low
bandwidth network based filesystems.

Hence it seems like this patchset is trying to duplicate
functionality that netfs already provides request/response
protocol-based filesystems, but with much less generic functionality
than netfs already provides....

Hence I'm not seeing why this IO patch was chosen for FUSE. Was
netfs considered as a candidate infrastructure large folio support
for FUSE? If so, why was iomap chosen over netfs? If not, would FUSE
be better suited to netfs integration than hacking fuse specific "no
block mapping" IO paths into infrastructure specifically optimised
for block based filesystems?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

