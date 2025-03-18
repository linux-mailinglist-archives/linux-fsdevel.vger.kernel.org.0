Return-Path: <linux-fsdevel+bounces-44350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF4A67C81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 20:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F16882843
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02817207DEA;
	Tue, 18 Mar 2025 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLR9knhl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9361531E1;
	Tue, 18 Mar 2025 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324493; cv=none; b=rMCUU9sbQuOl4yqvPqLWNkXbwa9RiJTRUIs5cbAXAuE1lul41z/kW2A1Pe1sWhoGNPC7/+Rz06JkVEBnJYy//B2uO/6zOFLdSqpctN10lMt4DDvrPLZeBmfqryOPmFM6sE1BvYke7ws2HG8LS20uUF7surPjvNTAYOW2pH30Wz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324493; c=relaxed/simple;
	bh=OMs5aVL4NRSgKrZLoPZm/15L2U76ZKU/MNbrAGOy48U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8hFtyqpcmrWSTj0Tbjzpe6o0b96uiE8POqPI0FAsbPEXUIkXCZt+jFTQN3RO/KyOMlbpEkY+W/8gewXw0E4NrlbqGm6OJoygZA+LgXtC786k2qHnsJONfc8v47PmBWhVoTT0WkU0RuDX3oCpP+8mykqLqWMEJwtiadbHD+cLEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLR9knhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82242C4CEDD;
	Tue, 18 Mar 2025 19:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742324492;
	bh=OMs5aVL4NRSgKrZLoPZm/15L2U76ZKU/MNbrAGOy48U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TLR9knhlXaKWd9luXt/2WM7Q7XTjrQBUJ5wWA9Ej5P10+0fo9UplOwk7NJmnw4QXo
	 a2gvS0v58NzaAqIK1aNoE/wDecHLHP8l+nMC/a2ys1FZVOM6WW0dBJxx6nRYelY930
	 WS+6XWHhk8CO0s6KU3zooM5YFNUCqtgBeAM3rsdtfREUvNZ2rqI7MpEJFSQDz5MJOO
	 FVWVjUGbWdXA0G8xosl0i30HJzIlWpdM5ILep16gi6kARzZEDQnj9m3Sr6LOlH4Jfw
	 nV4w7FwFpFzCBUHJO0s4uDKeVxu9a3R+lXXlfasUNglFHoQ8PUXiP8xlT0YHYn2dWF
	 NBqKkygpm4jFQ==
Message-ID: <ebba0044-053c-4d72-8ea1-e8c1f2bf0a96@kernel.org>
Date: Tue, 18 Mar 2025 20:01:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] initramfs: Add size validation to prevent tmpfs
 exhaustion
To: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>,
 David Disseldorp <ddiss@suse.de>
Cc: "jsperbeck@google.com" <jsperbeck@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "lukas@wunner.de" <lukas@wunner.de>,
 "wufan@linux.microsoft.com" <wufan@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <BYAPR12MB3205F96E780AA2F00EAD16E8D5D22@BYAPR12MB3205.namprd12.prod.outlook.com>
 <20250317182157.7adbc168.ddiss@suse.de>
 <872d008e-8412-4351-a954-29ee7c7c8315@kernel.org>
 <BYAPR12MB320544939A73966CC84D5020D5DE2@BYAPR12MB3205.namprd12.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <BYAPR12MB320544939A73966CC84D5020D5DE2@BYAPR12MB3205.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/03/2025 13:46, Stephen Eta Zhou wrote:
> Hi Krzysztof
> 
>> Just in case before anyone tries to actually apply it: the entire patch
>> has both corrupted header and actual patch is corrupted - all
>> indentation messed.
> 
> Sorry, this is my oversight.....
> I checked it locally using checkpatch.pl and it was fine, but I just used it to import and found that there is a problem. Sorry for wasting your time. I will regenerate this patch and resend it in the correct format.
> 
> Krzysztof, thanks for pointing this out.
> 
> Thanks,
> Stephen
> ________________________________________
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Tuesday, March 18, 2025 19:55
> To: David Disseldorp <ddiss@suse.de>; Stephen Eta Zhou <stephen.eta.zhou@outlook.com>
> Cc: jsperbeck@google.com <jsperbeck@google.com>; akpm@linux-foundation.org <akpm@linux-foundation.org>; gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>; lukas@wunner.de <lukas@wunner.de>; wufan@linux.microsoft.com <wufan@linux.microsoft.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-fsdevel@vger.kernel.org <linux-fsdevel@vger.kernel.org>
> Subject: Re: [RFC PATCH] initramfs: Add size validation to prevent tmpfs exhaustion
>  
What is this header doing this? Use standard mailing list response
style, not some copy-paste and then quote entire irrelevant context.

Best regards,
Krzysztof

