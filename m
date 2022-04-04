Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBCE4F1B3B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379551AbiDDVTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380576AbiDDUbw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:31:52 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD899377FA
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 13:29:54 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KXMp90prXzMptVt;
        Mon,  4 Apr 2022 22:29:53 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KXMp602llzlhRVP;
        Mon,  4 Apr 2022 22:29:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1649104193;
        bh=0mFVDtUYoFc9pSC5qUi5cW5G1Ntu51smq5L10oK+2/A=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=TaTRgRi8PJBAchvq1Ix+2vhlaVk/a4nJDrvNu0UPE+g7kY8z4w69RVDtrYUQI4sW7
         NyeXa0fQWVDYnVQ3YGjrnXS4Dxsj1EG0+q4+bKAuR0xQzy0D8Rj6shj3puUOuxqZU6
         n9x7Sib0gN6Nsv1/R7bd7gTDuaRn/pnmNcgBseS8=
Message-ID: <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net>
Date:   Mon, 4 Apr 2022 22:30:13 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
References: <20220321161557.495388-1-mic@digikod.net>
 <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
In-Reply-To: <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 04/04/2022 20:47, Linus Torvalds wrote:
> On Mon, Apr 4, 2022 at 11:40 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> It looks like this didn't get pulled for -rc1 even though it was sent
>> during the merge window and has been in -next for a while. It would be
>> really nice to get this landed since userspace can't make any forward
>> progress without the kernel support.
> 
> Honestly, I need a *lot* better reasoning for random new non-standard
> system calls than this had.
> 
> And this kind of "completely random interface with no semantics except
> for random 'future flags'" I will not pull even *with* good reasoning.

I think the semantic is well defined:
"This new syscall enables user space to ask the kernel: is this file
descriptor's content trusted to be used for this purpose?"
See the trusted_for_policy sysctl documentation: 
https://lore.kernel.org/all/20220104155024.48023-3-mic@digikod.net/

There is currently only one defined and implemented purpose: execution 
(or script interpretation). There is room for other flags because it is 
a good practice to do so, and other purposes were proposed.


> 
> I already told Mickaël in private that I wouldn't pull this.
> 
> Honestly, we have a *horrible* history with non-standard system calls,
> and that's been true even for well-designed stuff that actually
> matters, that people asked for.
> 
> Something  like this, which adds one very special system call and
> where the whole thing is designed for "let's add something random
> later because we don't even know what we want" is right out.
> 
> What the system call seems to actually *want* is basically a new flag
> to access() (and faccessat()). One that is very close to what X_OK
> already is.

I agree.


> 
> But that wasn't how it was sold.
> 
> So no. No way will this ever get merged, and whoever came up with that
> disgusting "trusted_for()" (for WHAT? WHO TRUSTS? WHY?) should look
> themselves in the mirror.

Well, naming is difficult, but I'm open to suggestion. :)

As explained in the description, the WHAT is the file descriptor 
content, the WHO TRUSTS is the system security policy (e.g. the mount 
point options) and the WHY is defined by the usage flag 
(TRUSTED_FOR_EXECUTION).
This translates to: is this file descriptor's content trusted to be used 
for this specified purpose/usage?


> 
> If you add a new X_OK variant to access(), maybe that could fly.

As answered in private, that was the approach I took for one of the 
early versions but a dedicated syscall was requested by Al Viro: 
https://lore.kernel.org/r/2ed377c4-3500-3ddc-7181-a5bc114ddf94@digikod.net
The main reason behind this request was that it doesn't have the exact 
same semantic as faccessat(2). The changes for this syscall are 
documented here: 
https://lore.kernel.org/all/20220104155024.48023-3-mic@digikod.net/
The whole history is linked in the cover letter: 
https://lore.kernel.org/all/2ed377c4-3500-3ddc-7181-a5bc114ddf94@digikod.net/

This initial proposal was using a new faccessat2(2) flag: 
AT_INTERPRETED, see 
https://lore.kernel.org/all/20200908075956.1069018-2-mic@digikod.net/
What do you think about that? I'm happy to get back to this version if 
everyone is OK with it.
