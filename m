Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C4977BB8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 16:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjHNO1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 10:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjHNO0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:26:48 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A560BB2;
        Mon, 14 Aug 2023 07:26:47 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-686ea67195dso2875719b3a.2;
        Mon, 14 Aug 2023 07:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692023207; x=1692628007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqPfjKBh4fEn5Wj87LjUhKggel2I0g0zW4XnW9s14SU=;
        b=UD7R0cYlv9ZdLynzmrk0ifiklrDAV7u2pQIzyT/HzttSYarybBYqdYMUgQd/fRwRyK
         6vaJWTWacCOsGn8F/g+X0Snh7slof1OMbNuXb6LHIBBMWf388sH5rxAYV+muvNOv9YxN
         gREyhAN/HR/Mwjq9Dn6VMHMRAldxC50xo9mzyuh5QEl/RiDQ2ABD6gT2KlTnelYGBoqS
         eEGDyW8tUtWqcyLv/QigzBOYYtVXPFeyg5v29v/9PwO5OW7eyreNl4OdDzNrAzzU0mHZ
         lxzwkjr7Iqd7bMzbTQhgwriguOXuH+GBEx6Y2cYuKEGBz7GzAd+e+BQ8bO9BDOkQfsqj
         6CNA==
X-Gm-Message-State: AOJu0YzUIxHU84Y+YM0JAPDbff0O/eNcKbcOvACGh2UQktsnSv2qziB1
        RcSlR707ZkOfEhWzB9RqwP0=
X-Google-Smtp-Source: AGHT+IHOmH/CPfbHjiPSRAabws5WhG05U7tv659QbNd/xn288gX5HmehFp2dEtU52oDRt4xSfXpfVg==
X-Received: by 2002:a05:6a21:7985:b0:135:2f12:7662 with SMTP id bh5-20020a056a21798500b001352f127662mr8501008pzc.33.1692023206792;
        Mon, 14 Aug 2023 07:26:46 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e105:59a6:229c:65de? ([2620:15c:211:201:e105:59a6:229c:65de])
        by smtp.gmail.com with ESMTPSA id x17-20020aa79191000000b006874c47e918sm7977606pfa.124.2023.08.14.07.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 07:26:46 -0700 (PDT)
Message-ID: <abad92af-d8b2-0488-cc75-01a3f4e8e270@acm.org>
Date:   Mon, 14 Aug 2023 07:26:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [dm-devel] [PATCH v14 02/11] Add infrastructure for copy offload
 in block and request layer.
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-doc@vger.kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, mcgrof@kernel.org, dlemoal@kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230811105300.15889-1-nj.shetty@samsung.com>
 <CGME20230811105648epcas5p3ae8b8f6ed341e2aa253e8b4de8920a4d@epcas5p3.samsung.com>
 <20230811105300.15889-3-nj.shetty@samsung.com>
 <3b1da341-1c7f-e28f-d6aa-cecb83188f34@acm.org>
 <20230814121853.ms4acxwr56etf3ph@green245>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230814121853.ms4acxwr56etf3ph@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/14/23 05:18, Nitesh Shetty wrote:
> On 23/08/11 02:25PM, Bart Van Assche wrote:
>> On 8/11/23 03:52, Nitesh Shetty wrote:
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> index 0bad62cca3d0..de0ad7a0d571 100644
>>> +static inline bool op_is_copy(blk_opf_t op)
>>> +{
>>> +    return ((op & REQ_OP_MASK) == REQ_OP_COPY_SRC ||
>>> +        (op & REQ_OP_MASK) == REQ_OP_COPY_DST);
>>> +}
>>> +
>>
>> The above function should be moved into include/linux/blk-mq.h below the
>> definition of req_op() such that it can use req_op() instead of 
>> open-coding it.
>>
> We use this later for dm patches(patch 9) as well, and we don't have 
> request at
> that time.

My understanding is that include/linux/blk_types.h should only contain
data types and constants and hence that inline functions like
op_is_copy() should be moved elsewhere.

Bart.

