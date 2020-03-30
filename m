Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B485197DDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 16:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgC3OHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 10:07:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38129 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3OHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:07:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id f6so15466477wmj.3;
        Mon, 30 Mar 2020 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NkzDxDJV1bnIzEyyQHH60q1JMe3S2qaalEpyevgeDjU=;
        b=l09D8vePmsTy6YJfx5OBWOTZXcDmZP5AqjJZZ2/1V3JxhHYaHl0Ng7dBXXkGqvkbNO
         70Gny56xP33iDCFXLwqULkq+3yPJva9Ww7Zdd8Ud2P7Gl5mvKuT+WXIQW/eGwOW5uthm
         zxw4Dm10afQz6D2RrJbiELMAeI1+bHF32zI8K9wEwL9dgvy452c/UeATCmoOeyG1QwTQ
         wKasux9fjj7o0Ws3dHATmouJhcROWFRLaPwolcR5qYqd7RcLsmFGDsICAQHN2JIo/DMH
         DFre0geNYld5cX4Kzxj8bSNs8iYyKDext4OttK9wmN5UQyxn1fDhEvLZxESD9C0fEcDZ
         ANNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NkzDxDJV1bnIzEyyQHH60q1JMe3S2qaalEpyevgeDjU=;
        b=tJqlxP1PmW2LzdAyn77F0pQtuXE7yw66CbIKDB7rtHUFvhQ9ZOzf8agJ2wsULFyuwi
         jTU2tvVglWEFgVGAvyVxCVcQ1pS171BhKwa1Eu1v93E4CtKCz+O5S9Z6/+TprcwBEvsM
         /qhN56ciJL4SIN4AulpxlRtT1nbJqh1Du32UW0kBehsAtWCgDoXH9yazQjkozl2tnUPE
         TXeB06KibDqXV02Xp11c+aDRgzXsWzF2ajLYyeEt/qgbpTTxlr/nytBmAIt6OjdAy8Sx
         //Q2NqHvcfkWy1h7VhX7qv9cDSzyFnT8A2WAnyzL3Gh7MaWngw+dm8m2Ug46M0uULnQJ
         Po2w==
X-Gm-Message-State: ANhLgQ2e7nAEuxgeREKDxG5ZygFdAlzKvLqupZk09ds8Nm5bsdfA4L8w
        kFpY8gja4Ue2plc2NPV0TeI=
X-Google-Smtp-Source: ADFU+vvDgfqqnHf5IRDG0vNghnouBgCUY5+ARj5KVNJUOS4CEX51oW7b0ZiqGVsrAZGVOvfw235vGA==
X-Received: by 2002:a1c:8108:: with SMTP id c8mr13124272wmd.50.1585577233309;
        Mon, 30 Mar 2020 07:07:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id b203sm21270063wmc.45.2020.03.30.07.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:07:12 -0700 (PDT)
Date:   Mon, 30 Mar 2020 14:07:12 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] XArray: simplify the calculation of shift
Message-ID: <20200330140712.sloduuoqc5jid64m@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-3-richard.weiyang@gmail.com>
 <20200330132028.GA22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330132028.GA22483@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 06:20:28AM -0700, Matthew Wilcox wrote:
>On Mon, Mar 30, 2020 at 12:36:36PM +0000, Wei Yang wrote:
>> When head is NULL, shift is calculated from max. Currently we use a loop
>> to detect how many XA_CHUNK_SHIFT is need to cover max.
>> 
>> To achieve this, we can get number of bits max expands and round it up
>> to XA_CHUNK_SHIFT.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  lib/xarray.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>> 
>> diff --git a/lib/xarray.c b/lib/xarray.c
>> index 1d9fab7db8da..6454cf3f5b4c 100644
>> --- a/lib/xarray.c
>> +++ b/lib/xarray.c
>> @@ -560,11 +560,7 @@ static int xas_expand(struct xa_state *xas, void *head)
>>  	unsigned long max = xas_max(xas);
>>  
>>  	if (!head) {
>> -		if (max == 0)
>> -			return 0;
>> -		while ((max >> shift) >= XA_CHUNK_SIZE)
>> -			shift += XA_CHUNK_SHIFT;
>> -		return shift + XA_CHUNK_SHIFT;
>> +		return roundup(fls_long(max), XA_CHUNK_SHIFT);
>
>This doesn't give the same number.  Did you test this?
>
>Consider max = 64.  The current code does:
>
>shift = 0;
>64 >> 0 >= 64 (true)
>shift += 6;
>64 >> 6 < 64
>return 12
>
>Your replacement does:
>
>fls_long(64) = 6

fls_long(64) = 7

>roundup(6, 6) is 6.
>
>Please be more careful.

-- 
Wei Yang
Help you, Help me
