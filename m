Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32C07B86A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 19:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbjJDReV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 13:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjJDReU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:34:20 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA171A6;
        Wed,  4 Oct 2023 10:34:16 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c63164a2b6so9710405ad.0;
        Wed, 04 Oct 2023 10:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440856; x=1697045656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+/9fMvIMylBk0tUbkGNvHwmLNtY7jK7qI7VPa1SYvo=;
        b=kO0PWT5No7NlODxM63GhW7VUuyO89xEdHizAXlK+4KHh880crBurt3wcMndUKeqRTg
         cwFuIZum5VQ11J9iIRMGoyE7VBadrFVYbGHI5HFJ5jRwjg/1PSjuFVitxe6osjG424ES
         O1wo3WRSAr+hs0BGeakrA9EG/MOGp130rEEE7eraLidDqKBVK9PdZVBUlAPffJdtbwz3
         r8W1MvCZ/XEZSdtBpRftKhaV7eMuW+IljlUYu4YWTuy+osXc1QhEuDD7Tvex9VoT6Tb/
         yQj8TQlNY0w4eorwcS52ln4z57slUSuCM9yLZPKaaTUlMZCZrtBn515PscBtOgT2/ygR
         etvQ==
X-Gm-Message-State: AOJu0YxPlAE8R6YCYS2Nczjmk9A+QQz3ns7qdgRqyhu+NbRBnyrrljz7
        r4PAv4lK056Xh8yhOi1shRQ=
X-Google-Smtp-Source: AGHT+IG8R+DlyiiEVWC+68KptejH+cGLh+ypDyuFaNYiG/lvbHPG9T3lVvSCSBbHEXdRAJ132q1v4Q==
X-Received: by 2002:a17:902:d4c4:b0:1c5:e207:836e with SMTP id o4-20020a170902d4c400b001c5e207836emr444422plg.26.1696440856149;
        Wed, 04 Oct 2023 10:34:16 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:969d:167a:787c:a6c7? ([2620:15c:211:201:969d:167a:787c:a6c7])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b001bbb25dd3a7sm3978166plr.187.2023.10.04.10.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 10:34:15 -0700 (PDT)
Message-ID: <e6c7b33c-38ba-402b-abdc-b783d4402402@acm.org>
Date:   Wed, 4 Oct 2023 10:34:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <1adeff8e-e2fe-7dc3-283e-4979f9bd6adc@oracle.com>
 <8e2f4aeb-e00e-453a-9658-b1c4ae352084@acm.org>
 <d981dea1-9851-6511-d101-22ea8d7fd31e@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d981dea1-9851-6511-d101-22ea8d7fd31e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/23 02:14, John Garry wrote:
> On 03/10/2023 17:45, Bart Van Assche wrote:
>> On 10/3/23 01:37, John Garry wrote:
>>> I don't think that is_power_of_2(write length) is specific to XFS.
>>
>> I think this is specific to XFS. Can you show me the F2FS code that 
>> restricts the length of an atomic write to a power of two? I haven't 
>> found it. The only power-of-two check that I found in F2FS is the 
>> following (maybe I overlooked something):
>>
>> $ git grep -nH is_power fs/f2fs
>> fs/f2fs/super.c:3914:    if (!is_power_of_2(zone_sectors)) {
> 
> Any usecases which we know of requires a power-of-2 block size.
> 
> Do you know of a requirement for other sizes? Or are you concerned that 
> it is unnecessarily restrictive?
> 
> We have to deal with HW features like atomic write boundary and FS 
> restrictions like extent and stripe alignment transparent, which are 
> almost always powers-of-2, so naturally we would want to work with 
> powers-of-2 for atomic write sizes.
> 
> The power-of-2 stuff could be dropped if that is what people want. 
> However we still want to provide a set of rules to the user to make 
> those HW and FS features mentioned transparent to the user.

Hi John,

My concern is that the power-of-2 requirements are only needed for
traditional filesystems and not for log-structured filesystems (BTRFS,
F2FS, BCACHEFS).

What I'd like to see is that each filesystem declares its atomic write
requirements (in struct address_space_operations?) and that
blkdev_atomic_write_valid() checks the filesystem-specific atomic write
requirements.

Thanks,

Bart.
