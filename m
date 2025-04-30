Return-Path: <linux-fsdevel+bounces-47708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9D5AA46D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 11:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7603BE976
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A6021CC4D;
	Wed, 30 Apr 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h95Pj+uN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C754288CC
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004593; cv=none; b=gDfMLNuaF1MS414cIMzSCerlX4hF7jI0wLk3vPLoF1yBQ1mNwkg6y5/vxRFyaORgBZ6TRHQLGej1Fe17Ig2sIK4SwuUR+DQ+2a55TD/7sGGrPhgcRIF81ySUGB+Uw+7hydLQthqq/LYdBi6nIhhp8c9i4SE7eQYqMW6egla19lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004593; c=relaxed/simple;
	bh=9sg3geL+Vq/SstBgQY04tVrifsekE9PoUEd2W+9CMHI=;
	h=From:Mime-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=k4VWHX7NrkU5wdjyVmkuDL+PbWNk6GzFzEOBje80UY4kpqmqt45r8UGzKyh2LfFLnKltjIoblLlXAmuxZwqSbxLT8xwySnllUdgRuy1WVBX5oUGTfRoIOVG61KOqPw2yQR0mfIVY/NXBRq3D1Ojj6+mXn7KABwe4CWE8lr9ZduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h95Pj+uN; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-523ffbe0dbcso7158809e0c.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1746004589; x=1746609389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :mime-version:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/FpfmJioAdNJY0+TNoNhbjTHHg1RLhLRSXLwyGVuMec=;
        b=h95Pj+uNBnWAgApCSYK4H6EjMgVPN1kbZ+jOvj9selegGRHOslJPACvZrLwONA89wh
         cnOtiej8KTmisBocazCRUgNwnhl1OXd2v5KhdXvMfXpJf3JLpR+A49CuBis/bonim2Z7
         d/Epeu/Pgvo7nUSGBwrL2BTG59R8EOsRW/K5qziW7AOfJnO4hd8eWgoVbDrVnAlaLNvK
         SPdmSyQZqSWJnZXt8lo/Hb9xadWtpjm72iwzEgwpccYgSNpWsOA5Un6ABsothXYK0DTe
         sjBPOaYtgPMH8FIpqW/gCVpvrjfJQK88zY/KagretL9KPyGhorPYxQEAo4sSBgIi6k5l
         m67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746004589; x=1746609389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :mime-version:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FpfmJioAdNJY0+TNoNhbjTHHg1RLhLRSXLwyGVuMec=;
        b=dtxXwUpjGaX8njJ3rQOW2H/bjKxVRLHdgCc1lfMiRgNhWRJLtBmk9w3Scvphsh1gFU
         7DoJKrwRGOs9TFqBC/5SaSDr5QtTP3xA8yH7+0oUvHopYTIozr0+Pct2i0kiFEbj06P+
         Vcz8rPSCTuT2Unn+JaGSaatI/kuOLPUjuFj7gf5Zz4H5RjouqNoQbvnL6YdKznShcMyB
         xH6ak1zwgoL90NHKYNGrWTf+K9BKF58Qp/XFjyGTb5D6Qd51uzzZpIvV8gKpayboNWSR
         PYTRQxltYQf3ZMQGva9P8TeVoORXPRlvycKIjhebd+RzqzV6kucRIx5kGk03a4HJEhnn
         u+ow==
X-Forwarded-Encrypted: i=1; AJvYcCUpk1bPANMBKnwZ4nwtYwzwofzTiYNIGvCOK4EOsZEtm202Qdawk1Njwv4ba9BmKfTm4GNC3NVLPZF6Bu9d@vger.kernel.org
X-Gm-Message-State: AOJu0Yxar0yK2fE8NyBaANP6xdOhwaVMzfz5Qoco/f3OC70DHK8U9T7Z
	Ssvw7A19YWISjUT7dD4rmDiRG2wUEiQGm5vuUpEaXkJHobSkVRcVJlSgnOLv7rHeD4U71H7BHMI
	SFQv5x9mAx73hSJ2WPp4DJQ1JxCJLViylIKN6
X-Gm-Gg: ASbGncuj/p9OXh3EukzIQJ2yxHqgReJLgsuWxLaBMri8na22eldpW0NcINrTOzOvEbj
	DQK/FM4ifeUoVrbawbyzq7s2VbuMo+REgs0hyx1jHCRucMdd+FmzqY3YdM3fSSFPJ0AfG029BKf
	304P8ip5GF/PbJqPnER/YGLUE=
X-Google-Smtp-Source: AGHT+IGUdyWIFWemUxR8cGlbp009kWxdylwhOsecl9akidqkmz+IWKOdRPTajULbkm3Y8k761QMI67Wsmq2VLhQzLm0=
X-Received: by 2002:a05:6122:2224:b0:529:2644:676f with SMTP id
 71dfb90a1353d-52acd87ab74mr1464395e0c.8.1746004589261; Wed, 30 Apr 2025
 02:16:29 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 30 Apr 2025 04:16:28 -0500
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 30 Apr 2025 04:16:28 -0500
From: Jiadong Sun <sunjiadong.lff@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Original-From: Jiadong Sun <sunjiadong.lff@bytedance.com>
Date: Wed, 30 Apr 2025 04:16:28 -0500
X-Gm-Features: ATxdqUE1GlU75dtjYcQizNLW2r1BtvIcFNfsvG_F7FYhdKaVVj2RrFltONH9NoA
Message-ID: <CAP2HCOmAkRVTci0ObtyW=3v6GFOrt9zCn2NwLUbZ+Di49xkBiw@mail.gmail.com>
Subject: [RFC] optimize cost of inter-process communication
To: luto@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	akpm@linux-foundation.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	duanxiongchun@bytedance.com, yinhongbo@bytedance.com, 
	dengliang.1214@bytedance.com, xieyongji@bytedance.com, 
	chaiwen.cc@bytedance.com, songmuchun@bytedance.com, yuanzhu@bytedance.com, 
	sunjiadong.lff@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

# Background

In traditional inter-process communication (IPC) scenarios, Unix domain
sockets are commonly used in conjunction with the epoll() family for
event multiplexing. IPC operations involve system calls on both the data
and control planes, thereby imposing a non-trivial overhead on the
interacting processes. Even when shared memory is employed to optimize
the data plane, two data copies still remain. Specifically, data is
initially copied from a process's private memory space into the shared
memory area, and then it is copied from the shared memory into the
private memory of another process.

This poses a question: Is it possible to reduce the overhead of IPC with
only minimal modifications at the application level? To address this, we
observed that the functionality of IPC, which encompasses data transfer
and invocation of the target thread, is similar to a function call,
where arguments are passed and the callee function is invoked to process
them. Inspired by this analogy, we introduce RPAL (Run Process As
Library), a framework designed to enable one process to invoke another
as if making a local function call, all without going through the kernel.

# Design

First, let=E2=80=99s formalize RPAL=E2=80=99s core objectives:

1. Data-plane efficiency: Reduce the number of data copies from two (in
the shared memory solution) to one.
2. Control-plane optimization: Eliminate the overhead of system calls
and kernel's thread switches.
3. Application compatibility: Minimize the modifications to existing
applications that utilize Unix domain sockets and the epoll() family.

To attain the first objective, processes that use RPAL share the same
virtual address space. So one process can access another's data directly
via a data pointer. This means data can be transferred from one process
to another with just one copy operation.

To meet the second goal, RPAL relies on the shared address space to do
lightweight context switching in user space, which we call an "RPAL
call". This allows one process to execute another process's code just
like a local function call.

To achieve the third target, RPAL stays compatible with the epoll family
of functions, like epoll_create(), epoll_wait(), and epoll_ctl(). If an
application uses epoll for IPC, developers can switch to RPAL with just
a few small changes. For instance, you can just replace epoll_wait()
with rpal_epoll_wait(). The basic epoll procedure, where a process waits
for another to write to a monitored descriptor using an epoll file
descriptor, still works fine with RPAL.

## Address space sharing

For address space sharing, RPAL partitions the entire userspace virtual
address space and allocates non-overlapping memory ranges to each
process. On x86_64 architectures, RPAL uses a memory range size covered
by a single PUD (Page Upper Directory) entry, which is 512GB. This
restricts each process=E2=80=99s virtual address space to 512GB on x86_64,
sufficient for most applications in our scenario. The rationale is
straightforward: address space sharing can be simply achieved by copying
the PUD from one process=E2=80=99s page table to another=E2=80=99s. So one =
process can
directly use the data pointer to access another's memory.


  |------------| <- 0
  |------------| <- 512 GB
  |  Process A |
  |------------| <- 2*512 GB
  |------------| <- n*512 GB
  |  Process B |
  |------------| <- (n+1)*512 GB
  |------------| <- STACK_TOP
  |  Kernel    |
  |------------|

## RPAL call

We refer to the lightweight userspace context switching mechanism as
RPAL call. It enables the caller (or sender) thread of one process to
directly switch to the callee (or receiver) thread of another process.

When Process A=E2=80=99s caller thread initiates an RPAL call to Process B=
=E2=80=99s
callee thread, the CPU saves the caller=E2=80=99s context and loads the cal=
lee=E2=80=99s
context. This enables direct userspace control flow transfer from the
caller to the callee. After the callee finishes data processing, the CPU
saves Process B=E2=80=99s callee context and switches back to Process A=E2=
=80=99s caller
context, completing a full IPC cycle.


  |------------|                |---------------------|
  |  Process A |                |  Process B          |
  | |-------|  |                | |-------|           |
  | | caller| --- RPAL call --> | | callee|    handle |
  | | thread| <------------------ | thread| -> event  |
  | |-------|  |                | |-------|           |
  |------------|                |---------------------|

# Security and compatibility with kernel subsystems

## Memory protection between processes

Since processes using RPAL share the address space, unintended
cross-process memory access may occur and corrupt the data of another
process. To mitigate this, we leverage Memory Protection Keys (MPK) on
x86 architectures.

MPK assigns 4 bits in each page table entry to a "protection key", which
is paired with a userspace register (PKRU). The PKRU register defines
access permissions for memory regions protected by specific keys (for
detailed implementation, refer to the kernel documentation "Memory
Protection Keys"). With MPK, even though the address space is shared
among processes, cross-process access is restricted: a process can only
access the memory protected by a key if its PKRU register is configured
with the corresponding permission. This ensures that processes cannot
access each other=E2=80=99s memory unless an explicit PKRU configuration is=
 set.

## Page fault handling and TLB flushing

Due to the shared address space architecture, both page fault handling
and TLB flushing require careful consideration. For instance, when
Process A accesses Process B=E2=80=99s memory, a page fault may occur in Pr=
ocess
A's context, but the faulting address belongs to Process B. In this
case, we must pass Process B's mm_struct to the page fault handler.

TLB flushing is more complex. When a thread flushes the TLB, since the
address space is shared, not only other threads in the current process
but also other processes that share the address space may access the
corresponding memory (related to the TLB flush). Therefore, the cpuset
used for TLB flushing should be the union of the mm_cpumasks of all
processes that share the address space.

## Lazy switch of kernel context

In RPAL, a mismatch may arise between the user context and the kernel
context. The RPAL call is designed solely to switch the user context,
leaving the kernel context unchanged. For instance, when an RPAL call
takes place, transitioning from caller thread to callee thread, and
subsequently a system call is initiated within callee thread, the kernel
will incorrectly utilize the caller's kernel context (such as the kernel
stack) to process the system call.

To resolve context mismatch issues, a kernel context switch is triggered
at the kernel entry point when the callee initiates a syscall or an
exception/interrupt occurs. This mechanism ensures context consistency
before processing system calls, interrupts, or exceptions. We refer to
this kernel context switch as a "lazy switch" because it defers the
switching operation from the traditional thread switch point to the next
kernel entry point.

Lazy switch should be minimized as much as possible, as it significantly
degrades performance. We currently utilize RPAL in an RPC framework, in
which the RPC sender thread relies on the RPAL call to invoke the RPC
receiver thread entirely in user space. In most cases, the receiver
thread is free of system calls and the code execution time is relatively
short. This characteristic effectively reduces the probability of a lazy
switch occurring.

## Time slice correction

After an RPAL call, the callee's user mode code executes. However, the
kernel incorrectly attributes this CPU time to the caller due to the
unchanged kernel context.

To resolve this, we use the Time Stamp Counter (TSC) register to measure
CPU time consumed by the callee thread in user space. The kernel then
uses this user-reported timing data to adjust the CPU accounting for
both the caller and callee thread, similar to how CPU steal time is
implemented.

## Process recovery

Since processes can access each other=E2=80=99s memory, there is a risk tha=
t the
target process=E2=80=99s memory may become invalid at the access time (e.g.=
, if
the target process has exited unexpectedly). The kernel must handle such
cases; otherwise, the accessing process could be terminated due to
failures originating from another process.

To address this issue, each thread of the process should pre-establish a
recovery point when accessing the memory of other processes. When such
an invalid access occurs, the thread traps into the kernel. Inside the
page fault handler, the kernel restores the user context of the thread
to the recovery point. This mechanism ensures that processes maintain
mutual independence, preventing cascading failures caused by
cross-process memory issues.

# Performance

To quantify the performance improvements driven by RPAL, we measured
latency both before and after its deployment. Experiments were conducted
on a server equipped with two Intel(R) Xeon(R) Platinum 8336C CPUs (2.30
GHz) and 1 TB of memory. Latency was defined as the duration from when
the client thread initiates a message to when the server thread is
invoked and receives it.

During testing, the client transmitted 1 million 32-byte messages, and
we computed the per-message average latency. The results are as follows:

*****************
Without RPAL: Message length: 32 bytes, Total TSC cycles: 19616222534,
Message count: 1000000, Average latency: 19616 cycles
With RPAL: Message length: 32 bytes, Total TSC cycles: 1703459326,
Message count: 1000000, Average latency: 1703 cycles
*****************

These results confirm that RPAL delivers substantial latency
improvements over the current epoll implementation=E2=80=94achieving a
17,913-cycle reduction (an ~91.3% improvement) for 32-byte messages.

We have applied RPAL to an RPC framework that is widely used in our data
center. With RPAL, we have successfully achieved up to 15.5% reduction
in the CPU utilization of processes in real-world microservice scenario.
The gains primarily stem from minimizing control plane overhead through
the utilization of userspace context switches. Additionally, by
leveraging address space sharing, the number of memory copies is
significantly reduced.

# Future Work

Currently, RPAL requires the MPK (Memory Protection Key) hardware
feature, which is supported by a range of Intel CPUs. For AMD
architectures, MPK is supported only on the latest processor,
specifically, 4th Generation AMD EPYC=E2=84=A2 Processors and subsequent
generations. Patch sets that extend RPAL support to systems lacking MPK
hardware will be provided later.

RPAL is currently implemented on the Linux v5.15 kernel, which is
publicly available at:

             https://github.com/openvelinux/kernel/tree/5.15-rpal

Accompanying test programs are also provided in the samples/rpal/
directory. And the user-mode RPAL library, which realizes user-space
RPAL call, is in the samples/rpal/librpal directory.

We are in the process of porting RPAL to the latest kernel version,
which still requires substantial effort. We hope to firstly get some
community discussions and feedback on RPAL's optimization approaches and
architecture.

Look forward to your comments.

Jiadong Sun (11):
   rpal: enable rpal service registration
   rpal: enable virtual address space partitions
   rpal: add user interface for rpal service
   rpal: introduce service level operations
   rpal: introduce thread level operations
   rpal: enable epoll functions support for rpal
   rpal: enable lazy switch
   rpal: enable pku memory protection
   rpal: support page fault handling and tlb flushing
   rpal: allow user to disable rpal
   samples: add rpal samples

  arch/x86/Kconfig                                 |    2 +
  arch/x86/entry/entry_64.S                        |  140 +++++++++++
  arch/x86/events/amd/core.c                       |   16 ++
  arch/x86/include/asm/cpufeatures.h               |    3 +-
  arch/x86/include/asm/pgtable.h                   |   13 +
  arch/x86/include/asm/pgtable_types.h             |   11 +
  arch/x86/include/asm/tlbflush.h                  |    5 +
  arch/x86/kernel/Makefile                         |    2 +
  arch/x86/kernel/asm-offsets.c                    |    4 +-
  arch/x86/kernel/nmi.c                            |   21 ++
  arch/x86/kernel/process.c                        |   19 ++
  arch/x86/kernel/process_64.c                     |  106 ++++++++
  arch/x86/kernel/rpal/Kconfig                     |   21 ++
  arch/x86/kernel/rpal/Makefile                    |    4 +
  arch/x86/kernel/rpal/core.c                      |  698
+++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/x86/kernel/rpal/internal.h                  |  130 ++++++++++
  arch/x86/kernel/rpal/mm.c                        |  456
++++++++++++++++++++++++++++++++++
  arch/x86/kernel/rpal/pku.c                       |  240 +++++++++++++++++=
+
  arch/x86/kernel/rpal/proc.c                      |  208 ++++++++++++++++
  arch/x86/kernel/rpal/service.c                   |  869
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  arch/x86/kernel/rpal/thread.c                    |  432
++++++++++++++++++++++++++++++++
  arch/x86/mm/fault.c                              |  243 +++++++++++++++++=
+
  arch/x86/mm/mmap.c                               |   10 +
  arch/x86/mm/tlb.c                                |  170 ++++++++++++-
  config.x86_64                                    |    2 +
  fs/binfmt_elf.c                                  |  103 +++++++-
  fs/eventpoll.c                                   |  306
+++++++++++++++++++++++
  fs/exec.c                                        |   11 +
  fs/file_table.c                                  |   10 +
  include/linux/file.h                             |   13 +
  include/linux/mm_types.h                         |    3 +
  include/linux/rpal.h                             |  529
+++++++++++++++++++++++++++++++++++++++
  include/linux/sched.h                            |   15 ++
  init/init_task.c                                 |    8 +
  kernel/entry/common.c                            |   29 +++
  kernel/exit.c                                    |    5 +
  kernel/fork.c                                    |   23 ++
  kernel/sched/core.c                              |  749
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
  kernel/sched/fair.c                              |  128 ++++++++++
  mm/memory.c                                      |   13 +
  mm/mmap.c                                        |   35 +++
  mm/mprotect.c                                    |  112 +++++++++
  mm/rmap.c                                        |    5 +
  samples/rpal/Makefile                            |   14 ++
  samples/rpal/client.c                            |  182 ++++++++++++++
  samples/rpal/librpal/asm_define.h                |    9 +
  samples/rpal/librpal/asm_x86_64_rpal_call.S      |   57 +++++
  samples/rpal/librpal/debug.h                     |   12 +
  samples/rpal/librpal/fiber.c                     |  119 +++++++++
  samples/rpal/librpal/fiber.h                     |   64 +++++
  samples/rpal/librpal/jump_x86_64_sysv_elf_gas.S  |   81 ++++++
  samples/rpal/librpal/make_x86_64_sysv_elf_gas.S  |   82 ++++++
  samples/rpal/librpal/ontop_x86_64_sysv_elf_gas.S |   84 +++++++
  samples/rpal/librpal/private.h                   |  302
++++++++++++++++++++++
  samples/rpal/librpal/rpal.c                      | 2560
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++
  samples/rpal/librpal/rpal.h                      |  155 ++++++++++++
  samples/rpal/librpal/rpal_pkru.h                 |   78 ++++++
  samples/rpal/librpal/rpal_queue.c                |  239 +++++++++++++++++=
+
  samples/rpal/librpal/rpal_queue.h                |   55 ++++
  samples/rpal/librpal/rpal_x86_64_call_ret.S      |   45 ++++
  samples/rpal/server.c                            |  249
+++++++++++++++++++
  61 files changed, 10304 insertions(+), 5 deletions(-)
  create mode 100644 arch/x86/kernel/rpal/Kconfig
  create mode 100644 arch/x86/kernel/rpal/Makefile
  create mode 100644 arch/x86/kernel/rpal/core.c
  create mode 100644 arch/x86/kernel/rpal/internal.h
  create mode 100644 arch/x86/kernel/rpal/mm.c
  create mode 100644 arch/x86/kernel/rpal/pku.c
  create mode 100644 arch/x86/kernel/rpal/proc.c
  create mode 100644 arch/x86/kernel/rpal/service.c
  create mode 100644 arch/x86/kernel/rpal/thread.c
  create mode 100644 include/linux/rpal.h
  create mode 100644 samples/rpal/Makefile
  create mode 100644 samples/rpal/client.c
  create mode 100644 samples/rpal/librpal/asm_define.h
  create mode 100644 samples/rpal/librpal/asm_x86_64_rpal_call.S
  create mode 100644 samples/rpal/librpal/debug.h
  create mode 100644 samples/rpal/librpal/fiber.c
  create mode 100644 samples/rpal/librpal/fiber.h
  create mode 100644 samples/rpal/librpal/jump_x86_64_sysv_elf_gas.S
  create mode 100644 samples/rpal/librpal/make_x86_64_sysv_elf_gas.S
  create mode 100644 samples/rpal/librpal/ontop_x86_64_sysv_elf_gas.S
  create mode 100644 samples/rpal/librpal/private.h
  create mode 100644 samples/rpal/librpal/rpal.c
  create mode 100644 samples/rpal/librpal/rpal.h
  create mode 100644 samples/rpal/librpal/rpal_pkru.h
  create mode 100644 samples/rpal/librpal/rpal_queue.c
  create mode 100644 samples/rpal/librpal/rpal_queue.h
  create mode 100644 samples/rpal/librpal/rpal_x86_64_call_ret.S
  create mode 100644 samples/rpal/server.c

--
2.20.1

