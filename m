Return-Path: <linux-fsdevel+bounces-71020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFB0CB09FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 17:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EBB23011308
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 16:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE090329E5E;
	Tue,  9 Dec 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJjOTpm2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB4A329E46;
	Tue,  9 Dec 2025 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765298998; cv=none; b=lZ4BBNVLDifDilqHXndjD1Pe9S272ScKFmIFQd1RD6w89Po3Pk8ss6G9bPEE1GDUiI2jomiFhwuy5nbWiFsj+yAbaGmL6l7L6KLIMp8BfWkc+nq92vwbFR9/E/wHel3rH2H5fgRsQAdnxowhgaD5onCKYgye4rRTqXE1rj+1hr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765298998; c=relaxed/simple;
	bh=Fi78wc/8rnoNlreCtprcXsR18cJ0DDoUyGSanGb1RRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpdJfdsKLpUhuXF+keunIcx261QutDTpkGTpxyqDy4ODARSzB8R3d5JK32vM+F2YwGXRhdTFGjS/XBSZ1DAl8arkj2tgDyytQo4nx0gZcaM+lhhks5qM6IPttGUldGF6ebJV84yI5lkE8y0pYD4m6nEOP5RJ/jFNa0SBCyl+QrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJjOTpm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8E4C4CEF5;
	Tue,  9 Dec 2025 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765298997;
	bh=Fi78wc/8rnoNlreCtprcXsR18cJ0DDoUyGSanGb1RRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJjOTpm2un+kyEU0/ywQtbHS8wwQye9QYslUGfHzpEghgFGb1qOs9CojnRpSrmnSV
	 ZKdjT74+9GHiUXpruZRNIUG9g/zbxlIYMAb3/utMhHV39M2zuNqTpvEfmNxm3C3q81
	 YVJ80JYsEcWa+y27dp+1JyF+ES01uHXTA27aHIrTHlvvz/ZR1/gy+ZY2oAIKm3RUuS
	 4uYLyek/yu0Dn+l0TnLkBXcRjFtd00r7yrcIZaeavLdqPgrvJ+5CYpmAm20+Da3goB
	 RqXSALzX97DUVkKLtiYlidha19mfi8u38DrGu0rQFAFZNUIcBr6aRiDQ8GArUKySrI
	 vUQSe71LrzXiQ==
Date: Tue, 9 Dec 2025 08:49:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tmpfs: enforce the immutable flag on open files
Message-ID: <20251209164956.GB89444@frogsfrogsfrogs>
References: <toyfbuhwbqa4zfgnojghr4v7k2ra6uh3g3sikbuwata3iozi3m@tarta.nabijaczleweli.xyz>
 <be986c18-3db2-38a1-8401-f0035ab71e7a@google.com>
 <mmfrclxjf2mmmohiwdbgqhyyrlab33tpnmtuzatk2xsuyiglrp@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mmfrclxjf2mmmohiwdbgqhyyrlab33tpnmtuzatk2xsuyiglrp@tarta.nabijaczleweli.xyz>

On Tue, Dec 09, 2025 at 03:00:35PM +0100, Ahelenia Ziemiańska wrote:
> On Mon, Dec 08, 2025 at 08:14:44PM -0800, Hugh Dickins wrote:
> > On Mon, 8 Dec 2025, Ahelenia Ziemiańska wrote:
> > > This useful behaviour is implemented for most filesystems,
> > > and wants to be implemented for every filesystem, quoth ref:
> > >   There is general agreement that we should standardize all file systems
> > >   to prevent modifications even for files that were opened at the time
> > >   the immutable flag is set.  Eventually, a change to enforce this at
> > >   the VFS layer should be landing in mainline.
> > > 
> > > References: commit 02b016ca7f99 ("ext4: enforce the immutable flag on
> > >  open files")
> > > Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> > Sorry: thanks, but no thanks.
> > 
> > Supporting page_mkwrite() comes at a cost (an additional fault on first
> > write to a folio in a shared mmap).  It's important for space allocation
> > (and more) in the case of persistent writeback filesystems, but unwelcome
> > overhead in the case of tmpfs (and ramfs and hugetlbfs - others?).
> 
> Yeah, from the way page_mkwrite() was implemented it looked like
> enough of a pessimisation to be significant, and with how common
> an operation this is, I kinda expected this result.
> 
> (I was also gonna post the same for ramfs,
>  but it doesn't support FS_IOC_SETFLAGS attributes at all.)
> 
> > tmpfs has always preferred not to support page_mkwrite(), and just fail
> > fstests generic/080: we shall not slow down to change that, without a
> > much stronger justification than "useful behaviour" which we've got
> > along well enough without.
> 
> How do we feel about just the VFS half of this,
> i.e. open(WR)/chattr +i/write() = -EPERM?
> That shouldn't have a performance impact.
> 
> (I'll admit that this is the behaviour I find to be useful,
>  and I was surprised that the ext4 implementation also made mappings
>  SIGBUS, but I implemented both out of an undue sense of completionism.)
> 
> > But it is interesting that tmpfs supports IMMUTABLE, and passes all
> > the chattr fstests, without this patch.  Perhaps you should be adding
> > a new fstest, for tmpfs to fail: I won't thank you for that, but it
> > would be a fair response!
> 
> I rather think having IMMUTABLE but not atomically perfusing it
> to file descriptions is worthy of a test failure.
> The mmap behaviour, not so much.

If tmpfs isn't going to implement the same FS_FLAG_IMMUTABLE behaviors
as all the other filesystems then you should remove support for setting
the flag at all and leave a comment that minimizing fault latencies was
more important to the maintainer, so that nobody gets any smart ideas
about adding it back in.  Better not to advertise support than to have
quirky sh*t all over the kernel.

--D

> > Hugh
> > 
> > > ---
> > > v1: https://lore.kernel.org/linux-fsdevel/znhu3eyffewvvhleewehuvod2wrf4tz6vxrouoakiarjtxt5uy@tarta.nabijaczleweli.xyz/t/#u
> > > 
> > > shmem_page_mkwrite()'s return 0; falls straight into do_page_mkwrite()'s
> > > 	if (unlikely(!(ret & VM_FAULT_LOCKED))) {
> > > 		folio_lock(folio);
> > > Given the unlikely, is it better to folio_lock(folio); return VM_FAULT_LOCKED; instead?
> > > 
> > > /ext4# uname -a
> > > Linux tarta 6.18.0-10912-g416f99c3b16f-dirty #1 SMP PREEMPT_DYNAMIC Sat Dec  6 12:14:41 CET 2025 x86_64 GNU/Linux
> > > /ext4# while sleep 1; do echo $$; done > file &
> > > [1] 262
> > > /ext4# chattr +i file
> > > /ext4# sh: line 25: echo: write error: Operation not permitted
> > > sh: line 25: echo: write error: Operation not permitted
> > > sh: line 25: echo: write error: Operation not permitted
> > > sh: line 25: echo: write error: Operation not permitted
> > > fg
> > > while sleep 1; do
> > >     echo $$;
> > > done > file
> > > ^C
> > > /ext4# mount -t tmpfs tmpfs /tmp
> > > /ext4# cd /tmp
> > > /tmp# while sleep 1; do echo $$; done > file &
> > > [1] 284
> > > /tmp# chattr +i file
> > > /tmp# sh: line 35: echo: write error: Operation not permitted
> > > sh: line 35: echo: write error: Operation not permitted
> > > sh: line 35: echo: write error: Operation not permitted
> > > 
> > > $ cat test.c
> > > #include <unistd.h>
> > > #include <fcntl.h>
> > > #include <sys/ioctl.h>
> > > #include <linux/fs.h>
> > > #include <sys/mman.h>
> > > int main(int, char **argv) {
> > > 	int fd = open(argv[1], O_RDWR | O_CREAT | O_TRUNC, 0666);
> > > 	ftruncate(fd, 1024 * 1024);
> > > 	char *addr = mmap(NULL, 1024 * 1024, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> > > 	addr[0] = 0x69;
> > > 	int attrs = FS_IMMUTABLE_FL;
> > > 	ioctl(3, FS_IOC_SETFLAGS, &attrs);
> > > 	addr[1024 * 1024 - 1] = 0x69;
> > > }
> > > 
> > > # strace ./test /tmp/file
> > > execve("./test", ["./test", "/tmp/file"], 0x7ffc720bead8 /* 22 vars */) = 0
> > > ...
> > > openat(AT_FDCWD, "/tmp/file", O_RDWR|O_CREAT|O_TRUNC, 0666) = 3
> > > ftruncate(3, 1048576)                   = 0
> > > mmap(NULL, 1048576, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x7f09bbf2a000
> > > ioctl(3, FS_IOC_SETFLAGS, [FS_IMMUTABLE_FL]) = 0
> > > --- SIGBUS {si_signo=SIGBUS, si_code=BUS_ADRERR, si_addr=0x7f09bc029fff} ---
> > > +++ killed by SIGBUS +++
> > > Bus error
> > > # tr -d \\0 < /tmp/file; echo
> > > i
> > > 
> > >  mm/shmem.c | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index d578d8e765d7..432935f79f35 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -1294,6 +1294,14 @@ static int shmem_setattr(struct mnt_idmap *idmap,
> > >  	bool update_mtime = false;
> > >  	bool update_ctime = true;
> > >  
> > > +	if (unlikely(IS_IMMUTABLE(inode)))
> > > +		return -EPERM;
> > > +
> > > +	if (unlikely(IS_APPEND(inode) &&
> > > +		     (attr->ia_valid & (ATTR_MODE | ATTR_UID |
> > > +					ATTR_GID | ATTR_TIMES_SET))))
> > > +		return -EPERM;
> > > +
> > >  	error = setattr_prepare(idmap, dentry, attr);
> > >  	if (error)
> > >  		return error;
> > > @@ -2763,6 +2771,17 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
> > >  	return ret;
> > >  }
> > >  
> > > +static vm_fault_t shmem_page_mkwrite(struct vm_fault *vmf)
> > > +{
> > > +	struct file *file = vmf->vma->vm_file;
> > > +
> > > +	if (unlikely(IS_IMMUTABLE(file_inode(file))))
> > > +		return VM_FAULT_SIGBUS;
> > > +
> > > +	file_update_time(file);
> > > +	return 0;
> > > +}
> > > +
> > >  unsigned long shmem_get_unmapped_area(struct file *file,
> > >  				      unsigned long uaddr, unsigned long len,
> > >  				      unsigned long pgoff, unsigned long flags)
> > > @@ -3475,6 +3494,10 @@ static ssize_t shmem_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > >  	ret = generic_write_checks(iocb, from);
> > >  	if (ret <= 0)
> > >  		goto unlock;
> > > +	if (unlikely(IS_IMMUTABLE(inode))) {
> > > +		ret = -EPERM;
> > > +		goto unlock;
> > > +	}
> > >  	ret = file_remove_privs(file);
> > >  	if (ret)
> > >  		goto unlock;
> > > @@ -5286,6 +5309,7 @@ static const struct super_operations shmem_ops = {
> > >  static const struct vm_operations_struct shmem_vm_ops = {
> > >  	.fault		= shmem_fault,
> > >  	.map_pages	= filemap_map_pages,
> > > +	.page_mkwrite	= shmem_page_mkwrite,
> > >  #ifdef CONFIG_NUMA
> > >  	.set_policy     = shmem_set_policy,
> > >  	.get_policy     = shmem_get_policy,
> > > @@ -5295,6 +5319,7 @@ static const struct vm_operations_struct shmem_vm_ops = {
> > >  static const struct vm_operations_struct shmem_anon_vm_ops = {
> > >  	.fault		= shmem_fault,
> > >  	.map_pages	= filemap_map_pages,
> > > +	.page_mkwrite	= shmem_page_mkwrite,
> > >  #ifdef CONFIG_NUMA
> > >  	.set_policy     = shmem_set_policy,
> > >  	.get_policy     = shmem_get_policy,
> > > -- 
> > > 2.39.5
> 



