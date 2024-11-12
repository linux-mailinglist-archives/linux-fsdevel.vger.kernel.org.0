Return-Path: <linux-fsdevel+bounces-34489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7599C61A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FA3B84CC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E96212F0B;
	Tue, 12 Nov 2024 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oAjCIijy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3F2123F2
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431774; cv=none; b=SI+Z8B7DHMjpU0fJJH7/643Uu6JZ/RmrBYrfmATqQQIwJLuqrjTIcwCuX+QSu4jwkWTmGJRaIYTCMotGoH1LqdbHn4e52fDa9OjGwrTfXhOO8JrIYdhQNRiskLPlLq31WUoir07XFZTMDGW45zAfBpljMQNCXhaHZRNGg1qCBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431774; c=relaxed/simple;
	bh=WElPdD8LZYryTigGCKIJr1x7hPyk/0fp60+PcfErbm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPOWF35VD9RFUyWJTf/n55vcYL666+7r22XZ0dzclX1dhBU76YYb9fD+hmoWFa/Sh05BGybw6TXyE+Zb85o+wi1oeRe25PaKOd3DnvjSOPd4Vs2uYsJpmrRqgjN+zlY+bUv2E8bFm1eI83Qv3cXT72xQiakgsLP/eKYM0ipRz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oAjCIijy; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5eb73ec1e1aso2877441eaf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731431772; x=1732036572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnwYJHTHAIT7NhrPIR59Xh9wM+nrsn1VWuRs7Z2BGss=;
        b=oAjCIijytabdM5gECO8+BuZ4Jqs/uZmzyfwftew4kiT4b9OMzcSAhy5StU1kxXA+mY
         paUUrFjsq1d7/6SqzetFMqv4FZzuwg+HBElvj6XQh1lvA46bghdn4HaN1mpRcms2Ri/o
         zmVrHZwMh6q6EM12J2iIYAMU+Og0HAXrkHESC2ewc/Ll3xaXwqC4LqMmZ4tInelY+dPS
         CfMicufONUT5KN9x0Vfvt5hu6oJt3MRDKBW/Od48G9daj4aTh2ZobRFsfyJhszxv+ZMw
         mkiyXQVWvgtC/HLatTrB75Hra0UaKA3/9N3TDCmQzxUsmvagV0GfGPyrNGFS+jX/ceqi
         DdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731431772; x=1732036572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnwYJHTHAIT7NhrPIR59Xh9wM+nrsn1VWuRs7Z2BGss=;
        b=IzyPVPcxwi1kbyiOvSKUIsmOcqBOFtQoEJ4tVYHgWAxungmckxcg92OFp0xyEy9XZy
         bsc/69uXTCxigV7XIiazH7JbR4mrnCHr+l5di3bxypaOSBJT8rQYINnxDlHD+U62or6n
         1yjYzjtN0hgFsVFWitz9sVQcO54oHPbpyoQzbVpP7PCkAcxn1tEpKl+Ip1fP+G2OXgW8
         KuqvaGUEFgBm4VdV67vXUq0Ip7MYh6txFUntlm91YsTt9UqywHhmf99BDg5jFc9gPxZS
         egOA0kRVjSDufxk2aW1E8bqH4RkOJeGP5ldHif2QpuvNLmiv6FJWi0OyMnjT1uddG6K1
         SyRg==
X-Forwarded-Encrypted: i=1; AJvYcCWEARTdRZ+H5aFUr2o4fCbsF63MA1WcmOfzpQk9h2lKQA3qoTw8a3uz6abG2mlIXLMof4Ej+oPuSl+SvQ4v@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMQNgVxr+0B30kIS0STej7UETmhjx9UmhJVXj3ecDyr2wtamE
	wSaE/xFnbLGkz63LtkOwSTEHprJlFjA/uedZ7MHMRf7WTiMQkca4AOnZt4fLi9g=
X-Google-Smtp-Source: AGHT+IG7wz2TGObI3XCZLc6czEW3NEVtcJxYLSH6bVzUApdp4Zu/FDc4eOSHYLi8nQ/yqwWNP9VyFg==
X-Received: by 2002:a05:6820:4c85:b0:5eb:6c26:1ca0 with SMTP id 006d021491bc7-5ee57b9d3f9mr11631558eaf.1.1731431772373;
        Tue, 12 Nov 2024 09:16:12 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a1080fb77sm2816311a34.20.2024.11.12.09.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 09:16:11 -0800 (PST)
Message-ID: <aeb58f3d-67b2-4df3-abc7-49a2e9bb8270@kernel.dk>
Date: Tue, 12 Nov 2024 10:16:10 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] iomap: make buffered writes work with RWF_UNCACHED
To: Brian Foster <bfoster@redhat.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-14-axboe@kernel.dk> <ZzOEVwWpGEaq6wE7@bfoster>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzOEVwWpGEaq6wE7@bfoster>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 9:37 AM, Brian Foster wrote:
> On Mon, Nov 11, 2024 at 04:37:40PM -0700, Jens Axboe wrote:
>> Add iomap buffered write support for RWF_UNCACHED. If RWF_UNCACHED is
>> set for a write, mark the folios being written with drop_writeback. Then
> 
> s/drop_writeback/uncached/ ?

Ah indeed, guess that never got changed. Thanks, will fix that in the
commit message.

> BTW, this might be getting into wonky "don't care that much" territory,
> but something else to be aware of is that certain writes can potentially
> change pagecache state as a side effect outside of the actual buffered
> write itself.
> 
> For example, xfs calls iomap_zero_range() on write extension (i.e. pos >
> isize), which uses buffered writes and thus could populate a pagecache
> folio without setting it uncached, even if done on behalf of an uncached
> write.
> 
> I've only made a first pass and could be missing some details, but IIUC
> I _think_ this means something like writing out a stream of small,
> sparse and file extending uncached writes could actually end up behaving
> more like sync I/O. Again, not saying that's something we really care
> about, just raising it in case it's worth considering or documenting..

No that's useful info, I'm not really surprised that there would still
be cases where UNCACHED goes unnoticed. In other words, I'd be surprised
if the current patches for eg xfs/ext4 cover all the cases where new
folios are created and should be marked as UNCACHED of IOCB_UNCACHED is
set in the iocb.

I think those can be sorted out or documented as we move forward.
UNCACHED is really just a hint - the kernel should do its best to not
have permanent folios for this IO, but there are certainly cases where
it won't be honored if you're racing with regular buffered IO or mmap.
For the case above, sounds like we could cover that, however, and
probably should.

-- 
Jens Axboe

