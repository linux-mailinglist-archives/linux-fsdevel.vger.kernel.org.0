Return-Path: <linux-fsdevel+bounces-28855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8003C96F8E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 17:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5DF282F1B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67D1D415D;
	Fri,  6 Sep 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Au3cULOF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BFA1D3192
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638190; cv=none; b=q5u6XTScfkVjxzDc/mgTgCC1i1Whr3OS3Zf731Tyd6BXe99MU/ttbLdYyjx2NbgmmxebMvMZVyyZK0hKuN/+gmDAS9IeKdpafmjHgChzUbcqtcVUeOYKwPjQXdS3QK9Td2HR7kw/3rV0F9iHlg2j16RboTMoLcF3TWDvm2uwXVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638190; c=relaxed/simple;
	bh=nUYTcFoxpxHQj0jdD301geWz0evCUuqKpFzTObrOiqU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DLJZ/dwWACmELGpnLHqvSduQsYQgcwKWPhtnLCoLsL8DVn3KLkwuyXMFQPBcdQWPc0VhZipcCcjynw0E4KGCXfayR7Hw+VnMtHJEZMKNp3exDYjYCyBWVJ+jwFsEiTj0qrs9VJlxjqHUkrjfoZXnfs7L1RGcT3EXYvlL6VpLKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Au3cULOF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725638187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EC8rSnLArJY5TrxFXTHIfQv4LZGXOtr++N0UTzGuyA=;
	b=Au3cULOFWUqzzwP5vreQjPEyM3SApjaDy4Kd/XgZwFQntNjlCKBJt8CsEdRByxdBYpvYvz
	cjQz3KdfWwy/nANKpMneAVo8RGbLT0M2CYiT+biPwZh/8ie+keytloq1MhOcNkV5i8LiRa
	bcix+6AwNkJkjLB2SlzIlNDHpPHDhMk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-PKLbuSkJOKCqLmhCIfpgTg-1; Fri, 06 Sep 2024 11:56:26 -0400
X-MC-Unique: PKLbuSkJOKCqLmhCIfpgTg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a21f28d87so462700939f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 08:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725638185; x=1726242985;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EC8rSnLArJY5TrxFXTHIfQv4LZGXOtr++N0UTzGuyA=;
        b=KmcYvQMH/fo5QZf0c9s0lyue3Ew49vBJpYA6hS3mlESIkF0YIeLNoDtgIs7E4V8aXz
         2cWy01DIRi/sR9+bH+mySBLQdODCBSkpcWkjb/z0kXzG4bMgz2YxF8tiOUdmY+6GFxVO
         hEXwNm3ni2LgyuRN9ziNvy+XMtxLbyIi7fErcw0URZEPypNUSJi5l7by3IZtrmvHVCSb
         KATqmM/PBG0TC6iEPE9BmwmitDvP0lzW6iMXiRWLWUnTQZXsfTs1NZCeRAY6c49I8Jvg
         AJ6YRbRd9IUDcdV1RiB3F/VJUK3n2eIQ5VYiIMmfYsMCxONtHDwEdOn+5xG3e0JFkygn
         cuUA==
X-Gm-Message-State: AOJu0YyxIYTST9nJaBlS0/8AOyndf4iLCZIdOVyfbxA9ytjncfwpRMbu
	TnqRjHNN+GhrjB3M0OBalI9AYxx/32SI5zZ0Idg+2iTjnTYnguWdxuqfOzZjlXbqCUBbxHtc7GV
	inoPQK8kufTpnP8zSIectvSB6R4es6OpJSDEFxmoMI0RoythWyDl/hXi8hT3KDlkakwfhos/Q6X
	9jxZwX3voco9dwnhQf5DqZi8biVGyFrvJVqTLOzOmqXXENuA==
X-Received: by 2002:a05:6602:2c14:b0:82a:4163:838 with SMTP id ca18e2360f4ac-82a961a16e5mr398059039f.6.1725638185640;
        Fri, 06 Sep 2024 08:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWGusXTORcoNJ8PpTT4AgLvt0klf64vVmzBdzVg428kLlViLsQQplN/LBS3FUtJSlEcx1n2Q==
X-Received: by 2002:a05:6602:2c14:b0:82a:4163:838 with SMTP id ca18e2360f4ac-82a961a16e5mr398056839f.6.1725638185212;
        Fri, 06 Sep 2024 08:56:25 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e93122sm4218244173.87.2024.09.06.08.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 08:56:24 -0700 (PDT)
Message-ID: <8f83df83-5421-4141-9af3-1cd9a1e90372@redhat.com>
Date: Fri, 6 Sep 2024 10:56:22 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] adfs, affs, befs: convert to new mount api
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org
References: <20240829194138.2073709-1-sandeen@redhat.com>
Content-Language: en-US
In-Reply-To: <20240829194138.2073709-1-sandeen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/24 2:39 PM, Eric Sandeen wrote:
> I'm going alphabetically for now ;)
> 
> These were all tested against images I created or obtained, using a
> script to test random combinations of valid and invalid mount and
> remount options, and comparing the results before and after the changes.
> 
> AFAICT, all parsing works as expected and behavior is unchanged.
> 
> Thanks,
> -Eric
> 

Hm, hold off on these. Found at least 1 string memory leak, will
resend along with hfs & hfsplus ... Sorry about that, didn't think
to check kmemleak before sending.

-Eric


