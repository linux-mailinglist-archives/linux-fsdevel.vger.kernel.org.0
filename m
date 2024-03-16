Return-Path: <linux-fsdevel+bounces-14551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB5B87D8C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 05:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2111F21A8C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 04:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1945667;
	Sat, 16 Mar 2024 04:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7LR1jiG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F67C3FC2
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Mar 2024 04:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710563923; cv=none; b=Mr5u27oerFYI+7qAuaeXMdtO+6at+05lENjxcvL2TtZgFwb976w0vCXKm9OVok3Mc8AGORYQ31/hOVsxrd0DZ7tktB3E7yupqBPE7nMDnqGQq7+zGS7cJbAZaEUmRgJdJv13inpM1JVFF5EiPTFmJSDXE/cekyX6ZRQEMzMbi0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710563923; c=relaxed/simple;
	bh=tvOC1LQNoBNXZzBXzLkPtgJ0WJjzmczTYhpL5+8oHh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9EqCqbekdfGVj84IzYPNd5qve1INmZzmUKaHJSGZfJeyTqPBW5ZSt+BbJ1uuQkOIyGlTcmt6Uk/+2ayJbx0L+eW72blH67eRbsA2g/LXkpgRB8yGO4RqwKUU0QGe0lbIRDb0psxa/Mnmq4HQvncg0sfA5iiO2M6c8O3nV5nTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7LR1jiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6A2C433F1;
	Sat, 16 Mar 2024 04:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710563923;
	bh=tvOC1LQNoBNXZzBXzLkPtgJ0WJjzmczTYhpL5+8oHh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7LR1jiGmldhrm0/Pv9N/t5Xc355i/eDADT1qLwjgbLI6lmRRTAGXsFyJkNKXwvvr
	 NV9zVa3fhZXT2x6hhaVYahuVV5VcrbPvmDHxmlMofuoanXLDFmbsAJeM1grJgdj5Pz
	 4Aud5buWoDSTm98oHPwiWAbcgU3QCQNecVhm5IfIWgfVMZ0/dCbOjuaZLcHvlzyskU
	 r+qqirI9h4JemRLJTiC5t3II2YoTtpVmE9p68SeBF0bIApAbe862kzvl6rvKpyhB6P
	 c5sLUbXq9AtimT5Xv7z/ZkbHP4b4wQIXRBkRKqHWTGc8KQCax9Q6qg9i/u+4EahOSw
	 szXQn7PaUQ9Xg==
Date: Fri, 15 Mar 2024 21:38:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Phillip Susi <phill@thesusis.net>
Cc: Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: Uneccesary flushes waking up suspended disks
Message-ID: <20240316043842.GR6184@frogsfrogsfrogs>
References: <877cieqhaw.fsf@vps.thesusis.net>
 <Ze5fOTojI+BhgXOW@dread.disaster.area>
 <87h6h78uar.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6h78uar.fsf@vps.thesusis.net>

On Fri, Mar 15, 2024 at 10:05:16AM -0400, Phillip Susi wrote:
> Dave Chinner <david@fromorbit.com> writes:
> 
> > How do other filesystems behave? Is this a problem just on specific
> > filesystems?
> 
> I finally got around to testing other filesystems and surprisingly, it
> seems this is only a problem for ext4.  I tried btrfs, f2fs, jfs, udf,
> and xfs.  xfs even uses the same jbd2 for journaling that ext4 does
> doesn't it?

No, xfs has its own logging code.

> I just formatted a clean fs, synced, and ran blktrace, then synced
> again, and only ext4 emits a flush on the second sync.

Heh.  Maybe we should deprecate ext4 then? :)

(Just kidding!)

--D

