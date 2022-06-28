Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687E155F1D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 01:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiF1XTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 19:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiF1XTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:19:15 -0400
Received: from mail.yonan.net (mail.yonan.net [54.244.116.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF492FE74
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 16:19:14 -0700 (PDT)
Received: from [10.10.0.40] (unknown [76.130.91.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.yonan.net (Postfix) with ESMTPSA id 75B0A3E947;
        Tue, 28 Jun 2022 23:19:13 +0000 (UTC)
Message-ID: <03ee39fa-7cfd-5155-3559-99ec8c8a2d32@openvpn.net>
Date:   Tue, 28 Jun 2022 17:19:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] namei: implemented RENAME_NEWER flag for renameat2()
 conditional replace
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20220627221107.176495-1-james@openvpn.net>
 <Yrs7lh6hG44ERoiM@ZenIV>
 <CAOQ4uxgoZe8UUftRKf=b--YmrKJ4wdDX99y7G8U2WTuuVsyvdA@mail.gmail.com>
From:   James Yonan <james@openvpn.net>
In-Reply-To: <CAOQ4uxgoZe8UUftRKf=b--YmrKJ4wdDX99y7G8U2WTuuVsyvdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/22 12:34, Amir Goldstein wrote:
> On Tue, Jun 28, 2022 at 8:44 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>> On Mon, Jun 27, 2022 at 04:11:07PM -0600, James Yonan wrote:
>>
>>>            && d_is_positive(new_dentry)
>>>            && timespec64_compare(&d_backing_inode(old_dentry)->i_mtime,
>>>                                  &d_backing_inode(new_dentry)->i_mtime) <= 0)
>>>                goto exit5;
>>>
>>> It's pretty cool in a way that a new atomic file operation can even be
>>> implemented in just 5 lines of code, and it's thanks to the existing
>>> locking infrastructure around file rename/move that these operations
>>> become almost trivial.  Unfortunately, every fs must approve a new
>>> renameat2() flag, so it bloats the patch a bit.
>> How is it atomic and what's to stabilize ->i_mtime in that test?
>> Confused...
> Good point.
> RENAME_EXCHANGE_WITH_NEWER would have been better
> in that regard.
>
> And you'd have to check in vfs_rename() after lock_two_nondirectories()

So I mean atomic in the sense that you are comparing the old and new 
mtimes inside the lock_rename/unlock_rename critical section in 
do_renameat2(), so the basic guarantees of rename still hold, i.e. that 
readers see an atomic transition from old to new files, or no transition 
(where mtime comparison results in -EEXIST return).  I understand that 
it doesn't guarantee i_mtime stability, but the application layer may 
not need that guarantee. In our case, mtime is immutable after local 
file creation and before do_renameat2() is used to move the file into place.

Re: RENAME_EXCHANGE_WITH_NEWER, that's an interesting idea.  You could 
actually implement it with minor changes in the patch, by simply 
combining RENAME_EXCHANGE|RENAME_NEWER.  Because fundamentally, all 
RENAME_NEWER does is compare mtimes and possibly return early with 
-EEXIST.  If the early return is not taken, then it becomes a plain 
rename or RENAME_EXCHANGE if that flag is also specified.

James


