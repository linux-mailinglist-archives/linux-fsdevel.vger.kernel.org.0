Return-Path: <linux-fsdevel+bounces-20845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0978D8566
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 16:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D56B22A87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3785712FB09;
	Mon,  3 Jun 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH+jBWqR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510226AD5;
	Mon,  3 Jun 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425995; cv=none; b=A25MAXrOCRuC5fo13kzjynsDI9Jb83rQOQMRhEyjakp2Amk4ru43FbFXMyRSdd/wf9zPab0hbPu7xBc3PtMU/xh7Q3ycf6+lYNE6w5O84dj9MeA36tLeCXVH+BkjqTdC0fEYMtsaps7EJqFX7Hr/0X+B2JWCvQSuh82eo6HogMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425995; c=relaxed/simple;
	bh=ANoxgMGV23DkMPB+4QIDz19SbnyYNPj5Qnure/xMmD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pm3aAFiNg7TGl4CzMpQ7c4KOZvr9P8Na6N6XwfMIb6vCXq7whn9YjZvYZOAS+EPpOe+ZoKHyn0YmqqhqjVX9ShETwfFv9jyVUcfGsg64guI52ZAXvxRf6CtcrI/7laI/gaXKCHAOrwCFhUODOdxZo9RJ0N7paP8DteSKt6haI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH+jBWqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B773C2BD10;
	Mon,  3 Jun 2024 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717425995;
	bh=ANoxgMGV23DkMPB+4QIDz19SbnyYNPj5Qnure/xMmD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QH+jBWqRfXKPzVvMLrt/S0t+n4P8iWA2G++uF/Dish3I5Q7/sjB9D5UVTlnJNFW/H
	 37tdH0Qh9/9Ec+8CLlfHOIyYH0YlHVWcvjdK9cROxShqg2+cOEWqETrOpWjMf3iv/L
	 oeTUWg+SggFpClTaREfm3SidfDa2aF8X1TrPqc/H9UwnDTwOHS8Ck4PDquOyp2R+7g
	 eTErNUnwUU8wI4NVH12/2GAXCfHT6g9R037RR1xiR9Pyj/V2BNcxW1pzvV6z8jMIEY
	 rKnHffMDr9enMwzNcl814qV+tulBnhkzu5Zf/GONt3wBp3aoB9FWoQsgqwW9MA3u4A
	 +5S9Up44+S2DA==
Date: Mon, 3 Jun 2024 16:46:31 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC] misuse of descriptor tables in HID-BPF
Message-ID: <xghiytd7462sujj5lw65jcrc3c5yoq35cstumkk7tvq2a5wl7y@3c2ori7znd62>
References: <20240602234048.GF1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602234048.GF1629371@ZenIV>

Hi Al,

On Jun 03 2024, Al Viro wrote:
> static int hid_bpf_insert_prog(int prog_fd, struct bpf_prog *prog)
> {
>         int i, index = -1, map_fd = -1, err = -EINVAL;
> 
>         /* retrieve a fd of our prog_array map in BPF */
>         map_fd = skel_map_get_fd_by_id(jmp_table.map->id);
> 
> 	...
> 
>         /* insert the program in the jump table */
>         err = skel_map_update_elem(map_fd, &index, &prog_fd, 0);
>         if (err)
>                 goto out;
> 
> 	...
> 
>         if (err < 0)
>                 __hid_bpf_do_release_prog(map_fd, index);
>         if (map_fd >= 0)
>                 close_fd(map_fd);
>         return err;
> }
> 
> What.  The.  Hell?

TL;DR: I'm getting rid of that code in (hopefully v6.11), so any bad
justification I can come up with can safely be ignored.

> 
> Folks, descriptor table is a shared object.  It is NOT safe to use
> as a scratchpad.
> 
> Another thread might do whatever it bloody wants to anything inserted
> there.  It may close your descriptor, it may replace it with something
> entirely unrelated to what you've placed there, etc.
> 
> This is fundamentally broken.  The same goes for anything that tries
> to play similar games.  Don't use descriptor tables that way.
> 
> Kernel-side descriptors should be used only for marshalling - they can
> be passed by userland (and should be resolved to struct file *, with
> no expectations that repeated call of fget() would yield the same
> pointer) and they can be returned _to_ userland - after you've allocated
> them and associated them with struct file *.

I think the situation is not as bad as you think it is.
First these fds are not actually struct file * but bpf objects. So the
users of them should be rather small. Threading in this case is probably
fine because this only happens under a mutex lock.

And last, and I think that's the biggest point here, we are not really
"in the kernel". The code is executed in the kernel, but it's coming
from a syscall bpf program, and as such we are in a blurry state between
userspace and kernel space. Then, the bpf API uses fds because we are
effectively going through the userspace API from within the kernel to
populate the maps. At any point here we don't assume the fd is safe.
Whenever the call to skel_map_update_elem() is done, the kernel emits
an equivalent of a syscall to this kernel function, and as such the
actual kernel code behind it treats everything like a kernel code should.

Efectively, this use of fds is to pass information from/to userland :)

But I agree, the whole logic of this file is weird, and not clean.

Luckily, with the help of the bpf folks, I came to a better solution,
with bpf_struct_ops[0].

> 
> Using them as handles for internal objects is an equivalent of playing
> in the traffic - think of it as evolution in action.

Which now raises the question: should I ask for the bpf_struct_ops
conversion to be backported in stable, because that code is too ugly?

Cheers,
Benjamin

[0] https://lore.kernel.org/bpf/20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org/

