Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDA62547FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 16:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgH0O5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 10:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgH0M0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:26:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BFEC061237;
        Thu, 27 Aug 2020 05:26:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d22so3364237pfn.5;
        Thu, 27 Aug 2020 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yshf0t+B3H2Fa7nb62l3WyLSVIwsly5Q7xCX3DmLffE=;
        b=NFWkpvTXXDzp1w5mZset2RiJ5g05ZT+xyjl78iInz5/zvgMHtsTH8g4bms1yHsbtB7
         6Dlflzfn1sV7eBOSr6wu9WspwIkgX5f+l0OHPDZ9TGAoixwJt8xA+gERMayIsAJiZMpW
         qIpDenLAYsUBGrP/Evx1QdLQqJbA9PcPmB9M8PApLK+71Tgr/i6C6o2BPfcIaQPfLmxB
         rxwNf5l2pihVbyAsEmRC2jozCQT/tSKT/ZgFs/fEk4zkDoA7y/AJ1ZUd7qsy3o2mI7gr
         AhYuDyfCrBasXAsuRu7qRFCygAIlK2bpUXLpShsjyCZ2HYLYdrDad2mHiITB2D3ybroJ
         Oj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yshf0t+B3H2Fa7nb62l3WyLSVIwsly5Q7xCX3DmLffE=;
        b=nIbhrXjSYuc5B3jfREJdkdhQLjMFQC76dZ32+qTBNehncxDrcjWo4FMBruwjLRhSEK
         4DzGPH83CXAyzWsIzvTuszpEdU8mWNWm1SHvpji5QHJuYx7eLtUTb1bYz1Ru+UEFXNAg
         Y7UaftZEs1gnn4iUHPuPTQsLuv0OqaGg7MpUuEHqo5flJPKZ1Qz8/D/aMQOE86/3ekGu
         9agTsZDtCH1AKD42WfPJBQqAj5yMRlhgIrqoTtAKI/e4SYvRdA7hjFRW7wvjRgJZ/K0l
         Fo7ASIdsVngebX4feo0bqwe/jEytqts6LnKNqDR8nUyB3sQXBFXo/SPodwamgoCwnUKl
         klQg==
X-Gm-Message-State: AOAM532nzFs+KgBbvkY6fcHZxRxySUOJ87WrKUqXcRdniW/QZFhpiO7J
        QGhjAWrv5ABF03prsISER+IZNFfcH/U=
X-Google-Smtp-Source: ABdhPJy4xSnQ/89HQNJOqn91G2wB0K2dcUDhB/FX3pR5jOgT4cde3TG+1FIj83w226bL/LxOaOYg0A==
X-Received: by 2002:a17:902:9888:: with SMTP id s8mr15941903plp.111.1598531184442;
        Thu, 27 Aug 2020 05:26:24 -0700 (PDT)
Received: from [192.168.1.200] (FL1-111-169-205-196.hyg.mesh.ad.jp. [111.169.205.196])
        by smtp.gmail.com with ESMTPSA id f24sm2062255pjt.53.2020.08.27.05.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 05:26:24 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] exfat: integrates dir-entry getting and validation
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200826115753epcas1p3321f1021e92cfba8279d8976e835d436@epcas1p3.samsung.com>
 <20200826115742.21207-1-kohada.t2@gmail.com>
 <011101d67c20$e3d604e0$ab820ea0$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <2d26da8b-eb50-1374-5cfc-c8ee1daabc0c@gmail.com>
Date:   Thu, 27 Aug 2020 21:26:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <011101d67c20$e3d604e0$ab820ea0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for your quick review.

On 2020/08/27 12:19, Namjae Jeon wrote:
>> +	i = ES_INDEX_NAME;
>> +	while ((ep = exfat_get_validated_dentry(es, i++, TYPE_NAME))) {
> Please find the way to access name entries like ep_file, ep_stream
> without calling exfat_get_validated_dentry().

Hmm, it's a hard order.
I can't separate length/type validation and extraction.
Sorry, I have no good idea.


>> @@ -590,17 +587,16 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,  void
>> exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)  {
>>   	int chksum_type = CS_DIR_ENTRY, i;
>> -	unsigned short chksum = 0;
>> +	u16 chksum = 0;
>>   	struct exfat_dentry *ep;
>>
>>   	for (i = 0; i < es->num_entries; i++) {
>> -		ep = exfat_get_dentry_cached(es, i);
>> +		ep = exfat_get_validated_dentry(es, i, TYPE_ALL);
> Ditto, You do not need to repeatedly call exfat_get_validated_dentry() for the entries
> which got from exfat_get_dentry_set().

Even if I could do that, it would be very difficult to implement a checksum patch.
It is also difficult to use for rename, move, delete.
(these also have no verification of neme-length and set-checksum)


>>   	/* validiate cached dentries */
>> -	for (i = 1; i < num_entries; i++) {
>> -		ep = exfat_get_dentry_cached(es, i);
>> -		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
>> -			goto free_es;
>> +	es->ep_stream = exfat_get_validated_dentry(es, ES_INDEX_STREAM, TYPE_STREAM);
>> +	if (!es->ep_stream)
>> +		goto free_es;
>> +
>> +	if (max_entries == ES_ALL_ENTRIES) {
>> +		for (i = 0; i < ES_FILE(es).num_ext; i++)
>> +			if (!exfat_get_validated_dentry(es, ES_INDEX_STREAM + i, TYPE_SECONDARY))
>> +				goto free_es;
>> +		for (i = 0; i * EXFAT_FILE_NAME_LEN < ES_STREAM(es).name_len; i++)
>> +			if (!exfat_get_validated_dentry(es, ES_INDEX_NAME + i, TYPE_NAME))
>> +				goto free_es;
> Why do you unnecessarily check entries with two loops?
> Please refer to the patch I sent.

This order is possible.
However, TYPE_SECONDARY loop will be back as checksum loop.

In the next patch, I can fix the 'TYPE_SECONDARY loop' order.
do you need it?


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>


