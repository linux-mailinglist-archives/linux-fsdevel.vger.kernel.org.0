Return-Path: <linux-fsdevel+bounces-44446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19547A68DE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 14:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E42174A27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1830A2571B1;
	Wed, 19 Mar 2025 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="jYGoBDSK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C3A29;
	Wed, 19 Mar 2025 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391340; cv=none; b=Bx12MU8scB18xtwbDKnEbh/jnH3r73jw+k7StQ7QBcrkL9HbYv3NUwFcb1bDzlU8p/na0Iovob4/uY01OYsNK1OUtOb/1VRNkhXdqq8gRU9XJmWun51vVBTVIvRBlZnbOJkPx0zDy4NxjXEtZNWvIvNLEIb/nW3U91zPxSFnNWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391340; c=relaxed/simple;
	bh=RLiqBVLAswhOALCEFFshUGNdDuiXsWj7woAnkixStJI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VQCUAU2nW7zk23P9bU1iS10+vVK+2exalANY4LfcV+Lf9tzJ0UyMNFM1+ZtivTOpBNZpIv8hXXTTwb1pQhG+P9rUew8wNewumxJxtlgqAbTEtQT20RZvdYemmyKN4fCt9B6SU+Jz9oPzMNKNudFVqJr4/xx9Rtv2osUCmt91hRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=jYGoBDSK; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1742391338; x=1773927338;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=GD84eS+KjqESu8bl1BI9Aha2TWlwiVZ+GXn8bhJHG+4=;
  b=jYGoBDSKc5RJX7hux43YfIF/rAryUafpC41O6t9vUJATyZz/N6ArqbD4
   9eyv8IgIeTuYHfFAXRosA36w2oeYz5Q+H9+DSRzjaTa6UVEpbrYwabI8C
   tVJF13ttg0vyhd3mhAgAsuMrOTXBhyfW6boVVjFmRRXf0NFizw/3LEV/r
   Q=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736812800"; 
   d="scan'208";a="481718566"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 13:35:33 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:53702]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.40:2525] with esmtp (Farcaster)
 id 22e8791f-d226-4e39-a4e3-702c6513df8c; Wed, 19 Mar 2025 13:35:32 +0000 (UTC)
X-Farcaster-Flow-ID: 22e8791f-d226-4e39-a4e3-702c6513df8c
Received: from EX19D020UWA002.ant.amazon.com (10.13.138.222) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 13:35:32 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D020UWA002.ant.amazon.com (10.13.138.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 13:35:32 +0000
Received: from email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 13:35:32 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com (Postfix) with ESMTP id CF94A40238;
	Wed, 19 Mar 2025 13:35:31 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 8C4975149; Wed, 19 Mar 2025 13:35:31 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Christian Brauner <brauner@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Eric Biederman <ebiederm@xmission.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, "Hugh
 Dickins" <hughd@google.com>, Alexander Graf <graf@amazon.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, David Woodhouse
	<dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, Mike Rapoport
	<rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
	<tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, "Dave
 Hansen" <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<kexec@lists.infradead.org>
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
In-Reply-To: <20250318232727.GF9311@nvidia.com>
References: <20250307005830.65293-1-ptyadav@amazon.de>
	<20250307005830.65293-2-ptyadav@amazon.de>
	<20250307-sachte-stolz-18d43ffea782@brauner> <mafs0ikokidqz.fsf@amazon.de>
	<20250309-unerwartet-alufolie-96aae4d20e38@brauner>
	<20250317165905.GN9311@nvidia.com>
	<20250318-toppen-elfmal-968565e93e69@brauner>
	<20250318145707.GX9311@nvidia.com> <mafs0a59i3ptk.fsf@amazon.de>
	<20250318232727.GF9311@nvidia.com>
Date: Wed, 19 Mar 2025 13:35:31 +0000
Message-ID: <mafs05xk53zz0.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 18 2025, Jason Gunthorpe wrote:

> On Tue, Mar 18, 2025 at 11:02:31PM +0000, Pratyush Yadav wrote:
>
>> I suppose we can serialize all FDs when the box is sealed and get rid of
>> the struct file. If kexec fails, userspace can unseal the box, and FDs
>> will be deserialized into a new struct file. This way, the behaviour
>> from userspace perspective also stays the same regardless of whether
>> kexec went through or not. This also helps tie FDBox closer to KHO.
>
> I don't think we can do a proper de-serialization without going
> through kexec. The new stuff Mike is posting for preserving memory
> will not work like that.

Why not? If the next kernel can restore the file from the serialized
content, so can the current kernel. What stops this from working with
the new memory preservation scheme (which I assume is the idea you
proposed in [0])? In that, kho_preserve_folio() marks a page to be
preserved across KHO. We can have a kho_restore_folio() function that
removes the reservation from the xarray and returns the folio to the
caller. The KHO machinery takes care of abstracting the detail of
whether kexec actually happened. With that in place, I don't see why we
can't deserialize without going through kexec.

>
> I think error recovery wil have to work by just restoring access to
> the FD and it's driver state that was never actually destroyed.
>
>> > It sure would be nice if the freezing process could be managed
>> > generically somehow.
>> >
>> > One option for freezing would have the kernel enforce that userspace
>> > has closed and idled the FD everywhere (eg check the struct file
>> > refcount == 1). If userspace doesn't have access to the FD then it is
>> > effectively frozen.
>> 
>> Yes, that is what I want to do in the next revision. FDBox itself will
>> not close the file descriptors when you put a FD in the box. It will
>> just grab a reference and let the userspace close the FD. Then when the
>> box is sealed, the operation can be refused if refcount != 1.
>
> I'm not sure about this sealed idea..
>
> One of the design points here was to have different phases for the KHO
> process and we want to shift alot of work to the earlier phases. Some
> of that work should be putting things into the fdbox, freezing them,
> and writing out the serialzation as that may be quite time consuming.
>
> The same is true for the deserialize step where we don't want to bulk
> deserialize but do it in an ordered way to minimize the critical
> downtime.
>
> So I'm not sure if a 'seal' operation that goes and bulk serializes
> everything makes sense. I still haven't seen a state flow chart and a
> proposal where all the different required steps would have to land to
> get any certainty here.

The seal operation does bulk serialize/deserialize for _one_ box. You
can have multiple boxes and distribute your FDs in the boxes based on
the serialize or deserialize order you want. Userspace decides when to
seal or unseal a particular box, which gives it full control over the
order in which things happen.

>
> At least in my head I imagined you'd open the KHO FD, put it in
> serializing mode and then go through in the right order pushing all
> the work and building the serializion data structure as you go.

If we serialize the box at seal time, this is exactly how things will be
done. Before KHO activate happens, userspace can start putting in FDs
and start serializing things. Then when activation happens, the
box-level metadata gets quickly written out to the main FDT and that's
it. The bulk of the per-fd work should already be done.

We can even have something like FDBOX_PREPARE_FD or FDBOX_PREPARE_BOX
that pre-serializes as much as it can before anything is actually
frozen, so the actual freeze is faster. This is similar to pre-copy
during live migration for example.

All of this is made easier if each component has its own FDT (or any
other data structure) and doesn't have to share the same FDT. This is
the direction we are going in anyway with the next KHO versions.

>
> At the very end you'd finalize the KHO serialization, which just
> writes out a little bit more to the FDT and gives you back the FDT
> blob for the kexec. It should be a very fast operation.
>
> Jason
>

[0] https://lore.kernel.org/lkml/20250212152336.GA3848889@nvidia.com/

-- 
Regards,
Pratyush Yadav

