Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FCA3482BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 21:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhCXURu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 16:17:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38958 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbhCXURf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:17:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id BCFFA1F45E77
Subject: Re: [RFC PATCH 2/4] mm: shmem: Support case-insensitive file name
 lookups
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, smcv@collabora.com,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Rosenberg <drosen@google.com>
References: <20210323195941.69720-1-andrealmeid@collabora.com>
 <20210323195941.69720-3-andrealmeid@collabora.com>
 <877dlxd3oc.fsf@collabora.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <a6b6dd15-17ae-13f4-be87-489976e52662@collabora.com>
Date:   Wed, 24 Mar 2021 17:17:21 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <877dlxd3oc.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Às 17:18 de 23/03/21, Gabriel Krisman Bertazi escreveu:
> André Almeida <andrealmeid@collabora.com> writes:
>>   	opt = fs_parse(fc, shmem_fs_parameters, param, &result);
>>   	if (opt < 0)
>> @@ -3468,6 +3519,23 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>>   		ctx->full_inums = true;
>>   		ctx->seen |= SHMEM_SEEN_INUMS;
>>   		break;
>> +	case Opt_casefold:
>> +		if (strncmp(param->string, "utf8-", 5))
>> +			return invalfc(fc, "Only utf8 encondings are supported");
>> +		ret = strscpy(version, param->string + 5, sizeof(version));
> 
> Ugh.  Now we are doing two strscpy for the parse api (in unicode_load).
> Can change the unicode_load api to reuse it?
> 

So instead of getting just the version number (e.g. "12.1.0") as 
parameter, utf8_load/unicode_load would get the full encoding string 
(e.g. "utf8-12.1.0") right?
