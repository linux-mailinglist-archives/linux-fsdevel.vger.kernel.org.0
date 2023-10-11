Return-Path: <linux-fsdevel+bounces-93-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624497C5993
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEB51C20C26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AF928DA6;
	Wed, 11 Oct 2023 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA511A59F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 16:52:58 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA598;
	Wed, 11 Oct 2023 09:52:56 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so5939125b3a.3;
        Wed, 11 Oct 2023 09:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043176; x=1697647976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6zUpknAC7Sy2tcpF9mgl5ePU7XxnvjLIarfaMOgLr0=;
        b=B5+ofsLqeRjN27IeiDjLSeN5NWi0qwuZDabjzTC355x4NdmWt4G1nKfojSOb/PeLwJ
         r8YMIZgjRpaFCETemVCbW0L9Z1umBCEhFbDn2+IAXSgg+sI8Mxsn/EoeElOpGCCSswhx
         p27tb3Xoeq7EPsb+4lXY6irjIGqmZ79fF0t5WL90NOgod3WQ9OHKZQH5EacrEty5lw6+
         hyJid3CV/qMXGaQJKBGTSZpJTtQd36LXOSD3qhAggZgF+ui+Z8RrP0Df+A06OU/7j/7H
         IqfxCjcc6ph7lW/DyhoFQWXy1isqanrfMok3Tuk5x/L6Mz3BVOC2tj+GLWay4PWRjnR3
         BQEA==
X-Gm-Message-State: AOJu0YxRxldJ8boLOqRB7nTuYQGrbHI2uCbwKr/aiCEH/tKohFQ/bjmq
	jNT3DWo9XQCCRy7MNV13ij4=
X-Google-Smtp-Source: AGHT+IHFQjQ/lCq+cNlsykqzNv6FsFfaJeTA7h4SGpi90ObKvJ5LTN9AtVaZclt5Blb+HsZDGtxaBg==
X-Received: by 2002:a05:6a00:b95:b0:68f:dfea:9100 with SMTP id g21-20020a056a000b9500b0068fdfea9100mr28789481pfj.21.1697043175734;
        Wed, 11 Oct 2023 09:52:55 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:19de:6b54:16fe:c022? ([2620:15c:211:201:19de:6b54:16fe:c022])
        by smtp.gmail.com with ESMTPSA id i29-20020a633c5d000000b0057c44503835sm86555pgn.65.2023.10.11.09.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 09:52:55 -0700 (PDT)
Message-ID: <bfb7e2be-79f8-4f5e-b87e-3045d9c937b4@acm.org>
Date: Wed, 11 Oct 2023 09:52:52 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] block: Make bio_set_ioprio() modify fewer
 bio->bi_ioprio bits
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
 Daejun Park <daejun7.park@samsung.com>, Damien Le Moal <dlemoal@kernel.org>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <CGME20231005194156epcas5p14c65d7fbecc60f97624a9ef968bebf2e@epcas5p1.samsung.com>
 <20231005194129.1882245-2-bvanassche@acm.org>
 <28f21f46-60f1-1651-e6a9-938fd2340ff5@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <28f21f46-60f1-1651-e6a9-938fd2340ff5@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/9/23 22:22, Kanchan Joshi wrote:
> On 10/6/2023 1:10 AM, Bart Van Assche wrote:
>> A later patch will store the data lifetime in the bio->bi_ioprio member
>> before bio_set_ioprio() is called. Make sure that bio_set_ioprio()
>> doesn't clear more bits than necessary.
>>
>> Cc: Damien Le Moal <dlemoal@kernel.org>
>> Cc: Niklas Cassel <niklas.cassel@wdc.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>    block/blk-mq.c         |  3 ++-
>>    include/linux/ioprio.h | 10 ++++++++++
>>    2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index e2d11183f62e..bc086660ffd3 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2926,7 +2926,8 @@ static void bio_set_ioprio(struct bio *bio)
>>    {
>>    	/* Nobody set ioprio so far? Initialize it based on task's nice value */
>>    	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
>> -		bio->bi_ioprio = get_current_ioprio();
>> +		ioprio_set_class_and_level(&bio->bi_ioprio,
>> +					   get_current_ioprio());
>>    	blkcg_set_ioprio(bio);
>>    }
>>    
>> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
>> index 7578d4f6a969..f2e768ab4b35 100644
>> --- a/include/linux/ioprio.h
>> +++ b/include/linux/ioprio.h
>> @@ -71,4 +71,14 @@ static inline int ioprio_check_cap(int ioprio)
>>    }
>>    #endif /* CONFIG_BLOCK */
>>    
>> +#define IOPRIO_CLASS_LEVEL_MASK ((IOPRIO_CLASS_MASK << IOPRIO_CLASS_SHIFT) | \
>> +				 (IOPRIO_LEVEL_MASK << 0))
>> +
>> +static inline void ioprio_set_class_and_level(u16 *prio, u16 class_level)
>> +{
>> +	WARN_ON_ONCE(class_level & ~IOPRIO_CLASS_LEVEL_MASK);
>> +	*prio &= ~IOPRIO_CLASS_LEVEL_MASK;
>> +	*prio |= class_level;
> 
> Return of get_current_ioprio() will touch all 16 bits here. So
> user-defined value can alter whatever was set in bio by F2FS (patch 4 in
> this series). Is that not an issue?

The above is incomprehensible to me. Anyway, I will try to answer.

It is not clear to me why it is claimed that "get_current_ioprio() will
touch all 16 bits here"? The return value of get_current_ioprio() is
passed to ioprio_set_class_and_level() and that function clears the hint
bits from the get_current_ioprio() return value.

ioprio_set_class_and_level() preserves the hint bits set by F2FS.

> And what is the user interface you have in mind. Is it ioprio based, or
> write-hint based or mix of both?

Since the data lifetime is encoded in the hint bits, the hint bits need
to be set by user space to set a data lifetime. In case you would help,
the blktest test that I wrote to test this functionality is available
below.

Thanks,

Bart.


diff --git a/tests/scsi/097 b/tests/scsi/097
new file mode 100755
index 000000000000..01d280021653
--- /dev/null
+++ b/tests/scsi/097
@@ -0,0 +1,62 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Google LLC
+
+. tests/zbd/rc
+. common/null_blk
+. common/scsi_debug
+
+DESCRIPTION="test block data lifetime support"
+QUICK=1
+
+requires() {
+	_have_fio
+	_have_module scsi_debug
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local scsi_debug_params=(
+		delay=0
+		dev_size_mb=1024
+		sector_size=4096
+	)
+	_init_scsi_debug "${scsi_debug_params[@]}" &&
+	local dev="/dev/${SCSI_DEBUG_DEVICES[0]}" fail &&
+	ls -ld "${dev}" >>"${FULL}" &&
+	local i fio_args=(
+		--group_reporting=1
+		--gtod_reduce=1
+		--ioscheduler=none
+		--norandommap
+		--direct=1
+		--rw=randwrite
+		--ioengine=io_uring
+		--time_based
+	) &&
+	for ((i=1; i<=3; i++)); do
+		fio_args+=(
+			--name=whint"$i"
+			--filename="${dev}"
+			--prio=$((i<<6))
+			--time_based
+			--runtime=10
+		)
+	done &&
+	_run_fio "${fio_args[@]}" >>"${FULL}" 2>&1 ||
+	fail=true
+
+	head -n 999 /sys/bus/pseudo/drivers/scsi_debug/group_number_stats >> 
"${FULL}"
+	while read -r group count; do
+		if [ "$count" -gt 0 ]; then echo "$group"; fi
+	done < /sys/bus/pseudo/drivers/scsi_debug/group_number_stats
+	_exit_scsi_debug
+
+	if [ -z "$fail" ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+		return 1
+	fi
+}
diff --git a/tests/scsi/097.out b/tests/scsi/097.out
new file mode 100644
index 000000000000..f6ed3d6de861
--- /dev/null
+++ b/tests/scsi/097.out
@@ -0,0 +1,5 @@
+Running scsi/097
+1
+2
+3
+Test complete


