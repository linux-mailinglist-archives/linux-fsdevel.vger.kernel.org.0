Return-Path: <linux-fsdevel+bounces-70969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8412FCAD036
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 12:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E480A304A7C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0FD31283F;
	Mon,  8 Dec 2025 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBTQcGYW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD524677A;
	Mon,  8 Dec 2025 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765193806; cv=none; b=ZQCKrFPWVZgvJD4JL5UuRSwUyfnXekqM3VithxgyB7ddhAED2lyy2KgkltEOFRGJYB5ZcdP4yJW9JsQm1KjEn53en/Fnh6ceHY23D3Oc2eddGmePUWt/GALWUpuJFWbCtxyD6x+WU11Kz7yGGg3NDWg3toTQBKwU1ND68SHJpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765193806; c=relaxed/simple;
	bh=YNWal0I/AH1LFdEiVmw8rnxCMpBAtc16rJQWMT3Zsk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=era4ICa0NMQp0Mkh5VMUnkHOGBkUUpGSBGa9Tn/iDWJnSu2pL8elOx/+7R6GZMpnNMbgjmjYOmllacPNkVEq/mTibzqcNSdlaTUgudN9mJzREofenZkc+qOFRzPOkGBceRxaDTBGuvm5ORRWO8yMyvlVmULV+KKdFB+XfaiY4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBTQcGYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF129C4CEF1;
	Mon,  8 Dec 2025 11:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765193806;
	bh=YNWal0I/AH1LFdEiVmw8rnxCMpBAtc16rJQWMT3Zsk4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SBTQcGYWwGF9rF2zFHEDI6g91h/lU/t6xv/fGssMyKgesFbdb3KEjo7838vl+6w5G
	 Xi4HCMSErMIo7K0aeUdZBDZ3UxAnc+W7x5FJzRCro5HZZETB454E/hcqn6ug648KI3
	 mKf6fmjwZqKTCEhdA/C6jnI+9Dx4oe1cbpCTbx12iDeZu0++7HhcpuRfROlBPAfnv2
	 45dbykMlhmAFwtH2ThLZOIBPnN7dqIztWGzSeo51l5eukd1joYMtuJEZAw+IGaRAyC
	 r/SMmASxmcQtiFvq93gv23WMpVGzKKwf9CQ3TMrUoqrAF0vgH67BdSm6bTceiV7vxr
	 QwAl2pVezgJxg==
Message-ID: <ecac9bc7-d048-44cb-ae49-f380cd180e55@kernel.org>
Date: Mon, 8 Dec 2025 12:36:42 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] lib: xarray: free unused spare node in
 xas_create_range()
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, willy@infradead.org,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 dev.jain@arm.com, janak@mpiricsoftware.com, shardulsb08@gmail.com
References: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
 <d651e943-99f5-431e-a67d-e4e6784e720e@kernel.org>
 <edc1773d7d2e36682f607549a1f69b1bc503f72e.camel@mpiricsoftware.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <edc1773d7d2e36682f607549a1f69b1bc503f72e.camel@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> -restore:
>> -       xas->xa_shift = shift;
>> -       xas->xa_sibs = sibs;
>> -       xas->xa_index = index;
>> -       return;
>> -success:
>> -       xas->xa_index = index;
>> -       if (xas->xa_node)
>> -               xas_set_offset(xas);
>> +       if (success) {
>> +               xas->xa_index = index;
>> +               if (xas->xa_node)
>> +                       xas_set_offset(xas);
>> +       } else {
>> +               xas->xa_shift = shift;
>> +               xas->xa_sibs = sibs;
>> +               xas->xa_index = index;
>> +       }
>> +       /* Free any unused spare node from xas_nomem() */
>> +       xas_destroy(xas);
>>    }
>>    EXPORT_SYMBOL_GPL(xas_create_range);
>>
>>
> Your bool-based version reads nicer; I’m happy to follow up with a
> small cleanup patch on top that switches xas_create_range() over to
> that style (with a Suggested-by tag).

Yeah, feel free to send a cleanup out that removes some of these labels
(doesn't necessarily have to be what I proposed).

-- 
Cheers

David

