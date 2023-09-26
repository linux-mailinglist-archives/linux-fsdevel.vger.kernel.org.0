Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7957AE413
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 05:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjIZD1n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 23:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZD1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:27:41 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388A6B3;
        Mon, 25 Sep 2023 20:27:34 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:60716)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qkyjR-0025XF-KK; Mon, 25 Sep 2023 21:27:29 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:52928 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qkyjQ-00A2kG-Bx; Mon, 25 Sep 2023 21:27:29 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sebastian Ott <sebott@redhat.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        sam@gentoo.org, Rich Felker <dalias@libc.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
        <36e93c8e-4384-b269-be78-479ccc7817b1@redhat.com>
        <87zg1bm5xo.fsf@email.froward.int.ebiederm.org>
        <37d3392c-cf33-20a6-b5c9-8b3fb8142658@redhat.com>
        <87jzsemmsd.fsf_-_@email.froward.int.ebiederm.org>
        <84e974d3-ae0d-9eb5-49b2-3348b7dcd336@redhat.com>
        <202309251001.C050864@keescook>
Date:   Mon, 25 Sep 2023 22:27:02 -0500
In-Reply-To: <202309251001.C050864@keescook> (Kees Cook's message of "Mon, 25
        Sep 2023 10:06:01 -0700")
Message-ID: <87v8bxiph5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1qkyjQ-00A2kG-Bx;;;mid=<87v8bxiph5.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/wOaQp+8aovEG4tuK61x9uVVX7vY5QjGM=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 668 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (1.8%), b_tie_ro: 10 (1.6%), parse: 1.41
        (0.2%), extract_message_metadata: 35 (5.2%), get_uri_detail_list: 4.9
        (0.7%), tests_pri_-2000: 43 (6.4%), tests_pri_-1000: 2.8 (0.4%),
        tests_pri_-950: 1.27 (0.2%), tests_pri_-900: 1.04 (0.2%),
        tests_pri_-200: 0.88 (0.1%), tests_pri_-100: 10 (1.5%), tests_pri_-90:
        89 (13.4%), check_bayes: 73 (10.9%), b_tokenize: 13 (1.9%),
        b_tok_get_all: 13 (2.0%), b_comp_prob: 4.1 (0.6%), b_tok_touch_all: 39
        (5.8%), b_finish: 0.87 (0.1%), tests_pri_0: 437 (65.4%),
        check_dkim_signature: 0.58 (0.1%), check_dkim_adsp: 7 (1.1%),
        poll_dns_idle: 15 (2.3%), tests_pri_10: 3.1 (0.5%), tests_pri_500: 29
        (4.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Mon, Sep 25, 2023 at 05:27:12PM +0200, Sebastian Ott wrote:
>> On Mon, 25 Sep 2023, Eric W. Biederman wrote:
>> > 
>> > Implement a helper elf_load that wraps elf_map and performs all
>> > of the necessary work to ensure that when "memsz > filesz"
>> > the bytes described by "memsz > filesz" are zeroed.
>> > 
>> > Link: https://lkml.kernel.org/r/20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net
>> > Reported-by: Sebastian Ott <sebott@redhat.com>
>> > Reported-by: Thomas Weißschuh <linux@weissschuh.net>
>> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> > ---
>> > fs/binfmt_elf.c | 111 +++++++++++++++++++++---------------------------
>> > 1 file changed, 48 insertions(+), 63 deletions(-)
>> > 
>> > Can you please test this one?
>
> Eric thanks for doing this refactoring! This does look similar to the
> earlier attempt:
> https://lore.kernel.org/lkml/20221106021657.1145519-1-pedro.falcato@gmail.com/
> and it's a bit easier to review.

I need to context switch away for a while so Kees if you will
I will let you handle the rest of this one.


A couple of thoughts running through my head for anyone whose ambitious
might include cleaning up binfmt_elf.c

The elf_bss variable in load_elf_binary can be removed.

Work for a follow on patch is using my new elf_load in load_elf_interp
and possibly in load_elf_library.  (More code size reduction).

An outstanding issue is if the first segment has filesz 0, and has a
randomized locations.  But that is the same as today.

There is a whole question does it make sense for the elf loader
to have it's own helper vm_brk_flags in mm/mmap.c or would it
make more sense for binfmt_elf to do what binfmt_elf_fdpic does and
have everything to go through vm_mmap.

I think replacing vm_brk_flags with vm_mmap would allow fixing the
theoretical issue of filesz 0 and randomizing locations.



In this change I replaced an open coded padzero that did not clear
all of the way to the end of the page, with padzero that does.

I also stopped checking the return of padzero as there is at least
one known case where testing for failure is the wrong thing to do.
It looks like binfmt_elf_fdpic may have the proper set of tests
for when error handling can be safely completed.

I found a couple of commits in the old history
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git,
that look very interesting in understanding this code.

commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail")
commit c6e2227e4a3e ("[SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c")
commit 5bf3be033f50 ("v2.4.10.1 -> v2.4.10.2")

Looking at commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail"):
>  commit 39b56d902bf35241e7cba6cc30b828ed937175ad
>  Author: Pavel Machek <pavel@ucw.cz>
>  Date:   Wed Feb 9 22:40:30 2005 -0800
> 
>     [PATCH] binfmt_elf: clearing bss may fail
>     
>     So we discover that Borland's Kylix application builder emits weird elf
>     files which describe a non-writeable bss segment.
>     
>     So remove the clear_user() check at the place where we zero out the bss.  I
>     don't _think_ there are any security implications here (plus we've never
>     checked that clear_user() return value, so whoops if it is a problem).
>     
>     Signed-off-by: Pavel Machek <pavel@suse.cz>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>

It seems pretty clear that binfmt_elf_fdpic with skipping clear_user
for non-writable segments and otherwise calling clear_user (aka padzero)
and checking it's return code is the right thing to do.

I just skipped the error checking as that avoids breaking things.

It looks like Borland's Kylix died in 2005 so it might be safe to
just consider read-only segments with memsz > filesz an error.


Looking at commit 5bf3be033f50 ("v2.4.10.1 -> v2.4.10.2") the
binfmt_elf.c bits confirm my guess that the weird structure is because
before that point binfmt_elf.c assumed there would be only a single
segment with memsz > filesz.  Which is why the code was structured so
weirdly.

Looking a little farther it looks like the binfmt_elf.c was introduced
in Linux v1.0, with essentially the same structure in load_elf_binary as
it has now.  Prior to that Linux hard coded support for a.out binaries
in execve.  So if someone wants to add a Fixes tag it should be
"Fixes: v1.0"

Which finally explains to me why the code is so odd.  For the most part
the code has only received maintenance for the last 30 years or so.
Strictly 29 years, but 30 has a better ring to it.

Anyway those are my rambling thoughts that might help someone.
For now I will be happy if we can get my elf_load helper tested
to everyone's satisfaction and merged.

Eric
