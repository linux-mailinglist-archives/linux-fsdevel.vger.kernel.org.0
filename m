Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311EC4D6BAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 02:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiCLBhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 20:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCLBhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 20:37:15 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215E974633;
        Fri, 11 Mar 2022 17:36:10 -0800 (PST)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22C1YYxk016513;
        Sat, 12 Mar 2022 10:34:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sat, 12 Mar 2022 10:34:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22C1YTKo016496
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 12 Mar 2022 10:34:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b848fe63-e86d-af38-5198-5519cb3c02ef@I-love.SAKURA.ne.jp>
Date:   Sat, 12 Mar 2022 10:34:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] fs: Fix inconsistent f_mode
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?Q?n?= <mic@digikod.net>,
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhRrjqe1AdZYtjpzLJyBF6FTeQ4EcEwsOd2YMimA5_tzEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/03/12 7:15, Paul Moore wrote:
> The silence on this has been deafening :/  No thoughts on fixing, or
> not fixing OPEN_FMODE(), Al?

On 2022/03/01 19:15, Mickaël Salaün wrote:
> 
> On 01/03/2022 10:22, Christian Brauner wrote:
>> That specific part seems a bit risky at first glance. Given that the
>> patch referenced is from 2009 this means we've been allowing O_WRONLY |
>> O_RDWR to succeed for almost 13 years now.
>
> Yeah, it's an old bug, but we should keep in mind that a file descriptor
> created with such flags cannot be used to read nor write. However,
> unfortunately, it can be used for things like ioctl, fstat, chdir… I
> don't know if there is any user of this trick.

I got a reply from Al at https://lkml.kernel.org/r/20090212032821.GD28946@ZenIV.linux.org.uk
that sys_open(path, 3) is for ioctls only. And I'm using this trick when opening something
for ioctls only.
