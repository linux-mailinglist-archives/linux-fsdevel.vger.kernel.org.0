Return-Path: <linux-fsdevel+bounces-48093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85122AA95A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4773AC2C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E06525C706;
	Mon,  5 May 2025 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNrMzKKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0F7255F56;
	Mon,  5 May 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455061; cv=none; b=Q3VrCteonjEVKQDkE806Nf3835IAMtR4LfrcAMJlnWU70eDS69TncP5uJ+JVJna+BlTJ/cZeQz2vZQOC9g3ye4y2MI3uPY7J6ZELcb2hjo48/y2kntfes+b8tilvIyaBm28x4d+yWtx7h9FpqtQdg3l00XquNPkqlbJqGkwINrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455061; c=relaxed/simple;
	bh=VQJBlsfcu039NGxcnB1so5IxqsZzRbfh+MiXuVuI5II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMxx8Ta55MIGTvpBdnhcrniUaCSLzMZqigmilT/pL91hJRKVaHBx8FFDXKtdQ2g3cyqSKQ0N8p5aa9l3at8QiD69Mp2lMuh7v/pGxLcSdWB2DYr93p7WHsdIOM0nOAfL0T7EmHRmMzWBgvhtXw2baLQid30rPHukgpmCTVfsSsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNrMzKKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BD8C4CEE4;
	Mon,  5 May 2025 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746455060;
	bh=VQJBlsfcu039NGxcnB1so5IxqsZzRbfh+MiXuVuI5II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNrMzKKi/t1SIITN5L5wcVPdHJTVI6srZ6l2sbqX4uKfcjcNqOR3C5hnlDL8Wo4nn
	 l3NSt3By2S4Ir0Jf8RNwGEiEeAPehBTo0oSpVaA22Pug5NeEyKwVOtmFg+6x4sd/DT
	 eAFccNDJIVoJcrKI9bvCXydEcq1sFl20NEjsWzOJz8ESCKMUosxvzUtSx/a+SyVpzh
	 ct8JeRG/8Hy5JoXTl1xlzibhHn6SuKQDDyZsgTirtSPSEOzqC6t10vp+y0cON9aOTX
	 jdStAp2pJfQDFWZlN1lYg5PWyREgm71FSKN/5zDk+mycksa+tYYZb7c7qVZE3QVTGO
	 H0Jzwpeki6yCA==
Date: Mon, 5 May 2025 07:24:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v11 06/16] xfs: ignore HW which cannot atomic write a
 single block
Message-ID: <20250505142420.GH1035866@frogsfrogsfrogs>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
 <20250504085923.1895402-7-john.g.garry@oracle.com>
 <20250505054310.GB20925@lst.de>
 <1d0e85d5-5e5c-4a8c-ae97-d90092c2c296@oracle.com>
 <0b0d61e9-68e6-4eb0-a7bd-6e256e6d45f8@oracle.com>
 <20250505083050.GA31587@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505083050.GA31587@lst.de>

On Mon, May 05, 2025 at 10:30:50AM +0200, Christoph Hellwig wrote:
> On Mon, May 05, 2025 at 09:12:53AM +0100, John Garry wrote:
> > On 05/05/2025 06:45, John Garry wrote:
> >> On 05/05/2025 06:43, Christoph Hellwig wrote:
> >>> I think this subject line here is left from an earlier version and
> >>> doesn't quite seem to summarize what this patch is doing now?
> >
> > How about we just split this patch into 2 patches:
> > part 1 re-org with new helper xfs_configure_buftarg_atomic_writes()
> > part 2 ignore HW which cannot atomic write a single FS block
> 
> Fine with me.  Although just fixing up the subject sounds fine as well.

I don't care either way.

--D

