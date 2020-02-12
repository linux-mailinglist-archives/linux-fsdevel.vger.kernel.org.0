Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8C15A988
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBLM5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 07:57:11 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38902 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgBLM5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:57:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so2194365ljh.5;
        Wed, 12 Feb 2020 04:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FuSs9kS8ae3w5JjTuFnQ+TphT7r0wrypfGkdXwpwO3k=;
        b=IyduzuDPBYv3bttdle4/H2G/Mobjrt2pHYyuCTdRgF3Nxm7H6tBfoondtSVigiw6Tl
         f3V36pAg8zbGds845Zknr0bzJ2lh1g3Bf/Qg66A906mOxWKAxK3Z0E0rK7/djP/Av5Lr
         c+tmAjcG5IwBgwN4T+eZ6sxwv/AMsxjgUH0XD7aYonE156L/xGbtPujYtu+ZTMEhRYZn
         H7f8aq6sAewK9W/QZbKyBGBf4aJLa39q5XAcSbqLPxeH1b8xhQdjdn4S1MikK3d4xKEd
         Ot+5p8Hkm5DAOiqjVaRwohUuSuPhLXOi2riiZl1CYkJlOfhie2k2D4kIw3lPbr37QKmP
         Vulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FuSs9kS8ae3w5JjTuFnQ+TphT7r0wrypfGkdXwpwO3k=;
        b=Ttyqeu29dGR7H/wz+C/TBV1tJXOC3wzExSJlzOouY+B7ZkB1b4EIkRX/eEAz8DheWb
         uUTeAnzgnfzGG/qeSgqwSgCT8N1ieSUm7l0jEdFNFWYcpbRKdsvDqw5qcDNs61GX3UKK
         Ti5mT8PF1WfGUrkU4WRDWriD71pyQBa3/Cr8f7uQMmtrUxPK2AbJlMijtmQT4X6iHust
         tsjGugfG89BDrr5+cA6EfJsM5p+dXoEACx8XXNNKqm3F0ObhR4QkYHXlKYRFa4WbTAv6
         D7Djqrp4sAXvjH78H79Nf4To2jiGiuOKb1EpyPaC500MQyUv3P5Yb9i71PjJIAl7WK8O
         paLw==
X-Gm-Message-State: APjAAAV3BqQbRTilWQ4hL0u+UWef22LfKDcnLmSxQ5d2IECS516quNqB
        k3F+UIufCGaUvp5hzJM1BmqidKgNbds=
X-Google-Smtp-Source: APXvYqxcw6Qgtiyx0LP+B0IJNtbp/9B9kOUrcgrqm5D7yiJFSUFGSOQXha2tKnmxxWuj4+YkHDI5Kw==
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr7873560ljj.225.1581512228434;
        Wed, 12 Feb 2020 04:57:08 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id t1sm226977lji.98.2020.02.12.04.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 04:57:04 -0800 (PST)
Subject: Re: [PATCH v2] fs: optimise kiocb_set_rw_flags()
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8cecd243-38aa-292d-15cd-49b485f9253f@gmail.com>
 <5328b35d948ea2a3aa5df2b1d740c7cb1f38c846.1579224594.git.asml.silence@gmail.com>
 <14929e52-9437-e856-7eff-4e5b45968f89@gmail.com>
Message-ID: <3fd1844b-d059-7729-8d09-ad51d11514fa@gmail.com>
Date:   Wed, 12 Feb 2020 15:57:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <14929e52-9437-e856-7eff-4e5b45968f89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/31/2020 4:01 PM, Pavel Begunkov wrote:
> On 1/17/2020 4:32 AM, Pavel Begunkov wrote:
>> kiocb_set_rw_flags() generates a poor code with several memory writes
>> and a lot of jumps. Help compilers to optimise it.
>>
>> Tested with gcc 9.2 on x64-86, and as a result, it its output now is a
>> plain code without jumps accumulating in a register before a memory
>> write.
> 
> Humble ping

Anyone?

> 
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>
>> v2: check for 0 flags in advance (Matthew Wilcox)
>>
>>  include/linux/fs.h | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 98e0349adb52..22b46fc8fdfa 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -3402,22 +3402,28 @@ static inline int iocb_flags(struct file *file)
>>  
>>  static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>>  {
>> +	int kiocb_flags = 0;
>> +
>> +	if (!flags)
>> +		return 0;
>>  	if (unlikely(flags & ~RWF_SUPPORTED))
>>  		return -EOPNOTSUPP;
>>  
>>  	if (flags & RWF_NOWAIT) {
>>  		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
>>  			return -EOPNOTSUPP;
>> -		ki->ki_flags |= IOCB_NOWAIT;
>> +		kiocb_flags |= IOCB_NOWAIT;
>>  	}
>>  	if (flags & RWF_HIPRI)
>> -		ki->ki_flags |= IOCB_HIPRI;
>> +		kiocb_flags |= IOCB_HIPRI;
>>  	if (flags & RWF_DSYNC)
>> -		ki->ki_flags |= IOCB_DSYNC;
>> +		kiocb_flags |= IOCB_DSYNC;
>>  	if (flags & RWF_SYNC)
>> -		ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
>> +		kiocb_flags |= (IOCB_DSYNC | IOCB_SYNC);
>>  	if (flags & RWF_APPEND)
>> -		ki->ki_flags |= IOCB_APPEND;
>> +		kiocb_flags |= IOCB_APPEND;
>> +
>> +	ki->ki_flags |= kiocb_flags;
>>  	return 0;
>>  }
>>  
>>
> 

-- 
Pavel Begunkov
