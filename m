Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1141731B14C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Feb 2021 17:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhBNQqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 11:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhBNQqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 11:46:21 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD55C061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 08:45:42 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z9so2462500pjl.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 08:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jsxPXndPtlbP9qHAOMHugFNPre3jOqtTcliLMqIUo0E=;
        b=ZVNeHQcF74iE6NWzayp2AMEppb2L4tAMnEU8DL0BodUfbTUXMNk/1x5hpZtgWumNWH
         9HQ4dYaQ6il65QljuCGFrxRDHY7ftbmguwn6j8+G7CK1PEQhUebV2CUQuBHPa4oqXRka
         sxMW+XZjtdGIOcWquD+fvOd1ejwVPDacvLp5+dYTHIaD1hlqXl0CAxjc+/Z8x11ggYl3
         2WhvnZTf9NO4f1HKYir4DhPL8n2TZmuA0hTZ9LHsl8Bzw1RZTj4R+J2GfjcRnqQ3WHsC
         b/VFlo5EawDchT0QBg1pqRN3exoxB4n5jIeoNBWcNi2WHsFCung8f9scqvAvdVfUjiaP
         ER9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jsxPXndPtlbP9qHAOMHugFNPre3jOqtTcliLMqIUo0E=;
        b=SBVYXFU6nMRxGkGIBuQkNyisgn4TKyepX90FrvQz5iHjq8bTwS+KUPVMCya4G8qgUm
         ni4F5c94/TF/5R/aP+9RM4e6YHIo3pxJs0h1XL3UC24hIg3l2ds5uSVhUBiUrwSDHLVQ
         87jGf6hCMSDiNmT6vJtqNcu4nBL5N+stZlZj7reS8oup55pVLalgUMr5xkzZ2QmKmygF
         5SH/a3koBBoLK5kLXh78ChPJnoUWO8EvH1kyXDq5L33fGFhlrGjj2jQsWRiGefeHEWuN
         eDs64/1dS3ee8BsJO82xZSiahO3DgByKdZ/UlTADyv+BdwU4KIuFObZgC7naQpQqgLVg
         lG2A==
X-Gm-Message-State: AOAM530F/StW+mkCBNvezMY+x2IfpXv7R0HKMCiwMz6PL5pjHGc6AoL+
        276PjIlznxmZ0Tawzd9nl6Tyu+2i+hDS8g==
X-Google-Smtp-Source: ABdhPJxRHlSMWYAjL+cSG4Iphzq2BCTFoMQCGICJ9cGsv9bXnYokVTsR49ot71rELtFdY7n0e9t1LA==
X-Received: by 2002:a17:902:8ec1:b029:dc:8ae1:7a22 with SMTP id x1-20020a1709028ec1b02900dc8ae17a22mr11460882plo.6.1613321141515;
        Sun, 14 Feb 2021 08:45:41 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d124sm14974995pfa.149.2021.02.14.08.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 08:45:41 -0800 (PST)
Subject: Re: [PATCH RFC] namei: don't drop link paths acquired under
 LOOKUP_RCU
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <8b114189-e943-a7e6-3d31-16aa8a148da6@kernel.dk>
 <YClKQlivsPPcbyCd@zeniv-ca.linux.org.uk>
 <YClSik4Ilvh1vF64@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0699912b-84ae-39d5-6b2e-8cb04eaa3939@kernel.dk>
Date:   Sun, 14 Feb 2021 09:45:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YClSik4Ilvh1vF64@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/14/21 9:40 AM, Al Viro wrote:
> On Sun, Feb 14, 2021 at 04:05:22PM +0000, Al Viro wrote:
>> On Sun, Feb 07, 2021 at 01:26:19PM -0700, Jens Axboe wrote:
>>
>>> Al, not sure if this is the right fix for the situation, but it's
>>> definitely a problem. Observed by doing a LOOKUP_CACHED of something with
>>> links, using /proc/self/comm as the example in the attached way to
>>> demonstrate this problem.
>>
>> That's definitely not the right fix.  What your analysis has missed is
>> what legitimize_links() does to nd->depth when called.  IOW, on transitions
>> from RCU mode you want nd->depth to set according the number of links we'd
>> grabbed references to.  Flatly setting it to 0 on failure exit will lead
>> to massive leaks.
>>
>> Could you check if the following fixes your reproducers?
>>
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 4cae88733a5c..afb293b39be7 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -687,7 +687,7 @@ static bool try_to_unlazy(struct nameidata *nd)
>>  
>>  	nd->flags &= ~LOOKUP_RCU;
>>  	if (nd->flags & LOOKUP_CACHED)
>> -		goto out1;
>> +		goto out2;
>>  	if (unlikely(!legitimize_links(nd)))
>>  		goto out1;
>>  	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
>> @@ -698,6 +698,8 @@ static bool try_to_unlazy(struct nameidata *nd)
>>  	BUG_ON(nd->inode != parent->d_inode);
>>  	return true;
>>  
>> +out2:
>> +	nd->depth = 0;	// as we hadn't gotten to legitimize_links()
>>  out1:
>>  	nd->path.mnt = NULL;
>>  	nd->path.dentry = NULL;
>> @@ -725,7 +727,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry, unsi
>>  
>>  	nd->flags &= ~LOOKUP_RCU;
>>  	if (nd->flags & LOOKUP_CACHED)
>> -		goto out2;
>> +		goto out3;
>>  	if (unlikely(!legitimize_links(nd)))
>>  		goto out2;
>>  	if (unlikely(!legitimize_mnt(nd->path.mnt, nd->m_seq)))
>> @@ -753,6 +755,8 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry, unsi
>>  	rcu_read_unlock();
>>  	return true;
>>  
>> +out3:
>> +	nd->depth = 0;	// as we hadn't gotten to legitimize_links()
>>  out2:
>>  	nd->path.mnt = NULL;
>>  out1:
> 
> Alternatively, we could use the fact that legitimize_links() is not
> called anywhere other than these two places and have LOOKUP_CACHED
> checked there.  As in

Both fix the issue for me, just tested them. The second one seems
cleaner to me, would probably be nice to have a comment on that in
either the two callers or at least in legitimize_links() though.

-- 
Jens Axboe

