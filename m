Return-Path: <linux-fsdevel+bounces-43442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CACFA56ADB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6946718965F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAD621B91D;
	Fri,  7 Mar 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="NE959u44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330B16EB4C;
	Fri,  7 Mar 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359117; cv=none; b=kztu7N7BC8Ry7bQ2iDQMjzxMH75mHs07vysT/PsiEDAZz/9y9XSLAv4Ja1O3xqNnfXnbMRHDte9pYr1/zgMImOGMi/rVzSCyqvvpzrSB5aDTFL8QH52cAM8qj2ra+2Axy4rYwk6+6UAqYaUzpI128Utnvf0FthYAub3c5dxEbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359117; c=relaxed/simple;
	bh=kwfQ2viZjcJs4DWec3iIl/eL5neUFf9mbp0VO8UcQUQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kowPXe8f346yJ8JvRsPqsvzF/aUmmtgj0W9aMF2a3UMSD+8pLlVGkOCrMcy+RRQ831m7A/19urlhcF1LP07lzDAF3v8DGk15ynpPECSbLgTcHADIdJcI3deANU1OWIEkX8btFoX4/CehI6xW6we/5rNeUtggbu1SHOtjTbNBuN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=NE959u44; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1741359116; x=1772895116;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=YDJ9NWJiqHjkYZ5kkjUyY//2AUUucA49vpJJTDMiXuQ=;
  b=NE959u44me11s+jPOqC7eSuIDyEOGPkABrvLqNrP6lNgoTD0IKB2Gl7W
   UtV/EIttXWdhr3oofE+mAeJ3bvVjR2swLmxKNQR5p+aUm1pfeuRO8bZqR
   GzolyU0uPYh9tRvO64FW/P9MNkEpCr5Tv3mi8tyhjux6YCVpCklyXx7sF
   w=;
X-IronPort-AV: E=Sophos;i="6.14,229,1736812800"; 
   d="scan'208";a="29462509"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:51:46 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:39887]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.188:2525] with esmtp (Farcaster)
 id 70f3b09f-6ea4-4e19-a874-e38a86bb3a3b; Fri, 7 Mar 2025 14:51:41 +0000 (UTC)
X-Farcaster-Flow-ID: 70f3b09f-6ea4-4e19-a874-e38a86bb3a3b
Received: from EX19D014EUA002.ant.amazon.com (10.252.50.103) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 14:51:35 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D014EUA002.ant.amazon.com (10.252.50.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 14:51:35 +0000
Received: from email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 14:51:34 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com (Postfix) with ESMTP id 28866A5C5F;
	Fri,  7 Mar 2025 14:51:34 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id B17484F83; Fri,  7 Mar 2025 14:51:33 +0000 (UTC)
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
In-Reply-To: <87ikok7wf4.fsf@trenco.lwn.net>
References: <20250307005830.65293-1-ptyadav@amazon.de>
	<20250307005830.65293-3-ptyadav@amazon.de> <87ikok7wf4.fsf@trenco.lwn.net>
Date: Fri, 7 Mar 2025 14:51:33 +0000
Message-ID: <mafs0v7skj3m2.fsf@amazon.de>
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
>> With FDBox in place, add documentation that describes what it is and how
>> it is used, along with its UAPI and in-kernel API.
>>
>> Since the document refers to KHO, add a reference tag in kho/index.rst.
>>
>> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
>> ---
>>  Documentation/filesystems/locking.rst |  21 +++
>>  Documentation/kho/fdbox.rst           | 224 ++++++++++++++++++++++++++
>>  Documentation/kho/index.rst           |   3 +
>>  MAINTAINERS                           |   1 +
>>  4 files changed, 249 insertions(+)
>>  create mode 100644 Documentation/kho/fdbox.rst
>
> Please do not create a new top-level directory under Documentation for
> this; your new file belongs in userspace-api/.

I did not. The top-level directory comes from the KHO patches [0] (not
merged yet). This series is based on top of those. You can find the full
tree here [1].

Since this is closely tied to KHO I found it a good fit for putting it
on KHO's directory. I don't have strong opinions about this so don't
mind moving it elsewhere if you think that is better.

>
> From a quick perusal of your documentation:
>
> - You never say what "KHO" is

fdbox.rst has a reference to Documentation/kho/index.rst which does
explain what Kexec Handover (KHO) means. Due to the ref to the top-level
heading, the rendered text looks like:

>     The primary purpose of FDBox is to be used with Kexec Handover Subsystem.
                    This is a link to kho/index.rst   ^^^^^^^^^^^^^^^^^^^^^^^^

IMO that is enough explanation, and there would be little benefit in
duplicating the explanation for KHO. Do you still think a one or two
line explanation is warranted here?

>
> - Your boxes live in a single global namespace?

Yes. Should they not? FWIW, the boxes are in a global namespace, but
each box has a namespace of its own for naming FDs. All FD names in a
single box should be unique but the same FD name can be used in two
different boxes.

>
> - What sort of access control applies to one of these boxes?  What keeps
>   me from mucking around inside somebody else's box?

For now, none. You need CAP_SYS_ADMIN to be able to muck around with a
box. The current idea is that we only let root use it and if more a fine
grained permission model needed it can be done in userspace, or we can
extend our permission model later.

[0] https://lore.kernel.org/lkml/20250206132754.2596694-10-rppt@kernel.org/
[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/tree/Documentation/kho?h=kho

-- 
Regards,
Pratyush Yadav

