Return-Path: <linux-fsdevel+bounces-63576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BB2BC3889
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 09:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13A8402BA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 07:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64742F0C7A;
	Wed,  8 Oct 2025 07:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4CLiF6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E92E62C6
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907054; cv=none; b=NRNEnnYUcpNeRtfdwFXQC+DGC+2K9W9hOtXDieJmDAcp3321OLrF78k2Sp1wQ5WD5awDeMKa8aBrC7LWOfJRd/fLsqiW+dKH+iV/5qKA2ZUf28Xk+cK6jCO4Bgf3bHMx5zd6LhZ2S2IsC7zFkD9897fIZo7PWOQu3PBVg2c7iBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907054; c=relaxed/simple;
	bh=/GbuQkuDNR0smyhVeZXvUoVOJNV+5FL2qiigjo7yspo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1UMD92kz5lhQ96cIcf4hkWmDCyvztQk9MgBokRarK2Ismv/Z74/WyWVtrZxYZFKUb7VS3Utm1YIyA8HUFQ/rVW0EQQgstDk2mvEbVp4Rzfo1cljX+VE1tmWlHs4q3Cd5O1GEllpZf8L6Hvc8dkm+TOrQJYUq/NB2qkSEUWy9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4CLiF6F; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4df3fabe9c2so233991cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 00:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759907051; x=1760511851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPCHBZ1+/7LiLJckiEnwJaZfBghJo0RvCO3Y5uD53wo=;
        b=B4CLiF6Figh5oBsptxipQcJrfoHUMisD+0Iw/gee+79h+97umCSutby3pdtSNAQ9jx
         mUgMjq8eL9b9TF8DMJEv1wO16xM/RxvHZFLCX8cS/vU8JhwfeOuPC5gR4I+vTOdvelNg
         7Eq0N9xD55xuK/M1JjxkoY8B7s5KEhp9qFCa1asos3hy/WOuVVAvnue5VpJHij8nIcY1
         cTrQErj7Tnx0E1Ea/hka5HHt16SAoBMrohHmarngBz717dmFWthSwqou32jWhV3rJGoK
         ni0yHvmuEnmtEDF92PX9zZd6ALFP3zBEm4RUi/iq2DxjK5+Uff51HJF58SNwr80NKXX0
         QHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759907051; x=1760511851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPCHBZ1+/7LiLJckiEnwJaZfBghJo0RvCO3Y5uD53wo=;
        b=LjO4xFdETYmfuoMZJ4c6UUyoWZFB3mU53+OQvGDbpldnzdsZRanfYGkY/lLgsq+ABi
         E+R6cn4B9GWW3QOPx8FZXU/S8M59k9n22qqRb1UZh+H+cMPdP+mShcq2mJ9Lz/A7l+1K
         lp29M3ILScmYQp53qFfH1jpUQ5Unu2PftTzksExagSq2Zo+VijzNfzJylRUviHgVMF/Q
         ZQuMKniFUohc8f4PqgiSNpKk8iEeCGn9htgwKBWZ6VgSMdTtegjJr2npW1CLbXcmH9aX
         L272pKg7mTpucLM/bOyKJ+uRNmVZBJiVGXMWQHYxLcgRvnsW1p3MK99BOXrpboTfcycU
         vFSg==
X-Forwarded-Encrypted: i=1; AJvYcCXDifzeNzA7rTfzG0JW6j/hhPPgWn5j8m+4wBvHnqTJmp9om0HtPIsbUJmPEEuE1ntI+paC83ONVq3EuofB@vger.kernel.org
X-Gm-Message-State: AOJu0YyR4n1udTEZvmIxxmxxD2CFnu9MoxckGhqGcISlZwUvBP/r0paQ
	90Dv4KaoxogWi/R+lRBUg4RpKIc+KJ+AYEGllm6gILik5m6B/6G3z7w8c6n/imBDsHQb97Uvyvj
	qCR31b9Ant7coT1RAH9ZLZBmAq6vhcjWNngkWnH0J
X-Gm-Gg: ASbGncudCMjQLWO6P+j//XHo5rGTneEfIZPu3P/s4ZmMoecnOXWyhOAwaD2on5eqbqu
	C16gMA3kn31KtRSQWkSuijEMdu3dDvYaByChtnW2rVMPOE/t9APxyhXUz8KW9UXJswMFeHF9ntX
	SYm4OPH3sWXlCeba47rzy/DZWMe25SkRRzrIsfvFWo1j77OJL6T/+DbePkfw9NX3he489ILeiLs
	U9KnQCSLui0k+N04CmCqX+WiHq2HRkyF023AX+kPERWVqYBo0gATll996sihm+pyxyfhMTUdowJ
	K/2UBg==
X-Google-Smtp-Source: AGHT+IESBNxpmlHAcig1IJkHHF05YX821iqOxoDV74weoqPTYVJz+7JZa7+j9bKX361CFoQRAxX2np/+3jTAYoYjULA=
X-Received: by 2002:a05:622a:14cd:b0:4b4:9863:5d76 with SMTP id
 d75a77b69052e-4e6eab2eacfmr4994001cf.8.1759907049795; Wed, 08 Oct 2025
 00:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com> <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
In-Reply-To: <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 8 Oct 2025 00:03:58 -0700
X-Gm-Features: AS18NWCS-g05IhVhTIM2Iz76DqP2Hm1WLW7pFPt_MogdzxJ745tyFKTSuojklQE
Message-ID: <CAAywjhSP=ugnSJOHPGmTUPGh82wt+qnaqZAqo99EfhF-XHD5Sg@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 10:11=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Sun, Sep 28, 2025 at 9:03=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > This series introduces the Live Update Orchestrator (LUO), a kernel
> > subsystem designed to facilitate live kernel updates. LUO enables
> > kexec-based reboots with minimal downtime, a critical capability for
> > cloud environments where hypervisors must be updated without disrupting
> > running virtual machines. By preserving the state of selected resources=
,
> > such as file descriptors and memory, LUO allows workloads to resume
> > seamlessly in the new kernel.
> >
> > The git branch for this series can be found at:
> > https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v4
> >
> > The patch series applies against linux-next tag: next-20250926
> >
> > While this series is showed cased using memfd preservation. There are
> > works to preserve devices:
> > 1. IOMMU: https://lore.kernel.org/all/20250928190624.3735830-16-skhawaj=
a@google.com
> > 2. PCI: https://lore.kernel.org/all/20250916-luo-pci-v2-0-c494053c3c08@=
kernel.org
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Changelog since v3:
> > (https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@so=
leen.com):
> >
> > - The main architectural change in this version is introduction of
> >   "sessions" to manage the lifecycle of preserved file descriptors.
> >   In v3, session management was left to a single userspace agent. This
> >   approach has been revised to improve robustness. Now, each session is
> >   represented by a file descriptor (/dev/liveupdate). The lifecycle of
> >   all preserved resources within a session is tied to this FD, ensuring
> >   automatic cleanup by the kernel if the controlling userspace agent
> >   crashes or exits unexpectedly.
> >
> > - The first three KHO fixes from the previous series have been merged
> >   into Linus' tree.
> >
> > - Various bug fixes and refactorings, including correcting memory
> >   unpreservation logic during a kho_abort() sequence.
> >
> > - Addressing all comments from reviewers.
> >
> > - Removing sysfs interface (/sys/kernel/liveupdate/state), the state
> >   can now be queried  only via ioctl() API.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Hi all,
>
> Following up on yesterday's Hypervisor Live Update meeting, we
> discussed the requirements for the LUO to track dependencies,
> particularly for IOMMU preservation and other stateful file
> descriptors. This email summarizes the main design decisions and
> outcomes from that discussion.
>
> For context, the notes from the previous meeting can be found here:
> https://lore.kernel.org/all/365acb25-4b25-86a2-10b0-1df98703e287@google.c=
om
> The notes for yesterday's meeting are not yes available.
>
> The key outcomes are as follows:
>
> 1. User-Enforced Ordering
> -------------------------
> The responsibility for enforcing the correct order of operations will
> lie with the userspace agent. If fd_A is a dependency for fd_B,
> userspace must ensure that fd_A is preserved before fd_B. This same
> ordering must be honored during the restoration phase after the reboot
> (fd_A must be restored before fd_B). The kernel preserve the ordering.
>
> 2. Serialization in PRESERVE_FD
> -------------------------------
> To keep the global prepare() phase lightweight and predictable, the
> consensus was to shift the heavy serialization work into the
> PRESERVE_FD ioctl handler. This means that when userspace requests to
> preserve a file, the file handler should perform the bulk of the
> state-saving work immediately.
>
> The proposed sequence of operations reflects this shift:
>
> Shutdown Flow:
> fd_preserve() (heavy serialization) -> prepare() (lightweight final
> checks) -> Suspend VM -> reboot(KEXEC) -> freeze() (lightweight)
>
> Boot & Restore Flow:
> fd_restore() (lightweight object creation) -> Resume VM -> Heavy
> post-restore IOCTLs (e.g., hardware page table re-creation) ->
> finish() (lightweight cleanup)
>
> This decision primarily serves as a guideline for file handler
> implementations. For the LUO core, this implies minor API changes,
> such as renaming can_preserve() to a more active preserve() and adding
> a corresponding unpreserve() callback to be called during
> UNPRESERVE_FD.
>
> 3. FD Data Query API
> --------------------
> We identified the need for a kernel API to allow subsystems to query
> preserved FD data during the boot process, before userspace has
> initiated the restore.
>
> The proposed API would allow a file handler to retrieve a list of all
> its preserved FDs, including their session names, tokens, and the
> private data payload.
>
> Proposed Data Structure:
>
> struct liveupdate_fd {
>         char *session; /* session name */
>         u64 token; /* Preserved FD token */
>         u64 data; /* Private preserved data */
> };
>
> Proposed Function:
> liveupdate_fd_data_query(struct liveupdate_file_handler *h,
>                          struct liveupdate_fd *fds, long *count);
>
> 4. New File-Lifecycle-Bound Global State
> ----------------------------------------
> A new mechanism for managing global state was proposed, designed to be
> tied to the lifecycle of the preserved files themselves. This would
> allow a file owner (e.g., the IOMMU subsystem) to save and retrieve
> global state that is only relevant when one or more of its FDs are
> being managed by LUO.
>
> The key characteristics of this new mechanism are:
> The global state is optionally created on the first preserve() call
> for a given file handler.
> The state can be updated on subsequent preserve() calls.
> The state is destroyed when the last corresponding file is unpreserved
> or finished.
> The data can be accessed during boot.
>
> I am thinking of an API like this.
>
> 1. Add three more callbacks to liveupdate_file_ops:

This part is a little tricky, the file handler might be in a
completely different subsystem as compared to the global state. While
FD is supposed to own and control the lifecycle of the preserved
state, the global state might be needed in a completely different
layer during boot or some other event. Maybe the user can put some
APIs in place to move this state across layers?

Subsystems actually do provide this flexibility. But If I see
correctly, this approach is "global" like a subsystem but synchronous.
Users can decide when to preserve/create global state when they need
without the need to stage it and preserve it when subsystem PREPARE is
called.
> /*
>  * Optional. Called by LUO during first get global state call.
>  * The handler should allocate/KHO preserve its global state object and r=
eturn a
>  * pointer to it via 'obj'. It must also provide a u64 handle (e.g., a ph=
ysical
>  * address of preserved memory) via 'data_handle' that LUO will save.
>  * Return: 0 on success.
>  */
> int (*global_state_create)(struct liveupdate_file_handler *h,
>                            void **obj, u64 *data_handle);
>
> /*
>  * Optional. Called by LUO in the new kernel
>  * before the first access to the global state. The handler receives
>  * the preserved u64 data_handle and should use it to reconstruct its
>  * global state object, returning a pointer to it via 'obj'.
>  * Return: 0 on success.
>  */
> int (*global_state_restore)(struct liveupdate_file_handler *h,
>                             u64 data_handle, void **obj);

If I understand correctly, is this only for unpacking? Once unpacked
the user can call the _get function and get the global state that it
just unpacked. This should be fine.
>
> /*
>  * Optional. Called by LUO after the last
>  * file for this handler is unpreserved or finished. The handler
>  * must free its global state object and any associated resources.
>  */
> void (*global_state_destroy)(struct liveupdate_file_handler *h, void *obj=
);
>
> The get/put global state data:
>
> /* Get and lock the data with file_handler scoped lock */
> int liveupdate_fh_global_state_get(struct liveupdate_file_handler *h,
>                                    void **obj);
>
> /* Unlock the data */
> void liveupdate_fh_global_state_put(struct liveupdate_file_handler *h);
>
> Execution Flow:
> 1. Outgoing Kernel (First preserve() call):
> 2. Handler's preserve() is called. It needs the global state, so it calls
>    liveupdate_fh_global_state_get(&h, &obj). LUO acquires h->global_state=
_lock.
>    It sees h->global_state_obj is NULL.
>    LUO calls h->ops->global_state_create(h, &h->global_state_obj, &handle=
).
>    The handler allocates its state, preserves it with KHO, and returns it=
s live
>    pointer and a u64 handle.
> 3. LUO stores the handle internally for later serialization.
> 4. LUO sets *obj =3D h->global_state_obj and returns 0 with the lock stil=
l held.
> 5. The preserve() callback does its work using the obj.
> 6. It calls liveupdate_fh_global_state_put(h), which releases the lock.
>
> Global PREPARE:
> 1. LUO iterates handlers. If h->count > 0, it writes the stored data_hand=
le into
>    the LUO FDT.
>
> Incoming Kernel (First access):
> 1. When liveupdate_fh_global_state_get(&h, &obj) is called the first time=
. LUO
>    acquires h->global_state_lock.
> 2. It sees h->global_state_obj is NULL, but it knows it has a preserved u=
64
>    handle from the FDT. LUO calls h->ops->global_state_restore()
> 3. Reconstructs its state object, and returns the live pointer.
> 4. LUO sets *obj =3D h->global_state_obj and returns 0 with the lock held=
.
> 5. The caller does its work.
> 6. It calls liveupdate_fh_global_state_put(h) to release the lock.
>
> Last File Cleanup (in unpreserve or finish):
> 1. LUO decrements h->count to 0.
> 2. This triggers the cleanup logic.
> 3. LUO calls h->ops->global_state_destroy(h, h->global_state_obj).
> 4. The handler frees its memory and resources.
> 5. LUO sets h->global_state_obj =3D NULL, resetting it for a future live =
update
>    cycle.
>
> Pasha
>
>
> Pasha

