Return-Path: <linux-fsdevel+bounces-52516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7D9AE3C41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743173A8C4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAF723ABBB;
	Mon, 23 Jun 2025 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfnB+mjo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5C02367B0;
	Mon, 23 Jun 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674414; cv=none; b=mExKaEeVRFvNhYFOIVmJQ+qPdF9QcSHUdO7RurFPgcTM6XxyNZ06tdbqigYIYwoFtoRqCri02Kh4sw/yLRVyCTXHHZjPHmHsTDgRnLn32N26mdP/F4y6PUSJ1HAUzRllF6D3QF6TBehvmUrKhUWFzrgDYpbtI/PnXuXrTcvFDUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674414; c=relaxed/simple;
	bh=7Xubnx5PrszaDkFPcdQn0yJvFNKRnBtRBZljZ8eV87Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUieGWBYosZ8BR+HTN8sELcH916Em7MAzbP1wxAX6NjLHcxGqDd23FryP81HdnyCyZqJ/TPj5DLU0jtuAv2v951AaIN2lk7jzQU/dt+n6oNYFqj+XlkblUKCJcIh/r/EruUdniy5AFBCNT2smUIJ5vg48MPx0nolbxAvDCb/VjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfnB+mjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B929DC4CEF0;
	Mon, 23 Jun 2025 10:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750674414;
	bh=7Xubnx5PrszaDkFPcdQn0yJvFNKRnBtRBZljZ8eV87Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfnB+mjogCAFWsxEZGWCYMGFf+mYwiYYOVggLuWsLuewkGioyV2kdsS55h8h/9A1v
	 f97TmJeIXm0KZaamPOoVTaM2eC+27mCUn1ien3aTvUshy2QdDa/BTMZ/hmbqskwJyl
	 YSMD+WvUa5f+1/kqbVXj2ko7eKql88rlr0xucnhPs6czPP3InALEi0VKhyxTddE4F8
	 ooEUdk2odGnkyCef8GXSxSkStCNnXAkCLxttHqWunbn6t/vUIIN3Htq2EumT4r4MFe
	 9npy1dOYhJIc0zkhPai9Hc/LCvAat4naHaBW0F8gxRuwqfFJX+ABkb7q+fVt6vHAYn
	 CMOAjnJGtJ0OA==
Date: Mon, 23 Jun 2025 12:26:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable
 filesystems
Message-ID: <20250623-analog-kolossal-4eee589ebb08@brauner>
References: <20250602171702.1941891-1-amir73il@gmail.com>
 <oxmvu3v6a3r4ca26b4dhsx45vuulltbke742zna3rrinxc7qxb@kinu65dlrv3f>
 <CAOQ4uxicRiha+EV+Fv9iAbWqBJzqarZhCa3OjuTr93NpT+wW-Q@mail.gmail.com>
 <CAOQ4uxiNjZKonPKh7Zbz89TmSE67BVHmAtLMZGz=CazNAYRmGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiNjZKonPKh7Zbz89TmSE67BVHmAtLMZGz=CazNAYRmGQ@mail.gmail.com>

On Sun, Jun 22, 2025 at 09:20:24AM +0200, Amir Goldstein wrote:
> On Mon, Jun 16, 2025 at 10:06 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Sun, Jun 15, 2025 at 9:20 PM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Mon, Jun 02, 2025 at 07:17:02PM +0200, Amir Goldstein wrote:
> > > > Case folding is often applied to subtrees and not on an entire
> > > > filesystem.
> > > >
> > > > Disallowing layers from filesystems that support case folding is over
> > > > limiting.
> > > >
> > > > Replace the rule that case-folding capable are not allowed as layers
> > > > with a rule that case folded directories are not allowed in a merged
> > > > directory stack.
> > > >
> > > > Should case folding be enabled on an underlying directory while
> > > > overlayfs is mounted the outcome is generally undefined.
> > > >
> > > > Specifically in ovl_lookup(), we check the base underlying directory
> > > > and fail with -ESTALE and write a warning to kmsg if an underlying
> > > > directory case folding is enabled.
> > > >
> > > > Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > > Link: https://lore.kernel.org/linux-fsdevel/20250520051600.1903319-1-kent.overstreet@linux.dev/
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Miklos,
> > > >
> > > > This is my solution to Kent's request to allow overlayfs mount on
> > > > bcachefs subtrees that do not have casefolding enabled, while other
> > > > subtrees do have casefolding enabled.
> > > >
> > > > I have written a test to cover the change of behavior [1].
> > > > This test does not run on old kernel's where the mount always fails
> > > > with casefold capable layers.
> > > >
> > > > Let me know what you think.
> > > >
> > > > Kent,
> > > >
> > > > I have tested this on ext4.
> > > > Please test on bcachefs.
> > >
> > > Where are we at with getting this in? I've got users who keep asking, so
> > > hoping we can get it backported to 6.15
> >
> > I'm planning to queue this for 6.17, but hoping to get an ACK from Miklos first.
> >
> 
> Hi Christian,
> 
> I would like to let this change soak in next for 6.17.
> I can push to overlayfs-next, but since you have some changes on vfs.file,
> I wanted to consult with you first.
> 
> The changes are independent so they could go through different trees,
> but I don't like that so much, so I propose a few options.
> 
> 1. make vfs.file a stable branch, so I can base overlayfs-next on it
> 2. rename to vfs.backing_file and make stable
> 3. take this single ovl patch via your tree, as I don't currently have
>     any other ovl patches queued to 6.17

Let's start with 3. and switch to a stable branch on demand?

