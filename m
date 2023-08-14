Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D3077BCE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjHNPYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 11:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjHNPXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:23:45 -0400
Received: from out-71.mta1.migadu.com (out-71.mta1.migadu.com [95.215.58.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7599010C1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 08:23:43 -0700 (PDT)
Date:   Mon, 14 Aug 2023 11:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692026621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=odVIt/5wqGAJeOs9uVdPC5bYWm2C36UtqikhKqjhgQs=;
        b=av8xoPF9Wxv45SXZf6WLQK5/Fb+dKBpiRouCaSh6qZkGuACL8mMMX2ostiNTehpbQS4XkV
        wpzk93WJrZRnVsWYao+xq+CHAlHERowZiwmJtb9da9Cg+KOtv7mLackqHPTAsFGBPpToXc
        nv6TeaSEaZL8I/AKljssQXQ0t+Hs+7c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230814152335.oiroowt2co2kj4xx@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230811-neigt-baufinanzierung-4c9521b036c6@brauner>
 <20230811125801.g3uwnouefoleq4nx@moria.home.lan>
 <20230814-funknetz-dreikampf-196dd2545dd9@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814-funknetz-dreikampf-196dd2545dd9@brauner>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 09:25:54AM +0200, Christian Brauner wrote:
> On Fri, Aug 11, 2023 at 08:58:01AM -0400, Kent Overstreet wrote:
> > I don't see the justification for the delay - every cycle there's some
> > amount of vfs/block layer refactoring that affects filesystems, the
> > super work is no different.
> 
> So, the reason is that we're very close to having the super code
> massaged in a shape where bcachefs should be able to directly make use
> of the helpers instead of having to pull in custom code at all. But not
> all that work has made it.

Well, bcachefs really isn't doing anything terribly unusual here; we're
using sget() directly, same as btrfs, and we have to because we're both
multi device filesystems.

Jan's restructing of mount_bdev() got me thinking that it should be
possible to do a mount_bdevs() that both btrfs and bcachefs could use -
but we don't need to be blocked on that, sget()'s been a normal exported
interface since forever.

Somewhat related, I dropped this patch from my tree:
block: Don't block on s_umount from __invalidate_super()
https://evilpiepirate.org/git/bcachefs.git/commit/?h=bcachefs-v6.3&id=1dd488901bc025a61e1ce1a0f54999a2b221bd78

and instead, for now we're closing block devices later in the shutdown
path like other filesystems do (after calling generic_shutdown_super(),
not in put_super()).

But now I've got some test failures, e.g.
https://evilpiepirate.org/~testdashboard/c/040e910f7f316ea6273c895dcc026b9f1ad36a8e/xfstests.generic.604/log.br

and since you guys are switching block device opens to use a real
holder, I suspect you'll be seeing the same issue soon.

The bug is that the mount appears to be gone - generic_shutdown_super()
is finished - so as far as userspace can tell everything is shutdown and
we should be able to start using the block device again, but the unmount
path hasn't actually called blkdev_put() yet.

So that patch I posted is one way to solve the self-deadlock from
calling blkdev_put() where we really want to be calling it... not the
prettiest way, but I think this is something we do need to get fixed.
