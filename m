Return-Path: <linux-fsdevel+bounces-66618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3320C267E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 18:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85325350D54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CBF3081AD;
	Fri, 31 Oct 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwR8XQCT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEBA2D9EEA;
	Fri, 31 Oct 2025 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761933381; cv=none; b=uahYAWYRsuIWg15IRPXO8f1F9gk4YnvT1LBTSjMmb5FT0s6VNDsjWiQDzADDxKhqdgEc26CXIEJ9GVWCowU3EmpSIvcJtBAkId6sldG5QIchpi1zsThOOjrZ4UkW+CtZouJgpSFa2t16JQKk3G8FeX2wTS+9gYsSF3f9q3R8USc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761933381; c=relaxed/simple;
	bh=H8EOJ2c9jd/Ul9NUBVR9luEIoA6uBvTNnShszv4+CP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzbcof90AYpmTF8poT7iJxtn6CnkyY34GTHi4YcdrbqD2JgPbVBexJib4aP6WwFz9QS5JaouA2sZh7TLLREZvZi12l90/gDl2r9UyzYy4Pm3GTduPUHSQvV7fnWBVWRflUhPZx3pMBRUhNCeb/KA1Zi+hDCsqOvLOJ4sSfAubx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwR8XQCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436F9C4CEE7;
	Fri, 31 Oct 2025 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761933381;
	bh=H8EOJ2c9jd/Ul9NUBVR9luEIoA6uBvTNnShszv4+CP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwR8XQCTNs4U8EsVE1Fg2wPP+weaLRoD6a5DODzvC0Z8NwObu7FkFdEANlXb87c/7
	 hu5yR9UhR1X0JfraXrX+GNRSo6ty+Ex9S1PveeK7iB/8v3AYOy+keSd7jybWdgG2oc
	 ubXLfON/hD43M4BNqjCrmzssfwpimah/k7B0q3YiAdLYlE37JHoh6ALZXGB0ib0EXX
	 i6M3u/646FMz9uf+gNwXBp22GH4lcin2ejyoAHP4WminI+h+TLUWXlivMjp4GlgKUJ
	 qSK3UeqR73ZiyVuQtKfOwtJcT/2nvKka48gWBunYrS2CLjem3cdOcU4N0OUxUtiH96
	 rFsGnhYxPrJFg==
Date: Fri, 31 Oct 2025 10:56:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bernd@bsbernd.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCHBOMB v6] fuse: containerize ext4 for safer operation
Message-ID: <20251031175620.GQ6174@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
 <CAJnrk1YVjB2U6HSHqkjqCc_6i-Vzg+Vmts_KV0yaa3KG6TN3pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YVjB2U6HSHqkjqCc_6i-Vzg+Vmts_KV0yaa3KG6TN3pg@mail.gmail.com>

On Thu, Oct 30, 2025 at 09:35:25AM -0700, Joanne Koong wrote:
> On Tue, Oct 28, 2025 at 5:27 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > At this stage I still get about 95% of the kernel ext4 driver's
> > streaming directio performance on streaming IO, and 110% of its
> > streaming buffered IO performance.  Random buffered IO is about 85% as
> 
> Do you know why this is faster than ext4 sequential buffered IO?

The last time I looked, ext4 still uses buffer heads and 4k folios, even
for regular files that don't have any fancy features.  IOWs, the iomap
port for kernel ext4 remains unmerged.

--D

> Thanks,
> Joanne
> 
> > fast as the kernel.  Random direct IO is about 80% as fast as the
> > kernel; see the cover letter for the fuse2fs iomap changes for more
> > details.  Unwritten extent conversions on random direct writes are
> > especially painful for fuse+iomap (~90% more overhead) due to upcall
> > overhead.  And that's with (now dynamic) debugging turned on!
> >
> 

