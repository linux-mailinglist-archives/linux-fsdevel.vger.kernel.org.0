Return-Path: <linux-fsdevel+bounces-20860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B838D8AAC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 22:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993781C220A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 20:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF8213B5AF;
	Mon,  3 Jun 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MEVnxCmn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFB136E17;
	Mon,  3 Jun 2024 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444829; cv=none; b=G/1su7ux7WsFgq5NYp9+o6mmRm9kK+wYxTbXF17peHglJGEvCNqo5PeD8lUv1E6Ucxz5epRNBQVF6Si1nAKfW/dGnM5U7j3EtB9glh7/WxyDZSChZrsuPWKiw+lgBtJaa7r3gw6uA6zfAINjyZ0JTJJEgiwICFLdZ8uvGDCOWxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444829; c=relaxed/simple;
	bh=LvfYWC9ai0O4h/qMhZHU4BhEwmCWRQGAkgn1fVm/API=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoqK9lptIwbWJVl+jWhomRg5cfwOq88/vMtMgF1irJHNs/9XUU48rzUFL5rQbX2ifN08pI/+SJWuIJXFV8z53v9Uc4v/fFMZC0F0kHdobLSNUmUtDiMJ63lBZ1PCZQEmSCmZhaUKAhkg6MiZo7sMwxrDFehxZLtv77G+l0dFDnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MEVnxCmn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LP1zmN7gh+LnGD4nFAKmEqqZF8DCbsNy58ickS09QtQ=; b=MEVnxCmnaED6bwuUtUSMUo/k1Z
	Bwhuc3hPg6PiiG6MBE7w50UfPvmxUc7wuWRMaUDZSYSZ0vZj5l3sn2m/ZoeLuVwOUbwaUUXFvrcS2
	Ksy+ybRgsYv0/LNDLsMpRnvUc112tCc4YCsVJ6oI2SjW2+OaOS82R0EpgeyDP7dPQ4TOQEhaJQblT
	zr03y1UfvX8lrkWOIWURBm28KY1X2W89rfJMR4iOG0Ml4T8G2FTF8LmkaWHVHZ3LxL+0J/nGWjXLx
	1WjpVdGRv1z7ddD0LO2TnleNBLbLSlBKbKLfBPHSvrRujzAcRXiGq7OPFHCm/gn/JdG6wfinjND+t
	SRLZm4Dw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sEDqx-00Chme-38;
	Mon, 03 Jun 2024 20:00:24 +0000
Date: Mon, 3 Jun 2024 21:00:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC] misuse of descriptor tables in HID-BPF
Message-ID: <20240603200023.GN1629371@ZenIV>
References: <20240602234048.GF1629371@ZenIV>
 <xghiytd7462sujj5lw65jcrc3c5yoq35cstumkk7tvq2a5wl7y@3c2ori7znd62>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xghiytd7462sujj5lw65jcrc3c5yoq35cstumkk7tvq2a5wl7y@3c2ori7znd62>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 03, 2024 at 04:46:31PM +0200, Benjamin Tissoires wrote:

> > Kernel-side descriptors should be used only for marshalling - they can
> > be passed by userland (and should be resolved to struct file *, with
> > no expectations that repeated call of fget() would yield the same
> > pointer) and they can be returned _to_ userland - after you've allocated
> > them and associated them with struct file *.
> 
> I think the situation is not as bad as you think it is.
> First these fds are not actually struct file * but bpf objects. So the
> users of them should be rather small. Threading in this case is probably
> fine because this only happens under a mutex lock.

First of all, _any_ of those is actually a struct file * - it's just that
initially you have a reference to opened bpffs file there.  As soon
as it's in the table, it can be replaced with _any_ reference to opened
file.  And no, your mutex doesn't matter here - dup2() neither knows
nor cares about it.  And that's all you need to replace a descriptor table
entry - dup2() from another thread that happens to share descriptor table
with the one you are currently running in.

> And last, and I think that's the biggest point here, we are not really
> "in the kernel". The code is executed in the kernel, but it's coming
> from a syscall bpf program, and as such we are in a blurry state between
> userspace and kernel space.

In context of which thread is it executed?  IOW, what does current point
to when your code runs?

> Then, the bpf API uses fds because we are
> effectively going through the userspace API from within the kernel to
> populate the maps. At any point here we don't assume the fd is safe.
> Whenever the call to skel_map_update_elem() is done, the kernel emits
> an equivalent of a syscall to this kernel function, and as such the
> actual kernel code behind it treats everything like a kernel code should.

It's not about the isolated accesses of descriptor table being unsafe;
it's about the assumption that references you've put into descriptor
table will not be replaced by another thread, both sides using perfectly
sound operations for each access.

Again, descriptor table should be treated as a shared data structure.
There are some exceptions (e.g. in execve() past the point of no return,
after it has explicitly unshared the descriptor table), but none of those
applies in your case.

There's no such thing as "lock descriptor table against modifications"
available outside of fs/file.c; moreover, the thing used inside fs/file.c
to protect individual table modifications is a spinlock and it really
can't be held over blocking operations.

So the descriptor table itself will be fine, but the references you store
in there might be replaced at any point.

> Efectively, this use of fds is to pass information from/to userland :)

"Here's a new descriptor, feel free to do IO on it" is fine - if another
thread starts playing silly buggers with descriptor table (e.g. closes
that descriptor behind the first thread's back), it's a userland bug
and the kernel is fine.  Two threads sharing descriptor table are likely
to share memory as well, so they can step on each others' toes in a lot
of other ways.  Your situation is different - you have kernel-side code
putting stuff into descriptor table and expecting the same thing to be
found at the same place later on.  _That_ is a trouble waiting to happen.

> But I agree, the whole logic of this file is weird, and not clean.
> 
> Luckily, with the help of the bpf folks, I came to a better solution,
> with bpf_struct_ops[0].

Hadn't looked at it yet...

