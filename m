Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B33B692C7F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Feb 2023 02:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjBKBWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 20:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKBWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 20:22:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4299D5BA4F;
        Fri, 10 Feb 2023 17:22:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1C8B61EAF;
        Sat, 11 Feb 2023 01:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454A3C433D2;
        Sat, 11 Feb 2023 01:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676078570;
        bh=AlDt6/OIjKlJZzh5y2XaxptgauXVea6y6IlTFCUct9Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=r446EfjAUATJI0QGeFojWvnLjk7LlSlaz4fuhzSQnM8T2VkUqMIybloZ4BXNLTFlf
         u+2Mjz+LTKLB0hW2XzA542MoWLP+TXCqsDqbPtutpCMyi4fx4//XDpcFa98XrFcRzs
         5FkyU5eYnM9yTq9a0dNFT1KP/8dUWIxggOc7/7MG1e2EcSzuqlZjXZ+fjkrCDh1FEZ
         ozwSluGn2ytWdOl1iMaJidDc6f+IuI5+PhT79LmOYvgWc4599TBXGT4o7lM8/Dd8pC
         AqWIRN5Njy+rMKirylbMyztDsscd6YyMuIn0zZsKJdUH4K3JapVPW/xGONGtVntTfB
         qVOwLv/aJYYog==
Message-ID: <910d9157-1168-a7b7-8a9b-56a93687170c@kernel.org>
Date:   Sat, 11 Feb 2023 09:22:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] proc: fix to check name length in proc_lookup_de()
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230131155559.35800-1-chao@kernel.org>
 <93c1e281-82a5-d7d0-04b1-67ac2cf3d0fa@kernel.org>
 <20230202154154.64a087a47bbf2210584b1734@linux-foundation.org>
 <Y9+fYuixrjGnkReH@p183>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y9+fYuixrjGnkReH@p183>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/2/5 20:21, Alexey Dobriyan wrote:
> Nothing! /proc lived without this check for 30 years:

Oh, I'm trying make error handling logic of proc's lookup() to be the
same as other generic filesystem, it looks you don't think it's worth or
necessary to do that, anyway, the change is not critial, let's ignore it,
thank you for reviewing this patch.

Thanks,

> 
> int proc_match(int len,const char * name,struct proc_dir_entry * de)
> {
>          register int same __asm__("ax");
> 
>          if (!de || !de->low_ino)
>                  return 0;
>          /* "" means "." ---> so paths like "/usr/lib//libc.a" work */
>          if (!len && (de->name[0]=='.') && (de->name[1]=='\0'))
>                  return 1;
>          if (de->namelen != len)
>                  return 0;
>          __asm__("cld\n\t"
>                  "repe ; cmpsb\n\t"
>                  "setz %%al"
>                  :"=a" (same)
>                  :"0" (0),"S" ((long) name),"D" ((long) de->name),"c" (len)
>                  :"cx","di","si");
>          return same;
> }

