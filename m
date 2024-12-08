Return-Path: <linux-fsdevel+bounces-36712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546BA9E87C4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 21:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD5A188504B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 20:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F170A189F42;
	Sun,  8 Dec 2024 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="oy8/ReYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C69A158862
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Dec 2024 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733689735; cv=none; b=ql4EF6Xpo3M4R88cYhzJT7G18dRno0qFwis2SykPyXAupoXS5JT3y62DzvChVvLoFpm4de0E5mEqiy9kJSpuHfVem4qhLuuA8QZLa3tRVJ/lUivMNddDhAw0m9KY+fK0h5N+EUX3g+XZhBzHHU5oa3yA1Qs89nXw/gFT19oZj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733689735; c=relaxed/simple;
	bh=MCThqbnSymxnjcm7dPmv7InFUnWXw8hen6+VOlIYGXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixy38Q/z65xMPfwBt3IsEM7FwwlTDYdmI0APYhqfbPe+pb9aBQDNKMqUea3Frwn1sLhurW13XUkPs/qe9z1LD4oXI3xwMcJXNY9gJ/2oBxScPCAIausaHRYlQa4/8cfAohKdzZVVoxp10g2pyKgrG6D1MWF61mGc6/VBr462VeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=oy8/ReYV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fd49d85f82so340481a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Dec 2024 12:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733689733; x=1734294533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vza9A+t1GMERYW4xV7cpDTKZ675BDJOMb1tJ0A06dBc=;
        b=oy8/ReYV/AepxdrDPIqqxdeeZE49RJFuzEZ2tqClf0uOZjLdX5TrY1/MqGbPyzTOJh
         DEQLstSBJ5XHcvvkpi6ytG8oV2vPLLuU3RUYmw92XUkQQVdxoNvBCUsSDVU/WK0EaJM6
         sCUz2j5KzGJNlPutc1sQ5uo4dlUEyx31b8OrWuZdzvUWpw3+WobnlaBlYGxPt2+TTDDn
         Qu8YxCUM1l1WtI+fZ9GOiCF5AXmAVCWGPlIgFod+Rrf+YiWs+zvpO7ofx30ngWNGGDBs
         dG5mH3PXtg8zRiFvT5bXcKNrdvZlE4K9RNVGGeFG+7rfzQUeyEnDvmlNxi5lhZULXRZN
         kDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733689733; x=1734294533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vza9A+t1GMERYW4xV7cpDTKZ675BDJOMb1tJ0A06dBc=;
        b=DOrWO6f9mx7JiAtSbTffD7u3Gp4asSrliHf1jJp/sPxGxTJsa93epEM8bAGgzxRUva
         e92JzfoFgVGbD9v6IOcr0weD87aYhGmEdxmULbD1qBNnpn9hilN4QkWGNfvTGo3rGEvr
         hs7be2gfxxS3aZN/LboMRXBfmaAKWqYUnqZcGuXtHxZhZcj2d9QbZ3BF3PNQDYYYje92
         SWWc5ilUAaMxlZi4rlA+qNwiuoZRsXddhulWRZL2Hlecyhrn/iNfWcySU7lgPpt+iaK4
         CrVBgn/YG0wrF3StyyWimVlAzvIKvIESctQ5A2EKdspvjnxR4Nqf4Gk2H/zQ3Rg6K3qK
         jQsw==
X-Forwarded-Encrypted: i=1; AJvYcCXONbLeR/aOQqNyaiDIdKzfkPNaIyeng6dgrAm/mNzz/GRE8RSgIvN0voonRHvod2h5fMz8uxRc5WJ2/N6Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyoxvT5gYmYyvFTQubjKrbdKZKW6XGWpBkFASQWGPSJTYvJ/DkI
	6ShelzWlexb73QsTfGgfOKFxa8efe4ZqVEVM5mWstETgAZYeQyq6NkgDAyur9h0=
X-Gm-Gg: ASbGnct/xdkp+uzngYGO6AyiuhGzhLcqJ0z/q3bFulD+zzYeyqs0QCk2IQXDsVUZcm5
	iBb3tgX7LiRHy9aeNlAYFHGxhdkhDZXZvkZwUb6ZjAquf4IkEqxiQGx8QL5leQ6BBKhn7uil6oo
	2tNxxcm/HzVqPCLLEQe0UzbfgSSFwsUrOaRks1XzHk5hK/UBdwPNHwquMjMMkYcngeH5io9CYvl
	gAlUtzVz8UmTInIAXDfTwTRrfNU4LT03tzNFiaKmK0UXQxk/M+LoEJck28Ie8iWrGq9JL8SSfhW
	g8VnR5q06dVmyJYiALN2Mmc=
X-Google-Smtp-Source: AGHT+IFk14cXJmIEBd62bgPEl1xxD6ozhc7bahVtSgzragd1S9aYWQrkX3cSUvn5gCrfQcUPmrKaGA==
X-Received: by 2002:a17:90b:3f4d:b0:2ee:b2be:f398 with SMTP id 98e67ed59e1d1-2ef6955f708mr15833697a91.2.1733689732905;
        Sun, 08 Dec 2024 12:28:52 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef4600d2c4sm7259137a91.47.2024.12.08.12.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 12:28:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tKNTW-00000008Iab-2usM;
	Mon, 09 Dec 2024 07:01:54 +1100
Date: Mon, 9 Dec 2024 07:01:54 +1100
From: Dave Chinner <david@fromorbit.com>
To: cel@kernel.org
Cc: Zorro Lang <zlang@redhat.com>, linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] fstests: disable generic duperemove tests for NFS and
 others
Message-ID: <Z1X7Mlf5Lhgu1Iu7@dread.disaster.area>
References: <20241208180718.930987-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208180718.930987-1-cel@kernel.org>

On Sun, Dec 08, 2024 at 01:07:18PM -0500, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> On NFS mounts, at least, generic/559, 560, and 561 run for a very
> long time, and usually fail.
> 
> The above tests already gate on whether duperemove is installed on
> the test system, but when fstests is installed as part of an
> automated workflow designed to handle many filesystem types,
> duperemove is installed by default.
> 
> duperemove(8) states:
> 
>   Deduplication is currently only supported by the btrfs and xfs
>   filesystem.
> 
> Ensure that the generic dedupe tests are run on only filesystems
> where duperemove is known to work.

Perhaps we should just remove this test. duperemove seems to be
quite flakey unreliable and keeps failing on my XFS test systems
(e.g. getting stuck in endless fiemap loops). I've set these tests
to be 'unreliable_in_parallel' because a 75% failure rate when the
system is under heavy load due to duperemove bugs is unacceptible in
a tool being used for a regression test.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

