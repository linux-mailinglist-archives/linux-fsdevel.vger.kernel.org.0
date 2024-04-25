Return-Path: <linux-fsdevel+bounces-17813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311C98B2757
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 19:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6571F25B2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD99614E2EC;
	Thu, 25 Apr 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejqPYHRW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2414E2CC;
	Thu, 25 Apr 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065169; cv=none; b=Nu28HIvRNWjdyjkfdqDpL8YJN0G3aNDnN8Fo+HQCD2AdWfGM39u9YI+77QWWl2kga+lgDJ1Bztd3komTtZFtu+6uIPlHcTQVgcTOCRhSz1CE/QVVI3DCKWq6LWQtShlmtNlDXhqczO04o5Efn/5ezjZiHsf279hAWHqSS0s86aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065169; c=relaxed/simple;
	bh=WiDWAopP55QKKCOgKkzDDn2ErC+ijp8is0bjkrl9Lwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KgeTkkO1RFBYMg7zWOTcggPXRSQkq1DTpaVtF+tLYQ0B/Vj8TDC6PM6Rffo7xdR4FGqD4Y3LCh4doVBpO46K+S+n3MvnvxABl12X3e6yl0UwBqGoeL9eSPf1ZSKBgsMasWeMj6eFrSD3Vz9Rbb+OQiZUoVkEEwLda122TWCKlJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejqPYHRW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714065167; x=1745601167;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WiDWAopP55QKKCOgKkzDDn2ErC+ijp8is0bjkrl9Lwc=;
  b=ejqPYHRWwL5c6K7Fn3S8rT+GryR7Dpip1RscsOJZxJJ4ypHUJYFikA0s
   w7Ezn75fh6975LejOOAsGzJRgG1knvv3OpDuXX2WCL/LZ8+/Vf06FziNJ
   r2jQhM52Ui9LLCGGIL4oEBIjHl3i+gspNsqUTVmijb6YqaqDPw2ZysExc
   4Kml+EKFZ2n9ZngKw9+VquKT76U+5lTReL8BqkS08FuQI9MjhhHb4yKVC
   nl1MEjUm7fVpI3/r/j1q3iIGmF8H2gBYx6WJv+2UzAUrnh3coxGbE87WM
   DL0F/E5pCYPnUdQWlZrKjfX0yXqHAP4o9RLGQyp/Q1x58pAeZGmwxs1Gc
   g==;
X-CSE-ConnectionGUID: 7VBb9mEOR1uWQuZoozYBlQ==
X-CSE-MsgGUID: GIgASEMATauIk36qADx/2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9619266"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9619266"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 10:12:35 -0700
X-CSE-ConnectionGUID: cIeHjDXdQUWrsDzxppDG2g==
X-CSE-MsgGUID: z67CDhjiR4OHpq6kq9o8ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="29773015"
Received: from unknown (HELO vcostago-mobl3) ([10.124.220.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 10:12:35 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: amir73il@gmail.com, hu1.chen@intel.com, miklos@szeredi.hu,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] overlayfs: Optimize override/revert creds
In-Reply-To: <20240425-nullnummer-pastinaken-c8cf2f7c41f3@brauner>
References: <20240403021808.309900-1-vinicius.gomes@intel.com>
 <20240424-befund-unantastbar-9b0154bec6e7@brauner>
 <87a5liy3le.fsf@intel.com>
 <20240425-nullnummer-pastinaken-c8cf2f7c41f3@brauner>
Date: Thu, 25 Apr 2024 10:12:34 -0700
Message-ID: <87y191wem5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Brauner <brauner@kernel.org> writes:

> On Wed, Apr 24, 2024 at 12:15:25PM -0700, Vinicius Costa Gomes wrote:
>> Christian Brauner <brauner@kernel.org> writes:
>> 
>> > On Tue, Apr 02, 2024 at 07:18:05PM -0700, Vinicius Costa Gomes wrote:
>> >> Hi,
>> >> 
>> >> Changes from RFC v3:
>> >>  - Removed the warning "fixes" patches, as they could hide potencial
>> >>    bugs (Christian Brauner);
>> >>  - Added "cred-specific" macros (Christian Brauner), from my side,
>> >>    added a few '_' to the guards to signify that the newly introduced
>> >>    helper macros are preferred.
>> >>  - Changed a few guard() to scoped_guard() to fix the clang (17.0.6)
>> >>    compilation error about 'goto' bypassing variable initialization;
>> >> 
>> >> Link to RFC v3:
>> >> 
>> >> https://lore.kernel.org/r/20240216051640.197378-1-vinicius.gomes@intel.com/
>> >> 
>> >> Changes from RFC v2:
>> >>  - Added separate patches for the warnings for the discarded const
>> >>    when using the cleanup macros: one for DEFINE_GUARD() and one for
>> >>    DEFINE_LOCK_GUARD_1() (I am uncertain if it's better to squash them
>> >>    together);
>> >>  - Reordered the series so the backing file patch is the first user of
>> >>    the introduced helpers (Amir Goldstein);
>> >>  - Change the definition of the cleanup "class" from a GUARD to a
>> >>    LOCK_GUARD_1, which defines an implicit container, that allows us
>> >>    to remove some variable declarations to store the overriden
>> >>    credentials (Amir Goldstein);
>> >>  - Replaced most of the uses of scoped_guard() with guard(), to reduce
>> >>    the code churn, the remaining ones I wasn't sure if I was changing
>> >>    the behavior: either they were nested (overrides "inside"
>> >>    overrides) or something calls current_cred() (Amir Goldstein).
>> >> 
>> >> New questions:
>> >>  - The backing file callbacks are now called with the "light"
>> >>    overriden credentials, so they are kind of restricted in what they
>> >>    can do with their credentials, is this acceptable in general?
>> >
>> > Until we grow additional users, I think yes. Just needs to be
>> > documented.
>> >
>> 
>> Will add some documentation for it, then.
>> 
>> >>  - in ovl_rename() I had to manually call the "light" the overrides,
>> >>    both using the guard() macro or using the non-light version causes
>> >>    the workload to crash the kernel. I still have to investigate why
>> >>    this is happening. Hints are appreciated.
>> >
>> > Do you have a reproducer? Do you have a splat from dmesg?
>> 
>> Just to be sure, with this version of the series the crash doesn't
>> happen. It was only happening when I was using the guard() macro
>> everywhere.
>> 
>> I just looked at my crash collection and couldn't find the splats, from
>> what I remember I lost connection to the machine, and wasn't able to
>> retrieve the splat.
>> 
>> I believe the crash and clang 17 compilation error point to the same
>> problem, that in ovl_rename() some 'goto' skips the declaration of the
>> (implicit) variable that the guard() macro generates. And it ends up
>> doing a revert_creds_light() on garbage memory when ovl_rename()
>> returns.
>
> If this is a compiler bug this warrants at least a comment in the commit
> message because right now people will be wondering why that place
> doesn't use a guard. Ideally we can just use guards everywhere though
> and report this as a bug against clang, I think.
>

I am seeing this like a bug/mising feature in gcc (at least in the
version I was using), as clang (correctly) refuses to compile the buggy
code (I agree with the error).

But I will add a comment to the code explaining why guard() cannot be
used in that case.


Cheers,
-- 
Vinicius

