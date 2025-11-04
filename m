Return-Path: <linux-fsdevel+bounces-66927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3AC30BE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 12:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E0CF34A2A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 11:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD722EAB80;
	Tue,  4 Nov 2025 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPdGemG0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B82E92D9
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255936; cv=none; b=sNEmf44j1ZgOWvDfKw8HE5yYCGOQz8Qy1fqFk/HXHz23dEa9CxpbddZDYqhbUSGA3y+I49x50yPDOcOaR7pkMscrT1oX1QfRRAX79g+Qgkw8ZXkN/gxvdKhIh25s8fdZQQq6/t+fEw8Xbp1nF4YS3RDP6cb2bB5yqvWbn3Oirnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255936; c=relaxed/simple;
	bh=Sw7bSqlGqr5IT9Xat5i0E71Exlf9sKUY61iDbp4a4t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2iPavC3hlrT+u0lYFSGZ6fhaqeJ/rTy2QYhb6vOOzBUCWZAJ/0KzGq9O9h7nFweTSYdpZc7l0xqgCxTSvGbc2KGbcpfQ2B8BvN+aLvQh5ESKqcJTDFgL0kgs32rY9nQUur0JRpk+syZdcBDVeD2agb3U/TgnBAy562lRlxjKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPdGemG0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so2021312b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 03:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762255934; x=1762860734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aoSxDhxS90f6BeCfm1xZZ+x6pE+INoKbsN0wsldLLGc=;
        b=kPdGemG0DCN+yk6LnPqF6SDXZwGjacksJbxEPAQ6EyolxXjOUZpfBzAn/Pl7k+Q4TT
         jKVEBkLxw0PAc81bkRAnFi7ee4QAsf067QCz8f4AcbEorBk2zLOwDQS/8dwQU0Geg6pr
         ZjL74Jy2o36rugOgpMQCs06r3+pDmoD0haJCSdRVtFNQnJgwSWivGxp/ojPt+9lo9+Po
         8HgJJPsnLuQVKAzQReWRwAWcOfa64v9ZQqY24Ow1BfmfHgW0kDuAyNbF+DpehP0D0Gda
         bArD5/LML6RZnxojefkB1q2i6FFih35tYVKmZYVfC6OOp5h4MgwabhkVxfOGHagJIMHS
         zUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255934; x=1762860734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoSxDhxS90f6BeCfm1xZZ+x6pE+INoKbsN0wsldLLGc=;
        b=eGal4P9/Lv9nAhvBZmTvXqMva7NUFc7xBD1IXvALm69UHVvRKi6Js1qPPjmzGtq0r6
         aS9xLbPnu1Dn0WfzCB1dAuu/dts7ZuNuvfrbV3t3Raim53mugASQCfENIu3PuzwOv8h0
         90i2GqsqNhdQA4qEK6xvvgZuyfu2prUk/iVZYIw6uL7oNyHavh0ZxuKb9HZT+WSa1Gux
         jaX2uIBCD+KgzLYCA31ODbd/u3T/4fivatsrMa4CrHhJT6WvPGUkg/a6sSwyG8phC8Ow
         UR63qbtRQU1kzRj6koBq1v5ttx/tzFQhN9j0xtDnMlEEiRQPVK71RvMZv9gKzAsbamz3
         mQBg==
X-Forwarded-Encrypted: i=1; AJvYcCVJOdDPFLxfSnpWgoNVNDb09T5CO/+/PrYpR3eC+Z3X7FqivTFQYFNQNJc2Ob/o81wQTQOBiCjb88RreE0N@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl8vucaUslLI5dlHCEoIgbfeJ4Ky0Gz5kHgb1RVXr8uSmWHNaP
	hiNAbIwfkSRSMI2OQaJZRU9bxEVZ9R4Di8izZ3/1BH4IbKidSN4B+ghc
X-Gm-Gg: ASbGncscoo0bMoYt843iF0b4i8eG37lEJ4sFJzF4EMIFuDPlRuthl0OkPv9wImLUCcY
	/TE5byXflbAmryGarDIlOk8Dnq1AodMaEVToNUBKm7lvuBL7JVNCRKVCB+owVCYwmAoVPmO+FW+
	PbL1AmuizKZj5HPAfOGQMKIKqsXZtVX1wfoKhYxMKpfK+J2/Yj/Znh/IBsj3s9U546jLgZAb/gf
	0KBDFN8Hl34iI7nhVKsv5mWQNckUhGqBszKHHtFWyh0mNWTiurnAMamKPW0vYIex3n/oiBPK5Az
	xncN8S1HZT4RR77b0Ek4qcK+H3JFYLCdKctd0V8K+wZEaWatpJMyzsrDaX6gF0BEuHB6PXMiW3h
	43uamGt74cT8KyMWNv58pRqhcAxvDBMgMDge5FzNSTUg8vFHr/FJrR44lODtoB88qa3eSseJsIn
	KoKSMRStuRSYSioFxlUbA=
X-Google-Smtp-Source: AGHT+IFQi4sy7Pt+iNRc3yBEyf08yF9LpgtHzOpvhx7vFHjqpeB38ssLGuLoFfNxgUkcZVwLEr9mCA==
X-Received: by 2002:a05:6300:8a03:b0:34e:865e:8a65 with SMTP id adf61e73a8af0-34e866de6cbmr2005737637.52.1762255934090;
        Tue, 04 Nov 2025 03:32:14 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6919401sm2618951b3a.65.2025.11.04.03.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 03:32:13 -0800 (PST)
Message-ID: <8031227a-8a27-4aa0-8ca2-c44f494e9ad2@gmail.com>
Date: Tue, 4 Nov 2025 19:32:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] isofs: check the return value of
 sb_min_blocksize() in isofs_fill_super
To: Christoph Hellwig <hch@infradead.org>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
 <20251103164722.151563-4-yangyongpeng.storage@gmail.com>
 <aQndM_Bq1HPRNyds@infradead.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <aQndM_Bq1HPRNyds@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 19:02, Christoph Hellwig wrote:
> On Tue, Nov 04, 2025 at 12:47:21AM +0800, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> sb_min_blocksize() may return 0. Check its return value to avoid
>> opt->blocksize and sb->s_blocksize is 0.
>>
>> Cc: <stable@vger.kernel.org> # v6.15
>> Fixes: 1b17a46c9243e9 ("isofs: convert isofs to use the new mount API")
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>> ---
>>   fs/isofs/inode.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
>> index 6f0e6b19383c..ad3143d4066b 100644
>> --- a/fs/isofs/inode.c
>> +++ b/fs/isofs/inode.c
>> @@ -610,6 +610,11 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
>>   		goto out_freesbi;
>>   	}
>>   	opt->blocksize = sb_min_blocksize(s, opt->blocksize);
>> +	if (!opt->blocksize) {
>> +		printk(KERN_ERR
> 
> This should probably use pr_err instead.
> 

Thanks for the review. The other functions in fs/isofs/inode.c use 
"printk(KERN_ERR|KERN_DEBUG|KERN_WARNING ...)", so I used 
"printk(KERN_ERR ...)" for consistency.

Yongpeng,

