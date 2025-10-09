Return-Path: <linux-fsdevel+bounces-63687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D01BCB211
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 00:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC6B3AF1F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 22:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0F286D62;
	Thu,  9 Oct 2025 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NfvaH25e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1381286883
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049769; cv=none; b=M0JnDUnICX0EmiRJTTSGheoxW9GzH6tgUQcXd1czwye3pJOvOapJ9OySTvrHYO7zgSh78Z4bhleFZ0mkJ+iJVGAIhC/v2C+FXGXSC5BylqxPhJNM38/Rz978jCrhAXoEGi7TIndk2AfJbJas2mGtVdIp3cRx4gdWIrjVXl3VN20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049769; c=relaxed/simple;
	bh=ekP0ZQ45qB1qjtzYO3U/Bk6+BdQ2224iAUiUCuv1zO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4BlasE4id+ZyfK2F8BM9zFpdDxJJvHQhJn79p56nwaUzPTKExTuqZihI4D7NgN7si465Vx47OEDPZOoU+RuOL9arQKTJKTLQ8DT2x4hZUy1uazo0ChkGGhGtqlZp5uM308Eg5WbUEuOv8WjQSDbP7rlizlb1ho6QTpDNtlBIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=NfvaH25e; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4da37f6e64cso14508251cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 15:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760049767; x=1760654567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FbWfQ96AFEkEG50UixpYovK71meMygfaTOSv2fS0lo=;
        b=NfvaH25ejd9yhUtOC1bZhYBeS5pBSOeNKHEDhv8F+UTxfjbJyKH2bkVpvSdZagpouN
         +MY82sRj1dmrtPAl/JLpAXEYSe1Ra3GuT7E+nKyaKz6S+SGX/E4NfkpyURRLaMFyIXyU
         RpylL/4wCHo6gbn8h2D7tKZgmZp+7uG5SunHfh+bBQJhLqllMie+q2syau3prfNb5vnb
         MHDQFkl+95oX4H1omSHmfE4G3EttRC5ILBNjZ/DZ3ZTMGLiqGte1UHOpcgASGxiMlgFl
         mYhxyinNnmuw3AVicq06zrlBNGgJ802MoBI9fxtjAMc9c1Sx9P6dVmyYm4cdSImpEjvm
         43GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049767; x=1760654567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FbWfQ96AFEkEG50UixpYovK71meMygfaTOSv2fS0lo=;
        b=HvzlEnpgL1eB0n1VRoGcvJ3gGMJc8f8/AWP7yfoW+9wsFPa2b/6wqWirrQBh/pJHHm
         R+CX4hS+LMEkX/NsqB/keYCVwik5PklYATgzetDTec5JAgl6bC9DVnVxWa1mDkM2h9G1
         Qxay1SAV2/n36sWi8a/d5Z0/Ij0wQBR3Rr06KB1bLvLhgCmzZTmZNP6SEQk8F01gwZUD
         A2aKahy8L9FZQ1WT66UWcjdP+zcMzWak4iDTBdi6CeI1qjYllUiXDE+Qp787rO90BDLM
         KUKugJMYPT+w6lEGdAKXZ/2tO9/yLup2rySOimVZa9B2ngGle0uV4Kb9h0C6y2ceY7+e
         jo0g==
X-Forwarded-Encrypted: i=1; AJvYcCWa3O1CkYPQ85oT2F9uSb8N8fC7d70NqiKRcmfqeqf59w8KHpaq8josiy8d97egWPcU7JnC+uRxXS5OTC9+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt0bkQ/QKS+zaEfUA+9sS1+n+/HLONt/ILMOLw5C6v2Ki+OjcE
	RBUlBzQsv5Baqw+kb0mnWyMJbeqFNWj2f0qABuz/CgBvFqxlVOKsIlYWjtY2z3n7ZuVQkQs5pZA
	82wbmFwYVd2JOcE78OfpRSN8bKnodr5qNAugE+7Rhpg==
X-Gm-Gg: ASbGncuZAs90qkdXkvdEdyTE8MEuHG6ExIhR+wowuIhPcj5TjBxs7Kysl/E4U/Cu2hp
	wihuXq71lW6GF+sBC4+e1dd2uTl/98mArBPpls5Vs/AqWNMO7mO5amKI3/ZSqbspxpIKnsBmEkB
	iqHIok751Tn71slT/DxAFoHxEH7VrHcXIo7SbnCYWmJdGndxf2kB51JabehSvM+2meVkmGCg0dk
	mLVijksGCzm5geoTjbH/6Ua6Ou6
X-Google-Smtp-Source: AGHT+IHG5W702Zbf4mjn7MvE15WtY39zkt1MK6wHvNWeSpV5Z77scUuTO2nY2xRATETmTz79MrDYNcaEvgfPFiK7ygM=
X-Received: by 2002:a05:622a:60d:b0:4b6:33c1:4d53 with SMTP id
 d75a77b69052e-4e6eacccf23mr129760071cf.16.1760049766599; Thu, 09 Oct 2025
 15:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com> <CAAywjhT_9vV-V+BBs1_=QqhCGQqHo89qWy7r5zW1ej51yHPGJA@mail.gmail.com>
In-Reply-To: <CAAywjhT_9vV-V+BBs1_=QqhCGQqHo89qWy7r5zW1ej51yHPGJA@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 9 Oct 2025 18:42:09 -0400
X-Gm-Features: AS18NWD5B-wFlFzrsG8ABOC3Hmjw4CdpOCjhPtFpyfzvKOXdPCdlviqFJ5wfQM0
Message-ID: <CA+CK2bAe3yk4NocURmihcuTNPUcb2-K0JCaQQ5GJ4B58YLEwEw@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
To: Samiullah Khawaja <skhawaja@google.com>
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

On Thu, Oct 9, 2025 at 5:58=E2=80=AFPM Samiullah Khawaja <skhawaja@google.c=
om> wrote:
>
> On Tue, Oct 7, 2025 at 10:11=E2=80=AFAM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On Sun, Sep 28, 2025 at 9:03=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > >
> > > This series introduces the Live Update Orchestrator (LUO), a kernel
> > > subsystem designed to facilitate live kernel updates. LUO enables
> > > kexec-based reboots with minimal downtime, a critical capability for
> > > cloud environments where hypervisors must be updated without disrupti=
ng
> > > running virtual machines. By preserving the state of selected resourc=
es,
> > > such as file descriptors and memory, LUO allows workloads to resume
> > > seamlessly in the new kernel.
> > >
> > > The git branch for this series can be found at:
> > > https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v4
> > >
> > > The patch series applies against linux-next tag: next-20250926
> > >
> > > While this series is showed cased using memfd preservation. There are
> > > works to preserve devices:
> > > 1. IOMMU: https://lore.kernel.org/all/20250928190624.3735830-16-skhaw=
aja@google.com
> > > 2. PCI: https://lore.kernel.org/all/20250916-luo-pci-v2-0-c494053c3c0=
8@kernel.org
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Changelog since v3:
> > > (https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@=
soleen.com):
> > >
> > > - The main architectural change in this version is introduction of
> > >   "sessions" to manage the lifecycle of preserved file descriptors.
> > >   In v3, session management was left to a single userspace agent. Thi=
s
> > >   approach has been revised to improve robustness. Now, each session =
is
> > >   represented by a file descriptor (/dev/liveupdate). The lifecycle o=
f
> > >   all preserved resources within a session is tied to this FD, ensuri=
ng
> > >   automatic cleanup by the kernel if the controlling userspace agent
> > >   crashes or exits unexpectedly.
> > >
> > > - The first three KHO fixes from the previous series have been merged
> > >   into Linus' tree.
> > >
> > > - Various bug fixes and refactorings, including correcting memory
> > >   unpreservation logic during a kho_abort() sequence.
> > >
> > > - Addressing all comments from reviewers.
> > >
> > > - Removing sysfs interface (/sys/kernel/liveupdate/state), the state
> > >   can now be queried  only via ioctl() API.
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Hi all,
> >
> > Following up on yesterday's Hypervisor Live Update meeting, we
> > discussed the requirements for the LUO to track dependencies,
> > particularly for IOMMU preservation and other stateful file
> > descriptors. This email summarizes the main design decisions and
> > outcomes from that discussion.
> >
> > For context, the notes from the previous meeting can be found here:
> > https://lore.kernel.org/all/365acb25-4b25-86a2-10b0-1df98703e287@google=
.com
> > The notes for yesterday's meeting are not yes available.
> >
> > The key outcomes are as follows:
> >
> > 1. User-Enforced Ordering
> > -------------------------
> > The responsibility for enforcing the correct order of operations will
> > lie with the userspace agent. If fd_A is a dependency for fd_B,
> > userspace must ensure that fd_A is preserved before fd_B. This same
> > ordering must be honored during the restoration phase after the reboot
> > (fd_A must be restored before fd_B). The kernel preserve the ordering.
> >
> > 2. Serialization in PRESERVE_FD
> > -------------------------------
> > To keep the global prepare() phase lightweight and predictable, the
> > consensus was to shift the heavy serialization work into the
> > PRESERVE_FD ioctl handler. This means that when userspace requests to
> > preserve a file, the file handler should perform the bulk of the
> > state-saving work immediately.
> >
> > The proposed sequence of operations reflects this shift:
> >
> > Shutdown Flow:
> > fd_preserve() (heavy serialization) -> prepare() (lightweight final
> > checks) -> Suspend VM -> reboot(KEXEC) -> freeze() (lightweight)
> >
> > Boot & Restore Flow:
> > fd_restore() (lightweight object creation) -> Resume VM -> Heavy
> > post-restore IOCTLs (e.g., hardware page table re-creation) ->
> > finish() (lightweight cleanup)
> >
> > This decision primarily serves as a guideline for file handler
> > implementations. For the LUO core, this implies minor API changes,
> > such as renaming can_preserve() to a more active preserve() and adding
> > a corresponding unpreserve() callback to be called during
> > UNPRESERVE_FD.
> >
> > 3. FD Data Query API
> > --------------------
> > We identified the need for a kernel API to allow subsystems to query
> > preserved FD data during the boot process, before userspace has
> > initiated the restore.
> >
> > The proposed API would allow a file handler to retrieve a list of all
> > its preserved FDs, including their session names, tokens, and the
> > private data payload.
> >
> > Proposed Data Structure:
> >
> > struct liveupdate_fd {
> >         char *session; /* session name */
> >         u64 token; /* Preserved FD token */
> >         u64 data; /* Private preserved data */
> > };
> >
> > Proposed Function:
> > liveupdate_fd_data_query(struct liveupdate_file_handler *h,
> >                          struct liveupdate_fd *fds, long *count);
>
> Now that you are adding the "File-Lifecycle-Bound Global State", I was
> wondering if this session data query mechanism is still necessary. It
> seems that any preserved state a file handler needs to restore during
> boot could be fetched using the Global data support instead. For
> example, I don't think session information will be needed to restore
> iommu domains during boot (iommu init), but even if some other file
> handler needs it then it can keep this info in global data. I
> discussed this briefly with Pasha today, but wanted to raise it here
> as well.

I agree, the query API is ugly and indeed not needed with the FLB
Global State. The biggest problem with the query API is that the
caller must somehow know how to interpret the preserved file-handler
data before the struct file is reconstructed. This is problematic;
there should only be one place that knows how to store and interpret
the data, not multiple.

It looks like the combination of an enforced ordering:
Preservation: A->B->C->D
Un-preservation: D->C->B->A
Retrieval: A->B->C->D

and the FLB Global State (where data is automatically created and
destroyed when a particular file type participates in a live update)
solves the need for this query mechanism. For example, the IOMMU
driver/core can add its data only when an iommufd is preserved and add
more data as more iommufds are added. The preserved data is also
automatically removed once the live update is finished or canceled.

Pasha

