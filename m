Return-Path: <linux-fsdevel+bounces-15357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B2488C8FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 17:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925A7324F71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7FC13CA8E;
	Tue, 26 Mar 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgInalM5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5913C91B;
	Tue, 26 Mar 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470210; cv=none; b=UZaxqt9xmnVQoxv+VvAqjfeL/6Rf0n/uJNXNuDfK4dVubI5yAcjTnXHCNCWpNECOpmlzeVjHaSKt3bQSh4Euj1sFp1WlLuT+GdE9GPxZ13BQYkIGrRO31OCdDRQIWzoNKEH1i8QSxx+n9vBJtU0lTrABVndY3Z7pwkIdXjjU6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470210; c=relaxed/simple;
	bh=JeEqzuses3HS1WFM26cBg0E7pipHfw2grSLI30vpyMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sm0vOMhBzW0EXAN0vyvuqj3M5Ypk8ghPaU92Jed6heowW8j0R0Ti5tdb+PZ7PqdJhscf/1ztczi9ef0zl44MGv5ajNWMK6b+vnH9PXVonLnrxeft2NDDTiMkSqYsdvDCZnc52/d8WyGuqg3MgzXoia5aRdjt6JjjP9qo0eWcMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgInalM5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711470205; x=1743006205;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=JeEqzuses3HS1WFM26cBg0E7pipHfw2grSLI30vpyMU=;
  b=AgInalM55VBW1v2SvkUlNYpLg2fvzEVx8Sm05gy9NidXxSP3qJOWOXdr
   Ay8s6jZSY01bL6oemnfCtOyA0B65eFePqz7imAOjYTpX9WNpp4b529qL0
   atgBra4KmzJ9V98aZ/pVVhZJnS+QXMhVPPjlf6dJN7tCbcUWUtSTSDTtr
   8psj6goniZ94L+Dd3YMM+ufP7Tqo6xbBJUClpnhte13OjEbvWY+JjOeef
   nctq/RMsAOm5M0wllxWmSL0ck9Y881FhevYe5/+wdaouJzl3IEwcvAyGj
   lv0sLUc0AimL52bneKb21RojrrH1Uy9NL3RzAqabAxzxhDUSHcvzeTtDa
   g==;
X-CSE-ConnectionGUID: 6Zi660EbS2yYxRpHyyc/MA==
X-CSE-MsgGUID: PguBU9rZT1W+hyu9M2WRTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6746490"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6746490"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:23:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15997942"
Received: from unknown (HELO vcostago-mobl3) ([10.124.221.236])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:23:22 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: amir73il@gmail.com, hu1.chen@intel.com, miklos@szeredi.hu,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 1/5] cleanup: Fix discarded const warning when defining
 lock guard
In-Reply-To: <20240326-daheim-aluminium-810603172600@brauner>
References: <20240216051640.197378-1-vinicius.gomes@intel.com>
 <20240216051640.197378-2-vinicius.gomes@intel.com>
 <20240318-flocken-nagetiere-1e027955d06e@brauner>
 <20240318-dehnen-entdecken-dd436f42f91a@brauner>
 <87msqlq0i8.fsf@intel.com> <20240326-steil-sachpreis-cec621ae5c59@brauner>
 <20240326-daheim-aluminium-810603172600@brauner>
Date: Tue, 26 Mar 2024 09:23:22 -0700
Message-ID: <87a5mlotc5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Brauner <brauner@kernel.org> writes:

> On Tue, Mar 26, 2024 at 11:53:12AM +0100, Christian Brauner wrote:
>> On Mon, Mar 25, 2024 at 05:50:55PM -0700, Vinicius Costa Gomes wrote:
>> > Christian Brauner <brauner@kernel.org> writes:
>> > 
>> > >
>> > > So something like this? (Amir?)
>> > >
>> > >  
>> > > -DEFINE_LOCK_GUARD_1(cred, const struct cred, _T->lock = override_creds_light(_T->lock),
>> > > -	     revert_creds_light(_T->lock));
>> > > +DEFINE_LOCK_GUARD_1(cred, struct cred,
>> > > +		    _T->lock = (struct cred *)override_creds_light(_T->lock),
>> > > +		    revert_creds_light(_T->lock));
>> > > +
>> > > +#define cred_guard(_cred) guard(cred)(((struct cred *)_cred))
>> > > +#define cred_scoped_guard(_cred) scoped_guard(cred, ((struct cred *)_cred))
>> > >  
>> > >  /**
>> > >   * get_new_cred_many - Get references on a new set of credentials
>> > 
>> > Thinking about proposing a PATCH version (with these suggestions applied), Amir
>> > has suggested in the past that I should propose two separate series:
>> >  (1) introducing the guard helpers + backing file changes;
>> >  (2) overlayfs changes;
>> > 
>> > Any new ideas about this? Or should I go with this plan?
>> 
>> I mean make it two separate patches and I can provide Amir with a stable
>> branch for the cleanup guards. I think that's what he wanted.
>
> But send them out in one series ofc. Amir and I can sort this if needed.

Yeah, understood.


Thank you,
-- 
Vinicius

