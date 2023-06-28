Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB57874177D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjF1RwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:52:18 -0400
Received: from out-9.mta0.migadu.com ([91.218.175.9]:56292 "EHLO
        out-9.mta0.migadu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjF1RwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:52:10 -0400
Date:   Wed, 28 Jun 2023 13:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687974729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3wb1kX6L9/pLjHJdQokUyimNTJMnyAUv+LwDyu/SD5A=;
        b=NF2SPqayC4BiclJHcHAIBaBByf4KV5Q43ZH0e95617IhssmKgWnWUFtxGyotr/gKZhsNm1
        RN+KQcxyvA5BGAeqHSlWP2WprMri89bMWLGDEt7y92eH+lt1bEABpnImsptiWCu8Qw+EWG
        RijQZcqgyot80L03bXHj53Ze3srap7k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
References: <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:57:02AM -0600, Jens Axboe wrote:
> I discussed this with Christian offline. I have a patch that is pretty
> simple, but it does mean that you'd wait for delayed fput flush off
> umount. Which seems kind of iffy.
> 
> I think we need to back up a bit and consider if the kill && umount
> really is sane. If you kill a task that has open files, then any fput
> from that task will end up being delayed. This means that the umount may
> very well fail.
> 
> It'd be handy if we could have umount wait for that to finish, but I'm
> not at all confident this is a sane solution for all cases. And as
> discussed, we have no way to even identify which files we'd need to
> flush out of the delayed list.
> 
> Maybe the test case just needs fixing? Christian suggested lazy/detach
> umount and wait for sb release. There's an fsnotify hook for that,
> fsnotify_sb_delete(). Obviously this is a bit more involved, but seems
> to me that this would be the way to make it more reliable when killing
> of tasks with open files are involved.

No, this is a real breakage. Any time we introduce unexpected
asynchrony there's the potential for breakage: case in point, there was
a filesystem that made rm asynchronous, then there were scripts out
there that deleted until df showed under some threshold.. whoops...

this would break anyone that does fuser; umount; and making the umount
lazy just moves the race to the next thing that uses the block device.

I'd like to know how delayed_fput() avoids this.
