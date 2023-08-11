Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06D2779A76
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 00:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjHKWLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 18:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjHKWLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:11:12 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA1358B;
        Fri, 11 Aug 2023 15:11:08 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso18350115ad.0;
        Fri, 11 Aug 2023 15:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691791868; x=1692396668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o52cWlwXR3N6/ms+y9tYy0bzSVEqexTODJML7eEO/+8=;
        b=EQ2sZul3d57pqCL8M8JVf1ldHkCXVvqzCEvH+txVulk9x2C3v8ffvTOm4L6gxElL1s
         N2QTT4r0VkOzvGS7zPRkHlsmnvuGVpUSwhbEnmi7xoTzL2qnFqKxRQsnb9APMIvWtIjZ
         Cu78wspgNNGRJdY+B49+0ov+c6soFd98jGWmhtDLuGlOii/Eok8pzCWRLmSeOT7iaR3U
         FQ5Bbs+Wh7mw1W0HUtYBXpnTnfojTs2TM5OzK0IG8xFdpAwxrITEyXsNshPtbO3+v2Dk
         pImFJ1A0etPF0UJWJaConocr2c2ADpFOdseJE3/w/Tck8f8i9q9qKVMnFx9fn0BxybE6
         tLjQ==
X-Gm-Message-State: AOJu0YxLFZVlwPf9Ya+FTbjQhIT2L6qgX4N+LjXxfIeM6ELlm1syCRgP
        OaQrgzbwnuurtKFj4bmAptc=
X-Google-Smtp-Source: AGHT+IGO1cYq9ryCeUR18SdH4aYD4OVeMcVgDFSRF+fdG4TERHS/ZNVH28DIGQxUbVu84B1GJsMb2w==
X-Received: by 2002:a17:903:185:b0:1bc:2036:2219 with SMTP id z5-20020a170903018500b001bc20362219mr2795385plg.41.1691791868121;
        Fri, 11 Aug 2023 15:11:08 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090282c900b001bc53321392sm4413845plz.69.2023.08.11.15.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 15:11:07 -0700 (PDT)
Message-ID: <57558d7b-4444-b709-60bf-5a061cd6c3e9@acm.org>
Date:   Fri, 11 Aug 2023 15:11:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 04/11] block: add emulation for copy
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Vincent Fu <vincent.fu@samsung.com>, martin.petersen@oracle.com,
        linux-doc@vger.kernel.org, gost.dev@samsung.com,
        Anuj Gupta <anuj20.g@samsung.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, mcgrof@kernel.org, dlemoal@kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230811105300.15889-1-nj.shetty@samsung.com>
 <CGME20230811105713epcas5p3b5323a0c553006e60671dde6c72fc4c6@epcas5p3.samsung.com>
 <20230811105300.15889-5-nj.shetty@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-5-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/23 03:52, Nitesh Shetty wrote:
> +	schedule_work(&emulation_io->emulation_work);

schedule_work() uses system_wq. This won't work for all users since 
there are no latency guarantees for system_wq.

Thanks,

Bart.
