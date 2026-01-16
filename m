Return-Path: <linux-fsdevel+bounces-74168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CEBD3346E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07B383145C51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C2F33ADAA;
	Fri, 16 Jan 2026 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZjUu62X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117533A9E4;
	Fri, 16 Jan 2026 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577949; cv=none; b=jRFn6nJn7VubCBQNZBDdDXR18hCO9qZsrLOWpU5J0hzzViNt8abu1PMfn42CvP88N9V0mV1MNDMDi2gAbNudt4rm6VpIg5rT40409NlLjjUrK/3VE4AY/TpDhJgYWFyyqZExQW04m6ir89h/kKKfIs1B0O+5MN5j8l44HjC+5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577949; c=relaxed/simple;
	bh=tlQ329P2frk1XRIPmlK/A7U392r3EEuohhwQilBcxQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIlikQ7LlhR1quNbLXQL+KRgA/HCOqvr4Yn5L0IMuT2eAmBKMOLXaAoxToNJz6FPKy3KOqVgAbt+CpZwdSkmLKluOgY4RmdRDhu+Jzu1xlC4gBYs1piSQ+NIumIVbHKGagBbRsBO8w9nlnyfcMJgZm2y2PuaSXyC0TOPJrZJQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZjUu62X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC23C116C6;
	Fri, 16 Jan 2026 15:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768577948;
	bh=tlQ329P2frk1XRIPmlK/A7U392r3EEuohhwQilBcxQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OZjUu62XdoPT3Y0ayrO7aIJC6VWRyUQiDyiK9byve1sYqq3/VR7h5seDL1L33u+4f
	 GGqI1EIUfeVIaIPtu7SxUz7mXUuqPGXCctrgfDCtUELB3LHjQc2iDvx0VZ5/IKlmFz
	 9xizCGZe3yYKb9bY1e+7HawWfZmGbxYf3xfh4PZWXQilm4jAF5Qou0/xKt+R31DwUq
	 1s1c/7tOlRK0uk5AWJrflRyjPmNcoZIe6r/Mcmei3H0xpr+ky8W73Cp1ByUvL3BK2Z
	 3T4ZJYC7x/41bfC49RH+yU+X2LI9/71smOOJDUd7yAwu00YDdC4UulI08Zf6BB1kYv
	 PyY/h+zerfg0w==
Message-ID: <d548815e-bab2-4f1a-8c41-003aaf4f7c14@kernel.org>
Date: Fri, 16 Jan 2026 10:38:56 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] nfsd: Convert export flags to use BIT() macro
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <c8735411d66dd7db9c5abb2b5a1c4d9b98ea174a.1768573690.git.bcodding@hammerspace.com>
 <15993494-ddd8-4656-8815-2693ee3b7fb3@app.fastmail.com>
 <8F2645AA-9CB4-44D5-9121-8699216EF7CD@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <8F2645AA-9CB4-44D5-9121-8699216EF7CD@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/26 10:35 AM, Benjamin Coddington wrote:
> On 16 Jan 2026, at 10:31, Chuck Lever wrote:
> 
>> On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
>>> Simplify these defines for consistency, readability, and clarity.
>>>
>>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>>> ---
>>>  fs/nfsd/nfsctl.c                 |  2 +-
>>>  include/uapi/linux/nfsd/export.h | 38 ++++++++++++++++----------------
>>>  2 files changed, 20 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index 30caefb2522f..8ccc65bb09fd 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -169,7 +169,7 @@ static const struct file_operations
>>> exports_nfsd_operations = {
>>>
>>>  static int export_features_show(struct seq_file *m, void *v)
>>>  {
>>> -	seq_printf(m, "0x%x 0x%x\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
>>> +	seq_printf(m, "0x%lx 0x%lx\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
>>>  	return 0;
>>>  }
>>>
>>> diff --git a/include/uapi/linux/nfsd/export.h
>>> b/include/uapi/linux/nfsd/export.h
>>> index a73ca3703abb..4e712bb02322 100644
>>> --- a/include/uapi/linux/nfsd/export.h
>>> +++ b/include/uapi/linux/nfsd/export.h
>>> @@ -26,22 +26,22 @@
>>>   * Please update the expflags[] array in fs/nfsd/export.c when adding
>>>   * a new flag.
>>>   */
>>> -#define NFSEXP_READONLY		0x0001
>>> -#define NFSEXP_INSECURE_PORT	0x0002
>>> -#define NFSEXP_ROOTSQUASH	0x0004
>>> -#define NFSEXP_ALLSQUASH	0x0008
>>> -#define NFSEXP_ASYNC		0x0010
>>> -#define NFSEXP_GATHERED_WRITES	0x0020
>>> -#define NFSEXP_NOREADDIRPLUS    0x0040
>>> -#define NFSEXP_SECURITY_LABEL	0x0080
>>> -/* 0x100 currently unused */
>>> -#define NFSEXP_NOHIDE		0x0200
>>> -#define NFSEXP_NOSUBTREECHECK	0x0400
>>> -#define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests -
>>> just trust */
>>> -#define NFSEXP_MSNFS		0x1000	/* do silly things that MS clients
>>> expect; no longer supported */
>>> -#define NFSEXP_FSID		0x2000
>>> -#define	NFSEXP_CROSSMOUNT	0x4000
>>> -#define	NFSEXP_NOACL		0x8000	/* reserved for possible ACL related use
>>> */
>>> +#define NFSEXP_READONLY			BIT(0)
>>> +#define NFSEXP_INSECURE_PORT	BIT(1)
>>> +#define NFSEXP_ROOTSQUASH		BIT(2)
>>> +#define NFSEXP_ALLSQUASH		BIT(3)
>>> +#define NFSEXP_ASYNC			BIT(4)
>>> +#define NFSEXP_GATHERED_WRITES	BIT(5)
>>> +#define NFSEXP_NOREADDIRPLUS    BIT(6)
>>> +#define NFSEXP_SECURITY_LABEL	BIT(7)
>>> +/* BIT(8) currently unused */
>>> +#define NFSEXP_NOHIDE			BIT(9)
>>> +#define NFSEXP_NOSUBTREECHECK	BIT(10)
>>> +#define NFSEXP_NOAUTHNLM		BIT(11)	/* Don't authenticate NLM requests -
>>> just trust */
>>> +#define NFSEXP_MSNFS			BIT(12)	/* do silly things that MS clients
>>> expect; no longer supported */
>>> +#define NFSEXP_FSID				BIT(13)
>>> +#define NFSEXP_CROSSMOUNT		BIT(14)
>>> +#define NFSEXP_NOACL			BIT(15)	/* reserved for possible ACL related
>>> use */
>>>  /*
>>>   * The NFSEXP_V4ROOT flag causes the kernel to give access only to
>>> NFSv4
>>>   * clients, and only to the single directory that is the root of the
>>> @@ -51,11 +51,11 @@
>>>   * pseudofilesystem, which provides access only to paths leading to
>>> each
>>>   * exported filesystem.
>>>   */
>>> -#define	NFSEXP_V4ROOT		0x10000
>>> -#define NFSEXP_PNFS		0x20000
>>> +#define NFSEXP_V4ROOT			BIT(16)
>>> +#define NFSEXP_PNFS				BIT(17)
>>>
>>>  /* All flags that we claim to support.  (Note we don't support NOACL.) */
>>> -#define NFSEXP_ALLFLAGS		0x3FEFF
>>> +#define NFSEXP_ALLFLAGS			BIT(18) - BIT(8) - 1
>>>
>>>  /* The flags that may vary depending on security flavor: */
>>>  #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
>>> -- 
>>> 2.50.1
>>
>> This might constitute a breaking user space API change. BIT() is
>> a kernel convention. What defines BIT() for user space consumers
>> of this header?
> 
> Doh - good catch.  I can drop this, or maybe add:
> 
> #ifndef BIT
> #define BIT(n) (1UL << (n))
> #endif
I'm happy leaving these as hex constants.


-- 
Chuck Lever

