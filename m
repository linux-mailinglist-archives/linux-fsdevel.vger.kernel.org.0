Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B56487E8B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 22:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiAGVwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 16:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiAGVwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:52:37 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ED4C06173F
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jan 2022 13:52:37 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p13so20173706lfh.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jan 2022 13:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drummond.us; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PnXSJFSihRYvsgQqBY3XTyJfXwYqGTgNYopJeoVUvak=;
        b=XenP/t7xfc9uDjf35pRffSh+wRe9F3surMN62krC5kbed/h3Fxnexskp3H7oBFspEJ
         A5jZx7HttCpsKLVRM1a/Mqov2ukiiwtWRyN8n8Vd99NKQtO3XJCAnvQDWc3krEANu9aL
         TpiNxP9TxJ8OSoyZJXEquX3RWbjzAz7Lazp6vfoobdcpXCqvqKz5T0ZXzlGlcVwZhuao
         hvaemHyjmZCbL9/+t0jDyI1p96qGyNRl9GOJIEFtZRCiP0qABegGluNJ/4FpPmGiqzXP
         Rg84vltYTy4wwXdQoGf8O09UlqNO+Xx+E4PUAxeoH87EK0K+FOel6DBGt8/KrixQhecD
         8WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PnXSJFSihRYvsgQqBY3XTyJfXwYqGTgNYopJeoVUvak=;
        b=z6pYhLt1JZHbE8pxid//E7eYd2Y0Yl2m2n7yw35H3M9VCmpWtDajwAU3mSop9bQe53
         IJ7jXzVGCaQNHlvTORCCdKa3hdYDKmOGR2A1wLtT5k+C1Y069PuXcwBWblHafjFANRr6
         dAxkPGRYl3r4YfCNSvLYyEPyJrPU6RcIxrssPfzKNlF3Wqf0h1UohEIwqkWehjg0jfxJ
         eicSFnfGOlg643T4VGy1S0SqauBX1Zw6AKA/JnT4MUOPbJy0dhM4/oJ01AGlla56imoq
         dsyfxKr8jCtElQ1EQN2EeapcTKYyOe86Es2BrO5xwi+cCIm+Fmk7onj2R7VAfRvH2bh8
         m+6w==
X-Gm-Message-State: AOAM532Cr7Aeq+z+7ZHNfi1XhCiyErVDM4oAJHwcWH4Oa60QP6PAc9em
        Idw0joGfQNMkUaXQMzriBklidwAt3YeqGEzqzAiTHQ==
X-Google-Smtp-Source: ABdhPJxTIyTDUmfRlSPzm4fUeuZhCOeZxertXLMGGaTV/QaY5JZx8UMnvVTWn2yG5VSx12GoHBofLaarZieQ3GV95mQ=
X-Received: by 2002:a05:651c:4d3:: with SMTP id e19mr49467532lji.467.1641592355171;
 Fri, 07 Jan 2022 13:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20220103181956.983342-1-walt@drummond.us> <20220103181956.983342-9-walt@drummond.us>
 <Ydi1F3df2JIkDuMN@cello>
In-Reply-To: <Ydi1F3df2JIkDuMN@cello>
From:   Walt Drummond <walt@drummond.us>
Date:   Fri, 7 Jan 2022 13:52:23 -0800
Message-ID: <CADCN6nz5wOmzFExUVJZiXVOJH40852=Q=AimBAiEDXaSvxHwKw@mail.gmail.com>
Subject: Re: [RFC PATCH 8/8] signals: Support BSD VSTATUS, KERNINFO and SIGINFO
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 7, 2022 at 1:48 PM Arseny Maslennikov <ar@cs.msu.ru> wrote:
>
> On Mon, Jan 03, 2022 at 10:19:56AM -0800, Walt Drummond wrote:
> > Support TTY VSTATUS character, NOKERNINFO local control bit and the
> > signal SIGINFO, all as in 4.3BSD.
> >
> > Signed-off-by: Walt Drummond <walt@drummond.us>
> > ---
> >  arch/x86/include/asm/signal.h       |   2 +-
> >  arch/x86/include/uapi/asm/signal.h  |   4 +-
> >  drivers/tty/Makefile                |   2 +-
> >  drivers/tty/n_tty.c                 |  21 +++++
> >  drivers/tty/tty_io.c                |  10 ++-
> >  drivers/tty/tty_ioctl.c             |   4 +
> >  drivers/tty/tty_status.c            | 135 ++++++++++++++++++++++++++++
> >  fs/proc/array.c                     |  29 +-----
> >  include/asm-generic/termios.h       |   4 +-
> >  include/linux/sched.h               |  52 ++++++++++-
> >  include/linux/signal.h              |   4 +
> >  include/linux/tty.h                 |   8 ++
> >  include/uapi/asm-generic/ioctls.h   |   2 +
> >  include/uapi/asm-generic/signal.h   |   6 +-
> >  include/uapi/asm-generic/termbits.h |  34 +++----
> >  15 files changed, 264 insertions(+), 53 deletions(-)
> >  create mode 100644 drivers/tty/tty_status.c
> >
> > diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signa=
l.h
> > index d8e2efe6cd46..0a01877c11ab 100644
> > --- a/arch/x86/include/asm/signal.h
> > +++ b/arch/x86/include/asm/signal.h
> > @@ -8,7 +8,7 @@
> >  /* Most things should be clean enough to redefine this at will, if car=
e
> >     is taken to make libc match.  */
> >
> > -#define _NSIG                64
> > +#define _NSIG                65
> >
> >  #ifdef __i386__
> >  # define _NSIG_BPW   32
> > diff --git a/arch/x86/include/uapi/asm/signal.h b/arch/x86/include/uapi=
/asm/signal.h
> > index 164a22a72984..60dca62d3dcf 100644
> > --- a/arch/x86/include/uapi/asm/signal.h
> > +++ b/arch/x86/include/uapi/asm/signal.h
> > @@ -60,7 +60,9 @@ typedef unsigned long sigset_t;
> >
> >  /* These should not be considered constants from userland.  */
> >  #define SIGRTMIN     32
> > -#define SIGRTMAX     _NSIG
> > +#define SIGRTMAX     64
> > +
> > +#define SIGINFO              65
> >
> >  #define SA_RESTORER  0x04000000
> >
> > diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> > index a2bd75fbaaa4..d50ba690bb87 100644
> > --- a/drivers/tty/Makefile
> > +++ b/drivers/tty/Makefile
> > @@ -2,7 +2,7 @@
> >  obj-$(CONFIG_TTY)            +=3D tty_io.o n_tty.o tty_ioctl.o tty_ldi=
sc.o \
> >                                  tty_buffer.o tty_port.o tty_mutex.o \
> >                                  tty_ldsem.o tty_baudrate.o tty_jobctrl=
.o \
> > -                                n_null.o
> > +                                n_null.o tty_status.o
> >  obj-$(CONFIG_LEGACY_PTYS)    +=3D pty.o
> >  obj-$(CONFIG_UNIX98_PTYS)    +=3D pty.o
> >  obj-$(CONFIG_AUDIT)          +=3D tty_audit.o
> > diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> > index 0ec93f1a61f5..b510e01289fd 100644
> > --- a/drivers/tty/n_tty.c
> > +++ b/drivers/tty/n_tty.c
> > @@ -1334,6 +1334,24 @@ static void n_tty_receive_char_special(struct tt=
y_struct *tty, unsigned char c)
> >                       commit_echoes(tty);
> >                       return;
> >               }
> > +#ifdef VSTATUS
> > +             if (c =3D=3D STATUS_CHAR(tty)) {
> > +                     /* Do the status message first and then send
> > +                      * the signal, otherwise signal delivery can
> > +                      * change the process state making the status
> > +                      * message misleading.  Also, use __isig() and
> > +                      * not sig(), as if we flush the tty we can
> > +                      * lose parts of the message.
>
> ...As well as the character input in the canonical mode's built-in line
> editor.
>

Yes, good catch.  But this is not going to be in the next version of the pa=
tch.

> > +                      */
> > +
> > +                     if (!L_NOKERNINFO(tty))
> > +                             tty_status(tty);
> > +# if defined(SIGINFO) && SIGINFO !=3D SIGPWR
> > +                     __isig(SIGINFO, tty);
> > +# endif
> > +                     return;
> > +             }
> > +#endif       /* VSTATUS */
> >               if (c =3D=3D '\n') {
> >                       if (L_ECHO(tty) || L_ECHONL(tty)) {
> >                               echo_char_raw('\n', ldata);
> > @@ -1763,6 +1781,9 @@ static void n_tty_set_termios(struct tty_struct *=
tty, struct ktermios *old)
> >                       set_bit(EOF_CHAR(tty), ldata->char_map);
> >                       set_bit('\n', ldata->char_map);
> >                       set_bit(EOL_CHAR(tty), ldata->char_map);
> > +#ifdef VSTATUS
> > +                     set_bit(STATUS_CHAR(tty), ldata->char_map);
> > +#endif
> >                       if (L_IEXTEN(tty)) {
> >                               set_bit(WERASE_CHAR(tty), ldata->char_map=
);
> >                               set_bit(LNEXT_CHAR(tty), ldata->char_map)=
;
> > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > index 6616d4a0d41d..8e488ecba330 100644
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -120,18 +120,26 @@
> >  #define TTY_PARANOIA_CHECK 1
> >  #define CHECK_TTY_COUNT 1
> >
> > +/* Less ugly than an ifdef in the middle of the initalizer below, mayb=
e? */
> > +#ifdef NOKERNINFO
> > +# define __NOKERNINFO NOKERNINFO
> > +#else
> > +# define __NOKERNINFO 0
> > +#endif
> > +
> >  struct ktermios tty_std_termios =3D {  /* for the benefit of tty drive=
rs  */
> >       .c_iflag =3D ICRNL | IXON,
> >       .c_oflag =3D OPOST | ONLCR,
> >       .c_cflag =3D B38400 | CS8 | CREAD | HUPCL,
> >       .c_lflag =3D ISIG | ICANON | ECHO | ECHOE | ECHOK |
> > -                ECHOCTL | ECHOKE | IEXTEN,
> > +                ECHOCTL | ECHOKE | IEXTEN | __NOKERNINFO,
> >       .c_cc =3D INIT_C_CC,
> >       .c_ispeed =3D 38400,
> >       .c_ospeed =3D 38400,
> >       /* .c_line =3D N_TTY, */
> >  };
> >  EXPORT_SYMBOL(tty_std_termios);
> > +#undef __NOKERNINFO
> >
> >  /* This list gets poked at by procfs and various bits of boot up code.=
 This
> >   * could do with some rationalisation such as pulling the tty proc fun=
ction
> > diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> > index 507a25d692bb..b250eabca1ba 100644
> > --- a/drivers/tty/tty_ioctl.c
> > +++ b/drivers/tty/tty_ioctl.c
> > @@ -809,6 +809,10 @@ int tty_mode_ioctl(struct tty_struct *tty, struct =
file *file,
> >               if (get_user(arg, (unsigned int __user *) arg))
> >                       return -EFAULT;
> >               return tty_change_softcar(real_tty, arg);
> > +#ifdef TIOCSTAT
> > +     case TIOCSTAT:
> > +             return tty_status(real_tty);
> > +#endif
> >       default:
> >               return -ENOIOCTLCMD;
> >       }
> > diff --git a/drivers/tty/tty_status.c b/drivers/tty/tty_status.c
> > new file mode 100644
>
> Nitpick: the new functionality is part of n_tty and not the generic tty
> subsystem, so "tty_status.c" is a misleading name for the new file,
> unlike e. g. "n_tty_status.c". It has no use in the various modem
> drivers, for example.
> Likewise for the tty_status() function.

ACK, will do.

>
> > index 000000000000..a9600f5bd48c
> > --- /dev/null
> > +++ b/drivers/tty/tty_status.c
> > @@ -0,0 +1,135 @@
> > +// SPDX-License-Identifier: GPL-1.0+
> > +/*
> > + * tty_status.c --- implements VSTATUS and TIOCSTAT from BSD4.3/4.4
> > + *
> > + */
> > +
> > +#include <linux/sched.h>
> > +#include <linux/mm.h>
> > +#include <linux/tty.h>
> > +#include <linux/sched/cputime.h>
> > +#include <linux/sched/loadavg.h>
> > +#include <linux/pid.h>
> > +#include <linux/slab.h>
> > +#include <linux/math64.h>
> > +
> > +#define MSGLEN (160 + TASK_COMM_LEN)
> > +
> > +inline unsigned long getRSSk(struct mm_struct *mm)
> > +{
> > +     if (mm =3D=3D NULL)
> > +             return 0;
> > +     return get_mm_rss(mm) * PAGE_SIZE / 1024;
> > +}
> > +
> > +inline long nstoms(long l)
> > +{
> > +     l /=3D NSEC_PER_MSEC * 10;
> > +     if (l < 10)
> > +             l *=3D 10;
> > +     return l;
> > +}
> > +
> > +inline struct task_struct *compare(struct task_struct *new,
> > +                                struct task_struct *old)
> > +{
> > +     unsigned int ostate, nstate;
> > +
> > +     if (old =3D=3D NULL)
> > +             return new;
> > +
> > +     ostate =3D task_state_index(old);
> > +     nstate =3D task_state_index(new);
> > +
> > +     if (ostate =3D=3D nstate) {
> > +             if (old->start_time > new->start_time)
> > +                     return old;
> > +             return new;
> > +     }
> > +
> > +     if (ostate < nstate)
> > +             return old;
> > +
> > +     return new;
> > +}
> > +
> > +struct task_struct *pick_process(struct pid *pgrp)
> > +{
> > +     struct task_struct *p, *winner =3D NULL;
> > +
> > +     read_lock(&tasklist_lock);
> > +     do_each_pid_task(pgrp, PIDTYPE_PGID, p) {
> > +             winner =3D compare(p, winner);
> > +     } while_each_pid_task(pgrp, PIDTYPE_PGID, p);
> > +     read_unlock(&tasklist_lock);
> > +
> > +     return winner;
> > +}
> > +
> > +int tty_status(struct tty_struct *tty)
> > +{
> > +     char tname[TASK_COMM_LEN];
> > +     unsigned long loadavg[3];
> > +     uint64_t pcpu, cputime, wallclock;
> > +     struct task_struct *p;
> > +     struct rusage rusage;
> > +     struct timespec64 utime, stime, rtime;
> > +     char msg[MSGLEN] =3D {0};
> > +     int len =3D 0;
> > +
> > +     if (tty =3D=3D NULL)
> > +             return -ENOTTY;
> > +
> > +     get_avenrun(loadavg, FIXED_1/200, 0);
> > +     len +=3D scnprintf((char *)&msg[len], MSGLEN - len, "load: %lu.%0=
2lu  ",
> > +                    LOAD_INT(loadavg[0]), LOAD_FRAC(loadavg[0]));
> > +
> > +     if (tty->ctrl.session =3D=3D NULL) {
> > +             len +=3D scnprintf((char *)&msg[len], MSGLEN - len,
> > +                              "not a controlling terminal");
> > +             goto print;
> > +     }
> > +
> > +     if (tty->ctrl.pgrp =3D=3D NULL) {
> > +             len +=3D scnprintf((char *)&msg[len], MSGLEN - len,
> > +                              "no foreground process group");
> > +             goto print;
> > +     }
> > +
> > +     p =3D pick_process(tty->ctrl.pgrp);
> > +     if (p =3D=3D NULL) {
> > +             len +=3D scnprintf((char *)&msg[len], MSGLEN - len,
> > +                              "empty foreground process group");
> > +             goto print;
> > +     }
> > +
> > +     get_task_comm(tname, p);
> > +     getrusage(p, RUSAGE_BOTH, &rusage);
> > +     wallclock =3D ktime_get_ns() - p->start_time;
> > +
> > +     utime.tv_sec =3D rusage.ru_utime.tv_sec;
> > +     utime.tv_nsec =3D rusage.ru_utime.tv_usec * NSEC_PER_USEC;
> > +     stime.tv_sec =3D rusage.ru_stime.tv_sec;
> > +     stime.tv_nsec =3D rusage.ru_stime.tv_usec * NSEC_PER_USEC;
> > +     rtime =3D ns_to_timespec64(wallclock);
> > +
> > +     cputime =3D timespec64_to_ns(&utime) + timespec64_to_ns(&stime);
> > +     pcpu =3D div64_u64(cputime * 100, wallclock);
> > +
> > +     len +=3D scnprintf((char *)&msg[len], MSGLEN - len,
> > +                      /* task, PID, task state */
> > +                      "cmd: %s %d [%s] "
> > +                      /* rtime,    utime,      stime,      %cpu,  rss =
*/
> > +                      "%llu.%02lur %llu.%02luu %llu.%02lus %llu%% %luk=
",
> > +                      tname, task_pid_vnr(p), (char *)get_task_state_n=
ame(p),
> > +                      rtime.tv_sec, nstoms(rtime.tv_nsec),
> > +                      utime.tv_sec, nstoms(utime.tv_nsec),
> > +                      stime.tv_sec, nstoms(stime.tv_nsec),
> > +                      pcpu, getRSSk(p->mm));
> > +
> > +print:
> > +     len +=3D scnprintf((char *)&msg[len], MSGLEN - len, "\r\n");
> > +     tty_write_message(tty, msg);
>
> tty_write_message() is quite risky to use; while writing my
> implementation a couple of years ago I've found it easy to accidentally
> set up deadlocks with this interface =E2=80=94 in particular if the funct=
ion is
> called from the tty character receive path.
> I hope you're testing the functionality with CONFIG_PROVE_LOCKING enabled=
.

I have not, but I will.

Is there a different 'put a message on this tty' api I should be using?

Thanks.

>
> > +
> > +     return 0;
> > +}
> > diff --git a/fs/proc/array.c b/fs/proc/array.c
> > index f37c03077b58..eb14306cdde2 100644
> > --- a/fs/proc/array.c
> > +++ b/fs/proc/array.c
> > @@ -62,6 +62,7 @@
> >  #include <linux/tty.h>
> >  #include <linux/string.h>
> >  #include <linux/mman.h>
> > +#include <linux/sched.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/sched/numa_balancing.h>
> >  #include <linux/sched/task_stack.h>
> > @@ -111,34 +112,6 @@ void proc_task_name(struct seq_file *m, struct tas=
k_struct *p, bool escape)
> >               seq_printf(m, "%.64s", tcomm);
> >  }
> >
> > -/*
> > - * The task state array is a strange "bitmap" of
> > - * reasons to sleep. Thus "running" is zero, and
> > - * you can test for combinations of others with
> > - * simple bit tests.
> > - */
> > -static const char * const task_state_array[] =3D {
> > -
> > -     /* states in TASK_REPORT: */
> > -     "R (running)",          /* 0x00 */
> > -     "S (sleeping)",         /* 0x01 */
> > -     "D (disk sleep)",       /* 0x02 */
> > -     "T (stopped)",          /* 0x04 */
> > -     "t (tracing stop)",     /* 0x08 */
> > -     "X (dead)",             /* 0x10 */
> > -     "Z (zombie)",           /* 0x20 */
> > -     "P (parked)",           /* 0x40 */
> > -
> > -     /* states beyond TASK_REPORT: */
> > -     "I (idle)",             /* 0x80 */
> > -};
> > -
> > -static inline const char *get_task_state(struct task_struct *tsk)
> > -{
> > -     BUILD_BUG_ON(1 + ilog2(TASK_REPORT_MAX) !=3D ARRAY_SIZE(task_stat=
e_array));
> > -     return task_state_array[task_state_index(tsk)];
> > -}
> > -
> >  static inline void task_state(struct seq_file *m, struct pid_namespace=
 *ns,
> >                               struct pid *pid, struct task_struct *p)
> >  {
> > diff --git a/include/asm-generic/termios.h b/include/asm-generic/termio=
s.h
> > index b1398d0d4a1d..9b080e1a82d4 100644
> > --- a/include/asm-generic/termios.h
> > +++ b/include/asm-generic/termios.h
> > @@ -10,9 +10,9 @@
> >       eof=3D^D          vtime=3D\0        vmin=3D\1         sxtc=3D\0
> >       start=3D^Q        stop=3D^S         susp=3D^Z         eol=3D\0
> >       reprint=3D^R      discard=3D^U      werase=3D^W       lnext=3D^V
> > -     eol2=3D\0
> > +     eol2=3D\0         status=3D^T
> >  */
> > -#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\02=
7\026\0"
> > +#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\02=
7\026\0\024"
> >
> >  /*
> >   * Translate a "termio" structure into a "termios". Ugh.
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index c1a927ddec64..2171074ec8f5 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -70,7 +70,7 @@ struct task_group;
> >
> >  /*
> >   * Task state bitmask. NOTE! These bits are also
> > - * encoded in fs/proc/array.c: get_task_state().
> > + * encoded in get_task_state().
> >   *
> >   * We have two separate sets of flags: task->state
> >   * is about runnability, while task->exit_state are
> > @@ -1643,6 +1643,56 @@ static inline char task_state_to_char(struct tas=
k_struct *tsk)
> >       return task_index_to_char(task_state_index(tsk));
> >  }
> >
> > +static inline const char *get_task_state_name(struct task_struct *tsk)
> > +{
> > +     static const char * const task_state_array[] =3D {
> > +
> > +             /* states in TASK_REPORT: */
> > +             "running",              /* 0x00 */
> > +             "sleeping",             /* 0x01 */
> > +             "disk sleep",           /* 0x02 */
> > +             "stopped",              /* 0x04 */
> > +             "tracing stop",         /* 0x08 */
> > +             "dead",                 /* 0x10 */
> > +             "zombie",               /* 0x20 */
> > +             "parked",               /* 0x40 */
> > +
> > +             /* states beyond TASK_REPORT: */
> > +             "idle",                 /* 0x80 */
> > +     };
> > +
> > +     BUILD_BUG_ON(1 + ilog2(TASK_REPORT_MAX) !=3D ARRAY_SIZE(task_stat=
e_array));
> > +     return task_state_array[task_state_index(tsk)];
> > +}
> > +
> > +static inline const char *get_task_state(struct task_struct *tsk)
> > +{
> > +     /*
> > +      * The task state array is a strange "bitmap" of
> > +      * reasons to sleep. Thus "running" is zero, and
> > +      * you can test for combinations of others with
> > +      * simple bit tests.
> > +      */
> > +     static const char * const task_state_array[] =3D {
> > +
> > +             /* states in TASK_REPORT: */
> > +             "R (running)",          /* 0x00 */
> > +             "S (sleeping)",         /* 0x01 */
> > +             "D (disk sleep)",       /* 0x02 */
> > +             "T (stopped)",          /* 0x04 */
> > +             "t (tracing stop)",     /* 0x08 */
> > +             "X (dead)",             /* 0x10 */
> > +             "Z (zombie)",           /* 0x20 */
> > +             "P (parked)",           /* 0x40 */
> > +
> > +             /* states beyond TASK_REPORT: */
> > +             "I (idle)",             /* 0x80 */
> > +     };
> > +
> > +     BUILD_BUG_ON(1 + ilog2(TASK_REPORT_MAX) !=3D ARRAY_SIZE(task_stat=
e_array));
> > +     return task_state_array[task_state_index(tsk)];
> > +}
> > +
> >  /**
> >   * is_global_init - check if a task structure is init. Since init
> >   * is free to have sub-threads we need to check tgid.
> > diff --git a/include/linux/signal.h b/include/linux/signal.h
> > index b77f9472a37c..76bda1a20578 100644
> > --- a/include/linux/signal.h
> > +++ b/include/linux/signal.h
> > @@ -541,6 +541,7 @@ extern bool unhandled_signal(struct task_struct *ts=
k, int sig);
> >   *   |  non-POSIX signal  |  default action  |
> >   *   +--------------------+------------------+
> >   *   |  SIGEMT            |  coredump        |
> > + *   |  SIGINFO           |  ignore          |
> >   *   +--------------------+------------------+
> >   *
> >   * (+) For SIGKILL and SIGSTOP the action is "always", not just "defau=
lt".
> > @@ -567,6 +568,9 @@ static inline int sig_kernel_ignore(unsigned long s=
ig)
> >       return  sig =3D=3D SIGCONT  ||
> >               sig =3D=3D SIGCHLD  ||
> >               sig =3D=3D SIGWINCH ||
> > +#if defined(SIGINFO) && SIGINFO !=3D SIGPWR
> > +             sig =3D=3D SIGINFO  ||
> > +#endif
> >               sig =3D=3D SIGURG;
> >  }
> >
> > diff --git a/include/linux/tty.h b/include/linux/tty.h
> > index 168e57e40bbb..943d85aa471c 100644
> > --- a/include/linux/tty.h
> > +++ b/include/linux/tty.h
> > @@ -49,6 +49,9 @@
> >  #define WERASE_CHAR(tty) ((tty)->termios.c_cc[VWERASE])
> >  #define LNEXT_CHAR(tty)      ((tty)->termios.c_cc[VLNEXT])
> >  #define EOL2_CHAR(tty) ((tty)->termios.c_cc[VEOL2])
> > +#ifdef VSTATUS
> > +#define STATUS_CHAR(tty) ((tty)->termios.c_cc[VSTATUS])
> > +#endif
> >
> >  #define _I_FLAG(tty, f)      ((tty)->termios.c_iflag & (f))
> >  #define _O_FLAG(tty, f)      ((tty)->termios.c_oflag & (f))
> > @@ -114,6 +117,9 @@
> >  #define L_PENDIN(tty)        _L_FLAG((tty), PENDIN)
> >  #define L_IEXTEN(tty)        _L_FLAG((tty), IEXTEN)
> >  #define L_EXTPROC(tty)       _L_FLAG((tty), EXTPROC)
> > +#ifdef NOKERNINFO
> > +#define L_NOKERNINFO(tty) _L_FLAG((tty), NOKERNINFO)
> > +#endif
> >
> >  struct device;
> >  struct signal_struct;
> > @@ -428,4 +434,6 @@ extern void tty_lock_slave(struct tty_struct *tty);
> >  extern void tty_unlock_slave(struct tty_struct *tty);
> >  extern void tty_set_lock_subclass(struct tty_struct *tty);
> >
> > +extern int tty_status(struct tty_struct *tty);
> > +
> >  #endif
> > diff --git a/include/uapi/asm-generic/ioctls.h b/include/uapi/asm-gener=
ic/ioctls.h
> > index cdc9f4ca8c27..baa2b8d42679 100644
> > --- a/include/uapi/asm-generic/ioctls.h
> > +++ b/include/uapi/asm-generic/ioctls.h
> > @@ -97,6 +97,8 @@
> >
> >  #define TIOCMIWAIT   0x545C  /* wait for a change on serial input line=
(s) */
> >  #define TIOCGICOUNT  0x545D  /* read serial port inline interrupt coun=
ts */
> > +/* Some architectures use 0x545E for FIOQSIZE */
> > +#define TIOCSTAT        0x545F       /* display process group stats on=
 tty */
> >
> >  /*
> >   * Some arches already define FIOQSIZE due to a historical
> > diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-gener=
ic/signal.h
> > index 3c4cc9b8378e..0b771eb1db94 100644
> > --- a/include/uapi/asm-generic/signal.h
> > +++ b/include/uapi/asm-generic/signal.h
> > @@ -4,7 +4,7 @@
> >
> >  #include <linux/types.h>
> >
> > -#define _NSIG                64
> > +#define _NSIG                65
> >  #define _NSIG_BPW    __BITS_PER_LONG
> >  #define _NSIG_WORDS  ((_NSIG + _NSIG_BPW - 1) / _NSIG_BPW)
> >
> > @@ -49,9 +49,11 @@
> >  /* These should not be considered constants from userland.  */
> >  #define SIGRTMIN     32
> >  #ifndef SIGRTMAX
> > -#define SIGRTMAX     _NSIG
> > +#define SIGRTMAX     64
> >  #endif
> >
> > +#define SIGINFO              65
> > +
> >  #if !defined MINSIGSTKSZ || !defined SIGSTKSZ
> >  #define MINSIGSTKSZ  2048
> >  #define SIGSTKSZ     8192
> > diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-gen=
eric/termbits.h
> > index 2fbaf9ae89dd..cb4e9c6d629f 100644
> > --- a/include/uapi/asm-generic/termbits.h
> > +++ b/include/uapi/asm-generic/termbits.h
> > @@ -58,6 +58,7 @@ struct ktermios {
> >  #define VWERASE 14
> >  #define VLNEXT 15
> >  #define VEOL2 16
> > +#define VSTATUS 17
> >
> >  /* c_iflag bits */
> >  #define IGNBRK       0000001
> > @@ -164,22 +165,23 @@ struct ktermios {
> >  #define IBSHIFT        16            /* Shift from CBAUD to CIBAUD */
> >
> >  /* c_lflag bits */
> > -#define ISIG 0000001
> > -#define ICANON       0000002
> > -#define XCASE        0000004
> > -#define ECHO 0000010
> > -#define ECHOE        0000020
> > -#define ECHOK        0000040
> > -#define ECHONL       0000100
> > -#define NOFLSH       0000200
> > -#define TOSTOP       0000400
> > -#define ECHOCTL      0001000
> > -#define ECHOPRT      0002000
> > -#define ECHOKE       0004000
> > -#define FLUSHO       0010000
> > -#define PENDIN       0040000
> > -#define IEXTEN       0100000
> > -#define EXTPROC      0200000
> > +#define ISIG    0000001
> > +#define ICANON          0000002
> > +#define XCASE           0000004
> > +#define ECHO    0000010
> > +#define ECHOE           0000020
> > +#define ECHOK           0000040
> > +#define ECHONL          0000100
> > +#define NOFLSH          0000200
> > +#define TOSTOP          0000400
> > +#define ECHOCTL         0001000
> > +#define ECHOPRT         0002000
> > +#define ECHOKE          0004000
> > +#define FLUSHO          0010000
> > +#define PENDIN          0040000
> > +#define IEXTEN          0100000
> > +#define EXTPROC         0200000
> > +#define NOKERNINFO 0400000
> >
> >  /* tcflow() and TCXONC use these */
> >  #define      TCOOFF          0
> > --
> > 2.30.2
> >
