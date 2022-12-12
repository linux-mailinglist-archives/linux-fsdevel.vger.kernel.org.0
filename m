Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91B86497D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 03:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiLLCGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 21:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiLLCGf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:06:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C08C62E7
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 18:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670810736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KcoXdId9+WwBuH+gRgk9EJjde2pyS057yq6y4/z/asQ=;
        b=hYDz3OukLGInIplppDvcsfYQKPqMXF8OGJAAiRGatxGNo4kyNk9MURIP1KqNmC7bbKsqfh
        D3HJ57YnS8Aqn5VDvl7bONUnMTvBlKY6dacli+WKSUCUJ8CZ/D7mwfLHvN6wMjgd/s3COD
        PyYTfyvzlSNx6TuIXh6Y2LIs6jQyd9w=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209-xkOOE-nYPZ6J3ITAdPaC8w-1; Sun, 11 Dec 2022 21:05:33 -0500
X-MC-Unique: xkOOE-nYPZ6J3ITAdPaC8w-1
Received: by mail-pf1-f200.google.com with SMTP id e6-20020aa78c46000000b005772151d489so7203897pfd.15
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 18:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcoXdId9+WwBuH+gRgk9EJjde2pyS057yq6y4/z/asQ=;
        b=DlFd0EenKye5dpZIAybgtROimXqCuP4h7ogKzh8BoiQz1ukTOE4X4ep8BqClT5Bzbd
         KpoWdFgH6xln0RN7jy15iVwluW0/5qA8TM1iooinyckjfkk1bCyWITfonQXp55e9iKlG
         hRLnuo7nkalDD2odaKMA/Souv9UpTm53xKOzbnjpRsIV3Dqq+tb78PrbO/6R2RQIqR3I
         dPlXej5A4Mwz0bHZznF/Cjt7DQuleeeLj/AGJXbALViyreelAjpbhMOARFgd6cfDMdS9
         t49ZQrsFh/HumsDX4vI597kKInoNEnextbCuqPmpUpOZQm9RznBjjEQKWaAnZNC8+cvH
         Wlug==
X-Gm-Message-State: ANoB5pnbpvrJqoVbXDVyinQhESNnoIkE8UBhPa1MDWTzXrBwLgRC/VME
        a1keXcg5s9yVX9WjIWaS5DYxJpN1hNEv+spjk16aXEmlY9q9pc5K3O7X0ZcVFDz4SFIHm+x9jC0
        mlVQwH70JJXH9DEZRGgHHEq3VIQ==
X-Received: by 2002:a05:6a20:8c10:b0:a4:f2e7:3ddb with SMTP id j16-20020a056a208c1000b000a4f2e73ddbmr17958909pzh.36.1670810732466;
        Sun, 11 Dec 2022 18:05:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7aCLSEyoJ7BBMHiT3mCrX87K6sPK5IjIUx454Tyd3aJ4b2HlJT4e0NaY+fcVHMckzeWZrVJA==
X-Received: by 2002:a05:6a20:8c10:b0:a4:f2e7:3ddb with SMTP id j16-20020a056a208c1000b000a4f2e73ddbmr17958891pzh.36.1670810732163;
        Sun, 11 Dec 2022 18:05:32 -0800 (PST)
Received: from ?IPV6:2403:580e:4b40:0:7968:2232:4db8:a45e? (2403-580e-4b40--7968-2232-4db8-a45e.ip6.aussiebb.net. [2403:580e:4b40:0:7968:2232:4db8:a45e])
        by smtp.gmail.com with ESMTPSA id o24-20020aa79798000000b005745eb7eccasm4537805pfp.112.2022.12.11.18.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 18:05:31 -0800 (PST)
Message-ID: <2d8ac4c9-abeb-6a36-6c96-b14a5a0a2a31@redhat.com>
Date:   Mon, 12 Dec 2022 10:05:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 0/5] proc: improve root readdir latency with many
 threads
Content-Language: en-US
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Cc:     onestero@redhat.com, ebiederm@redhat.com,
        Brian Foster <bfoster@redhat.com>
References: <20221202171620.509140-1-bfoster@redhat.com>
From:   Ian Kent <ikent@redhat.com>
In-Reply-To: <20221202171620.509140-1-bfoster@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/12/22 01:16, Brian Foster wrote:
> Hi all,
>
> Here's v3 of the /proc readdir optimization patches. See v1 for the full
> introductary cover letter.
>
> Most of the feedback received to this point has been around switching
> the pid code over to use the xarray api instead of the idr. Matt Wilcox
> posted most of the code to do that. I cleaned it up a bit and posted a
> standalone series for that here [1], but didn't receive any feedback.
> Patches 1-3 of this series are essentially a repost of [1].
>
> Patches 4-5 are otherwise mostly the same as v2 outside of switching
> over to use the xarray bits instead of the idr/radix-tree.
>
> Thoughts, reviews, flames appreciated.


It looks like there's not much happens with this change so far.


Mathew, could we at least include this in linux-next, to see if

there is anything obvious to worry about since we are fiddling

with the pid numbering ... is there anything we need to do

differently for these to be included in next?


Ian

>
> Brian
>
> [1] https://lore.kernel.org/linux-mm/20220715113349.831370-1-bfoster@redhat.com/
>
> v3:
> - Drop radix-tree fixups.
> - Convert pid idr usage to xarray.
> - Replace tgid radix-tree tag set/lookup to use xarray mark.
> v2: https://lore.kernel.org/linux-fsdevel/20220711135237.173667-1-bfoster@redhat.com/
> - Clean up idr helpers to be more generic.
> - Use ->idr_base properly.
> - Lift tgid iteration helper into pid.c to abstract tag logic from
>    users.
> v1: https://lore.kernel.org/linux-fsdevel/20220614180949.102914-1-bfoster@redhat.com/
>
> Brian Foster (5):
>    pid: replace pidmap_lock with xarray lock
>    pid: split cyclic id allocation cursor from idr
>    pid: switch pid_namespace from idr to xarray
>    pid: mark pids associated with group leader tasks
>    procfs: use efficient tgid pid search on root readdir
>
>   arch/powerpc/platforms/cell/spufs/sched.c |   2 +-
>   fs/proc/base.c                            |  17 +--
>   fs/proc/loadavg.c                         |   2 +-
>   include/linux/pid.h                       |   3 +-
>   include/linux/pid_namespace.h             |   9 +-
>   include/linux/threads.h                   |   2 +-
>   init/main.c                               |   3 +-
>   kernel/fork.c                             |   2 +-
>   kernel/pid.c                              | 177 +++++++++++++---------
>   kernel/pid_namespace.c                    |  23 ++-
>   10 files changed, 132 insertions(+), 108 deletions(-)
>

