Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB44D4FCD32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 05:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344575AbiDLDjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 23:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbiDLDjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:39:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BF0192B6;
        Mon, 11 Apr 2022 20:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CCB761739;
        Tue, 12 Apr 2022 03:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEA3C385AB;
        Tue, 12 Apr 2022 03:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649734657;
        bh=mrnyWd53bMjtQiofKd1ZScd6fhayzsp2b2W3MoHNM2E=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=LAYKihxMKJhnXPTa4WZrVPzXkSQ4ejSv+VLVFkiuj3Eru0PQl9kBMjevSg6xsM+v2
         FtanT70z7YqHF3wjZD00oCpQtZDHYtOcZZzel4991POxPZshKdW+/Gl3Vv6U9p7w+A
         x3cv+EsDTmxhKJHgIBW4whnYppweYwBgPee+KAFshc5xwEIddIQzx/nMuq7mjABnka
         I1h/p8jOE6qAE6LVEw7H0mLrryGlPwmVyaCfgEayjTvUsA8mJmMUYNQCVwBwN41g4P
         TnSo9iMnLfv34CbEfa2JedDh0Sw6294d4S61z4OKpgb+vbPQ+CZqtYqZv+XCDl610S
         vnXt1EdX21Rkw==
Received: by mail-wr1-f50.google.com with SMTP id u3so25820246wrg.3;
        Mon, 11 Apr 2022 20:37:36 -0700 (PDT)
X-Gm-Message-State: AOAM530iZkitFGGo7ijzTHdG4EzLOAHAjAf64jp6aUqjxeSIXGGwGvTv
        yVW8oUj6FnUqpwlTnd5vWetOZ3YwxRlPTuzIYL4=
X-Google-Smtp-Source: ABdhPJz0KUn6IlpgNB3uSlVMKzj8lqhrvusdBUInVzLjf0fRn0xOig95EqNNIf17wcv5AUFXeQYozDt9L7lvUt+1E9k=
X-Received: by 2002:a05:6000:1ca:b0:207:acc8:c153 with SMTP id
 t10-20020a05600001ca00b00207acc8c153mr1969999wrx.165.1649734655137; Mon, 11
 Apr 2022 20:37:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:2c1:0:0:0:0 with HTTP; Mon, 11 Apr 2022 20:37:34
 -0700 (PDT)
In-Reply-To: <01626f93-e982-8631-4196-112a8bb4a01a@kernel.dk>
References: <HK2PR04MB3891FCECADD7AECEEF5DD63081E99@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <Yk/DpSwR8kGKWJYl@infradead.org> <CAKYAXd9NAUjdxT2GOWGoPvH5nOXSFtD7u0t_9rCiZx7hSGC0PA@mail.gmail.com>
 <01626f93-e982-8631-4196-112a8bb4a01a@kernel.dk>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 12 Apr 2022 12:37:34 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9D85wpwFOzii2yMfA9jZuRC0Q5XZ89OAHZYdHw0pyqWg@mail.gmail.com>
Message-ID: <CAKYAXd9D85wpwFOzii2yMfA9jZuRC0Q5XZ89OAHZYdHw0pyqWg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] block: add sync_blockdev_range()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-04-12 10:12 GMT+09:00, Jens Axboe <axboe@kernel.dk>:
> On 4/10/22 8:08 PM, Namjae Jeon wrote:
>> 2022-04-08 14:09 GMT+09:00, Christoph Hellwig <hch@infradead.org>:
>>> Looks good:
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Thanks for your review!
>>
>> Hi Jens,
>>
>> Can I apply this patch with your Ack to exfat #dev ?
>
> Yes go ahead:
>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
Applied, Thanks for your review!

>
> --
> Jens Axboe
>
>
