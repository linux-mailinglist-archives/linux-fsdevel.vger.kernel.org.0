Return-Path: <linux-fsdevel+bounces-27518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D1961DC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 06:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBD528545B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3743914A4C7;
	Wed, 28 Aug 2024 04:51:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C33D96A;
	Wed, 28 Aug 2024 04:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724820678; cv=none; b=I+8usyYxTBwzg0T/3isoeMOfpnborwCUQdUljGlyN2pjriuJdi77NUy4euQ7xb7M5G5WN8wVlDuStu/VH2Huxbc6CZkolEtEzQNrFLlRIg6wh5+GYlqKA4hVeQwOpg+cNV9v853y4el+ltqThzLIX1uVIHPXWv79zETrs4x+d6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724820678; c=relaxed/simple;
	bh=KBx6obOq/6dkHGv0rTLRmF33cSerMRqjj+i6Suu7n5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/ARYl7h8SpcTee3a4tXr8Z6Veo4XOxP8Qwnsd8Lwec7PPtcZ5p/GBJyFwpbRAyZwbRaBjMV0AYsT7zLUztrJfE3YSyqO0A0/zrjkUVkfeeKnPch1j70yf6a8eMCZuo6E7Bc0b9g9CEFmRBRtV/mP2zExLKtg8c4BQon1GhT8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B0062227A88; Wed, 28 Aug 2024 06:51:13 +0200 (CEST)
Date: Wed, 28 Aug 2024 06:51:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/10] iomap: zeroing already holds invalidate_lock in
 iomap_file_buffered_write_punch_delalloc
Message-ID: <20240828045113.GC31463@lst.de>
References: <20240827051028.1751933-1-hch@lst.de> <20240827051028.1751933-5-hch@lst.de> <20240827162804.GY865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827162804.GY865349@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 27, 2024 at 09:28:04AM -0700, Darrick J. Wong wrote:
> On Tue, Aug 27, 2024 at 07:09:51AM +0200, Christoph Hellwig wrote:
> > All callers of iomap_zero_range already hold invalidate_lock, so we can't
> > take it again in iomap_file_buffered_write_punch_delalloc.
> 
> What about the xfs_zero_range call in xfs_file_write_checks?  AFAICT we
> don't hold the invalidate lock there.  Did I misread that?

No, I think you're right.  My testing just never managed to hit a short
zero while doing the write prep.

I guess I'll need to do something more complicated than the zero flag
then. I initially added a new flag just for that and then (wrongly as you
pointed out) that I don't need it after all.

> Also, would nested takings of the invalidate lock cause a livelock?  Or
> is this actually quite broken now?

It is a cold, hard deadlock.


