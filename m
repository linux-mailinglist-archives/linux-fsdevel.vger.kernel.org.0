Return-Path: <linux-fsdevel+bounces-27254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ED695FD8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 00:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6401F236F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C5319CD0B;
	Mon, 26 Aug 2024 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVGCbmi9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B430146A71;
	Mon, 26 Aug 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713061; cv=none; b=O4FRX7J6TWE4XPTgCxR9nXrqioxaW1QDrydFXqAifno9IJw+iv9zNO/ZF3H88EmEA5sEHhssCh2YJ9wprKgb9BFbmmjaaksv7jo6/aN3JoYoJr0YmN2I1Aa0AR9U/cfO9YODHHSAvBiadlY7g0UQKSVhQiULAGRhzmW4AWtIIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713061; c=relaxed/simple;
	bh=fJ7aUPSH5xd0bQ6Ioys5f+Vk+9v/lyGsicxsmq46dAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e6fBIkpEsEJ7Vjr5pg/hRdSLpsrv/8QTqq+SALsaosrQqNu5Qjk3JwEsTI/3UVn7FOOs+MxTRlH2c7X+f2luCtxYbS8KqBQLc13VfZ8dSB/86OKhIL1uVT0VB3u8ZsXSVI40gcvj3qzxbcIPkOb0manzzar/irFO+kVnvhlsS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVGCbmi9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724713060; x=1756249060;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=fJ7aUPSH5xd0bQ6Ioys5f+Vk+9v/lyGsicxsmq46dAo=;
  b=KVGCbmi9OuAhBGzfjG9HqFtGfNvMW03/2IJMAmXK5OHRMst5VQzx3Tvr
   L+39l7fTrLv03GnUq5YaSQkuAhLCNyR/UtxmovKYZAg+4jsRhX0jzLW0z
   EH9/G+OnJ65f5w27SCyrNrSeEVZeGz9G//A1zPSY2qfv/72qu+dBdysnL
   A8387BcVkTJ20VThO4Fwms3p4yYdsRTATma6K3x7zX/uD8USxP9UavZsM
   doyrjHRwS5a/sWdUjI7yVjZTJBE5vB1FeseN7sF23/mnUZiAuiUjbbb46
   APMQ1uKEGphyRqkkCauKTrtUlI6mR9FdI/tIr2iW7lakjxxZ68A1YaAiS
   g==;
X-CSE-ConnectionGUID: mRuo8UF8RbKejC0XN56w8Q==
X-CSE-MsgGUID: ppFvggAETaCE3bxZnZL9zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23031629"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23031629"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:57:39 -0700
X-CSE-ConnectionGUID: NxuhCjigStOj/k3f+ziYHA==
X-CSE-MsgGUID: S3/nh20vTdS/itS9/Pn2XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66812928"
Received: from mesiment-mobl2.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.223.39])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:57:35 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/16] overlayfs: Use
 ovl_override_creds_light()/revert_creds_light()
In-Reply-To: <CAJfpegtko6VtNpshGUzZixE0jqecwQR91xT=Q7W5sf6HPGVPeQ@mail.gmail.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
 <20240822012523.141846-6-vinicius.gomes@intel.com>
 <CAJfpegtko6VtNpshGUzZixE0jqecwQR91xT=Q7W5sf6HPGVPeQ@mail.gmail.com>
Date: Mon, 26 Aug 2024 15:57:32 -0700
Message-ID: <87a5gylwo3.fsf@intel.com>
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
>> Convert to use ovl_override_creds_light()/revert_creds_light(), these
>> functions assume that the critical section won't modify the usage
>> counter of the credentials in question.
>>
>> In most overlayfs instances, the credentials lifetime is the duration
>
> Why most instances?  AFAICS the creds have the same lifetime as the
> overlayfs superblock.
>

I may be reading the code wrong, but on file creation some of the
credentials that are worked on come from the task(?).


Cheers,
-- 
Vinicius

