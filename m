Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5537B479F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Oct 2023 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjJANXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjJANXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:23:38 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CAE8E;
        Sun,  1 Oct 2023 06:23:36 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3af609c4dfeso2944548b6e.1;
        Sun, 01 Oct 2023 06:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696166615; x=1696771415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVJSYZtpL0YLa+wcSpHtc+qG+rdtMGRB99f0WwrMd40=;
        b=l8gK/xLbmU3VcpswqtVQ4osnKA3PiOgCmngkGdgGvW42lc3FPAoee0wkwEUE/i9hR3
         9a9Fj0T9jBo1x9YS3TJ/62OSIqjzO9Z617M0bHZw21IUwRAuTp5qty0WKg1zgxz8+u04
         eUV5mdQc3Tn/HrZzM7p1qYk38OeI1Lcqmwrfc2QJzy1Y0hVXjoT7GfR1wG9JpQTga1cH
         nfpzAcj7gk7kWmRMLiF8Fr2Vd5EQUSt6W/3RSJ8VggbtOtZL7aa+1RKwmJeX3r+qFALy
         OIZa1enx/FJueIi4Arsdy7hTPBm2grlt3kIqwQpFYVy5Z20RisCoEDM/hrodMBmd8WtU
         YmzA==
X-Gm-Message-State: AOJu0YwlZR5/xURFcSL7Sps60/xL7XfhhisCqbdIr+UnD22ISDmGGjHV
        UAbFcBBFdrd+UxnV+7EYGgY=
X-Google-Smtp-Source: AGHT+IG5r59Stw18eP45GGvts3KKKs7AnR8jZu7o46ucmeUjXt+CrOjIYIY866yaw9ZKQjAGZmJ61Q==
X-Received: by 2002:aca:220e:0:b0:3a1:bfda:c6d2 with SMTP id b14-20020aca220e000000b003a1bfdac6d2mr9142795oic.11.1696166615513;
        Sun, 01 Oct 2023 06:23:35 -0700 (PDT)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001c20c608373sm20148814plh.296.2023.10.01.06.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 06:23:34 -0700 (PDT)
Message-ID: <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
Date:   Sun, 1 Oct 2023 06:23:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-4-john.g.garry@oracle.com>
 <20230929224922.GB11839@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230929224922.GB11839@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/29/23 15:49, Eric Biggers wrote:
> On Fri, Sep 29, 2023 at 10:27:08AM +0000, John Garry wrote:
>> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
>> index 7cab2c65d3d7..c99d7cac2aa6 100644
>> --- a/include/uapi/linux/stat.h
>> +++ b/include/uapi/linux/stat.h
>> @@ -127,7 +127,10 @@ struct statx {
>>   	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>>   	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
>>   	/* 0xa0 */
>> -	__u64	__spare3[12];	/* Spare space for future expansion */
>> +	__u32	stx_atomic_write_unit_max;
>> +	__u32	stx_atomic_write_unit_min;
> 
> Maybe min first and then max?  That seems a bit more natural, and a lot of the
> code you've written handle them in that order.
> 
>> +#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
> 
> How would this differ from stx_atomic_write_unit_min != 0?

Is it even possible that stx_atomic_write_unit_min == 0? My understanding
is that all Linux filesystems rely on the assumption that writing a single
logical block either succeeds or does not happen, even if a power failure
occurs between writing and reading a logical block.

Thanks,

Bart.
