Return-Path: <linux-fsdevel+bounces-15269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A447D88B65F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 01:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582912C2D08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 00:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CF31C2BD;
	Tue, 26 Mar 2024 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDCAEj3Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60DC2F5E;
	Tue, 26 Mar 2024 00:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711414258; cv=none; b=POYcp4tZkQzUxz5rb3m+7+VzrmH/1bh5BeqJeQP25cmsupXLHwVB1RO57aYyolYfV/hBj2m1azVSLWBplV0QibkVEzGsHVBIicMXvi19FIzrg8sGcY8Aj4XdRyTES7xtYjOjDpcylNBYdv5CWrt/EKe1s5Ji+xmypcjQuwuFPb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711414258; c=relaxed/simple;
	bh=NG5q0aGOfaNM5SzJ8H0jCrhV4x9uLFpIGTBBzKZEcUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O230l8DNsCITSApNOzow4L3l80Nl3X1MPphXeGkI8aVlERzu+EQXna8JfFUV1G7s4D2BDtsckwnGs7nbRUZHrO06UbeirbVjYsj1UgCAzJI1VYNKd7diBpPRmB9ljCbvDEWrgtIhitf/UzDUYDl9W4q5VvRE7z3k73mfteLFBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDCAEj3Y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711414257; x=1742950257;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=NG5q0aGOfaNM5SzJ8H0jCrhV4x9uLFpIGTBBzKZEcUk=;
  b=oDCAEj3YTX4ROl8wiKsCXYasmMpHXFHOIsJuFq1UD1XnXktJuHivqgg/
   QJa7/PI/OE8hB1TnDwUSxLtiYbZAOtnweyloKa0XmUl++2Dv7e+ngojYH
   6eGU/sF5k++YaJxdqS/mzU8crR9FhnlLKY4T0Gs2QRgGOvrnIhKcX3nKa
   BDYTcVYEIjZiBDCIO2IJf0PoHyDbtCF6M/FdllN6c8xS0FhAEUsbftjHl
   C5pH243Gs7iHKlX3bVSywYLDlIKjKeX9a9NHYKVVibkFfyPNqcnM2BJGZ
   1jlQwbZMf4MZXSTHZBq+dPpOqEltiAhSKWG0eZHvbDs7YKZt+5PrGa1hy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17878176"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="17878176"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 17:50:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15689156"
Received: from unknown (HELO vcostago-mobl3) ([10.124.221.210])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 17:50:56 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: amir73il@gmail.com, hu1.chen@intel.com, miklos@szeredi.hu,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 1/5] cleanup: Fix discarded const warning when defining
 lock guard
In-Reply-To: <20240318-dehnen-entdecken-dd436f42f91a@brauner>
References: <20240216051640.197378-1-vinicius.gomes@intel.com>
 <20240216051640.197378-2-vinicius.gomes@intel.com>
 <20240318-flocken-nagetiere-1e027955d06e@brauner>
 <20240318-dehnen-entdecken-dd436f42f91a@brauner>
Date: Mon, 25 Mar 2024 17:50:55 -0700
Message-ID: <87msqlq0i8.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Brauner <brauner@kernel.org> writes:

>
> So something like this? (Amir?)
>
>  
> -DEFINE_LOCK_GUARD_1(cred, const struct cred, _T->lock = override_creds_light(_T->lock),
> -	     revert_creds_light(_T->lock));
> +DEFINE_LOCK_GUARD_1(cred, struct cred,
> +		    _T->lock = (struct cred *)override_creds_light(_T->lock),
> +		    revert_creds_light(_T->lock));
> +
> +#define cred_guard(_cred) guard(cred)(((struct cred *)_cred))
> +#define cred_scoped_guard(_cred) scoped_guard(cred, ((struct cred *)_cred))
>  
>  /**
>   * get_new_cred_many - Get references on a new set of credentials

Thinking about proposing a PATCH version (with these suggestions applied), Amir
has suggested in the past that I should propose two separate series:
 (1) introducing the guard helpers + backing file changes;
 (2) overlayfs changes;

Any new ideas about this? Or should I go with this plan?


Cheers,
-- 
Vinicius

