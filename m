Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473AE4D3E3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 01:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbiCJAhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 19:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiCJAhc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:37:32 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269B61052A2;
        Wed,  9 Mar 2022 16:36:32 -0800 (PST)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0F6043F12B;
        Thu, 10 Mar 2022 00:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646872582;
        bh=aGcEVKAOrTGJDxPnhMFB8dBVhKHNAxc+BYirL6/tWsM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=BYcRRKMHEhVvCIE5GQndE0fWH8AB88n1S+NB+OFT5mhAdCfel9WaZnM7MMLoMwdJQ
         B2oh8wyzyiPADr5/tlD9kTKjsC+csb1cGCRZGjsAMms3Hx0NsCb9M+b0Mr2o0rMP1Y
         Zay8WaezyhcUvaucSu1O5f0KOzdBDM4lUG7wyEJfOmAi/n6j+lCUGSCNjzy8MMmu/9
         SIfbic208WqVNTTRroZTJWwC4ZhfR6ZxY7RqdjIq/h6hqENjBzNTi5ttL2W4R7uNtV
         jSNaMsl9THVP1b6TK8KjBKMVLKrSbxV3OYaQ92a6MyWXj7zV1ctF8K2s4EhOObdF7C
         XrboieAjFlQRw==
Message-ID: <8d520529-4d3e-4874-f359-0ead9207cead@canonical.com>
Date:   Wed, 9 Mar 2022 16:36:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1] fs: Fix inconsistent f_mode
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Steve French <sfrench@samba.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20220228215935.748017-1-mic@digikod.net>
 <20220301092232.wh7m3fxbe7hyxmcu@wittgenstein>
 <f6b63133-d555-a77c-0847-de15a9302283@digikod.net>
 <CAHC9VhQd3rL-13k0u39Krkdjp2_dtPfgEPxr=kawWUM9FjjOsw@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CAHC9VhQd3rL-13k0u39Krkdjp2_dtPfgEPxr=kawWUM9FjjOsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/9/22 13:31, Paul Moore wrote:
> On Tue, Mar 1, 2022 at 5:15 AM Mickaël Salaün <mic@digikod.net> wrote:
>> On 01/03/2022 10:22, Christian Brauner wrote:
>>> On Mon, Feb 28, 2022 at 10:59:35PM +0100, Mickaël Salaün wrote:
>>>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>>>
>>>> While transitionning to ACC_MODE() with commit 5300990c0370 ("Sanitize
>>>> f_flags helpers") and then fixing it with commit 6d125529c6cb ("Fix
>>>> ACC_MODE() for real"), we lost an open flags consistency check.  Opening
>>>> a file with O_WRONLY | O_RDWR leads to an f_flags containing MAY_READ |
>>>> MAY_WRITE (thanks to the ACC_MODE() helper) and an empty f_mode.
>>>> Indeed, the OPEN_FMODE() helper transforms 3 (an incorrect value) to 0.
>>>>
>>>> Fortunately, vfs_read() and vfs_write() both check for FMODE_READ, or
>>>> respectively FMODE_WRITE, and return an EBADF error if it is absent.
>>>> Before commit 5300990c0370 ("Sanitize f_flags helpers"), opening a file
>>>> with O_WRONLY | O_RDWR returned an EINVAL error.  Let's restore this safe
>>>> behavior.
>>>
>>> That specific part seems a bit risky at first glance. Given that the
>>> patch referenced is from 2009 this means we've been allowing O_WRONLY |
>>> O_RDWR to succeed for almost 13 years now.
>>
>> Yeah, it's an old bug, but we should keep in mind that a file descriptor
>> created with such flags cannot be used to read nor write. However,
>> unfortunately, it can be used for things like ioctl, fstat, chdir… I
>> don't know if there is any user of this trick.
>>
>> Either way, there is an inconsistency between those using ACC_MODE() and
>> those using OPEN_FMODE(). If we decide to take a side for the behavior
>> of one or the other, without denying to create such FD, it could also
>> break security policies. We have to choose what to potentially break…
> 
> I'm not really liking the idea that the empty/0 f_mode field leads to
> SELinux doing an ioctl access check as opposed to the expected
> read|write check.  Yes, other parts of the code catch the problem, but
> this is bad from a SELinux perspective.  Looking quickly at the other
> LSMs, it would appear that other LSMs are affected as well.
> 
> If we're not going to fix file::f_mode, the LSMs probably need to
> consider using file::f_flags directly in conjunction with a correct
> OPEN_FMODE() macro (or better yet a small inline function that isn't
> as ugly).
> 
yeah, I have to agree

