Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF711724E72
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 23:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbjFFVGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjFFVGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:06:13 -0400
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C71707;
        Tue,  6 Jun 2023 14:06:08 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5f1d:0:640:49bf:0])
        by forward501a.mail.yandex.net (Yandex) with ESMTP id 9705F5EB94;
        Wed,  7 Jun 2023 00:06:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 36bUBP1DdeA0-FdoUgi57;
        Wed, 07 Jun 2023 00:06:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1686085564;
        bh=g+p57RqFmxJ4tzpz/26eK8nSIEQ3A6k2DYL8R5TP9Jo=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=hs+DfPcJaUkA0cTRNlzqm0BdIgJqOxd5hZo8lrJTuB3j7JLEo5ZEWDeX0KuY1wIqy
         Sc8GkCdA/Cg5Dlv0wqDIaqhj8MqZ0x7pMCh2fVG1DW6TZRRMw6d5kfkBd1mXF4o3MZ
         WUC27bTIOC+uFu4eZrMlOK2rQ4uxMbS+lhjz8Y7g=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <ef1b0ecd-5a03-4256-2a7a-3e22b755aa53@ya.ru>
Date:   Wed, 7 Jun 2023 00:06:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/3] mm: Make unregistration of super_block shrinker
 more faster
To:     Dave Chinner <david@fromorbit.com>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
 <ZH5ig590WleaH1Ed@dread.disaster.area>
Content-Language: en-US
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <ZH5ig590WleaH1Ed@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.06.2023 01:32, Dave Chinner wrote:
> On Mon, Jun 05, 2023 at 10:02:46PM +0300, Kirill Tkhai wrote:
>> This patch set introduces a new scheme of shrinker unregistration. It allows to split
>> the unregistration in two parts: fast and slow. This allows to hide slow part from
>> a user, so user-visible unregistration becomes fast.
>>
>> This fixes the -88.8% regression of stress-ng.ramfs.ops_per_sec noticed
>> by kernel test robot:
>>
>> https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
>>
>> ---
>>
>> Kirill Tkhai (2):
>>       mm: Split unregister_shrinker() in fast and slow part
>>       fs: Use delayed shrinker unregistration
> 
> Did you test any filesystem other than ramfs?
> 
> Filesystems more complex than ramfs have internal shrinkers, and so
> they will still be running the slow synchronize_srcu() - potentially
> multiple times! - in every unmount. Both XFS and ext4 have 3
> internal shrinker instances per mount, so they will still call
> synchronize_srcu() at least 3 times per unmount after this change.
> 
> What about any other subsystem that runs a shrinker - do they have
> context depedent shrinker instances that get frequently created and
> destroyed? They'll need the same treatment.

Of course, all of shrinkers should be fixed. This patch set just aims to describe
the idea more wider, because I'm not sure most people read replys to kernel robot reports.

This is my suggestion of way to go. Probably, Qi is right person to ask whether
we're going to extend this and to maintain f95bdb700bc6 in tree.

There is not much time. Unfortunately, kernel test robot reported this significantly late.

> Seriously, part of changing shrinker infrastructure is doing an
> audit of all the shrinker instances to determine how the change will
> impact those shrinkers, and if the same structural changes are
> needed to those implementations.
> 
> I don't see any of this being done - this looks like a "slap a bandaid
> over the visible symptom" patch set without any deeper investigation
> of the scope of the issue having been gained.
> 
> Along with all shrinkers now running under a SRCU critical region
> and requiring a machine wide synchronisation point for every
> unregister_shrinker() call made, the ability to repeated abort
> global shrinker passes via external SRCU expediting, and now an
> intricate locking and state dance in do_shrink_slab() vs
> unregister_shrinker, I can't say I'm particularly liking any of
> this, regardles of the benefits it supposedly provides.
> 
> -Dave.

