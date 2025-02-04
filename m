Return-Path: <linux-fsdevel+bounces-40745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF76A271DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4642C3A1232
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4BC20FAA0;
	Tue,  4 Feb 2025 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlUX0vwV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0EC206F3A
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738672315; cv=none; b=pbRjA+3gHjFVEKJsK0PZx8a4/xgF82VAZrDNHHaDOzluicger2Aesi3lDptxo/RTISgGCL+wYw+w/78+Jx0FMomYh6cJgCTjsoEc3VWXQX/DfCRFVGvMfTxhM9ja7wbZFW2cD/mKRdyYbUEfEB3z5R9ZObavuT4WlgCGNGSE8GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738672315; c=relaxed/simple;
	bh=v8eMud63We0xAUiSz6XVSPMJXJKlHefE8JPx8aibdVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioSQUeCAav/HXdRaZEFqhEIkJ3gmSb7pwgYJFWvfUb5QsxDBRXEOWIqYaUMS+bWnTmspkFZD+ND81hTk8gHqr3voo4pJzW1S0g07DgztuQYirtUI6tNdnURO7HNxw9/ztlozp0qySSEivR2QjRC189FZc73EDT8ip3TjIruRNYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlUX0vwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A943C4CEDF;
	Tue,  4 Feb 2025 12:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738672314;
	bh=v8eMud63We0xAUiSz6XVSPMJXJKlHefE8JPx8aibdVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlUX0vwV9oagM1oWpmmFD8U98yS9wlMMR/d7cxQlqz8+79HCay/whLyCZ71Qiheat
	 tb1QpbFs/cx1y4ML+8QxCBfHRTBQB9UhVyC5GGdUcApbLLs62nehznbkvbsrRemVwe
	 0/XbILit/uYqenO9gNJ5rlqzXZuAmZpuKvTXP5EkzLMZKaJ1O1FwUhdg9jIX5nv18D
	 kamteEcL/cqdTa/ZWh1cEhD3pwBwNeC6s2BkaYq1qVxwXlBxf+TfDqQ9g4XgxulihC
	 H1R2cuGXovKO5DJG7Ibs9sWfWO4q7AmZI/wT905fpSGVifNaRq4A0D8Nbr1ergDQ2P
	 7KL2tty8FMAPw==
Date: Tue, 4 Feb 2025 13:31:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Joanne Koong <joannelkoong@gmail.com>, kernel-team@meta.com, 
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: clear FR_PENDING without holding fiq lock for
 uring requests
Message-ID: <20250204-endrunde-kursangebot-27e874e6da80@brauner>
References: <20250203185040.2365113-1-joannelkoong@gmail.com>
 <20250204-glashaus-begraben-5ea4e8fc3941@brauner>
 <17197632-8612-427b-90b0-26b2626a8ffd@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17197632-8612-427b-90b0-26b2626a8ffd@fastmail.fm>

On Tue, Feb 04, 2025 at 12:31:21PM +0100, Bernd Schubert wrote:
> Hi Christian,
> 
> On 2/4/25 12:12, Christian Brauner wrote:
> > On Mon, 03 Feb 2025 10:50:40 -0800, Joanne Koong wrote:
> >> req->flags is set/tested/cleared atomically in fuse. When the FR_PENDING
> >> bit is cleared from the request flags when assigning a request to a
> >> uring entry, the fiq->lock does not need to be held.
> >>
> >>
> > 
> > Applied to the vfs-6.15.fuse branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.15.fuse branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs-6.15.fuse
> > 
> > [1/1] fuse: clear FR_PENDING without holding fiq lock for uring requests
> >       https://git.kernel.org/vfs/vfs/c/c612e9f8d20b
> 
> do you see my reply?
> 
> https://lore.kernel.org/all/ff73c955-2267-4c77-8dca-0e4181d8e8b4@fastmail.fm/

Hm, that's odd. It didn't appear for me... Sorry about that.

