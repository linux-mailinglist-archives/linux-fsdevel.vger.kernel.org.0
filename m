Return-Path: <linux-fsdevel+bounces-27255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF7495FD9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 00:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E94E1C224D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3AA19D8BF;
	Mon, 26 Aug 2024 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOLi8Pis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A731119D89C;
	Mon, 26 Aug 2024 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713127; cv=none; b=ciyqpAuU17j4QBgU+8Bgwx2DUtfF61zSFs6bMJ2RxIUnpiJQLiYq3MTwHX2/b4j2wpEAxnG1XXy2jNQE1Wrqmt8y6uh7Lb/6/NhDTX9N1neb1gT/NZKVO1y0h4WbQ6gWpf5eY6lWLVdo2dWOmnlFNEWArO/Y5pXymEpvhbh39ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713127; c=relaxed/simple;
	bh=KBdnXoPXWivL24WLXhGNRR2nKQBcVnqGZ3RcOscog68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uawhztM+QjGyyGzBMe/glpeXCJABN/KG+VgPLBpe1/nZTU+KHkeIwuxsG4CEVtx3Aff3pFXQP/n9UyoKufi3LF+ZKLMh7MetfVRjc89QqscnOmo4dERCFEQscBp0VAfAD/lM4vwCbYf0YZ+aCn/3zzllopoR0Dk1bScT7Ur1U/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOLi8Pis; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724713126; x=1756249126;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KBdnXoPXWivL24WLXhGNRR2nKQBcVnqGZ3RcOscog68=;
  b=XOLi8Pis/QvX7R2QXdTfHCBqRTka/3r+GNbdvyOcWc8CWhhfN7UTtbYA
   QKSEPKXeQaalXVKxoDh6MUDauTv3o0G7EVHO5HHAUcirjy5rGR8wyq2sc
   VPbjRcMD0d67zcJKI00tlCxR8KMq32Z3ML3sL3Ft8m6EbBgNxRLe60ezN
   dmGOg47vX+HJvXR+c+Z8KGF4Sqwf7+q356jOhjrTvW+4Q3Ns3DDYWIoiw
   xiXJN1HXGauCGGwePAxMBV1Q0x6ixmHMInPzNhLDJV/O6PGIXjeCDE5Bd
   CTJQttFb/Sr9BpBusAy0lLQ8CxFTO9w6m18VqOXL/YzaAuhNu7vYrf566
   Q==;
X-CSE-ConnectionGUID: eLY1YvmJRBC6agVgU3WxCA==
X-CSE-MsgGUID: r1DGwmDpS7ibPFv1kcxKmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33789496"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="33789496"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:58:45 -0700
X-CSE-ConnectionGUID: 1pP8iyVdQni8HNRx/CCgWg==
X-CSE-MsgGUID: F/MfvuJuQK6HdtKEyaThJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62483322"
Received: from mesiment-mobl2.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.223.39])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:58:42 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/16] fs/backing-file: Convert to cred_guard()
In-Reply-To: <CAJfpegs5+2DadbB6tfwLD+DAFzqfOTi7bZMxJCoj_r5Tu7jcfw@mail.gmail.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
 <20240822012523.141846-8-vinicius.gomes@intel.com>
 <CAJfpegs5+2DadbB6tfwLD+DAFzqfOTi7bZMxJCoj_r5Tu7jcfw@mail.gmail.com>
Date: Mon, 26 Aug 2024 15:58:38 -0700
Message-ID: <874j76lwm9.fsf@intel.com>
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
>> Replace the override_creds_light()/revert_creds_light() pairs of
>> operations to cred_guard().
>
> I'd note here, that in some cases the revert will happen later than
> previously, but (hopefully) you have verified that in these cases it
> won't make a difference.
>

Will add this note to the commit message.

> Thanks,
> Miklos


Cheers,
-- 
Vinicius

