Return-Path: <linux-fsdevel+bounces-67124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C976FC35CAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 14:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960655607DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4673195F0;
	Wed,  5 Nov 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnQMpaiu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58E2D73A7;
	Wed,  5 Nov 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348587; cv=none; b=FpTJRtevVukEXu9QkS8H710wouVISJJYMSZGj9sWooyNnUZJtm8h1cPLfW/yDRhsQcwzpv02bvPNaaq9KhRocMH/jNKw8Iq7jnNGxWqlC35NWo2H10aK+32W62w9JWo0v5bqUuqIULR8P+UonXmM4LSjZ+42me0UYZDW8TUsUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348587; c=relaxed/simple;
	bh=OBvixuYbeAnNVseOEocUtnf2AaLDAy6Mj92/tM/4EB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUmZjz1UDXusBZiOziqY3vIaJiwuNCcG1+zCoAVG13fZ1SfRolsLOaFSDZyFzL2FkTzeCHIq5hil2yBs2UUnsGg7cStJRGKjyzqDhQ+L42DZT0VixltMoEtkfql/AAcQTfd57ZYDgoSE8ZO7iazwhdRpGJmAOH2b5/dfdP4E70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnQMpaiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C33C4CEF8;
	Wed,  5 Nov 2025 13:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762348586;
	bh=OBvixuYbeAnNVseOEocUtnf2AaLDAy6Mj92/tM/4EB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RnQMpaiuAolZlRt+GOgY8wQUOoEAqEsvvBhNHFfabs3tgQdd/42dJ4BLpf02azCs7
	 9f5LkQUq4/5I3J7xDoN9f2Nx12Ii26kGmzAPhXZW/DkyiUxqK/+qYDcLH0dpCdJpmY
	 I8bq0drnEp7lJ+2zecFyc266utJI7C9jUyFuiMrtFTL+vFSpS7KNPsYvVYBWs4X+93
	 JUVuXLg8R3tAigRVRdNoNIG0ah53puDwO3NtTUAHN+zuI28jyIbNTi77g/EJ7W3ive
	 Tobez7A38LaBkvBroJdXPCHcMoub+yGyJRZsEjNuf6bMVUL1xt7dr+leLrQHcqjThU
	 RYeTZ6wKB6HKA==
Date: Wed, 5 Nov 2025 14:16:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, jack@suse.cz, raven@themaw.net, 
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, borntraeger@linux.ibm.com, 
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 22/50] convert efivarfs
Message-ID: <20251105-sohlen-fenster-e7c5af1204c4@brauner>
References: <20251028004614.393374-23-viro@zeniv.linux.org.uk>
 <66300d81c5e127e3bca8c6c4d997da386b142004.camel@HansenPartnership.com>
 <20251028174540.GN2441659@ZenIV>
 <20251028210805.GP2441659@ZenIV>
 <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
 <9f079d0c8cffb150c0decb673a12bfe1b835efc9.camel@HansenPartnership.com>
 <20251029193755.GU2441659@ZenIV>
 <CAMj1kXHnEq97bzt-C=zKJdV3BK3EDJCPz3Pfyk52p2735-4wFA@mail.gmail.com>
 <20251105-aufheben-ausmusterung-4588dab8c585@brauner>
 <423f5cc5352c54fc21e0570daeeddc4a58e74974.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <423f5cc5352c54fc21e0570daeeddc4a58e74974.camel@HansenPartnership.com>

On Wed, Nov 05, 2025 at 08:09:03AM -0500, James Bottomley wrote:
> On Wed, 2025-11-05 at 12:47 +0100, Christian Brauner wrote:
> > On Thu, Oct 30, 2025 at 02:35:51PM +0100, Ard Biesheuvel wrote:
> [...]
> > > commit 0e4f9483959b785f65a36120bb0e4cf1407e492c
> > > Author: Christian Brauner <brauner@kernel.org>
> > > Date:   Mon Mar 31 14:42:12 2025 +0200
> > > 
> > >     efivarfs: support freeze/thaw
> > > 
> > > actually broke James's implementation of the post-resume sync with
> > > the underlying variable store.
> > > 
> > > So I wonder what the point is of all this complexity if it does not
> > > work for the use case where it is the most important, i.e., resume
> > > from hibernation, where the system goes through an ordinary cold
> > > boot and so the EFI variable store may have gotten out of sync with
> > > the hibernated kernel's view of it.
> > > 
> > > If no freeze/thaw support in the suspend/resume path is
> > > forthcoming, would it be better to just revert that change? That
> > > would badly conflict with your changes, though, so I'd like to
> > > resolve this before 
> > > going further down this path.
> > 
> > So first of all, this works. I've tested it extensively. If it
> > doesn't work there's a regression.
> 
> I haven't yet got around to finding the test image I used for this, but
> I'll try to do that and get a test running this week.
> 
> > And suspend/resume works just fine with freeze/thaw. See commit
> > eacfbf74196f ("power: freeze filesystems during suspend/resume")
> > which implements exactly that.
> > 
> > The reason this didn't work for you is very likely:
> > 
> > cat /sys/power/freeze_filesystems
> > 0
> > 
> > which you must set to 1.
> 
> Actually, no, that's not correct.  The efivarfs freeze/thaw logic must
> run unconditionally regardless of this setting to fix the systemd bug,
> so all the variable resyncing is done in the thaw call, which isn't
> conditioned on the above (or at least it shouldn't be).

It is conditioned on the above currently but we can certainly fix it
easily to not be.

