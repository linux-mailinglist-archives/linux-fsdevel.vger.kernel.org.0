Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AB96A4708
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 17:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjB0QcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 11:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjB0QcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:32:04 -0500
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Feb 2023 08:32:01 PST
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB634EE9;
        Mon, 27 Feb 2023 08:32:00 -0800 (PST)
Received: from nvm (nvm.home.romanrm.net [IPv6:fd39::101])
        by len.romanrm.net (Postfix) with SMTP id 3CA7B40311;
        Mon, 27 Feb 2023 16:24:29 +0000 (UTC)
Date:   Mon, 27 Feb 2023 21:24:28 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Ammar Faizi <ammarfaizi2@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Filipe Manana <fdmanana@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for
 btrfs
Message-ID: <20230227212428.6d852cc3@nvm>
In-Reply-To: <b863f0ec-5e53-0045-cca1-c1a513e930e5@gmail.com>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
        <CAL3q7H63rvF3bXNgQAhcjdjbP2q5Wxo8MjcxcT7BeA9vjxAxwQ@mail.gmail.com>
        <ff610f19-7303-f583-4e22-e526f314aaa9@gmx.com>
        <b863f0ec-5e53-0045-cca1-c1a513e930e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 27 Feb 2023 20:45:26 +0700
Ammar Faizi <ammarfaizi2@gmail.com> wrote:

> Based on my testing, it gives lower latency for a browser app playing
> a YouTube video.
> 
> Without this proposed option, high-level compression on a btrfs
> storage is a real noise to user space apps. It periodically freezes
> the UI for 2 to 3 seconds and causes audio lag; it mostly happens when
> it starts writing the dirty write to the disk.
> 
> It's reasonably easy to reproduce by making a large dirty write and
> invoking a "sync" command.
> 
> Side note: Pin user apps to CPUs a,b,c,d and btrfs workquques to CPUs
> w,x,y,z.

The end user should not be expected to do that.
(At least that is my opinion as an end user :)

The worst part, in times when Btrfs has no current work to do, it means the
user apps are hard-capped to 4 cores for no good reason, and the other 4 are
idling. Even with a split like 6/2, this is still looks like giving up on the
achievements of multi-tasking operating systems and falling back to some
antique state with fixed separation.

> I want to run a smooth app with video. I also want to have high-level
> compression for my btrfs storage. But I don't want the compression and
> checksum work to bother my video; here, I give you CPU x,y,z for the
> btrfs work. And here I give you CPU a,b,c,d,e,f for the video work.
> 
> I have a similar case on a torrent seeder server where high-level
> compression is expected. And I believe there are more cases where this
> option is advantageous.

I really hope there can be some other approach. Such as some adjustment
to kworker processing so that it's not as aggressive in starving userspace.
There are no possibility to run kernel task at a lower priority, right?

But if no other way, maybe an option like that is good to have for the
moment.

-- 
With respect,
Roman
