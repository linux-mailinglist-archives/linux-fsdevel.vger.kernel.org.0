Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7470A737ECD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 11:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjFUJRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFUJRm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:17:42 -0400
X-Greylist: delayed 137996 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jun 2023 02:17:39 PDT
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A85E10FE
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 02:17:39 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QmHw15pQqzMpnrZ;
        Wed, 21 Jun 2023 09:17:37 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4QmHw02Qj2zMsmSf;
        Wed, 21 Jun 2023 11:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1687339057;
        bh=veOtCaJt3Hey607zkXQSppG6fPPqafaKDZ9+dmpVLHM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OnZL2JgboFxsS3s56X5OTJb7RVNkFDh123KRefPFI56o6P0uqaz9h623kRadbz71u
         aF4YiSGnl34ufWWh5OMlhNoXXwaCgWTa17D+vEvpt4L5biWHoMEKltH5LYBi1DHn13
         vMqaXyi8Ri33FtKndtTdd1mnMJD3wyQ4Zw/vya2k=
Message-ID: <a4c973df-ed4d-960a-217c-3027e525e953@digikod.net>
Date:   Wed, 21 Jun 2023 11:17:35 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [RFC 0/4] Landlock: ioctl support
Content-Language: en-US
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Jeff Xu <jeffxu@google.com>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
 <1cb74c81-3c88-6569-5aff-154b8cf626fa@digikod.net>
 <20230510.c667268d844f@gnoack.org>
 <CALmYWFv4f=YsRFHvj4LTog4GY9NmfSOE6hZnJNOpCzPM-5G06g@mail.gmail.com>
 <a932bbb5-7b19-2299-0ca4-3fa13d63d817@digikod.net>
 <CABi2SkV79kPt+8vD=-9C2TDkVoNfkOxtaT2C470MWpV1EJvvpg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CABi2SkV79kPt+8vD=-9C2TDkVoNfkOxtaT2C470MWpV1EJvvpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 21/06/2023 01:44, Jeff Xu wrote:
> On Sat, Jun 17, 2023 at 2:49 AM Mickaël Salaün <mic@digikod.net> wrote:
>>
>>
>> On 24/05/2023 23:43, Jeff Xu wrote:
>>> Sorry for the late reply.
>>>>
>>>> (Looking in the direction of Jeff Xu, who has inquired about Landlock
>>>> for Chromium in the past -- do you happen to know in which ways you'd
>>>> want to restrict ioctls, if you have that need? :))
>>>>
>>>
>>> Regarding this patch, here is some feedback from ChromeOS:
>>>    - In the short term: we are looking to integrate Landlock into our
>>> sandboxer, so the ability to restrict to a specific device is huge.
>>> - Fundamentally though, in the effort of bringing process expected
>>> behaviour closest to allowed behaviour, the ability to speak of
>>> ioctl() path access in Landlock would be huge -- at least we can
>>> continue to enumerate in policy what processes are allowed to do, even
>>> if we still lack the ability to restrict individual ioctl commands for
>>> a specific device node.
>>
>> Thanks for the feedback!
>>
>>>
>>> Regarding medium term:
>>> My thoughts are, from software architecture point of view, it would be
>>> nice to think in planes: i.e. Data plane / Control plane/ Signaling
>>> Plane/Normal User Plane/Privileged User Plane. Let the application
>>> define its planes, and assign operations to them. Landlock provides
>>> data structure and syscall to construct the planes.
>>
>> I'm not sure to follow this plane thing. Could you give examples for
>> these planes applied to Landlock?
>>
> The idea is probably along the same lines as yours: let user space
> define/categorize ioctls.  For example, for a camera driver, users can
> define two planes - control plane: setup parameters of lens, data
> plane: setup data buffers for data transfer and do start/stop (I'm
> just making up the example since I don't really know the camera
> driver).
> 
> The idea is for Landlock to provide a mechanism to let user space to
> divide/assign ioctls to different planes, such that the user space
> processes can set/define security boundaries according to the plane it
> is on.

Right, we're on the same track. :)


> 
>>
>>>
>>> However, one thing I'm not sure is the third arg from ioctl:
>>> int ioctl(int fd, unsigned long request, ...);
>>> Is it possible for the driver to use the same request id, then put
>>> whatever into the third arg ? how to deal with that effectively ?
>>
>> I'm not sure about the value of all the arguments (except the command
>> one) vs. the complexity to filter them, but we could discuss that when
>> we'll reach this step.
>>
>>>
>>> For real world user cases, Dmitry Torokhov (added to list) can help.
>>
>> Yes please!
>>
> ya,  it will help with the design if there is a real world scenario to study.

I'll get internal requirements too.


> 
>>>
>>> PS: There is also lwn article about SELinux implementation of ioctl: [1]
>>> [1] https://lwn.net/Articles/428140/
>>
>> Thanks for the pointer, this shows how complex this IOCTL access control
>> is. For Landlock, I'd like to provide the minimal required features to
>> enable user space to define their own rules, which means to let user
>> space (and especially libraries) to identify useful or potentially
>> harmful IOCTLs.
>>
> Yes. That makes sense.
> 
>>>
>>> Thanks!
>>> -Jeff Xu
