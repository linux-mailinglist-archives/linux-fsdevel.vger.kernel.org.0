Return-Path: <linux-fsdevel+bounces-36910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A669EAE06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 11:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE9A168332
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 10:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799A019C54A;
	Tue, 10 Dec 2024 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw92oLA8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD323DE8F;
	Tue, 10 Dec 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826851; cv=none; b=I8Ev4Ye0AiUQWTUYTp5GeJ1B/9pc+7NIm+KpWMiRnXKzMaP0dg2ZDMpkzwPtiAOWcJ6DBUyXohoOWIXRAroSqJ0FiqFr7PrZq8ntG9BaNgckQKtKb4Maz+j44gcb1Zwm+nC6q19ghLtsgns3UpesDiFEfEgc99MQIB6UkXDnDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826851; c=relaxed/simple;
	bh=shJZaFw/E0/b3YLMgrlFnAU3HSKm4vC7XBp0UA4tPEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCdF7NwuvHw0u/6TXBkNvQp0BV5RZmQsd2IA0+xKxE0qST0m2nyH9Tr+EyzdDTyIeizSN341pGV/WO1jgv4pwX946iiiZkZg/wrsJVf5wZPdi9TqYaJZ/yFkrFaI4GJgPUpRFKqBlJv4wdi7By04uWI2mzvpIbjy50Uhs88BMxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw92oLA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFA8C4CED6;
	Tue, 10 Dec 2024 10:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733826851;
	bh=shJZaFw/E0/b3YLMgrlFnAU3HSKm4vC7XBp0UA4tPEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mw92oLA8HwtU9GlwbINp+ydZIOEulhYmdPyRiNXcMteX+h/0R8IayLpa2bnM8GOBU
	 YwA4mdI0VZXHoND2peuPphuoFeOjahRjGtyDhb2AsW2BSad83SuBcciqBYMxDxrVBc
	 Cxp83z/RKgtRExOycjCLMype2dDAIBOhmBndl4VrrGmpANXCMCdYznIZSGA1Vda8vP
	 HgXfcddmlVyna7U1aIT60kmyPd87CKSlltH/PqHMFA8bK5qAhc0IUv8BwtWwyRvfZM
	 N7dG6NXXHQKmmkhRYbS366bw8/d0Zf370ftaREaR1FveOXd55ut55qihuNvhGv9YJV
	 FqbkhXe13NcOQ==
Date: Tue, 10 Dec 2024 11:34:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Erin Shepherd <erin.shepherd@e43.eu>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stable <stable@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export
 operations as only supporting file handles
Message-ID: <20241210-holunder-caravan-578662919f10@brauner>
References: <20241206160358.GC7820@frogsfrogsfrogs>
 <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
 <Z1ahFxFtksuThilS@infradead.org>
 <CAOQ4uxiEnEC87pVBhfNcjduHOZWfbEoB8HKVbjNHtkaWA5d-JA@mail.gmail.com>
 <Z1b00KG2O6YMuh_r@infradead.org>
 <CAOQ4uxjcVuq+PCoMos5Vi=t_S1OgJEM5wQ6Za2Ue9_FOq31m9Q@mail.gmail.com>
 <15628525-629f-49a4-a821-92092e2fa8cb@oracle.com>
 <d74572123acf8e09174a29897c3074f5d46e4ede.camel@kernel.org>
 <337ca572-2bfb-4bb5-b71c-daf7ac5e9d56@oracle.com>
 <20241210-gekonnt-pigmente-6d44d768469f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241210-gekonnt-pigmente-6d44d768469f@brauner>

On Tue, Dec 10, 2024 at 11:13:16AM +0100, Christian Brauner wrote:
> On Mon, Dec 09, 2024 at 12:20:10PM -0500, Chuck Lever wrote:
> > On 12/9/24 12:15 PM, Jeff Layton wrote:
> > > On Mon, 2024-12-09 at 11:35 -0500, Chuck Lever wrote:
> > > > On 12/9/24 11:30 AM, Amir Goldstein wrote:
> > > > > On Mon, Dec 9, 2024 at 2:46 PM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > > 
> > > > > > On Mon, Dec 09, 2024 at 09:58:58AM +0100, Amir Goldstein wrote:
> > > > > > > To be clear, exporting pidfs or internal shmem via an anonymous fd is
> > > > > > > probably not possible with existing userspace tools, but with all the new
> > > > > > > mount_fd and magic link apis, I can never be sure what can be made possible
> > > > > > > to achieve when the user holds an anonymous fd.
> > > > > > > 
> > > > > > > The thinking behind adding the EXPORT_OP_LOCAL_FILE_HANDLE flag
> > > > > > > was that when kernfs/cgroups was added exportfs support with commit
> > > > > > > aa8188253474 ("kernfs: add exportfs operations"), there was no intention
> > > > > > > to export cgroupfs over nfs, only local to uses, but that was never enforced,
> > > > > > > so we thought it would be good to add this restriction and backport it to
> > > > > > > stable kernels.
> > > > > > 
> > > > > > Can you please explain what the problem with exporting these file
> > > > > > systems over NFS is?  Yes, it's not going to be very useful.  But what
> > > > > > is actually problematic about it?  Any why is it not problematic with
> > > > > > a userland nfs server?  We really need to settle that argumet before
> > > > > > deciding a flag name or polarity.
> > > > > > 
> > > > > 
> > > > > I agree that it is not the end of the world and users do have to explicitly
> > > > > use fsid= argument to be able to export cgroupfs via nfsd.
> > > > > 
> > > > > The idea for this patch started from the claim that Jeff wrote that cgroups
> > > > > is not allowed for nfsd export, but I couldn't find where it is not allowed.
> > > > > 
> > > 
> > > I think that must have been a wrong assumption on my part. I don't see
> > > anything that specifically prevents that either. If cgroupfs is mounted
> > > and you tell mountd to export it, I don't see what would prevent that.
> > > 
> > > To be clear, I don't see how you would trick bog-standard mountd into
> > > exporting a filesystem that isn't mounted into its namespace, however.
> > > Writing a replacement for mountd is always a possibilty.
> > > 
> > > > > I have no issue personally with leaving cgroupfs exportable via nfsd
> > > > > and changing restricting only SB_NOUSER and SB_KERNMOUNT fs.
> > > > > 
> > > > > Jeff, Chuck, what is your opinion w.r.t exportability of cgroupfs via nfsd?
> > > > 
> > > > We all seem to be hard-pressed to find a usage scenario where exporting
> > > > pseudo-filesystems via NFS is valuable. But maybe someone has done it
> > > > and has a good reason for it.
> > > > 
> > > > The issue is whether such export should be consistently and actively
> > > > prevented.
> > > > 
> > > > I'm not aware of any specific security issues with it.
> > > > 
> > > > 
> > > 
> > > I'm not either, but we are in new territory here. nfsd is a network
> > > service, so it does present more of an attack surface vs. local access.
> > > 
> > > In general, you do have to take active steps to export a filesystem,
> > > but if someone exports / with "crossmnt", everything mounted is
> > > potentially accessible. That's obviously a dumb thing to do, but people
> > > make mistakes, and it's possible that doing this could be part of a
> > > wider exploit.
> > > 
> > > I tend to think it safest to make exporting via nfsd an opt-in thing on
> > > a per-fs basis (along the lines of this patchset). If someone wants to
> > > allow access to more "exotic" filesystems, let them argue their use-
> > > case on the list first.
> > 
> > If we were starting from scratch, 100% agree.
> > 
> > The current situation is that these file systems appear to be exportable
> > (and not only via NFS). The proposal is that this facility is to be
> > taken away. This can easily turn into a behavior regression for someone
> > if we're not careful.
> 
> So I'm happy to drop the exportfs preliminary we have now preventing
> kernfs from being exported but then Christoph and you should figure out
> what the security implications of allowing kernfs instances to be
> exported areare because I'm not an NFS export expert.
> 
> Filesystems that fall under kernfs that are exportable by NFS as I
> currently understand it are at least:
> 
> (1) sysfs
> (2) cgroupfs
> 
> Has anyone ever actually tried to export the two and tested what
> happens? Because I wouldn't be surprised if this ended in tears but
> maybe I'm overly pessimistic.
> 
> Both (1) and (2) are rather special and don't have standard filesystem
> semantics in a few places.
> 
> - cgroupfs isn't actually namespace aware. Whereas most filesystems like
>   tmpfs and ramfs that are mountable inside unprivileged containers are
>   multi-instance filesystems, aka allocate a new superblock per
>   container cgroupfs is single-instance with a nasty implementation to
>   virtualize the per-container view via cgroup namespaces. I wouldn't be
>   surprised if that ends up being problematic.
> 
> - Cgroupfs has write-time permission checks as the process that is moved
>   into a cgroup isn't known at open time. That has been exploitable
>   before this was fixed.
> 
> - Even though it's legacy cgroup has a v1 and v2 mode where v1 is even
>   more messed up than v2 including the release-agent logic which ends up
>   issuing a usermode helper to call a binary when a cgroup is released.
> 
> - sysfs potentially exposes all kinds of extremly low-level information
>   to a remote machine.
> 
> None of this gives me the warm and fuzzy. But that's just me.
> 
> Otherwise, I don't understand what it means that a userspace NFS server
> can export kernfs instances. I don't know what that means and what the
> contrast to in-kernel NFS server export is and whether that has the same
> security implications. If so it's even scary that some random userspace
> NFS server can just expose guts like kernfs.
> 
> But if both of you feel that this is safe to do and there aren't any
> security issues lurking that have gone unnoticed simply because no one
> has really ever exported sysfs or cgroupfs then by all means continue
> allowing that. I'm rather skeptical.

Amir pointed that sysfs can't be exported as it opts out of kernfs
export_operations being set.

