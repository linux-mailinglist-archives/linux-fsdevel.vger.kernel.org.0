Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892EB33FC83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 02:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCRBCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 21:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCRBCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 21:02:31 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C09C06174A;
        Wed, 17 Mar 2021 18:02:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id ay2so425821plb.3;
        Wed, 17 Mar 2021 18:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CL3mpZeU+WmZERc2Fdv9igWqFClRL5x2TM3MaTKj5Js=;
        b=NLNfQuquyc9Lgwz1xlL6WWBBQAAQdv48QhQyuEorz8yrWhgdjaHcfiwAxYdufXrxIZ
         3a61MR0Fhn5EqttfalOWARo2ZYVvuQLyTkxvsXvOd4/bBHtSbfHMdxEV0BLo+Z/kxc42
         YY8YJ50TT+uLlYx/VLqzvoNZwNsUN4sLGrxb7BxFgL6rCSh1kn5U297dViOshRQXxsN7
         0YOV9kG3SqI2cfnbrtQzGuzI++zHVq7hBW8WtR7zbB8Uqc8Q5loIcLDjW6dQ30OvwSqz
         pwGuHY25VSOz+6HLbQSTiabudvGaErtuYgloueeNQL+qFWqJQaKbucmRr0voDTTX3wls
         +7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CL3mpZeU+WmZERc2Fdv9igWqFClRL5x2TM3MaTKj5Js=;
        b=EsForFwT4azkP4YlTD/H9yi6/fBQNF77R3royH6HYS4NY5ky/yfA75dJpOmV07MN8g
         k8X0tjFBbRmeyc5IN/8+FjvCrLu+q8SlJExmMn3DpUktYAyD5BcwCm9b5f7qlcD2vgdW
         Di63XuiYeJr3N0vrLj8/efdqdL6Auu//i7CXfuqePlui468IEoAPPskHqYSS5s4rJnAT
         4bTch+Pw8SEgnveyn39VyXD544dF51Ripc3NyMqZ6KMQLWBbQHfMV/IFJCBaXV7by1kh
         6YR/fKpgyetGA3xZejGUU0hGz2XEC7x+apD4uWnqhAADeIrJSoO61lwm55ZoDWQOyM2l
         KCmw==
X-Gm-Message-State: AOAM533rbAf0byzD7ICY2IpTpnyMsYiSs9qHHFqS6h5HYATZfTBusGOg
        HjD6Q/Aun+rFnSPE0ofxMU0hP++F9QZUrw==
X-Google-Smtp-Source: ABdhPJwjzBuk8ibPxNIY932v5/q8E9aP+l+In8KRCzW8G7fHQXRb1IHIyV2p/vrsbD4iDB/wDFoH8Q==
X-Received: by 2002:a17:902:7888:b029:e6:b94d:c72 with SMTP id q8-20020a1709027888b02900e6b94d0c72mr7349180pll.8.1616029348463;
        Wed, 17 Mar 2021 18:02:28 -0700 (PDT)
Received: from [192.168.0.12] ([125.186.151.199])
        by smtp.googlemail.com with ESMTPSA id w79sm262216pfc.87.2021.03.17.18.02.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Mar 2021 18:02:28 -0700 (PDT)
Subject: Re: [PATCH] exfat: speed up iterate/lookup by fixing start point of
 traversing fat chain
To:     Sungjong Seo <sj1557.seo@samsung.com>, namjae.jeon@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <CGME20210315043335epcas1p2bf257806e9ba1c2a492739a6424a2b44@epcas1p2.samsung.com>
 <20210315043316.54508-1-hyeongseok@gmail.com>
 <a64901d71b47$9cacb070$d6061150$@samsung.com>
From:   Hyeongseok Kim <hyeongseok@gmail.com>
Message-ID: <1e43f9f0-5721-177b-8712-fa3018261b1e@gmail.com>
Date:   Thu, 18 Mar 2021 10:02:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a64901d71b47$9cacb070$d6061150$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ko-KR
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/18/21 1:07 AM, Sungjong Seo wrote:
>>   /*
>> - * return values:
>> - *   >= 0	: return dir entiry position with the name in dir
>> - *   -ENOENT	: entry with the name does not exist
>> - *   -EIO	: I/O error
>> + * @ei:         inode info of directory
>> + * @p_dir:      input as directory structure in which we search name
>> + *              if found, output as a cluster dir where the name exists
>> + *              if not found, not changed from input
>> + * @num_entries entry size of p_uniname
>> + * @return:
>> + *   >= 0:      dir entry position from output p_dir.dir
>> + *   -ENOENT:   entry with the name does not exist
>> + *   -EIO:      I/O error
>>    */
>>   int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info
>> *ei,
>>   		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
>> @@ -925,14 +930,16 @@ int exfat_find_dir_entry(struct super_block *sb,
>> struct exfat_inode_info *ei,
> [snip]
>    			hint_stat->clu = p_dir->dir;
>>   			hint_stat->eidx = 0;
>> -			return (dentry - num_ext);
>> +
>> +			exfat_chain_dup(p_dir, &tmp_clu);
>> +			return dentry_in_cluster;
>>   		}
>>   	}
>>
>>   	hint_stat->clu = clu.dir;
>>   	hint_stat->eidx = dentry + 1;
>> -	return dentry - num_ext;
>> +
>> +	exfat_chain_dup(p_dir, &tmp_clu);
>> +	return dentry_in_cluster;
>>   }
> Changing the functionality of exfat find_dir_entry() will affect
> exfat_find() and exfat_lookup(), breaking the concept of ei->dir.dir
> which should have the starting cluster of its parent directory.
>
> Well, is there any missing patch related to exfat_find()?
> It would be nice to modify the caller of this function, exfat_find(),
> so that this change in functionality doesn't affect other functions.
>
> Thanks.
>
Whoops, it's a bug. I didn't catch that, thanks.
Maybe it could make exfat inode hash problem.
I wanted to reuse current function interface but, it would be better
to add an addtional parameter. I'll fix this in v2.


