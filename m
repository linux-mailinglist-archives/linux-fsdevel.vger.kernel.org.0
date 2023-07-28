Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCA376637C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 07:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjG1FFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 01:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjG1FFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:05:40 -0400
Received: from bagheera.iewc.co.za (bagheera.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB282D67;
        Thu, 27 Jul 2023 22:05:38 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by bagheera.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qPFf1-0005PS-Vn; Fri, 28 Jul 2023 07:05:08 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qPFf0-0005t6-R4; Fri, 28 Jul 2023 07:05:06 +0200
Message-ID: <c4d98da8-1931-4165-9212-c502c71d4bbd@uls.co.za>
Date:   Fri, 28 Jul 2023 07:05:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir [v2].
Content-Language: en-GB
To:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Antonio SJ Musumeci <trapexit@spawn.link>
References: <20230726105953.843-1-jaco@uls.co.za>
 <20230727081237.18217-1-jaco@uls.co.za>
 <CAJfpegvJ7FOS35yiKsTAzQh5Uf71FatU-kTJpXJtDPQbXeMgxA@mail.gmail.com>
 <d9ec13de-ebb2-af50-6026-408b49ff979b@fastmail.fm>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <d9ec13de-ebb2-af50-6026-408b49ff979b@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
>>>          plus = fuse_use_readdirplus(inode, ctx);
>>>          ap->args.out_pages = true;
>>> -       ap->num_pages = 1;
>>> +       ap->num_pages = READDIR_PAGES;
>>
>> No.  This is the array lenght, which is 1.  This is the hack I guess,
>> which makes the above trick work.
>
> Hmm, ap->num_pages / ap->pages[] is used in fuse_copy_pages, but so is 
> ap->descs[] - shouldn't the patch caused an out-of-bound access?
> Out of interest, would you mind to explain how the hack worked?

Apparently it shouldn't ... my understanding of how pages* worked was 
all wrong.

I'm guessing since all the data fits in the first page (ap->pages[0] in 
other words, of length/size desc.length) that the other pages are never 
accessed.  Looking at fuse_copy_pages this does indeed seem to be the 
case.  So I ended up just being really, really lucky here.

Kind regards,
Jaco

