Return-Path: <linux-fsdevel+bounces-63399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F36ABB82A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 23:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1292819E4EFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278D125A357;
	Fri,  3 Oct 2025 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGNTKeQm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B08D22154B;
	Fri,  3 Oct 2025 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525512; cv=none; b=ugDKniTBG1VfaBQtRIauzGC8PpoeF5aCnGlno4jmHQqBVBmkDkBBTxUzLs0r2r/4b3RdYLs6dhGgNDZLX4AeSDT9lUKeebAu1lv2mugqGhyX07y5xN+C5U+DLkO4NjlCpnN6y0h/rQenLB13ZNIrhMxtCUFBZZ5Eb2hFb74SIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525512; c=relaxed/simple;
	bh=sc94Ij1DkX9t7P+TP2AG8M5dKK22AJnJHXFzH3zXXFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1GsEJQ5R7He4UgcereeTr2KfVI4qTHupqu53YwOHiVJYc4HWaXNpzpDCCIz+ZC+Ut/FyclQHfMg9fj0TFO3NTqV1sJEsx7SJ9uApXq67zQb77dClnT2BFaErZXQeHNgCLQbYIMUM830HV1pXtjJsn1WDZWl3IQ+ISuQ560fu3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGNTKeQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5578EC4CEF5;
	Fri,  3 Oct 2025 21:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759525511;
	bh=sc94Ij1DkX9t7P+TP2AG8M5dKK22AJnJHXFzH3zXXFc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WGNTKeQm9E4HAjk2CiuOq231Zuuo9bwOkuq831NeVRg1B13pQJLjPsPLEUGeGlNXF
	 t25BnVM2Trm6xVwk6stIVsvXdfbfR371X3XfR92Lqdx8askDU1nCuQ23X2f8TRFSod
	 jtMARjihSWA2vFr930+sHbXbQr0gIQ97wHivEtw1OpbuB4DDfANFMU/mk0PPs534+t
	 RudUUz6GS//tuhKit/CQ9qSei04vERJRGVHftty8TpGMuBME1q2Hpll4XfEGjsrKvO
	 Jh8QKInROxHwFizd8gzWTuleCkJKq6LL2R+viwOfAhtfsX9l9HlQhDiMiERA7GRr2Z
	 qO3bs9M8k17zQ==
Message-ID: <4a31ae5c-ddb2-40ae-ae8d-747479da69e3@kernel.org>
Date: Fri, 3 Oct 2025 17:05:09 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Volker Lendecke
 <Volker.Lendecke@sernet.de>, CIFS <linux-cifs@vger.kernel.org>
References: <20250925151140.57548-1-cel@kernel.org>
 <CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
 <87tt0gqa8f.fsf@mailhost.krisman.be>
 <28ffeb31-beec-4c7a-ad41-696d0fd54afe@kernel.org>
 <87plb3ra1z.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <87plb3ra1z.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/25 4:43 PM, Gabriel Krisman Bertazi wrote:
> Chuck Lever <cel@kernel.org> writes:
> 
>> On 10/3/25 11:24 AM, Gabriel Krisman Bertazi wrote:

>>> Does the protocol care about unicode version?  For userspace, it would
>>> be very relevant to expose it, as well as other details such as
>>> decomposition type.
>>
>> For the purposes of indicating case sensitivity and preservation, the
>> NFS protocol does not currently care about unicode version.
>>
>> But this is a very flexible proposal right now. Please recommend what
>> you'd like to see here. I hope I've given enough leeway that a unicode
>> version could be provided for other API consumers.
> 
> But also, encoding version information is filesystem-wide, so it would
> fit statfs.

ext4 appears to have the ability to set the case folding behavior
on each directory, that's why I started with statx.


-- 
Chuck Lever

