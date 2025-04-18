Return-Path: <linux-fsdevel+bounces-46669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21384A936AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 13:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E0A4620A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 11:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CD126FD8F;
	Fri, 18 Apr 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT79LG9P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7D19DF52;
	Fri, 18 Apr 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744976810; cv=none; b=FYIUjBILX9GGLtjOkVM14mEXjRXFPrRtgV8O/190Y1vHCes3UEdCNnRsh3EDTvW44VVl0WkIJlisy83xo1VASxN7Qre0BdnRep6rNpDsfKGQY+zf7+rDXADcKkXWkfyKNMavmKG3d+nkFhtLcMndZZGme6ivEEUwSSYKZRxphbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744976810; c=relaxed/simple;
	bh=nFYnUbzMjC9jO0H8WeVfufozuSTSOUIv0in3G1/EIfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5TgsCR1TaY2/5AUXIoYTLtyucFZeJsfNXauiDW6xzaC9KD4qe6dEfZgsXehUO7wtWUzeK9ovQDb2+g48kZo+7nue2ujtUKyjSkuYb4AFNe9XMVEUd/4M1wX23IDJBpmYCI3k0imClb4kjxKwDHwbvb+zQ5W/hUzLK0NPIfRKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PT79LG9P; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acb2faa9f55so221991166b.3;
        Fri, 18 Apr 2025 04:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744976804; x=1745581604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maUNf9agGDLbe+E9AFm7RUyRCX/ozk5ZstSL1FpwMeU=;
        b=PT79LG9PlAFKoU+6jndPh7m3X0jBoc1aH/eqQ4i1/uMEDsDrBk1+2wFhK60qBR5ad1
         uOXdO0YBuz73LoSCiAIrFw0jaUGarwVITkWTByaxnYToUf1c+5ty5gib9UFpNU089NXP
         2OpRlGRAphB4av1G+6lGP9/3Dfo+Sdvcj+/rX3Mu2B8TXdcR+kUgGyg7l0VhXlFyG0jk
         T1Zojk433HHOBJr3ekbkp9Gti3Xps8DQUXG/d0Aitk1JuG0edcE8PejE9oM4K4DihSSF
         0vZklggrzYFFOrq1iuwra2cvrPYwn5ACVn7/E2/vifogOMbbS0EpoB/AGo3vXl7PJlnF
         JMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744976804; x=1745581604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maUNf9agGDLbe+E9AFm7RUyRCX/ozk5ZstSL1FpwMeU=;
        b=czsJAEAWDDC7L4BLebkbDZ3Q54droUzgLgZtqeUyuONkm33hjvoXTRY92DMEzcXdv5
         /pRQR0nqNlu6932WnpDwBN+KR3qmP1RfEEOYQcvU15QnrjVOGtBGDt+Z192wRN086exc
         LZ4XXo4jfU1Z2C6oU2MjppzNchUt46gA2g1R6V3x9YN8sO4lZdevzInOaZP/LkqJDYlJ
         3/U85kbVuX7gPg1czEb/JDqzkYjaXoi5Kh8wqOS+4eRg9nWEluh+7IBp2O/In6gi2IND
         r7MmPFdgiXQ+dUVy1Qu0yWBQhgfkJEtn3k6LZjrtoGkEk13duuc+KDn0tXmmtfmg2VCh
         X3Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU/197fe7u7ECVO9H9VmvSZB90QE4uvscdjTe6Mayz0YeIEZLmNE/qnVPegdTMPAeH1hgtCjGqW2eJZRai4@vger.kernel.org, AJvYcCUhkBNxDebg0Bd0wHRAYL3Zoi7VUAlFNtZGnlBp0ZgY/894fdPR87O1HPZI1T3AZoP+TfSQCs6g3m3RF93p@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37gDZveGLivtx9540Yy0ztE/7UdKsNi6R/aKDriJWijt5pv52
	gykr+jziz0oV1zaUNduZS10+wZbDkajGO8KOSDGHTKLz4a0bVY8UDhtbrmHFEK3c18CcJdzW1mD
	zMyoPYqz0rbl53sKiDJJHs0fgEhQ=
X-Gm-Gg: ASbGncvk4GvT4FJpDlbxqXeLkQ7wplrM6Agvcva1axH/V0WsaAIY81i0KQApTfVKmEX
	MUN3qVy1swL9o3fsWNE0RbVO8ufSakLMi89/83WuYTYWod8ZPEgnglP5W5swJnY/EIOGPMP3VLL
	Dt0wqqyQtirSuC82SIo2RvklW9WMBEctK0
X-Google-Smtp-Source: AGHT+IHd0Lp3vekAwZcQBaMXEJcq0XyZTc/D37u+wIDjfg/bp19IvXqCCiJnWBdxbf9L30Hx5pUuwOSS8ZF202n5XFI=
X-Received: by 2002:a17:906:9f90:b0:aca:a163:aa3d with SMTP id
 a640c23a62f3a-acb74ac3f89mr255242966b.3.1744976803802; Fri, 18 Apr 2025
 04:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202504171513.6d6f8a16-lkp@intel.com> <CAGudoHGcQspttcaZ6nYfwBkXiJEC-XKuprxnmXRjjufz2vPRhw@mail.gmail.com>
 <CAGudoHHMvREPjWNvmAa_qQovK-9S1zvCAGh=K6U21oyr4pTtzg@mail.gmail.com>
 <hupjeobnfvo7y3jyvomjuqxtdl2df2myqxwr3bktmxabsrbid4@erg2ghyfkuj5> <aAIJc+VxVPQC2Jqb@xsang-OptiPlex-9020>
In-Reply-To: <aAIJc+VxVPQC2Jqb@xsang-OptiPlex-9020>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 18 Apr 2025 13:46:30 +0200
X-Gm-Features: ATxdqUHW_Cc50YTgYhXXFMj_prY96itPxynGdH8nx-TVEQJkObdjrgrqZ5maSm4
Message-ID: <CAGudoHGBhJfGsktrsd5xSWZh7nLf1AsB1oNnS05B8H=POhrnYg@mail.gmail.com>
Subject: Re: [linus:master] [fs] a914bd93f3: stress-ng.close.close_calls_per_sec
 52.2% regression
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 10:13=E2=80=AFAM Oliver Sang <oliver.sang@intel.com=
> wrote:
>
> hi, Mateusz Guzik,
>
> On Thu, Apr 17, 2025 at 12:17:54PM +0200, Mateusz Guzik wrote:
> > On Thu, Apr 17, 2025 at 12:02:55PM +0200, Mateusz Guzik wrote:
> > > bottom line though is there is a known tradeoff there and stress-ng
> > > manufactures a case where it is always the wrong one.
> > >
> > > fd 2 at hand is inherited (it's the tty) and shared between *all*
> > > workers on all CPUs.
> > >
> > > Ignoring some fluff, it's this in a loop:
> > > dup2(2, 1024)                           =3D 1024
> > > dup2(2, 1025)                           =3D 1025
> > > dup2(2, 1026)                           =3D 1026
> > > dup2(2, 1027)                           =3D 1027
> > > dup2(2, 1028)                           =3D 1028
> > > dup2(2, 1029)                           =3D 1029
> > > dup2(2, 1030)                           =3D 1030
> > > dup2(2, 1031)                           =3D 1031
> > > [..]
> > > close_range(1024, 1032, 0)              =3D 0
> > >
> > > where fd 2 is the same file object in all 192 workers doing this.
> > >
> >
> > the following will still have *some* impact, but the drop should be muc=
h
> > lower
> >
> > it also has a side effect of further helping the single-threaded case b=
y
> > shortening the code when it works
>
> we applied below patch upon a914bd93f3. it seems it not only recovers the
> regression we saw on a914bd93f3, but also causes further performance bene=
fit
> that it's +29.4% better than 3e46a92a27 (parent of a914bd93f3).
>
> at the same time, I also list stress-ng.close.ops_per_sec here which is n=
ot
> in our original report since the data has overlap so our code logic don't
> think they are reliable then will not list in table without some 'force'
> option.
>

some drop for highly concurrent close of *the same* file is expected.
it's a tradeoff optimizing for a case where the call to close deals
with the last fd, which is most common in real life

if one was to try to dig deeper the real baseline would be against
23e490336467fcdaf95e1efcf8f58067b59f647b , which is just prior to any
of the ref changes, but i'm not sure doing this is warranted

I very much expect the patchset is a net loss for this stress-ng run,
but also per the above description stress-ng does not accurately
represent what happens in the real world, turning the tradeoff
introduced in the patchset into a problem.

all that said, i'll do a proper patch submission for what i posted
here, thanks for testing

> in a stress-ng close test, the output looks like below:
>
> 2025-04-18 02:58:28 stress-ng --timeout 60 --times --verify --metrics --n=
o-rand-seed --close 192
> stress-ng: info:  [6268] setting to a 1 min run per stressor
> stress-ng: info:  [6268] dispatching hogs: 192 close
> stress-ng: info:  [6268] note: /proc/sys/kernel/sched_autogroup_enabled i=
s 1 and this can impact scheduling throughput for processes not attached to=
 a tty. Setting this to 0 may improve performance metrics
> stress-ng: metrc: [6268] stressor       bogo ops real time  usr time  sys=
 time   bogo ops/s     bogo ops/s CPU used per       RSS Max
> stress-ng: metrc: [6268]                           (secs)    (secs)    (s=
ecs)   (real time) (usr+sys time) instance (%)          (KB)
> stress-ng: metrc: [6268] close           1568702     60.08    171.29   95=
24.58     26108.29         161.79        84.05          1548  <--- (1)
> stress-ng: metrc: [6268] miscellaneous metrics:
> stress-ng: metrc: [6268] close             600923.80 close calls per sec =
(harmonic mean of 192 instances)   <--- (2)
> stress-ng: info:  [6268] for a 60.14s run time:
> stress-ng: info:  [6268]   11547.73s available CPU time
> stress-ng: info:  [6268]     171.29s user time   (  1.48%)
> stress-ng: info:  [6268]    9525.12s system time ( 82.48%)
> stress-ng: info:  [6268]    9696.41s total time  ( 83.97%)
> stress-ng: info:  [6268] load average: 520.00 149.63 51.46
> stress-ng: info:  [6268] skipped: 0
> stress-ng: info:  [6268] passed: 192: close (192)
> stress-ng: info:  [6268] failed: 0
> stress-ng: info:  [6268] metrics untrustworthy: 0
> stress-ng: info:  [6268] successful run completed in 1 min
>
>
>
> the stress-ng.close.close_calls_per_sec data is from (2)
> the stress-ng.close.ops_per_sec data is from line (1), bogo ops/s (real t=
ime)
>
> from below, seems a914bd93f3 also has a small regression for
> stress-ng.close.ops_per_sec but not obvious since data is not stable enou=
gh.
> 9f0124114f almost has same data as 3e46a92a27 regarding to this
> stress-ng.close.ops_per_sec.
>
>
> summary data:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testc=
ase/testtime:
>   gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/i=
gk-spr-2sp1/close/stress-ng/60s
>
> commit:
>   3e46a92a27 ("fs: use fput_close_sync() in close()")
>   a914bd93f3 ("fs: use fput_close() in filp_close()")
>   9f0124114f  <--- a914bd93f3 + patch
>
> 3e46a92a27c2927f a914bd93f3edfedcdd59deb615e 9f0124114f707363af03caed5ae
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>     473980 =C4=85 14%     -52.2%     226559 =C4=85 13%     +29.4%     613=
288 =C4=85 12%  stress-ng.close.close_calls_per_sec
>    1677393 =C4=85  3%      -6.0%    1576636 =C4=85  5%      +0.6%    1686=
892 =C4=85  3%  stress-ng.close.ops
>      27917 =C4=85  3%      -6.0%      26237 =C4=85  5%      +0.6%      28=
074 =C4=85  3%  stress-ng.close.ops_per_sec
>
>
> full data is as [1]
>
>
> >
> > diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
> > index 7db62fbc0500..c73865ed4251 100644
> > --- a/include/linux/file_ref.h
> > +++ b/include/linux/file_ref.h
> > @@ -181,17 +181,15 @@ static __always_inline __must_check bool file_ref=
_put_close(file_ref_t *ref)
> >       long old, new;
> >
> >       old =3D atomic_long_read(&ref->refcnt);
> > -     do {
> > -             if (unlikely(old < 0))
> > -                     return __file_ref_put_badval(ref, old);
> > -
> > -             if (old =3D=3D FILE_REF_ONEREF)
> > -                     new =3D FILE_REF_DEAD;
> > -             else
> > -                     new =3D old - 1;
> > -     } while (!atomic_long_try_cmpxchg(&ref->refcnt, &old, new));
> > -
> > -     return new =3D=3D FILE_REF_DEAD;
> > +     if (likely(old =3D=3D FILE_REF_ONEREF)) {
> > +             new =3D FILE_REF_DEAD;
> > +             if (likely(atomic_long_try_cmpxchg(&ref->refcnt, &old, ne=
w)))
> > +                     return true;
> > +             /*
> > +              * The ref has changed from under us, don't play any game=
s.
> > +              */
> > +     }
> > +     return file_ref_put(ref);
> >  }
> >
> >  /**
>
>
> [1]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testc=
ase/testtime:
>   gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/i=
gk-spr-2sp1/close/stress-ng/60s
>
> commit:
>   3e46a92a27 ("fs: use fput_close_sync() in close()")
>   a914bd93f3 ("fs: use fput_close() in filp_close()")
>   9f0124114f  <--- a914bd93f3 + patch
>
> 3e46a92a27c2927f a914bd93f3edfedcdd59deb615e 9f0124114f707363af03caed5ae
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>     355470 =C4=85 14%     -17.6%     292767 =C4=85  7%      -8.9%     323=
894 =C4=85  6%  cpuidle..usage
>       5.19            -0.6        4.61 =C4=85  3%      -0.0        5.18 =
=C4=85  2%  mpstat.cpu.all.usr%
>     495615 =C4=85  7%     -38.5%     304839 =C4=85  8%      -5.5%     468=
431 =C4=85  7%  vmstat.system.cs
>     780096 =C4=85  5%     -23.5%     596446 =C4=85  3%      -4.7%     743=
238 =C4=85  5%  vmstat.system.in
>    4004843 =C4=85  8%     -21.1%    3161813 =C4=85  8%      -6.2%    3758=
245 =C4=85 10%  time.involuntary_context_switches
>       9475            +1.1%       9582            +0.3%       9504       =
 time.system_time
>     183.50 =C4=85  2%     -37.8%     114.20 =C4=85  3%      -3.4%     177=
.34 =C4=85  2%  time.user_time
>   25637892 =C4=85  6%     -42.6%   14725385 =C4=85  9%      -6.4%   23992=
138 =C4=85  7%  time.voluntary_context_switches
>    2512168 =C4=85 17%     -45.8%    1361659 =C4=85 71%      +0.5%    2524=
627 =C4=85 15%  sched_debug.cfs_rq:/.avg_vruntime.min
>    2512168 =C4=85 17%     -45.8%    1361659 =C4=85 71%      +0.5%    2524=
627 =C4=85 15%  sched_debug.cfs_rq:/.min_vruntime.min
>     700402 =C4=85  2%     +19.8%     838744 =C4=85 10%      +5.0%     735=
486 =C4=85  4%  sched_debug.cpu.avg_idle.avg
>      81230 =C4=85  6%     -59.6%      32788 =C4=85 69%      -6.1%      76=
301 =C4=85  7%  sched_debug.cpu.nr_switches.avg
>      27992 =C4=85 20%     -70.2%       8345 =C4=85 74%     +11.7%      31=
275 =C4=85 26%  sched_debug.cpu.nr_switches.min
>     473980 =C4=85 14%     -52.2%     226559 =C4=85 13%     +29.4%     613=
288 =C4=85 12%  stress-ng.close.close_calls_per_sec
>    1677393 =C4=85  3%      -6.0%    1576636 =C4=85  5%      +0.6%    1686=
892 =C4=85  3%  stress-ng.close.ops
>      27917 =C4=85  3%      -6.0%      26237 =C4=85  5%      +0.6%      28=
074 =C4=85  3%  stress-ng.close.ops_per_sec
>    4004843 =C4=85  8%     -21.1%    3161813 =C4=85  8%      -6.2%    3758=
245 =C4=85 10%  stress-ng.time.involuntary_context_switches
>       9475            +1.1%       9582            +0.3%       9504       =
 stress-ng.time.system_time
>     183.50 =C4=85  2%     -37.8%     114.20 =C4=85  3%      -3.4%     177=
.34 =C4=85  2%  stress-ng.time.user_time
>   25637892 =C4=85  6%     -42.6%   14725385 =C4=85  9%      -6.4%   23992=
138 =C4=85  7%  stress-ng.time.voluntary_context_switches
>      23.01 =C4=85  2%      -1.4       21.61 =C4=85  3%      +0.1       23=
.13 =C4=85  2%  perf-stat.i.cache-miss-rate%
>   17981659           -10.8%   16035508 =C4=85  4%      -0.5%   17886941 =
=C4=85  4%  perf-stat.i.cache-misses
>   77288888 =C4=85  2%      -6.5%   72260357 =C4=85  4%      -1.7%   75978=
329 =C4=85  3%  perf-stat.i.cache-references
>     504949 =C4=85  6%     -38.1%     312536 =C4=85  8%      -5.7%     476=
406 =C4=85  7%  perf-stat.i.context-switches
>      33030           +15.7%      38205 =C4=85  4%      +1.3%      33444 =
=C4=85  4%  perf-stat.i.cycles-between-cache-misses
>       4.34 =C4=85 10%     -38.3%       2.68 =C4=85 20%      +0.1%       4=
.34 =C4=85 11%  perf-stat.i.metric.K/sec
>      26229 =C4=85 44%     +37.8%      36145 =C4=85  4%     +21.8%      31=
948 =C4=85  4%  perf-stat.overall.cycles-between-cache-misses
>       2.12 =C4=85 47%    +151.1%       5.32 =C4=85 28%     -13.5%       1=
.84 =C4=85 27%  perf-sched.sch_delay.avg.ms.__cond_resched.__do_sys_close_r=
ange.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       0.28 =C4=85 60%    +990.5%       3.08 =C4=85 53%   +6339.3%      18=
.16 =C4=85314%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_=
noprof.do_eventfd.__x64_sys_eventfd2.do_syscall_64
>       0.96 =C4=85 28%     +35.5%       1.30 =C4=85 25%      -7.5%       0=
.89 =C4=85 29%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_noprof=
.load_elf_phdrs.load_elf_binary.exec_binprm
>       2.56 =C4=85 43%    +964.0%      27.27 =C4=85161%    +456.1%      14=
.25 =C4=85127%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.open_last_l=
ookups.path_openat.do_filp_open
>      12.80 =C4=85139%    +366.1%      59.66 =C4=85107%    +242.3%      43=
.82 =C4=85204%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.shmem_unlin=
k.vfs_unlink.do_unlinkat
>       2.78 =C4=85 25%     +50.0%       4.17 =C4=85 19%     +22.2%       3=
.40 =C4=85 18%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc=
_lru_noprof.__d_alloc.d_alloc_cursor.dcache_dir_open
>       0.78 =C4=85 18%     +39.3%       1.09 =C4=85 19%     +24.7%       0=
.97 =C4=85 36%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc=
_noprof.mas_alloc_nodes.mas_preallocate.vma_shrink
>       2.63 =C4=85 10%     +16.7%       3.07 =C4=85  4%      +1.3%       2=
.67 =C4=85 15%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc=
_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
>       0.04 =C4=85223%   +3483.1%       1.38 =C4=85 67%   +2231.2%       0=
.90 =C4=85243%  perf-sched.sch_delay.avg.ms.__cond_resched.netlink_release.=
__sock_release.sock_close.__fput
>       0.72 =C4=85 17%     +42.5%       1.02 =C4=85 22%     +20.4%       0=
.86 =C4=85 15%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sch=
ed_exec.bprm_execve.part
>       0.35 =C4=85134%    +457.7%       1.94 =C4=85 61%    +177.7%       0=
.97 =C4=85104%  perf-sched.sch_delay.avg.ms.__cond_resched.task_numa_work.t=
ask_work_run.syscall_exit_to_user_mode.do_syscall_64
>       1.88 =C4=85 34%    +574.9%      12.69 =C4=85115%    +389.0%       9=
.20 =C4=85214%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.sy=
scall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       2.41 =C4=85 10%     +18.0%       2.84 =C4=85  9%     +62.4%       3=
.91 =C4=85 81%  perf-sched.sch_delay.avg.ms.__cond_resched.wp_page_copy.__h=
andle_mm_fault.handle_mm_fault.do_user_addr_fault
>       1.85 =C4=85 36%    +155.6%       4.73 =C4=85 50%     +27.5%       2=
.36 =C4=85 54%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_comm=
on.__do_fault.do_read_fault
>      28.94 =C4=85 26%     -52.4%      13.78 =C4=85 36%     -29.1%      20=
.52 =C4=85 50%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do=
_syscall_64
>       2.24 =C4=85  9%     +22.1%       2.74 =C4=85  8%     +14.2%       2=
.56 =C4=85 14%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem=
_down_write_slowpath.down_write.unlink_file_vma_batch_final
>       2.19 =C4=85  7%     +17.3%       2.57 =C4=85  6%      +6.4%       2=
.33 =C4=85  6%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem=
_down_write_slowpath.down_write.vma_link_file
>       2.39 =C4=85  6%     +16.4%       2.79 =C4=85  9%     +12.3%       2=
.69 =C4=85  8%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem=
_down_write_slowpath.down_write.vma_prepare
>       0.34 =C4=85 77%   +1931.5%       6.95 =C4=85 99%   +5218.5%      18=
.19 =C4=85313%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_=
noprof.do_eventfd.__x64_sys_eventfd2.do_syscall_64
>      29.69 =C4=85 28%    +129.5%      68.12 =C4=85 28%     +11.1%      32=
.99 =C4=85 30%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_=
noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
>       7.71 =C4=85 21%     +10.4%       8.51 =C4=85 25%     -30.5%       5=
.36 =C4=85 30%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_n=
oprof.seq_read_iter.vfs_read.ksys_read
>       1.48 =C4=85 96%    +284.6%       5.68 =C4=85 56%     -39.2%       0=
.90 =C4=85112%  perf-sched.sch_delay.max.ms.__cond_resched.copy_strings_ker=
nel.kernel_execve.call_usermodehelper_exec_async.ret_from_fork
>       3.59 =C4=85 57%    +124.5%       8.06 =C4=85 45%     +44.7%       5=
.19 =C4=85 72%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.mmap_r=
ead_lock_maybe_expand.get_arg_page.copy_string_kernel
>       3.39 =C4=85 91%    +112.0%       7.19 =C4=85 44%    +133.6%       7=
.92 =C4=85129%  perf-sched.sch_delay.max.ms.__cond_resched.down_read_killab=
le.iterate_dir.__x64_sys_getdents64.do_syscall_64
>      22.16 =C4=85 77%    +117.4%      48.17 =C4=85 34%     +41.9%      31=
.45 =C4=85 54%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killa=
ble.exec_mmap.begin_new_exec.load_elf_binary
>       8.72 =C4=85 17%    +358.5%      39.98 =C4=85 61%     +98.6%      17=
.32 =C4=85 77%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc=
_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
>      35.71 =C4=85 49%      +1.8%      36.35 =C4=85 37%     -48.6%      18=
.34 =C4=85 25%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc=
_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
>       0.04 =C4=85223%   +3484.4%       1.38 =C4=85 67%   +2231.2%       0=
.90 =C4=85243%  perf-sched.sch_delay.max.ms.__cond_resched.netlink_release.=
__sock_release.sock_close.__fput
>       0.53 =C4=85154%    +676.1%       4.12 =C4=85 61%    +161.0%       1=
.39 =C4=85109%  perf-sched.sch_delay.max.ms.__cond_resched.task_numa_work.t=
ask_work_run.syscall_exit_to_user_mode.do_syscall_64
>      25.76 =C4=85 70%   +9588.9%       2496 =C4=85127%   +2328.6%     625=
.69 =C4=85272%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.sy=
scall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      51.53 =C4=85 26%     -58.8%      21.22 =C4=85106%     +13.1%      58=
.30 =C4=85190%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read=
.do_syscall_64
>       4.97 =C4=85 48%    +154.8%      12.66 =C4=85 75%     +25.0%       6=
.21 =C4=85 42%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_comm=
on.__do_fault.do_read_fault
>       4.36 =C4=85 48%    +147.7%      10.81 =C4=85 29%     -14.1%       3=
.75 =C4=85 26%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__do_sys_cl=
ose_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>     108632 =C4=85  4%     +23.9%     134575 =C4=85  6%      -1.3%     107=
223 =C4=85  4%  perf-sched.wait_and_delay.count.__cond_resched.__do_sys_clo=
se_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>     572.67 =C4=85  6%     +37.3%     786.17 =C4=85  7%      +1.9%     583=
.75 =C4=85  8%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_c=
ommon.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>     596.67 =C4=85 12%     +43.9%     858.50 =C4=85 13%      +2.4%     610=
.75 =C4=85  8%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_c=
ommon.wait_for_completion_state.call_usermodehelper_exec.__request_module
>     294.83 =C4=85  9%     +31.1%     386.50 =C4=85 11%      +1.7%     299=
.75 =C4=85 11%  perf-sched.wait_and_delay.count.__cond_resched.dput.termina=
te_walk.path_openat.do_filp_open
>    1223275 =C4=85  2%     -17.7%    1006293 =C4=85  6%      +0.5%    1228=
897        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.c=
ommon_nsleep.__x64_sys_clock_nanosleep
>       2772 =C4=85 11%     +43.6%       3980 =C4=85 11%      +6.6%       2=
954 =C4=85  9%  perf-sched.wait_and_delay.count.do_wait.kernel_wait.call_us=
ermodehelper_exec_work.process_one_work
>      11690 =C4=85  7%     +29.8%      15173 =C4=85 10%      +5.6%      12=
344 =C4=85  7%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_=
common.filemap_fault.__do_fault
>       4072 =C4=85100%    +163.7%      10737 =C4=85  7%     +59.4%       6=
491 =C4=85 58%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.=
asm_exc_page_fault.[unknown].[unknown]
>       8811 =C4=85  6%     +26.2%      11117 =C4=85  9%      +2.6%       9=
039 =C4=85  8%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.=
asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
>     662.17 =C4=85 29%    +187.8%       1905 =C4=85 29%     +36.2%     901=
.58 =C4=85 32%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_rea=
d.do_syscall_64
>      15.50 =C4=85 11%     +48.4%      23.00 =C4=85 16%      -6.5%      14=
.50 =C4=85 24%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do=
_poll.constprop.0.do_sys_poll
>     167.67 =C4=85 20%     +48.0%     248.17 =C4=85 26%      -8.3%     153=
.83 =C4=85 27%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.r=
wsem_down_write_slowpath.down_write.open_last_lookups
>       2680 =C4=85 12%     +42.5%       3820 =C4=85 11%      +6.7%       2=
860 =C4=85  9%  perf-sched.wait_and_delay.count.schedule_timeout.___down_co=
mmon.__down_timeout.down_timeout
>     137.17 =C4=85 13%     +31.8%     180.83 =C4=85  9%     +12.4%     154=
.17 =C4=85 16%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for=
_common.wait_for_completion_state.__wait_rcu_gp
>       2636 =C4=85 12%     +43.1%       3772 =C4=85 12%      +6.1%       2=
797 =C4=85 10%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for=
_common.wait_for_completion_state.call_usermodehelper_exec
>      10.50 =C4=85 11%     +74.6%      18.33 =C4=85 23%     +19.0%      12=
.50 =C4=85 18%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.=
kthread.ret_from_fork
>       5619 =C4=85  5%     +38.8%       7797 =C4=85  9%      +9.2%       6=
136 =C4=85  8%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.r=
et_from_fork.ret_from_fork_asm
>      70455 =C4=85  4%     +32.3%      93197 =C4=85  6%      +1.1%      71=
250 =C4=85  3%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.d=
o_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       6990 =C4=85  4%     +37.4%       9603 =C4=85  9%      +7.7%       7=
528 =C4=85  5%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_f=
rom_fork.ret_from_fork_asm
>     191.28 =C4=85124%   +1455.2%       2974 =C4=85100%    +428.0%       1=
009 =C4=85166%  perf-sched.wait_and_delay.max.ms.__cond_resched.dput.path_o=
penat.do_filp_open.do_sys_openat2
>       1758 =C4=85118%     -87.9%     211.89 =C4=85211%     -96.6%      59=
.86 =C4=85184%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys=
_read.do_syscall_64
>       2.24 =C4=85 48%    +144.6%       5.48 =C4=85 29%     -14.7%       1=
.91 =C4=85 25%  perf-sched.wait_time.avg.ms.__cond_resched.__do_sys_close_r=
ange.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       8.06 =C4=85101%    +618.7%      57.94 =C4=85 68%    +332.7%      34=
.88 =C4=85100%  perf-sched.wait_time.avg.ms.__cond_resched.__fput.__x64_sys=
_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.28 =C4=85146%    +370.9%       1.30 =C4=85 64%    +260.2%       0=
.99 =C4=85148%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__spl=
it_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
>       3.86 =C4=85  5%     +86.0%       7.18 =C4=85 44%     +41.7%       5=
.47 =C4=85 32%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_=
pgtables.exit_mmap.__mmput
>       2.54 =C4=85 29%     +51.6%       3.85 =C4=85 12%      +9.6%       2=
.78 =C4=85 39%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killa=
ble.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.11 =C4=85 39%    +201.6%       3.36 =C4=85 47%     +77.3%       1=
.98 =C4=85 86%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killa=
ble.exec_mmap.begin_new_exec.load_elf_binary
>       3.60 =C4=85 68%   +1630.2%      62.29 =C4=85153%    +398.4%      17=
.94 =C4=85134%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.l=
ink_path_walk.part
>       0.20 =C4=85 64%    +115.4%       0.42 =C4=85 42%    +145.2%       0=
.48 =C4=85 83%  perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.__k=
ernel_read.load_elf_binary.exec_binprm
>     142.09 =C4=85145%     +58.3%     224.93 =C4=85104%    +179.8%     397=
.63 =C4=85102%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc=
_noprof.alloc_pid.copy_process.kernel_clone
>      55.51 =C4=85 53%    +218.0%     176.54 =C4=85 83%     +96.2%     108=
.89 =C4=85 87%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc=
_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
>       3.22 =C4=85  3%     +15.4%       3.72 =C4=85  9%      +2.3%       3=
.30 =C4=85  7%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc=
_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
>       0.04 =C4=85223%  +37562.8%      14.50 =C4=85198%   +2231.2%       0=
.90 =C4=85243%  perf-sched.wait_time.avg.ms.__cond_resched.netlink_release.=
__sock_release.sock_close.__fput
>       1.19 =C4=85 30%     +59.3%       1.90 =C4=85 34%      +3.7%       1=
.24 =C4=85 37%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_c=
omplete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
>       0.36 =C4=85133%    +447.8%       1.97 =C4=85 60%    +174.5%       0=
.99 =C4=85103%  perf-sched.wait_time.avg.ms.__cond_resched.task_numa_work.t=
ask_work_run.syscall_exit_to_user_mode.do_syscall_64
>       1.73 =C4=85 47%    +165.0%       4.58 =C4=85 51%     +45.7%       2=
.52 =C4=85 52%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_comm=
on.__do_fault.do_read_fault
>       1.10 =C4=85 21%    +693.9%       8.70 =C4=85 70%    +459.3%       6=
.13 =C4=85173%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_=
sysvec_call_function_single.[unknown]
>      54.56 =C4=85 32%    +400.2%     272.90 =C4=85 67%    +345.0%     242=
.76 =C4=85 41%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_com=
mon.wait_for_completion_state.kernel_clone
>      10.87 =C4=85 18%    +151.7%      27.36 =C4=85 68%     +69.1%      18=
.38 =C4=85 83%  perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepa=
re.__vmf_anon_prepare.do_pte_missing.__handle_mm_fault
>     123.35 =C4=85181%   +1219.3%       1627 =C4=85 82%    +469.3%     702=
.17 =C4=85118%  perf-sched.wait_time.max.ms.__cond_resched.__fput.__x64_sys=
_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       9.68 =C4=85108%   +5490.2%     541.19 =C4=85185%     -56.7%       4=
.19 =C4=85327%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_=
noprof.do_epoll_create.__x64_sys_epoll_create.do_syscall_64
>       3.39 =C4=85 91%    +112.0%       7.19 =C4=85 44%     +52.9%       5=
.19 =C4=85 54%  perf-sched.wait_time.max.ms.__cond_resched.down_read_killab=
le.iterate_dir.__x64_sys_getdents64.do_syscall_64
>       1.12 =C4=85128%    +407.4%       5.67 =C4=85 52%    +536.0%       7=
.11 =C4=85144%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__spl=
it_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
>      30.58 =C4=85 29%   +1741.1%     563.04 =C4=85 80%   +1126.4%     375=
.06 =C4=85119%  perf-sched.wait_time.max.ms.__cond_resched.down_write.free_=
pgtables.exit_mmap.__mmput
>       3.82 =C4=85114%    +232.1%      12.70 =C4=85 49%    +155.2%       9=
.76 =C4=85120%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vms_g=
ather_munmap_vmas.__mmap_prepare.__mmap_region
>       7.75 =C4=85 46%     +72.4%      13.36 =C4=85 32%     +18.4%       9=
.17 =C4=85 86%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killa=
ble.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      13.39 =C4=85 48%    +259.7%      48.17 =C4=85 34%    +107.1%      27=
.74 =C4=85 58%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killa=
ble.exec_mmap.begin_new_exec.load_elf_binary
>      12.46 =C4=85 30%     +90.5%      23.73 =C4=85 34%     +25.5%      15=
.64 =C4=85 44%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killa=
ble.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
>     479.90 =C4=85 78%    +496.9%       2864 =C4=85141%    +310.9%       1=
972 =C4=85132%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_l=
ookups.path_openat.do_filp_open
>     185.75 =C4=85116%    +875.0%       1811 =C4=85 84%    +264.8%     677=
.56 =C4=85141%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_openat=
.do_filp_open.do_sys_openat2
>       2.52 =C4=85 44%    +105.2%       5.18 =C4=85 36%     +38.3%       3=
.49 =C4=85 74%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc=
_noprof.vm_area_alloc.alloc_bprm.kernel_execve
>       0.04 =C4=85223%  +37564.1%      14.50 =C4=85198%   +2231.2%       0=
.90 =C4=85243%  perf-sched.wait_time.max.ms.__cond_resched.netlink_release.=
__sock_release.sock_close.__fput
>       0.54 =C4=85153%    +669.7%       4.15 =C4=85 61%    +161.6%       1=
.41 =C4=85108%  perf-sched.wait_time.max.ms.__cond_resched.task_numa_work.t=
ask_work_run.syscall_exit_to_user_mode.do_syscall_64
>      28.22 =C4=85 14%     +41.2%      39.84 =C4=85 25%     +27.1%      35=
.87 =C4=85 43%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_c=
lear_ptes.part.0
>       4.90 =C4=85 51%    +158.2%      12.66 =C4=85 75%     +26.7%       6=
.21 =C4=85 42%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_comm=
on.__do_fault.do_read_fault
>      26.54 =C4=85 66%   +5220.1%       1411 =C4=85 84%   +2691.7%     740=
.84 =C4=85187%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_=
sysvec_call_function_single.[unknown]
>       1262 =C4=85  9%    +434.3%       6744 =C4=85 60%    +293.8%       4=
971 =C4=85 41%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_com=
mon.wait_for_completion_state.kernel_clone
>      30.09           -12.8       17.32            -2.9       27.23       =
 perf-profile.calltrace.cycles-pp.filp_flush.filp_close.__do_sys_close_rang=
e.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       9.32            -9.3        0.00            -9.3        0.00       =
 perf-profile.calltrace.cycles-pp.fput.filp_close.__do_sys_close_range.do_s=
yscall_64.entry_SYSCALL_64_after_hwframe
>      41.15            -5.9       35.26            -0.2       40.94       =
 perf-profile.calltrace.cycles-pp.__dup2
>      41.02            -5.9       35.17            -0.2       40.81       =
 perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.__dup2
>      41.03            -5.8       35.18            -0.2       40.83       =
 perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__dup2
>      13.86            -5.5        8.35            -1.1       12.79       =
 perf-profile.calltrace.cycles-pp.filp_flush.filp_close.do_dup2.__x64_sys_d=
up2.do_syscall_64
>      40.21            -5.5       34.71            -0.2       40.02       =
 perf-profile.calltrace.cycles-pp.__x64_sys_dup2.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe.__dup2
>      38.01            -4.9       33.10            +0.1       38.09       =
 perf-profile.calltrace.cycles-pp.do_dup2.__x64_sys_dup2.do_syscall_64.entr=
y_SYSCALL_64_after_hwframe.__dup2
>       4.90 =C4=85  2%      -1.9        2.96 =C4=85  3%      -0.5        4=
.38 =C4=85  2%  perf-profile.calltrace.cycles-pp.locks_remove_posix.filp_fl=
ush.filp_close.__do_sys_close_range.do_syscall_64
>       2.63 =C4=85  9%      -1.9        0.76 =C4=85 18%      -0.5        2=
.11 =C4=85  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_inte=
rrupt.filp_flush.filp_close.__do_sys_close_range.do_syscall_64
>       4.44            -1.7        2.76 =C4=85  2%      -0.4        3.99  =
      perf-profile.calltrace.cycles-pp.dnotify_flush.filp_flush.filp_close.=
__do_sys_close_range.do_syscall_64
>       2.50 =C4=85  2%      -0.9        1.56 =C4=85  3%      -0.2        2=
.28 =C4=85  2%  perf-profile.calltrace.cycles-pp.locks_remove_posix.filp_fl=
ush.filp_close.do_dup2.__x64_sys_dup2
>       2.22            -0.8        1.42 =C4=85  2%      -0.2        2.04  =
      perf-profile.calltrace.cycles-pp.dnotify_flush.filp_flush.filp_close.=
do_dup2.__x64_sys_dup2
>       1.66 =C4=85  5%      -0.3        1.37 =C4=85  5%      -0.2        1=
.42 =C4=85  4%  perf-profile.calltrace.cycles-pp.ksys_dup3.__x64_sys_dup2.d=
o_syscall_64.entry_SYSCALL_64_after_hwframe.__dup2
>       1.60 =C4=85  5%      -0.3        1.32 =C4=85  5%      -0.2        1=
.36 =C4=85  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.ksys_dup3._=
_x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.0        0.00            +0.6        0.65 =C4=85=
  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__do_sys_close_range.=
do_syscall_64.entry_SYSCALL_64_after_hwframe.close_range
>       0.00            +0.0        0.00           +41.2       41.20       =
 perf-profile.calltrace.cycles-pp.filp_close.__do_sys_close_range.do_syscal=
l_64.entry_SYSCALL_64_after_hwframe.close_range
>       0.00            +0.0        0.00           +42.0       42.01       =
 perf-profile.calltrace.cycles-pp.__do_sys_close_range.do_syscall_64.entry_=
SYSCALL_64_after_hwframe.close_range
>       0.00            +0.0        0.00           +42.4       42.36       =
 perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.close_range
>       0.00            +0.0        0.00           +42.4       42.36       =
 perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.close_rang=
e
>       0.00            +0.0        0.00           +42.4       42.44       =
 perf-profile.calltrace.cycles-pp.close_range
>       0.58 =C4=85  2%      +0.0        0.62 =C4=85  2%      +0.0        0=
.61 =C4=85  3%  perf-profile.calltrace.cycles-pp.do_read_fault.do_pte_missi=
ng.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>       1.40 =C4=85  4%      +0.0        1.44 =C4=85  9%      -0.4        0=
.99 =C4=85  6%  perf-profile.calltrace.cycles-pp.__close
>       0.54 =C4=85  2%      +0.0        0.58 =C4=85  2%      +0.0        0=
.56 =C4=85  3%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_=
fault.do_pte_missing.__handle_mm_fault.handle_mm_fault
>       1.34 =C4=85  5%      +0.0        1.40 =C4=85  9%      -0.4        0=
.93 =C4=85  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe.__close
>       1.35 =C4=85  5%      +0.1        1.40 =C4=85  9%      -0.4        0=
.93 =C4=85  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwf=
rame.__close
>       0.72 =C4=85  4%      +0.1        0.79 =C4=85  4%      -0.7        0=
.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.__do_sys_close_r=
ange.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>       1.23 =C4=85  5%      +0.1        1.31 =C4=85 10%      -0.5        0=
.77 =C4=85  8%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall=
_64.entry_SYSCALL_64_after_hwframe.__close
>       0.00            +1.8        1.79 =C4=85  5%      +1.4        1.35 =
=C4=85  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrup=
t.fput_close.filp_close.__do_sys_close_range.do_syscall_64
>      19.11            +4.4       23.49            +0.7       19.76       =
 perf-profile.calltrace.cycles-pp.filp_close.do_dup2.__x64_sys_dup2.do_sysc=
all_64.entry_SYSCALL_64_after_hwframe
>      40.94            +6.5       47.46           -40.9        0.00       =
 perf-profile.calltrace.cycles-pp.filp_close.__do_sys_close_range.do_syscal=
l_64.entry_SYSCALL_64_after_hwframe.syscall
>      42.24            +6.6       48.79           -42.2        0.00       =
 perf-profile.calltrace.cycles-pp.syscall
>      42.14            +6.6       48.72           -42.1        0.00       =
 perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
>      42.14            +6.6       48.72           -42.1        0.00       =
 perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.syscall
>      41.86            +6.6       48.46           -41.9        0.00       =
 perf-profile.calltrace.cycles-pp.__do_sys_close_range.do_syscall_64.entry_=
SYSCALL_64_after_hwframe.syscall
>       0.00           +14.6       14.60 =C4=85  2%      +6.4        6.41  =
      perf-profile.calltrace.cycles-pp.fput_close.filp_close.do_dup2.__x64_=
sys_dup2.do_syscall_64
>       0.00           +29.0       28.95 =C4=85  2%     +12.5       12.50  =
      perf-profile.calltrace.cycles-pp.fput_close.filp_close.__do_sys_close=
_range.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      45.76           -19.0       26.72            -4.1       41.64       =
 perf-profile.children.cycles-pp.filp_flush
>      14.67           -14.7        0.00           -14.7        0.00       =
 perf-profile.children.cycles-pp.fput
>      41.20            -5.9       35.30            -0.2       40.99       =
 perf-profile.children.cycles-pp.__dup2
>      40.21            -5.5       34.71            -0.2       40.03       =
 perf-profile.children.cycles-pp.__x64_sys_dup2
>      38.53            -5.2       33.33            +0.1       38.59       =
 perf-profile.children.cycles-pp.do_dup2
>       7.81 =C4=85  2%      -3.1        4.74 =C4=85  3%      -0.8        7=
.02 =C4=85  2%  perf-profile.children.cycles-pp.locks_remove_posix
>       7.03            -2.6        4.40 =C4=85  2%      -0.7        6.37  =
      perf-profile.children.cycles-pp.dnotify_flush
>       5.60 =C4=85 16%      -1.3        4.27 =C4=85 14%      -0.7        4=
.89 =C4=85  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_inter=
rupt
>       1.24 =C4=85  3%      -0.4        0.86 =C4=85  4%      -0.0        1=
.21        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       1.67 =C4=85  5%      -0.3        1.37 =C4=85  5%      -0.2        1=
.42 =C4=85  4%  perf-profile.children.cycles-pp.ksys_dup3
>       3.09 =C4=85  3%      -0.1        2.95 =C4=85  4%      -0.3        2=
.82 =C4=85  3%  perf-profile.children.cycles-pp._raw_spin_lock
>       0.29            -0.1        0.22 =C4=85  2%      +0.0        0.30 =
=C4=85  2%  perf-profile.children.cycles-pp.update_load_avg
>       0.10 =C4=85 71%      -0.1        0.04 =C4=85112%      -0.1        0=
.05 =C4=85 30%  perf-profile.children.cycles-pp.hrtimer_update_next_event
>       0.10 =C4=85 10%      -0.1        0.05 =C4=85 46%      +0.0        0=
.13 =C4=85  7%  perf-profile.children.cycles-pp.__x64_sys_fcntl
>       0.17 =C4=85  7%      -0.1        0.12 =C4=85  4%      -0.0        0=
.14 =C4=85  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64
>       0.15 =C4=85  3%      -0.0        0.10 =C4=85 18%      -0.0        0=
.15 =C4=85  3%  perf-profile.children.cycles-pp.clockevents_program_event
>       0.04 =C4=85 45%      -0.0        0.00            +0.0        0.07 =
=C4=85  7%  perf-profile.children.cycles-pp.update_irq_load_avg
>       0.06 =C4=85 11%      -0.0        0.02 =C4=85 99%      +0.0        0=
.08 =C4=85 24%  perf-profile.children.cycles-pp.stress_close_func
>       0.13 =C4=85  5%      -0.0        0.10 =C4=85  7%      +0.0        0=
.14 =C4=85  9%  perf-profile.children.cycles-pp.__switch_to
>       0.06 =C4=85  7%      -0.0        0.04 =C4=85 71%      -0.0        0=
.06 =C4=85  8%  perf-profile.children.cycles-pp.lapic_next_deadline
>       0.11 =C4=85  3%      -0.0        0.09 =C4=85  5%      -0.0        0=
.10 =C4=85  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>       1.49 =C4=85  3%      -0.0        1.48 =C4=85  2%      +0.2        1=
.68 =C4=85  4%  perf-profile.children.cycles-pp.x64_sys_call
>       0.00            +0.0        0.00           +42.5       42.47       =
 perf-profile.children.cycles-pp.close_range
>       0.23 =C4=85  2%      +0.0        0.24 =C4=85  5%      +0.0        0=
.26 =C4=85  5%  perf-profile.children.cycles-pp.__irq_exit_rcu
>       0.06 =C4=85  6%      +0.0        0.08 =C4=85  6%      +0.0        0=
.07 =C4=85  9%  perf-profile.children.cycles-pp.__folio_batch_add_and_move
>       0.26 =C4=85  2%      +0.0        0.28 =C4=85  3%      +0.0        0=
.28 =C4=85  6%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
>       0.08 =C4=85  4%      +0.0        0.11 =C4=85 10%      +0.0        0=
.09 =C4=85  7%  perf-profile.children.cycles-pp.set_pte_range
>       0.45 =C4=85  2%      +0.0        0.48 =C4=85  2%      +0.0        0=
.48 =C4=85  4%  perf-profile.children.cycles-pp.zap_present_ptes
>       0.18 =C4=85  3%      +0.0        0.21 =C4=85  4%      +0.0        0=
.20 =C4=85  4%  perf-profile.children.cycles-pp.folios_put_refs
>       0.29 =C4=85  3%      +0.0        0.32 =C4=85  3%      +0.0        0=
.31 =C4=85  4%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pa=
ges
>       0.29 =C4=85  3%      +0.0        0.32 =C4=85  3%      +0.0        0=
.31 =C4=85  5%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
>       1.42 =C4=85  5%      +0.0        1.45 =C4=85  9%      -0.4        1=
.00 =C4=85  6%  perf-profile.children.cycles-pp.__close
>       0.34 =C4=85  4%      +0.0        0.38 =C4=85  3%      +0.0        0=
.36 =C4=85  4%  perf-profile.children.cycles-pp.tlb_finish_mmu
>       0.24 =C4=85  3%      +0.0        0.27 =C4=85  5%      -0.0        0=
.23 =C4=85  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.69 =C4=85  2%      +0.0        0.74 =C4=85  2%      +0.0        0=
.72 =C4=85  5%  perf-profile.children.cycles-pp.filemap_map_pages
>       0.73 =C4=85  2%      +0.0        0.78 =C4=85  2%      +0.0        0=
.77 =C4=85  5%  perf-profile.children.cycles-pp.do_read_fault
>       0.65 =C4=85  7%      +0.1        0.70 =C4=85 15%      -0.5        0=
.17 =C4=85 10%  perf-profile.children.cycles-pp.fput_close_sync
>       1.24 =C4=85  5%      +0.1        1.33 =C4=85 10%      -0.5        0=
.79 =C4=85  8%  perf-profile.children.cycles-pp.__x64_sys_close
>      42.26            +6.5       48.80           -42.3        0.00       =
 perf-profile.children.cycles-pp.syscall
>      41.86            +6.6       48.46            +0.2       42.02       =
 perf-profile.children.cycles-pp.__do_sys_close_range
>      60.05           +10.9       70.95            +0.9       60.97       =
 perf-profile.children.cycles-pp.filp_close
>       0.00           +44.5       44.55 =C4=85  2%     +19.7       19.70  =
      perf-profile.children.cycles-pp.fput_close
>      14.31 =C4=85  2%     -14.3        0.00           -14.3        0.00  =
      perf-profile.self.cycles-pp.fput
>      30.12 =C4=85  2%     -13.0       17.09            -2.4       27.73  =
      perf-profile.self.cycles-pp.filp_flush
>      19.17 =C4=85  2%      -9.5        9.68 =C4=85  3%      -0.6       18=
.61        perf-profile.self.cycles-pp.do_dup2
>       7.63 =C4=85  3%      -3.0        4.62 =C4=85  4%      -0.7        6=
.90 =C4=85  2%  perf-profile.self.cycles-pp.locks_remove_posix
>       6.86 =C4=85  3%      -2.6        4.28 =C4=85  3%      -0.6        6=
.25        perf-profile.self.cycles-pp.dnotify_flush
>       0.64 =C4=85  4%      -0.4        0.26 =C4=85  4%      -0.0        0=
.62 =C4=85  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
>       0.22 =C4=85 10%      -0.1        0.15 =C4=85 11%      +0.1        0=
.34 =C4=85  2%  perf-profile.self.cycles-pp.x64_sys_call
>       0.23 =C4=85  3%      -0.1        0.17 =C4=85  8%      +0.0        0=
.25 =C4=85  3%  perf-profile.self.cycles-pp.__schedule
>       0.10 =C4=85 44%      -0.1        0.05 =C4=85 71%      +0.0        0=
.15 =C4=85  3%  perf-profile.self.cycles-pp.pick_next_task_fair
>       0.08 =C4=85 19%      -0.1        0.03 =C4=85100%      -0.0        0=
.06 =C4=85  7%  perf-profile.self.cycles-pp.pick_eevdf
>       0.04 =C4=85 44%      -0.0        0.00            +0.0        0.07 =
=C4=85  8%  perf-profile.self.cycles-pp.__x64_sys_fcntl
>       0.06 =C4=85  7%      -0.0        0.03 =C4=85100%      -0.0        0=
.06 =C4=85  8%  perf-profile.self.cycles-pp.lapic_next_deadline
>       0.13 =C4=85  7%      -0.0        0.10 =C4=85 10%      +0.0        0=
.13 =C4=85  8%  perf-profile.self.cycles-pp.__switch_to
>       0.09 =C4=85  8%      -0.0        0.06 =C4=85  8%      +0.0        0=
.10        perf-profile.self.cycles-pp.__update_load_avg_se
>       0.08 =C4=85  4%      -0.0        0.05 =C4=85  7%      -0.0        0=
.07        perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.08 =C4=85  9%      -0.0        0.06 =C4=85 11%      -0.0        0=
.05 =C4=85  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64
>       0.06 =C4=85  7%      +0.0        0.08 =C4=85  8%      +0.0        0=
.07 =C4=85  8%  perf-profile.self.cycles-pp.filemap_map_pages
>       0.12 =C4=85  3%      +0.0        0.14 =C4=85  4%      +0.0        0=
.13 =C4=85  6%  perf-profile.self.cycles-pp.folios_put_refs
>       0.25 =C4=85  2%      +0.0        0.27 =C4=85  3%      +0.0        0=
.27 =C4=85  6%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
>       0.17 =C4=85  5%      +0.0        0.20 =C4=85  6%      -0.0        0=
.17 =C4=85  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.64 =C4=85  7%      +0.1        0.70 =C4=85 15%      -0.5        0=
.17 =C4=85 11%  perf-profile.self.cycles-pp.fput_close_sync
>       0.00            +0.1        0.07 =C4=85  5%      +0.0        0.00  =
      perf-profile.self.cycles-pp.do_nanosleep
>       0.00            +0.1        0.10 =C4=85 15%      +0.0        0.00  =
      perf-profile.self.cycles-pp.filp_close
>       0.00           +43.9       43.86 =C4=85  2%     +19.4       19.35  =
      perf-profile.self.cycles-pp.fput_close
>
>


--=20
Mateusz Guzik <mjguzik gmail.com>

