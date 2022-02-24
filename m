Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34454C2E5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 15:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiBXOYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 09:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiBXOYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:24:46 -0500
Received: from winds.org (winds.org [68.75.195.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53E8D17C407;
        Thu, 24 Feb 2022 06:24:15 -0800 (PST)
Received: by winds.org (Postfix, from userid 100)
        id 0A86D1CA58F0; Thu, 24 Feb 2022 09:24:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by winds.org (Postfix) with ESMTP id DE3A21B33EE9;
        Thu, 24 Feb 2022 09:24:14 -0500 (EST)
Date:   Thu, 24 Feb 2022 09:24:14 -0500 (EST)
From:   Byron Stanoszek <gandalf@winds.org>
To:     Jan Kara <jack@suse.cz>
cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
In-Reply-To: <20220224084636.tdobyxoql5xtxkx7@quack3.lan>
Message-ID: <bb2c357f-d033-2a39-cfe8-f7e1ad2726f1@winds.org>
References: <YhIwUEpymVzmytdp@casper.infradead.org> <20220222100408.cyrdjsv5eun5pzij@quack3.lan> <20220222221614.GC3061737@dread.disaster.area> <3ce45c23-2721-af6e-6cd7-648dc399597@winds.org> <20220224084636.tdobyxoql5xtxkx7@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 24 Feb 2022, Jan Kara wrote:
> On Wed 23-02-22 09:48:26, Byron Stanoszek wrote:
>> On Wed, 23 Feb 2022, Dave Chinner wrote:
>>> On Tue, Feb 22, 2022 at 11:04:08AM +0100, Jan Kara wrote:
>>>> Hello!
>>>>
>>>> On Sun 20-02-22 12:13:04, Matthew Wilcox wrote:
>>>>> Keeping reiserfs in the tree has certain costs.  For example, I would
>>>>> very much like to remove the 'flags' argument to ->write_begin.  We have
>>>>> the infrastructure in place to handle AOP_FLAG_NOFS differently, but
>>>>> AOP_FLAG_CONT_EXPAND is still around, used only by reiserfs.
>>>>>
>>>>> Looking over the patches to reiserfs over the past couple of years, there
>>>>> are fixes for a few syzbot reports and treewide changes.  There don't
>>>>> seem to be any fixes for user-spotted bugs since 2019.  Does reiserfs
>>>>> still have a large install base that is just very happy with an old
>>>>> stable filesystem?  Or have all its users migrated to new and exciting
>>>>> filesystems with active feature development?
>>>>>
>>>>> We've removed support for senescent filesystems before (ext, xiafs), so
>>>>> it's not unprecedented.  But while I have a clear idea of the benefits to
>>>>> other developers of removing reiserfs, I don't have enough information to
>>>>> weigh the costs to users.  Maybe they're happy with having 5.15 support
>>>>> for their reiserfs filesystems and can migrate to another filesystem
>>>>> before they upgrade their kernel after 5.15.
>>>>>
>>>>> Another possibility beyond outright removal would be to trim the kernel
>>>>> code down to read-only support for reiserfs.  Most of the quirks of
>>>>> reiserfs have to do with write support, so this could be a useful way
>>>>> forward.  Again, I don't have a clear picture of how people actually
>>>>> use reiserfs, so I don't know whether it is useful or not.
>>>>>
>>>>> NB: Please don't discuss the personalities involved.  This is purely a
>>>>> "we have old code using old APIs" discussion.
>>>>
>>>> So from my distro experience installed userbase of reiserfs is pretty small
>>>> and shrinking. We still do build reiserfs in openSUSE / SLES kernels but
>>>> for enterprise offerings it is unsupported (for like 3-4 years) and the module
>>>> is not in the default kernel rpm anymore.
>>>>
>>>> So clearly the filesystem is on the deprecation path, the question is
>>>> whether it is far enough to remove it from the kernel completely. Maybe
>>>> time to start deprecation by printing warnings when reiserfs gets mounted
>>>> and then if nobody yells for year or two, we'll go ahead and remove it?
>>>
>>> Yup, I'd say we should deprecate it and add it to the removal
>>> schedule. The less poorly tested legacy filesystem code we have to
>>> maintain the better.
>>>
>>> Along those lines, I think we really need to be more aggressive
>>> about deprecating and removing filesystems that cannot (or will not)
>>> be made y2038k compliant in the new future. We're getting to close
>>> to the point where long term distro and/or product development life
>>> cycles will overlap with y2038k, so we should be thinking of
>>> deprecating and removing such filesystems before they end up in
>>> products that will still be in use in 15 years time.
>>>
>>> And just so everyone in the discussion is aware: XFS already has a
>>> deprecation and removal schedule for the non-y2038k-compliant v4
>>> filesystem format. It's officially deprecated right now, we'll stop
>>> building kernels with v4 support enabled by default in 2025, and
>>> we're removing the code that supports the v4 format entirely in
>>> 2030.
>>
>> For what it's worth, I have a number of production servers still using
>> Reiserfs, which I regularly maintain by upgrading to the latest Linux kernel
>> annually (mostly to apply security patches). I figured this filesystem would
>> still be available for several more years, since it's not quite y2038k yet.
>>
>> I originally installed Reiserfs on these systems as early as 2005 due to the
>> tail-packing feature, which saved space with many small files on older
>> harddrives. Since then, I witnessed the development of ext4, and then btrfs.
>> For a long time, these newer filesystems had occasional reports of instabilities
>> and lost data, and so I shied away from using them. Meanwhile, Reiserfs reached
>> a level of maturity and no longer had active development on it, except for the
>> occasional bugfix. I felt this was a filesystem I could trust going forward
>> (despite its relative slowness), even after popular Linux distributions
>> eventually dropped it from being installed by default.
>>
>> I have only recently begun to use XFS on newer installs, only since the XFS
>> developers added bigtime support for y2038k. But for existing installs, I ask
>> that we keep Reiserfs supported in the kernel a little longer. Perhaps use the
>> same deprecation schedule that was picked for XFS v4 (roughly 10 years of
>> deprecation before eventual removal)?
>
> Thanks for letting us know about your usage! Frankly the reality of
> reiserfs is that it gets practically no development time and little
> testing. Now this would not be a big problem on its own because what used
> to work should keep working but the rest of the common filesystem
> infrastructure keeps moving (e.g. with Matthew's page cache changes, new
> mount API, ...) and so it can happen that with a lack of testing &
> development reiserfs will break without us noticing. So I would not
> consider reiserfs a particularly safe choice these days and rather consider
> migration to some other filesystem. Originally I thought about 2 years
> deprecation period but if 5 years make things significantly easier for you
> (here I have to admit I don't have experience with maintaining larger fleet
> of servers and how much effort it takes to move it to a different fs) we can
> live with that I guess.

I understand the necessity to drop uncommon or unmaintained subsystems in order
to keep moving forward with code development. And thanks for the warning
regarding reiserfs not being a particularly safe choice these days.

For my specific use case, I can probably squeeze by with 2 years of
deprecation, but I would feel more comfortable with having 3. Thanks for your
consideration!

Regards,
  -Byron

