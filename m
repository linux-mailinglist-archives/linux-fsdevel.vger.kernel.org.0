Return-Path: <linux-fsdevel+bounces-43495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CBFA57600
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 00:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1BE77A8047
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 23:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26E259C89;
	Fri,  7 Mar 2025 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="rOprVQmb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217951FECB6;
	Fri,  7 Mar 2025 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390111; cv=none; b=EjglQvNKTgWKcPR1Yp4axvVzWRWsCd9Y9rnjGaZ1Yf0L+dkj3G2m6yhiR9YD80I9Y44ayMbKXVKWI7j7XVIpXLSHKmraFAgx9U4AMc/78oPFUZzn5zWAR1Micw8UTAMwfRpjSp4y4BxcbJcwjtXRwpPZFFXn3AiutX6kt9fY/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390111; c=relaxed/simple;
	bh=UeOROIuHxrOSWLbOE95MlbOgZCV+/mmsFcLLjNmWGY4=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G7HbZYPV7iZoJ9tJ3XLTWZ59Wg/JSCpUlNxdKFFOAr1TKOKHKS/GdKXtbEIv94tPtvfpyrNz/B7NYjTuYsNH5v/csA3f/W6SUcjcSF+xS5Mhou+8Huwtx6ipzMyHeSGDFaEpE2mOaHLpAmfDZWcLBF6x1vSv90hzQ8fBSjq/184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=rOprVQmb; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1741390111; x=1772926111;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=PxKleB6Wh7ZXzq2XCt1pO6Tm9zMapmQjwJkScUHeXmc=;
  b=rOprVQmbX4pYqWHAuAAkdjzvrYvRBvO+ZmrB4IwQSEiogtiF5hr7974P
   Sdwb4UJ9aetXbXGVgB54FN0ZKcscr8F+EXyYmc61TMMlqBZCMFsk3fAAn
   Eputg48XzRd20Uq3VduU26neFPpaMODq2j6ktmsd9mHSkt8LWeHe8KWOK
   k=;
X-IronPort-AV: E=Sophos;i="6.14,230,1736812800"; 
   d="scan'208";a="805364181"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 23:28:24 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:22470]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.39:2525] with esmtp (Farcaster)
 id fbb96d7f-d3b0-45f3-bcea-de6963836fbc; Fri, 7 Mar 2025 23:28:23 +0000 (UTC)
X-Farcaster-Flow-ID: fbb96d7f-d3b0-45f3-bcea-de6963836fbc
Received: from EX19D020UWA004.ant.amazon.com (10.13.138.231) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 23:28:23 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D020UWA004.ant.amazon.com (10.13.138.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 23:28:22 +0000
Received: from email-imr-corp-prod-iad-all-1b-1323ce6b.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 23:28:22 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-iad-all-1b-1323ce6b.us-east-1.amazon.com (Postfix) with ESMTP id 57D4C4354C;
	Fri,  7 Mar 2025 23:28:22 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 1583C4F0F; Fri,  7 Mar 2025 23:28:22 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Jonathan Corbet <corbet@lwn.net>
CC: <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Hugh
 Dickins" <hughd@google.com>, Alexander Graf <graf@amazon.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, David Woodhouse
	<dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, Mike Rapoport
	<rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
	<tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, "Dave
 Hansen" <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Wei Yang
	<richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH 2/5] misc: add documentation for FDBox
In-Reply-To: <87ecz87tik.fsf@trenco.lwn.net>
References: <20250307005830.65293-1-ptyadav@amazon.de>
	<20250307005830.65293-3-ptyadav@amazon.de> <87ikok7wf4.fsf@trenco.lwn.net>
	<mafs0v7skj3m2.fsf@amazon.de> <87ecz87tik.fsf@trenco.lwn.net>
Date: Fri, 7 Mar 2025 23:28:22 +0000
Message-ID: <mafs0msdwifop.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 07 2025, Jonathan Corbet wrote:

> Pratyush Yadav <ptyadav@amazon.de> writes:
>
>> On Fri, Mar 07 2025, Jonathan Corbet wrote:
>>
>>> Pratyush Yadav <ptyadav@amazon.de> writes:
>>>
>>>> With FDBox in place, add documentation that describes what it is and how
>>>> it is used, along with its UAPI and in-kernel API.
>>>>
>>>> Since the document refers to KHO, add a reference tag in kho/index.rst.
>>>>
>>>> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
>>>> ---
>>>>  Documentation/filesystems/locking.rst |  21 +++
>>>>  Documentation/kho/fdbox.rst           | 224 ++++++++++++++++++++++++++
>>>>  Documentation/kho/index.rst           |   3 +
>>>>  MAINTAINERS                           |   1 +
>>>>  4 files changed, 249 insertions(+)
>>>>  create mode 100644 Documentation/kho/fdbox.rst
>>>
>>> Please do not create a new top-level directory under Documentation for
>>> this; your new file belongs in userspace-api/.
>>
>> I did not. The top-level directory comes from the KHO patches [0] (not
>> merged yet). This series is based on top of those. You can find the full
>> tree here [1].
>>
>> Since this is closely tied to KHO I found it a good fit for putting it
>> on KHO's directory. I don't have strong opinions about this so don't
>> mind moving it elsewhere if you think that is better.
>
> I've not seen the KHO stuff, but I suspect I'll grumble about that too.
> Our documentation should be organized for its audience, not for its
> authors.  So yes, I think that your documentation of the user-space
> interface should definitely go in the userspace-api book.

Okay, fair enough. I'll move it there.

>
> Thanks,
>
> jon
>
> (Who now realizes he has been arguing this point of view for over ten
> years ... eventually it will get across... :)

-- 
Regards,
Pratyush Yadav

