Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F151242C0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHLPRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 11:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgHLPRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:17:09 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2E1C061383;
        Wed, 12 Aug 2020 08:17:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l60so1291820pjb.3;
        Wed, 12 Aug 2020 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OPdbgPZo5jPPRPHIcS+vE4PWrAHpzcBRc1OSWPUvjGw=;
        b=HcVh8d5bXzhnDcRk6obxAbO9kDFuVZLMJYBoDa/NCGKVegm43fqC/mrZbv0E6BL96x
         w4oyfcYaWtHxY5ZT9Z0pChvq/X/oswR6mAdZ3z84kU2++AcL0Gis2xvqBvydx66j4Lqz
         9TgAdvtUGgsz8KKuyqz0SWC+e+nUU7+YFeIyXiCrlit/M/JfWH9vMTgXCUsd47gr5s2C
         ohtQat7gZRzwbpj6z7S1OwRjeJmVVIB6G2hs1Ox/86sXuVfxBZ4Q3gdfRP5KUhDya7Z5
         ZYspTxFJQOzSzjZKThNimM4cQ/qNwutv4pmEdNBjgUEQ9yg7XbufInFRwT38enUR9qBw
         wQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OPdbgPZo5jPPRPHIcS+vE4PWrAHpzcBRc1OSWPUvjGw=;
        b=Z7A5O6oTIZxLLfzbK9gqytCEQPwF3ssyQZ42n+SKB1+LH465Zd4Gr9FZfBUrMG0D6v
         SkLVe1pSpB57NOVKjR5Q17ABnOquzOTTzqB19J4kkEHu75PG/eIl6Ua53QMUjbzEMyF7
         TCfR2H4c53Ml6SPtxGkgaYoo1MNdrUYV+fo4dhEiIXrPiK85GXOv9EVgNpF+QJmmPz5B
         IVPGaj8El14MXNq/stH/Sm/K8DhqpP8rTj9ZlD4gtQ3O8uGcWDfrV+pfraLhqKSdZt+z
         3oCtGomk1K3V3mgokA2gMYUUHAL1J0DpcyOeFQ6vvMxTxIvn7FOGdTQONgLamppcA45a
         tcFg==
X-Gm-Message-State: AOAM530gBUoJQq6TfmIqZd5WggA+AGiy0jjB2qs4R9W0vl1+6qwexOSl
        PlUKT27LyT78IALwi7CjFiIlphBg
X-Google-Smtp-Source: ABdhPJy/oLGw62eQRU1A+7OxhwYHUA6OMPtfhcQ648vOdyOIXznDgsiWKRWzWoY69pr+OVBSwknOuQ==
X-Received: by 2002:a17:902:76cb:: with SMTP id j11mr5889298plt.29.1597245428056;
        Wed, 12 Aug 2020 08:17:08 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:5c24:508b:d8c0:f3b? ([2404:7a87:83e0:f800:5c24:508b:d8c0:f3b])
        by smtp.gmail.com with ESMTPSA id mr21sm2513142pjb.57.2020.08.12.08.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 08:17:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] exfat: add dir-entry set checksum validation
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200807073101epcas1p43ba30d0ff54cb09f90b7dc69c746d3e6@epcas1p4.samsung.com>
 <20200807073049.24959-1-kohada.t2@gmail.com>
 <003e01d66ede$2c2fe620$848fb260$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <55c049e9-f32a-486b-b150-79bf1fbb886c@gmail.com>
Date:   Thu, 13 Aug 2020 00:17:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <003e01d66ede$2c2fe620$848fb260$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thnak you for your reply.

>> -void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
>> +static int exfat_calc_dir_chksum_with_entry_set(struct
>> +exfat_entry_set_cache *es, u16 *chksum)
>>   {
>> -	int chksum_type = CS_DIR_ENTRY, i;
>> -	unsigned short chksum = 0;
>>   	struct exfat_dentry *ep;
>> +	int i;
>>
>> -	for (i = 0; i < es->num_entries; i++) {
>> -		ep = exfat_get_validated_dentry(es, i, TYPE_ALL);
>> -		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
>> -					     chksum_type);
>> -		chksum_type = CS_DEFAULT;
>> +	ep = container_of(es->de_file, struct exfat_dentry, dentry.file);
>> +	*chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, 0, CS_DIR_ENTRY);
>> +	for (i = 0; i < es->de_file->num_ext; i++) {
>> +		ep = exfat_get_validated_dentry(es, 1 + i, TYPE_SECONDARY);
>> +		if (!ep)
>> +			return -EIO;
>> +		*chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, *chksum, CS_DEFAULT);
>>   	}
>> +	return 0;
> We can return checksum after removing u16 *chksum argument.

I want to do that too!
How should I return the error?

Right now, I found that the type of chksum is not 'u16'.
I'll fix in v2.


>> +}
>> +
>> +void exfat_update_dir_chksum_with_entry_set(struct
>> +exfat_entry_set_cache *es) {
>> +	u16 chksum;
>> +
>> +	exfat_calc_dir_chksum_with_entry_set(es, &chksum);
>>   	es->de_file->checksum = cpu_to_le16(chksum);
>>   	es->modified = true;
>>   }
>> @@ -775,6 +784,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
>>   	struct exfat_entry_set_cache *es;
>>   	struct exfat_dentry *ep;
>>   	struct buffer_head *bh;
>> +	u16 chksum;
>>
>>   	if (p_dir->dir == DIR_DELETED) {
>>   		exfat_err(sb, "access to deleted dentry"); @@ -839,10 +849,10 @@ struct
>> exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
>>   		goto free_es;
>>   	es->de_stream = &ep->dentry.stream;
>>
>> -	for (i = 2; i < es->num_entries; i++) {
>> -		if (!exfat_get_validated_dentry(es, i, TYPE_SECONDARY))
>> -			goto free_es;
>> -	}
>> +	if (max_entries == ES_ALL_ENTRIES &&
>> +	    ((exfat_calc_dir_chksum_with_entry_set(es, &chksum) ||
>> +	      chksum != le16_to_cpu(es->de_file->checksum))))
> Please add error print log if checksum mismatch error happen.

OK.
I'll add in v2.


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
