Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE9D6612D7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 02:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjAHBHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Jan 2023 20:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHBHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Jan 2023 20:07:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC93178A2;
        Sat,  7 Jan 2023 17:07:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E1FDFCE0AD6;
        Sun,  8 Jan 2023 01:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDD0C433F2;
        Sun,  8 Jan 2023 01:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673140036;
        bh=ZkYtiO+cjCxfI2x+S8MawGe99yJlO2wRVT7BtCshZhI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=QR/hDkXrHqMjb887VzsmZkC5HXmYDiJH61HY27g2F8+8JZOEi7tnJ88Lu7ykEqDN/
         lTFixhrsdIvpqBAMnj5q7QlSmMuCgyCfjlwOIp3erp8kit4Ge5oJfSL1O/3w6shS9Q
         RIxR8zAqfU0PIAlZO+jEOWQh8CHmoueQdyR8njBbG2qgF3Nfr+bBq0eWAiRv9TVRlt
         Qds+eFe1Q+8v/3hIjDfmBoi9KV7ap8DxzSPtRNIdCVfVt9vd+Y1SCdVPFVHLkie29o
         XfhYULqQBWx53R5Z79/b0ls9s+o+x2jD9uMBWmA5SoEFcYk0fEBti8d9qgL2sHWUW1
         ZCbpZkTf7PnJA==
Received: by mail-il1-f173.google.com with SMTP id y2so3216079ily.5;
        Sat, 07 Jan 2023 17:07:16 -0800 (PST)
X-Gm-Message-State: AFqh2kr3GOXvBNR7Ag7Jpep9sp73YxFvNmU0jZuh09juMCej3qLAKLca
        LuiR1Eu9aUeR3xIG+PP69Vl0jNyuvH+DK/9ssFU=
X-Google-Smtp-Source: AMrXdXuaYPvCX2tgFD1JXp1WPtaEgEg26ss896Cna6PFMu63pWnS+5uFHOv2NcKYP2JpjxLxycMBo0D/WsjAfY7O04g=
X-Received: by 2002:a05:6e02:1112:b0:30c:4660:b6bc with SMTP id
 u18-20020a056e02111200b0030c4660b6bcmr2688541ilk.280.1673140035322; Sat, 07
 Jan 2023 17:07:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:4f0a:0:b0:2a7:1320:aa34 with HTTP; Sat, 7 Jan 2023
 17:07:13 -0800 (PST)
In-Reply-To: <PUZPR04MB6316CA04EFB01F79FD026F9181FB9@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316CA04EFB01F79FD026F9181FB9@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 8 Jan 2023 10:07:13 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8U+EfUMt4D+rQ64JuposBx0OrUABKrrfenenS6xd9H7A@mail.gmail.com>
Message-ID: <CAKYAXd8U+EfUMt4D+rQ64JuposBx0OrUABKrrfenenS6xd9H7A@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: fix inode->i_blocks for non-512 byte sector
 size device
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-01-06 14:45 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> inode->i_blocks is not real number of blocks, but 512 byte ones.
>
> Fixes: 98d917047e8b ("exfat: add file operations")
> Fixes: 5f2aa075070c ("exfat: add inode operations")
> Fixes: 719c1e182916 ("exfat: add super block operations")
>
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Applied, Thanks!
