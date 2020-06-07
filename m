Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594AA1F0A34
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 08:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgFGGC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jun 2020 02:02:27 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58192 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgFGGC0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 02:02:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jhoNt-0002sw-GJ; Sun, 07 Jun 2020 00:02:17 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jhoNs-0007uk-Fl; Sun, 07 Jun 2020 00:02:17 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
        <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
        <202006051903.C44988B@keescook>
        <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
        <20200606201956.rvfanoqkevjcptfl@ast-mbp>
        <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
        <20200607014935.vhd3scr4qmawq7no@ast-mbp>
Date:   Sun, 07 Jun 2020 00:58:12 -0500
In-Reply-To: <20200607014935.vhd3scr4qmawq7no@ast-mbp> (Alexei Starovoitov's
        message of "Sat, 6 Jun 2020 18:49:36 -0700")
Message-ID: <87mu5f8ljf.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jhoNs-0007uk-Fl;;;mid=<87mu5f8ljf.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+K4tihHVswn5I/i1dFAynwntdk//GL2kI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 603 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 14 (2.4%), b_tie_ro: 12 (2.0%), parse: 1.19
        (0.2%), extract_message_metadata: 6 (1.0%), get_uri_detail_list: 3.6
        (0.6%), tests_pri_-1000: 4.6 (0.8%), tests_pri_-950: 1.32 (0.2%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 114 (19.0%), check_bayes:
        112 (18.6%), b_tokenize: 11 (1.7%), b_tok_get_all: 15 (2.5%),
        b_comp_prob: 5 (0.9%), b_tok_touch_all: 76 (12.6%), b_finish: 1.38
        (0.2%), tests_pri_0: 440 (73.0%), check_dkim_signature: 0.77 (0.1%),
        check_dkim_adsp: 3.4 (0.6%), poll_dns_idle: 1.24 (0.2%), tests_pri_10:
        3.8 (0.6%), tests_pri_500: 8 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, Jun 06, 2020 at 03:33:14PM -0700, Linus Torvalds wrote:
>> On Sat, Jun 6, 2020 at 1:20 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> >
>> > Please mention specific bugs and let's fix them.
>> 
>> Well, Eric did mention one explicit bug, and several "looks dodgy" bugs.
>> 
>> And the fact is, this isn't used.
>> 
>> It's clever, and I like the concept, but it was probably a mistake to
>> do this as a user-mode-helper thing.
>> 
>> If people really convert netfilter rules to bpf, they'll likely do so
>> in user space. This bpfilter thing hasn't gone anywhere, and it _has_
>> caused problems.
>> 
>> So Alexei, I think the burden of proof is not on Eric, but on you.
>> 
>> Eric's claim is that
>> 
>>  (a) it has bugs (and yes, he pointed to at lelast one)
>
> the patch from March 12 ?
> I thought it landed long ago. Is there an issue with it?
> 'handling is questionable' is not very constructive.

It was half a fix.  Tetsuo still doesn't know how to fix tomoyo to work
with fork_usermode_blob.

He was asking for your feedback and you did not give it.

The truth is Tetsuo's fix was only a fix for the symptoms.  It was not a
good fix to the code.

>>  (b) it's not doing anything useful
>
> true.
>
>>  (b) it's a maintenance issue for execve, which is what Eric maintains.
>
> I'm not aware of execve issues. I don't remember being cc-ed on them.
> To me this 'lets remove everything' patch comes out of nowhere with
> a link to three month old patch as a justification.

I needed to know how dead the code is and your reply has confirmed
that the code is dead.

Deleting the code is much easier than the detailed careful work it would
take to make code that is in use work correctly.

>> So you can't just dismiss this, ignore the reported bug, and say
>> "we'll fix them".
>> 
>> That only answers (a) (well, it _would_ have answered (a)., except you
>> actually didn't even read Eric's report of existing bugs).
>> 
>> What is your answer to (b)-(c)?
>
> So far we had two attempts at converting netfilter rules to bpf. Both ended up
> with user space implementation and short cuts. bpf side didn't have loops and
> couldn't support 10k+ rules. That is what stalled the effort. imo it's a
> pointless corner case, but to be a true replacement people kept bringing it up
> as something valid. Now we have bpf iterator concept and soon bpf will be able
> to handle millions of rules. Also folks are also realizing that this effort has
> to be project managed appropriately. Will it materialize in patches tomorrow?
> Unlikely. Probably another 6 month at least. Also outside of netfilter
> conversion we've started /proc extension effort that will use the same umh
> facility. It won't be ready tomorrow as well, but both need umh.

Given that I am one of the folks who looks after proc I haven't seen
that either.  The direction I have seen in the last 20 years is people
figuring out how to reduce proc not really how to extend it so I can't
imagine what a /proc extension effort is.

> initrd is not
> an option due to operational constraints. We need a way to ship kernel tarball
> where bpf things are ready at boot. I suspect /proc extensions patches will
> land sooner. Couple month ago people used umh to do ovs->xdp translatation. It
> didn't land. People argued that the same thing can be achieved in user space
> and they were correct. So you're right that for most folks user space is the
> answer. But there are cases where kernel has to have these things before
> systemd starts.

You may have a valid case for doing things in the kernel before systemd
starts.  The current mechanism is fundamentally in conflict with the
LSMs which is an unresolved problem.

I don't see why you can't have a userspace process that does:

	pid = fork();
        if (pid == 0) {
        	/* Do bpf stuff */
        }
        else if (pid > 0) {
        	execve("/sbin/init", ...);
        }

You can build an initramfs with that code right into the kernel, so
I can't imagine the existing mechanisms being insufficient.

That said the fork_usermode_blob code needs to be taken out and
rewritten so as not to impose a burden on the rest of the code.  There
is no reason why code that is called only one time can not allocate a
filename and pass it to __do_execve_file.

There is no reason to allow modules access to any of that functionality
if you need something before an initramfs can be processed.

exit_umh() is completely unnecessary all that is needed is a reference
to a struct pid.

There are all of these layers and abstractions but with only the single
user in net/bpfilter/bpfilter_kern.c they all appear to have been
jumbled together without good layering inbetween then.

That is just what I see from looking at the code quickly.

All of those problems need to be addressed before fork_usermode_blob
grows any real users.

As for other users that want to use for_usermode_blob in the future
currently the code in the kernel is not at all straightforward to tell
if it is correct or not.  So before it grows any living users the code
need to be rewitten so that it is easy to tell that it is correct.

I have sympathy with your efforts but since the code is currently dead,
and in need of work.  I will write a good version of removing
CONFIG_BPFILTER_UMH on top of -rc1, leaving CONFIG_BPFILTER.

That should give you a solid foundation to build upon, while making the
kernel maintainble.

Eric

