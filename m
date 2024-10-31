Return-Path: <linux-fsdevel+bounces-33365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7929B825C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 19:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DDA5B21873
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541B81C9B79;
	Thu, 31 Oct 2024 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qv7OuOK7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E8F1BD000;
	Thu, 31 Oct 2024 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730398434; cv=none; b=m0ZuhdeEIQZQhmLxRsz22FmQ0FretvXdBb90snpwbU4DSZ++C3KlUa/U98FpvwketCKj5zXGNXE9PtU7JydXpeAcum2GLIUKjePwSphFji1EjO4JVPbiga82nLRajvLVgkG1ER6suFat/K0Q7zsK/PM4nxz2ckXLpHptiIgMHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730398434; c=relaxed/simple;
	bh=6TKrJg/emMufwx5afPy1lcRH0AYFrELgAHBnsPz+13k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYD3tSz6Z/DiYh6nMP3QTn0UJlNmugdDDIdubhGzuBP3GNuSNYRJnXY8gaSD7xcOIQ7hw7F+ne+f18kUT9kAQpRpFJdahr+RYp+llLlOFHlGHPJ5qk4kLRWYiRJukW7RVGu12xbRPwEh+h/AAidGiIaA0S0szgWGBL9LdRC6XP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qv7OuOK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1B2C4CECF;
	Thu, 31 Oct 2024 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730398434;
	bh=6TKrJg/emMufwx5afPy1lcRH0AYFrELgAHBnsPz+13k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qv7OuOK7dRxA2KAheVIq5dKvVqLqATTcGnmL/q7E2/YS5FUtuSiEMEkwKcM9efYKj
	 Tf0gnRnjBpXP9kIO3eoP/8buVf70rvZBbD7J+rHmsINEfZG25u3lz5UBMsI8QzhiTB
	 /iVU1Yq2CFuICoRJH4CxHZ4AN5VC2uCV4RzOiRa4UaeSIgulISwrbW3O0Wq8BnwFjO
	 7gM0vMwSuSJuyZg2yTNcpyBXwqgaM4exkA+VgFFWzBF1/q+xfki7jGZsi6TvMt47xm
	 J/8OVUwSOkrrH29RJJxCB3U7Wv06tEnVy9nNd/vmlCY1Vika9gQFK0TdJM6k/66LwN
	 DnqHjpblzXdoQ==
Date: Thu, 31 Oct 2024 11:13:51 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Gabriel Krisman Bertazi <krisman@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com,
	kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>, llvm@lists.linux.dev,
	linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 8/9] tmpfs: Expose filesystem features via sysfs
Message-ID: <20241031181351.GA1181429@thelio-3990X>
References: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
 <20241021-tonyk-tmpfs-v8-8-f443d5814194@igalia.com>
 <20241031051822.GA2947788@thelio-3990X>
 <c104f427-f9d9-498c-a719-ed6bf118226d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c104f427-f9d9-498c-a719-ed6bf118226d@igalia.com>

On Thu, Oct 31, 2024 at 02:31:21PM -0300, André Almeida wrote:
> Hi Nathan,
> 
> Em 31/10/2024 02:18, Nathan Chancellor escreveu:
> > Hi André,
> > 
> > On Mon, Oct 21, 2024 at 01:37:24PM -0300, André Almeida wrote:
> > > Expose filesystem features through sysfs, so userspace can query if
> > > tmpfs support casefold.
> > > 
> > > This follows the same setup as defined by ext4 and f2fs to expose
> > > casefold support to userspace.
> > > 
> > > Signed-off-by: André Almeida <andrealmeid@igalia.com>
> > > Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
> > > ---
> > >   mm/shmem.c | 37 +++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 37 insertions(+)
> > > 
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index ea01628e443423d82d44277e085b867ab9bf4b28..0739143d1419c732359d3a3c3457c3acb90c5b22 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -5546,3 +5546,40 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
> > >   	return page;
> > >   }
> > >   EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);
> > > +
> > > +#if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
> > > +#if IS_ENABLED(CONFIG_UNICODE)
> > > +static DEVICE_STRING_ATTR_RO(casefold, 0444, "supported");
> > > +#endif
> > > +
> > > +static struct attribute *tmpfs_attributes[] = {
> > > +#if IS_ENABLED(CONFIG_UNICODE)
> > > +	&dev_attr_casefold.attr.attr,
> > > +#endif
> > > +	NULL
> > > +};
> > > +
> > > +static const struct attribute_group tmpfs_attribute_group = {
> > > +	.attrs = tmpfs_attributes,
> > > +	.name = "features"
> > > +};
> > > +
> > > +static struct kobject *tmpfs_kobj;
> > > +
> > > +static int __init tmpfs_sysfs_init(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	tmpfs_kobj = kobject_create_and_add("tmpfs", fs_kobj);
> > > +	if (!tmpfs_kobj)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = sysfs_create_group(tmpfs_kobj, &tmpfs_attribute_group);
> > > +	if (ret)
> > > +		kobject_put(tmpfs_kobj);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +fs_initcall(tmpfs_sysfs_init);
> > > +#endif /* CONFIG_SYSFS && CONFIG_TMPFS */
> > > 
> > > -- 
> > > 2.47.0
> > > 
> > 
> > This change as commit 5132f08bd332 ("tmpfs: Expose filesystem features
> > via sysfs") in -next introduces a kCFI violation when accessing
> > /sys/fs/tmpfs/features/casefold. An attribute group created with
> > sysfs_create_group() has ->sysfs_ops() set to kobj_sysfs_ops, which has
> > a ->show() value of kobj_attr_show(). When kobj_attr_show() goes to call
> > the attribute's ->show() value after container_of(), there will be a
> > type mismatch in the case of the casefold attr, as it was defined with a
> > ->show() value of device_show_string() but that does not match the type
> > of ->show() in 'struct kobj_attribute'.
> > 
> > I can easily reproduce this with the following commands:
> > 
> >    $ printf 'CONFIG_%s=y\n' CFI_CLANG UNICODE >kernel/configs/repro.config
> > 
> >    $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 mrproper virtconfig repro.config Image.gz
> >    ...
> > 
> >    $ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/arm64-rootfs.cpio.zst | zstd -d >rootfs.cpio
> > 
> >    $ qemu-system-aarch64 \
> >        -display none \
> >        -nodefaults \
> >        -cpu max,pauth-impdef=true \
> >        -machine virt,gic-version=max,virtualization=true \
> >        -append 'console=ttyAMA0 earlycon rdinit=/bin/sh' \
> >        -kernel arch/arm64/boot/Image.gz \
> >        -initrd rootfs.cpio \
> >        -m 512m \
> >        -serial mon:stdio
> >    ...
> >    # mount -t sysfs sys /sys
> >    # cat /sys/fs/tmpfs/features/casefold
> >    [   70.558496] CFI failure at kobj_attr_show+0x2c/0x4c (target: device_show_string+0x0/0x38; expected type: 0xc527b809)
> >    [   70.560018] Internal error: Oops - CFI: 00000000f2008228 [#1] PREEMPT SMP
> >    [   70.560647] Modules linked in:
> >    [   70.561770] CPU: 0 UID: 0 PID: 46 Comm: cat Not tainted 6.12.0-rc4-00008-g5132f08bd332 #1
> >    [   70.562429] Hardware name: linux,dummy-virt (DT)
> >    [   70.562897] pstate: 21402009 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> >    [   70.563377] pc : kobj_attr_show+0x2c/0x4c
> >    [   70.563674] lr : sysfs_kf_seq_show+0xb4/0x130
> >    [   70.563987] sp : ffff80008043bac0
> >    [   70.564236] x29: ffff80008043bac0 x28: 000000007ffff001 x27: 0000000000000000
> >    [   70.564877] x26: 0000000001000000 x25: 000000007ffff001 x24: 0000000000000001
> >    [   70.565339] x23: fff000000238a000 x22: ffff9fa31a3996f8 x21: fff00000023fc000
> >    [   70.565806] x20: fff000000201df80 x19: fff000000238b000 x18: 0000000000000000
> >    [   70.566273] x17: 00000000c527b809 x16: 00000000df43c25c x15: fff000001fef8200
> >    [   70.566727] x14: 0000000000000000 x13: fff00000022450f0 x12: 0000000000001000
> >    [   70.567177] x11: fff00000023fc000 x10: 0000000000000000 x9 : ffff9fa31a18fac4
> >    [   70.567682] x8 : ffff9fa319badde4 x7 : 0000000000000000 x6 : 000000000000003f
> >    [   70.568138] x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000004
> >    [   70.568585] x2 : fff00000023fc000 x1 : ffff9fa31a881f90 x0 : fff000000201df80
> >    [   70.569169] Call trace:
> >    [   70.569389]  kobj_attr_show+0x2c/0x4c
> >    [   70.569706]  sysfs_kf_seq_show+0xb4/0x130
> >    [   70.570020]  kernfs_seq_show+0x44/0x54
> >    [   70.570280]  seq_read_iter+0x14c/0x4b0
> >    [   70.570543]  kernfs_fop_read_iter+0x60/0x198
> >    [   70.570820]  copy_splice_read+0x1f0/0x2f4
> >    [   70.571092]  splice_direct_to_actor+0xf4/0x2e0
> >    [   70.571376]  do_splice_direct+0x68/0xb8
> >    [   70.571626]  do_sendfile+0x1e8/0x488
> >    [   70.571874]  __arm64_sys_sendfile64+0xe0/0x12c
> >    [   70.572161]  invoke_syscall+0x58/0x114
> >    [   70.572424]  el0_svc_common+0xa8/0xdc
> >    [   70.572676]  do_el0_svc+0x1c/0x28
> >    [   70.572910]  el0_svc+0x38/0x68
> >    [   70.573132]  el0t_64_sync_handler+0x90/0xfc
> >    [   70.573394]  el0t_64_sync+0x190/0x19
> >    [   70.574001] Code: 72970131 72b8a4f1 6b11021f 54000040 (d4304500)
> >    [   70.574635] ---[ end trace 0000000000000000 ]---
> > 
> > I am not sure if there is a better API exists or if a local copy should
> > be rolled but I think the current scheme is definitely wrong because
> > there is no 'struct device' here.
> > 
> 
> Thank you for the report, I'm trying to fix it, it seems I have used
> something for device drivers in a filesystem. I wonder how btrfs doesn't get
> this error, since tmpfs_sysfs_init() is very similar to btrfs_init_sysfs().

Upon a quick glance, it looks like all of the btrfs sysfs functions
properly match the ->show() and ->store() type in kobj_attribute, so
there is no type mismatch when they are called indirectly.

Cheers,
Nathan

