Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544F54D7D80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 09:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbiCNIXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 04:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiCNIXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:23:22 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4893F331
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 01:22:12 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KH8f81BzkzMprsH;
        Mon, 14 Mar 2022 09:22:08 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KH8f4419JzlhSML;
        Mon, 14 Mar 2022 09:22:04 +0100 (CET)
Message-ID: <bdc3f565-9deb-504e-a904-639b9b2c7517@digikod.net>
Date:   Mon, 14 Mar 2022 09:22:33 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     John Johansen <john.johansen@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20220228215935.748017-1-mic@digikod.net>
 <20220301092232.wh7m3fxbe7hyxmcu@wittgenstein>
 <f6b63133-d555-a77c-0847-de15a9302283@digikod.net>
 <CAHC9VhQd3rL-13k0u39Krkdjp2_dtPfgEPxr=kawWUM9FjjOsw@mail.gmail.com>
 <8d520529-4d3e-4874-f359-0ead9207cead@canonical.com>
 <CAHC9VhRrjqe1AdZYtjpzLJyBF6FTeQ4EcEwsOd2YMimA5_tzEA@mail.gmail.com>
 <b848fe63-e86d-af38-5198-5519cb3c02ef@I-love.SAKURA.ne.jp>
 <CAHC9VhQqx7B+6Ji_92eMZ1o9O_yaDQQoPVw92Av0Zznv7i8F8w@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1] fs: Fix inconsistent f_mode
In-Reply-To: <CAHC9VhQqx7B+6Ji_92eMZ1o9O_yaDQQoPVw92Av0Zznv7i8F8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/03/2022 16:17, Paul Moore wrote:
> On Fri, Mar 11, 2022 at 8:35 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> On 2022/03/12 7:15, Paul Moore wrote:
>>> The silence on this has been deafening :/  No thoughts on fixing, or
>>> not fixing OPEN_FMODE(), Al?
>>
>> On 2022/03/01 19:15, Mickaël Salaün wrote:
>>>
>>> On 01/03/2022 10:22, Christian Brauner wrote:
>>>> That specific part seems a bit risky at first glance. Given that the
>>>> patch referenced is from 2009 this means we've been allowing O_WRONLY |
>>>> O_RDWR to succeed for almost 13 years now.
>>>
>>> Yeah, it's an old bug, but we should keep in mind that a file descriptor
>>> created with such flags cannot be used to read nor write. However,
>>> unfortunately, it can be used for things like ioctl, fstat, chdir… I
>>> don't know if there is any user of this trick.
>>
>> I got a reply from Al at https://lkml.kernel.org/r/20090212032821.GD28946@ZenIV.linux.org.uk
>> that sys_open(path, 3) is for ioctls only. And I'm using this trick when opening something
>> for ioctls only.
> 
> Thanks Tetsuo, that's helpful.  After reading your email I went
> digging around to see if this was documented anywhere, and buried in
> the open(2) manpage, towards the bottom under the "File access mode"
> header, is this paragraph:
> 
>   "Linux reserves the special, nonstandard access mode 3 (binary 11)
>    in flags to mean: check for read and write permission on the file
>    and return a file descriptor that can't be used for reading or
>    writing.  This nonstandard access mode is used by some Linux
>    drivers to return a file descriptor that is to be used only for
>    device-specific ioctl(2) operations."

Interesting, I missed the reference to this special value in the man page.

> 
> I learned something new today :)  With this in mind it looks like
> doing a SELinux file:ioctl check is the correct thing to do.

Indeed, SELinux uses it in an early ioctl check, but it still seems 
inconsistent (without being a bug) with the handling of the other value 
of this flag. This FD can also be used for chdir or other inode-related 
actions, which may not involve ioctl.

However, it seems there is a more visible inconsistency with the way 
Tomoyo checks for read, write (because of the ACC_MODE use) *and* ioctl 
rights for an ioctl action. At least, the semantic is not the same and 
is not reflected in the documentation.

Because AppArmor and Landlock don't support ioctl, this looks fine for them.
