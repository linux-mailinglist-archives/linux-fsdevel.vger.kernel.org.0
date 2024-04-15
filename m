Return-Path: <linux-fsdevel+bounces-16943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0D8A5586
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6588C1F22909
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8661EEE3;
	Mon, 15 Apr 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLtcVAHw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02DA6CDBA
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192493; cv=none; b=Bfhn+Wnwx9XX5ZinGf8PlpWZFxUNOS4Yz4QwUxDxlZ9Fo++DOtp/ryEuZTqzxgE4Cpzy1FcV6hE0YMjRSXFFIg9ZWDtBpxoCXDh8L/vGpgrZkt5Ekw0vZ4hfOGFnFcISJzHvrUATH1r1HA8ZrxsNs96ec3mIh/rvQR8/HMH7T6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192493; c=relaxed/simple;
	bh=dk3g34zDF+RgmPe2sp7iEYG0Bd2vOKhongDBGq6RZWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHo7lPKZTrOTrkWow1hPP93M6ObqiZDM4hvpFEr55gd0NDLSKal4bu7+phspDvXVVyrQ2Eah3DCrohrWE/O16f9r/BBzWO3ZOlOVZSxb7vwazUgzCFL85+AOLosKtooJYqnfEfzVK2HlFWkP1to4AQ64RUrrAjb3KhtEDlA+XgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLtcVAHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225F4C113CC;
	Mon, 15 Apr 2024 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713192493;
	bh=dk3g34zDF+RgmPe2sp7iEYG0Bd2vOKhongDBGq6RZWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FLtcVAHwhksdTnf9GbV+kMMaZemaUwhO+xYGvMoEBH/9EKjwIei8DRGnrfP7uw5rA
	 q0wApLy7iA8Xx1MfQRpD3HySl6zhdFJTf6ilcGLMWI6ZivqtFhTnXE/gOCbsnWl1Pw
	 DDxUdBq45Co5+GWToL+6Dr+N4Htq28ns8U4jaHJ8JW/my9tamyPiEMnzaWnACIGQdW
	 zmK4WmNn2FCxa5/xuKA5yLLIzQhxv9ruIvI6ybdEijYe6d7hZzakRm7LvdaLubX7dU
	 qrClrkx3JNnbGMYiqC2zYfN0LVx8+TQLXAu5jSR/4PzRdL1lG+UJ9YQEaQow9lJ1Dw
	 LCf/QqDaU8fcg==
Date: Mon, 15 Apr 2024 16:48:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: cel@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Fix shmem_rename2 directory offset calculation
Message-ID: <20240415-ratten-verifizieren-62efe5e9df74@brauner>
References: <20240411182611.203328-1-cel@kernel.org>
 <ZhlFQ6HFF5p9qUaX@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhlFQ6HFF5p9qUaX@tissot.1015granger.net>

On Fri, Apr 12, 2024 at 10:29:23AM -0400, Chuck Lever wrote:
> On Thu, Apr 11, 2024 at 02:26:09PM -0400, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > The existing code in shmem_rename2() allocates a fresh directory
> > offset value when renaming over an existing destination entry. User
> > space does not expect this behavior. In particular, applications
> > that rename while walking a directory can loop indefinitely because
> > they never reach the end of the directory.
> > 
> > The first patch in this series corrects that problem, which exists
> > in v6.6 - current. The second patch is a clean-up and can be deferred
> > until v6.10.
> > 
> > Chuck Lever (2):
> >   shmem: Fix shmem_rename2()
> >   libfs: Clean up the simple_offset API
> > 
> >  fs/libfs.c         | 89 ++++++++++++++++++++++++++++++++++------------
> >  include/linux/fs.h | 10 +++---
> >  mm/shmem.c         | 17 +++++----
> >  3 files changed, 81 insertions(+), 35 deletions(-)
> 
> A cursory pass with fstests seemed to work fine, but a number of
> tests in the git regression suite are failing. Please feel free
> to send review comments, but do not merge this series yet.

Ok!

