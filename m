Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA1C73BCB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjFWQhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 12:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjFWQho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:37:44 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC8F2942
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 09:37:30 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QnjZc06rrzMq32R;
        Fri, 23 Jun 2023 16:37:28 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4QnjZZ1wx8zMpnPl;
        Fri, 23 Jun 2023 18:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1687538247;
        bh=NUnmcWSTTZt7eIqedPc0vDhEW1R152+j3rJCyoMrDTo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oGcrsAqZWWOJ+U00oFpn+r2lwbUpMB2vFtlwJyvMivLpdsFoNT4lQKpLdnbd+flfC
         0tr4XiZWSIT0QU0AIRFRS0x2oS/cl3FFznrXu/Issul/L+yEZvVr3x/3rsPiuzSG8H
         n8weT2YgmrClL/EwirWVq+g4Fc+nQVHyeledpolo=
Message-ID: <77ec6e6c-7fb0-01ab-26c5-e9c9da392e2a@digikod.net>
Date:   Fri, 23 Jun 2023 18:37:25 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2 0/6] Landlock: ioctl support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>,
        linux-security-module@vger.kernel.org
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-hardening@vger.kernel.org
References: <20230623144329.136541-1-gnoack@google.com>
 <ZJW4O+HVymf4nB6A@google.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <ZJW4O+HVymf4nB6A@google.com>
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

Hi, thanks for the patches!


On 23/06/2023 17:20, Günther Noack wrote:
> Hello!
> 
> On Fri, Jun 23, 2023 at 04:43:23PM +0200, Günther Noack wrote:
>> Proposed approach
>> ~~~~~~~~~~~~~~~~~
>>
>> Introduce the LANDLOCK_ACCESS_FS_IOCTL right, which restricts the use
>> of ioctl(2) on file descriptors.
>>
>> We attach the LANDLOCK_ACCESS_FS_IOCTL right to opened file
>> descriptors, as we already do for LANDLOCK_ACCESS_FS_TRUNCATE.
>>
>> I believe that this approach works for the majority of use cases, and
>> offers a good trade-off between Landlock API and implementation
>> complexity and flexibility when the feature is used.
>>
>> Current limitations
>> ~~~~~~~~~~~~~~~~~~~
>>
>> With this patch set, ioctl(2) requests can *not* be filtered based on
>> file type, device number (dev_t) or on the ioctl(2) request number.
>>
>> On the initial RFC patch set [1], we have reached consensus to start
>> with this simpler coarse-grained approach, and build additional ioctl
>> restriction capabilities on top in subsequent steps.
> 
> We *could* use this opportunity to blanket disable the TIOCSTI ioctl, if a
> Landlock policy gets enabled and ioctls are handled.
> 
> TIOCSTI is a TTY ioctl which is commonly used as a sandbox escape, if the
> sandboxes system can get a hold on a TTY file descriptor from outside the
> sandbox (like STDOUT, hah).
> 
> An excellent summary of these problems was already written by Kees Cook on the
> Linux patch which removes TIOCSTI depending on a kernel config option:
> https://lore.kernel.org/lkml/20221022182828.give.717-kees@kernel.org/
> 
> Unfortunately on the distributions I have tested so far (Debian and Arch Linux),
> TIOCSTI is still enabled.
> 
> ***Proposal***:
> 
>    I am in favor of *disabling* TIOCSTI in all Landlocked processes,
>    if the Landlock policy handles the LANDLOCK_ACCESS_FS_IOCTL right.
> 
> If we want to do it in a backwards-compatible way, now would be the time to add
> it to the patch set. :)

What would that not be backward compatible?

> 
> As far as I can tell, there are no good legitimate use cases for TIOCSTI, and it
> would fix the aforementioned sandbox escaping trick for a Landlocked process.
> With the patch set as it is now, the only way to prevent that sandbox escape is
> unfortunately to either (1) close the TTY file descriptors when enabling
> Landlock, or (2) rely on an outside process to pass something else than a TTY
> for FDs 0, 1 and 2.

What about calling setsid()?

Alternatively, seccomp could be used, even if it could block overlapping 
IOCTLs as well…


> 
> Does that sound reasonable?  If yes, I'd send an update to this patch set which
> forbids TIOCSTI.

I agree that TIOCSTI is dangerous, but I don't see the rationale to add 
an exception for this specific IOCTL. I'm sure there are a lot of 
potentially dangerous IOCTLs out there, but from a kernel point of view, 
why should Landlock handle this one in a specific way?

Landlock should not define specific policies itself but let users manage 
that. Landlock should only restrict kernel features that *directly* 
enable to bypass its own restrictions (e.g. ptrace scope, FS topology 
changes when FS restrictions are in place).

I think we should instead focus on adding something like a 
landlock_inode_attr rule type to restrict IOCTLs defined by 
users/developers, and then extend it to make it possible to restrict 
already opened FDs as well.

> 
> Thanks,
> —Günther
> 
