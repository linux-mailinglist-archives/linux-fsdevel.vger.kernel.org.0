Return-Path: <linux-fsdevel+bounces-21044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AD98FD0D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F55291680
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FC920B20;
	Wed,  5 Jun 2024 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D87jHcoH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB051B963;
	Wed,  5 Jun 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597808; cv=none; b=tWNbMXjuTFHuy7QtbrHeG4YILyeGYXBBbE3vnKIwCvKyd7QdRxe9xH+8y9eVb/YTZdOqVQLJTJuvMhrG3IZc1vVu0rHvCcijwIBUk0r4oUvHx4MgmOohqhCr8PN3pR+ojV3nmDa5J8lTo/F5y446Zl3QzaeJ5Fw34Nb5WyPj6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597808; c=relaxed/simple;
	bh=xMHNeMXIdUWxCoeMH+9vlh/oDcMEA1gG0Olc8jiNjes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4FGFeUYNGdKhQM5X3fmSzbqEPebwgqBF06sPiZOX+vcmeM59imd5kRc/lYDYfzE3dfiixGbAv4bep9VwwwU9FcwXNIJlQFANs/mYEY4uuuyolrQDmbAHjKnGqJhoy+eMifzUnZcqnOcYFl+5Inh7KVdw22aSwD0bau4HpAXk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D87jHcoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9E2C2BD11;
	Wed,  5 Jun 2024 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717597807;
	bh=xMHNeMXIdUWxCoeMH+9vlh/oDcMEA1gG0Olc8jiNjes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D87jHcoH6Bnda/5BbHhhsdPVqnWolLYDsX5vr/w1CS92YEUz6g7QM/v0LTkwAMQv9
	 s32J31Z9+l1VlWNbimcGQP3wpLulUp4/orjAmc9H+6t7iNjw1X459SZ5aU6zAWU5TX
	 naFcQfqsCpMjbfO/OhmK1VOyjKXS7UWU63D4Nx+EthmmGTc2m3hecqn0W8EZpg+IqB
	 IgApoH5VvMsXHTPc8G66Mn+cKKfmWEVzoozdG7Ph2aQGRCBcScvsdHkkMD7DUdppQQ
	 P7d9kKS3TbcfmbG2txjVB6q0tBxhmta0VUpDmBdfGqQS/SolfQEvyPhUVU9eP5usl1
	 zQb5aQXRaJvhA==
Date: Wed, 5 Jun 2024 16:30:03 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC] misuse of descriptor tables in HID-BPF
Message-ID: <43tu4jun5r6bvdz57lnwzhefpkrx5ayrfkpv7n57i3iqif4t2g@pkn4zv3pqk3k>
References: <20240602234048.GF1629371@ZenIV>
 <xghiytd7462sujj5lw65jcrc3c5yoq35cstumkk7tvq2a5wl7y@3c2ori7znd62>
 <20240603200023.GN1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603200023.GN1629371@ZenIV>

On Jun 03 2024, Al Viro wrote:
> On Mon, Jun 03, 2024 at 04:46:31PM +0200, Benjamin Tissoires wrote:
> 
> > > Kernel-side descriptors should be used only for marshalling - they can
> > > be passed by userland (and should be resolved to struct file *, with
> > > no expectations that repeated call of fget() would yield the same
> > > pointer) and they can be returned _to_ userland - after you've allocated
> > > them and associated them with struct file *.
> > 
> > I think the situation is not as bad as you think it is.
> > First these fds are not actually struct file * but bpf objects. So the
> > users of them should be rather small. Threading in this case is probably
> > fine because this only happens under a mutex lock.
> 
> First of all, _any_ of those is actually a struct file * - it's just that
> initially you have a reference to opened bpffs file there.  As soon
> as it's in the table, it can be replaced with _any_ reference to opened
> file.  And no, your mutex doesn't matter here - dup2() neither knows
> nor cares about it.  And that's all you need to replace a descriptor table
> entry - dup2() from another thread that happens to share descriptor table
> with the one you are currently running in.

I think I'm still confused by what you said. Are you talking about
map_fd or prog_fd in the code extract you took (or both)?

FWIW, this part of the code will get removed entirely with struct_ops,
so a "not enough time to explain to an idiot person" is a perfectly fine
answer :)

map_fd is a fd to a map in a bpf preloaded by the kernel at boot time.
The kernel keeps a reference of it, and won't release it, thus my mutex,
which prevents the map to be removed while hid_bpf_attach(), is called.
Yes it won't prevent dup2(), but at least that ensures that struct
bpf_map * is safe.

prog_fd is coming from userspace, and we are in a bpf syscall here.
So if userspace wants to shoot itself in the foot, that's fine, but once
we re-enter the kernel (skel_map_update_elem()), bpf-core ensures that
prog_fd is actually pointing to a bpf object (or a struct file* pointing
at a bpf object).

Nowhere we are dealing with bpffs here. The bpf_prog is not pinned in
the bpffs. But maybe you are talking about the internal mapping bpf<->fd
that bpf-core does:
When skel_map_get_fd_by_id() is called, we effectively call
kern_sys_bpf(BPF_MAP_GET_FD_BY_ID), which goes through the same checks
than the syscall __NR_BPF. Then internally, this translates to
anon_inode_getfd().

Now, regarding dup2(): if between skel_map_get_fd_by_id() and close_fd(map_fd);
userspace calls dup2() to replace the the internal fd of the map by
another opened file, both calls to skel_map_update_elem() and
__hid_bpf_do_release_prog() are safe because they do the translation
into struct bpf_map* and check that they are dealing with a bpf_map.

If dup2() happens between skel_map_update_elem() and
__hid_bpf_do_release_prog(), that's fine too: there is an error, so the
index will eventually get reused, and the struct bpf_prog will
eventually be released. But it will never be used because the error is
known to hid_bpf_jmp_table.c.

So efectively dup2() is a userspace bug because all what happens is that you
will get an error and nothing will happen in the kernel (bonus point:
your newly reassigned fd will be closed).

> 
> > And last, and I think that's the biggest point here, we are not really
> > "in the kernel". The code is executed in the kernel, but it's coming
> > from a syscall bpf program, and as such we are in a blurry state between
> > userspace and kernel space.
> 
> In context of which thread is it executed?  IOW, what does current point
> to when your code runs?

As I understand it, current will point to the thread context of the caller.
The various fds I can retrieve here are the exact same numbers from
userspace or in the bpf syscall. I'm not sure I can do a simple printk()
on current, but if you have a simple pseudo code extract for me to get the
information you need I can probably run it.

> 
> > Then, the bpf API uses fds because we are
> > effectively going through the userspace API from within the kernel to
> > populate the maps. At any point here we don't assume the fd is safe.
> > Whenever the call to skel_map_update_elem() is done, the kernel emits
> > an equivalent of a syscall to this kernel function, and as such the
> > actual kernel code behind it treats everything like a kernel code should.
> 
> It's not about the isolated accesses of descriptor table being unsafe;
> it's about the assumption that references you've put into descriptor
> table will not be replaced by another thread, both sides using perfectly
> sound operations for each access.
> 
> Again, descriptor table should be treated as a shared data structure.
> There are some exceptions (e.g. in execve() past the point of no return,
> after it has explicitly unshared the descriptor table), but none of those
> applies in your case.
> 
> There's no such thing as "lock descriptor table against modifications"
> available outside of fs/file.c; moreover, the thing used inside fs/file.c
> to protect individual table modifications is a spinlock and it really
> can't be held over blocking operations.
> 
> So the descriptor table itself will be fine, but the references you store
> in there might be replaced at any point.

Again I don't disagree with you on the general usage, but I don't see
how I am going against.

I am not storing any fd anywhere. I call a UAPI indirect call from the
kernel which will again do a translation fd->bpf_map and fd->bpf_prog
into this bpf_map, with all of the checks that are required to see if
the pointer obtained from the fd is of the correct type.

Everything that stays and is stored in the kernel is the actual struct
bpf_prog* or struct bpf_map*, with refcounting done properly (AFAICT for
the refcounting).

> 
> > Efectively, this use of fds is to pass information from/to userland :)
> 
> "Here's a new descriptor, feel free to do IO on it" is fine - if another
> thread starts playing silly buggers with descriptor table (e.g. closes
> that descriptor behind the first thread's back), it's a userland bug
> and the kernel is fine.  Two threads sharing descriptor table are likely
> to share memory as well, so they can step on each others' toes in a lot
> of other ways.  Your situation is different - you have kernel-side code
> putting stuff into descriptor table and expecting the same thing to be
> found at the same place later on.  _That_ is a trouble waiting to happen.

If the descriptor is changed during that syscall operation because of dup2(),
it's fine because it's never stored as it is, and skel_map_update_elem() or
__hid_bpf_do_release_prog() will convert the descriptors into kernel
struct and will reject wrong types.

And if the problem is because I call skel_map_get_fd_by_id() and then
close_fd() at the end, I don't see the problem because that fd is never
shared with userspace.

> 
> > But I agree, the whole logic of this file is weird, and not clean.
> > 
> > Luckily, with the help of the bpf folks, I came to a better solution,
> > with bpf_struct_ops[0].
> 
> Hadn't looked at it yet...

From a fd point of view, this is much simpler (or it is punted to
bpf-core): there are none :)

So no need to review it if you don't have time, I'm basically entirely
rewriting this code, removing all of those maps and indirections, by
just keeping a list of proper refcounted kernel struct bpf_struct_ops *.

Cheers,
Benjamin

