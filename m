Return-Path: <linux-fsdevel+bounces-46898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A57A95FCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 09:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CBB3A8CA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 07:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1DE1E7C08;
	Tue, 22 Apr 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjeD7mXl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912931E2848
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308067; cv=none; b=jmMtIrApa8jjJ7j89G+d/tM5J48BIWGu3Tj+pZ6k9DQ4MFqF/zYKFBnQPPel18kI9Mo0HnkML3Bj/J0/lPTLPqu6+kdMtT89VbeY7XDx9aUVToWNG0vPg38TwJSQd3wwNKrSTZIdzEjC05ThyaOCYJOa+oCwB9f+EWT+jCQY7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308067; c=relaxed/simple;
	bh=/Eq6n5N/uePAhOs4UqiNg1RFnULd17pchtaWapnOYUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEGXdYpznlRo42NoR5RtmR7wARMsVnmpflfO+8qr43Mlwk4ylKF9/f5j70W5VbJrQWeLkm5a+5JPdFLe7i9XOZpPasv28rZ1+f1mN4F/2seWtPnRtXcc9eXXUsriGnflz5oWfb+ls1B4ZWvjDL1W4nlIvKW+8MmTxuMCvjl6fhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjeD7mXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C9DC4CEF4;
	Tue, 22 Apr 2025 07:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745308067;
	bh=/Eq6n5N/uePAhOs4UqiNg1RFnULd17pchtaWapnOYUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjeD7mXlb6UfEI374ylz6Dv7sAgeKuQXQL9fBwusVr5Ug+k0s/CLXAVlp3/dA1AE2
	 TxmHuPbgtBvhE71auLH+mS0dG1sk/BMYbncSa9P+oLO5k6UwG5R08/uca1/DI2guEd
	 9Jch9xU9lfHrva0gIE2TadcCbcgg2z+ecKYBC48EYLxIbUXkditc5JUnIJ4ufnR0T4
	 +NV/QVBc7fKKwd7MoqHdUry6ATlT+g9E9w4BgCoRUG+V5zRZKta3gYmqZe2dvBI7MM
	 CiR4alBLUyOz+UVTARoHJfMnbeF8VVxZNyFvDzXnlQvBCEzvKpJhQJBIHfdFxqCFCH
	 Jh9mywUsSK2Dw==
Date: Tue, 22 Apr 2025 09:47:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] do_lock_mount() races in 'beneath' case
Message-ID: <20250422-umstehend-freie-c60bc65a946d@brauner>
References: <20250421033509.GV2023217@ZenIV>
 <20250421-annehmbar-fotoband-eb32f31f6124@brauner>
 <20250421162947.GW2023217@ZenIV>
 <20250421170319.GX2023217@ZenIV>
 <20250422031448.GY2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422031448.GY2023217@ZenIV>

On Tue, Apr 22, 2025 at 04:14:48AM +0100, Al Viro wrote:
> On Mon, Apr 21, 2025 at 06:03:19PM +0100, Al Viro wrote:
> > On Mon, Apr 21, 2025 at 05:29:47PM +0100, Al Viro wrote:
> > 
> > > What's to prevent the 'beneath' case from getting mnt mount --move'd
> > > away *AND* the ex-parent from getting unmounted while we are blocked
> > > in inode_lock?  At this point we are not holding any locks whatsoever
> > > (and all mount-related locks nest inside inode_lock(), so we couldn't
> > > hold them there anyway).
> > > 
> > > Hit that race and watch a very unhappy umount...
> > 
> > While we are at it, in normal case inode_unlock() in unlock_mount()
> > is safe since we have dentry (and associated mount) pinned by
> > struct path we'd fed to matching lock_mount().  No longer true for
> > the 'beneath' case, AFAICS...
> 
> Completely untested patch follows; 'beneath' case in do_lock_mount() is made
> to grab mount reference to match the dentry one (same lifetime; dropped
> simultaneously), unlock_mount() unlocks the inode *before* namespace_unlock(),
> so we don't depend upon the externally held references.

Afaict both isssues you mentioned shouldn't exist. So I'd first like to
have details on how they're supposed to happen before fiddling with the
code, please.

