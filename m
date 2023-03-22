Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31E36C4759
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 11:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCVKRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 06:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCVKRT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9C95CEDB;
        Wed, 22 Mar 2023 03:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97BED60AE9;
        Wed, 22 Mar 2023 10:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4D7C433EF;
        Wed, 22 Mar 2023 10:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679480236;
        bh=j/clU2QHh0duzkVJY4C46Qu2I56Xdrto7SkpOldAW4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bwK7kmCPeOwOoNetxPfAW0Qg1+2x7O55qfT3E5VMgPaqEyxbgjHtWtZU5QGQu6US2
         gaCqVnlcnxSQo7yFg6TFNhCMkNUIaEsHxKPFu5Pk6pq3E5wPR+Oa8ZThLCj7mSj0+s
         cPkOYSml5qmsdEEPM5S6R8QHAalpSMh8wf102Z6eWq0Hm1hoXMNP/YkMZT57x0sY/W
         5k//8F3pqjw4jgAOIcqc1CbAMkxWA4iqKD1hRU5tlAVKBaLvranN6mZmVAN/YOtuG0
         m6uETCB+650rMRABsWR4+YFr0BXBKpGsW+J4DJhcnfQy/qUgWGJCU7Cpo8gNUykNwD
         IoVFygUIHhhGw==
Date:   Wed, 22 Mar 2023 11:17:10 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
Message-ID: <20230322101710.6rziolp4sqooqfwq@wittgenstein>
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein>
 <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
 <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
 <20230321142413.6mlowi5u6ewecodx@wittgenstein>
 <20230321161736.njmtnkvjf5rf7x5p@wittgenstein>
 <CAHk-=wi2mLKn6U7_aXMtP46TVSY6MTHv+ff-+xVFJbO914o65A@mail.gmail.com>
 <20230321201632.o2wiz5gk7cz36rn3@wittgenstein>
 <CAHk-=wg2nJ3Z8x-nDGi9iCJvDCgbhpN+qnZt6V1JPnHqxX2fhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wg2nJ3Z8x-nDGi9iCJvDCgbhpN+qnZt6V1JPnHqxX2fhQ@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:47:55PM -0700, Linus Torvalds wrote:
> On Tue, Mar 21, 2023 at 1:16 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > But yes, that is a valid complaint so - without having tested - sm like:
> 
> I'd actually go a bit further, and really spell all the bits out explicitly.
> 
> I mean, I was *literally* involved in that original O_TMPFILE_MASK thing:
> 
>    https://lore.kernel.org/all/CA+55aFxA3qoM5wpMUya7gEA8SZyJep7kMBRjrPOsOm_OudD8aQ@mail.gmail.com/
> 
> with the whole O_DIRECOTY games to make O_TMPFILE safer, but despite
> that I didn't remember this at all, and my suggested "maybe something
> like this" patch was broken for the O_TMPFILE case.
> 
> So while we do have all this documented in our history (both git
> commit logs and lore.kernel.org), I actually think it would be lovely
> to just make build_open_flags() be very explicit about all the exact
> O_xyz flags, and really write out the logic fully.
> 
> For example, even your clarified version that gets rid of the
> "O_TMPFILE_MASK" thing still eends up doing
> 
>         if (flags & __O_TMPFILE) {
>                 if ((flags & O_TMPFILE) != O_TMPFILE)
>                         return -EINVAL;
> 
> and so when you look at that code, you don't actually realize that
> O_TMPFILE _cotnains_ that __O_TMPFILE bit, and what the above really
> means is "also check O_DIRECTORY".
> 
> So considering how I couldn't remember this mess myself, despite
> having been involved with it personally (a decade ago..), I really do
> think that maybe this shoudl be open-coded with a comment, and the
> above code should instead be
> 
>         if (flags & __O_TMPFILE) {
>                 if (!(flags & O_DIRECTORY))
>                         return -EINVAL;
> 
> together with an explicit comment about how O_TMPFILE is the
> *combination* of __O_TMPFILE and O_DIRECTORY, along with a short
> explanation as to why.
> 
> Now, I agree that that test for O_DIRECTORY then _looks_ odd, but the
> thing is, it then makes the reality of this all much more explicit.
> 
> In contrast, doing that
> 
>                 if ((flags & O_TMPFILE) != O_TMPFILE)
> 
> may *look* more natural in that context, but if you actually start
> thinking about it, that check makes no sense unless you then look up
> what O_TMPFILE is, and the history behind it.
> 
> So I'd rather have code that looks a bit odd, but that explains itself
> and is explicit about what it does, than code that _tries_ to look
> natural but actually hides the reason for what it is doing.
> 
> And then next time somebody looks at that O_DIRECTORY | O_CREAT
> combination, suddenly the __O_TMPFILE interaction is there, and very
> explicit.
> 
> Hmm?
> 
> I don't feel *hugely* strongly about this, so in the end I'll bow to
> your decision, but considering that my initial patch looked sane but
> was buggy because I had forgotten about O_TMPFILE, I really think we
> should make this more explicit at a source level..

I don't feel strongly about this either and your points are valid. So I
incorporated that and updated the comments in the code. In case you'd like to
take another look I've now put this up at:

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/vfs.open.directory.creat.einval

for you to fetch changes up to 43b450632676fb60e9faeddff285d9fac94a4f58:

  open: return EINVAL for O_DIRECTORY | O_CREAT (2023-03-22 11:06:55 +0100)

----------------------------------------------------------------
vfs.open.directory.creat.einval

----------------------------------------------------------------
Christian Brauner (1):
      open: return EINVAL for O_DIRECTORY | O_CREAT

 fs/open.c                              | 18 +++++++++++++-----
 include/uapi/asm-generic/fcntl.h       |  1 -
 tools/include/uapi/asm-generic/fcntl.h |  1 -
 3 files changed, 13 insertions(+), 7 deletions(-)
