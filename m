Return-Path: <linux-fsdevel+bounces-64937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D00BF71B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65AC54057D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606EA33B962;
	Tue, 21 Oct 2025 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="dbM54z7X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DDE33C52B
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057298; cv=none; b=emY6bZfM2qlvtvXwx4uIAN3t77lKu6Oq20chpBy9pk0y/rii05Z7TIfJzjNEhlm2ER48ina12KfsvEAUC5XYSlPsZEo6dzh0WYT+bJ2ax0Bx7dyFafgAIWJ3cvTUesjpcEg4XOSr+gTZgobbsXAJnBa0XioaeYO54j7dIz1Czj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057298; c=relaxed/simple;
	bh=HtEYm3WbJmCN1KO4SaCrajhVynmFoIbWwbCW53lJb9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQJ6wfhcbtiG8vMAzGaKbONZOLpi0mBWF5ye0strS6RVxnwq3j3EK4g4LP549TgaakYVGCnFAraxpMcDfI3WiYfohVwkFG2CPSBgC8IHaTt3YKYlZ5b3877KPboBIYPI5fiUquJIDkkX33EHg0IX0jOOZCDe/2Hu7ZWyTcbK8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=dbM54z7X; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781010ff051so4223281b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1761057296; x=1761662096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sV3KIhc1PNPd/uW7bqfRoDcwumTG1e/maPgTaMLXuW0=;
        b=dbM54z7X73YK0xvaCLxSrxd7B9cDEkxGaKXjhj2zmoGu16KWr+T0FJK0jdTCmpGsH3
         o4ZFBsyVFrLggPOL/Tb6YvsfQTfHNlVgGYcqpMvgqE3j8e7S6SI6xyRSgNdyKRk9vffD
         sG4J8Ir0DyDNcILEwSnSyWufpvhezNY11r2M0ghYMIFt6G5EvBatBtUx8e2wYZJ0ygHZ
         C9N17nDus6p3E1Up4CMOr7as/cWtYPTBpPBD5RhcB+Cl5nIfnA0qqH4EZ1dT09I29LSO
         ZEh8Ip1rrYdkvUAX71vHOoUZMNBDX8rajGm7vagcak1T0w/X1gfLdGtEmchGigMrqEWX
         /mlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761057296; x=1761662096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV3KIhc1PNPd/uW7bqfRoDcwumTG1e/maPgTaMLXuW0=;
        b=PW3yZj9UAXWfGAtVyxI2BSRKgBWXrnMCN/ZrpZrvIYbo64TzM9WREkgrYX9v9Yh2Ct
         7pzcqApRP8i+8EGgvYvQUOnhZ4IaOR8TxBt+Nzl0DDAnhisYPkUYFb6hEghFzzz8x+h8
         zYsuJo/ikEfipSQYXxgZpQklOqXX7bHZwnJBBJ/HmyivMACmZujwFRDEvqyoMGnEeekf
         IsUn+lg2NF1reP51V/MtHCoFfpAbUUx+F6H9OaNfzY0l5KLDSuiqaRKu/gUDvbdn7Pad
         fpAXRfacUYvKOd/WnkYAb8IiCWIaBe6oCt4GxMJxDyPyEj8aDOrvmHPnF+Jx2G44Lygp
         mhaw==
X-Gm-Message-State: AOJu0YyEmr5JE+ppWTkp/77EsHJb6q51faV6QI1DIbmIVOiWqJ6aaWTN
	niDNVTGSeaa87GgaFBQESNsf7+3HQ5i8Z5XtYKI0ovjavGSBnS9a2rTY/QEPnwIGM48=
X-Gm-Gg: ASbGnctH/rYzpnGLIQQsQOPWTkhygmxlJAz0c+FHLf9xkf/rLLVJ7kkbZQv78QHSTTB
	6Kn3Y9o0v1m6d7DxdAlEA+H0pfWdoP54eUy+sJOSFJuYk4B/5i/nD42omRjebLx80eJ0IIhKkLi
	hgNRGLYb6EaCO2in3xfnKsqByJ8th/AqLaQ1mqwUMQRZLogc8e0GTWWNOeANYPMv4Owl4ktD+QW
	x9hQY3k01NdhHA3TeOaAWYhDd6AwbVLDwhocssmMgVaa4pKVaq/BBZ6Pu0ScHfeOlOkE1QMpX+n
	pTFRhu1hDh686zi+j+M2gJ8bO0ya0h8tJ2fuvzBGvPW73MCcRI8vI9byljsYa98VzfMfQ/ZG41g
	kML0QBeUGYWlcCUEFDzSrIy5R79QGYXZ1OUysEiGwxodfSGk41+aKityZk1U9ozs1W0HJDVcV7R
	cIafxaWGGr
X-Google-Smtp-Source: AGHT+IHBX9TIE3IQtEBoV7LOteBO6V2Q79FbArZ4HOehhBp5RxecJgOwYxXXdgG5tSXjdbgoVNEnFA==
X-Received: by 2002:a05:6a00:4b0f:b0:781:275a:29d9 with SMTP id d2e1a72fcca58-7a220b10725mr23389331b3a.18.1761057296233;
        Tue, 21 Oct 2025 07:34:56 -0700 (PDT)
Received: from localhost ([12.197.85.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15829sm11500038b3a.11.2025.10.21.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:34:54 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:34:54 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC DRAFT 00/50] nstree: listns()
Message-ID: <20251021143454.GA8072@fedora>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>

On Tue, Oct 21, 2025 at 01:43:06PM +0200, Christian Brauner wrote:
> Hey,
> 
> As announced a while ago this is the next step building on the nstree
> work from prior cycles. There's a bunch of fixes and semantic cleanups
> in here and a ton of tests.
> 
> I need helper here!: Consider the following current design:
> 
> Currently listns() is relying on active namespace reference counts which
> are introduced alongside this series.
> 
> The active reference count of a namespace consists of the live tasks
> that make use of this namespace and any namespace file descriptors that
> explicitly pin the namespace.
> 
> Once all tasks making use of this namespace have exited or reaped, all
> namespace file descriptors for that namespace have been closed and all
> bind-mounts for that namespace unmounted it ceases to appear in the
> listns() output.
> 
> My reason for introducing the active reference count was that namespaces
> might obviously still be pinned internally for various reasons. For
> example the user namespace might still be pinned because there are still
> open files that have stashed the openers credentials in file->f_cred, or
> the last reference might be put with an rcu delay keeping that namespace
> active on the namespace lists.
> 
> But one particularly strange example is CONFIG_MMU_LAZY_TLB_REFCOUNT=y.
> Various architectures support the CONFIG_MMU_LAZY_TLB_REFCOUNT option
> which uses lazy TLB destruction.
> 
> When this option is set a userspace task's struct mm_struct may be used
> for kernel threads such as the idle task and will only be destroyed once
> the cpu's runqueue switches back to another task. So the kernel thread
> will take a reference on the struct mm_struct pinning it.
> 
> And for ptrace() based access checks struct mm_struct stashes the user
> namespace of the task that struct mm_struct belonged to originally and
> thus takes a reference to the users namespace and pins it.
> 
> So on an idle system such user namespaces can be persisted for pretty
> arbitrary amounts of time via struct mm_struct.
> 
> Now, without the active reference count regulating visibility all
> namespace that still are pinned in some way on the system will appear in
> the listns() output and can be reopened using namespace file handles.
> 
> Of course that requires suitable privileges and it's not really a
> concern per se because a task could've also persist the namespace
> recorded in struct mm_struct explicitly and then the idle task would
> still reuse that struct mm_struct and another task could still happily
> setns() to it afaict and reuse it for something else.
> 
> The active reference count though has drawbacks itself. Namely that
> socket files break the assumption that namespaces can only be opened if
> there's either live processes pinning the namespace or there are file
> descriptors open that pin the namespace itself as the socket SIOCGSKNS
> ioctl() can be used to open a network namespace based on a socket which
> only indirectly pins a network namespace.
> 
> So that punches a whole in the active reference count tracking. So this
> will have to be handled as right now socket file descriptors that pin a
> network namespace that don't have an active reference anymore (no live
> processes, not explicit persistence via namespace fds) can't be used to
> issue a SIOCGSKNS ioctl() to open the associated network namespace.
> 
> So two options I see if the api is based on ids:
> 
> (1) We use the active reference count and somehow also make it work with
>     sockets.
> (2) The active reference count is not needed and we say that listns() is
>     an introspection system call anyway so we just always list
>     namespaces regardless of why they are still pinned: files,
>     mm_struct, network devices, everything is fair game.
> (3) Throw hands up in the air and just not do it.
>

I think the active reference counts are just nice to have, if I'm not missing
something we still have to figure out which pid is using the namespace we may
want to enter, so there's already a "time of check, time of use" issue. I think
if we want to have the active count we can do it just as an advisory thing, have
a flag that says "this ns is dying and you can't do anything with it", and then
for network namespaces we can just never set the flag and let the existing
SIOCKGSNS ioctl work as is.

The bigger question (and sorry I didn't think about this before now), is how are
we going to integrate this into the rest of the NS related syscalls? Having
progromatic introspection is excellent from a usabiility point of view, but we
also want to be able to have an easy way to get a PID from these namespaces, and
even eventually do things like setns() based on these IDs. Those are followup
series of course, but we should at least have a plan for them. Thanks,

Josef

