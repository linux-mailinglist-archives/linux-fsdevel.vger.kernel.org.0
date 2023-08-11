Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86D3779A65
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 00:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjHKWGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 18:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjHKWGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:06:11 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B572D57;
        Fri, 11 Aug 2023 15:06:11 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bc7b25c699so17952905ad.1;
        Fri, 11 Aug 2023 15:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691791571; x=1692396371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCulArU7T/2N0cjtt9v/Sb6kpK5zL9r3ISOsLR/eGqQ=;
        b=J/C1ZReKG1KJpEsoHjyOdEU0WWkxb8/jDnHYSmqBLqtBaIpfXuwmMyzm/Jf7to5SNt
         CGXU+uHXe7bdMz/N7lCbQ7sJryMvcWkgYcsao1pSD0i/ufFfe8tSTHAu2xVk2g8UapHR
         tKFH/omV5AMTsBkpopJ7DRThdkPGZkz7257eTBP0OSSV6tna8F+9+kK+22VF3NV/ThIz
         2cNflgc9PVkOgi2r+pqZYEwx8shcTxtebWvp64/Fbdb+VfFoGBl+Z+MSzDL6rRASSHF4
         NBLpR7HqfDNf13KJltHo+4jdyQEk/kVnJLxk9shqvrtgNZpBhquc/7l1LQU/2JLWu6cv
         vxzw==
X-Gm-Message-State: AOJu0Yyb+GNJ9osNBQuFhLNfBg6m9FI5Fuw4ueY89oNlfh9D5jk3gVFT
        xoZZl08VlmvH+olOK7upnvE=
X-Google-Smtp-Source: AGHT+IGRDCvq8p2vjG6TVx2gDv6+cL2iFQ4Ue2nk9VRR38rhHkVlR+1xjT53rq6hRwjwXypPBI3lmA==
X-Received: by 2002:a17:903:244d:b0:1b8:5ab2:49a4 with SMTP id l13-20020a170903244d00b001b85ab249a4mr3374277pls.53.1691791571131;
        Fri, 11 Aug 2023 15:06:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b001a183ade911sm4424160plh.56.2023.08.11.15.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 15:06:10 -0700 (PDT)
Message-ID: <2e263977-0ee7-ae78-5a8a-2a67df43df76@acm.org>
Date:   Fri, 11 Aug 2023 15:06:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 03/11] block: add copy offload support
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
Cc:     martin.petersen@oracle.com, linux-doc@vger.kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, mcgrof@kernel.org, dlemoal@kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230811105300.15889-1-nj.shetty@samsung.com>
 <CGME20230811105659epcas5p1982eeaeb580c4cb9b23a29270945be08@epcas5p1.samsung.com>
 <20230811105300.15889-4-nj.shetty@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-4-nj.shetty@samsung.com>
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
> +		if (rem != chunk)
> +			atomic_inc(&cio->refcount);

This code will be easier to read if the above if-test is left out
and if the following code is added below the for-loop:

	if (atomic_dec_and_test(&cio->refcount))
		blkdev_copy_endio(cio);

Thanks,

Bart.
