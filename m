Return-Path: <linux-fsdevel+bounces-56087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEA5B12BBA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 19:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D667160CE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 17:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B298E288C0D;
	Sat, 26 Jul 2025 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bjggcOv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C7B19309E;
	Sat, 26 Jul 2025 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753552396; cv=none; b=Sdvba4iCLlatTBSx3q/2BCHLPl9U8xsfzrMkxotryDOBcHCjHUvNGm5voXDt3U8vR4yhamyX6vwT9uzjY9G+vxRfAmCJqw7LzRXhhxO911deoS7twSekxQdblzLozvO035d+MCzaFSmMHijyPnlORQrXqAPV2l6TfRCqLuCnXM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753552396; c=relaxed/simple;
	bh=rrG56LXs8XekII4uK2o+4zd5afI3AF5tEzWWV0UhHow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVmlsNxlIZwO0bGsDd2j0LLqa9p600ogMYcMmKRwptrK5SICqf+cAPmnMH1ibJnj/2jQ/I2tb0QXQJkSyBuarJiykhDcC1sQom6WP8GOixYEZsqvwOxPL1kRcIIdrF6EXKuAGynaUgiXW1JFYM380hrXhJkrFxrYzYObaiy7WaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bjggcOv/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=SOtxzkA06bMXz5XGSpD7dNRE9mbRWoZpwb7GbjpoTJ0=; b=bjggcOv/I1oV/VU4bMpCcQdmRy
	xXwulh6+8qo6+Mj37KhMs+PPhiJJs3G09JucDsk6HPnpdotVhjKlqfXUUs+XtYssXjQoD+zUgbi/F
	sVGgWbfkoMCt477zzFLoDyf/18Q5lOYdGZ72kOaNafPFRp/ke2y+dOpZGZ9EUcubzLYpFWpX2nO/I
	hOhvnBR7uzo4NfomG4BkYGPB3NQlpBkSCJyphhmw9oQM4P76Qw9xYZFSd5qa+KMUu2cdm3CUPsZ5Z
	7LiMLO06cfeeUq0q/5FoXI7AYbPlQr58ULEjQIdPSHZB8PdOSdKaBjjvy3qUBgbi/ueLF/3yAu0Qw
	jbgCXBuw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufj54-0000000A3T6-2gzu;
	Sat, 26 Jul 2025 17:53:10 +0000
Date: Sat, 26 Jul 2025 18:53:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrei Vagin <avagin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev,
	Linux API <linux-api@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
Message-ID: <20250726175310.GB222315@ZenIV>
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV>
 <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jul 26, 2025 at 10:12:34AM -0700, Andrei Vagin wrote:
> On Thu, Jul 24, 2025 at 4:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Jul 24, 2025 at 01:02:48PM -0700, Andrei Vagin wrote:
> > > Hi Al and Christian,
> > >
> > > The commit 12f147ddd6de ("do_change_type(): refuse to operate on
> > > unmounted/not ours mounts") introduced an ABI backward compatibility
> > > break. CRIU depends on the previous behavior, and users are now
> > > reporting criu restore failures following the kernel update. This change
> > > has been propagated to stable kernels. Is this check strictly required?
> >
> > Yes.
> >
> > > Would it be possible to check only if the current process has
> > > CAP_SYS_ADMIN within the mount user namespace?
> >
> > Not enough, both in terms of permissions *and* in terms of "thou
> > shalt not bugger the kernel data structures - nobody's priveleged
> > enough for that".
> 
> Al,
> 
> I am still thinking in terms of "Thou shalt not break userspace"...
> 
> Seriously though, this original behavior has been in the kernel for 20
> years, and it hasn't triggered any corruptions in all that time.

For a very mild example of fun to be had there:
	mount("none", "/mnt", "tmpfs", 0, "");
	chdir("/mnt");
	umount2(".", MNT_DETACH);
	mount(NULL, ".", NULL, MS_SHARED, NULL);
Repeat in a loop, watch mount group id leak.  That's a trivial example
of violating the assertion ("a mount that had been through umount_tree()
is out of propagation graph and related data structures for good").

As for the "CAP_SYS_ADMIN within the mount user namespace" - which
userns do you have in mind?

