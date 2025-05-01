Return-Path: <linux-fsdevel+bounces-47808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6B1AA5A55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 06:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0034E2891
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A3F231833;
	Thu,  1 May 2025 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFJLQ49L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE754C85;
	Thu,  1 May 2025 04:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746073912; cv=none; b=MuwVguqV/dRLRcSAmT2SfAZ6JuGjVdDiSKsqm3W8b4N8IWofVfY+kHYVExiFgcEvdjWsa9vG1NSf4wczdTpE95SEsCtlF4GPkqIpBVSMPnRtcVEzSrkdJtu7o2UOeP8m1mvxT/NY84j3LEfC95KYGHXcJ5OhjpYlVgLmMaT4qos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746073912; c=relaxed/simple;
	bh=ZDNOHwwoAJLUr3IglTZ4hdSkQXIS1WA8o0QxHP5PN1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP9kn3wUQg5dQNCQSapHTGucBtXuDa2OXe0rQ/aXkPnpl97r9ETYsdgBXRPUcus4XBeVU/ZVY5J2ZUp3EfThZdHXCcgIs77kXuWDOedXC4gRCC97EZwRrGgRo5T3WJHe+CKY4DqMg286CrHyo/aDt09Hh77k68OZmftWhnaor8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFJLQ49L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9B8C4CEE3;
	Thu,  1 May 2025 04:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746073911;
	bh=ZDNOHwwoAJLUr3IglTZ4hdSkQXIS1WA8o0QxHP5PN1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFJLQ49LIWnXzJdisjZQ5wh1eua1xlS9w9mPEo4juI8L2W1kIDtBaFVQor53O6F9P
	 fAn9oNYkspleX9oGaKCWAFq+84+RPDGncE3wlV+5UznkIu8LXDdPmJJ4QUHf0dVfiz
	 uQmzmQg0wWIqRdajTJVEWubyzIk/Yu4BinByMGLgFqhM8nG9vpxasPXbSIU0lWbbGA
	 65Q+yQGK6j1AFLixplo68CKnDP0qlpL7JT1xviSv68a6jUatDhenHtgp5+den8ILw6
	 ce45e5tI3PNwTo0gHyWSQPCDTa9rS8iNvJTKaQ+2H7sdFjxZPABkyX4AhGdbGTMw2T
	 IawbhBPm6CNIw==
Date: Wed, 30 Apr 2025 21:31:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org
Subject: Re: [PATCH v9 00/15] large atomic writes for xfs
Message-ID: <20250501043151.GE1035866@frogsfrogsfrogs>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
 <972bd2fc-4dc9-42d5-ab05-dab29fd0e444@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <972bd2fc-4dc9-42d5-ab05-dab29fd0e444@oracle.com>

On Wed, Apr 30, 2025 at 03:14:04PM +0100, John Garry wrote:
> Hi Christoph,
> 
> At this point, is your only issue now with
> 05/15 xfs: ignore HW which cannot atomic write a single block
> ?
> 
> I am not sure on 15/15...

This series still needs reviews of patches 2, 3, 5, and 15, if I'm not
mistaken.

--D

> Thanks,
> John
> 

