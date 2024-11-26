Return-Path: <linux-fsdevel+bounces-35865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5919D902D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 02:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716A1169A35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 01:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E785F14A90;
	Tue, 26 Nov 2024 01:55:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from granite.fifsource.com (granite.fifsource.com [173.255.216.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7EDDA9;
	Tue, 26 Nov 2024 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.216.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732586159; cv=none; b=FhtgjUxdPHPHM0ZSKcE6jZ9JdoKXBocV139HXsD6tqkPpyNfIaWSAueI97e2KBEatQUxcIWLyI+/zx+JV87enLsZQkpVmXZYVqz0oQz4F1T7VDoJJb/jbhPRV35VssfihohgZ3elkmM2roJVyQuri+wkvzv1D99RhbfxAzRmmrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732586159; c=relaxed/simple;
	bh=x1Q1jqiMb0qZANI1diCAbnUoCUvWMoZSXXu1B14MoLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQGl0khTMGj0AFcvY4M6lFph0l3HqKA5h1BmCFqdjKjd+TS5SVm4ZkbW5dHvY2aJ9/t4xYL1mqkVjkf2jIvO9J+qymWvh7Hw0AxohZI/NSYhpIRclfOd1yWrCmSqDh+S8O60Ct3ldcs3kp4r8F/s3ywJcyKaCnE+VQ9Mi+0BRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fifi.org; spf=pass smtp.mailfrom=fifi.org; arc=none smtp.client-ip=173.255.216.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fifi.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fifi.org
Received: from ceramic.fifi.org (107-142-44-66.lightspeed.sntcca.sbcglobal.net [107.142.44.66])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by granite.fifsource.com (Postfix) with ESMTPSA id 345DC4076;
	Mon, 25 Nov 2024 17:48:49 -0800 (PST)
Message-ID: <3b1d4265b384424688711a9259f98dec44c77848.camel@fifi.org>
Subject: Re: Regression in NFS probably due to very large amounts of
 readahead
From: Philippe Troin <phil@fifi.org>
To: Anders Blomdell <anders.blomdell@gmail.com>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>,  linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
Date: Mon, 25 Nov 2024 17:48:48 -0800
In-Reply-To: <49648605-d800-4859-be49-624bbe60519d@gmail.com>
References: <49648605-d800-4859-be49-624bbe60519d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-11-23 at 23:32 +0100, Anders Blomdell wrote:
> When we (re)started one of our servers with 6.11.3-200.fc40.x86_64,
> we got terrible performance (lots of nfs: server x.x.x.x not
> responding).
> What triggered this problem was virtual machines with NFS-mounted
> qcow2 disks
> that often triggered large readaheads that generates long streaks of
> disk I/O
> of 150-600 MB/s (4 ordinary HDD's) that filled up the buffer/cache
> area of the
> machine.
>=20
> A git bisect gave the following suspect:
>=20
> git bisect start

8< snip >8

> # first bad commit: [7c877586da3178974a8a94577b6045a48377ff25]
> readahead: properly shorten readahead when falling back to
> do_page_cache_ra()

Thank you for taking the time to bisect, this issue has been bugging
me, but it's been non-deterministic, and hence hard to bisect.

I'm seeing the same problem on 6.11.10 (and earlier 6.11.x kernels) in
slightly different setups:

(1) On machines mounting NFSv3 shared drives. The symptom here is a
"nfs server XXX not responding, still trying" that never recovers
(while the server remains pingable and other NFSv3 volumes from the
hanging server can be mounted).

(2) On VMs running over qemu-kvm, I see very long stalls (can be up to
several minutes) on random I/O. These stalls eventually recover.

I've built a 6.11.10 kernel with
7c877586da3178974a8a94577b6045a48377ff25 reverted and I'm back to
normal (no more NFS hangs, no more VM stalls).

Phil.

