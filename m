Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DAC4D9045
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 00:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbiCNXVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 19:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbiCNXVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:21:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B69F1EAF4;
        Mon, 14 Mar 2022 16:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DF9CB81091;
        Mon, 14 Mar 2022 23:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEEBC340F5;
        Mon, 14 Mar 2022 23:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647300010;
        bh=2FdC7SwihSVVrZs4phed7Lbrp21pfyud0aUkZsI1zA8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VsVC9uixp0hNsOks/Wwq8a2FmoTGO7S63O8uUrVNV/kh39qbr1toIhu88f3ZQ/XAG
         5LwAYgVXyVetXSgcBID/TjC/v0LE9wNGm9j5oWY0XeV7ppCaLn52ZfIMR0e+WXShZi
         5MqYKBoG9PxvlnARBX9tIIxVTQ7YgzlNQ/FJRNk5ZKQOzXv3DD8+yTKzWRWieGkej5
         pdn0xpOC0tsErjYtgD1vkKfpYDfL+p2dlCR56YSd+wcQiqT5hgKg+oJtELhoTWXC8r
         Ts3AhSxo9t+33I3R0RsFMHJOrVVrgS9fcc4Uu0YWp98+qHPhhW8JvC7EC6SHB1Po05
         zTjZnxUDss9wQ==
Received: by mail-wr1-f49.google.com with SMTP id b19so4056473wrh.11;
        Mon, 14 Mar 2022 16:20:10 -0700 (PDT)
X-Gm-Message-State: AOAM532qxoVKQ+RmdLklbC7dkbwpqZBDDkarLh+rCJn2rBpudcnfE0kB
        gDpXt6r5IWqHZ3jOcmIiqMRt4mzAnS1qz8TkfTs=
X-Google-Smtp-Source: ABdhPJzocQjOSkwRAEOVvX1B3TdY7Z8TMDh2BkXK/Ec8oBJKzlFUSGVDXfcqAVufgB2uvtwr0YwjSXN1FRddBPI9O8U=
X-Received: by 2002:a05:6000:1d8c:b0:1f1:d8e2:fcb1 with SMTP id
 bk12-20020a0560001d8c00b001f1d8e2fcb1mr18618922wrb.165.1647300009057; Mon, 14
 Mar 2022 16:20:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:1d93:0:0:0:0 with HTTP; Mon, 14 Mar 2022 16:20:08
 -0700 (PDT)
In-Reply-To: <TYAPR01MB5353A452BE48880A1D4778B5900C9@TYAPR01MB5353.jpnprd01.prod.outlook.com>
References: <HK2PR04MB3891D1D0AFAD9CA98B67706B810B9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <TYAPR01MB5353A452BE48880A1D4778B5900C9@TYAPR01MB5353.jpnprd01.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 15 Mar 2022 08:20:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9BO1LipYx1EtOK=Uo11dY3beBc_0mh_t=opWXPibutBQ@mail.gmail.com>
Message-ID: <CAKYAXd9BO1LipYx1EtOK=Uo11dY3beBc_0mh_t=opWXPibutBQ@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: do not clear VolumeDirty in writeback
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>,
        "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-03-11 13:34 GMT+09:00,
Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
<Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>:
> Hi, Yuezhang,Mo
>
> I think it's good.
> It will not be possible to clear dirty automatically, but I think device
> life and reliable integrity are more important.
>
>
>> -       if (sync)
>> -               sync_dirty_buffer(sbi->boot_bh);
>> +       sync_dirty_buffer(sbi->boot_bh);
>> +
>
> Use __sync_dirty_buffer() with REQ_FUA/REQ_PREFLUSH instead to guarantee a
> strict write order (including devices).
Yuezhang, It seems to make sense. Can you check this ?

Thanks!
>
> BR
> T .Kohada
