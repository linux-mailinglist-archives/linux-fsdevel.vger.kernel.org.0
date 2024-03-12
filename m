Return-Path: <linux-fsdevel+bounces-14211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0741587961A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 15:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C112B20CEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131297B3C6;
	Tue, 12 Mar 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2E2gY86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9279933;
	Tue, 12 Mar 2024 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253660; cv=none; b=ib9sZtXoXAka08jHI1sIZ3i2zZx7t58A1dUfrotRaj/qmt2VNYRFwz4WEUfeLhdRjJcK1WmqtUP1YpnE9L7Tc2Nc8ZVaZPDTkcXELnHrIL3lBpgXt/3dSYzljmQ67QpT+KpuLBqLDFftLyyMb2suv77QfvbVkD82rvjIXuP4q8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253660; c=relaxed/simple;
	bh=bvndcJKgC/kiItScSENHsgi4u+xxjLobnUDEB/IFVlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftna7HSxdqos779ukCNHpDew6Pc0drzvZn0qafugcWEadYqI4GpvC2/94k+73nmU30yk+xWKrKAc9L7B/g1ZbG+wxtDdXGZgmj8Z32vZW6NRdfkvDjx5ZhIKgRyy2GJWq9WMFsB5f6f/S3LlibLIjTK+lwklQVdCsMDa0xh64mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2E2gY86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F516C433C7;
	Tue, 12 Mar 2024 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710253659;
	bh=bvndcJKgC/kiItScSENHsgi4u+xxjLobnUDEB/IFVlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2E2gY86B6K2Qx/XA1LALB2vephl9VjNUEbRksClTVaBq45YMp6q79KYThBBx61Ab
	 PTDkos2aNFWq1vrMKcv9+jOWqcHuiiH9Vi4YyL8zdv5o/zavVhgP3tj9NpfwCjJvSS
	 rUMEq5X1k76Wc7fhC6vz35y1Ktznt8h1tWlRammGISbYubSxeLYxITDQifvY2zyuqS
	 DoJtv7oXzr7f3+5M7neQzqlbm/lbv7hF+x3yn18AdA0nMkyu02eTvN5NyAz+UCt9us
	 x9ttdkV9KZpHzkUPbKMrfSz5haoMImkYY19RF6Dt+7RZhLdi6RTmOvbGkHog+rYlfR
	 R26WMuaQhKAtg==
Date: Tue, 12 Mar 2024 15:27:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] statx: stx_subvol
Message-ID: <20240312-erstrahlen-lauch-9fc2b6ba3829@brauner>
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <2f598709-fccb-4364-bf15-f9c171b440aa@wdc.com>
 <20240311-zugeparkt-mulden-48b143bf51e0@brauner>
 <kzhjrn5kfggurz46wahncz4smekj7aizmhoe4sqphxt44vyfdm@3fgozft33f5u>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kzhjrn5kfggurz46wahncz4smekj7aizmhoe4sqphxt44vyfdm@3fgozft33f5u>

On Mon, Mar 11, 2024 at 04:15:04PM -0400, Kent Overstreet wrote:
> On Mon, Mar 11, 2024 at 02:43:11PM +0100, Christian Brauner wrote:
> > On Mon, Mar 11, 2024 at 08:12:33AM +0000, Johannes Thumshirn wrote:
> > > On 08.03.24 03:29, Kent Overstreet wrote:
> > > > Add a new statx field for (sub)volume identifiers, as implemented by
> > > > btrfs and bcachefs.
> > > > 
> > > > This includes bcachefs support; we'll definitely want btrfs support as
> > > > well.
> > > 
> > > For btrfs you can add the following:
> > > 
> > > 
> > >  From 82343b7cb2a947bca43234c443b9c22339367f68 Mon Sep 17 00:00:00 2001
> > > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > Date: Mon, 11 Mar 2024 09:09:36 +0100
> > > Subject: [PATCH] btrfs: provide subvolume id for statx
> > > 
> > > Add the inode's subvolume id to the newly proposed statx subvol field.
> > > 
> > > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > ---
> > 
> > Thanks, will fold, once I hear from Josef.
> 
> Can we try to make 6.9? Need to know what to put in the manpage, and
> I've got userspace tooling that wants to use it.

Hm, I understand that you want to see this done but I think it's just
too tight. If this would've been Acked last week then we could've done
it the second week of the merge window. So my reaction is to wait for
v6.10. What do others think?

