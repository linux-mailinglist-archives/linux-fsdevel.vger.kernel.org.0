Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25A95BD8E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 02:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiITAqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 20:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiITAqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 20:46:08 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B659B419B5;
        Mon, 19 Sep 2022 17:46:02 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28K0jW6S080988;
        Tue, 20 Sep 2022 09:45:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Tue, 20 Sep 2022 09:45:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28K0jVKR080985
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Sep 2022 09:45:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b732028b-5348-fb6f-fc08-530d599e5a19@I-love.SAKURA.ne.jp>
Date:   Tue, 20 Sep 2022 09:45:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH (urgent)] vfs: fix uninitialized uid/gid in chown_common()
Content-Language: en-US
To:     Seth Forshee <sforshee@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        syzbot <syzbot+541e21dcc32c4046cba9@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <00000000000008058305e9033f85@google.com>
 <3411f396-a41e-76cb-7836-941fbade81dc@I-love.SAKURA.ne.jp>
 <20220919151220.htzmyesqt24xr26o@wittgenstein>
 <20220919151414.excah6gywyposvfj@wittgenstein>
 <20220919234102.GA21118@mail.hallyn.com> <YykIg4PRC3XZoJ9A@do-x1extreme>
 <YykJWF2wCEUHbnys@do-x1extreme>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YykJWF2wCEUHbnys@do-x1extreme>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/09/20 9:29, Seth Forshee wrote:
>>>>> Odd that we didn't get any of the reports. Thanks for relying this.
>>>>> I'll massage this a tiny bit, apply and will test with syzbot.

Since KMSAN is not yet upstreamed, uninit-value reports can come only after bugs
reached upstream kernels. Also, only LSMs which implement security_path_chown()
hook and checks uid/gid values (i.e. TOMOYO) would catch this bug.

>>>>
>>>> Fyi, Seth.
>>>
>>> Because the modules are ignoring ia_valid & ATTR_XID?
>>
>> security_path_chown() takes ids as arguments, not struct iattr.
>>
>>   int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
>>
>> The ones being passed are now taken from iattr and thus potentially not
>> initialized. Even if we change it to only call security_path_chown()
>> when one of ATTR_{U,G}ID is set the other might not be set, so
>> initializing iattr.ia_vfs{u,g}id makes sense to me and should match the
>> old behavior of passing invalid ids in this situation.
>>
>> What I don't understand is why security_path_chown() is even necessary
>> when we also have security_inode_setattr(), which also gets called
>> during chown and gets the full iattr struct. Maybe there's a good
>> reason, but at first glance it seems like it could do any checks that
>> security_path_chown() is doing.
> 
> Maybe the important difference is that one takes the path as an argument
> and the other only takes the dentry? I guess that might be it, though it
> still feels kind of redundant.

security_path_*() hooks are used by LSMs which check absolute pathnames.
Thus, these hooks are not redundant.

