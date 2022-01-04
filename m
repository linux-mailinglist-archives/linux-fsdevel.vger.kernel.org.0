Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C492484984
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 21:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiADUzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 15:55:02 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49271 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233562AbiADUzB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:55:01 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 204KqTfp016358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jan 2022 15:52:30 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EDA7015C00E1; Tue,  4 Jan 2022 15:52:28 -0500 (EST)
Date:   Tue, 4 Jan 2022 15:52:28 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Walt Drummond <walt@drummond.us>, aacraid@microsemi.com,
        viro@zeniv.linux.org.uk, anna.schumaker@netapp.com, arnd@arndb.de,
        bsegall@google.com, bp@alien8.de, chuck.lever@oracle.com,
        bristot@redhat.com, dave.hansen@linux.intel.com,
        dwmw2@infradead.org, dietmar.eggemann@arm.com, dinguyen@kernel.org,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        idryomov@gmail.com, mingo@redhat.com, yzaikin@google.com,
        ink@jurassic.park.msu.ru, jejb@linux.ibm.com, jmorris@namei.org,
        bfields@fieldses.org, jlayton@kernel.org, jirislaby@kernel.org,
        john.johansen@canonical.com, juri.lelli@redhat.com,
        keescook@chromium.org, mcgrof@kernel.org,
        martin.petersen@oracle.com, mattst88@gmail.com, mgorman@suse.de,
        oleg@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        rth@twiddle.net, richard@nod.at, serge@hallyn.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        trond.myklebust@hammerspace.com, vincent.guittot@linaro.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] signals: Support more than 64 signals
Message-ID: <YdSzjPbVDVGKT4km@mit.edu>
References: <20220103181956.983342-1-walt@drummond.us>
 <87iluzidod.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iluzidod.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 12:00:34PM -0600, Eric W. Biederman wrote:
> I dug through the previous conversations and there is a little debate
> about what makes sense for SIGPWR to do by default.  Alan Cox remembered
> SIGPWR was sent when the power was restored, so ignoring SIGPWR by
> default made sense.  Ted Tso pointed out a different scenario where it
> was reasonable for SIGPWR to be a terminating signal.
> 
> So far no one has actually found any applications that will regress if
> SIGPWR becomes ignored by default.  Furthermore on linux SIGPWR is only
> defined to be sent to init, and init ignores all signals by default so
> in practice SIGPWR is ignored by the only process that receives it
> currently.

As it turns out, systemd does *not* ignore SIGPWR.  Instead, it will
initiate the sigpwr target.  From the systemd.special man page:

       sigpwr.target
           A special target that is started when systemd receives the
           SIGPWR process signal, which is normally sent by the kernel
           or UPS daemons when power fails.

And child processes of systemd are not ignoring SIGPWR.  Instead, they
are getting terminated.

<tytso@cwcc>
41% /bin/sleep 50 &
[1] 180671
<tytso@cwcc>
42% kill -PWR 180671
[1]+  Power failure           /bin/sleep 50

> Where I saw the last conversation falter was in making a persuasive
> case of why SIGINFO was interesting to add.  Given a world of ssh
> connections I expect a persuasive case can be made.  Especially if there
> are a handful of utilities where it is already implemented that just
> need to be built with SIGINFO defined.

One thing that's perhaps worth disentangling is the value of
supporting VSTATUS --- which is a control character much like VINTR
(^C) or VQUIT (control backslash) which is set via the c_cc[] array in
termios structure.  Quoting from the termios man page:

       VSTATUS
              (not in POSIX; not supported under Linux; status
              request: 024, DC4, Ctrl-T).  Status character (STATUS).
              Display status information at terminal, including state
              of foreground process and amount of CPU time it has
              consumed.  Also sends a SIGINFO signal (not supported on
              Linux) to the foreground process group.

The basic idea is that when you type C-t, you can find out information
about the currently running process.  This is a feature that
originally comes from TOPS-10's TENEX operating system, and it is
supported today on FreeBSD and Mac OS.  For example, it might display
something like this:

load: 2.39  cmd: ping 5374 running 0.00u 0.00s

The reason why SIGINFO is sent to the foreground process group is that
it gives the process an opportunity print application specific
information about currently running process.  For example, maybe the C
compiler could print something like "parsing 2042 of 5000 header
files", or some such.  :-)

There are people who wish that Linux supported Control-T / VSTATUS,
for example, just last week, on TUHS, the Unix greybeards list, there
were two such heartfelt wishes for Control-T support from two such
greybeards:

    "It's my biggest annoyance with Linux that it doesn't [support
    control-t]
    - https://minnie.tuhs.org/pipermail/tuhs/2021-December/024849.html

    "I personally can't stand using Linux, even casually for a very
     short sys-admin task, because of this missing feature"
    - https://minnie.tuhs.org/pipermail/tuhs/2021-December/024898.html

I claim, though, that we could implement VSTATUS without implenting
the SIGINFO part of the feature.  Previous few applications *ever*
implemented SIGINFO signal handlers so they could give status
information, it's the hard one, since we don't have any spare signals
left.  If we were to repurpose some lesser used signal, whether it be
SIGPWR, SIGLOST, or SIGSTKFLT, the danger is that there might be some
userspace program (such as a UPS monitoring program which wants to
trigger power fail handling, or a userspace NFSv4 process that wants
to signal that it was unable to recover a file's file lock after a
server reboot), and if we try to take over the signal assignment, it's
possible that we might get surprised.  Furthermore, all of the
possibly unused signals that we might try to reclaim terminate the
process by default, and SIGINFO *has* to have a default signal
handling action of Ignore, since otherwise typing Control-T will end
up killing the current foreground application.

Personally, I don't care all that much about VSTATUS support --- I
used it when I was in university, but honestly, I've never missed it.
But if there is someone who wants to try to implement VSTATUS, and
make some Unix greybeards happy, and maybe even switch from FreeBSD to
Linux as a result, go wild.  I'm not convinced, though, that adding
the SIGINFO part of the support is worth the effort.

Not only do almost no programs implement SIGINFO support, a lot of CPU
bound programs where this might be actually useful, end up running a
large number of processes in parallel.  Take the "parsing 2042 of 5000
header files" example I gave above.  Consider what would happen if gcc
implemented support for SIGINFO, but the user was running a "make -j
16" and typed Control-T.   The result would be chaos!

So if you really miss Control-T, and it's the only thing holding back
a few FreeBSD users from Linux, I don't see the problem with
implementing that part of the feature.  Why not just do the easy part
of the feature which is perhaps 5% of the work, and might provide 99%
of the benefit (at least for those people who care).

> Without seeing the persuasive case for more signals I have to say that
> adding more signals to the kernel sounds like a bad idea.

Concur, 100%.

						- Ted
