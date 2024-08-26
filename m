Return-Path: <linux-fsdevel+bounces-27252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8362295FD74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 00:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66B41C21BFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9525619EEAA;
	Mon, 26 Aug 2024 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ff7TDC5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854DE19D07B;
	Mon, 26 Aug 2024 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712496; cv=none; b=CqtauFbdZu9O0X254n7oEDpW/u5ZuLWYFFcsLnKUrLxmMkaYGiz9H4e6v2DWgiHp6bHIcXY7kihssw9+BtlDTHokFqocGXv4U4Q8VFw9lJ/t1xpAUsJ56ocnrlTW3mGTbFisKRzs2JU9G98L8Ev/7MMGDLbvf3/51Tcz42RzaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712496; c=relaxed/simple;
	bh=x1hjh95k0wxaveZBrA+vEUT6erVcu1eYnkXU9yxB4Gg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a80/yYixh3ljkYYDzSvXzFYR7JdbOscsV/VPJNCERJvOrFKF/o60L/38RdqWDy4Xjd7V5aUKrQOM3dYDvzRp40dvY+42raCe8QqUb5AOd5CbL+D7VSweyGUqaNJC84P1Yy2dMsPTBkjbGq4sDh8aRH56AJ21UvULFb5+fq3HSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ff7TDC5i; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724712495; x=1756248495;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=x1hjh95k0wxaveZBrA+vEUT6erVcu1eYnkXU9yxB4Gg=;
  b=ff7TDC5iyKLf0y19udb2Y01IPpcUrF4ZvFHWMBO39tywc+FHhB6vFqIn
   ZrQUp7SjfOcJ4cHF9Xvr8SO5sHaW6+3+a1RWSQAKQcO3pQkwXBX2OyG17
   UMd6lApXrQ8ReGLPPCDKAxBUtpgdcckary88YHcC+sa3HXj3Py9MlV49q
   BR9BDiIQWEtSx3guCT3TMvs1akL4JGMiqg8TSQ9UZg0tPj6eaYCu3J5r/
   rVsCLwlE2QvgTvVUvcvGlkBX6Jyr8OAxzrQZh8AjxnUtUAG14LaVYB9p7
   eIknopSEd9DKnm7aQ8/xWzZzgtYfV/uPIZtwjyKOtqiohuANn8wsBioo9
   w==;
X-CSE-ConnectionGUID: FIUFE4RUTQusfzdwh9JIfQ==
X-CSE-MsgGUID: k0YRAnUYTKetC9C9LTHtvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="13225200"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="13225200"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:48:14 -0700
X-CSE-ConnectionGUID: OlW0FGS6T1Sc4Z+Gg1PEvw==
X-CSE-MsgGUID: kAJuRAjTQquHVlYP0FTDJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62972252"
Received: from mesiment-mobl2.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.223.39])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:48:11 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/16] overlayfs: Document critical override_creds()
 operations
In-Reply-To: <CAJfpegvx2nyVpp4kHaxt=VwBb3U4=7GM-pjW_8bu+fm_N8diHQ@mail.gmail.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
 <20240822012523.141846-5-vinicius.gomes@intel.com>
 <CAJfpegvx2nyVpp4kHaxt=VwBb3U4=7GM-pjW_8bu+fm_N8diHQ@mail.gmail.com>
Date: Mon, 26 Aug 2024 15:48:07 -0700
Message-ID: <87wmk2lx3s.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> Add a comment to these operations that cannot use the _light version
>> of override_creds()/revert_creds(), because during the critical
>> section the struct cred .usage counter might be modified.
>
> Why is it a problem if the usage counter is modified?  Why is the
> counter modified in each of these cases?
>

Working on getting some logs from the crash that I get when I convert
the remaining cases to use the _light() functions.

Perhaps I was wrong on my interpretation of the crash.

Thanks for raising this, I should have added more information about this.


Cheers,
-- 
Vinicius

