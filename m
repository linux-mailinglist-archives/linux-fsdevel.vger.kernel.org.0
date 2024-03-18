Return-Path: <linux-fsdevel+bounces-14777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A726E87F2AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 22:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6FF1F2254A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 21:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB95A4DC;
	Mon, 18 Mar 2024 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0nbCrFg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33AD5A4C2;
	Mon, 18 Mar 2024 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798901; cv=none; b=YVdigL81qqxkDjJQHaKYs6LPv1vvGoSfATz2hD68rboloOLYWYvOwKZmc3YiBEFjPyA95G0Lod+bQu2XueKF1E19o01SVPZVY5YqnUP+CWgD2XbRqCp/du9wzUKw5GY25su3O0u0Zipm7frM0Gy3LIitq/UjEkNXLJDvvlWo0h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798901; c=relaxed/simple;
	bh=OtuCDqkSfVg0+5ApOlxKzqe1QfAgEjBGhzs/PhrLUJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V8FOoEer+m+7qcFbitTEYlFVgjeI+qEG+7Cr/st9e4AVTeaElasMmRJmlIjWljwG8oJSqNUENUZGix1HMgJBmyHJ5RntYzA3Gm6f84MDcyqjamhkBvwGU63lI7LzAJyWVYzgmPUL/iFeI5OCTK+mMHIJ2UTDALf/4Yh68xbcVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0nbCrFg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710798899; x=1742334899;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=OtuCDqkSfVg0+5ApOlxKzqe1QfAgEjBGhzs/PhrLUJ4=;
  b=Z0nbCrFg7SJyNp2WEc6LlS/4UyM808nHqsSf+0OSgo8s+PsG1flP1R/1
   BhaI/GkYw3fYOpn62pH7d+pNP7L3GeZ7XzcFsonkol7fjqFkZ0vEBZ2Ri
   Fmb9m7zgipo53p8DXWxfFbKANDkPGICKAYOK8rzuYQXD2dvq96btvrnaw
   FgcJDYdpxTHGTx9veHh6oHYN6VsEzukq3UXdAccQPcCEGh1LKbqlF935Y
   pVhpWQaiQmaALa4L6k2R6lOuXpMrOYOO07FeD9mEXwSQTWe4JziMDkMtO
   bsUkpAGhg7WTmuMuFrxpZsgmjEWgHB73RLWhMhXRt5Jv6GVhK/m3+rIGP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="16786152"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="16786152"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 14:54:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="36731025"
Received: from unknown (HELO vcostago-mobl3) ([10.125.110.188])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 14:54:57 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: amir73il@gmail.com, hu1.chen@intel.com, miklos@szeredi.hu,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 1/5] cleanup: Fix discarded const warning when defining
 lock guard
In-Reply-To: <20240318-flocken-nagetiere-1e027955d06e@brauner>
References: <20240216051640.197378-1-vinicius.gomes@intel.com>
 <20240216051640.197378-2-vinicius.gomes@intel.com>
 <20240318-flocken-nagetiere-1e027955d06e@brauner>
Date: Mon, 18 Mar 2024 14:54:56 -0700
Message-ID: <875xxjp5n3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian Brauner <brauner@kernel.org> writes:

> On Thu, Feb 15, 2024 at 09:16:36PM -0800, Vinicius Costa Gomes wrote:
>> Fix the following warning when defining a cleanup guard for a "const"
>> pointer type:
>>=20
>> ./include/linux/cleanup.h:211:18: warning: return discards =E2=80=98cons=
t=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
>>   211 |         return _T->lock;                                        =
        \
>>       |                ~~^~~~~~
>> ./include/linux/cleanup.h:233:1: note: in expansion of macro =E2=80=98__=
DEFINE_UNLOCK_GUARD=E2=80=99
>>   233 | __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)       =
        \
>>       | ^~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/cred.h:193:1: note: in expansion of macro =E2=80=98DEFIN=
E_LOCK_GUARD_1=E2=80=99
>>   193 | DEFINE_LOCK_GUARD_1(cred, const struct cred, _T->lock =3D overri=
de_creds_light(_T->lock),
>>       | ^~~~~~~~~~~~~~~~~~~
>>=20
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>>  include/linux/cleanup.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
>> index c2d09bc4f976..085482ef46c8 100644
>> --- a/include/linux/cleanup.h
>> +++ b/include/linux/cleanup.h
>> @@ -208,7 +208,7 @@ static inline void class_##_name##_destructor(class_=
##_name##_t *_T)	\
>>  									\
>>  static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
>>  {									\
>> -	return _T->lock;						\
>> +	return (void *)_T->lock;					\
>>  }
>
> I think both of these patches are a bit ugly as we burden the generic
> cleanup code with casting to void which could cause actual issues.

Fair point.

>
> Casting from const to non-const is rather specific to the cred code so I
> would rather like to put the burden on the cred code instead of the
> generic code if possible.

For what it's worth, I liked your changes, will remove these two "fixes"
from the series and use your suggestions in the next version.


Thank you,
--=20
Vinicius

