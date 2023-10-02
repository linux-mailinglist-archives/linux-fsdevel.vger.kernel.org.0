Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964B17B584B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjJBQjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 12:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjJBQjQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:39:16 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6149AB3;
        Mon,  2 Oct 2023 09:39:14 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c5cd27b1acso148806335ad.2;
        Mon, 02 Oct 2023 09:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696264751; x=1696869551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Epc3kHekMbk3DpyR613WlFgpCZN6T8om28Nb8xn4ctM=;
        b=hgx9i3iXgDE/dUyZN/t8cfuiy0THEROgV3h/vLEV+hj/MzxIU2dpdkuRb18v3hg7AM
         hAjAC/vYR22WMY7xpEgpmdVf2tP8y5kCA3asJLcPIi3BLgURHJvOIJIenPF8ADDtSIkV
         UhgxXdNYiTFsk+UnhjYAUJ8ALSaj6X1qDSyCaWeYRNZN6DbDbENYHokN+8HUVE6D/fkf
         YW5wz0iwYMJ4WHrY21Cbb6x5PaBUT61/20WxgSn6vk8ukXOQ5oBdGVU2jcFp+hWEDkxE
         iT1aC9hdr/LPdcUUor+NMoHLkjo+GGuCJgIPOXL6Ms0JUWYIitex2YnlikfjdsjKXu6G
         bMqA==
X-Gm-Message-State: AOJu0YzETYx6wuBRma/JcXX9rhzNRkyuloVh8tB3+djr8GZrjyRr74i4
        akQCaTNl+bUq83xdHL/Qxgs=
X-Google-Smtp-Source: AGHT+IHB7bfjcRTKOYZhsbBGxygH0ZM3vak6LlonbVA5Gw3MYbtT8JKoz0CPRb1bjtZ5gI4feDJEFQ==
X-Received: by 2002:a17:902:d508:b0:1c6:1733:fb3f with SMTP id b8-20020a170902d50800b001c61733fb3fmr13983893plg.49.1696264751217;
        Mon, 02 Oct 2023 09:39:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6ad7:f663:5f97:db57? ([2620:15c:211:201:6ad7:f663:5f97:db57])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902ed4300b001bdd68b3f4bsm14079194plb.295.2023.10.02.09.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 09:39:10 -0700 (PDT)
Message-ID: <56a4089e-d8f2-48d9-9bfd-3fd687c44834@acm.org>
Date:   Mon, 2 Oct 2023 09:39:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] fs: Restore kiocb.ki_hint
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        David Howells <dhowells@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-4-bvanassche@acm.org>
 <DM6PR04MB657516145B6C3E71FEDB0C6CFCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB657516145B6C3E71FEDB0C6CFCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/2/23 03:45, Avri Altman wrote:
>> diff --git a/io_uring/rw.c b/io_uring/rw.c
>> index c8c822fa7980..c41ae6654116 100644
>> --- a/io_uring/rw.c
>> +++ b/io_uring/rw.c
>> @@ -677,6 +677,7 @@ static int io_rw_init_file(struct io_kiocb *req,
>> fmode_t mode)
>>                  req->flags |= io_file_get_flags(file);
>>
>>          kiocb->ki_flags = file->f_iocb_flags;
>> +       kiocb->ki_hint = file_inode(file)->i_write_hint;
>
> Originally ki_hint_validate() was used here as well?

Thanks for having reported this. I will restore the ki_hint_validate()
call in the io_uring code.

Bart.

