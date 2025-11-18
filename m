Return-Path: <linux-fsdevel+bounces-68923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AA5C68BC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6212E382922
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9549A331A52;
	Tue, 18 Nov 2025 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnP5Frhv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E643314C2;
	Tue, 18 Nov 2025 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460552; cv=none; b=qzRuKZndqTWIujBSPyDTOzSZVcWOK36AQhxGddcPYu+/Vw8kMZybgbKev/Un4IX03yrCE7ZgpOLs8Ufe3O3cia8OqJkCEO3o0LIu3AIi6Mjh+GojZZGVld/ORV2tkixSTbomu1yf25t0UOCr9dVHAJNm7ltxtpt8FRWH8Uf7ugo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460552; c=relaxed/simple;
	bh=vKxhqq4au/dWXSQZKX/aOQgvHvphJu+c1I5AhNTfc+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OKiOVo5vYEntzfPwYhP0W8qnsEl4AZuNi8IYJBu9GO0vdVTuseWhA1WOejGrpIRwuBh9RxaEtHFkDq2xC7Y0UkEZ+eoHrkVT/2UVZJvb9suEMIu7PF5QSblhsFHLXMy5YYJ4bDHzDWp2L1DEPOUYtYCI7GgVABKRWLGmS9ajDz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnP5Frhv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763460548; x=1794996548;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=vKxhqq4au/dWXSQZKX/aOQgvHvphJu+c1I5AhNTfc+g=;
  b=jnP5Frhvj+6kfFh5fd0jCD3NxtwQHfRZrIQUIz6KJATMm8aQwUflExb4
   kxoHx+UsZqvorO2XyYza7PKmuRlEdi19wtoGKN/LSIqOwUciHaaCwZgTz
   pf6ad6z1R4jqz18zZc2NghhXBdjpzfzedMe3r1VIHcsI6x6xhP83Z8ULl
   IpYw/HV8z2mlce4GOFn08KmXIT6sLg3RBJt+hy03lN7gf741BiD0PWXiA
   ACGwoqpqzZ6JN8rt/ugTWV8NCvZzFOjQKaqG4DQ4VR+rfBmpAM66B2n1V
   IPey6D3r02de4MtCyLINSCtDI3lQ5BoErrN3v9uSGbnp1a5npskSP+Rw7
   w==;
X-CSE-ConnectionGUID: 0Ie9MyZcRlub930KJJD8EA==
X-CSE-MsgGUID: Ww+iBu6gTaOlXpp2sK3P2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="90953338"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="90953338"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 02:09:04 -0800
X-CSE-ConnectionGUID: uw0/0t22RPOuCbwdBsIB2w==
X-CSE-MsgGUID: fN69BUQ3Sied0vows+5Mmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190512165"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.74])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 02:09:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, hansg@kernel.org, 
 Armin Wolf <W_Armin@gmx.de>
Cc: superm1@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
In-Reply-To: <20251111131125.3379-1-W_Armin@gmx.de>
References: <20251111131125.3379-1-W_Armin@gmx.de>
Subject: Re: [PATCH v2 0/4] platform/x86: wmi: Prepare for future changes
Message-Id: <176346053571.25792.7559691740634950169.b4-ty@linux.intel.com>
Date: Tue, 18 Nov 2025 12:08:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 11 Nov 2025 14:11:21 +0100, Armin Wolf wrote:

> After over a year of reverse engineering, i am finally ready to
> introduce support for WMI-ACPI marshaling inside the WMI driver core.
> Since the resulting patch series is quite large, i am planning to
> submit the necessary patches as three separate patch series.
> 
> This is supposed to be the first of the three patch series. Its main
> purpose is to prepare the WMI driver core for the upcoming changes.
> The first patch fixes an issue inside the nls utf16 to utf8 conversion
> code, while the next two patches fix some minor issues inside the WMI
> driver core itself. The last patch finally moves the code of the WMI
> driver core into a separate repository to allow for future additions
> without cluttering the main directory.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/4] fs/nls: Fix utf16 to utf8 conversion
      commit: 25524b6190295577e4918c689644451365e6466d
[2/4] platform/x86: wmi: Use correct type when populating ACPI objects
      commit: c209195a2a4ad920ff481b56628ca942d62e01b1
[3/4] platform/x86: wmi: Remove extern keyword from prototypes
      commit: 32e3fee88a4ac183541b478f5bc94084ea76436c
[4/4] platform/x86: wmi: Move WMI core code into a separate directory
      commit: e2c1b56f3dfa014128e775e898774c0356e3ff05

--
 i.


