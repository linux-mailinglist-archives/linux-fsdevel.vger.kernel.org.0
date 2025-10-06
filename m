Return-Path: <linux-fsdevel+bounces-63477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8856BBDD90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB7424EC91E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23D7233155;
	Mon,  6 Oct 2025 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmMudmN7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEDF1E1A3D;
	Mon,  6 Oct 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749575; cv=none; b=GaQYZu0CowIIAaHKrI0Ax2H6Gn3RLRmwKMGJxjezSZ11Brx/0ygy1ZrPobcs3kP6QixipQfp0RC4sl9GbCSZlbMUoYYivCbNQHfBbXcno0DA4hD5cFAxzYVOheYEnwaUpWCMahJVcU3qoXnNIduSuf+oXhLx3e6tuXdiLExiHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749575; c=relaxed/simple;
	bh=Hpvnf+j1mxtW51BviaDXUsv7YwPa75uCcO9uFatVCrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIT4k07SRjMcYmvlmKcGrdYyes195AY6ouJ+eNiHHF6K8HVLtnqv5dj/dUaMsmdP6vVdcX3nlrJBrK2+gbJi/pj43GbxYgQXv/mXmBKiKE6E7gEzdsS8/Y9tF5VAMYTpnH44M4bAH3GngAdzVN+mJ20/7KjTdWEzx7wJk9oUItw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmMudmN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9E9C4CEF5;
	Mon,  6 Oct 2025 11:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759749574;
	bh=Hpvnf+j1mxtW51BviaDXUsv7YwPa75uCcO9uFatVCrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmMudmN7W7uy1Ymw0EABoTYSzlU3Qfjeu9UysvjEA0EnjNtXbCYzI9ZoVcKOJIfkW
	 wKneuAhi/tDRGlbdtt2XX+UrQPFO7t1yxOPws7UydGfUrqESkwQ6SFnGXk1oW5mdcu
	 sDZtEPy9zhm9DM8PEsSRF/0L8ypx/RtYGBOp2QvY86N+UTprw94ehAlXOiziX3wiHI
	 zO88sv6j2hxnRWu7OLf+SZge1w/d4jMiuT98YeHpfGfjFGHVSba0MmbkxFfQ4wDdi4
	 aHFi4my1/guoEk7w3EGRctQYSedoLTZa1IdHoQIaDJ7aOPfQMd4Rp+bLvbDRfbT/A8
	 8W8vksM4tih5Q==
Date: Mon, 6 Oct 2025 13:19:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Chuck Lever <cel@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Volker Lendecke <Volker.Lendecke@sernet.de>, 
	CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
Message-ID: <20251006-zypressen-paarmal-4167375db973@brauner>
References: <20250925151140.57548-1-cel@kernel.org>
 <CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
 <87tt0gqa8f.fsf@mailhost.krisman.be>
 <28ffeb31-beec-4c7a-ad41-696d0fd54afe@kernel.org>
 <87plb3ra1z.fsf@mailhost.krisman.be>
 <4a31ae5c-ddb2-40ae-ae8d-747479da69e3@kernel.org>
 <87ldlrr8k3.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ldlrr8k3.fsf@mailhost.krisman.be>

On Fri, Oct 03, 2025 at 05:15:24PM -0400, Gabriel Krisman Bertazi wrote:
> Chuck Lever <cel@kernel.org> writes:
> 
> > On 10/3/25 4:43 PM, Gabriel Krisman Bertazi wrote:
> >> Chuck Lever <cel@kernel.org> writes:
> >> 
> >>> On 10/3/25 11:24 AM, Gabriel Krisman Bertazi wrote:
> >
> >>>> Does the protocol care about unicode version?  For userspace, it would
> >>>> be very relevant to expose it, as well as other details such as
> >>>> decomposition type.
> >>>
> >>> For the purposes of indicating case sensitivity and preservation, the
> >>> NFS protocol does not currently care about unicode version.
> >>>
> >>> But this is a very flexible proposal right now. Please recommend what
> >>> you'd like to see here. I hope I've given enough leeway that a unicode
> >>> version could be provided for other API consumers.
> >> 
> >> But also, encoding version information is filesystem-wide, so it would
> >> fit statfs.
> >
> > ext4 appears to have the ability to set the case folding behavior
> > on each directory, that's why I started with statx.
> 
> Yes. casefold is set per directory, but the unicode version and
> casefolding semantics used by those casefolded directories are defined
> for the entire filesystem.

I'm not too fond of wasting statx() space for this. Couldn't this be
exposed via the new file_getattr() system call?:

/*
 * Variable size structure for file_[sg]et_attr().
 *
 * Note. This is alternative to the structure 'struct file_kattr'/'struct fsxattr'.
 * As this structure is passed to/from userspace with its size, this can
 * be versioned based on the size.
 */
struct file_attr {
        __u64 fa_xflags;        /* xflags field value (get/set) */
        __u32 fa_extsize;       /* extsize field value (get/set)*/
        __u32 fa_nextents;      /* nextents field value (get)   */
        __u32 fa_projid;        /* project identifier (get/set) */
        __u32 fa_cowextsize;    /* CoW extsize field value (get/set) */
};

