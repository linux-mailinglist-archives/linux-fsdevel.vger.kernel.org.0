Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD9761347E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 12:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJaL3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 07:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJaL3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:29:39 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0893EDF17;
        Mon, 31 Oct 2022 04:29:37 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29VBSTWq091436;
        Mon, 31 Oct 2022 20:28:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Mon, 31 Oct 2022 20:28:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29VBSSNC091431
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 31 Oct 2022 20:28:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <af24da42-02cb-e60e-d1df-365801aa686b@I-love.SAKURA.ne.jp>
Date:   Mon, 31 Oct 2022 20:28:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH -next 0/5] fs: fix possible null-ptr-deref when parsing
 param
Content-Language: en-US
To:     Ian Kent <raven@themaw.net>, Hawkins Jiawei <yin31149@gmail.com>,
        viro@zeniv.linux.org.uk
Cc:     18801353760@163.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        cmaiolino@redhat.com, dhowells@redhat.com, hughd@google.com,
        miklos@szeredi.hu, oliver.sang@intel.com, siddhesh@gotplt.org,
        syzbot+db1d2ea936378be0e4ea@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, smfrench@gmail.com,
        pc@cjr.nz, lsahlber@redhat.com, sprasad@microsoft.com,
        tom@talpey.com
References: <Y1VwdUYGvDE4yUoI@ZenIV>
 <20221024004257.18689-1-yin31149@gmail.com>
 <7ba9257e-0285-117c-eada-04716230d5af@themaw.net>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <7ba9257e-0285-117c-eada-04716230d5af@themaw.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/10/24 12:34, Ian Kent wrote:
> 
> On 24/10/22 08:42, Hawkins Jiawei wrote:
>> On Mon, 24 Oct 2022 at 00:48, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>> On Mon, Oct 24, 2022 at 12:39:41AM +0800, Hawkins Jiawei wrote:
>>>> According to commit "vfs: parse: deal with zero length string value",
>>>> kernel will set the param->string to null pointer in vfs_parse_fs_string()
>>>> if fs string has zero length.
>>>>
>>>> Yet the problem is that, when fs parses its mount parameters, it will
>>>> dereferences the param->string, without checking whether it is a
>>>> null pointer, which may trigger a null-ptr-deref bug.
>>>>
>>>> So this patchset reviews all functions for fs to parse parameters,
>>>> by using `git grep -n "\.parse_param" fs/*`, and adds sanity check
>>>> on param->string if its function will dereference param->string
>>>> without check.
>>> How about reverting the commit in question instead?  Or dropping it
>>> from patch series, depending upon the way akpm handles the pile
>>> these days...
>> I think both are OK.
>>
>> On one hand, commit "vfs: parse: deal with zero length string value"
>> seems just want to make output more informattive, which probably is not
>> the one which must be applied immediately to fix the
>> panic.
>>
>> On the other hand, commit "vfs: parse: deal with zero length string value"
>> affects so many file systems, so there are probably some deeper
>> null-ptr-deref bugs I ignore, which may take time to review.
> 
> Yeah, it would be good to make the file system handling consistent
> but I think there's been a bit too much breakage and it appears not
> everyone thinks the approach is the right way to do it.
> 
> I'm thinking of abandoning this and restricting it to the "source"
> parameter only to solve the user space mount table parser problem but
> still doing it in the mount context code to keep it general (at least
> for this case).

No progress on this problem, and syzbot is reporting one after the other...

I think that reverting is the better choice.

