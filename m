Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819F04E8FCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 10:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbiC1ILx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 04:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbiC1ILw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:11:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D99A532EC
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 01:10:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8867D210DF;
        Mon, 28 Mar 2022 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648455006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eLjyxrm10dAh5Sj8tw43YCgRFuno0Jm9/aAQWe0mrDg=;
        b=Fx2UYawwTN41HJ7+uNYLhovYx7tJzYlt4Jq848w0pRGeZAYAY5vh4cuXv3hl/Op06RxxjX
        g5i0GK/LhH0YCL6PGJk2hqTlPWAC3N6dq6e7RzDo4im3BsQwm+tw3B4TAQ7wBpnrK6zqHv
        qwkDmQaB2//eTlZ5BLJBwSL7A9Wnjzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648455006;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eLjyxrm10dAh5Sj8tw43YCgRFuno0Jm9/aAQWe0mrDg=;
        b=YltA1BKRoIX1Bi+7HhfSVcOHJ9BQFzgrmNhp+p3YYacfKlpBdeC5bZO12t43KMygxns/+E
        vYYJjUaXxSzKehCg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7CCFDA3B82;
        Mon, 28 Mar 2022 08:10:06 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 35209A0610; Mon, 28 Mar 2022 10:10:06 +0200 (CEST)
Date:   Mon, 28 Mar 2022 10:10:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [GIT PULL] Reiserfs, udf, ext2 fixes and cleanups for 5.18-rc1
Message-ID: <20220328081006.sw6hb42567gzvlqz@quack3.lan>
References: <20220323153712.csh5pme32z5aqx4e@quack3.lan>
 <CAADWXX_FmHu6xb1tUEbwNZKtJ-dDe0uCpR94q6j0BRt3SxQxnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADWXX_FmHu6xb1tUEbwNZKtJ-dDe0uCpR94q6j0BRt3SxQxnQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 25-03-22 17:44:11, Linus Torvalds wrote:
> On Wed, Mar 23, 2022 at 8:37 AM Jan Kara <jack@suse.cz> wrote:
> >
> > The biggest change in this pull is the addition of a deprecation message
> > about reiserfs with the outlook that we'd eventually be able to remove it
> > from the kernel. Because it is practically unmaintained and untested and
> > odd enough that people don't want to bother with it anymore...
> 
> Pulled.
> 
> I have this memory of seeing somebody suggest the eventual removal be
> a bit more gradual with a "turn it read-only" first, as perhaps a
> slightly  less drastic "remove entirely" maintainability option.

Someone was suggesting we could keep reiserfs read-only. I didn't
understand it as a "stronger variant" of deprecation message but maybe that
was my lack of understanding. It is true we might switch reiserfs mounts to
read-only say year before the planned removal, possibly allow overriding
read-only mount with a special mount option, to force remaining users to
pay attention. The warning on mount may be too easy to ignore.

> But maybe I'm just confused and mis-remember - and maybe nobody is
> willing to maintain even just a read-only form. But being at least
> able to read old filesystem images might help *some* people if they
> notice much too late that "oh, it's gone".

Hmm, so you probably do mean: "keep read-only version around for a bit
longer". The concern I have there is that to simplify life of people doing
treewide changes (which was one of the motivations for scheduling reiserfs
removal), we'd probably need to rip out the write support code from the
kernel and I'm not sure how difficult is it going to be to carve out those
bits of code. I'm not sure whether taking say grub2 reiserfs support code
and making a fullblown fuse module with read-only support out of it isn't
going to be simpler task.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
