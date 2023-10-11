Return-Path: <linux-fsdevel+bounces-129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9047C5EB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 22:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C5D2821D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 20:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD84F1BDF0;
	Wed, 11 Oct 2023 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325EA12E53
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 20:51:05 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACF9A9;
	Wed, 11 Oct 2023 13:51:03 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-27d1f57bda7so36941a91.0;
        Wed, 11 Oct 2023 13:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057463; x=1697662263;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nE+u+F1XkNDY5suKWhgfSDeZXY6238ysQJ12xui8faI=;
        b=PodpIlA6kc9rcD3lUSetKU+2XcImBSaTEYr+ZZsVQ4mVBMNYLx3gVusdMM4u7JZqGK
         6LTu48/SFjAu2kf44EapchCYl/Vz5QgMTzoyxrwZewNu2hC4js/vCs0dYwvv6yAgK8X0
         aDr7wf/DE+XFS+NQT6B9qTJngiq04pi4bJoeAFzarLPnRuQ6jTS67qrGny6JgihUWjbh
         6zm7S2V9YZkNOVTsNcNrgOmQLf1BSpw/leu6C3ak/IQaiG90HEzXYBDqzhoJjhvjFg3L
         1V2v/OABqr9hwfWk5/x4tMnWxIV1OugUx+x6kdV7Qb0ZoAYT2SXHjtV3SPxGdzDoNBe5
         90Hg==
X-Gm-Message-State: AOJu0Yy7MfkbVfsd5n+2MYEjHvQw+XrXq7opvYV4ebX9/I87baametpX
	2xvHf6wk72iK5AsNLnZMApc=
X-Google-Smtp-Source: AGHT+IEQsrUikkl+B3X3A6GHGMJk0zCkNQCIcFx/RiY+mEqPpKHqXHGQJ3jBlTWnhgrGIBsfb7aJqA==
X-Received: by 2002:a17:90a:b008:b0:273:cb91:c74f with SMTP id x8-20020a17090ab00800b00273cb91c74fmr22557041pjq.8.1697057462903;
        Wed, 11 Oct 2023 13:51:02 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:19de:6b54:16fe:c022? ([2620:15c:211:201:19de:6b54:16fe:c022])
        by smtp.gmail.com with ESMTPSA id sm6-20020a17090b2e4600b00273fc850342sm352450pjb.20.2023.10.11.13.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:51:02 -0700 (PDT)
Message-ID: <b0b015bf-0a27-4e89-950a-597b9fed20fb@acm.org>
Date: Wed, 11 Oct 2023 13:51:00 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] block: Support data lifetime in the I/O priority
 bitfield
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
 Daejun Park <daejun7.park@samsung.com>, Hannes Reinecke <hare@suse.de>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <20231005194129.1882245-4-bvanassche@acm.org>
 <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
 <46c17c1b-29be-41a3-b799-79163851f972@acm.org>
In-Reply-To: <46c17c1b-29be-41a3-b799-79163851f972@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/6/23 11:07, Bart Van Assche wrote:
> On 10/6/23 01:19, Damien Le Moal wrote:
>> Your change seem to assume that it makes sense to be able to combine 
>> CDL with
>> lifetime hints. But does it really ? CDL is of dubious value for solid 
>> state
>> media and as far as I know, UFS world has not expressed interest. 
>> Conversely,
>> data lifetime hints do not make much sense for spin rust media where 
>> CDL is
>> important. So I would say that the combination of CDL and lifetime 
>> hints is of
>> dubious value.
>>
>> Given this, why not simply define the 64 possible lifetime values as 
>> plain hint
>> values (8 to 71, following 1 to 7 for CDL) ?
>>
>> The other question here if you really want to keep the bit separation 
>> approach
>> is: do we really need up to 64 different lifetime hints ? While the scsi
>> standard allows that much, does this many different lifetime make 
>> sense in
>> practice ? Can we ever think of a usecase that needs more than say 8 
>> different
>> liftimes (3 bits) ? If you limit the number of possible lifetime hints 
>> to 8,
>> then we can keep 4 bits unused in the hint field for future features.
> 
> Hi Damien,
> 
> Not supporting CDL for solid state media and supporting eight different
> lifetime values sounds good to me. Is this perhaps what you had in mind?
> 
> Thanks,
> 
> Bart.
> 
> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -100,6 +100,14 @@ enum {
>          IOPRIO_HINT_DEV_DURATION_LIMIT_5 = 5,
>          IOPRIO_HINT_DEV_DURATION_LIMIT_6 = 6,
>          IOPRIO_HINT_DEV_DURATION_LIMIT_7 = 7,
> +       IOPRIO_HINT_DATA_LIFE_TIME_0 = 8,
> +       IOPRIO_HINT_DATA_LIFE_TIME_1 = 9,
> +       IOPRIO_HINT_DATA_LIFE_TIME_2 = 10,
> +       IOPRIO_HINT_DATA_LIFE_TIME_3 = 11,
> +       IOPRIO_HINT_DATA_LIFE_TIME_4 = 12,
> +       IOPRIO_HINT_DATA_LIFE_TIME_5 = 13,
> +       IOPRIO_HINT_DATA_LIFE_TIME_6 = 14,
> +       IOPRIO_HINT_DATA_LIFE_TIME_7 = 15,
>   };

(replying to my own e-mail)

Hi Damien,

Does the above look good to you?

Thanks,

Bart.


