Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3262424E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 06:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgHLExS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 00:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgHLExR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 00:53:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077AC06174A;
        Tue, 11 Aug 2020 21:53:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f5so545215plr.9;
        Tue, 11 Aug 2020 21:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zFEjZKzQE3ZABmc81+BgSC7mMz71MgJlsGm5WTbANI0=;
        b=LlIaviUVzDC86445Fo6GeWoMXQdYHSPlkdm4yJvnUhBoPXuq7jkH6fZ7NJrLM8lEZ+
         9DIuG36wsobjOFp5MxXVbCOZV8VYyU25vJ3cOi/328XjmI5cYXUQnyoKom7zkxhiQdMq
         qcEFfGtzQKoMz9MYmRrNXPmgwvKvOvQi6o9PCFtD2YQtIUKdd3FwayvdX4PYaNJPtfGo
         Mr8vP9dqw0iVGlS95yGveFOrvdsTLE+g4rOq25jyLQSURWv9XLki5GsNqXQTT1PyKLVz
         xRHwTlpwzkmINLj23XyVKq8eg+u2eHZWCQGA2VmVjwD+PZkSk7tNob5SFGimyCCdaxdv
         yLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zFEjZKzQE3ZABmc81+BgSC7mMz71MgJlsGm5WTbANI0=;
        b=IfIy+dDcQuKC4L7jWNJtobhAoWjMQaPlKPEFi3zvoONLz9cMyM3qh3qKhxRV/JwW6j
         tonLPd/RKCB/UNjlDA0+N37nuO7mQSFyJMzUDlbaidOsI5Xhoc7ItCtND9Nrmvj5Vx6E
         hm4lBCQ7YmJPQE+qAwB4wB/CZKDbcFb/QMqhlzVRg4K+bSn+tCSgtTCHwmwhR/qauAuF
         MXR4wcDvh1Dz9F00pibUCcMVPhXw+AjliWEC65Pbarcou7vr2cBmouUSs8YUyBUcWcr7
         fL2t7Z54xN5nk1hBj2+NFwVxmPuRWL1X076msjoUL+L1mn/PgjTzoVt4DblIH+XT5ifb
         /AvA==
X-Gm-Message-State: AOAM533LRhKTkagflzu9eewTlvLZfP1Nk9Jdf9oH6B9/oSVX039fjRby
        bWJf2KsuPukWozHiZEza5Y+Pyoh4
X-Google-Smtp-Source: ABdhPJwXq4XTNtUZQ0DS7An7X2Qnhski79XcTogJnGrAf4HsbsSZPLMxhqsxAxSWIlOQDbTw/lYcIw==
X-Received: by 2002:a17:902:16b:: with SMTP id 98mr3574997plb.23.1597207995914;
        Tue, 11 Aug 2020 21:53:15 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:5c24:508b:d8c0:f3b? ([2404:7a87:83e0:f800:5c24:508b:d8c0:f3b])
        by smtp.gmail.com with ESMTPSA id l78sm758969pfd.130.2020.08.11.21.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 21:53:15 -0700 (PDT)
Subject: Re: [PATCH 1/2] exfat: add NameLength check when extracting name
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200806055718epcas1p33009b21ebf96b48d6e3f819065fade28@epcas1p3.samsung.com>
 <20200806055653.9329-1-kohada.t2@gmail.com>
 <000101d66da4$8d1b5090$a751f1b0$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <e5344111-f486-b52a-970e-fc349e90d375@gmail.com>
Date:   Wed, 12 Aug 2020 13:53:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <000101d66da4$8d1b5090$a751f1b0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for your reply.

On 2020/08/09 1:54, Sungjong Seo wrote:
>> The current implementation doesn't care NameLength when extracting the
>> name from Name dir-entries, so the name may be incorrect.
>> (Without null-termination, Insufficient Name dir-entry, etc) Add a
>> NameLength check when extracting the name from Name dir-entries to extract
>> correct name.
>> And, change to get the information of file/stream-ext dir-entries via the
>> member variable of exfat_entry_set_cache.
>>
>> ** This patch depends on:
>>    '[PATCH v3] exfat: integrates dir-entry getting and validation'.
>>
>> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
>> ---
>>   fs/exfat/dir.c | 81 ++++++++++++++++++++++++--------------------------
>>   1 file changed, 39 insertions(+), 42 deletions(-)
>>
>> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
>> 91cdbede0fd1..545bb73b95e9 100644
>> --- a/fs/exfat/dir.c
>> +++ b/fs/exfat/dir.c
>> @@ -28,16 +28,15 @@ static int exfat_extract_uni_name(struct exfat_dentry
>> *ep,
>>
>>   }
>>
>> -static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
>> -		struct exfat_chain *p_dir, int entry, unsigned short
>> *uniname)
>> +static int exfat_get_uniname_from_name_entries(struct
>> exfat_entry_set_cache *es,
>> +		struct exfat_uni_name *uniname)
>>   {
>> -	int i;
>> -	struct exfat_entry_set_cache *es;
>> +	int n, l, i;
>>   	struct exfat_dentry *ep;
>>
>> -	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES);
>> -	if (!es)
>> -		return;
>> +	uniname->name_len = es->de_stream->name_len;
>> +	if (uniname->name_len == 0)
>> +		return -EIO;
> 
> -EINVAL looks better.

OK.
I'll change in v2.

>>   	/*
>>   	 * First entry  : file entry
>> @@ -45,14 +44,15 @@ static void exfat_get_uniname_from_ext_entry(struct
>> super_block *sb,
>>   	 * Third entry  : first file-name entry
>>   	 * So, the index of first file-name dentry should start from 2.
>>   	 */
>> -
>> -	i = 2;
>> -	while ((ep = exfat_get_validated_dentry(es, i++, TYPE_NAME))) {
>> -		exfat_extract_uni_name(ep, uniname);
>> -		uniname += EXFAT_FILE_NAME_LEN;
>> +	for (l = 0, n = 2; l < uniname->name_len; n++) {
>> +		ep = exfat_get_validated_dentry(es, n, TYPE_NAME);
>> +		if (!ep)
>> +			return -EIO;
>> +		for (i = 0; l < uniname->name_len && i <
> EXFAT_FILE_NAME_LEN;
>> i++, l++)
>> +			uniname->name[l] = le16_to_cpu(ep-
>>> dentry.name.unicode_0_14[i]);
> 
> Looks good.
> 
>>   	}
>> -
>> -	exfat_free_dentry_set(es, false);
>> +	uniname->name[l] = 0;
>> +	return 0;
>>   }
>>
>>   /* read a directory entry from the opened directory */ @@ -63,6 +63,7 @@
>> static int exfat_readdir(struct inode *inode, struct exfat_dir_entry
>> *dir_entry)
> [snip]
>> -			*uni_name.name = 0x0;
>> -			exfat_get_uniname_from_ext_entry(sb, &dir, dentry,
>> -				uni_name.name);
>> +			dir_entry->size = le64_to_cpu(es->de_stream-
>>> valid_size);
>> +
>> +			exfat_get_uniname_from_name_entries(es, &uni_name);
> 
> Modified function has a return value.
> It would be better to check the return value.

Oops!
I'll fix it in v2.


>>   			exfat_utf16_to_nls(sb, &uni_name,
>>   				dir_entry->namebuf.lfn,
>>   				dir_entry->namebuf.lfnbuf_len);
>> -			brelse(bh);
>>
>> -			ep = exfat_get_dentry(sb, &clu, i + 1, &bh, NULL);
>> -			if (!ep)
>> -				return -EIO;
>> -			dir_entry->size =
>> -				le64_to_cpu(ep->dentry.stream.valid_size);
>> -			brelse(bh);
>> +			exfat_free_dentry_set(es, false);
>>
>>   			ei->hint_bmap.off = dentry >> dentries_per_clu_bits;
>>   			ei->hint_bmap.clu = clu.dir;
>> --
>> 2.25.1
> 
> 
