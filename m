Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DDB7B5A5D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbjJBSjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 14:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjJBSjM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:39:12 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3813DC;
        Mon,  2 Oct 2023 11:39:05 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59f4f80d084so1163257b3.1;
        Mon, 02 Oct 2023 11:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696271945; x=1696876745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc60tErHmFLa/ojhrllX+rIN4q7yH7L/FhjXgxWfjlA=;
        b=mMjFzSpYzwwHQFuni+3y7KwwVF9g8Ug9ala3LCcVo395Doop45T1R0ThNnxCvQQTIp
         fGaiH9G8ZPgA+kew6QfgxfRU5wKttiwT/YBLtc122oS72PCuv3W0FZQMd40pgKygu5Yj
         oxXWn+irwMT0vus+qlh8vckzi9w9dy8QL1ER2eoV1LKOjhnqSU72NskpN1scawKaNolO
         vq6EA5+28nYnVSw29+sXePEFSS8WafHjxVRi3h7BI1FrjKeL9O4jkV3KS7Bt67eI04aK
         YhUknHFRWHwJEh766Vdl4kBCszvHgd98xkxkvkMfC+IfYDgOXTYcaBmyxpW+VVj1cmSA
         mPRQ==
X-Gm-Message-State: AOJu0YzjkkRvKGjUYJWhwrqx6zEkOFXM3F/7NEU4IburZkELBZYT9gQ9
        AxUaK8p98JTvvoVv0JK+2QQ=
X-Google-Smtp-Source: AGHT+IESVNBLm8WCa7rBouLG5qA3ZmN61xUw/sb/SYnK4ixQ5LUHtH5fDdM+JtbnGYgfpHa7GLtSKA==
X-Received: by 2002:a25:c748:0:b0:ced:6134:7606 with SMTP id w69-20020a25c748000000b00ced61347606mr10978974ybe.30.1696271944617;
        Mon, 02 Oct 2023 11:39:04 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6ad7:f663:5f97:db57? ([2620:15c:211:201:6ad7:f663:5f97:db57])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c2f1a2f6bsm19484421pge.41.2023.10.02.11.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 11:39:03 -0700 (PDT)
Message-ID: <2c929105-7c7f-43c5-a105-42d1813d0e29@acm.org>
Date:   Mon, 2 Oct 2023 11:39:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>
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
 <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
 <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/2/23 02:51, John Garry wrote:
> On 01/10/2023 14:23, Bart Van Assche wrote:
>> Is it even possible that stx_atomic_write_unit_min == 0? My 
>> understanding is that all Linux filesystems rely on the assumption 
>> that writing a single logical block either succeeds or does not 
>> happen, even if a power failure occurs between writing and reading 
>> a logical block.
> 
> Maybe they do rely on this, but is it particularly interesting?
> 
> BTW, I would not like to provide assurances that every storage media 
> produced writes logical blocks atomically.

Neither the SCSI SBC standard nor the NVMe standard defines a "minimum
atomic write unit". So why to introduce something in the Linux kernel
that is not defined in common storage standards?

I propose to leave out stx_atomic_write_unit_min from
struct statx and also to leave out atomic_write_unit_min_sectors from
struct queue_limits. My opinion is that we should not support block
devices in the Linux kernel that do not write logical blocks atomically.
Block devices that do not write logical blocks atomically are not
compatible with Linux kernel journaling filesystems. Additionally, I'm
not sure it's even possible to write a journaling filesystem for such 
block devices.

Thanks,

Bart.
