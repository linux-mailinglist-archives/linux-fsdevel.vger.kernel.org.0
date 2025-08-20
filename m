Return-Path: <linux-fsdevel+bounces-58360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCAAB2D36F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 07:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196763B7400
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 05:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6436D283FEB;
	Wed, 20 Aug 2025 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9MlNIAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94E42A8C;
	Wed, 20 Aug 2025 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755667245; cv=none; b=H2tSkzZMGpxDXJ7Wu+QdTFuy/Vi95tmYHxqh+tyNSelvraK9dIQakVRG6n1bPGUs9Fu9RjhMoRjlOu+Q6ra1o/BRBh55IDI1z7KUFmk4Uz2EyrGh708ZepHlh6Bq0/ik8halK3y1nNP05BHyAxuU7cjeHkO+CoUAklXSl61Pjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755667245; c=relaxed/simple;
	bh=xsYzyo01FebGnDxxfqBHAy+cxw9XljjmiKymC0b4Agk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf2FTJfXUtfWVe2XNeZazmkwqUA62n7Aaq3UnRN2Ob1qzpvIz2TVuHWPnZo+KZ3sGDD/SQh/yRGTHFE6s8HhyDcrpZMcmtZq+lA+8NQ6jLneAhgBZICtZswyf817WSaZp1Zypivab4XWxIg/Lse3A3LkeVqwF0O/O6ANu+ksfiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9MlNIAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE4CC4CEEB;
	Wed, 20 Aug 2025 05:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755667245;
	bh=xsYzyo01FebGnDxxfqBHAy+cxw9XljjmiKymC0b4Agk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9MlNIAIaB1X/8UqXSthhxTu7vHDHg1QnhuA82Wu+mSIcpMcJFHBMvX8cOlOAOHOu
	 yHPaFlMNK0UaiCp20Tdlwm4PHDIRh3x3kaeHlHFpmvWAWQME37lTbozlUjiQeuLBBT
	 eUlNQvq3eFexyvTBki9bUUuU+kNfybcIhGGIMXpfbv9gYxF5MAABXQL0YLDsXPFcYh
	 WvWRSb7yMu/xvbHeRHJWch7ENoFBGN57/uyfKfoFsyW1iKrkimtRSCf3TX75JGRKhN
	 ih8VZqjL+/fwVeF63N7OSF9n1rDARKIRl5Vyz+VCnwQypC1VaffIHwca1GJCfPh6Bo
	 xkm4SXhqiFCZA==
Date: Tue, 19 Aug 2025 22:20:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: clarify extending writes handling
Message-ID: <20250820052043.GJ7942@frogsfrogsfrogs>
References: <CAJfpegsz3fScMWh4BVuzax1ovVN5qEm1yr8g=XEU0DnsHbXCvQ@mail.gmail.com>
 <20250820021143.1069-1-luochunsheng@ustc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820021143.1069-1-luochunsheng@ustc.edu>

On Wed, Aug 20, 2025 at 10:11:43AM +0800, Chunsheng Luo wrote:
> Tue, 19 Aug 2025 16:07:19 Miklos Szeredi wrote:
> 
> >>
> >> Only flush extending writes (up to LLONG_MAX) for files with upcoming
> >> write operations, and Fix confusing 'end' parameter usage.
> >
> > Patch looks correct, but it changes behavior on input file of
> > copy_file_range(), which is not explained here.
> 
> Thank you for your review.
> 
> For the copy_file_range input file, since it only involves read operations,
> I think it is not necessary to flush to LLONG_MAX. Therefore, for the input file, 
> flushing to the end is sufficient.
> 
> If you think my understanding is correct, I can resend a revised version of
> the patch to update the commit log and include a clear explanation regarding
> the behavior changes in 'fuse_copy_file_range' and 'fuse_file_fallocate' operations.

I don't understand the current behavior at all -- why do the callers of
fuse_writeback_range pass an @end parameter when it ignores @end in
favor of LLONG_MAX?  And why is it necessary to flush to EOF at all?
fallocate and copy_file_range both take i_rwsem, so what could they be
racing with?  Or am I missing something here?

fuse-iomap flushes and unmaps only the given file range, and afaict
that's just fine ... but there is this pesky generic/551 failure I keep
seeing, so I might actually be missing some subtlety. :)

--D

> Thanks
> Chunsheng Luo
> 

