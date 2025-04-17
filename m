Return-Path: <linux-fsdevel+bounces-46602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4959FA911D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 05:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA697AE2FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 03:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2739C1B393D;
	Thu, 17 Apr 2025 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mbz6xsi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F589EAE7;
	Thu, 17 Apr 2025 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744858904; cv=none; b=dWKKMAlGZN9ekrcvPrk8e3L9f95wJkBX4Ydw4AJ5jsNBMFKs0u6XNuGiZrhYiEUxck852DPvCxd1cgdZkL9j4eioJULR4sL4/eIJZBq1bwofEOJT6Rj4XdqbyF+6K19a+uhsCtFMCRaf4jbyhbES/d0CdUmXeZO5/4gGZBlvvdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744858904; c=relaxed/simple;
	bh=YQ3n6r+nEiZ2nPmGKrTfCE32r2QocRbAL/UULZP0GUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPLEj2J9qnSb9lk81petzjUqoSVHCGwla5u5kLRzM89sjnXI1+9EvkpiytbeMEi0kJeeIG2dPey0boTdCGxv/DG8F6ou1oDCnokm/VSEKVXkmZ7/o4qjQhnOJJn15DA85OAyRAIDk8GAePYA4sedMz6jj4inFI/jT+bmhZrFiZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mbz6xsi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54942C4CEE2;
	Thu, 17 Apr 2025 03:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744858904;
	bh=YQ3n6r+nEiZ2nPmGKrTfCE32r2QocRbAL/UULZP0GUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mbz6xsi3MB9Npu5oHVSzi5bd/Rw59mk1gAxsA6LXZv7s+UzZI1b43NheMod/exF/E
	 p0G99l6XKS5QIPrs4SNl0ULGT5n+53zkA2dxI3yyfEiBRWgYbPEwRvoE0Cftxo9fVj
	 sg0H5/ha3Aw2aybHnOV24+Vvy3Zlmpt/BQcs8nPsn5q/hQp451IwX9O117Mpn2qHgq
	 9YZO2zu58UM5WRog5JSj7TSFx4YHgLVdaQ5fTShDLMN7TVrBVXSLXalasVD8CPq2TB
	 sk7yU5MiE1LRTeCcEt1cziHyJXLioiwTH9gZF/oCxoGkQWjjxAGubvfYB+KCSxkkE8
	 kaKKIBpoAR54g==
Date: Wed, 16 Apr 2025 20:01:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-xfs@vger.kernel.org
Subject: Re: [6.15-rc2 regression] xfs: null pointer in the dax fault code
Message-ID: <20250417030143.GO25675@frogsfrogsfrogs>
References: <20250416174358.GM25675@frogsfrogsfrogs>
 <aAAYK_Fl2U5CJBGB@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAAYK_Fl2U5CJBGB@dread.disaster.area>

On Thu, Apr 17, 2025 at 06:50:51AM +1000, Dave Chinner wrote:
> On Wed, Apr 16, 2025 at 10:43:58AM -0700, Darrick J. Wong wrote:
> > Hi folks,
> > 
> > After upgrading to 6.15-rc2, I see the following crash in (I think?) the
> > DAX code on xfs/593 (which is a fairly boring fsck test).
> > 
> > MKFS_OPTIONS=" -m metadir=1,autofsck=1,uquota,gquota,pquota, -d daxinherit=1,"
> > MOUNT_OPTIONS=""
> > 
> > Any ideas?  Does this stack trace ring a bell for anyone?
> 
> That looks like the stack trace in this patch posted to -fsdevel a
> week ago:
> 
> https://lore.kernel.org/linux-fsdevel/20250410091020.119116-1-david@redhat.com/

Ah, thanks.  Will try that patch out.
--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

