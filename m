Return-Path: <linux-fsdevel+bounces-29581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E4997AFAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 13:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865D41F234B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08E167D98;
	Tue, 17 Sep 2024 11:25:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EDB15820F;
	Tue, 17 Sep 2024 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726572322; cv=none; b=TXdDg/0zAw/OuYK+Zp4xhNzT95hgsqHqyqMbg9CfPftDDxwD94jSM+pqvfIQ2R4ZKNKMn77kusXCmUk1dCRgzgiWz7UqtT3j4hN1TwcexK/tU5nnxC36C8wz+BfDEiup7Bv35CdEknyQZy/HodzSEUzRVoTxN3l6zF++dz6ghlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726572322; c=relaxed/simple;
	bh=BYmFY8dLUIgAp4G3c1WMS+OnWT811CxQviKlYhUbkAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wri9GoVmR1jXonfdOVr6NrOhm9ueC7UR94VBFdtpcWllnfBM0zUYoDSZzPZ2gospp5mV9+BIAmDc7LffqZtMyEnJE0yCluhd4Pfw7Gq2lIYBezTN+0c/eojj+TUu9jhRB39v8eRIamHYtw+DUUQGDn6mXQXfUU7RPU1HhFizWIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7E381007;
	Tue, 17 Sep 2024 04:25:48 -0700 (PDT)
Received: from [10.163.61.158] (unknown [10.163.61.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA1E23F66E;
	Tue, 17 Sep 2024 04:25:13 -0700 (PDT)
Message-ID: <06703362-23d3-4554-ab33-e81960e7d41f@arm.com>
Date: Tue, 17 Sep 2024 16:55:11 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/7] x86/mm: Drop page table entry address output from
 pxd_ERROR()
To: Dave Hansen <dave.hansen@intel.com>, David Hildenbrand
 <david@redhat.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
 <20240917073117.1531207-3-anshuman.khandual@arm.com>
 <c4fe25e3-9b03-483f-8322-3a17d1a6644a@redhat.com>
 <be3a44a3-7f33-4d6b-8348-ed6b8c3e7b49@intel.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <be3a44a3-7f33-4d6b-8348-ed6b8c3e7b49@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/24 16:49, Dave Hansen wrote:
> On 9/17/24 03:22, David Hildenbrand wrote:
>> Not a big fan of all these "bad PTE" thingies ...
> 
> In general?
> 
> Or not a big fan of the fact that every architecture has their own
> (mostly) copied-and-pasted set?

Right, these pxd_ERROR() have similar definitions across platforms,
(often the exact same) something that could be converged into common
generic ones instead.

