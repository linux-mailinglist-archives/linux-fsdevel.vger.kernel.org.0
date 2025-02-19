Return-Path: <linux-fsdevel+bounces-42082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A38A3C4EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A6C16932E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A05D1FE44E;
	Wed, 19 Feb 2025 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jDTON8jY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760981F417A
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982186; cv=none; b=H/K0kkd6hzQkGYAdglTM9RE4pn3Maa8uXT2kJ8PpS5oCZ9g7A39UnyuDdwKHgqH1YcWR00Px1dBmuS96hU87miZSJaYs5WQRl/FIjh/c1SVt48W7hhLXrdBGN5FeSVchBZ9tK01Skj/FGtEII6hKcYGXxc5IRfnv4Y5ikd+9B/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982186; c=relaxed/simple;
	bh=NvID/kMg36Diao3OFuD2pJOuu3vylpBwx2YN0l8Evok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRgymHpNGmsMhXcr3XJLkg+nIxAs2FowC9wYxuJQ3PBJbmPVp/35JagPjs5rPqQUxw0wCSfggiBZsoU2QJqJOdyiTyb21ZQtGIb8F3n2VrLrugHOFysgwyE96+DNSmJo8xrotfRiEN+Lhw7/85QEZVGMdfbuiFCuEVtsUHGmfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jDTON8jY; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso22285845ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 08:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739982183; x=1740586983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67TYMpkqxY5mExKnmZVTE77hxJr9qVBfzvrOMIP8NRY=;
        b=jDTON8jYgvmi1TsE5gCn12hB9s6ARl3WruyKmqI7gUlgX7GEVlGvbWZ0Gj2g6vji9w
         1x5zJnaWxxXiTaToNxoN97dFSXKQLDc3gLeqKUnW851aanfswQntEKsygwEVN7+it5An
         9zUbQfOR8spWXmgH0aIgQLU0xoFg47XqEDUauquqr1+dWgoygqnVy3BoZykcjEW4KllX
         Rc1DbRtWWPZmcs2mHb+Sx4FQw7kX7f0hwRhdLIL0gHgvk6vnHZPo7k0+uUBY+8WTc9KN
         GEMGi5zagKFa3479AFmda+tMeZQQulU2F8jMiXyXZhV0krSJq4BI0o/9VDpSxYDWzc1x
         U9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982183; x=1740586983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67TYMpkqxY5mExKnmZVTE77hxJr9qVBfzvrOMIP8NRY=;
        b=Zi14zBu4wYN+CrSSgyv8xeda307MFZDMEYekfCsegq1ycMX5WXXHua85QFSoyzJwJ3
         mfWToW1cSzzqkXIZuhB974HK208qbDl6uEe1Jf2M2kX1K3E5RcM94tZlUDnHL24x8iPO
         afJShO2xG80gv6asCYGr2sBJ5NCsUFlKKqQOfCS0/OqOGPb0WGXazetG5bfkejEtbBXR
         Ygdk81uGGS9412l1qJnhx8Qd/im2qjnl63sB678D91kuLOl5do0cyUEgPeOwKXUTz2WV
         TabjB+pz9xZQxWXdX4dTs95o+W4j9iJBPmscjz8lv2ASsCIVSq3v55Hmb3/3EhfNcqsc
         FVYg==
X-Gm-Message-State: AOJu0YxxTXMBfbOGyJ4B4LtX+gX46vq1ORz6C0e8vY7PQVvNZPtbVvGK
	BGRyfabGCpqKySRxZ/xjr8Xn7aRk/gn7WXj4tSFeMZ2gQckpn66d7mLvN82jICs=
X-Gm-Gg: ASbGncv4CtmIGmoosfB4a3mCbUvYfjUhcqsJiPVvNDoG8OhPnppOY7TbFRZcuI1Xnhi
	BRMcCN56ZAUNWjmqwGa63H3KftPuz210UFkYS7gaUuogbHYXKdw78tqr4E9SrcGZ0W3n/QEuvKZ
	oNjNW5MeI/MwoSzpXGia/fjivV+d1jlWNsi6mxc3Rx2ENA14h+5gIAgXUbX7qxhEiv+01wsavhC
	2enYeGpRG2HVwxFBtY5TsLL5yyOCRQwGIpj1dR89u2osXCNSoDE1qYsZ2L7MCMtCsR9zWe6HQLo
	Km3BN5zxsZk=
X-Google-Smtp-Source: AGHT+IGsP9WAlYtkUYVoWjhz3+vnzS72BFbKRaFhdh7G4oojUtLjlV/F9FheozGc1GxCuDhK7ilFlw==
X-Received: by 2002:a05:6e02:1d85:b0:3d1:a75e:65dd with SMTP id e9e14a558f8ab-3d2807905e3mr162742745ab.10.1739982183443;
        Wed, 19 Feb 2025 08:23:03 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee8809c5d1sm2144921173.38.2025.02.19.08.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:23:02 -0800 (PST)
Message-ID: <65e5ddcd-642b-4671-b814-d4a66b2039d3@kernel.dk>
Date: Wed, 19 Feb 2025 09:23:01 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/truncate: don't skip dirty page in
 folio_unmap_invalidate()
To: Jingbo Xu <jefflexu@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, brauner@kernel.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
 <20250218120209.88093-3-jefflexu@linux.alibaba.com>
 <cedbmhuivcr2imkzuqebrrihdkfsmgqmplqqn7s2fusk3v4ezq@7jbz26dds76d>
 <b2248d8c-1f80-4806-80fb-cbc40ad713e6@linux.alibaba.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b2248d8c-1f80-4806-80fb-cbc40ad713e6@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 6:23 PM, Jingbo Xu wrote:
> 
> 
> On 2/18/25 8:32 PM, Kirill A. Shutemov wrote:
>> On Tue, Feb 18, 2025 at 08:02:09PM +0800, Jingbo Xu wrote:
>>> ... otherwise this is a behavior change for the previous callers of
>>> invalidate_complete_folio2(), e.g. the page invalidation routine.
>>
>> Hm. Shouldn't the check be moved to caller of the helper in mm/filemap.c?
>>
>> Otherwise we would drop pages without writing them back. And lose user's
>> data.
>>
> 
> IMHO this check is not needed as the following folio_launder() called
> inside folio_unmap_invalidate() will write back the dirty page.
> 
> Hi Jens,
> 
> What do you think about it?

Yep agree on that.

-- 
Jens Axboe


