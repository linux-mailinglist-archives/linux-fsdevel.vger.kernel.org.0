Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212B473E405
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjFZP4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 11:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFZP4g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:56:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6B294;
        Mon, 26 Jun 2023 08:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F46A60EE0;
        Mon, 26 Jun 2023 15:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04E3C433C0;
        Mon, 26 Jun 2023 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687794993;
        bh=WarwMhCBqmpJZsSLoUnPJxtPhha9dRm5G2gDAXP2dZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDtc8rHb4Iox3X/oSbx5sqa4OZNK2ZUEd+24hnasMMqSLb80qYIq+2C1t1umhl0d2
         SlEyWWk4yGO5C6ynvvYAfZBf6gKdkaeRB40ab/LEPJIqDJLLuRvtP5ip3Nb+yy5ivX
         9jzGGNgWGuuo9ALUhqGfh/w2WrLDq3653HknpYSaO9z3rokv/aqreR5ZVQtBKK8lL4
         eIF13RWe+Tan4scB/VF19Tfj0aVqAQwQbH/I7sDgaSJIRsXic1rNLWrVT+zz4PuiRh
         BF7piDf2vKZhbr5LXKEk++dmr5Ae1QXc4OxVPWXyZ2WK2RWavvx4FSNrTInrO5rFaL
         +W1fEztNf2L8g==
Date:   Mon, 26 Jun 2023 17:56:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read
 side?)
Message-ID: <20230626-fazit-campen-d54e428aa4d6@brauner>
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner>
 <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 01:59:07PM +0200, Ahelenia Ziemiańska wrote:
> On Mon, Jun 26, 2023 at 11:32:16AM +0200, Christian Brauner wrote:
> > On Mon, Jun 26, 2023 at 03:12:09AM +0200, Ahelenia Ziemiańska wrote:
> > > Hi! (starting with get_maintainers.pl fs/splice.c,
> > >      idk if that's right though)
> > > 
> > > Per fs/splice.c:
> > >  * The traditional unix read/write is extended with a "splice()" operation
> > >  * that transfers data buffers to or from a pipe buffer.
> > > so I expect splice() to work just about the same as read()/write()
> > > (and, to a large extent, it does so).
> > > 
> > > Thus, a refresher on pipe read() semantics
> > > (quoting Issue 8 Draft 3; Linux when writing with write()):
> > > 60746  When attempting to read from an empty pipe or FIFO:
> > > 60747  • If no process has the pipe open for writing, read( ) shall return 0 to indicate end-of-file.
> > > 60748  • If some process has the pipe open for writing and O_NONBLOCK is set, read( ) shall return
> > > 60749    −1 and set errno to [EAGAIN].
> > > 60750  • If some process has the pipe open for writing and O_NONBLOCK is clear, read( ) shall
> > > 60751    block the calling thread until some data is written or the pipe is closed by all processes that
> > > 60752    had the pipe open for writing.
> > > 
> > > However, I've observed that this is not the case when splicing from
> > > something that sleeps on read to a pipe, and that in that case all
> > > readers block, /including/ ones that are reading from fds with
> > > O_NONBLOCK set!
> > > 
> > > As an example, consider these two programs:
> > > -- >8 --
> > > // wr.c
> > > #define _GNU_SOURCE
> > > #include <fcntl.h>
> > > #include <stdio.h>
> > > int main() {
> > >   while (splice(0, 0, 1, 0, 128 * 1024 * 1024, 0) > 0)
> > >     ;
> > >   fprintf(stderr, "wr: %m\n");
> > > }
> > > -- >8 --
> > > 
> > > -- >8 --
> > > // rd.c
> > > #define _GNU_SOURCE
> > > #include <errno.h>
> > > #include <fcntl.h>
> > > #include <stdio.h>
> > > #include <unistd.h>
> > > int main() {
> > >   fcntl(0, F_SETFL, fcntl(0, F_GETFL) | O_NONBLOCK);
> > > 
> > >   char buf[64 * 1024] = {};
> > >   for (ssize_t rd;;) {
> > > #if 1
> > >     while ((rd = read(0, buf, sizeof(buf))) == -1 && errno == EINTR)
> > >       ;
> > > #else
> > >     while ((rd = splice(0, 0, 1, 0, 128 * 1024 * 1024, 0)) == -1 &&
> > >            errno == EINTR)
> > >       ;
> > > #endif
> > >     fprintf(stderr, "rd=%zd: %m\n", rd);
> > >     write(1, buf, rd);
> > > 
> > >     errno = 0;
> > >     sleep(1);
> > >   }
> > > }
> > > -- >8 --
> > > 
> > > Thus:
> > > -- >8 --
> > > a$ make rd wr
> > > a$ mkfifo fifo
> > > a$ ./rd < fifo                           b$ echo qwe > fifo
> > > rd=4: Success
> > > qwe
> > > rd=0: Success
> > > rd=0: Success                            b$ sleep 2 > fifo
> > > rd=-1: Resource temporarily unavailable
> > > rd=-1: Resource temporarily unavailable
> > > rd=0: Success
> > > rd=0: Success                            
> > > rd=-1: Resource temporarily unavailable  b$ /bin/cat > fifo
> > > rd=-1: Resource temporarily unavailable
> > > rd=4: Success                            abc
> > > abc
> > > rd=-1: Resource temporarily unavailable
> > > rd=4: Success                            def
> > > def
> > > rd=0: Success                            ^D
> > > rd=0: Success
> > > rd=0: Success                            b$ ./wr > fifo
> > > -- >8 --
> > > and nothing. Until you actually type a line (or a few) into teletype b
> > > so that the splice completes, at which point so does the read.
> > > 
> > > An even simpler case is 
> > > -- >8 --
> > > $ ./wr | ./rd
> > > abc
> > > def
> > > rd=8: Success
> > > abc
> > > def
> > > ghi
> > > jkl
> > > rd=8: Success
> > > ghi
> > > jkl
> > > ^D
> > > wr: Success
> > > rd=-1: Resource temporarily unavailable
> > > rd=0: Success
> > > rd=0: Success
> > > -- >8 --
> > > 
> > > splice flags don't do anything.
> > > Tested on bookworm (6.1.27-1) and Linus' HEAD (v6.4-rc7-234-g547cc9be86f4).
> > > 
> > > You could say this is a "denial of service", since this is a valid
> > > way of following pipes (and, sans SIGIO, the only portable one),
> > splice() may block for any of the two file descriptors if they don't
> > have O_NONBLOCK set even if SPLICE_F_NONBLOCK is raised.
> > 
> > SPLICE_F_NONBLOCK in splice_file_to_pipe() is only relevant if the pipe
> > is full. If the pipe isn't full then the write is attempted. That of
> > course involves reading the data to splice from the source file. If the
> > source file isn't O_NONBLOCK that read may block holding pipe_lock().
> > 
> > If you raise O_NONBLOCK on the source fd in wr.c then your problems go
> > away. This is pretty long-standing behavior.
> I don't see how this is relevant here. Whether the writer splice blocks
> ‒ or how it behaves at all ‒ doesn't matter.
> 
> The /reader/ demands non-blocking reads. Just by running a splice()
> we've managed to permanently hang the reader in a way that's fully
> impervious to everything.
> 
> Actually, hold that: in testing this on an actual program that relies on
> this (nullmailer), I've found that trying to /open the FIFO/ also hangs
> forever, in that same signal-impervious state.
> 
> To wit:
>   $ ps 3766
>     PID TTY      STAT   TIME COMMAND
>    3766 ?        Ss     0:01 /usr/sbin/nullmailer-send
>   $ ls -l /proc/3766/fd
>   total 0
>   lr-x------ 1 mail mail 64 Jun 14 15:03 0 -> /dev/null
>   lrwx------ 1 mail mail 64 Jun 14 15:03 1 -> 'socket:[81721760]'
>   lrwx------ 1 mail mail 64 Jun 14 15:03 2 -> 'socket:[81721760]'
>   lr-x------ 1 mail mail 64 Apr 28 15:38 3 -> 'pipe:[81721763]'
>   l-wx------ 1 mail mail 64 Jun 14 15:03 4 -> 'pipe:[81721763]'
>   lr-x------ 1 mail mail 64 Jun 14 15:03 5 -> /var/spool/nullmailer/trigger
>   lrwx------ 1 mail mail 64 Jun 14 15:03 9 -> /dev/null
>   # cat /proc/3766/fdinfo/5
>   pos:    0
>   flags:  0104000
>   mnt_id: 64
>   ino:    393969
>   # < /proc/3766/fdinfo/5 fdinfo
>   O_RDONLY        O_NONBLOCK O_LARGEFILE
>   # strace -yp 3766 &
>   strace: Process 3766 attached
>   $ strace out/cmd/cat > /var/spool/nullmailer/trigger
>   [cat] (normal libc setup)
>   [cat] splice(0, NULL, 1, NULL, 134217728, SPLICE_F_MOVE|SPLICE_F_MOREa
>   [cat] ) = 2
>   [cat] splice(0, NULL, 1, NULL, 134217728, SPLICE_F_MOVE|SPLICE_F_MORE
>   [nullmailer] pselect6(6, [5</var/spool/nullmailer/trigger>], NULL, NULL, {tv_sec=86397, tv_nsec=624894145}, NULL) = 1 (in [5], left {tv_sec=86394, tv_nsec=841299215})
>   [nullmailer] write(1<socket:[81721760]>, "Trigger pulled.\n", 16) = 16
>   [nullmailer] read(5</var/spool/nullmailer/trigger>,
> and
>   $ strace -y sh -c 'echo zupa > /var/spool/nullmailer/trigger'
>   (...whatever shell setup)
>   rt_sigaction(SIGTERM, {sa_handler=SIG_DFL, sa_mask=~[RTMIN RT_1], sa_flags=SA_RESTORER, sa_restorer=0xf7d21bb0}, NULL, 8) = 0
>   openat(AT_FDCWD, "/var/spool/nullmailer/trigger", O_WRONLY|O_CREAT|O_TRUNC, 0666
> 
> This is a "you've lost" situation to me. This system will /never/
> send mail now, and any mailer program will also hang forever
> (again, to wit:
>    # echo zupa | strace -yfo /tmp/ss mail root
>  does hang forever and /tmp/ss ends in
>    16915 close(6</var/spool/nullmailer/queue>) = 0
>    16915 unlink("/var/spool/nullmailer/tmp/16915") = 0
>    16915 openat(AT_FDCWD, "/var/spool/nullmailer/trigger", O_WRONLY|O_NONBLOCK
>  )
> which means that, on this system, I will never get events from smartd
> or ZED, so fuck me if I wanted to get "scrub errored" or "disk
> will die soon" notifications (in pre-2.0.0 ZED this would also have
>  broken autoreplace=on since it waited synchronously),
> or from other monitoring, so again fuck me if I wanted to get
> overheating/packet drops/whatever notifications,
> or again fuck me if I wanted to get cron mail.
> In many ways I've brought the system down (or will have done in like a
> day once some mails go out) by sending a mail weird.
> 
> 
> Naturally systemd stopping nullmailer failed after a few minutes with
>   × nullmailer.service - Nullmailer relay-only MTA
>        Loaded: loaded (/lib/systemd/system/nullmailer.service; enabled; preset: enabled)
>        Active: failed (Result: timeout) since Mon 2023-06-26 13:10:02 CEST; 6min ago
>      Duration: 1month 4w 10h 55min 29.666s
>          Docs: man:nullmailer(7)
>      Main PID: 3766
>         Tasks: 1 (limit: 4673)
>        Memory: 3.1M
>           CPU: 1min 26.893s
>        CGroup: /system.slice/nullmailer.service
>                └─3766 /usr/sbin/nullmailer-send
>   
>   Jun 26 13:05:32 szarotka systemd[1]: nullmailer.service: State 'stop-sigterm' timed out. Killing.
>   Jun 26 13:05:32 szarotka systemd[1]: nullmailer.service: Killing process 3766 (nullmailer-send) with signal SIGKILL.
>   Jun 26 13:07:02 szarotka systemd[1]: nullmailer.service: Processes still around after SIGKILL. Ignoring.
>   Jun 26 13:08:32 szarotka systemd[1]: nullmailer.service: State 'final-sigterm' timed out. Killing.
>   Jun 26 13:08:32 szarotka systemd[1]: nullmailer.service: Killing process 3766 (nullmailer-send) with signal SIGKILL.
>   Jun 26 13:10:02 szarotka systemd[1]: nullmailer.service: Processes still around after final SIGKILL. Entering failed mode.
>   Jun 26 13:10:02 szarotka systemd[1]: nullmailer.service: Failed with result 'timeout'.
>   Jun 26 13:10:02 szarotka systemd[1]: nullmailer.service: Unit process 3766 (nullmailer-send) remains running after unit s>
>   Jun 26 13:10:02 szarotka systemd[1]: Stopped nullmailer.service - Nullmailer relay-only MTA.
>   Jun 26 13:10:02 szarotka systemd[1]: nullmailer.service: Consumed 1min 26.893s CPU time.
> 
> But not to fret! Maybe we can still kill it with the cgroup! No:
>   # strace -y sh -c 'echo 1 > /sys/fs/cgroup/system.slice/nullmailer.service/cgroup.kill'
>   ...
>   dup2(3</sys/fs/cgroup/system.slice/nullmailer.service/cgroup.kill>, 1) = 1</sys/fs/cgroup/system.slice/nullmailer.service/cgroup.kill>
>   close(3</sys/fs/cgroup/system.slice/nullmailer.service/cgroup.kill>) = 0
>   write(1</sys/fs/cgroup/system.slice/nullmailer.service/cgroup.kill>, "1\n", 2) = 2
>   ...
> This completes, sure, but doesn't do anything at all
> (admittedly, I'm not a cgroup expert, but it did work on other,
>  non-poisoned, cgroups, so I'd expect it to work).
> 
> Opening the FIFO with O_NONBLOCK also hangs, obviously.
> Killing the splicer restores order, as expected.
> 
> > Splice would have to be
> > refactored to not rely on pipe_lock(). That's likely major work with a
> > good portion of regressions if the past is any indication.
> That's likely; however, it ‒ or an equivalent solution ‒ would
> probably be a good idea to do, on balance of all my points above,
> I think.

In-kernel consumers already have a way of detecting when the pipe isn't
safe for non-blocking read anymore because splice has been called and
cleared FMODE_NOWAIT.

I mean, one workaround would probably be poll() even with O_NONBLOCK but
I get why that's annoying and half of a solution.

So there are three options afaict:

(1) rewrite splice.c to kill its reliance on pipe_lock()
    Very involved and would need a splice + pipe expert.
(2) Add pipe_lock_interruptible() to stop the bleeding and give
    userspace the ability to at least kill a hanging reader.
    Also a potentially sensitive change probably regression prone.
(3) Somehow factor in FMODE_NOWAIT when acquiring pipe_lock().
    If FMODE_NOWAIT is set, try to acquire the lock and if not report
    EAGAIN otherwise proceed as before. I think Jens proposed a version
    of this a while back.

Adding Linus as well since he probably has thoughts on this.
tl;dr it by splicing from a regular file to a pipe where the regular
file in splice isn't O_NONBLOCK we can hold pipe_lock() as long as we
want and hang pipe_read() even with O_NONBLOCK unkillable trying to
acquire pipe_lock().
