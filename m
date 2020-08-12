Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956C9242528
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 08:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgHLGCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 02:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgHLGCV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 02:02:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A1DC06174A;
        Tue, 11 Aug 2020 23:02:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l60so582826pjb.3;
        Tue, 11 Aug 2020 23:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HPIOK3rNviX7M7TkAWIwKVBAfKjkjAUG64sCRy5ZUtQ=;
        b=oerSCwoH0WT1Ys/TiLkcsyScgiuNNILFBmNRtCQ/yoz7XwRPub46N6KYvGI0TgtCeb
         4tApLHOil3cxXTgPkqY2/H2ON6bWDDDSATT0Zb6gHTu3PG9NdYsymAlq6Pf/eTPwsyS9
         IM2cVO6E2lYEDfAdeBU0O+UnxLv5szBnMtN6UpVqPh2iQNbrLRN5ds1+N099oSFHFA3I
         OImVlEakW/SjBvy/ajBGIJGSa4NxWunELgdagULj67G0Z8jHdud11QRbPRLNiFZa4fgJ
         hMuEDN4A0sFlQKJXGo/lfwG9x62OyEpfXpN2PBvHyes5x0g60WD4eXdBXF4JWWoY2bKh
         9FgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HPIOK3rNviX7M7TkAWIwKVBAfKjkjAUG64sCRy5ZUtQ=;
        b=nKMfyufzhzIG9Vqtbq7RMITjRYx9wi6C+CUVDQgFRZylkPVU++59dhBIKRbfVrcNHw
         srGVgE+coxmP7W48B/hzFEcKkANyP5SJ2FN/SB8a9zkxNQn8X2nH0A9wIZWLpw4suhsI
         xD4/zwbKOCvlZHdiBJYPZnyfkC5tZlAMk/q5qohrj8FJKi8AZ828an8Kn6Yjb3wifNON
         hd6azkMK5Cx2F5Kza5T12xNDZ+bhCVRgTqOsi84qzhqbdQ2QN6O934oXK0kT47XmdYCj
         G7nxQ4J4wudY2lwsmL+Rrim+BWN7GhpPtE/QdTGP77kjaIsP3w/bz7tvv2R7thj4ydTy
         JezA==
X-Gm-Message-State: AOAM532jbqwgcWIyJfayowB3e79ZsWJ/xOsl9QjRAIOgLnlBzmjnVKRV
        RjHVNAsqCCuczhtysIEWUXW8Ee69
X-Google-Smtp-Source: ABdhPJxt6PrZbuufcWM60ic9ghuriNAmfoiUIlaiuSxDKs4la8PmxHiY16CqR7uEquHSyRQ5gbO8Hg==
X-Received: by 2002:a17:90b:c90:: with SMTP id o16mr4293425pjz.79.1597212140341;
        Tue, 11 Aug 2020 23:02:20 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:5c24:508b:d8c0:f3b? ([2404:7a87:83e0:f800:5c24:508b:d8c0:f3b])
        by smtp.gmail.com with ESMTPSA id s67sm1048954pfs.117.2020.08.11.23.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 23:02:19 -0700 (PDT)
Subject: Re: [PATCH 2/2] exfat: unify name extraction
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200806055653.9329-1-kohada.t2@gmail.com>
 <CGME20200806055726epcas1p2f36810983abf14d3aa27f8a102bbbc4d@epcas1p2.samsung.com>
 <20200806055653.9329-2-kohada.t2@gmail.com>
 <000201d66da8$07a2c750$16e855f0$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <bbd9355c-cd48-b961-0a91-771a702c03df@gmail.com>
Date:   Wed, 12 Aug 2020 15:02:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <000201d66da8$07a2c750$16e855f0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for your reply.

On 2020/08/09 2:19, Sungjong Seo wrote:
> [snip]
>> @@ -963,80 +942,38 @@ int exfat_find_dir_entry(struct super_block *sb,
>> struct exfat_inode_info *ei,
>>   			num_empty = 0;
>>   			candi_empty.eidx = EXFAT_HINT_NONE;
>>
> [snip]
>>
>> -			if (entry_type &
>> -					(TYPE_CRITICAL_SEC |
> TYPE_BENIGN_SEC)) {
>> -				if (step == DIRENT_STEP_SECD) {
>> -					if (++order == num_ext)
>> -						goto found;
>> -					continue;
>> -				}
>> +			exfat_get_uniname_from_name_entries(es, &uni_name);
> 
> It is needed to check a return value.

I'll fix it in v2.


>> +			exfat_free_dentry_set(es, false);
>> +
>> +			if (!exfat_uniname_ncmp(sb,
>> +						p_uniname->name,
>> +						uni_name.name,
>> +						name_len)) {
>> +				/* set the last used position as hint */
>> +				hint_stat->clu = clu.dir;
>> +				hint_stat->eidx = dentry;
> 
> eidx and clu of hint_stat should have one for the next entry we'll start
> looking for.
> Did you intentionally change the concept?

Yes, this is intentional.
Essentially, the "Hint" concept is to reduce the next seek cost with minimal cost.
There is a difference in the position of the hint, but the concept is the same.
As you can see, the patched code strategy doesn't move from current position.
Basically, the original code strategy is advancing only one dentry.(It's the "minimum cost")
However, when it reaches the cluster boundary, it gets the next cluster and error handling.
Getting the next cluster The error handling already exists at the end of the while loop,
so the code is duplicated.
These costs should be paid next time and are no longer the "minimum cost".

Should I add this to the commit-message?


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
