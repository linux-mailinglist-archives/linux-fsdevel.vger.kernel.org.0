Return-Path: <linux-fsdevel+bounces-50433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF310ACC21B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 10:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717FE188FFCB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 08:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E700C280CEA;
	Tue,  3 Jun 2025 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kGXC5wbO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4368280323
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938966; cv=none; b=hAAM6t457hwJf+toimw+ieKggbStLdAcCudN5RSXOs3sMtxjM0UtiDYvcy0h7hR4nfSyvfkfrxAB7XjUrRokvd9siH5MdGGLa+4mHVqGlNXxEKWfnn9P1bFyB9kX+fxMY+rEHbmlVEYrYuIV2g+rEtCg7cIuMBXYNRRW9lIfS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938966; c=relaxed/simple;
	bh=BXuh/nsb77GXnONTiKPpQxTeKDuDHtW3xWxOlCZB8zk=;
	h=In-Reply-To:From:Mime-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUhQoX7LB0e9thzWIzWAx79b1sKlo2J/vR0A9/7cFh6WexndNziw3TOjjBU3PIcXERweYkgQRdmwMdXSUEVNxyPv/UhrJmqCPojtgfwinEaI+O9X1MdaJc2iFoLMlu/j3UqsAmm8NWv+KB+MOwK85j3+668gCYq89821luiZ6TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kGXC5wbO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a44b3526e6so45842881cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748938961; x=1749543761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :user-agent:mime-version:from:in-reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7BzDhvrp2uY0gQYXCyW2U1ugFPB4TP4d5cC/hQcSvQ=;
        b=kGXC5wbOdHMzkn2yYoOTgC8FwBf+BE1v64D/PwV/ZAc8fyJsY2Kk+X65gHYvJngkEV
         gogvIhW/29G23LFaKqOzn/LWOhFSPsFOX+SCDSeQiFWAMCwfmS6GkndpB+zN16f/CvGP
         54u9AM/M4wD7VghAQWKuLWyAyg/Zqh7mDGFiQdxMiJA1gMmF/ybSUK/hCPzS2arheyE9
         YFp6bqBU7Z5vPXYc40K7iyJFXhu4nU6EZGUEnuBICToA/O2XUolz15wP2RwR/hz3cpVE
         HBn9gJwevB/n+Q2dkd/mAduPMzfnLDt97HOviD1h/u5H7yCV3XwAKnnbR0u2APuefCDd
         qTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748938961; x=1749543761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :user-agent:mime-version:from:in-reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+7BzDhvrp2uY0gQYXCyW2U1ugFPB4TP4d5cC/hQcSvQ=;
        b=N/Lml2Y7RESv39ZdStgBvG3BsyuPISatOmzOpoUU2FP26KugVsdsaoRlhWvBl26Nze
         V+vEyNSzYWKIMD3SrAOUwzPzRrtnUGeMN3Gv7a0KZY0Mbee2UufRWDFCWmBIr1RmDKc8
         CBLThlVw2WfctyKKw3kR5XwOviDneAtVmvLl8qiPRpFufqRAhmlQdVYxjRY4upbl5hRY
         xcQmAThNLjJ+cVhnYXtrIyegsAaqf5mF7jdd3wuD+ILRXEnC6YJz1vi0wdL3V62dEGgt
         MHJDBgoBZyT3ekenTfkGqp0c/M063doDFF1OROz8RQ1rY98Dhidn8kuNxHr6UhHddWl4
         Fo1A==
X-Forwarded-Encrypted: i=1; AJvYcCWw0qW/7Q4EQszRWn22Bg1wTnubZFmd/3dLDwMdwkZk6UxTccSwkkEGIbQY9eRUwzS5LJtXm0oqSe9cA8xg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/j7TS9sFTDey+Qbs8S91NJNu+V84aDEJ8Wf/fB6OcF6GWjzn
	fJHLkKKahw6Btp9EdM6XxVY/jA2pNN+QcZGHRzFjEiLP9etjaUBDkR7VRLFDVYbKHvNb4oDNiSi
	ivp88/uKnvIOhD08vU178N96HiFij5loSaDf0XnR0cQ==
X-Gm-Gg: ASbGncvR8vM+5ozSfkQiqzqKnZqV0WsZiGnNzsjxox7qE25L17WM7WftqnKU9mBlICg
	0+RyH0m8dXJswD+CoIitzHFy/k16U4KLd0ucsMMmZ4WjTa7afD5880qOffNYdGBES2iiChuo7uC
	PWwNGR9qsFeIjPixGAiDm8EFQu4tKNS5PoGJI=
X-Google-Smtp-Source: AGHT+IGbdmCrZUoM8Mhar6JV3bUZzvJotBlslT5tVluEP3VE42X1V6tQMr+AedVVDicPBAqDyY5nCfjJeNU15AA1B30=
X-Received: by 2002:a05:622a:4a17:b0:4a4:369c:7635 with SMTP id
 d75a77b69052e-4a44005c3f3mr290139811cf.19.1748938961205; Tue, 03 Jun 2025
 01:22:41 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 3 Jun 2025 03:22:39 -0500
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 3 Jun 2025 03:22:39 -0500
In-Reply-To: <8c98c8e0-95e1-4292-8116-79d803962d5f@lucifer.local>
X-Original-From: Bo Li <libo.gcs85@bytedance.com>
From: Bo Li <libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
References: <cover.1748594840.git.libo.gcs85@bytedance.com> <8c98c8e0-95e1-4292-8116-79d803962d5f@lucifer.local>
Date: Tue, 3 Jun 2025 03:22:39 -0500
X-Gm-Features: AX0GCFt-gvTIguI8oo_H9fFRDX2XQ8TxUxLXINdxWnRB4pX4rfwkyw-E0XNHgqE
Message-ID: <CAGX5aN1aogK80L-TVj7+ru66sn-1FN+H5+Z6LJZi0hoj=_gY4A@mail.gmail.com>
Subject: Re: [RFC v2 00/35] optimize cost of inter-process communication
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org, kees@kernel.org, 
	akpm@linux-foundation.org, david@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, peterz@infradead.org, dietmar.eggemann@arm.com, 
	hpa@zytor.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, jannh@google.com, 
	pfalcato@suse.de, riel@surriel.com, harry.yoo@oracle.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	duanxiongchun@bytedance.com, yinhongbo@bytedance.com, 
	dengliang.1214@bytedance.com, xieyongji@bytedance.com, 
	chaiwen.cc@bytedance.com, songmuchun@bytedance.com, yuanzhu@bytedance.com, 
	chengguozhu@bytedance.com, sunjiadong.lff@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On 5/30/25 5:33 PM, Lorenzo Stoakes wrote:
> Bo,
>
> You have outstanding feedback on your v1 from me and Dave Hansen. I'm not
> quite sure why you're sending a v2 without responding to that.
>
> This isn't how the upstream kernel works...
>
> Thanks, Lorenzo
>
> On Fri, May 30, 2025 at 05:27:28PM +0800, Bo Li wrote:
>> Changelog:
>>
>> v2:
>> - Port the RPAL functions to the latest v6.15 kernel.
>> - Add a supplementary introduction to the application scenarios and
>>    security considerations of RPAL.
>>
>> link to v1:
>> https://lore.kernel.org/lkml/CAP2HCOmAkRVTci0ObtyW=3D3v6GFOrt9zCn2NwLUbZ=
+Di49xkBiw@mail.gmail.com/
>>
>> ------------------------------------------------------------------------=
--
>>
>> # Introduction
>>
>> We mainly apply RPAL to the service mesh architecture widely adopted in
>> modern cloud-native data centers. Before the rise of the service mesh
>> architecture, network functions were usually integrated into monolithic
>> applications as libraries, and the main business programs invoked them
>> through function calls. However, to facilitate the independent developme=
nt
>> and operation and maintenance of the main business programs and network
>> functions, the service mesh removed the network functions from the main
>> business programs and made them independent processes (called sidecars).
>> Inter-process communication (IPC) is used for interaction between the ma=
in
>> business program and the sidecar, and the introduced inter-process
>> communication has led to a sharp increase in resource consumption in
>> cloud-native data centers, and may even occupy more than 10% of the CPU =
of
>> the entire microservice cluster.
>>
>> To achieve the efficient function call mechanism of the monolithic
>> architecture under the service mesh architecture, we introduced the RPAL
>> (Running Process As Library) architecture, which implements the sharing =
of
>> the virtual address space of processes and the switching threads in user
>> mode. Through the analysis of the service mesh architecture, we found th=
at
>> the process memory isolation between the main business program and the
>> sidecar is not particularly important because they are split from one
>> application and were an integral part of the original monolithic
>> application. It is more important for the two processes to be independen=
t
>> of each other because they need to be independently developed and
>> maintained to ensure the architectural advantages of the service mesh.
>> Therefore, RPAL breaks the isolation between processes while preserving =
the
>> independence between them.  We think that RPAL can also be applied to ot=
her
>> scenarios featuring sidecar-like architectures, such as distributed file
>> storage systems in LLM infra.
>>
>> In RPAL architecture, multiple processes share a virtual address space, =
so
>> this architecture can be regarded as an advanced version of the Linux
>> shared memory mechanism:
>>
>> 1. Traditional shared memory requires two processes to negotiate to ensu=
re
>> the mapping of the same piece of memory. In RPAL architecture, two RPAL
>> processes still need to reach a consensus before they can successfully
>> invoke the relevant system calls of RPAL to share the virtual address
>> space.
>> 2. Traditional shared memory only shares part of the data. However, in R=
PAL
>> architecture, processes that have established an RPAL communication
>> relationship share a virtual address space, and all user memory (such as
>> data segments and code segments) of each RPAL process is shared among th=
ese
>> processes. However, a process cannot access the memory of other processe=
s
>> at any time. We use the MPK mechanism to ensure that the memory of other
>> processes can only be accessed when special RPAL functions are called.
>> Otherwise, a page fault will be triggered.
>> 3. In RPAL architecture, to ensure the consistency of the execution cont=
ext
>> of the shared code (such as the stack and thread local storage), we furt=
her
>> implement the thread context switching in user mode based on the ability=
 to
>> share the virtual address space of different processes, enabling the
>> threads of different processes to directly perform fast switching in use=
r
>> mode without falling into kernel mode for slow switching.
>>
>> # Background
>>
>> In traditional inter-process communication (IPC) scenarios, Unix domain
>> sockets are commonly used in conjunction with the epoll() family for eve=
nt
>> multiplexing. IPC operations involve system calls on both the data and
>> control planes, thereby imposing a non-trivial overhead on the interacti=
ng
>> processes. Even when shared memory is employed to optimize the data plan=
e,
>> two data copies still remain. Specifically, data is initially copied fro=
m
>> a process's private memory space into the shared memory area, and then i=
t
>> is copied from the shared memory into the private memory of another
>> process.
>>
>> This poses a question: Is it possible to reduce the overhead of IPC with
>> only minimal modifications at the application level? To address this, we
>> observed that the functionality of IPC, which encompasses data transfer
>> and invocation of the target thread, is similar to a function call, wher=
e
>> arguments are passed and the callee function is invoked to process them.
>> Inspired by this analogy, we introduce RPAL (Run Process As Library), a
>> framework designed to enable one process to invoke another as if making
>> a local function call, all without going through the kernel.
>>
>> # Design
>>
>> First, let=E2=80=99s formalize RPAL=E2=80=99s core objectives:
>>
>> 1. Data-plane efficiency: Reduce the number of data copies from two (in =
the
>>     shared memory solution) to one.
>> 2. Control-plane optimization: Eliminate the overhead of system calls an=
d
>>     kernel's thread switches.
>> 3. Application compatibility: Minimize the modifications to existing
>>     applications that utilize Unix domain sockets and the epoll() family=
.
>>
>> To attain the first objective, processes that use RPAL share the same
>> virtual address space. So one process can access another's data directly
>> via a data pointer. This means data can be transferred from one process =
to
>> another with just one copy operation.
>>
>> To meet the second goal, RPAL relies on the shared address space to do
>> lightweight context switching in user space, which we call an "RPAL call=
".
>> This allows one process to execute another process's code just like a
>> local function call.
>>
>> To achieve the third target, RPAL stays compatible with the epoll family
>> of functions, like epoll_create(), epoll_wait(), and epoll_ctl(). If an
>> application uses epoll for IPC, developers can switch to RPAL with just =
a
>> few small changes. For instance, you can just replace epoll_wait() with
>> rpal_epoll_wait(). The basic epoll procedure, where a process waits for
>> another to write to a monitored descriptor using an epoll file descripto=
r,
>> still works fine with RPAL.
>>
>> ## Address space sharing
>>
>> For address space sharing, RPAL partitions the entire userspace virtual
>> address space and allocates non-overlapping memory ranges to each proces=
s.
>> On x86_64 architectures, RPAL uses a memory range size covered by a
>> single PUD (Page Upper Directory) entry, which is 512GB. This restricts
>> each process=E2=80=99s virtual address space to 512GB on x86_64, suffici=
ent for
>> most applications in our scenario. The rationale is straightforward:
>> address space sharing can be simply achieved by copying the PUD from one
>> process=E2=80=99s page table to another=E2=80=99s. So one process can di=
rectly use the
>> data pointer to access another's memory.
>>
>>
>>   |------------| <- 0
>>   |------------| <- 512 GB
>>   |  Process A |
>>   |------------| <- 2*512 GB
>>   |------------| <- n*512 GB
>>   |  Process B |
>>   |------------| <- (n+1)*512 GB
>>   |------------| <- STACK_TOP
>>   |  Kernel    |
>>   |------------|
>>
>> ## RPAL call
>>
>> We refer to the lightweight userspace context switching mechanism as RPA=
L
>> call. It enables the caller (or sender) thread of one process to directl=
y
>> switch to the callee (or receiver) thread of another process.
>>
>> When Process A=E2=80=99s caller thread initiates an RPAL call to Process=
 B=E2=80=99s
>> callee thread, the CPU saves the caller=E2=80=99s context and loads the =
callee=E2=80=99s
>> context. This enables direct userspace control flow transfer from the
>> caller to the callee. After the callee finishes data processing, the CPU
>> saves Process B=E2=80=99s callee context and switches back to Process A=
=E2=80=99s caller
>> context, completing a full IPC cycle.
>>
>>
>>   |------------|                |---------------------|
>>   |  Process A |                |  Process B          |
>>   | |-------|  |                | |-------|           |
>>   | | caller| --- RPAL call --> | | callee|    handle |
>>   | | thread| <------------------ | thread| -> event  |
>>   | |-------|  |                | |-------|           |
>>   |------------|                |---------------------|
>>
>> # Security and compatibility with kernel subsystems
>>
>> ## Memory protection between processes
>>
>> Since processes using RPAL share the address space, unintended
>> cross-process memory access may occur and corrupt the data of another
>> process. To mitigate this, we leverage Memory Protection Keys (MPK) on x=
86
>> architectures.
>>
>> MPK assigns 4 bits in each page table entry to a "protection key", which
>> is paired with a userspace register (PKRU). The PKRU register defines
>> access permissions for memory regions protected by specific keys (for
>> detailed implementation, refer to the kernel documentation "Memory
>> Protection Keys"). With MPK, even though the address space is shared
>> among processes, cross-process access is restricted: a process can only
>> access the memory protected by a key if its PKRU register is configured
>> with the corresponding permission. This ensures that processes cannot
>> access each other=E2=80=99s memory unless an explicit PKRU configuration=
 is set.
>>
>> ## Page fault handling and TLB flushing
>>
>> Due to the shared address space architecture, both page fault handling a=
nd
>> TLB flushing require careful consideration. For instance, when Process A
>> accesses Process B=E2=80=99s memory, a page fault may occur in Process A=
's
>> context, but the faulting address belongs to Process B. In this case, we
>> must pass Process B's mm_struct to the page fault handler.
>>
>> TLB flushing is more complex. When a thread flushes the TLB, since the
>> address space is shared, not only other threads in the current process b=
ut
>> also other processes that share the address space may access the
>> corresponding memory (related to the TLB flush). Therefore, the cpuset u=
sed
>> for TLB flushing should be the union of the mm_cpumasks of all processes
>> that share the address space.
>>
>> ## Lazy switch of kernel context
>>
>> In RPAL, a mismatch may arise between the user context and the kernel
>> context. The RPAL call is designed solely to switch the user context,
>> leaving the kernel context unchanged. For instance, when a RPAL call tak=
es
>> place, transitioning from caller thread to callee thread, and subsequent=
ly
>> a system call is initiated within callee thread, the kernel will
>> incorrectly utilize the caller's kernel context (such as the kernel stac=
k)
>> to process the system call.
>>
>> To resolve context mismatch issues, a kernel context switch is triggered=
 at
>> the kernel entry point when the callee initiates a syscall or an
>> exception/interrupt occurs. This mechanism ensures context consistency
>> before processing system calls, interrupts, or exceptions. We refer to t=
his
>> kernel context switch as a "lazy switch" because it defers the switching
>> operation from the traditional thread switch point to the next kernel en=
try
>> point.
>>
>> Lazy switch should be minimized as much as possible, as it significantly
>> degrades performance. We currently utilize RPAL in an RPC framework, in
>> which the RPC sender thread relies on the RPAL call to invoke the RPC
>> receiver thread entirely in user space. In most cases, the receiver
>> thread is free of system calls and the code execution time is relatively
>> short. This characteristic effectively reduces the probability of a lazy
>> switch occurring.
>>
>> ## Time slice correction
>>
>> After an RPAL call, the callee's user mode code executes. However, the
>> kernel incorrectly attributes this CPU time to the caller due to the
>> unchanged kernel context.
>>
>> To resolve this, we use the Time Stamp Counter (TSC) register to measure
>> CPU time consumed by the callee thread in user space. The kernel then us=
es
>> this user-reported timing data to adjust the CPU accounting for both the
>> caller and callee thread, similar to how CPU steal time is implemented.
>>
>> ## Process recovery
>>
>> Since processes can access each other=E2=80=99s memory, there is a risk =
that the
>> target process=E2=80=99s memory may become invalid at the access time (e=
.g., if
>> the target process has exited unexpectedly). The kernel must handle such
>> cases; otherwise, the accessing process could be terminated due to
>> failures originating from another process.
>>
>> To address this issue, each thread of the process should pre-establish a
>> recovery point when accessing the memory of other processes. When such a=
n
>> invalid access occurs, the thread traps into the kernel. Inside the page
>> fault handler, the kernel restores the user context of the thread to the
>> recovery point. This mechanism ensures that processes maintain mutual
>> independence, preventing cascading failures caused by cross-process memo=
ry
>> issues.
>>
>> # Performance
>>
>> To quantify the performance improvements driven by RPAL, we measured
>> latency both before and after its deployment. Experiments were conducted=
 on
>> a server equipped with two Intel(R) Xeon(R) Platinum 8336C CPUs (2.30 GH=
z)
>> and 1 TB of memory. Latency was defined as the duration from when the
>> client thread initiates a message to when the server thread is invoked a=
nd
>> receives it.
>>
>> During testing, the client transmitted 1 million 32-byte messages, and w=
e
>> computed the per-message average latency. The results are as follows:
>>
>> *****************
>> Without RPAL: Message length: 32 bytes, Total TSC cycles: 19616222534,
>>   Message count: 1000000, Average latency: 19616 cycles
>> With RPAL: Message length: 32 bytes, Total TSC cycles: 1703459326,
>>   Message count: 1000000, Average latency: 1703 cycles
>> *****************
>>
>> These results confirm that RPAL delivers substantial latency improvement=
s
>> over the current epoll implementation=E2=80=94achieving a 17,913-cycle r=
eduction
>> (an ~91.3% improvement) for 32-byte messages.
>>
>> We have applied RPAL to an RPC framework that is widely used in our data
>> center. With RPAL, we have successfully achieved up to 15.5% reduction i=
n
>> the CPU utilization of processes in real-world microservice scenario. Th=
e
>> gains primarily stem from minimizing control plane overhead through the
>> utilization of userspace context switches. Additionally, by leveraging
>> address space sharing, the number of memory copies is significantly
>> reduced.
>>
>> # Future Work
>>
>> Currently, RPAL requires the MPK (Memory Protection Key) hardware featur=
e,
>> which is supported by a range of Intel CPUs. For AMD architectures, MPK =
is
>> supported only on the latest processor, specifically, 3th Generation AMD
>> EPYC=E2=84=A2 Processors and subsequent generations. Patch sets that ext=
end RPAL
>> support to systems lacking MPK hardware will be provided later.
>>
>> Accompanying test programs are also provided in the samples/rpal/
>> directory. And the user-mode RPAL library, which realizes user-space RPA=
L
>> call, is in the samples/rpal/librpal directory.
>>
>> We hope to get some community discussions and feedback on RPAL's
>> optimization approaches and architecture.
>>
>> Look forward to your comments.
>>
>> Bo Li (35):
>>    Kbuild: rpal support
>>    RPAL: add struct rpal_service
>>    RPAL: add service registration interface
>>    RPAL: add member to task_struct and mm_struct
>>    RPAL: enable virtual address space partitions
>>    RPAL: add user interface
>>    RPAL: enable shared page mmap
>>    RPAL: enable sender/receiver registration
>>    RPAL: enable address space sharing
>>    RPAL: allow service enable/disable
>>    RPAL: add service request/release
>>    RPAL: enable service disable notification
>>    RPAL: add tlb flushing support
>>    RPAL: enable page fault handling
>>    RPAL: add sender/receiver state
>>    RPAL: add cpu lock interface
>>    RPAL: add a mapping between fsbase and tasks
>>    sched: pick a specified task
>>    RPAL: add lazy switch main logic
>>    RPAL: add rpal_ret_from_lazy_switch
>>    RPAL: add kernel entry handling for lazy switch
>>    RPAL: rebuild receiver state
>>    RPAL: resume cpumask when fork
>>    RPAL: critical section optimization
>>    RPAL: add MPK initialization and interface
>>    RPAL: enable MPK support
>>    RPAL: add epoll support
>>    RPAL: add rpal_uds_fdmap() support
>>    RPAL: fix race condition in pkru update
>>    RPAL: fix pkru setup when fork
>>    RPAL: add receiver waker
>>    RPAL: fix unknown nmi on AMD CPU
>>    RPAL: enable time slice correction
>>    RPAL: enable fast epoll wait
>>    samples/rpal: add RPAL samples
>>
>>   arch/x86/Kbuild                               |    2 +
>>   arch/x86/Kconfig                              |    2 +
>>   arch/x86/entry/entry_64.S                     |  160 ++
>>   arch/x86/events/amd/core.c                    |   14 +
>>   arch/x86/include/asm/pgtable.h                |   25 +
>>   arch/x86/include/asm/pgtable_types.h          |   11 +
>>   arch/x86/include/asm/tlbflush.h               |   10 +
>>   arch/x86/kernel/asm-offsets.c                 |    3 +
>>   arch/x86/kernel/cpu/common.c                  |    8 +-
>>   arch/x86/kernel/fpu/core.c                    |    8 +-
>>   arch/x86/kernel/nmi.c                         |   20 +
>>   arch/x86/kernel/process.c                     |   25 +-
>>   arch/x86/kernel/process_64.c                  |  118 +
>>   arch/x86/mm/fault.c                           |  271 ++
>>   arch/x86/mm/mmap.c                            |   10 +
>>   arch/x86/mm/tlb.c                             |  172 ++
>>   arch/x86/rpal/Kconfig                         |   21 +
>>   arch/x86/rpal/Makefile                        |    6 +
>>   arch/x86/rpal/core.c                          |  477 ++++
>>   arch/x86/rpal/internal.h                      |   69 +
>>   arch/x86/rpal/mm.c                            |  426 +++
>>   arch/x86/rpal/pku.c                           |  196 ++
>>   arch/x86/rpal/proc.c                          |  279 ++
>>   arch/x86/rpal/service.c                       |  776 ++++++
>>   arch/x86/rpal/thread.c                        |  313 +++
>>   fs/binfmt_elf.c                               |   98 +-
>>   fs/eventpoll.c                                |  320 +++
>>   fs/exec.c                                     |   11 +
>>   include/linux/mm_types.h                      |    3 +
>>   include/linux/rpal.h                          |  633 +++++
>>   include/linux/sched.h                         |   21 +
>>   init/init_task.c                              |    6 +
>>   kernel/exit.c                                 |    5 +
>>   kernel/fork.c                                 |   32 +
>>   kernel/sched/core.c                           |  676 +++++
>>   kernel/sched/fair.c                           |  109 +
>>   kernel/sched/sched.h                          |    8 +
>>   mm/mmap.c                                     |   16 +
>>   mm/mprotect.c                                 |  106 +
>>   mm/rmap.c                                     |    4 +
>>   mm/vma.c                                      |   18 +
>>   samples/rpal/Makefile                         |   17 +
>>   samples/rpal/asm_define.c                     |   14 +
>>   samples/rpal/client.c                         |  178 ++
>>   samples/rpal/librpal/asm_define.h             |    6 +
>>   samples/rpal/librpal/asm_x86_64_rpal_call.S   |   57 +
>>   samples/rpal/librpal/debug.h                  |   12 +
>>   samples/rpal/librpal/fiber.c                  |  119 +
>>   samples/rpal/librpal/fiber.h                  |   64 +
>>   .../rpal/librpal/jump_x86_64_sysv_elf_gas.S   |   81 +
>>   .../rpal/librpal/make_x86_64_sysv_elf_gas.S   |   82 +
>>   .../rpal/librpal/ontop_x86_64_sysv_elf_gas.S  |   84 +
>>   samples/rpal/librpal/private.h                |  341 +++
>>   samples/rpal/librpal/rpal.c                   | 2351 +++++++++++++++++
>>   samples/rpal/librpal/rpal.h                   |  149 ++
>>   samples/rpal/librpal/rpal_pkru.h              |   78 +
>>   samples/rpal/librpal/rpal_queue.c             |  239 ++
>>   samples/rpal/librpal/rpal_queue.h             |   55 +
>>   samples/rpal/librpal/rpal_x86_64_call_ret.S   |   45 +
>>   samples/rpal/offset.sh                        |    5 +
>>   samples/rpal/server.c                         |  249 ++
>>   61 files changed, 9710 insertions(+), 4 deletions(-)
>>   create mode 100644 arch/x86/rpal/Kconfig
>>   create mode 100644 arch/x86/rpal/Makefile
>>   create mode 100644 arch/x86/rpal/core.c
>>   create mode 100644 arch/x86/rpal/internal.h
>>   create mode 100644 arch/x86/rpal/mm.c
>>   create mode 100644 arch/x86/rpal/pku.c
>>   create mode 100644 arch/x86/rpal/proc.c
>>   create mode 100644 arch/x86/rpal/service.c
>>   create mode 100644 arch/x86/rpal/thread.c
>>   create mode 100644 include/linux/rpal.h
>>   create mode 100644 samples/rpal/Makefile
>>   create mode 100644 samples/rpal/asm_define.c
>>   create mode 100644 samples/rpal/client.c
>>   create mode 100644 samples/rpal/librpal/asm_define.h
>>   create mode 100644 samples/rpal/librpal/asm_x86_64_rpal_call.S
>>   create mode 100644 samples/rpal/librpal/debug.h
>>   create mode 100644 samples/rpal/librpal/fiber.c
>>   create mode 100644 samples/rpal/librpal/fiber.h
>>   create mode 100644 samples/rpal/librpal/jump_x86_64_sysv_elf_gas.S
>>   create mode 100644 samples/rpal/librpal/make_x86_64_sysv_elf_gas.S
>>   create mode 100644 samples/rpal/librpal/ontop_x86_64_sysv_elf_gas.S
>>   create mode 100644 samples/rpal/librpal/private.h
>>   create mode 100644 samples/rpal/librpal/rpal.c
>>   create mode 100644 samples/rpal/librpal/rpal.h
>>   create mode 100644 samples/rpal/librpal/rpal_pkru.h
>>   create mode 100644 samples/rpal/librpal/rpal_queue.c
>>   create mode 100644 samples/rpal/librpal/rpal_queue.h
>>   create mode 100644 samples/rpal/librpal/rpal_x86_64_call_ret.S
>>   create mode 100755 samples/rpal/offset.sh
>>   create mode 100644 samples/rpal/server.c
>>
>> --
>> 2.20.1
>>

Thank you for your feedback! There might be some misunderstanding.
According to the feedback in RPAL V1, we rebased the RPAL to the latest
stable kernel and added an introduction section to explain our
considerations regarding the process isolation of the RPAL architecture.

Thanks!

