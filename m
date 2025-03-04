Return-Path: <linux-fsdevel+bounces-43137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6038EA4E8A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C7B19C4D4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283892C155C;
	Tue,  4 Mar 2025 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xVzpIv8w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5282C154E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107564; cv=none; b=ohs0BQa4wAxisDCHMR2OEAGdhMwKiYLlDwojQu7LePUSNdS0uE09Rox9zVCay5Ci8bMuTzigCGvNheEQKOmUdDLUAFudnV7qCpaCBdSk4JdF+0zR508P/ej1hNWJIMcfi41lLcyu7vwkC/XGdipZf1CfYYws9K+PfLhq3hh5voA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107564; c=relaxed/simple;
	bh=NMceGXU1AayKIvYDDDytTT9zM6ePfplkGhj1Gwrp0Tc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mccJJ5+GmU3r6fM6budCpTtTPyQUGks42AB2K1oK7AQVKZCSXHPT+A24vSOgk53LP4ITxQsL+ea/eLkJMmk8581yrhoROTDxiZS+IwBRtJF8mW+Qe/xhL8zxsIKQKjy2C2YJQ+TDNmo4BzO9aptHrLPXg+A/LhRVmSoPej7LwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xVzpIv8w; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2236b6fb4a6so146402315ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 08:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741107562; x=1741712362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7W7yQmf61Pq53pMS2vzrgU7eZq7ZkAtUnxQ4fLwZP8=;
        b=xVzpIv8wKPzZufylkWP08Zk3L6PpAtcFJZqbK5fZWTOv6yzWtCz1OLqybZApjy6ZQ2
         k2GZ1UrEtB9Rs8bxEXpyClDuHvAbnZIALZWxGlH9mV2iVrCW57deaINSsPlABGY0yJWQ
         YHaMrxkB50e9C5nK/ZJ8zrPJxBSGQcp0jC7rsHotKUNBJ6YseLws9+xoJrCx9H2hLjZN
         fbY6pA2XmiwM/36ztyZTla9TPDMyzTECE5ZXmnenjgYn3gP9CoXz/Z6SPnoxHSx/3PsA
         Lv9rhuKNQX1xrJdYjNT9rHstlHTTsTcQAScduyhRfLJ4P3lJDu1w9D7dlh0w450BP9n9
         10fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107562; x=1741712362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7W7yQmf61Pq53pMS2vzrgU7eZq7ZkAtUnxQ4fLwZP8=;
        b=F5Tt6C2kswDxRYyznfjWtF5S9W6TTlLSrpjMJxtstZpXkZO/ESK69WCQ5/010nTng7
         /ItY+fmo+USgcqHEcMlUnDShMtMjF+1Cewiaivzr3p1YgFUHmhYD6ZhDfQu8v6kwt7Ok
         5hk1rQ1QLEJiBPzOGltLB1O5WDUp7qy6DLoXNQUFCD1ePrkW8TfBlvkeaoIQyKcXMzfJ
         0EuvMwQ0uLxbO+yaY7Xyc6bl3SrzPrS9X1oVGuRRU0MDdpyX+KX0U2nBz5fwSxrjp2Cr
         JJxvr0rAF3yz+v9gITSwfgC27425aDowaY5COTUiKuOOSeHxQDk8wriJkWUy4kaJPHcd
         EK2w==
X-Forwarded-Encrypted: i=1; AJvYcCW05Cq+4fBgWjT2zx8ZM3mHX7wzX0+7tryDhDAHtfcGA+Ohlf32Hkw2syvXHbJaelP9ruxCq/XaZ9Eeqm32@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0s3poxr0UJkWRkCdQtUa8CC1+EKWdPdriOi6dbE9pjnIKnax
	kfBKWEKXolJfVjBPLsSD/hHZUyGw0+E6x9a0yLRqvGcsYarhNnbc/jPw+49ambs//7evD7e6cUj
	NsA==
X-Google-Smtp-Source: AGHT+IHAFrEgPQdnRru2RpcA9ojFQVDAwMfLY/u9ofYMqa8EKlltfiiKVsKJDm4SpBm3Hx0wphR2ehXHeKw=
X-Received: from plbju14.prod.google.com ([2002:a17:903:428e:b0:220:e84e:350c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b83:b0:221:7955:64c3
 with SMTP id d9443c01a7336-22368f9d123mr262199705ad.23.1741107562128; Tue, 04
 Mar 2025 08:59:22 -0800 (PST)
Date: Tue, 4 Mar 2025 08:59:20 -0800
In-Reply-To: <9d04c204-cb9a-4109-977b-3d39b992c521@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b494af0e-3441-48d4-abc8-df3d5c006935@suse.cz> <diqz8qplabre.fsf@ackerleytng-ctop.c.googlers.com>
 <Z8cci0nNtwja8gyR@google.com> <9d04c204-cb9a-4109-977b-3d39b992c521@redhat.com>
Message-ID: <Z8cxaGGoQ2163-R6@google.com>
Subject: Re: [PATCH v6 4/5] KVM: guest_memfd: Enforce NUMA mempolicy using
 shared policy
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Vlastimil Babka <vbabka@suse.cz>, shivankg@amd.com, 
	akpm@linux-foundation.org, willy@infradead.org, pbonzini@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com, 
	tabba@google.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 04, 2025, David Hildenbrand wrote:
> On 04.03.25 16:30, Sean Christopherson wrote:
> > On Tue, Mar 04, 2025, Ackerley Tng wrote:
> > > Vlastimil Babka <vbabka@suse.cz> writes:
> > > > > struct shared_policy should be stored on the inode rather than the file,
> > > > > since the memory policy is a property of the memory (struct inode),
> > > > > rather than a property of how the memory is used for a given VM (struct
> > > > > file).
> > > > 
> > > > That makes sense. AFAICS shmem also uses inodes to store policy.
> > > > 
> > > > > When the shared_policy is stored on the inode, intra-host migration [1]
> > > > > will work correctly, since the while the inode will be transferred from
> > > > > one VM (struct kvm) to another, the file (a VM's view/bindings of the
> > > > > memory) will be recreated for the new VM.
> > > > > 
> > > > > I'm thinking of having a patch like this [2] to introduce inodes.
> > > > 
> > > > shmem has it easier by already having inodes
> > > > 
> > > > > With this, we shouldn't need to pass file pointers instead of inode
> > > > > pointers.
> > > > 
> > > > Any downsides, besides more work needed? Or is it feasible to do it using
> > > > files now and convert to inodes later?
> > > > 
> > > > Feels like something that must have been discussed already, but I don't
> > > > recall specifics.
> > > 
> > > Here's where Sean described file vs inode: "The inode is effectively the
> > > raw underlying physical storage, while the file is the VM's view of that
> > > storage." [1].
> > > 
> > > I guess you're right that for now there is little distinction between
> > > file and inode and using file should be feasible, but I feel that this
> > > dilutes the original intent.
> > 
> > Hmm, and using the file would be actively problematic at some point.  One could
> > argue that NUMA policy is property of the VM accessing the memory, i.e. that two
> > VMs mapping the same guest_memfd could want different policies.  But in practice,
> > that would allow for conflicting requirements, e.g. different policies in each
> > VM for the same chunk of memory, and would likely lead to surprising behavior due
> > to having to manually do mbind() for every VM/file view.
> 
> I think that's the same behavior with shmem? I mean, if you have two people
> asking for different things for the same MAP_SHARE file range, surprises are
> unavoidable.

Yeah, I was specifically thinking of the case where a secondary mapping doesn't
do mbind() at all, e.g. could end up effectively polluting guest_memfd with "bad"
allocations.

