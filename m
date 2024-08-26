Return-Path: <linux-fsdevel+bounces-27098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF5095E944
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B071F215F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 06:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB66A83CD9;
	Mon, 26 Aug 2024 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westnet.com.au header.i=@westnet.com.au header.b="XZ8Abl1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from omr11.pc5.atmailcloud.com (omr11.pc5.atmailcloud.com [54.253.16.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40C84A2C
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.253.16.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655213; cv=none; b=L9Gnd5lwRZ4NlihwubCJ062cSCEj9ZzCcA30bjgkGG+U94lV/Z2/srS/rbbIdceG0g3KQCxs/GPIdcavQN2pdCjcFZK6fKVCwqatHbFu0wMU3rebdT0Xv5iUwJgF9hxDzuOUhOb0+AZrrI+qg4GR1fUyX+wGN8rlup5b9nelzzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655213; c=relaxed/simple;
	bh=SZOB2GzfM2HiMg5u1k8b1oB/Ag1ANxaOyBlqewizrC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlCuqT4zgpyAJKNNAIwrv1LmtDl/hMsD0b5ltMbHjaQ8CHr3VFXZSlbG/wYuybjAN88w1A490cYAjcREekCsDMUEbiLPcBEgBMXcHiR5PpR3O7XH4hfuUmsBJupQcJI6lKPqyriMRBsNt0aIMUp9WHA0TBZpUuFiItgHbjp8b1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=westnet.com.au; spf=pass smtp.mailfrom=westnet.com.au; dkim=pass (2048-bit key) header.d=westnet.com.au header.i=@westnet.com.au header.b=XZ8Abl1I; arc=none smtp.client-ip=54.253.16.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=westnet.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westnet.com.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=westnet.com.au; s=202309; h=Content-Type:From:To:Subject:MIME-Version:Date:
	Message-ID; bh=QEUtMFqzmR/dVBXiS7+67J7iA6ElXTXjVcFhUdzJdJM=; b=XZ8Abl1IBN0hnX
	KzlJwKKadUBuz2T9Lse2YwcmolWgvMd9MzWh91lMVyuKZVdLoneMvOeOsQgEo4E7L+2RQIB+LvAEX
	OoVfucY+eIq35YqhddoX1arQLtg5aT+DAyYoRMjD0OGyRINkBTzOqilNXV9dAud8JA6Xta/E7wkTF
	Kb26g43Mf5uqq77xF6nnK98b/J7Wc44SPiLP776YYKkScPZUv6DpOOTn+SSq9VP504Cg0idYfLsKk
	eLE3xeR/tR7uutK1WYytOq6c0jkkNcq/cEE/0owgcKj3C587Fu92Qs0rHeNKjcAcffvVnUW27ZL4m
	C3MlSsPAoQS7iKZcLRiA==;
Received: from CMR-KAKADU04.i-0c3ae8fd8bf390367
	 by OMR.i-0e491b094b8af55fe with esmtps
	(envelope-from <gregungerer@westnet.com.au>)
	id 1siOci-0008OB-El;
	Mon, 26 Aug 2024 01:34:24 +0000
Received: from [202.125.30.52] (helo=[192.168.0.22])
	 by CMR-KAKADU04.i-0c3ae8fd8bf390367 with esmtpsa
	(envelope-from <gregungerer@westnet.com.au>)
	id 1siOch-00085B-2t;
	Mon, 26 Aug 2024 01:34:24 +0000
Message-ID: <ca926bdf-906c-472f-b240-79997ccf86a9@westnet.com.au>
Date: Mon, 26 Aug 2024 11:34:21 +1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] romfs: Convert romfs_read_folio() to use a folio
To: Christian Brauner <brauner@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
References: <20240530202110.2653630-1-willy@infradead.org>
 <20240530202110.2653630-13-willy@infradead.org>
 <597dd1bb-43ee-4531-8869-c46b38df56bd@westnet.com.au>
 <ZrmBvo6c1N7YnJ6y@casper.infradead.org>
 <bafe6129-209b-4172-996e-5d79389fc496@westnet.com.au>
 <Zr0GTnPHfeA0P8nb@casper.infradead.org>
 <20240815-geldentwertung-riechen-0d25a2121756@brauner>
Content-Language: en-US
From: Greg Ungerer <gregungerer@westnet.com.au>
In-Reply-To: <20240815-geldentwertung-riechen-0d25a2121756@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Atmail-Id: gregungerer@westnet.com.au
X-atmailcloud-spam-action: no action
X-Cm-Analysis: v=2.4 cv=S+DfwpsP c=1 sm=1 tr=0 ts=66cbdba0 a=7K0UZV/HFv9j2j1oDe/kdQ==:117 a=7K0UZV/HFv9j2j1oDe/kdQ==:17 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=80-xaVIC0AIA:10 a=x7bEGLp0ZPQA:10 a=SDW7Ul2gMjjPdDcMQk0A:9 a=QEXdDO2ut3YA:10
X-Cm-Envelope: MS4xfKTUFMZ5/MKH0kOrrsOtOSkcSHJoVNcsbT80Bc915Jg2OOgFkai3mMlxL+CXVpCRdoQlW/eTeEyWA9yCAthK1EeJ/FRWfAXWULqtH/37VchHnlV2hTgU u2GkZ/xEwNh30ho92eKmgw4yEfQR70/XoUkLcY4CesJfP5WliqykyHBwKip6wkkpjBDBDikDwV1Q2A==
X-atmailcloud-route: unknown


On 15/8/24 22:42, Christian Brauner wrote:
> On Wed, Aug 14, 2024 at 08:32:30PM GMT, Matthew Wilcox wrote:
>> On Mon, Aug 12, 2024 at 02:36:57PM +1000, Greg Ungerer wrote:
>>> Yep, that fixes it.
>>
>> Christian, can you apply this fix, please?
>>
>> diff --git a/fs/romfs/super.c b/fs/romfs/super.c
>> index 68758b6fed94..0addcc849ff2 100644
>> --- a/fs/romfs/super.c
>> +++ b/fs/romfs/super.c
>> @@ -126,7 +126,7 @@ static int romfs_read_folio(struct file *file, struct folio *folio)
>>   		}
>>   	}
>>   
>> -	buf = folio_zero_tail(folio, fillsize, buf);
>> +	buf = folio_zero_tail(folio, fillsize, buf + fillsize);
>>   	kunmap_local(buf);
>>   	folio_end_read(folio, ret == 0);
>>   	return ret;
> 
> Yep, please see #vfs.fixes. The whole series is already upstream.

Just a heads up, this is still broken in 6.11-rc5.

