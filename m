Return-Path: <linux-fsdevel+bounces-11486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309E9853F04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99A1B288EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CB66280E;
	Tue, 13 Feb 2024 22:46:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DA626B2;
	Tue, 13 Feb 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864372; cv=none; b=uFfAUCfKb1k+vMYIpdbZofbIhyvzVzcovZRkfuwhkj8PwIvdg/jhM4KxIlOMYPi8i98pu9kRtHUz+LrSTSqv4vj7iGs8YmdWKJZWNQxHuwp8lJIExNP6htXT2eVkH8RyBI5KfFOXp2bVyr9dIMLqX7Ks1veUa2CIlhPySusbgKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864372; c=relaxed/simple;
	bh=6AWrD9fLn9rIoWsfdQ1zN/JM/sKG+z0lxc9s0V1f1BY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2L2GgG5UXbunjvUu53WSY3kBT4M1pNs7CWMYUv5/4CXZ9oFFgfgHlr30XzzZiXNhovAWcEivwrIl3J42LMBLVy6E0T8zR+WXp/9bEdqbxeV7sEMkGhvLgnEIEUb/NeWb2QacjiR7i8+2XL5vOcM4/wdBQlEsWLJJero2/+71fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29488C433C7;
	Tue, 13 Feb 2024 22:46:04 +0000 (UTC)
Date: Tue, 13 Feb 2024 17:47:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Cc: Suren Baghdasaryan <surenb@google.com>, "Darrick J. Wong"
 <djwong@kernel.org>, akpm@linux-foundation.org, kent.overstreet@linux.dev,
 mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
 void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, peterx@redhat.com, david@redhat.com, axboe@kernel.dk,
 mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org,
 dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
 paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com,
 yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
 andreyknvl@gmail.com, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
Message-ID: <20240213174733.086b2e3e@gandalf.local.home>
In-Reply-To: <202402131436.2CA91AE@keescook>
References: <20240212213922.783301-1-surenb@google.com>
	<20240212213922.783301-14-surenb@google.com>
	<202402121433.5CC66F34B@keescook>
	<CAJuCfpGU+UhtcWxk7M3diSiz-b7H64_7NMBaKS5dxVdbYWvQqA@mail.gmail.com>
	<20240213222859.GE6184@frogsfrogsfrogs>
	<CAJuCfpGHrCXoK828KkmahJzsO7tJsz=7fKehhkWOT8rj-xsAmA@mail.gmail.com>
	<202402131436.2CA91AE@keescook>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 14:38:16 -0800
Kees Cook <keescook@chromium.org> wrote:

> > > Save yourself a cycle of "rework the whole fs interface only to have
> > > someone else tell you no" and put it in debugfs, not sysfs.  Wrangling
> > > with debugfs is easier than all the macro-happy sysfs stuff; you don't
> > > have to integrate with the "device" model; and there is no 'one value
> > > per file' rule.  
> > 
> > Thanks for the input. This file used to be in debugfs but reviewers
> > felt it belonged in /proc if it's to be used in production
> > environments. Some distros (like Android) disable debugfs in
> > production.  
> 
> FWIW, I agree debugfs is not right. If others feel it's right in /proc,
> I certainly won't NAK -- it's just been that we've traditionally been
> trying to avoid continuing to pollute the top-level /proc and instead
> associate new things with something in /sys.

You can create your own file system, but I would suggest using kernfs for it ;-)

If you look in /sys/kernel/ you'll see a bunch of kernel file systems already there:

 ~# mount |grep kernel
 securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
 debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
 tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
 configfs on /sys/kernel/config type configfs (rw,nosuid,nodev,noexec,relatime)

-- Steve

