Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD17A8DFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 22:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjITUqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 16:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITUqt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:46:49 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C63FB9;
        Wed, 20 Sep 2023 13:46:44 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c43b4b02c1so1583885ad.3;
        Wed, 20 Sep 2023 13:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695242803; x=1695847603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykhgKtsX2cSkN4uX6LBnSBcD5nrfp6+TARNRJQaJR6c=;
        b=KjEpjqii7J5F+11Ktejpqmb7mKb4ne0/2TejTMZ7m/dSQvpsVcdq+vnCQ5CVBufidd
         M2un6GCezYGVACW2Q/dibpQBbIiBqSaib3FkIDoGfbE4Fi9E1qEky3UAYw/HkwfCg2IB
         5IOxbChJv23D9p2l73NGbF0/JcDpSADag1taCyX7a4C0s6pN7NX0USp65Hsj5GIcik1h
         eb43ZrJ7cHcmJGVEoIK9wv+0f024I5daJXUH8LvlMQ8cPVfWAwCeCWIyTTBUuD1XutLl
         pyBvep6fxVSYHjMlGIx7NPHkWpz99YVYgn4oyKhwzVLkvWrgwBORdA25rfDRN+IKRbtk
         8WGw==
X-Gm-Message-State: AOJu0YxibkDPLXk3A9GMm8VH+98ZmyEix1W0YZe8TAY18pmkmWeCAgEA
        LbEb00aavWBKSgCK21USirQ=
X-Google-Smtp-Source: AGHT+IHguTQYMss6/IXnNgOwpT4FcjQGDCqbCZ3melCWZ4OqXn8ID/L0Al/3KiqNr+xc0NSK5TDqPg==
X-Received: by 2002:a17:902:7d87:b0:1c4:29dd:2519 with SMTP id a7-20020a1709027d8700b001c429dd2519mr2830020plm.67.1695242803527;
        Wed, 20 Sep 2023 13:46:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b0c6:e5b6:49ef:e0bd? ([2620:15c:211:201:b0c6:e5b6:49ef:e0bd])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001ab2b4105ddsm12240212plg.60.2023.09.20.13.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 13:46:42 -0700 (PDT)
Message-ID: <1522d8ec-6b15-45d5-b6d9-517337e2c8cf@acm.org>
Date:   Wed, 20 Sep 2023 13:46:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <ZQtHwsNvS1wYDKfG@casper.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZQtHwsNvS1wYDKfG@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/20/23 12:28, Matthew Wilcox wrote:
> On Wed, Sep 20, 2023 at 12:14:25PM -0700, Bart Van Assche wrote:
>> Zoned UFS vendors need the data temperature information. Hence
>> this patch series that restores write hint information in F2FS and
>> in the block layer. The SCSI disk (sd) driver is modified such that
>> it passes write hint information to SCSI devices via the GROUP
>> NUMBER field.
> 
> "Need" in what sense?  Can you quantify what improvements we might 
> see from this patchset?

Hi Matthew,

This is what Jens wrote about 1.5 years ago in reply to complaints about
the removal of write hint support making it impossible to pass write 
hint information to SSD devices: "If at some point there's a
desire to actually try and upstream this support, then we'll be happy to
review that patchset."
(https://lore.kernel.org/linux-block/ef77ef36-df95-8658-ff54-7d8046f5d0e7@kernel.dk/). 
Hence this patch series.

Recently T10 standardized how data temperature information should be 
passed to SCSI devices. One of the patches in this series translates 
write hint information into a data temperature for SCSI devices. This 
can be used by SCSI SSD devices (including UFS devices) to reduce write 
amplification inside the device because host software should assign the 
same data temperature to all data that will be garbage collected at once.

Thanks,

Bart.
