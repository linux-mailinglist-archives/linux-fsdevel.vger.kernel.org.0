Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBCD5482C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 11:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbiFMJOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 05:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiFMJOr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:14:47 -0400
X-Greylist: delayed 343 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Jun 2022 02:14:46 PDT
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340D4186F4;
        Mon, 13 Jun 2022 02:14:46 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4LM5N73Srsz9sZR;
        Mon, 13 Jun 2022 11:08:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1655111335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/diBHTT7FJGtxv9Ix4yOBCZ8RnU/aeUMZMRq1jZWVd0=;
        b=Znxifht26gApX39S8dBdMlCkItNVWLXnXVPMEVWY3AG9zAT6gRrWMY9rhTZyANLJTCXA+T
        /Py+ybJGqRWT/5GkeLRhJZiWzDalGM3ZvZadEpQEYyYCU21C9ACURqw1LrNyUVHsOxWjvx
        1p9izA8OmzrQ5cxuRmCiyhEfNhVce3b+LqtSrMJHG1exvU+qFVCJb9AZGKmxkawe7s4w+F
        /Xrajo+QQRwLwU5ACiJOqV5anBx0ps2Y2wIrqp32YeXJCOeBwJm20EiuG6GVGM12Bl5Dy4
        ebLpFyJ47wP6J1/GG07XltI+NvUdJKpT2sZ8ndEXg24vYNlBTBRianCdqohCbA==
Message-ID: <51536e97-ca5f-abe4-b46c-ee3eb57f891e@mailbox.org>
Date:   Mon, 13 Jun 2022 11:08:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Content-Language: en-CA
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     andrey.grodzovsky@amd.com, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        hughd@google.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, daniel@ffwll.ch,
        linux-tegra@vger.kernel.org, alexander.deucher@amd.com,
        akpm@linux-foundation.org, linux-media@vger.kernel.org
References: <YqG67sox6L64E6wV@dhcp22.suse.cz>
 <77b99722-fc13-e5c5-c9be-7d4f3830859c@amd.com>
 <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
 <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
 <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
 <d4a19481-7a9f-19bf-c270-d89baa0970fc@amd.com>
 <YqIMmK18mb/+s5de@dhcp22.suse.cz>
 <3f7d3d96-0858-fb6d-07a3-4c18964f888e@gmail.com>
 <YqMuq/ZrV8loC3jE@dhcp22.suse.cz>
 <2e7e050e-04eb-0c0a-0675-d7f1c3ae7aed@amd.com>
 <YqNSSFQELx/LeEHR@dhcp22.suse.cz>
 <288528c3-411e-fb25-2f08-92d4bb9f1f13@gmail.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <288528c3-411e-fb25-2f08-92d4bb9f1f13@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 577iphbxb4bs3945taqe58kkqzbs8imi
X-MBO-RS-ID: 72e59480f2d70ddaf00
X-Rspamd-Queue-Id: 4LM5N73Srsz9sZR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-06-11 10:06, Christian König wrote:
> Am 10.06.22 um 16:16 schrieb Michal Hocko:
>> [...]
>>>> Just consider the above mentioned memcg driven model. It doesn't really
>>>> require to chase specific files and do some arbitrary math to share the
>>>> responsibility. It has a clear accounting and responsibility model.
>>> Ok, how does that work then?
>> The memory is accounted to whoever faults that memory in or to the
>> allocating context if that is a kernel memory (in most situations).
> 
> That's what I had in mind as well. Problem with this approach is that file descriptors are currently not informed that they are shared between processes.
> 
> So to make this work we would need something like attach/detach to process in struct file_operations.
> 
> And as I noted, this happens rather often. For example a game which renders 120 frames per second needs to transfer 120 buffers per second between client and X.

FWIW, in the steady state, the game will cycle between a small (generally 2-5) set of buffers. The game will not cause new buffers to be exported & imported for every frame.

In general, I'd expect dma-buf export & import to happen relatively rarely, e.g. when a window is opened or resized.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
