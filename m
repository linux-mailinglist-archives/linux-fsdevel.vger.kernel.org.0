Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF75ABED7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Sep 2022 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiICMCr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 08:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiICMCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 08:02:45 -0400
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081577C53D
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Sep 2022 05:02:42 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MKYLn0mg8zMqHBF;
        Sat,  3 Sep 2022 14:02:41 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MKYLl6fFdzlh8TK;
        Sat,  3 Sep 2022 14:02:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1662206561;
        bh=JXNTYaev2XeltPl20btaAvwnJIH6UGjaOYmj2d4EFlc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZRwOWu39+hFbP7d+eM0R0MJC3LQ067e4L/EVohVnZAbp7prlSRZpcoPqWi7+cWBKB
         fxOe1Icfr/SPgO7lgG7oZEEx3LAoqmILHyKxHHJFk8EIpJKFGnwThriEEpc9w6lE3r
         80j7cwe9t9PDwT4mvkzWC357TXYXPbburrb+kstg=
Message-ID: <7c9ca33e-df40-dcd3-4d6f-6d0943b7ca6d@digikod.net>
Date:   Sat, 3 Sep 2022 14:02:38 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v5 0/4] landlock: truncate support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
 <b336dcfc-7d28-dea9-54de-0b8e4b725c1c@digikod.net> <YxGVgfcXwEa+5ZYn@nuc>
 <YxGfxo87drkAjWGf@nuc> <68c65a52-4fa1-d2fb-f571-878f9f4658ba@digikod.net>
 <YxIwi9uss1CbKWia@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <YxIwi9uss1CbKWia@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 02/09/2022 18:34, Günther Noack wrote:
> On Fri, Sep 02, 2022 at 10:40:57AM +0200, Mickaël Salaün wrote:
>> On 02/09/2022 08:16, Günther Noack wrote:
>>> On Fri, Sep 02, 2022 at 07:32:49AM +0200, Günther Noack wrote:
>>>> On Thu, Sep 01, 2022 at 07:10:38PM +0200, Mickaël Salaün wrote:
>>>>> Hmm, I think there is an issue with this series. Landlock only enforces
>>>>> restrictions at open time or when dealing with user-supplied file paths
>>>>> (relative or absolute).
>>>>
>>>> Argh, ok. That sounds like a desirable property, although it would
>>>> mean reworking the patch set.
>>>>
>>>>> The use of the path_truncate hook in this series
>>>>> doesn't distinguish between file descriptor from before the current sandbox
>>>>> or from after being sandboxed. For instance, if a file descriptor is
>>>>> received through a unix socket, it is assumed that this is legitimate and no
>>>>> Landlock restriction apply on it, which is not the case with this series
>>>>> anymore. It is the same for files opened before the process sandbox itself.
>>>>>
>>>>> To be able to follow the current semantic, I think we should control the
>>>>> truncate access at open time (or when dealing with a user-supplied path) but
>>>>> not on any file descriptor as it is currently done.
>>>>
>>>> OK - so let me try to make a constructive proposal. We have previously
>>>> identified a few operations where a truncation happens, and I would
>>>> propose that the following Landlock rights should be needed for these:
>>>>
>>>> * truncate() (operating on char *path): Require LL_ACCESS_FS_TRUNCATE
>>>> * ftruncate() (operating on fd): No Landlock rights required
>>>> * open() for reading with O_TRUNC: Require LL_ACCESS_FS_TRUNCATE
>>>> * open() for writing with O_TRUNC: Require LL_ACCESS_FS_WRITE_FILE
>>>
>>> Thinking about it again, another alternative would be to require
>>> TRUNCATE as well when opening a file for writing - it would be
>>> logical, because the resulting FD can be truncated. It would also
>>> require people to provide the truncate right in order to open files
>>> for writing, but this may be the logical thing to do.
>>
>> Another alternative would be to keep the current semantic but ignore file
>> descriptors from not-sandboxed processes. This could be possible by
>> following the current file->f_mode logic but using the Landlock's
>> file->f_security instead to store if the file descriptor was opened in a
>> context allowing it to be truncated: file opened outside of a landlocked
>> process, or in a sandbox allowing LANDLOCK_ACCESS_FS_TRUNCATE on the related
>> path.
> 
> I'm not convinced that it'll be worth distinguishing between a FD
> opened for writing and a FD opened for writing+truncation. And whether
> the FD is open for writing is already tracked by default and
> ftruncate() checks that.

That might be a misunderstanding. What I'm proposing is to keep the same 
semantic as this fifth patch series, only to keep scoped Landlock 
restrictions and propagate them (which is already how Landlock works).

The layout1.truncate tests should work the same except that 
test_ftruncate(file_*_fd) will always be allowed because such FD they 
are opened before the thread being sandboxed.

> 
> I'm having a hard time constructing a scenario where write() should be
> permitted on an FD but ftruncate() should be forbidden. It seems that
> write() is the more dangerous operation of the two, with more
> potential to modify a file to one's liking, whereas the modifications
> possible through TRUNCATE are relatively benign?

I don't understand, this is how this fifth series already restrict 
truncate. I'm not proposing to change the FD minimal requirement to be 
"truncatable", and it would not be possible with the LSM framework anyway.


> 
> The opposite scenario (where ftruncate() is permitted and write() is
> forbidden) simply can't exist because an FD must already be writable
> in order to use ftruncate(). (see man page)

Right, and I'm not proposing to change that. Currently, the kernel 
tracks how a FD was opened (e.g. read or write mode). I'm proposing to 
add another *complementary* Landlock-specific mode for truncate because 
it is a more fine-grained access right with Landlock, hence this patch 
series.


> 
> Additionally, if we recall previous discussions on the truncate patch
> sets, there is the very commonly used creat() syscall (a.k.a. open()
> with O_CREAT|O_WRONLY|O_TRUNC), which anyway requires the Landlock
> truncate right in many cases. So I still think you can't actually use
> LANDLOCK_ACCESS_FS_FILE_WRITE without also providing the
> LANDLOCK_ACCESS_FS_TRUNCATE right?

Hmm, that is definitely not a common case, but this series permit that, 
see test_truncate(file_t).

> 
> In conclusion, I'd be in favor of not tracking the truncate right
> separately as a property of an open file descriptor. Does that
> rationale sound reasonable?

No, but I think there is a misunderstanding. :)

The idea is first to change hook_file_open() to set 
landlock_file(file)->access = LANDLOCK_ACCESS_FS_TRUNCATE if it is 
allowed by the policy: current thread being either not in a sandbox, or 
in a sandbox that allows truncate.
Then, in hook_path_truncate(), we allow the operation if `file && 
(landlock_file(file)->access & LANDLOCK_ACCESS_FS_TRUNCATE)`. Otherwise, 
it there is only a path available (because it comes from truncate(2)), 
we (almost) call current_check_access_path(path, 
LANDLOCK_ACCESS_FS_TRUNCATE).
