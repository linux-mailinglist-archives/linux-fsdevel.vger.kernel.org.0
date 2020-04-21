Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7DE1B3191
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 23:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDUVIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 17:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgDUVIj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:08:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F091F206D9;
        Tue, 21 Apr 2020 21:08:37 +0000 (UTC)
Date:   Tue, 21 Apr 2020 17:08:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk
Subject: Re: [PATCH 03/15] print_integer: new and improved way of printing
 integers
Message-ID: <20200421170836.4aafcbc2@gandalf.local.home>
In-Reply-To: <20200421164924.GB8735@avx2>
References: <20200420205743.19964-1-adobriyan@gmail.com>
        <20200420205743.19964-3-adobriyan@gmail.com>
        <20200420211911.GC185537@smile.fi.intel.com>
        <20200420212723.GE185537@smile.fi.intel.com>
        <20200420215417.6e2753ee@oasis.local.home>
        <20200421164924.GB8735@avx2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/xbI+jYb6tEPw5+QvHxltnyb"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--MP_/xbI+jYb6tEPw5+QvHxltnyb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 21 Apr 2020 19:49:24 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > Exactly. The code in _print_integer_u32() doesn't look as fast as the
> > code in vsprintf() that happens to use lookup tables and converts
> > without any loops.
> >=20
> > Hint, loops are bad, they cause the CPU to slow down. =20
>=20
> Oh, come on! Loops make code fit into icache and =CE=BCop decode cache.

Depends on the architecture.

>=20
> > Anyway, this patch series would require a pretty good improvement, as
> > the code replacing the sprintf() usages is pretty ugly compared to a
> > simple sprintf() call. =20
>=20
> No! Fast code must look ugly. Or in other words if you try to optimise
> integer printing to death you'll probably end with something like
> _print_integer().

As I stated, it will require a "pretty good improvement". There's always a
trade off. If the improvement is noticeable for real life cases, then ugly
code is worth it. If we are making ugly code for a benefit of something
that never shows outside of noise, then the net cost (less maintainable
code), is not worth it.

>=20
> When the very first patch changed /proc/stat to seq_put_decimal_ull()
> the speed up was 66% (or 33%). That's how slow printing was back then.
> It can be made slightly faster even now.

I'd like to see the tests that your ran (to reproduce them myself).

The first patch was making a 64bit number into 32bit number, thus
shortening the work by half.

>=20
> > Randomly picking patch 6:
> >=20
> >  static int loadavg_proc_show(struct seq_file *m, void *v)
> >  {
> >  	unsigned long avnrun[3];
> > =20
> >  	get_avenrun(avnrun, FIXED_1/200, 0);
> > =20
> > 	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %u/%d %d\n",
> > 		LOAD_INT(avnrun[0]), LOAD_FRAC(avnrun[0]),
> > 		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
> > 		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
> > 		nr_running(), nr_threads,
> > 		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
> >  	return 0;
> >  }
> >=20
> >   *vs*=20
> >=20
> >  static int loadavg_proc_show(struct seq_file *m, void *v)
> >  {
> >  	unsigned long avnrun[3];
> > 	char buf[3 * (LEN_UL + 1 + 2 + 1) + 10 + 1 + 10 + 1 + 10 + 1];
> > 	char *p =3D buf + sizeof(buf);
> > 	int i;
> >=20
> > 	*--p =3D '\n';
> > 	p =3D _print_integer_u32(p, idr_get_cursor(&task_active_pid_ns(current=
)->idr) - 1);
> > 	*--p =3D ' ';
> > 	p =3D _print_integer_u32(p, nr_threads);
> > 	*--p =3D '/';
> > 	p =3D _print_integer_u32(p, nr_running());
> >=20
> >  	get_avenrun(avnrun, FIXED_1/200, 0);
> > 	for (i =3D 2; i >=3D 0; i--) {
> > 		*--p =3D ' ';
> > 		--p;		/* overwritten */
> > 		*--p =3D '0';	/* conditionally overwritten */
> > 		(void)_print_integer_u32(p + 2, LOAD_FRAC(avnrun[i]));
> > 		*--p =3D '.';
> > 		p =3D _print_integer_ul(p, LOAD_INT(avnrun[i]));
> > 	}
> > =20
> > 	seq_write(m, p, buf + sizeof(buf) - p);
> >  	return 0;
> >  }
> >=20
> >=20
> > I much rather keep the first version. =20
>=20
> I did the benchmarks (without stack protector though), everything except
> /proc/cpuinfo and /proc/meminfo became faster. This requires investigation
> and I can drop vsprintf() changes until then.
>=20
> Now given that /proc/uptime format cast in stone, code may look a bit ugly
> and unusual but it won't require maintainance

Please share what you did as your benchmarks. If this is as good of a
performance as you claim, then these changes would be worth looking into.


So I applied your entire series, added the following patch:

diff --git a/include/linux/spinlock_api_smp.h
b/include/linux/spinlock_api_smp.h index 19a9be9d97ee..17c582d77ab7 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -152,9 +152,16 @@ static inline void __raw_spin_unlock(raw_spinlock_t
*lock) preempt_enable();
 }
=20
+extern u64 sched_clock(void);
 static inline void __raw_spin_unlock_irqrestore(raw_spinlock_t *lock,
 					    unsigned long flags)
 {
+	char buf[32];
+	u64 start, stop;
+	start =3D sched_clock();
+	sprintf(buf,"%lld", (unsigned long)lock);
+	stop =3D sched_clock();
+	trace_printk("time: %lld '%s'\n", stop - start, buf);
 	spin_release(&lock->dep_map, _RET_IP_);
 	do_raw_spin_unlock(lock);
 	local_irq_restore(flags);


Then after boot up, I did the following:

 # trace-cmd stop
 # trace-cmd extract

Which captured the traces:

          <idle>-0     [003]     5.405208: bprint:               _raw_spin_=
unlock_irqrestore: time: 799 '-110308271193088'
          <idle>-0     [003]     5.405210: bprint:               _raw_spin_=
unlock_irqrestore: time: 273 '-110308271193088'
          <idle>-0     [003]     5.412235: bprint:               _raw_spin_=
unlock_irqrestore: time: 1138 '-110308271193088'
          <idle>-0     [003]     5.412236: bprint:               _raw_spin_=
unlock_irqrestore: time: 213 '-110308271193088'
          <idle>-0     [003]     5.414241: bprint:               _raw_spin_=
unlock_irqrestore: time: 1094 '-110308271193088'
          <idle>-0     [003]     5.414243: bprint:               _raw_spin_=
unlock_irqrestore: time: 182 '-110308271193088'
          <idle>-0     [003]     5.418241: bprint:               _raw_spin_=
unlock_irqrestore: time: 1113 '-110308271193088'


Where "time: X", X is the delta in nanoseconds around the sprintf() call.

The I ran the attached perl program on the output, and got the following
results:

Before your patches:

 # trace-cmd report | ./report.pl
full_total =3D 52844823
  average:   255.902176229032
  std:       439.269729814847

And with your patches:

 # trace-cmd report | ./report.pl
full_total =3D 84725476
  average:   407.873274762306
  std:       555.755670463724

As the standard deviation is bigger than the average, it appears to be all
in the noise.

Then I decided to see if it affects "ps -eux"

Original:

# perf stat -r 100 ps -eux > /dev/null

 Performance counter stats for 'ps -eux' (100 runs):

              8.92 msec task-clock                #    0.937 CPUs utilized =
           ( +-  0.90% )
                 5      context-switches          #    0.545 K/sec         =
           ( +-  1.24% )
                 0      cpu-migrations            #    0.000 K/sec         =
        =20
               259      page-faults               #    0.029 M/sec         =
           ( +-  0.07% )
        32,973,751      cycles                    #    3.698 GHz           =
           ( +-  0.09% )
        17,254,307      stalled-cycles-frontend   #   52.33% frontend cycle=
s idle     ( +-  0.17% )
        38,707,960      instructions              #    1.17  insn per cycle=
        =20
                                                  #    0.45  stalled cycles=
 per insn  ( +-  0.01% )
         8,153,197      branches                  #  914.274 M/sec         =
           ( +-  0.01% )
           114,992      branch-misses             #    1.41% of all branche=
s          ( +-  0.12% )

         0.0095170 +- 0.0000829 seconds time elapsed  ( +-  0.87% )

With your patches:

# perf stat -r 100 ps -eux > /dev/null

 Performance counter stats for 'ps -eux' (100 runs):

              8.86 msec task-clock                #    0.918 CPUs utilized =
           ( +-  1.06% )
                 5      context-switches          #    0.527 K/sec         =
           ( +-  1.22% )
                 0      cpu-migrations            #    0.001 K/sec         =
           ( +-100.00% )
               259      page-faults               #    0.029 M/sec         =
           ( +-  0.08% )
        32,699,168      cycles                    #    3.692 GHz           =
           ( +-  0.12% )
        16,995,861      stalled-cycles-frontend   #   51.98% frontend cycle=
s idle     ( +-  0.21% )
        38,114,396      instructions              #    1.17  insn per cycle=
        =20
                                                  #    0.45  stalled cycles=
 per insn  ( +-  0.03% )
         7,985,526      branches                  #  901.625 M/sec         =
           ( +-  0.03% )
           112,852      branch-misses             #    1.41% of all branche=
s          ( +-  0.17% )

          0.009652 +- 0.000276 seconds time elapsed  ( +-  2.86% )

Not really much difference.

Then what about just catting /proc/$$/stat, and do a 1000 runs!

Original:

# perf stat -r 1000 cat /proc/$$/stat > /dev/null

 Performance counter stats for 'cat /proc/1622/stat' (1000 runs):

              0.34 msec task-clock                #    0.680 CPUs utilized =
           ( +-  0.21% )
                 0      context-switches          #    0.071 K/sec         =
           ( +- 20.18% )
                 0      cpu-migrations            #    0.000 K/sec         =
        =20
                65      page-faults               #    0.192 M/sec         =
           ( +-  0.07% )
           993,486      cycles                    #    2.934 GHz           =
           ( +-  0.07% )
           577,903      stalled-cycles-frontend   #   58.17% frontend cycle=
s idle     ( +-  0.09% )
           936,489      instructions              #    0.94  insn per cycle=
        =20
                                                  #    0.62  stalled cycles=
 per insn  ( +-  0.07% )
           202,912      branches                  #  599.213 M/sec         =
           ( +-  0.07% )
             6,976      branch-misses             #    3.44% of all branche=
s          ( +-  0.11% )

        0.00049797 +- 0.00000111 seconds time elapsed  ( +-  0.22% )


With your patches:

# perf stat -r 1000 cat /proc/$$/stat > /dev/null

 Performance counter stats for 'cat /proc/1624/stat' (1000 runs):

              0.34 msec task-clock                #    0.664 CPUs utilized =
           ( +-  0.23% )
                 0      context-switches          #    0.018 K/sec         =
           ( +- 40.72% )
                 0      cpu-migrations            #    0.000 K/sec         =
        =20
                65      page-faults               #    0.190 M/sec         =
           ( +-  0.07% )
           988,430      cycles                    #    2.892 GHz           =
           ( +-  0.07% )
           574,841      stalled-cycles-frontend   #   58.16% frontend cycle=
s idle     ( +-  0.09% )
           933,852      instructions              #    0.94  insn per cycle=
        =20
                                                  #    0.62  stalled cycles=
 per insn  ( +-  0.07% )
           202,096      branches                  #  591.297 M/sec         =
           ( +-  0.07% )
             6,836      branch-misses             #    3.38% of all branche=
s          ( +-  0.09% )

        0.00051476 +- 0.00000557 seconds time elapsed  ( +-  1.08% )


They are pretty much identical.

What's the purpose of all these changes again? There was no cover letter.

-- Steve

--MP_/xbI+jYb6tEPw5+QvHxltnyb
Content-Type: application/x-perl
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=report.pl

IyEvdXNyL2Jpbi9wZXJsIC13CgpteSBAbGlzdDsKbXkgJHRvdGFsOwoKd2hpbGUgKDw+KSB7Cglj
aG9tcDsKCWlmICgvdGltZTpccyooXFMqKS8pIHsKCQkkbGlzdFskI2xpc3QgKyAxXSA9ICQxOwoJ
CSR0b3RhbCArPSAkMTsKCX0KfQoKbXkgJGNudCA9ICQjbGlzdCArIDE7CmlmICghJGNudCkgewoJ
cHJpbnQgIm5vdGhpbmcgdG8gcmVwb3J0XG4iOwoJZXhpdDsKfQpteSAkYXZnID0gJHRvdGFsIC8g
JGNudDsKCm15ICRzdGQgPSAwOwokY250ID0gMDsKZm9yZWFjaCBteSAkdmFsIChAbGlzdCkgewoJ
bXkgJGRlbHRhID0gJHZhbCAtICRhdmc7Cgkkc3RkICs9ICRkZWx0YSAqICRkZWx0YTsKCSRjbnQr
KzsKfQpteSAkZnVsbF9zdGQgPSBzcXJ0KCRjbnQgPyAkc3RkIC8gJGNudCA6IDApOwoKcHJpbnRm
IDw8RU9GOwoKZnVsbF90b3RhbCA9ICR0b3RhbAogIGF2ZXJhZ2U6ICAgJGF2ZwogIHN0ZDogICAg
ICAgJGZ1bGxfc3RkCgpFT0YK

--MP_/xbI+jYb6tEPw5+QvHxltnyb--
