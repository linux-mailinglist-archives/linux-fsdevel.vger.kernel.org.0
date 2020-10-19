Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3692920BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 02:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgJSArX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Oct 2020 20:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgJSArX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Oct 2020 20:47:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5E1C061755;
        Sun, 18 Oct 2020 17:47:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y1so4129270plp.6;
        Sun, 18 Oct 2020 17:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WaAOFGJAd+WHLDvf0xKzV93iMnk9wVl5Rpau3SAZLA0=;
        b=aRYL9AWrkErIx1vCi6HHnN/6aOCXubfFHOYMtB2DiY1m0Wblo6NKGdb1e17BLqKtXl
         Jwi2vucKuukGv+u3aNOwYLBsLauQ3IFYBay5FvVkhq9sVlwdZBVUkbmXYcW8+UQZDjLm
         13KDuUGlU7jlJ9X7tx2genT/uBIblOzb52RbANSRo+uRnCIjmq4NFc9s+e4Xhnytcqt9
         BFNl25SV4JOsc1TsRBTDdVKl/oSi8Lx8LknzavYgWZjRLTQ21Ppqz7Ywk8yqnutr92Sw
         1LoNhoIdSrJexiPL0K3vWgt/tZ/TNXRPvFLQ/BIRwsHavAF9CegP34TIlRejNwMlMFf3
         zE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WaAOFGJAd+WHLDvf0xKzV93iMnk9wVl5Rpau3SAZLA0=;
        b=mjv2zzXh7wMtbr/Ow82IYyeivltPvt8rRBAsNNbm5Cs+B2P6Gz+LcG0Wp+qSUq2AD3
         zs6pDsr9k1TF8PAwqsHGFdcDx5evD5B1zllMw6DPq0mxGmTxQBR849LPYEfwiZ/ypyb5
         HC3U59HmOfMYFgcWB4Z+NypIbxIXycdMcLvyUAmpTG1DQTB+mahtxepASf6bWUBjXwdf
         Gp7iDkxX+YbS0qKagXXl+7xobFCeiQQsAAt/tyzDEiNPjt0MLsiedRyZTGrYlIcWv4UT
         Wxk5J1e5sI/tJUHVx/ehZ7Z+lGRdt2XxYvPFrDYOZ4lA3Y8m96sNsPfrE212szvZ6B63
         5J6A==
X-Gm-Message-State: AOAM531P85KEvFb5cCF7nOLoaehMxBsojW75qMVCqpeRkWwoXHzjpOnT
        e1ZX+msLgw88wffZKiPhXmy4C/u1VhPB5g==
X-Google-Smtp-Source: ABdhPJzSQcvWdIkcQ5+YPMm/ZbQnjyUeob6ywygQFNUpRpQzVU8u8pT2Ixc2iGg/NUkYIwlJDIABmQ==
X-Received: by 2002:a17:90a:e697:: with SMTP id s23mr14590668pjy.16.1603068441365;
        Sun, 18 Oct 2020 17:47:21 -0700 (PDT)
Received: from [192.168.1.200] (FL1-111-169-190-108.hyg.mesh.ad.jp. [111.169.190.108])
        by smtp.gmail.com with ESMTPSA id 198sm9785010pfy.41.2020.10.18.17.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 17:47:20 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] exfat: aggregate dir-entry updates into
 __exfat_write_inode().
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20201002060539epcas1p4efa16130724ad15a3f105f62dd78d018@epcas1p4.samsung.com>
 <20201002060528.27519-1-kohada.t2@gmail.com>
 <018b01d6a391$f06fc310$d14f4930$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <5c83b81c-e11d-094a-4a92-409605bd312d@gmail.com>
Date:   Mon, 19 Oct 2020 09:47:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <018b01d6a391$f06fc310$d14f4930$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> @@ -184,6 +185,11 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>>   			return -EIO;
>>   		}
>>
>> +		exfat_warn(sb, "alloc[%lu]@map: %lld (%d - %08x)",
>> +			   inode->i_ino, i_size_read(inode),
>> +			   (clu_offset << sbi->sect_per_clus_bits) * 512,
>> +			   last_clu);
> Is this leftover print from debugging?
> 
Oops!
Yes, just as you said.
I will post V4 soon.
Is there any other problem?


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
