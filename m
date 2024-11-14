Return-Path: <linux-fsdevel+bounces-34757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 666959C87D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 11:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906631F2459A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110921F81A7;
	Thu, 14 Nov 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ12has6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC01F757C;
	Thu, 14 Nov 2024 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580773; cv=none; b=hjfN/wrrVqJOBrH7Z3nbwnZ7eU1K1Ya9ZpHhNuAFXqBlE02/uj2z9Iaq7ybMwhDo/c3B1++El87VzRDe11JToqvYKuKCBfKmm4142Fj786e603Ym+teThYAuGwndL27ceY4FvzaFpLcycv2BRWObfI2jP8Hr5HLpvF9hRCZZuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580773; c=relaxed/simple;
	bh=7eVKM2u0wRuYynIMz0RGEDHl2osz/wLDV1pMKysucr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZhZ6f89PaHInhCVXlkAS0/pyPnLPz2isV2GeuqqWLJ5CphkERxb14cRcaxAL7RKN8ePjIS8tDT1I4vu/+WkxMNhfxOhdk/Q9ytlaqLN+tycr8NJ1z5cVPq3LYzA3MOOm16Kp/kBKWUPeXcWJduOS9/53xs++QUHbYtk4gTgNjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ12has6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A37C4CED4;
	Thu, 14 Nov 2024 10:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731580773;
	bh=7eVKM2u0wRuYynIMz0RGEDHl2osz/wLDV1pMKysucr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQ12has69L4dvjjiYK8WBZRVz8rlAphhl52vmon7NoRO2tBGN/GQvOW4OsavX/doI
	 yyAG5/i7o5/oSGR9zaSORatByq5Jl30JPxHLJ7O+WyiOSi+nAtRrjjKFIOmNI/dqzu
	 iJ8QtJ88inezm3elNFQaxVgjCuG/rtbr+iSzu8llq3Hs9ncwGrb4V3VCSfIYxcW9RD
	 kTxB9ps6xc74KCVWLPQl8t6jtnoA6GOjeM7G+e8IWU5blY4Baidu6Axw0lI6v8vE4P
	 SJpUA5N2EsSWjClewtKzQQEaAiKHGv7/N5ZFBzTay7QO25/TXRyJWDHSJ3+m69v7Ih
	 OKumpAtBFvoJA==
Date: Thu, 14 Nov 2024 11:39:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>, 
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Erin Shepherd <erin.shepherd@e43.eu>, 
	Amir Goldstein <amir73il@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, "christian@brauner.io" <christian@brauner.io>, 
	Paul Moore <paul@paul-moore.com>, "bluca@debian.org" <bluca@debian.org>
Subject: Re: [PATCH 0/4] pidfs: implement file handle support
Message-ID: <20241114-dachorganisation-erloschen-4d1b903b65c9@brauner>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241112-banknoten-ehebett-211d59cb101e@brauner>
 <05af74a9-51cc-4914-b285-b50d69758de7@e43.eu>
 <20241113004011.GG9421@frogsfrogsfrogs>
 <e280163e-357e-400c-81e1-0149fa5bfc89@e43.eu>
 <0f267de72403a3d6fb84a5d41ebf574128eb334d.camel@kernel.org>
 <78CFACCD-E2F1-4FF6-96BA-3738748A3B40@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78CFACCD-E2F1-4FF6-96BA-3738748A3B40@oracle.com>

On Wed, Nov 13, 2024 at 02:41:29PM +0000, Chuck Lever III wrote:
> 
> 
> > On Nov 13, 2024, at 8:29 AM, Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > On Wed, 2024-11-13 at 11:17 +0100, Erin Shepherd wrote:
> >> On 13/11/2024 01:40, Darrick J. Wong wrote:
> >>>> Hmm, I guess I might have made that possible, though I'm certainly not
> >>>> familiar enough with the internals of nfsd to be able to test if I've done
> >>>> so.
> >>> AFAIK check_export() in fs/nfsd/export.c spells this it out:
> >>> 
> >>> /* There are two requirements on a filesystem to be exportable.
> >>> * 1:  We must be able to identify the filesystem from a number.
> >>> *       either a device number (so FS_REQUIRES_DEV needed)
> >>> *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
> >>> * 2:  We must be able to find an inode from a filehandle.
> >>> *       This means that s_export_op must be set.
> >>> * 3: We must not currently be on an idmapped mount.
> >>> */
> >>> 
> >>> Granted I've been wrong on account of stale docs before. :$
> >>> 
> >>> Though it would be kinda funny if you *could* mess with another
> >>> machine's processes over NFS.
> >>> 
> >>> --D
> >> 
> >> To be clear I'm not familiar enough with the workings of nfsd to tell if
> >> pidfs fails those requirements and therefore wouldn't become exportable as
> >> a result of this patch, though I gather from you're message that we're in the
> >> clear?
> >> 
> >> Regardless I think my question is: do we think either those requirements could
> >> change in the future, or the properties of pidfs could change in the future,
> >> in ways that could accidentally make the filesystem exportable?
> >> 
> >> I guess though that the same concern would apply to cgroupfs and it hasn't posed
> >> an issue so far.
> > 
> > We have other filesystems that do this sort of thing (like cgroupfs),
> > and we don't allow them to be exportable. We'll need to make sure that
> > that's the case before we merge this, of course, as I forget the
> > details of how that works.
> 
> It's far easier to add exportability later than it is
> to remove it if we think it was a mistake. I would err
> on the side of caution if there isn't an immediate
> need/use-case for exposure via NFS.

Tbh, the idea itself of exporting pidfs via nfs is a) crazy and b)
pretty interesting. If we could really export pidfs over NFS cleanly
somehow then we would have a filesystem-like representation of a remote
machine's processes. There could be a lot of interesting things in this.
But I would think that this requires some proper massaging of how pidfs
works. But in principle it might be possible.

Again, I'm not saying it's a great idea and we definitely shouldn't do
it now. But it's an interesting thought experiment at least.

