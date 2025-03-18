Return-Path: <linux-fsdevel+bounces-44377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6AEA68064
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DB93B21DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 23:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E794205E33;
	Tue, 18 Mar 2025 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="netNYtCU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C4918C03A;
	Tue, 18 Mar 2025 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338960; cv=none; b=gTampyqKqLEhZJqapqiu9funTD4LKgKnlBnSdNbvRgFiZQ2IK96k+b8p1RoKGvNzJrhr08mGXlAfg5fsvdcc0dr5KG8NzVxPfL263rh+bHDvFFjSQLygsgsf0c+kglbi48xxpQaExd4T8pGJ8RaNPkrcGiyNopLCfd1sRC9OxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338960; c=relaxed/simple;
	bh=AFcG2UK8M7dIJr1iIPgFqTjloiFOP77afCaJhcKvdi4=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cznAOdr8Cwc2Fzo1wi52CZOyKl53+sxtW4MMvua+ZQ0iiNRUvQ0vEgtm3ZRSipO0uxb+fia2GNgOE55YzV8fexlEzCAcF0eruN8nunFRjdgVaNfxRLxprA8F0bQeaTu8X65YctxXM92Vn9NfFMShWS4g6W7u39tQAfXwNmW6S2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=netNYtCU; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1742338959; x=1773874959;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=o9Gs8I6caiy1/fPWZYvSLm6+kkS17oGi9fBfJW9dipQ=;
  b=netNYtCU2EjRfOEaokWfRpyWrLFQGqiDTcWKYeGCTnA5bQbWo5dNrr+y
   uhQjZ0Je3XkcJvUpS4nu2TBDqQwFf8Dkghs8YQdxYyP91lno9tWwo2GF+
   Zt104rIR8vYo2795fsOeWmc3t3j7ng6lInbE8gs8P1hK9deDNFGGpP9D+
   g=;
X-IronPort-AV: E=Sophos;i="6.14,258,1736812800"; 
   d="scan'208";a="706160683"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:02:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:9378]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.40:2525] with esmtp (Farcaster)
 id 587d40c0-f869-4b16-8e9b-ae504ea90e33; Tue, 18 Mar 2025 23:02:32 +0000 (UTC)
X-Farcaster-Flow-ID: 587d40c0-f869-4b16-8e9b-ae504ea90e33
Received: from EX19D020UWC003.ant.amazon.com (10.13.138.187) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:02:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D020UWC003.ant.amazon.com (10.13.138.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:02:32 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 23:02:32 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com (Postfix) with ESMTP id 201F480140;
	Tue, 18 Mar 2025 23:02:32 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id AB4514EA8; Tue, 18 Mar 2025 23:02:31 +0000 (UTC)
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
In-Reply-To: <20250318145707.GX9311@nvidia.com>
References: <20250307005830.65293-1-ptyadav@amazon.de>
	<20250307005830.65293-2-ptyadav@amazon.de>
	<20250307-sachte-stolz-18d43ffea782@brauner> <mafs0ikokidqz.fsf@amazon.de>
	<20250309-unerwartet-alufolie-96aae4d20e38@brauner>
	<20250317165905.GN9311@nvidia.com>
	<20250318-toppen-elfmal-968565e93e69@brauner>
	<20250318145707.GX9311@nvidia.com>
Date: Tue, 18 Mar 2025 23:02:31 +0000
Message-ID: <mafs0a59i3ptk.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 18 2025, Jason Gunthorpe wrote:

> On Tue, Mar 18, 2025 at 03:25:25PM +0100, Christian Brauner wrote:
>
>> > It is not really a stash, it is not keeping files, it is hardwired to
>> 
>> Right now as written it is keeping references to files in these fdboxes
>> and thus functioning both as a crippled high-privileged fdstore and a
>> serialization mechanism. 
>
> I think Pratyush went a bit overboard on that, I can see it is useful
> for testing, but really the kho control FD should be in either
> serializing or deserializing mode and it should not really act as an
> FD store.
>
> However, edge case handling makes this a bit complicated. 
>
> Once a FD is submitted to be serialized that FD has to be frozen and
> can't be allowed to change anymore.
>
> If the kexec process aborts then we need to unwind all of this stuff
> and unfreeze all the FDs.

I do think I might have went a bit overboard, but this was one of the
reasons for doing so. Having the struct file around, and having the
ability to map it back in allowed for kexec failure to be recoverable
easily and quickly.

I suppose we can serialize all FDs when the box is sealed and get rid of
the struct file. If kexec fails, userspace can unseal the box, and FDs
will be deserialized into a new struct file. This way, the behaviour
from userspace perspective also stays the same regardless of whether
kexec went through or not. This also helps tie FDBox closer to KHO.

The downside is that the recovery time will be slower since the state
has to be deserialized, but I suppose kexec failure should not happen
too often so that is something we can live with.

What do you think about doing it this way?

>
> It sure would be nice if the freezing process could be managed
> generically somehow.
>
> One option for freezing would have the kernel enforce that userspace
> has closed and idled the FD everywhere (eg check the struct file
> refcount == 1). If userspace doesn't have access to the FD then it is
> effectively frozen.

Yes, that is what I want to do in the next revision. FDBox itself will
not close the file descriptors when you put a FD in the box. It will
just grab a reference and let the userspace close the FD. Then when the
box is sealed, the operation can be refused if refcount != 1.

>
> In this case the error path would need to bring the FD back out of the
> fdbox.
>
> Jason
>

-- 
Regards,
Pratyush Yadav

