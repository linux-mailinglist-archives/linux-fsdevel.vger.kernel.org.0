Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6577B5B32
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 21:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbjJBTVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 15:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbjJBTVz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:21:55 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800C7B8;
        Mon,  2 Oct 2023 12:21:52 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-692c70bc440so95996b3a.3;
        Mon, 02 Oct 2023 12:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696274512; x=1696879312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/ve4+0hI3kPGfr74V3fRnzywfGyjXPBIyqNnDnwTuY=;
        b=ASbk9QYdkJdNH3dtF4kQxAFsa1WIsFZRCmEaGeONCcDrOLUA/l3FYCyKw+jCc/l4Lp
         URXEmUyjTNfoFYhTaboe92+s7mCrUOIVAOQNo7OInFKLSaaU4MQNVpTrj/sDrS/6DeeC
         +opqrkEnDfP0HpV0WoqiNvrET5+jyMu7PgwfAhuyV9L8ecpIJ0cSoQBlYcw6D/+oJ1r3
         s42eclPXZE7oBYjDzhDlpytJE2W2JM2eOVZxf5NeDeSgsVCXAVzK4OG1qDq9tK5VqfMZ
         h9grhLsPMwTuAyv9mHhfnNUyx6Ym90CUjWcQ6z5449W3OoSjr6jQMqfdLYNOcXTZo0mT
         dnMA==
X-Gm-Message-State: AOJu0YxwOStOFqwEYS4mNMb4un+Em2+f+aOYqo7HHNVxq1/NIfLSArFa
        a1C0cxuf65JPiMj37Itu/N8=
X-Google-Smtp-Source: AGHT+IHdmSkxcMU9Q3KlwXLUK3XdwSehxi52wiuutteyt+WOowhzgK0t39kMn9Z+tSskapiavysFsA==
X-Received: by 2002:a05:6a21:35c4:b0:136:ea0e:d23 with SMTP id ba4-20020a056a2135c400b00136ea0e0d23mr9301982pzc.11.1696274511618;
        Mon, 02 Oct 2023 12:21:51 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6ad7:f663:5f97:db57? ([2620:15c:211:201:6ad7:f663:5f97:db57])
        by smtp.gmail.com with ESMTPSA id o5-20020a170902d4c500b001b896d0eb3dsm10650573plg.8.2023.10.02.12.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 12:21:51 -0700 (PDT)
Message-ID: <6a41f73c-d2ac-405f-9ecd-96dd938c9a1f@acm.org>
Date:   Mon, 2 Oct 2023 12:21:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] scsi: sd: Add WRITE_ATOMIC_16 support
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-20-john.g.garry@oracle.com>
 <2abb1fb8-88c6-401d-b65f-b7001b2203ec@acm.org>
 <a6041625-a203-04b3-fa42-ed023e868060@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a6041625-a203-04b3-fa42-ed023e868060@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/2/23 04:36, John Garry wrote:
> On 29/09/2023 18:59, Bart Van Assche wrote:
>> On 9/29/23 03:27, John Garry wrote:
>>> +static blk_status_t sd_setup_atomic_cmnd(struct scsi_cmnd *cmd,
>>> +                    sector_t lba, unsigned int nr_blocks,
>>> +                    unsigned char flags)
>>> +{
>>> +    cmd->cmd_len  = 16;
>>> +    cmd->cmnd[0]  = WRITE_ATOMIC_16;
>>> +    cmd->cmnd[1]  = flags;
>>> +    put_unaligned_be64(lba, &cmd->cmnd[2]);
>>> +    cmd->cmnd[10] = 0;
>>> +    cmd->cmnd[11] = 0;
>>> +    put_unaligned_be16(nr_blocks, &cmd->cmnd[12]);
>>> +    cmd->cmnd[14] = 0;
>>> +    cmd->cmnd[15] = 0;
>>> +
>>> +    return BLK_STS_OK;
>>> +}
>>
>> Please store the 'dld' value in the GROUP NUMBER field. See e.g.
>> sd_setup_rw16_cmnd().
> 
> Are you sure that WRITE ATOMIC (16) supports dld?

Hi John,

I was assuming that DLD would be supported by the WRITE ATOMIC(16) 
command. After having taken another look at the latest SBC-5 draft
I see that the DLD2/DLD1/DLD0 bits are not present in the WRITE 
ATOMIC(16) command. So please ignore my comment above.

Thanks,

Bart.
