Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5A46C9801
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Mar 2023 23:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjCZVT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 17:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCZVT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 17:19:26 -0400
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [IPv6:2001:1600:3:17::190d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEFE5262
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Mar 2023 14:19:25 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Pl82x2FVFzMqsLX;
        Sun, 26 Mar 2023 23:19:21 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Pl82w3QZ1zMsFWW;
        Sun, 26 Mar 2023 23:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1679865561;
        bh=ZD83hN6SuR76iYpeMGyGAtgY8BuqDrMxZZSjIbx0wOg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MCmIxZAhFCyXPz7HcDPEs52NENsNQwRNDYPj5i2F0OEWJ14revjVkP7q7baBS94Y6
         ylT2HJMKsVZe3ZHgF1YL1Hqpj3vJkRiZrhPQhvm08w6dyfsKAGcgwFMVKTjMYXLTXh
         mPniioGKKLFB2A1XdLvFMpOB88kkrfvGHy5u7g94=
Message-ID: <fbaa6222-255d-57fa-c2fe-f69752a4cb35@digikod.net>
Date:   Sun, 26 Mar 2023 23:19:19 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: Does Landlock not work with eCryptfs?
Content-Language: en-US
To:     Tyler Hicks <code@tyhicks.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        landlock@lists.linux.dev,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20230319.2139b35f996f@gnoack.org>
 <c1c9c688-c64d-adf2-cc96-dc2aaaae5944@digikod.net>
 <20230320.c6b83047622f@gnoack.org>
 <5d415985-d6ac-2312-3475-9d117f3be30f@digikod.net>
 <e70f7926-21b6-fbce-c5d6-7b3899555535@digikod.net>
 <20230321172450.crwyhiulcal6jvvk@wittgenstein>
 <42ffeef4-e71f-dd2b-6332-c805d1db2e3f@digikod.net> <ZB4p4DXwgByYCt5O@sequoia>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <ZB4p4DXwgByYCt5O@sequoia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 24/03/2023 23:53, Tyler Hicks wrote:
> On 2023-03-21 19:16:28, Mickaël Salaün wrote:
>>
>> On 21/03/2023 18:24, Christian Brauner wrote:
>>> On Tue, Mar 21, 2023 at 05:36:19PM +0100, Mickaël Salaün wrote:
>>>> There is an inconsistency between ecryptfs_dir_open() and ecryptfs_open().
>>>> ecryptfs_dir_open() actually checks access right to the lower directory,
>>>> which is why landlocked processes may not access the upper directory when
>>>> reading its content. ecryptfs_open() uses a cache for upper files (which
>>>> could be a problem on its own). The execution flow is:
>>>>
>>>> ecryptfs_open() -> ecryptfs_get_lower_file() -> ecryptfs_init_lower_file()
>>>> -> ecryptfs_privileged_open()
>>>>
>>>> In ecryptfs_privileged_open(), the dentry_open() call failed if access to
>>>> the lower file is not allowed by Landlock (or other access-control systems).
>>>> Then wait_for_completion(&req.done) waits for a kernel's thread executing
>>>> ecryptfs_threadfn(), which uses the kernel's credential to access the lower
>>>> file.
>>>>
>>>> I think there are two main solutions to fix this consistency issue:
>>>> - store the mounter credentials and uses them instead of the kernel's
>>>> credentials for lower file and directory access checks (ecryptfs_dir_open
>>>> and ecryptfs_threadfn changes);
>>>> - use the kernel's credentials for all lower file/dir access check,
>>>> especially in ecryptfs_dir_open().
>>>>
>>>> I think using the mounter credentials makes more sense, is much safer, and
>>>> fits with overlayfs. It may not work in cases where the mounter doesn't have
>>>> access to the lower file hierarchy though.
>>>>
>>>> File creation calls vfs_*() helpers (lower directory) and there is not path
>>>> nor file security hook calls for those, so it works unconditionally.
>>>>
>>>>   From Landlock end users point of view, it makes more sense to grants access
>>>> to a file hierarchy (where access is already allowed) and be allowed to
>>>> access this file hierarchy, whatever it belongs to a specific filesystem
>>>> (and whatever the potential lower file hierarchy, which may be unknown to
>>>> users). This is how it works for overlayfs and I'd like to have the same
>>>> behavior for ecryptfs.
>>>
>>> So given that ecryptfs is marked as "Odd Fixes" who is realistically
>>> going to do the work of switching it to a mounter's credentials model,
>>> making sure this doesn't regress anything, and dealing with any
>>> potential bugs caused by this. It might be potentially better to just
>>> refuse to combine Landlock with ecryptfs if that's possible.
>>
>> If Tyler is OK with the proposed solutions, I'll get a closer look at it in
>> a few months. If anyone is interested to work on that, I'd be happy to
>> review and test (the Landlock part).
> 
> I am alright with using the mounter creds but eCryptfs is typically
> mounted as root using a PAM module so the mounter is typically going to
> be more privileged than the user accessing the eCryptfs mount (in the
> common case of an encrypted home directory).
> 
> But, as Christian points out, I think it might be better to make
> Landlock refuse to work with eCryptfs. Would you be at ease with that
> decision if we marked eCryptfs as deprecated with a planned removal
> date?

The only way to make Landlock "refuse" to work with eCryptfs would be to 
add exceptions according to the underlying filesystem when creating 
rules. Furthermore, to be consistent, this would need to be backported. 
I don't want to go in such direction to fix an eCryptfs issue.

Doing nothing would go against the principle of least astonishment 
because of unexpected and inconsistent behavior when using Landlock with 
eCryptfs. Indeed, Landlock users (e.g. app developers) may not know how, 
where, and on which kernel their sandboxed applications will run. This 
means that at best, developers will (potentially wrongly) check if 
eCryptfs is available/used and then disable sandboxing, and at worse the 
(opportunistically) sandboxed apps will break (because of denied 
access). In any case, it goes against user's interests.

Even if eCryptfs is marked as deprecated, it will be available for years 
(a lot for LTS) and (legitimate) bug reports will keep coming.

Instead, I'd like to fix the eCryptfs inconsistent behavior (highlighted 
by Landlock and other LSMs). I think it's worth trying the first 
proposed solution, which might not be too difficult to implement, and 
will get eCryptfs closer to the overlayfs semantic.
