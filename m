Return-Path: <linux-fsdevel+bounces-25580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7479C94DA4A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 05:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298541F22363
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 03:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7558913B584;
	Sat, 10 Aug 2024 03:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iKBHWi4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73FD3A1BA;
	Sat, 10 Aug 2024 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723260603; cv=none; b=NIe6RXkWSxWnUsf2GJSk1BvgM9AhzQ+aCcHKkmUVxkcH0jFk96ygQCVT8lxNqcnuoK0iYMdQ9XC57xPpq3K+vByW1ZQW0iUaRr9u0RWBoWPoW8QasRNJ+gHlpM3XAgHZ4nFHSudC04fyxhDxlUd2n7/scxO9b0oZG0dzmc62uuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723260603; c=relaxed/simple;
	bh=JG+S2VriE6vC0cT+340V8uthrcWccIelXM0OAvLdhgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDmR4jgNqWOH+xWNlIIUsHFvUVDBMXNfLd9NL7MvT5DZ7pywlA7Og2J/IRsfeYF3wIxb418ftXbYRszYuVluXTsD8xz4HF4FxYX4yeSC1jMUfLNBUfsHr/ogtvtSXQlmFpXBhF5miH7/BE4j0zNV09K6kVu/8HzAD1rvcX91KqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iKBHWi4d; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ln3k/EoX0oy3RTS4qxSKawW+zSS5fT3VDPUtbvDbogs=; b=iKBHWi4dDscoWrVq2GpUUY+I5f
	CANm6lIKUVTom7BQ4pQZh8oyxyXPsoKSfYmrCkES5HHakyaboJ6cdw1q3Nq5KTuobtQ9kjZ6cGdi1
	s/Z1ST9zS5Po7DZab5R4djkM/KMWMmakyJtSuvBGb0wtxbreWHNrmSNzRPnr6pu4Y1zXyvTERigcD
	Z4P7HN20LWzh9JLiu8b3ZeW0lBHSqTZGzTnsMEHHILRuYbwk7SR4W9//R9pdWb9qKgA06Uw3aEkUA
	k+tuEOb4mM3SwOHzU82Jntj/OZeLiFg82/PMzlQw/p7WkMcg6UmEzK/F+z/B+iYOLHGRelFE8UFeF
	0SETaWIg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sccng-00000000Km3-0pCw;
	Sat, 10 Aug 2024 03:29:52 +0000
Date: Sat, 10 Aug 2024 04:29:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Christian Brauner <brauner@kernel.org>, viro@kernel.org,
	bpf <bpf@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	kvm@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 17/39] bpf: resolve_pseudo_ldimm64(): take handling of a
 single ldimm64 insn into helper
Message-ID: <20240810032952.GB13701@ZenIV>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-17-viro@kernel.org>
 <CAEf4BzZipqBVhoY-S+WdeQ8=MhpKk-2dE_ESfGpV-VTm31oQUQ@mail.gmail.com>
 <20240807-fehlschlag-entfiel-f03a6df0e735@brauner>
 <CAEf4BzaeFTn41pP_hbcrCTKNZjwt3TPojv0_CYbP=+973YnWiA@mail.gmail.com>
 <CAADnVQKZW--EOkn5unFybxTKPNw-6rPB+=mY+cy_yUUsXe8R-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKZW--EOkn5unFybxTKPNw-6rPB+=mY+cy_yUUsXe8R-w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 08, 2024 at 09:51:34AM -0700, Alexei Starovoitov wrote:

> The bpf changes look ok and Andrii's approach is easier to grasp.
> It's better to route bpf conversion to CLASS(fd,..) via bpf-next,
> so it goes through bpf CI and our other testing.
> 
> bpf patches don't seem to depend on newly added CLASS(fd_pos, ...
> and fderr, so pretty much independent from other patches.

Representation change and switch to accessors do matter, though.
OTOH, I can put just those into never-rebased branch (basically,
"introduce fd_file(), convert all accessors to it" +
"struct fd representation change" + possibly "add struct fd constructors,
get rid of __to_fd()", for completeness sake), so you could pull it.
Otherwise you'll get textual conflicts on all those f.file vs. fd_file(f)...

