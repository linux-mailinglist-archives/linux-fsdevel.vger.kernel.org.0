Return-Path: <linux-fsdevel+bounces-50165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A180AC8AB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C1307A017C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70B220F2F;
	Fri, 30 May 2025 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a60OGV5B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096E128E7
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597310; cv=none; b=dU6ZHT/YW7F2sKnK4pa2Jnps9IjyHiXr/q0/r8pUZmdChIqoFb6Q5g4vd00dlbLPEojpMBDq7HdfS7j03Wa2ERN1orMqXoIqQvGj5JdAfZL/4280sZdY+MLYknifwuOWDbX0d4pNVe/MBhQvEOdUMVRp+V4yOmCBDYT2Id0B7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597310; c=relaxed/simple;
	bh=4ZpYH9gjzEMK0JBNxeSHRVQaFIcBi9bPL+YcG/+ScUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fwICN+tNAV+7LdY9GMykvbydWv5yFoDk8Su0G5lHjItyrHSNfMNtzZXD/kFAnL97NlmbA/5IU3+DgEPImCzMsS1XCMQArIcBFKXc4rNqMZjypNVQ5u0bx9byrYwdw/Uz2ts3kn+sP2ZSMgvU5YIBtyUzO4U/pAz6tK8CggFEtPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a60OGV5B; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2349282084bso23232015ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597306; x=1749202106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CczhYEWNGyPrtfRTCWOMeu+EteVzhsXFynQaRlBzWFA=;
        b=a60OGV5BvwE5Q+EJMzbNOsNKtlkoEu1D7N4L492i74V6aNYYf64gF49/xTgsUIh3Bi
         QZxduSz06RHvH+Pma9F+PRcgEwkBDEXbobP1xaKxE33t51Vqz6h+YLGX34EQtTj2Ps7f
         Cad5+mHnAAiLZwR5Fyec4gBuWfOUqKnaCrLM4F3w3ZM+kWUm8qyBZQJq8snilbUQ/GVe
         IvPMurO+aHpE+v22ZWowHpqPn4ZfdusAbffzngapYcFmCW6ocTTmJZm6s/VXGITIgLlM
         6xnHlK1BEju6dN8a/I9EkESxaL1RX3weGgAXDDO615hBrN5Pp1wfsOnuB0JuW7IHzx3F
         hnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597306; x=1749202106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CczhYEWNGyPrtfRTCWOMeu+EteVzhsXFynQaRlBzWFA=;
        b=eJZhVuoe6ANbT4tvJED/SAyjgaZVIa6pxmNH/STCzXOsnyg9A4rjxYiwqPJ47sq2Ff
         pZ0amlweL/+97dT0r2GpIAt5uGND4uerbbWVfKRMZ7TBG1yCZmIIQYQcMuCrJEtskfxB
         RUdjic+tjUwVqI2mdZlx/tPH9yRAHgzW6Ccqoz8pdJC5FDTqM/LEq8OTcoo2OXjOs1N4
         aHwVuGQyvJ2KrqIXOrLwki4HBFa4xcOOk7LHTJOxq/bZi3E0CeXefCOcRYNqTjj1u3/8
         Z3sP6rSdya9n1k5j8gM108i7ZpmSa32tklxn9dpWbGUjS6xWReAgweU6m/vUFJXL6+S3
         UNGA==
X-Forwarded-Encrypted: i=1; AJvYcCUp4/fbBDwrHA/kUIs2Zm/LpC6UsCia/Wrm/ejwNEIOyUjZISXCvbLgKfCWSJ2NjSjF2TW2SGufwVUXI5Un@vger.kernel.org
X-Gm-Message-State: AOJu0YyoFp8HUDNQO7JOT519dMDdJg+hW3vHLLLXHkzbE0Pygf/LuGIQ
	FWBZbk6RxI4izVeEkcdPNy28WkFCLsuOVSfL7e5BNthd9HYTGj1c1WDzCn/BDCNP2t4=
X-Gm-Gg: ASbGncuGkPDRN49p9odc0c1JCTdzzxI2b5V+5weeXcBrbZWte+4MfYKbQpgnKdQubhR
	rJQuso19IkhIrONC20SJRmedEu4Szo9QGX7lzpD/5oliaFgCw4R/1SPZeby5WfgGVGUbOdPEC8F
	z+CDf6CFEQsziwSj0FQDXpQhRCNwgtnkPDOCMWmiTZWDgfQ3JU42P9iO59o2si7NQKUlvBHesEs
	61C9rB8C9faLBrULjOVs60aRxTMuoBAjUm6WfwXwG8ZkBNewJt8e9Q9/FQVZ0TCnwEzmtLvAmeT
	XLoi+ma9vdu+fg5Z0VERivKAKkg36in6iXI0DcxOmRSQTDms7Y14R4mgH5bNtGZlQ1X3UspjbzO
	jZKebdDrkFw==
X-Google-Smtp-Source: AGHT+IFvYzOyzz0QKmq8BmP2270HEIZC3kk4v2nCSX/dhDAlMnvHnsDN8Dwflm9/0Lg34e9Yf5+UhQ==
X-Received: by 2002:a17:902:e807:b0:234:cb4a:bc30 with SMTP id d9443c01a7336-2352991146cmr46663765ad.41.1748597305966;
        Fri, 30 May 2025 02:28:25 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.28.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:28:25 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 00/35] optimize cost of inter-process communication
Date: Fri, 30 May 2025 17:27:28 +0800
Message-Id: <cover.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changelog:

v2:
- Port the RPAL functions to the latest v6.15 kernel.
- Add a supplementary introduction to the application scenarios and
  security considerations of RPAL.

link to v1:
https://lore.kernel.org/lkml/CAP2HCOmAkRVTci0ObtyW=3v6GFOrt9zCn2NwLUbZ+Di49xkBiw@mail.gmail.com/

--------------------------------------------------------------------------

# Introduction

We mainly apply RPAL to the service mesh architecture widely adopted in
modern cloud-native data centers. Before the rise of the service mesh
architecture, network functions were usually integrated into monolithic
applications as libraries, and the main business programs invoked them
through function calls. However, to facilitate the independent development
and operation and maintenance of the main business programs and network
functions, the service mesh removed the network functions from the main
business programs and made them independent processes (called sidecars).
Inter-process communication (IPC) is used for interaction between the main
business program and the sidecar, and the introduced inter-process
communication has led to a sharp increase in resource consumption in
cloud-native data centers, and may even occupy more than 10% of the CPU of
the entire microservice cluster.

To achieve the efficient function call mechanism of the monolithic
architecture under the service mesh architecture, we introduced the RPAL
(Running Process As Library) architecture, which implements the sharing of
the virtual address space of processes and the switching threads in user
mode. Through the analysis of the service mesh architecture, we found that
the process memory isolation between the main business program and the
sidecar is not particularly important because they are split from one
application and were an integral part of the original monolithic
application. It is more important for the two processes to be independent
of each other because they need to be independently developed and
maintained to ensure the architectural advantages of the service mesh.
Therefore, RPAL breaks the isolation between processes while preserving the
independence between them.  We think that RPAL can also be applied to other
scenarios featuring sidecar-like architectures, such as distributed file
storage systems in LLM infra.

In RPAL architecture, multiple processes share a virtual address space, so
this architecture can be regarded as an advanced version of the Linux
shared memory mechanism:

1. Traditional shared memory requires two processes to negotiate to ensure
the mapping of the same piece of memory. In RPAL architecture, two RPAL
processes still need to reach a consensus before they can successfully
invoke the relevant system calls of RPAL to share the virtual address
space.
2. Traditional shared memory only shares part of the data. However, in RPAL
architecture, processes that have established an RPAL communication
relationship share a virtual address space, and all user memory (such as
data segments and code segments) of each RPAL process is shared among these
processes. However, a process cannot access the memory of other processes
at any time. We use the MPK mechanism to ensure that the memory of other
processes can only be accessed when special RPAL functions are called.
Otherwise, a page fault will be triggered.
3. In RPAL architecture, to ensure the consistency of the execution context
of the shared code (such as the stack and thread local storage), we further
implement the thread context switching in user mode based on the ability to
share the virtual address space of different processes, enabling the
threads of different processes to directly perform fast switching in user
mode without falling into kernel mode for slow switching.

# Background

In traditional inter-process communication (IPC) scenarios, Unix domain
sockets are commonly used in conjunction with the epoll() family for event
multiplexing. IPC operations involve system calls on both the data and
control planes, thereby imposing a non-trivial overhead on the interacting
processes. Even when shared memory is employed to optimize the data plane,
two data copies still remain. Specifically, data is initially copied from
a process's private memory space into the shared memory area, and then it
is copied from the shared memory into the private memory of another
process.

This poses a question: Is it possible to reduce the overhead of IPC with
only minimal modifications at the application level? To address this, we
observed that the functionality of IPC, which encompasses data transfer
and invocation of the target thread, is similar to a function call, where
arguments are passed and the callee function is invoked to process them.
Inspired by this analogy, we introduce RPAL (Run Process As Library), a
framework designed to enable one process to invoke another as if making
a local function call, all without going through the kernel.

# Design

First, let’s formalize RPAL’s core objectives:

1. Data-plane efficiency: Reduce the number of data copies from two (in the
   shared memory solution) to one.
2. Control-plane optimization: Eliminate the overhead of system calls and
   kernel's thread switches.
3. Application compatibility: Minimize the modifications to existing
   applications that utilize Unix domain sockets and the epoll() family.

To attain the first objective, processes that use RPAL share the same
virtual address space. So one process can access another's data directly
via a data pointer. This means data can be transferred from one process to
another with just one copy operation. 

To meet the second goal, RPAL relies on the shared address space to do
lightweight context switching in user space, which we call an "RPAL call".
This allows one process to execute another process's code just like a
local function call.

To achieve the third target, RPAL stays compatible with the epoll family
of functions, like epoll_create(), epoll_wait(), and epoll_ctl(). If an
application uses epoll for IPC, developers can switch to RPAL with just a
few small changes. For instance, you can just replace epoll_wait() with
rpal_epoll_wait(). The basic epoll procedure, where a process waits for
another to write to a monitored descriptor using an epoll file descriptor,
still works fine with RPAL.

## Address space sharing

For address space sharing, RPAL partitions the entire userspace virtual
address space and allocates non-overlapping memory ranges to each process.
On x86_64 architectures, RPAL uses a memory range size covered by a
single PUD (Page Upper Directory) entry, which is 512GB. This restricts
each process’s virtual address space to 512GB on x86_64, sufficient for
most applications in our scenario. The rationale is straightforward: 
address space sharing can be simply achieved by copying the PUD from one
process’s page table to another’s. So one process can directly use the
data pointer to access another's memory.


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

We refer to the lightweight userspace context switching mechanism as RPAL
call. It enables the caller (or sender) thread of one process to directly
switch to the callee (or receiver) thread of another process. 

When Process A’s caller thread initiates an RPAL call to Process B’s
callee thread, the CPU saves the caller’s context and loads the callee’s
context. This enables direct userspace control flow transfer from the
caller to the callee. After the callee finishes data processing, the CPU
saves Process B’s callee context and switches back to Process A’s caller
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
process. To mitigate this, we leverage Memory Protection Keys (MPK) on x86
architectures.

MPK assigns 4 bits in each page table entry to a "protection key", which
is paired with a userspace register (PKRU). The PKRU register defines
access permissions for memory regions protected by specific keys (for
detailed implementation, refer to the kernel documentation "Memory
Protection Keys"). With MPK, even though the address space is shared
among processes, cross-process access is restricted: a process can only
access the memory protected by a key if its PKRU register is configured
with the corresponding permission. This ensures that processes cannot
access each other’s memory unless an explicit PKRU configuration is set.

## Page fault handling and TLB flushing

Due to the shared address space architecture, both page fault handling and
TLB flushing require careful consideration. For instance, when Process A
accesses Process B’s memory, a page fault may occur in Process A's
context, but the faulting address belongs to Process B. In this case, we
must pass Process B's mm_struct to the page fault handler.

TLB flushing is more complex. When a thread flushes the TLB, since the
address space is shared, not only other threads in the current process but
also other processes that share the address space may access the
corresponding memory (related to the TLB flush). Therefore, the cpuset used
for TLB flushing should be the union of the mm_cpumasks of all processes
that share the address space.

## Lazy switch of kernel context

In RPAL, a mismatch may arise between the user context and the kernel
context. The RPAL call is designed solely to switch the user context,
leaving the kernel context unchanged. For instance, when a RPAL call takes
place, transitioning from caller thread to callee thread, and subsequently
a system call is initiated within callee thread, the kernel will
incorrectly utilize the caller's kernel context (such as the kernel stack)
to process the system call.

To resolve context mismatch issues, a kernel context switch is triggered at
the kernel entry point when the callee initiates a syscall or an
exception/interrupt occurs. This mechanism ensures context consistency
before processing system calls, interrupts, or exceptions. We refer to this
kernel context switch as a "lazy switch" because it defers the switching
operation from the traditional thread switch point to the next kernel entry
point.

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
CPU time consumed by the callee thread in user space. The kernel then uses
this user-reported timing data to adjust the CPU accounting for both the
caller and callee thread, similar to how CPU steal time is implemented.

## Process recovery

Since processes can access each other’s memory, there is a risk that the
target process’s memory may become invalid at the access time (e.g., if
the target process has exited unexpectedly). The kernel must handle such
cases; otherwise, the accessing process could be terminated due to
failures originating from another process.

To address this issue, each thread of the process should pre-establish a
recovery point when accessing the memory of other processes. When such an
invalid access occurs, the thread traps into the kernel. Inside the page
fault handler, the kernel restores the user context of the thread to the
recovery point. This mechanism ensures that processes maintain mutual
independence, preventing cascading failures caused by cross-process memory
issues.

# Performance

To quantify the performance improvements driven by RPAL, we measured
latency both before and after its deployment. Experiments were conducted on
a server equipped with two Intel(R) Xeon(R) Platinum 8336C CPUs (2.30 GHz)
and 1 TB of memory. Latency was defined as the duration from when the
client thread initiates a message to when the server thread is invoked and
receives it.

During testing, the client transmitted 1 million 32-byte messages, and we
computed the per-message average latency. The results are as follows:

*****************
Without RPAL: Message length: 32 bytes, Total TSC cycles: 19616222534,
 Message count: 1000000, Average latency: 19616 cycles
With RPAL: Message length: 32 bytes, Total TSC cycles: 1703459326,
 Message count: 1000000, Average latency: 1703 cycles
*****************

These results confirm that RPAL delivers substantial latency improvements
over the current epoll implementation—achieving a 17,913-cycle reduction
(an ~91.3% improvement) for 32-byte messages.

We have applied RPAL to an RPC framework that is widely used in our data
center. With RPAL, we have successfully achieved up to 15.5% reduction in
the CPU utilization of processes in real-world microservice scenario. The
gains primarily stem from minimizing control plane overhead through the
utilization of userspace context switches. Additionally, by leveraging
address space sharing, the number of memory copies is significantly
reduced.

# Future Work

Currently, RPAL requires the MPK (Memory Protection Key) hardware feature,
which is supported by a range of Intel CPUs. For AMD architectures, MPK is
supported only on the latest processor, specifically, 3th Generation AMD
EPYC™ Processors and subsequent generations. Patch sets that extend RPAL
support to systems lacking MPK hardware will be provided later.

Accompanying test programs are also provided in the samples/rpal/
directory. And the user-mode RPAL library, which realizes user-space RPAL
call, is in the samples/rpal/librpal directory.
            
We hope to get some community discussions and feedback on RPAL's
optimization approaches and architecture.

Look forward to your comments.

Bo Li (35):
  Kbuild: rpal support
  RPAL: add struct rpal_service
  RPAL: add service registration interface
  RPAL: add member to task_struct and mm_struct
  RPAL: enable virtual address space partitions
  RPAL: add user interface
  RPAL: enable shared page mmap
  RPAL: enable sender/receiver registration
  RPAL: enable address space sharing
  RPAL: allow service enable/disable
  RPAL: add service request/release
  RPAL: enable service disable notification
  RPAL: add tlb flushing support
  RPAL: enable page fault handling
  RPAL: add sender/receiver state
  RPAL: add cpu lock interface
  RPAL: add a mapping between fsbase and tasks
  sched: pick a specified task
  RPAL: add lazy switch main logic
  RPAL: add rpal_ret_from_lazy_switch
  RPAL: add kernel entry handling for lazy switch
  RPAL: rebuild receiver state
  RPAL: resume cpumask when fork
  RPAL: critical section optimization
  RPAL: add MPK initialization and interface
  RPAL: enable MPK support
  RPAL: add epoll support
  RPAL: add rpal_uds_fdmap() support
  RPAL: fix race condition in pkru update
  RPAL: fix pkru setup when fork
  RPAL: add receiver waker
  RPAL: fix unknown nmi on AMD CPU
  RPAL: enable time slice correction
  RPAL: enable fast epoll wait
  samples/rpal: add RPAL samples

 arch/x86/Kbuild                               |    2 +
 arch/x86/Kconfig                              |    2 +
 arch/x86/entry/entry_64.S                     |  160 ++
 arch/x86/events/amd/core.c                    |   14 +
 arch/x86/include/asm/pgtable.h                |   25 +
 arch/x86/include/asm/pgtable_types.h          |   11 +
 arch/x86/include/asm/tlbflush.h               |   10 +
 arch/x86/kernel/asm-offsets.c                 |    3 +
 arch/x86/kernel/cpu/common.c                  |    8 +-
 arch/x86/kernel/fpu/core.c                    |    8 +-
 arch/x86/kernel/nmi.c                         |   20 +
 arch/x86/kernel/process.c                     |   25 +-
 arch/x86/kernel/process_64.c                  |  118 +
 arch/x86/mm/fault.c                           |  271 ++
 arch/x86/mm/mmap.c                            |   10 +
 arch/x86/mm/tlb.c                             |  172 ++
 arch/x86/rpal/Kconfig                         |   21 +
 arch/x86/rpal/Makefile                        |    6 +
 arch/x86/rpal/core.c                          |  477 ++++
 arch/x86/rpal/internal.h                      |   69 +
 arch/x86/rpal/mm.c                            |  426 +++
 arch/x86/rpal/pku.c                           |  196 ++
 arch/x86/rpal/proc.c                          |  279 ++
 arch/x86/rpal/service.c                       |  776 ++++++
 arch/x86/rpal/thread.c                        |  313 +++
 fs/binfmt_elf.c                               |   98 +-
 fs/eventpoll.c                                |  320 +++
 fs/exec.c                                     |   11 +
 include/linux/mm_types.h                      |    3 +
 include/linux/rpal.h                          |  633 +++++
 include/linux/sched.h                         |   21 +
 init/init_task.c                              |    6 +
 kernel/exit.c                                 |    5 +
 kernel/fork.c                                 |   32 +
 kernel/sched/core.c                           |  676 +++++
 kernel/sched/fair.c                           |  109 +
 kernel/sched/sched.h                          |    8 +
 mm/mmap.c                                     |   16 +
 mm/mprotect.c                                 |  106 +
 mm/rmap.c                                     |    4 +
 mm/vma.c                                      |   18 +
 samples/rpal/Makefile                         |   17 +
 samples/rpal/asm_define.c                     |   14 +
 samples/rpal/client.c                         |  178 ++
 samples/rpal/librpal/asm_define.h             |    6 +
 samples/rpal/librpal/asm_x86_64_rpal_call.S   |   57 +
 samples/rpal/librpal/debug.h                  |   12 +
 samples/rpal/librpal/fiber.c                  |  119 +
 samples/rpal/librpal/fiber.h                  |   64 +
 .../rpal/librpal/jump_x86_64_sysv_elf_gas.S   |   81 +
 .../rpal/librpal/make_x86_64_sysv_elf_gas.S   |   82 +
 .../rpal/librpal/ontop_x86_64_sysv_elf_gas.S  |   84 +
 samples/rpal/librpal/private.h                |  341 +++
 samples/rpal/librpal/rpal.c                   | 2351 +++++++++++++++++
 samples/rpal/librpal/rpal.h                   |  149 ++
 samples/rpal/librpal/rpal_pkru.h              |   78 +
 samples/rpal/librpal/rpal_queue.c             |  239 ++
 samples/rpal/librpal/rpal_queue.h             |   55 +
 samples/rpal/librpal/rpal_x86_64_call_ret.S   |   45 +
 samples/rpal/offset.sh                        |    5 +
 samples/rpal/server.c                         |  249 ++
 61 files changed, 9710 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/rpal/Kconfig
 create mode 100644 arch/x86/rpal/Makefile
 create mode 100644 arch/x86/rpal/core.c
 create mode 100644 arch/x86/rpal/internal.h
 create mode 100644 arch/x86/rpal/mm.c
 create mode 100644 arch/x86/rpal/pku.c
 create mode 100644 arch/x86/rpal/proc.c
 create mode 100644 arch/x86/rpal/service.c
 create mode 100644 arch/x86/rpal/thread.c
 create mode 100644 include/linux/rpal.h
 create mode 100644 samples/rpal/Makefile
 create mode 100644 samples/rpal/asm_define.c
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
 create mode 100755 samples/rpal/offset.sh
 create mode 100644 samples/rpal/server.c

-- 
2.20.1


