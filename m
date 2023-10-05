Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FCA7BAF16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 01:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjJEXIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 19:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjJEXFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:05:52 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F060C18D;
        Thu,  5 Oct 2023 15:58:42 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c5c91bece9so12667845ad.3;
        Thu, 05 Oct 2023 15:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696546722; x=1697151522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ltrto+rjiXQu6CZ+tQzK6opfBYwCjT8QDYR8jfh7uis=;
        b=O7DASNSznlTd5ejToG7zZxT0IN65h5T8Uh1E7nOD4KR3FSTFiKp5uU0Klez9Eofr9S
         RUwEZRW+TnRzEJBgkjn52VWF4fl1wydVjaYeJtI5wZq8CLoY4/CwtmN2r5niieEJ7FVK
         Oa48bzGPTGd9Ir8SPA21xlelOjhxI1pu0NkrEiWXcdNm9Ad5CNjTx0qFzQ1XQITVFL4O
         +gvlsu5qz8Zln17rfS9W7BdUol9y20ikB2sMNlqa75ZHYXInhp9t6+xUa5uD+HhF+d/5
         UlVTcsTutcDLmNFcm9eh731zopuJ+c9I90dcdCvUNTZ9zdIdtRWnbRE7o41jgsK8h0nb
         fbiw==
X-Gm-Message-State: AOJu0Yzi0rLi9lue2JnwHKT1HEOiqXI/mvVVO6es2brMnUzeCewWBJJ1
        feaVLmWZO3DMDF20j/hzyo8=
X-Google-Smtp-Source: AGHT+IG0/9Wn5G/tnzM5vE5E/JIG1ER4pe53NdB/BX3Y8VlltjOu9i9A0D7Ui0Qfz98C4QopBOrp7w==
X-Received: by 2002:a17:902:6ac4:b0:1c6:d34:5279 with SMTP id i4-20020a1709026ac400b001c60d345279mr6265144plt.13.1696546722102;
        Thu, 05 Oct 2023 15:58:42 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c24600b001b89a6164desm2316513plg.118.2023.10.05.15.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 15:58:41 -0700 (PDT)
Message-ID: <d976868a-d32c-43d1-b5da-ebbc4c8de468@acm.org>
Date:   Thu, 5 Oct 2023 15:58:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
 <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
 <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
 <34c08488-a288-45f9-a28f-a514a408541d@acm.org>
 <yq1ttr6qoqp.fsf@ca-mkp.ca.oracle.com>
 <a2077ddf-9a8f-4101-aeb9-605d6dee3c6e@acm.org>
 <ZR86Z1OcO52a4BtH@dread.disaster.area>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZR86Z1OcO52a4BtH@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/5/23 15:36, Dave Chinner wrote:
> $ lspci |grep -i nvme
> 03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> 06:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> $ cat /sys/block/nvme*n1/queue/write_cache
> write back
> write back
> $
> 
> That they have volatile writeback caches....

It seems like what I wrote has been misunderstood completely. With
"handling a power failure cleanly" I meant that power cycling a block device
does not result in read errors nor in reading data that has never been written.
Although it is hard to find information about this topic, here is what I found
online:
* About certain SSDs with power loss protection:
   https://us.transcend-info.com/embedded/technology/power-loss-protection-plp
* About another class of SSDs with power loss protection:
   https://www.kingston.com/en/blog/servers-and-data-centers/ssd-power-loss-protection
* About yet another class of SSDs with power loss protection:
   https://phisonblog.com/avoiding-ssd-data-loss-with-phisons-power-loss-protection-2/

So far I haven't found any information about hard disks and power failure
handling. What I found is that most current hard disks protect data with ECC.
The ECC mechanism should provide good protection against reading data that
has never been written. If a power failure occurs while a hard disk is writing
a physical block, can this result in a read error after power is restored? If
so, is this behavior allowed by storage standards?

Bart.
