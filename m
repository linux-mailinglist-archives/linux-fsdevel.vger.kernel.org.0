Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C997F4E398D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 08:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbiCVH2s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 03:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237400AbiCVH2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:28:46 -0400
X-Greylist: delayed 334 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Mar 2022 00:27:16 PDT
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA08049279;
        Tue, 22 Mar 2022 00:27:16 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id EB22C15F93A;
        Tue, 22 Mar 2022 16:21:41 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22M7LeWj076792
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 16:21:41 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22M7LeCa265007
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 16:21:40 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 22M7Lecr265006;
        Tue, 22 Mar 2022 16:21:40 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     qianfan <qianfanguijin@163.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: linux resetting when the usb storage was removed while copying
References: <1cc135e3-741f-e7d6-5d0a-fef319832a4c@163.com>
Date:   Tue, 22 Mar 2022 16:21:40 +0900
In-Reply-To: <1cc135e3-741f-e7d6-5d0a-fef319832a4c@163.com> (qianfan's message
        of "Mon, 21 Mar 2022 17:58:04 +0800")
Message-ID: <87pmmee9kr.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

qianfan <qianfanguijin@163.com> writes:

> Hi:
>
> I am tesing usb storage on linux v5.15, found that the system is resetting when the
> usb storage(fat32 format) was removed while copying. Besides my custom board
> has a gpio-watchdog with 1.6s timeout.

Looks like I/O error by unplugging usb while reading data pages for
readahead, then your watchdog detected some state to reset system.

If you disabled watchdog, it works as normal soon or later? If so, FAT
would not be able to do much (maybe ratelimit I/O error to mitigate
serial console overhead), request is from userspace or upper layer in
kernel.

Thanks.

> Next is the console(ttyS0, 115200) logs when usb disconnected:
>
> [   62.213788] usb 1-1: USB disconnect, device number 2
> [   62.221589] blk_update_request: I/O error, dev sda, sector 16447 op 0x1:(WRITE)
> flags 0x100000 phys_seg 1 prio class 0
> [   62.232990] Buffer I/O error on dev sda1, logical block 16385, lost async page
> write
> [   62.266159] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.271985] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.277828] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.283520] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.289219] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.294930] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.300595] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.306286] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.311964] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.317678] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.323376] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.329078] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.334773] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.340437] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.346139] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.351818] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.357506] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.363184] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.368872] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.374568] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.380233] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.385944] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.391623] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.397309] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.402987] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.408679] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.414384] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.420052] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.425746] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.431424] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.437120] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.442798] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.448501] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.454181] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.459869] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.465558] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.471224] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.476918] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.482598] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.488291] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.493970] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.499670] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.505362] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.511026] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.516715] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.522394] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.528084] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.533762] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.539448] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.545140] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.550804] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.556492] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.562170] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.567861] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.573541] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.579231] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.584923] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.590587] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.596277] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.601955] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.607653] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.613332] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.619018] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.624710] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.630393] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.636086] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.641763] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.647449] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.653127] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.658812] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.664503] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.670167] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.675857] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.681540] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.687227] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.692905] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.698590] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.704268] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.709953] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.715667] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.721333] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.727026] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.732709] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.738396] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.744074] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.749761] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.755451] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.761115] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.766806] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.772485] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.778172] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.783854] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.789540] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.795231] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.800896] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.806601] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.812281] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.817968] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.823646] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.829345] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.835043] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.840710] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.846400] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.852078] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.857766] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.863445] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.869130] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.874822] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.880487] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.886189] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.891869] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.897555] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.903234] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.908919] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.914610] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.920274] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.925963] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.931642] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.937344] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.943023] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.948710] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.954401] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.960065] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.965754] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.971431] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.977116] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.982797] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.988489] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.994168] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   62.999853] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.005541] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.011205] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.016895] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.022573] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.028258] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.033937] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.039635] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.045344] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.051009] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.056700] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.062378] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.068064] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.073742] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.079427] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.085121] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.090813] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.096505] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.102183] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.107869] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.113547] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.119243] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.124943] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.130607] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.136299] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.141982] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.147679] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.153358] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.159057] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.164749] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.170413] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.176112] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.181789] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.187477] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.193158] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.198851] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.204544] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.210208] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.215897] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.221575] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.227260] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.232937] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.238625] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.244325] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.249991] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.255681] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.261345] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.267047] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.272728] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.278415] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.284094] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.289787] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.295484] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.301149] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.306839] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.312516] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.318200] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.323877] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.329563] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.335253] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.340919] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.346612] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.352290] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.357975] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.363653] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.369338] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.375041] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.380706] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.386395] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.392074] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.397765] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.403444] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.409130] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.414820] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.420485] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.426173] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.431850] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.437535] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.443214] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.448911] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.454604] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.460268] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.465957] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.471635] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.477321] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.482998] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.488694] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.494388] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.500058] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.505748] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.511425] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.517110] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.522788] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.528474] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.534152] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.539836] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.545525] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.551194] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.556884] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.562562] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.568247] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.573925] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.579610] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.585301] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.590966] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.596667] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.602350] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.608037] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.613715] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.619400] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.625091] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.630755] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.636445] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.642122] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.647809] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.653491] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.659178] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.664868] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.670532] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.676229] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.681908] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.687594] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.693275] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.698961] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.704668] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.710333] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.716024] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.721701] FAT-fs (sda1): FAT read failed (blocknr 1162)
> [   63.727387▒
> U-Boot SPL 2022.01-rc1-00183-gfa5b4e2d19 (Feb 24 2022 - 15:48:38 +0800)
> Trying to boot from NAND
>
> I add a backtrace on function "fat_ent_bread", next is the stack:
>
> [   62.129550] usb 1-1: USB disconnect, device number 2
> [   62.137279] blk_update_request: I/O error, dev sda, sector 16447 op 0x1:(WRITE)
> flags 0x100000 phys_seg 1 prio class 0
> [   62.148725] Buffer I/O error on dev sda1, logical block 16385, lost async page
> write
> [   62.179800] ------------[ cut here ]------------
> [   62.184749] WARNING: CPU: 0 PID: 362 at fs/fat/fatent.c:110
> fat_ent_bread+0xec/0x104
> [   62.193072] fat_ent_bread
> [   62.193081] Modules linked in:
> [   62.199103] CPU: 0 PID: 362 Comm: gzip Not tainted
> 5.15.0-00013-g0ccd7df8f5ad-dirty #132
> [   62.207610] Hardware name: Generic AM33XX (Flattened Device Tree)
> [   62.214024] [<c0111438>] (unwind_backtrace) from [<c010b9f4>]
> (show_stack+0x10/0x14)
> [   62.222186] [<c010b9f4>] (show_stack) from [<c0adc214>]
> (dump_stack_lvl+0x40/0x4c)
> [   62.230165] [<c0adc214>] (dump_stack_lvl) from [<c0136264>]
> (__warn+0xf0/0x104)
> [   62.237858] [<c0136264>] (__warn) from [<c01362ec>]
> (warn_slowpath_fmt+0x74/0xbc)
> [   62.245722] [<c01362ec>] (warn_slowpath_fmt) from [<c042cdd0>]
> (fat_ent_bread+0xec/0x104)
> [   62.254321] [<c042cdd0>] (fat_ent_bread) from [<c042d4f8>]
> (fat_ent_read+0x1c8/0x258)
> [   62.262550] [<c042d4f8>] (fat_ent_read) from [<c0428b48>]
> (fat_get_cluster+0x214/0x394)
> [   62.270982] [<c0428b48>] (fat_get_cluster) from [<c0428d70>]
> (fat_get_mapped_cluster+0xa8/0x190)
> [   62.280221] [<c0428d70>] (fat_get_mapped_cluster) from [<c0431cf8>]
> (fat_get_block+0x60/0x310)
> [   62.289277] [<c0431cf8>] (fat_get_block) from [<c033622c>]
> (do_mpage_readpage+0x298/0x92c)
> [   62.297973] [<c033622c>] (do_mpage_readpage) from [<c0336960>]
> (mpage_readahead+0xa0/0x154)
> [   62.306751] [<c0336960>] (mpage_readahead) from [<c02725d4>]
> (read_pages+0x80/0x244)
> [   62.314878] [<c02725d4>] (read_pages) from [<c02728f0>]
> (page_cache_ra_unbounded+0x158/0x210)
> [   62.323818] [<c02728f0>] (page_cache_ra_unbounded) from [<c02628e4>]
> (filemap_readahead+0x64/0x8c)
> [   62.333222] [<c02628e4>] (filemap_readahead) from [<c0268024>]
> (filemap_read+0x55c/0x9f4)
> [   62.341802] [<c0268024>] (filemap_read) from [<c02e69d0>]
> (vfs_read+0x278/0x2f8)
> [   62.349573] [<c02e69d0>] (vfs_read) from [<c02e6f08>]
> (ksys_read+0xa8/0xd8)
> [   62.356878] [<c02e6f08>] (ksys_read) from [<c0100080>]
> (ret_fast_syscall+0x0/0x48)
> [   62.364818] Exception stack(0xc2b8dfa8 to 0xc2b8dff0)
> [   62.370116] dfa0:                   00000000 00000000 00000000 004f1144 00003ffc
> ffffffff
> [   62.378685] dfc0: 00000000 00000000 004f1144 00000003 004ee6bc 00000009
> 00000004 6232e5a0
> [   62.387252] dfe0: 00000000 be973b4c 0041ea7c b6ec2af8
> [   62.392732] ---[ end trace 28fb7741fb0db033 ]---
>
> I can't detect wether this problem is caused by fat(maybe fs) or usb.
>
> Thanks.
>

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
