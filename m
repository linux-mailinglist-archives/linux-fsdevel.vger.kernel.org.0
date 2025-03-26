Return-Path: <linux-fsdevel+bounces-45058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC07A70F94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 04:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EEC617995E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 03:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C3A17A31D;
	Wed, 26 Mar 2025 03:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obw1flVE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E55145B3F;
	Wed, 26 Mar 2025 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742960159; cv=none; b=oTdIvpfQHuLd6ypjD5wvleewi3rhO5xIR+spUKnw88/kIM6SBbX4dUzG5XngkBMDkcepkBB+vavVxOcf1f/i6OYldjtjodLeLbh8lp7Zo1nwlYToBHjTLqOV+oyuD+x/m/zrXV7XGfu+UB1bKRu/SsviBTMY2tPKpqSXX+BNmQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742960159; c=relaxed/simple;
	bh=zQNN1ki8h9kqS90OTVQimlrFmuW5TF2JapKQcSFEGKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fP92l2KTlwtbFsRB0T/++CwgjpLx+9/AUCBGSBBHIOHC8ZwSCntcPzEugyhRgt4ed+i14vAQOb1w8EDaoFSrlWqYdwVNgnmfXqQcDTaCnSNw98a/gD7sXkjH7p9RkK9auSQSouBgO1C/HxdZHywgGfWrVw2/ixv+Nly4Z526+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Obw1flVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF7BC4CEFB;
	Wed, 26 Mar 2025 03:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742960158;
	bh=zQNN1ki8h9kqS90OTVQimlrFmuW5TF2JapKQcSFEGKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Obw1flVEtxyMUW/At/kneqHxfCrKDMIfEBFv6McvFjYFOdcgZ6npv9tpvKo8mv8ez
	 wGZczvLlTbwcByRGQXLWST31lvnljN0K1TYOEQNl++JU6gesu67Lv09Sf66/NYLzNi
	 /BlGafMrBXix8SlQf7Ytl8uqTnChZahZwTUOXdN5gobvhjt5mEDD01xJpFOu0bvDPf
	 5OrUG8/fLcLDvWMTCvvqLQzKrAPQzWEoHP21x4jU85mEJpCNChLVCiwhu1hXuNLtfi
	 CQrEykMsCttEVhpMlGtOu4ZYvulksl9mU2IGksPM9t0ie19bmWEXivkDoSyGD/JTFt
	 c3ClMFEb/+6hA==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0618746bso43352855e9.2;
        Tue, 25 Mar 2025 20:35:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU94UNJklLRj0/LqLKSuD7MSthhNRWN+94q+Tm/YR99BWxJ9wjl5VTFKITOmcXrGEHA+sqNFZYRyW8tBg==@vger.kernel.org, AJvYcCUHtw2rdXI9nkHnBx1JWMuFhpvrKL7JMqEXJ2JDbR0BXs39vFww6DZ1WPrMzr/2dlYmqMdCJva3@vger.kernel.org, AJvYcCUN/rM3OyqzCji3yAAeuNbj+SFLrsEEc1r+MvtFSYIm7n2J9cq2EQKFtmFJSOjemeuMsKVP/79Loa5uLw==@vger.kernel.org, AJvYcCUOJB1k0WH8VsooQHBQBGpMQC3qK4+0mjkFMvp2MPiW1saMEhpNMKTk8zaswMiF60tgC+WHQB7Hcpuw@vger.kernel.org, AJvYcCUUOtusO85bu5sTv0/LZr9uwIfQNrWr+If90I8mY5C8liOam0CxCWlLqQX4oEJzOJE7FnqaSa5bQkfI3zPq@vger.kernel.org, AJvYcCUkgBw/8lWusfr0oUUtoHHLI5WJrx3Gq5ludqJmtWPW9ABe/HImtpRDvA8feyd6d9yMLIM=@vger.kernel.org, AJvYcCV0y9Rp3WyPr+ROHj8Tc5kMkkyfJ5Pa75mbmqtaQKskXMN23z3v2w4WM99LpKCaxXT5Ym9jKsf67VoSoyE6@vger.kernel.org, AJvYcCVHngYl9Doxk/6LTaPNnyOiEHMRCWnWRrQqP4E6UrlgQXiJaDqUTCq7wC9ddAxtAcW3+emRCDWkespEF54=@vger.kernel.org, AJvYcCVi9vOGzA1eRUJElCgNM+zvgpssGgSbcMwTF45ZqAoeiJMlLhtIzlTZ+E9gnAF40Mkh/0Gcv4794usD@vger.kernel.org, AJvYcCVqhEJuF1WZppYCb8LsY8uabRpjVB+Zt6cYy4fU
 rrVXZF+X5xErJXvHe4bHHnGYVnmF7gqDQv/BuuoLMOrT5lcafwKH@vger.kernel.org, AJvYcCW63N7tDBzrwRDfJ4GTXHwrSwJ1MLfOI2sF5yDuo4PBhVzYvQa6kRIug1IPRFlK2Gh34YEvHamkCS27lzNw+Q==@vger.kernel.org, AJvYcCWVheI2MNIJfkbYTdARgJi0TI5N64CPT+eNN1CkLkhEQ3xwtUYozLUct3lcQAiguwVH9mnQYNS9OeJFSVw=@vger.kernel.org, AJvYcCWw/FIx9s/hJj7CY6egS9rkj6exEkqbzz0armpOF6cGPeEzaY2x5b8oGkCPs99p2/SjrzTf@vger.kernel.org, AJvYcCXS3QV/jjstlIc//zcyb3qmBu2e5MtCCu12+3p7PF6e+LOoTttgT4pjX7inT1JSaTK3t4ZsgoTg+Hfp2zhW@vger.kernel.org, AJvYcCXmRi+YVC5n4A0R2C0x/2mFcBlyYBILrM7xJsy1syggC+VryuohIrPxDZFdNcSBDciMSP4KNaCKHqNYyX9oBvpn@vger.kernel.org, AJvYcCXtqN9GUfDfas3BqMfcTH9GLaakjUO8b6S45fhqKZFLlFzldaFOBCkrmY5tZhMPv9gwbsHrSjamR/1MV8E=@vger.kernel.org, AJvYcCXvriLTZuDx01UMTmS5vRafnOnASNeXfgADwPyt0mbTvJR+7FoXN4nwt8aaqLb/JRa5m6+i0tqDimi29qYEW2Gecw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS648DyRW2DuLvMGgQ8DuxpfOpfwGJVx077LqucmlumDBpT8nh
	f7tiZ3otVZs0WgyGHzfhVOsXw5SuzllvlxBbQcK5XMLK2SOyK20g5yri/h1VZgp4jE9h43w8Aa+
	joSvcgKx9JAEBi7rwVNX9WOjc7eM=
X-Google-Smtp-Source: AGHT+IH1qAC7M1zI/GB1SjlJsBUYduB5Ay6a4l3UglXrL2dMWn8mYzFqq7sfxGeFxk8syVmgNIyhBxbe8f3JJEoNutw=
X-Received: by 2002:a5d:5885:0:b0:391:23e7:968d with SMTP id
 ffacd0b85a97d-3997f959582mr18193138f8f.47.1742960156337; Tue, 25 Mar 2025
 20:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-2-guoren@kernel.org>
 <0024788o-35r0-73q1-1s54-q564p457q33s@vanv.qr>
In-Reply-To: <0024788o-35r0-73q1-1s54-q564p457q33s@vanv.qr>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 26 Mar 2025 11:35:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT8oATgSmOZNMRTRshbAo0kCZWHwZov7qgE5NqjHvsJMQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrGUbEH86Vmh44AHPZHOEZYFZr2PCQWEd8Vzn0mDV8EcIgvHnzVisOp1Qw
Message-ID: <CAJF2gTT8oATgSmOZNMRTRshbAo0kCZWHwZov7qgE5NqjHvsJMQ@mail.gmail.com>
Subject: Re: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
To: Jan Engelhardt <ej@inai.de>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, anup@brainfault.org, 
	atishp@atishpatra.org, oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, 
	will@kernel.org, mark.rutland@arm.com, brauner@kernel.org, 
	akpm@linux-foundation.org, rostedt@goodmis.org, edumazet@google.com, 
	unicorn_wang@outlook.com, inochiama@outlook.com, gaohan@iscas.ac.cn, 
	shihua@iscas.ac.cn, jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, peterz@infradead.org, 
	boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, 
	leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, 
	ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 4:31=E2=80=AFAM Jan Engelhardt <ej@inai.de> wrote:
>
>
> On Tuesday 2025-03-25 13:15, guoren@kernel.org wrote:
>
> >diff --git a/include/uapi/linux/netfilter/x_tables.h b/include/uapi/linu=
x/netfilter/x_tables.h
> >index 796af83a963a..7e02e34c6fad 100644
> >--- a/include/uapi/linux/netfilter/x_tables.h
> >+++ b/include/uapi/linux/netfilter/x_tables.h
> >@@ -18,7 +18,11 @@ struct xt_entry_match {
> >                       __u8 revision;
> >               } user;
> >               struct {
> >+#if __riscv_xlen =3D=3D 64
> >+                      __u64 match_size;
> >+#else
> >                       __u16 match_size;
> >+#endif
> >
> >                       /* Used inside the kernel */
> >                       struct xt_match *match;
>
> The __u16 is the common prefix of the union which is exposed to userspace=
.
> If anything, you need to use __attribute__((aligned(8))) to move
> `match` to a fixed location.
>
> However, that sub-struct is only used inside the kernel and never exposed=
,
> so the alignment of `match` should not play a role.
>
> Moreover, change from u16 to u64 would break RISC-V Big-Endian. Even if t=
here
> currently is no big-endian variant, let's not introduce such breakage.
You're correct. The __u64 modification is too raw from the proof of
concept. It's not correct, so I would accept your advice.

>
>
> >--- a/include/uapi/linux/netfilter_ipv4/ip_tables.h
> >+++ b/include/uapi/linux/netfilter_ipv4/ip_tables.h
> >@@ -200,7 +200,14 @@ struct ipt_replace {
> >       /* Number of counters (must be equal to current number of entries=
). */
> >       unsigned int num_counters;
> >       /* The old entries' counters. */
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              struct xt_counters __user *counters;
> >+              __u64 __counters;
> >+      };
> >+#else
> >       struct xt_counters __user *counters;
> >+#endif
> >
> >       /* The entries (hang off end: not really an array). */
> >       struct ipt_entry entries[];
>
> This seems ok, but perhaps there is a better name for __riscv_xlen (ifdef
> CONFIG_????ilp32), so it is not strictly tied to riscv,
> in case other platform wants to try ilp32-self mode.
Yes, I want that macro, but Linus has suggested "compat stuff". I
would have to try.

Thx for the reviewing!

>
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              int __user *auth_flavours;              /* 1 */
> >+              __u64 __auth_flavours;
> >+      };
> >+#else
> >       int __user *auth_flavours;              /* 1 */
> >+#endif
> > };
> >
> > /* bits in the flags field */
> >diff --git a/include/uapi/linux/ppp-ioctl.h b/include/uapi/linux/ppp-ioc=
tl.h
> >index 1cc5ce0ae062..8d48eab430c1 100644
> >--- a/include/uapi/linux/ppp-ioctl.h
> >+++ b/include/uapi/linux/ppp-ioctl.h
> >@@ -59,7 +59,14 @@ struct npioctl {
> >
> > /* Structure describing a CCP configuration option, for PPPIOCSCOMPRESS=
 */
> > struct ppp_option_data {
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              __u8    __user *ptr;
> >+              __u64   __ptr;
> >+      };
> >+#else
> >       __u8    __user *ptr;
> >+#endif
> >       __u32   length;
> >       int     transmit;
> > };
> >diff --git a/include/uapi/linux/sctp.h b/include/uapi/linux/sctp.h
> >index b7d91d4cf0db..46a06fddcd2f 100644
> >--- a/include/uapi/linux/sctp.h
> >+++ b/include/uapi/linux/sctp.h
> >@@ -1024,6 +1024,9 @@ struct sctp_getaddrs_old {
> > #else
> >       struct sockaddr         *addrs;
> > #endif
> >+#if (__riscv_xlen =3D=3D 64) && (__SIZEOF_LONG__ =3D=3D 4)
> >+      __u32                   unused;
> >+#endif
> > };
>
>
> >
> > struct sctp_getaddrs {
> >diff --git a/include/uapi/linux/sem.h b/include/uapi/linux/sem.h
> >index 75aa3b273cd9..de9f441913cd 100644
> >--- a/include/uapi/linux/sem.h
> >+++ b/include/uapi/linux/sem.h
> >@@ -26,10 +26,29 @@ struct semid_ds {
> >       struct ipc_perm sem_perm;               /* permissions .. see ipc=
.h */
> >       __kernel_old_time_t sem_otime;          /* last semop time */
> >       __kernel_old_time_t sem_ctime;          /* create/last semctl() t=
ime */
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              struct sem      *sem_base;              /* ptr to first s=
emaphore in array */
> >+              __u64 __sem_base;
> >+      };
> >+      union {
> >+              struct sem_queue *sem_pending;          /* pending operat=
ions to be processed */
> >+              __u64 __sem_pending;
> >+      };
> >+      union {
> >+              struct sem_queue **sem_pending_last;    /* last pending o=
peration */
> >+              __u64 __sem_pending_last;
> >+      };
> >+      union {
> >+              struct sem_undo *undo;                  /* undo requests =
on this array */
> >+              __u64 __undo;
> >+      };
> >+#else
> >       struct sem      *sem_base;              /* ptr to first semaphore=
 in array */
> >       struct sem_queue *sem_pending;          /* pending operations to =
be processed */
> >       struct sem_queue **sem_pending_last;    /* last pending operation=
 */
> >       struct sem_undo *undo;                  /* undo requests on this =
array */
> >+#endif
> >       unsigned short  sem_nsems;              /* no. of semaphores in a=
rray */
> > };
> >
> >@@ -46,10 +65,29 @@ struct sembuf {
> > /* arg for semctl system calls. */
> > union semun {
> >       int val;                        /* value for SETVAL */
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              struct semid_ds __user *buf;    /* buffer for IPC_STAT & =
IPC_SET */
> >+              __u64 ___buf;
> >+      };
> >+      union {
> >+              unsigned short __user *array;   /* array for GETALL & SET=
ALL */
> >+              __u64 __array;
> >+      };
> >+      union {
> >+              struct seminfo __user *__buf;   /* buffer for IPC_INFO */
> >+              __u64 ____buf;
> >+      };
> >+      union {
> >+              void __user *__pad;
> >+              __u64 ____pad;
> >+      };
> >+#else
> >       struct semid_ds __user *buf;    /* buffer for IPC_STAT & IPC_SET =
*/
> >       unsigned short __user *array;   /* array for GETALL & SETALL */
> >       struct seminfo __user *__buf;   /* buffer for IPC_INFO */
> >       void __user *__pad;
> >+#endif
> > };
> >
> > struct  seminfo {
> >diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
> >index d3fcd3b5ec53..5f7a83649395 100644
> >--- a/include/uapi/linux/socket.h
> >+++ b/include/uapi/linux/socket.h
> >@@ -22,7 +22,14 @@ struct __kernel_sockaddr_storage {
> >                               /* space to achieve desired size, */
> >                               /* _SS_MAXSIZE value minus size of ss_fam=
ily */
> >               };
> >+#if __riscv_xlen =3D=3D 64
> >+              union {
> >+                      void *__align; /* implementation specific desired=
 alignment */
> >+                      u64 ___align;
> >+              };
> >+#else
> >               void *__align; /* implementation specific desired alignme=
nt */
> >+#endif
> >       };
> > };
> >
> >diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
> >index 8981f00204db..8ed7b29897f9 100644
> >--- a/include/uapi/linux/sysctl.h
> >+++ b/include/uapi/linux/sysctl.h
> >@@ -33,13 +33,45 @@
> >                                  member of a struct __sysctl_args to ha=
ve? */
> >
> > struct __sysctl_args {
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              int __user *name;
> >+              __u64 __name;
> >+      };
> >+#else
> >       int __user *name;
> >+#endif
> >       int nlen;
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              void __user *oldval;
> >+              __u64 __oldval;
> >+      };
> >+#else
> >       void __user *oldval;
> >+#endif
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              size_t __user *oldlenp;
> >+              __u64 __oldlenp;
> >+      };
> >+#else
> >       size_t __user *oldlenp;
> >+#endif
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              void __user *newval;
> >+              __u64 __newval;
> >+      };
> >+#else
> >       void __user *newval;
> >+#endif
> >       size_t newlen;
> >+#if __riscv_xlen =3D=3D 64
> >+      unsigned long long __unused[4];
> >+#else
> >       unsigned long __unused[4];
> >+#endif
> > };
> >
> > /* Define sysctl names first */
> >diff --git a/include/uapi/linux/uhid.h b/include/uapi/linux/uhid.h
> >index cef7534d2d19..4a774dbd3de8 100644
> >--- a/include/uapi/linux/uhid.h
> >+++ b/include/uapi/linux/uhid.h
> >@@ -130,7 +130,14 @@ struct uhid_create_req {
> >       __u8 name[128];
> >       __u8 phys[64];
> >       __u8 uniq[64];
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              __u8 __user *rd_data;
> >+              __u64 __rd_data;
> >+      };
> >+#else
> >       __u8 __user *rd_data;
> >+#endif
> >       __u16 rd_size;
> >
> >       __u16 bus;
> >diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
> >index 649739e0c404..27dfd6032dc6 100644
> >--- a/include/uapi/linux/uio.h
> >+++ b/include/uapi/linux/uio.h
> >@@ -16,8 +16,19 @@
> >
> > struct iovec
> > {
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              void __user *iov_base;  /* BSD uses caddr_t (1003.1g requ=
ires void *) */
> >+              __u64 __iov_base;
> >+      };
> >+      union {
> >+              __kernel_size_t iov_len; /* Must be size_t (1003.1g) */
> >+              __u64 __iov_len;
> >+      };
> >+#else
> >       void __user *iov_base;  /* BSD uses caddr_t (1003.1g requires voi=
d *) */
> >       __kernel_size_t iov_len; /* Must be size_t (1003.1g) */
> >+#endif
> > };
> >
> > struct dmabuf_cmsg {
> >diff --git a/include/uapi/linux/usb/tmc.h b/include/uapi/linux/usb/tmc.h
> >index d791cc58a7f0..443ec5356caf 100644
> >--- a/include/uapi/linux/usb/tmc.h
> >+++ b/include/uapi/linux/usb/tmc.h
> >@@ -51,7 +51,14 @@ struct usbtmc_request {
> >
> > struct usbtmc_ctrlrequest {
> >       struct usbtmc_request req;
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              void __user *data; /* pointer to user space */
> >+              __u64 __data; /* pointer to user space */
> >+      };
> >+#else
> >       void __user *data; /* pointer to user space */
> >+#endif
> > } __attribute__ ((packed));
> >
> > struct usbtmc_termchar {
> >@@ -70,7 +77,14 @@ struct usbtmc_message {
> >       __u32 transfer_size; /* size of bytes to transfer */
> >       __u32 transferred; /* size of received/written bytes */
> >       __u32 flags; /* bit 0: 0 =3D synchronous; 1 =3D asynchronous */
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              void __user *message; /* pointer to header and data in us=
er space */
> >+              __u64 __message;
> >+      };
> >+#else
> >       void __user *message; /* pointer to header and data in user space=
 */
> >+#endif
> > } __attribute__ ((packed));
> >
> > /* Request values for USBTMC driver's ioctl entry point */
> >diff --git a/include/uapi/linux/usbdevice_fs.h b/include/uapi/linux/usbd=
evice_fs.h
> >index 74a84e02422a..8c8efef74c3c 100644
> >--- a/include/uapi/linux/usbdevice_fs.h
> >+++ b/include/uapi/linux/usbdevice_fs.h
> >@@ -44,14 +44,28 @@ struct usbdevfs_ctrltransfer {
> >       __u16 wIndex;
> >       __u16 wLength;
> >       __u32 timeout;  /* in milliseconds */
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              void __user *data;
> >+              __u64 __data;
> >+      };
> >+#else
> >       void __user *data;
> >+#endif
> > };
> >
> > struct usbdevfs_bulktransfer {
> >       unsigned int ep;
> >       unsigned int len;
> >       unsigned int timeout; /* in milliseconds */
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              void __user *data;
> >+              __u64 __data;
> >+      };
> >+#else
> >       void __user *data;
> >+#endif
> > };
> >
> > struct usbdevfs_setinterface {
> >@@ -61,7 +75,14 @@ struct usbdevfs_setinterface {
> >
> > struct usbdevfs_disconnectsignal {
> >       unsigned int signr;
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              void __user *context;
> >+              __u64 __context;
> >+      };
> >+#else
> >       void __user *context;
> >+#endif
> > };
> >
> > #define USBDEVFS_MAXDRIVERNAME 255
> >@@ -119,7 +140,14 @@ struct usbdevfs_urb {
> >       unsigned char endpoint;
> >       int status;
> >       unsigned int flags;
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              void __user *buffer;
> >+              __u64 __buffer;
> >+      };
> >+#else
> >       void __user *buffer;
> >+#endif
> >       int buffer_length;
> >       int actual_length;
> >       int start_frame;
> >@@ -130,7 +158,14 @@ struct usbdevfs_urb {
> >       int error_count;
> >       unsigned int signr;     /* signal to be sent on completion,
> >                                 or 0 if none should be sent. */
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              void __user *usercontext;
> >+              __u64 __usercontext;
> >+      };
> >+#else
> >       void __user *usercontext;
> >+#endif
> >       struct usbdevfs_iso_packet_desc iso_frame_desc[];
> > };
> >
> >@@ -139,7 +174,14 @@ struct usbdevfs_ioctl {
> >       int     ifno;           /* interface 0..N ; negative numbers rese=
rved */
> >       int     ioctl_code;     /* MUST encode size + direction of data s=
o the
> >                                * macros in <asm/ioctl.h> give correct v=
alues */
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              void __user *data;      /* param buffer (in, or out) */
> >+              __u64 __pad;
> >+      };
> >+#else
> >       void __user *data;      /* param buffer (in, or out) */
> >+#endif
> > };
> >
> > /* You can do most things with hubs just through control messages,
> >@@ -195,9 +237,17 @@ struct usbdevfs_streams {
> > #define USBDEVFS_SUBMITURB         _IOR('U', 10, struct usbdevfs_urb)
> > #define USBDEVFS_SUBMITURB32       _IOR('U', 10, struct usbdevfs_urb32)
> > #define USBDEVFS_DISCARDURB        _IO('U', 11)
> >+#if __riscv_xlen =3D=3D 64
> >+#define USBDEVFS_REAPURB           _IOW('U', 12, __u64)
> >+#else
> > #define USBDEVFS_REAPURB           _IOW('U', 12, void *)
> >+#endif
> > #define USBDEVFS_REAPURB32         _IOW('U', 12, __u32)
> >+#if __riscv_xlen =3D=3D 64
> >+#define USBDEVFS_REAPURBNDELAY     _IOW('U', 13, __u64)
> >+#else
> > #define USBDEVFS_REAPURBNDELAY     _IOW('U', 13, void *)
> >+#endif
> > #define USBDEVFS_REAPURBNDELAY32   _IOW('U', 13, __u32)
> > #define USBDEVFS_DISCSIGNAL        _IOR('U', 14, struct usbdevfs_discon=
nectsignal)
> > #define USBDEVFS_DISCSIGNAL32      _IOR('U', 14, struct usbdevfs_discon=
nectsignal32)
> >diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo=
.h
> >index f86185456dc5..3ccb99039a43 100644
> >--- a/include/uapi/linux/uvcvideo.h
> >+++ b/include/uapi/linux/uvcvideo.h
> >@@ -54,7 +54,14 @@ struct uvc_xu_control_mapping {
> >       __u32 v4l2_type;
> >       __u32 data_type;
> >
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              struct uvc_menu_info __user *menu_info;
> >+              __u64 __menu_info;
> >+      };
> >+#else
> >       struct uvc_menu_info __user *menu_info;
> >+#endif
> >       __u32 menu_count;
> >
> >       __u32 reserved[4];
> >@@ -66,7 +73,14 @@ struct uvc_xu_control_query {
> >       __u8 query;             /* Video Class-Specific Request Code, */
> >                               /* defined in linux/usb/video.h A.8.  */
> >       __u16 size;
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              __u8 __user *data;
> >+              __u64 __data;
> >+      };
> >+#else
> >       __u8 __user *data;
> >+#endif
> > };
> >
> > #define UVCIOC_CTRL_MAP               _IOWR('u', 0x20, struct uvc_xu_co=
ntrol_mapping)
> >diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >index c8dbf8219c4f..0a1dc2a780fb 100644
> >--- a/include/uapi/linux/vfio.h
> >+++ b/include/uapi/linux/vfio.h
> >@@ -1570,7 +1570,14 @@ struct vfio_iommu_type1_dma_map {
> > struct vfio_bitmap {
> >       __u64        pgsize;    /* page size for bitmap in bytes */
> >       __u64        size;      /* in bytes */
> >+      #if __riscv_xlen =3D=3D 64
> >+      union {
> >+              __u64 __user *data;     /* one bit per page */
> >+              __u64 __data;
> >+      };
> >+      #else
> >       __u64 __user *data;     /* one bit per page */
> >+      #endif
> > };
> >
> > /**
> >diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videode=
v2.h
> >index e7c4dce39007..8e5391f07626 100644
> >--- a/include/uapi/linux/videodev2.h
> >+++ b/include/uapi/linux/videodev2.h
> >@@ -1898,7 +1898,14 @@ struct v4l2_ext_controls {
> >       __u32 error_idx;
> >       __s32 request_fd;
> >       __u32 reserved[1];
> >+#if __riscv_xlen =3D=3D 64
> >+      union {
> >+              struct v4l2_ext_control *controls;
> >+              __u64 __controls;
> >+      };
> >+#else
> >       struct v4l2_ext_control *controls;
> >+#endif
> > };
> >
> > #define V4L2_CTRL_ID_MASK       (0x0fffffff)
> >--
> >2.40.1
> >
> >



--=20
Best Regards
 Guo Ren

