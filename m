Return-Path: <linux-fsdevel+bounces-45110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6D1A72579
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 23:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F1B7A42AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 22:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E611263F2C;
	Wed, 26 Mar 2025 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="HFvMYwIT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826F82899;
	Wed, 26 Mar 2025 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028841; cv=none; b=bt5+nQr5ImN570jFlL95yGkdpNayJ4I/1STmf/miqynOKd23vHdBXbj+I47Rov4OiWu/O81zyqweoPk3EraV7iSWcSeo7XOnS3Q9q4fgoRvCqZf8SeeFvKpWQ0dGfZMWPZ8tKSeiM6W30ScloaZaf5cFwAWaTSEr6XWDH7Jmzlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028841; c=relaxed/simple;
	bh=5BDxA3HqxThMPERYGuOk5WsAA0Pr9oqn94iYzC4t9ds=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FAAqvry0ydI7RfXMqgc9l/c9MuRNE1ayp+1OfI64dlJhqDfEFBnNxMmaMA5KcErlZVnfK4XnNiQDUQfT+ZMoxTflSZ1mOA+ayUxyTh2+9eMOj8c9y/MRdCq1TckKyGFCvtSc2PFLymRzpn68lWuRMScDtzRwrg27M+8qoYZua+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=HFvMYwIT; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1743028840; x=1774564840;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=clwLN2YhLA41I0snKPHwdNicUbCluLtbHF3lSV2GSW8=;
  b=HFvMYwITu1DMsDJTcI2+xWAoXH6btVNEFXlHXwU++WffrmMG7lrMCwP7
   NHGZ8UoaBPKuCBvVcVx8epA/c7Hd4yfFPL1crVOjfoOOi+qn8T4sjd0mU
   Rk9tJjzKSG5Krte4RYIUANr4LJ4RWAznULcwp1Hg42V8/abX0O7AF65ul
   4=;
X-IronPort-AV: E=Sophos;i="6.14,279,1736812800"; 
   d="scan'208";a="708491672"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 22:40:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:62713]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.254:2525] with esmtp (Farcaster)
 id 21996b69-f902-4603-9409-820b1efec001; Wed, 26 Mar 2025 22:40:33 +0000 (UTC)
X-Farcaster-Flow-ID: 21996b69-f902-4603-9409-820b1efec001
Received: from EX19D020UWC002.ant.amazon.com (10.13.138.147) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Mar 2025 22:40:31 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D020UWC002.ant.amazon.com (10.13.138.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Mar 2025 22:40:30 +0000
Received: from email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 22:40:30 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com (Postfix) with ESMTP id 363B540391;
	Wed, 26 Mar 2025 22:40:30 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id E67211568; Wed, 26 Mar 2025 22:40:29 +0000 (UTC)
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
In-Reply-To: <20250320121459.GS9311@nvidia.com>
References: <20250307005830.65293-2-ptyadav@amazon.de>
	<20250307-sachte-stolz-18d43ffea782@brauner> <mafs0ikokidqz.fsf@amazon.de>
	<20250309-unerwartet-alufolie-96aae4d20e38@brauner>
	<20250317165905.GN9311@nvidia.com>
	<20250318-toppen-elfmal-968565e93e69@brauner>
	<20250318145707.GX9311@nvidia.com> <mafs0a59i3ptk.fsf@amazon.de>
	<20250318232727.GF9311@nvidia.com> <mafs05xk53zz0.fsf@amazon.de>
	<20250320121459.GS9311@nvidia.com>
Date: Wed, 26 Mar 2025 22:40:29 +0000
Message-ID: <mafs05xjvs9eq.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 20 2025, Jason Gunthorpe wrote:

> On Wed, Mar 19, 2025 at 01:35:31PM +0000, Pratyush Yadav wrote:
>> On Tue, Mar 18 2025, Jason Gunthorpe wrote:
>> 
>> > On Tue, Mar 18, 2025 at 11:02:31PM +0000, Pratyush Yadav wrote:
>> >
>> >> I suppose we can serialize all FDs when the box is sealed and get rid of
>> >> the struct file. If kexec fails, userspace can unseal the box, and FDs
>> >> will be deserialized into a new struct file. This way, the behaviour
>> >> from userspace perspective also stays the same regardless of whether
>> >> kexec went through or not. This also helps tie FDBox closer to KHO.
>> >
>> > I don't think we can do a proper de-serialization without going
>> > through kexec. The new stuff Mike is posting for preserving memory
>> > will not work like that.
>> 
>> Why not? If the next kernel can restore the file from the serialized
>> content, so can the current kernel. What stops this from working with
>> the new memory preservation scheme (which I assume is the idea you
>> proposed in [0])? 
>
> It is because the current kernel does not destroy the struct page
> before the kexec and the new kernel assumes a zero'd fresh struct page
> at restore.
>
> So it would be very easy to corrupt the struct page information if you
> attempt to deserialize without going through the kexec step.
>
> There would be a big risk of getting things like refcounts out of
> sync.

Ideally, kho_preserve_folio() should be similar to freeing the folio,
except that it doesn't go to buddy for re-allocation. In that case,
re-using those pages should not be a problem as long as the driver made
sure the page was properly "freed", and there are no stale references to
it. They should be doing that anyway since they should make sure the
file doesn't change after it has been serialized.

Doing that might be easier said than done though. On a quick look, most
of the clearing of struct page seems to be happening in
free_pages_prepare(). This is usually followed by free_one_page(), which
gives the page back to buddy. Though I am not sure how much sense it
would make to use free_pages_prepare() outside of page free path. I need
to look deeper...

>
> Then you have the issue that I don't actually imagine shutting down
> something like iommufd, I was intending to leave it frozen in place
> with all its allocations and so on. If you try to de-serialize you
> can't de-serialize into the thing that is frozen, you'd create a new
> one from empty. Now you have two things pointing at the same stuff,
> what a mess.

What do you mean by "frozen in place"? Isn't that the same as being
serialized? Considering that we want to make sure a file is not opened
by any process before we serialize it, what do we get by keeping the
struct file around (assuming we can safely deserialize it without going
through kexec)?

>
>> The seal operation does bulk serialize/deserialize for _one_ box. You
>> can have multiple boxes and distribute your FDs in the boxes based on
>> the serialize or deserialize order you want. Userspace decides when to
>> seal or unseal a particular box, which gives it full control over the
>> order in which things happen.
>
> Why have more than one box? What is the point? I've been thinking we
> should just have a KHO control char dev FD for serializing and you can
> do all the operations people have been talking about in sysfs, as well
> as record FDs for serializing.

Main idea is for logical grouping and dependency management. If some FDs
have a dependency between them, grouping them in different boxes makes
it easy to let userspace choose the order of operations, but still have
a way to make sure all dependencies are met when the FDs are serialized.
Similarly, on the deserialize side, this ensures that all dependent FDs
are deserialized together.

[...]

-- 
Regards,
Pratyush Yadav

