Return-Path: <linux-fsdevel+bounces-63778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBADBCD9B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6806F4E3AB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E4A2F6569;
	Fri, 10 Oct 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5wHC506"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CEF21A95D;
	Fri, 10 Oct 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107778; cv=none; b=BxKhc4ZzRAC5X/aWZadOH6AD2h9Yu6ifPpnnJVzO/4puG9tG+7UjvAFs/Fvd61Glf3P30t0ddD5PeEXUOe5gMoVIKsYgxrIj6AYZ9Pfy5zu21SsLSy5XeVUYD+YyTwVIPeSxnSgxU0TagJhEG4lAkTOasq7amV1QQ4LrxhPqYcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107778; c=relaxed/simple;
	bh=Oh/7AZMFcBYKVF3dP+7IxTc/vPIZINLj7Syl673aU48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su1qrmimpHpAArDKPyRE9migsPuYXm6Pj/mMhf4dcrRjSUUEy5G+VtRqSwnmVVeOpPIQG8+ND6sSCEziexDpWZ3wBEoF51TiW8zlmzM65Njox8BaYls5LXCzaDoihC/q1+ntSYg5iP8RLF46TmC5Y5zsaSoYhEfmp0qZEuz8aAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5wHC506; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5603C4CEF1;
	Fri, 10 Oct 2025 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760107778;
	bh=Oh/7AZMFcBYKVF3dP+7IxTc/vPIZINLj7Syl673aU48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5wHC506WxIHpBXkvPDRrEyNyDH0a/Uk1dY4uCnSl2UfIjvkYxQRb7Lc2Te8S5jYs
	 19w+vB0AS7+bVKJfitE3+1OzdfkJ3UlZ64Nry6AY4dhmBK/5XYSMh7jdhqsmxChNYz
	 h5YueIYG6BtTW5o7rhuRgDEtgLlL7/2odkoHZ4enEQjXpdSuubRqQMaKXiYHpoIeGp
	 ROQTqBDzz4ma147mTtiUcA+ORS/vTEdE6dMWmHafqtE1emxCr8t+aqOCyJ41kZhYLu
	 hqNXYm/17umuQINFJx84+BlgnhvcbcIB6YWVACs27xypaZSjd+hvl1NashMQYKoiJS
	 7Aku3jp12el8A==
Date: Fri, 10 Oct 2025 07:49:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>,
	Chuck Lever <cel@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Volker Lendecke <Volker.Lendecke@sernet.de>,
	CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
Message-ID: <20251010144938.GB6174@frogsfrogsfrogs>
References: <20250925151140.57548-1-cel@kernel.org>
 <CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
 <87tt0gqa8f.fsf@mailhost.krisman.be>
 <28ffeb31-beec-4c7a-ad41-696d0fd54afe@kernel.org>
 <87plb3ra1z.fsf@mailhost.krisman.be>
 <4a31ae5c-ddb2-40ae-ae8d-747479da69e3@kernel.org>
 <87ldlrr8k3.fsf@mailhost.krisman.be>
 <20251006-zypressen-paarmal-4167375db973@brauner>
 <87zfa2pr4n.fsf@mailhost.krisman.be>
 <20251010-rodeln-meilenstein-0ebf47663d35@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-rodeln-meilenstein-0ebf47663d35@brauner>

On Fri, Oct 10, 2025 at 01:11:32PM +0200, Christian Brauner wrote:
> On Tue, Oct 07, 2025 at 01:18:32PM -0400, Gabriel Krisman Bertazi wrote:
> > Christian Brauner <brauner@kernel.org> writes:
> > 
> > > On Fri, Oct 03, 2025 at 05:15:24PM -0400, Gabriel Krisman Bertazi wrote:
> > >> Chuck Lever <cel@kernel.org> writes:
> > >> 
> > >> > On 10/3/25 4:43 PM, Gabriel Krisman Bertazi wrote:
> > >> >> Chuck Lever <cel@kernel.org> writes:
> > >> >> 
> > >> >>> On 10/3/25 11:24 AM, Gabriel Krisman Bertazi wrote:
> > >> >
> > >> >>>> Does the protocol care about unicode version?  For userspace, it would
> > >> >>>> be very relevant to expose it, as well as other details such as
> > >> >>>> decomposition type.
> > >> >>>
> > >> >>> For the purposes of indicating case sensitivity and preservation, the
> > >> >>> NFS protocol does not currently care about unicode version.
> > >> >>>
> > >> >>> But this is a very flexible proposal right now. Please recommend what
> > >> >>> you'd like to see here. I hope I've given enough leeway that a unicode
> > >> >>> version could be provided for other API consumers.
> > >> >> 
> > >> >> But also, encoding version information is filesystem-wide, so it would
> > >> >> fit statfs.
> > >> >
> > >> > ext4 appears to have the ability to set the case folding behavior
> > >> > on each directory, that's why I started with statx.
> > >> 
> > >> Yes. casefold is set per directory, but the unicode version and
> > >> casefolding semantics used by those casefolded directories are defined
> > >> for the entire filesystem.
> > >
> > > I'm not too fond of wasting statx() space for this. Couldn't this be
> > > exposed via the new file_getattr() system call?:
> > 
> > Do you mean exposing of unicode version and flags to userspace? If so,
> > yes, for sure, it can be fit in file_get_attr. It was never exposed
> > before, so there is no user expectation about it!
> 
> Imho it would fit better there than statx(). If this becomes really
> super common than we can also later decide to additional expose it via
> statx() but for now I think it'd be better to move this into the new
> file_attr()* apis.

n00b question here: Can you enable (or disable) casefolding and the
folding scheme used?  My guess is that one ought to be able to do that
either (a) on an empty directory or (b) by reindexing the entire
directory if the filesystem supports that kind of thing?  But hey, it's
not like xfs supports any of that. ;)

--D

