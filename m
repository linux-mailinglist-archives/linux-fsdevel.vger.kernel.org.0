Return-Path: <linux-fsdevel+bounces-4535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7934780019A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 03:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA471C208B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 02:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D1BC144
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 02:31:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B5FD5C;
	Thu, 30 Nov 2023 17:46:39 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1cfcc9b3b5cso530525ad.0;
        Thu, 30 Nov 2023 17:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395199; x=1701999999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5c41QMpOuncUjmqfedNCVrAjDlB3HJLJPB7WrpfBAI=;
        b=MYPuhvbU+X2hIRyJ5gxRJc1C1faFsiza44mkYXJrqDG9mm/3pUw8wgaSluwsPG+le4
         07Gn0aGxNgJ5+jFhE3kbOcoo4EqL0xAhDIP7FNgaLaGae32hkVURPfMcoGPS6kfUiJvd
         AmIGD6dsQfxiChsvPXDoHzNXlFV9RWHQo+RHaGfib4Enjtp520sfifG8gd0C844aIw7H
         o5+u66rlm6o79yiROAfglqFu4Zu8AlgWG1RWZ+gKpyfCpm5rE8vht4baK+RDSfxYzU8T
         5zhxg01K2zEM/HceOY4OefXgD3o6VWZPWALocxvbEqXKgnQJLaX70Ubospq9y4VIaZbm
         gkcQ==
X-Gm-Message-State: AOJu0YwfnzI/gXrmkBQqoX6SvzSuKbTyegqbMwJCscsv9pKxCND2WCZm
	66gyW6xSYL2olAmh+z8RWII=
X-Google-Smtp-Source: AGHT+IGM4qesWNbhDxKcV91xYXAhnvSBMMXbrT2KmmZvLK+u7Lw/S7xaenFCQ05C29xtExDybsW67Q==
X-Received: by 2002:a17:902:b713:b0:1cf:a509:ab6b with SMTP id d19-20020a170902b71300b001cfa509ab6bmr24822604pls.67.1701395198702;
        Thu, 30 Nov 2023 17:46:38 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001cfad034756sm2058131plg.138.2023.11.30.17.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 17:46:37 -0800 (PST)
Message-ID: <7764d824-4b47-486b-9da0-cb779779739a@acm.org>
Date: Thu, 30 Nov 2023 17:46:35 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/17] scsi_proto: Add structures and constants related
 to I/O groups and streams
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Daejun Park <daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
References: <20231130013322.175290-1-bvanassche@acm.org>
 <20231130013322.175290-10-bvanassche@acm.org>
 <35f9ad75-785c-4724-b28e-a093212bc480@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <35f9ad75-785c-4724-b28e-a093212bc480@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/23 05:19, Johannes Thumshirn wrote:
> On 30.11.23 02:34, Bart Van Assche wrote:
>> +/* SBC-5 IO advice hints group descriptor */
>> +struct scsi_io_group_descriptor {
>> +#if defined(__BIG_ENDIAN)
>> +	u8 io_advice_hints_mode: 2;
>> +	u8 reserved1: 3;
>> +	u8 st_enble: 1;
>> +	u8 cs_enble: 1;
>> +	u8 ic_enable: 1;
>> +#elif defined(__LITTLE_ENDIAN)
>> +	u8 ic_enable: 1;
>> +	u8 cs_enble: 1;
>> +	u8 st_enble: 1;
>> +	u8 reserved1: 3;
>> +	u8 io_advice_hints_mode: 2;
>> +#else
>> +#error
>> +#endif
>> +	u8 reserved2[3];
>> +	/* Logical block markup descriptor */
>> +#if defined(__BIG_ENDIAN)
>> +	u8 acdlu: 1;
>> +	u8 reserved3: 1;
>> +	u8 rlbsr: 2;
>> +	u8 lbm_descriptor_type: 4;
>> +#elif defined(__LITTLE_ENDIAN)
>> +	u8 lbm_descriptor_type: 4;
>> +	u8 rlbsr: 2;
>> +	u8 reserved3: 1;
>> +	u8 acdlu: 1;
>> +#else
>> +#error
>> +#endif
>> +	u8 params[2];
>> +	u8 reserved4;
>> +	u8 reserved5[8];
>> +};
>> +
>> +static_assert(sizeof(struct scsi_io_group_descriptor) == 16);
> 
> Have you considered using GENMASK() and FILED_GET() for this? All the
> ifdefs make the header rather ugly.
Hi Johannes,

When using bitfields, there are #ifdefs in the data structure
definitions but it is easy to write code that accesses the bitfields.
When using FIELD_GET(), the data structure definitions have no ifdefs
but the code that reads bitfields becomes harder to verify. The code
for setting bitfield values would have to use FIELD_PREP() and hence
would become more complex. An example of code that sets bitfields is
the definition of the gr_m_pg data structure in patch 15/17 of this
series. It would become more complicated if FIELD_PREP() would have to
be used in the definition of that data structure.

Thanks,

Bart.

