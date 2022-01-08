Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18D44883FD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 15:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiAHOjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 09:39:16 -0500
Received: from mx.cs.msu.ru ([188.44.42.42]:49729 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229712AbiAHOjP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 09:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
        s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JXGuWor50f9l1ttv/JgH6pHlEePJgE3HyqFcNY6k+A4=; b=hOsllfbDpG6S1euyNJ38aCJ5cf
        8ui9u9w2GJTr3n9BBHOE/KiQki0sHMuomc7+XGVGnsjD2gpEqizc79qU6CjaxFTZwxaYCgzbMA/PL
        xh5BKfHr+H32z48lIg64M/v5b0T0QIYtGQyLIl3sRqUDPa31t9vI90zm0fud+zhui26exuYics563
        lkiuaeoMQS+i1VR/7iLSTVLj8vyycYhF25QHaQJCQqfC0un8hyIK9c/m9aPvpBvG3OLr9bS6oeGg0
        OwkSdurIIPrP46GOTvoViiBT5ddXSpajPLEW/uUMj11AnZRJn94quchrc5Q08fzaijJgAMdLGtOVA
        CFW6Gb2w==;
Received: from [37.204.119.143] (port=58130 helo=cello)
        by mail.cs.msu.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1n6Crc-000PsA-N5; Sat, 08 Jan 2022 17:38:38 +0300
Date:   Sat, 8 Jan 2022 17:38:33 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Walt Drummond <walt@drummond.us>
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
Message-ID: <Ydmh6aYogzJq2Ab4@cello>
References: <20220103181956.983342-1-walt@drummond.us>
 <20220103181956.983342-9-walt@drummond.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G2OjEObSrXwMKUEk"
Content-Disposition: inline
In-Reply-To: <20220103181956.983342-9-walt@drummond.us>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: Re: [RFC PATCH 8/8] signals: Support BSD VSTATUS, KERNINFO and
 SIGINFO
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: No (on mail.cs.msu.ru); Unknown failure
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--G2OjEObSrXwMKUEk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 03, 2022 at 10:19:56AM -0800, Walt Drummond wrote:
> Support TTY VSTATUS character, NOKERNINFO local control bit and the
> signal SIGINFO, all as in 4.3BSD.
>=20
> Signed-off-by: Walt Drummond <walt@drummond.us>
> ---
>  arch/x86/include/asm/signal.h       |   2 +-
>  arch/x86/include/uapi/asm/signal.h  |   4 +-
>  drivers/tty/Makefile                |   2 +-
>  drivers/tty/n_tty.c                 |  21 +++++
>  drivers/tty/tty_io.c                |  10 ++-
>  drivers/tty/tty_ioctl.c             |   4 +
>  drivers/tty/tty_status.c            | 135 ++++++++++++++++++++++++++++
>  fs/proc/array.c                     |  29 +-----
>  include/asm-generic/termios.h       |   4 +-
>  include/linux/sched.h               |  52 ++++++++++-
>  include/linux/signal.h              |   4 +
>  include/linux/tty.h                 |   8 ++
>  include/uapi/asm-generic/ioctls.h   |   2 +
>  include/uapi/asm-generic/signal.h   |   6 +-
>  include/uapi/asm-generic/termbits.h |  34 +++----
>  15 files changed, 264 insertions(+), 53 deletions(-)
>  create mode 100644 drivers/tty/tty_status.c
>=20
> <...>
>=20
> diff --git a/drivers/tty/tty_status.c b/drivers/tty/tty_status.c
> new file mode 100644
> index 000000000000..a9600f5bd48c
> --- /dev/null
> +++ b/drivers/tty/tty_status.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-1.0+
> +/*
> + * tty_status.c --- implements VSTATUS and TIOCSTAT from BSD4.3/4.4
> + *
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/mm.h>
> +#include <linux/tty.h>
> +#include <linux/sched/cputime.h>
> +#include <linux/sched/loadavg.h>
> +#include <linux/pid.h>
> +#include <linux/slab.h>
> +#include <linux/math64.h>
> +
> +#define MSGLEN (160 + TASK_COMM_LEN)
> +
> +inline unsigned long getRSSk(struct mm_struct *mm)
> +{
> +	if (mm =3D=3D NULL)
> +		return 0;
> +	return get_mm_rss(mm) * PAGE_SIZE / 1024;
> +}
> +
> +inline long nstoms(long l)
> +{
> +	l /=3D NSEC_PER_MSEC * 10;
> +	if (l < 10)
> +		l *=3D 10;
> +	return l;
> +}
> +
> +inline struct task_struct *compare(struct task_struct *new,
> +				   struct task_struct *old)
> +{
> +	unsigned int ostate, nstate;
> +
> +	if (old =3D=3D NULL)
> +		return new;
> +
> +	ostate =3D task_state_index(old);
> +	nstate =3D task_state_index(new);
> +
> +	if (ostate =3D=3D nstate) {
> +		if (old->start_time > new->start_time)
> +			return old;
> +		return new;
> +	}
> +
> +	if (ostate < nstate)
> +		return old;
> +
> +	return new;
> +}
> +
> +struct task_struct *pick_process(struct pid *pgrp)
> +{
> +	struct task_struct *p, *winner =3D NULL;
> +
> +	read_lock(&tasklist_lock);
> +	do_each_pid_task(pgrp, PIDTYPE_PGID, p) {
> +		winner =3D compare(p, winner);
> +	} while_each_pid_task(pgrp, PIDTYPE_PGID, p);
> +	read_unlock(&tasklist_lock);
> +
> +	return winner;
> +}
> +
> +int tty_status(struct tty_struct *tty)
> +{
> +	char tname[TASK_COMM_LEN];
> +	unsigned long loadavg[3];
> +	uint64_t pcpu, cputime, wallclock;
> +	struct task_struct *p;
> +	struct rusage rusage;
> +	struct timespec64 utime, stime, rtime;
> +	char msg[MSGLEN] =3D {0};
> +	int len =3D 0;
> +
> +	if (tty =3D=3D NULL)
> +		return -ENOTTY;
> +
> +	get_avenrun(loadavg, FIXED_1/200, 0);
> +	len +=3D scnprintf((char *)&msg[len], MSGLEN - len, "load: %lu.%02lu  ",
> +		       LOAD_INT(loadavg[0]), LOAD_FRAC(loadavg[0]));
> +
> +	if (tty->ctrl.session =3D=3D NULL) {
> +		len +=3D scnprintf((char *)&msg[len], MSGLEN - len,
> +				 "not a controlling terminal");
> +		goto print;
> +	}
> +
> +	if (tty->ctrl.pgrp =3D=3D NULL) {
> +		len +=3D scnprintf((char *)&msg[len], MSGLEN - len,
> +				 "no foreground process group");
> +		goto print;
> +	}
> +
> +	p =3D pick_process(tty->ctrl.pgrp);
> +	if (p =3D=3D NULL) {
> +		len +=3D scnprintf((char *)&msg[len], MSGLEN - len,
> +				 "empty foreground process group");
> +		goto print;
> +	}
> +
> +	get_task_comm(tname, p);
> +	getrusage(p, RUSAGE_BOTH, &rusage);
> +	wallclock =3D ktime_get_ns() - p->start_time;
> +
> +	utime.tv_sec =3D rusage.ru_utime.tv_sec;
> +	utime.tv_nsec =3D rusage.ru_utime.tv_usec * NSEC_PER_USEC;
> +	stime.tv_sec =3D rusage.ru_stime.tv_sec;
> +	stime.tv_nsec =3D rusage.ru_stime.tv_usec * NSEC_PER_USEC;
> +	rtime =3D ns_to_timespec64(wallclock);
> +
> +	cputime =3D timespec64_to_ns(&utime) + timespec64_to_ns(&stime);
> +	pcpu =3D div64_u64(cputime * 100, wallclock);
> +
> +	len +=3D scnprintf((char *)&msg[len], MSGLEN - len,
> +			 /* task, PID, task state */
> +			 "cmd: %s %d [%s] "
> +			 /* rtime,    utime,      stime,      %cpu,  rss */
> +			 "%llu.%02lur %llu.%02luu %llu.%02lus %llu%% %luk",
> +			 tname,	task_pid_vnr(p), (char *)get_task_state_name(p),

task_pid_vnr(p) returns the PID of p in the PID namespace of current:

  pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
                          struct pid_namespace *ns)
  {
          pid_t nr =3D 0;
 =20
          rcu_read_lock();
          if (!ns)
                  ns =3D task_active_pid_ns(current);
          nr =3D pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
          rcu_read_unlock();
 =20
          return nr;
  }
  struct pid_namespace *task_active_pid_ns(struct task_struct *tsk)
  {
          return ns_of_pid(task_pid(tsk));
  }
  static inline pid_t task_pid_vnr(struct task_struct *tsk)
  {
          return __task_pid_nr_ns(tsk, PIDTYPE_PID, NULL);=20
  }

At this point current is an arbitrary kernel worker thread, not p. Most
likely we need another helper function in <linux/sched.h>.

> +			 rtime.tv_sec, nstoms(rtime.tv_nsec),
> +			 utime.tv_sec, nstoms(utime.tv_nsec),
> +			 stime.tv_sec, nstoms(stime.tv_nsec),
> +			 pcpu, getRSSk(p->mm));
> +
> +print:
> +	len +=3D scnprintf((char *)&msg[len], MSGLEN - len, "\r\n");
> +	tty_write_message(tty, msg);
> +
> +	return 0;
> +}
>=20
> <...>
>=20
> --=20
> 2.30.2
>=20

--G2OjEObSrXwMKUEk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAmHZoeQACgkQ9dQjyAYL
01DFXRAAqtQ3pUMr1CyVc1L4sGYw+AUbWxmOErcknQ9qe4y8z899etA1UHHdhs04
GrEC9m4algClk2x4pYeZZFZu2SeoTtJMFeIp2cklLz4TQvtW/VOaGl1UR9bcZC/q
EW8+p5HTB7rpKQXy8M9ALN1A93qpcKXmV6kfQ0O26eznbnJPcTBNLA/2KK9BMkL9
F19zukFZ7eihul5Cl5no8BLidYWtgmi4gkCi4SKhQjp4YPrOB3jTomrj0D9DxbwF
YLyVuRYk8Ut61OIblsZ8mLZwvhgCzrVdAbGQh4rCPnOleqZOfpa7q+SkX4QIYOp6
Lke+nUj70GHsqH/3qzDURa87aRBusDmZPQeqeB+2ZN15mXmSQVvzIr3cUyAtLlcR
bkv0gNP+cZQp1YTmK20Mf3ylJjPDNsoHRGTjlTy/9E9OD6ZyEtdsPTbQBjGMp9hS
VwfNl3spm0UUZF1PlqSo5HqAUUZ7M5EPL9dSQYYUr11LfzJp+U8oxCRhGKg2j4Uu
TkOWn+w1WUng8YCbAXf945dgvKEOtHoKdE16S+dMf7r2PfUXMy5+rauTFjDlHZvc
7MOnAil+syoiqi4DLFGGSAlS+JTDbAxfRuRoowLqRlzPXwE9ieaAvEq3RbJRgDLF
7Wcrp3ZoTTdPvjGhgtKbWsggcT89LOdOUlgYKcynZFnDNiVjXis=
=58pc
-----END PGP SIGNATURE-----

--G2OjEObSrXwMKUEk--
