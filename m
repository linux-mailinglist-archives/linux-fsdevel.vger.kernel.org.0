Return-Path: <linux-fsdevel+bounces-10636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E45D84CFD7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 18:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC25A28AD73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 17:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B98289F;
	Wed,  7 Feb 2024 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ElgKNZ5o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304CF82877
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327640; cv=none; b=cRO2DOVvWZIBSYDXl5rIgNGzLbEu/7uYfNU5EdkSxVNxbVAq6IK5+jzKyrV/DkkmNUfqsPC/Lw6szso0m0wsFnoDgWXsR1GRhjC+BkJMq2Np8w/Xh697RdauSQazWWqKVhA+xM/Pv9LeMkTHRO/694HUAbQRaIMYwHjKorRVvC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327640; c=relaxed/simple;
	bh=rpxr7u3oQ1f9tEqbE9lXrYaJvrFwR/A74/ikjVgV3ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWATgqOPHtMZS0WgCMLI6SA2xkHrg8KV021bE6rBA1q4yXNF2iBIi8BDa9ak1KBvmnaKIr6Ro0/JdnoFSoW+ZsDG7uPdmRrjTeO+35x10D15eMe0gFKy8MbhzdkWU2vk42nB/fSvgOQjtRTdxGDGaNQjNSnz80DvrhqwfIKu1F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ElgKNZ5o; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 417HeA6o025052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 12:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1707327611; bh=r9d+Doi+WOPExniXtR89NcGFZiyjO8sS0Kv850JhT+s=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ElgKNZ5oonmgRLpIzI3lEjYU0M4Q1AG+KxP3Hn5nZrqGeeOyYIQI//NCsu4L21v9R
	 i/CWDGDO5QJVbhWmAExjfUSsBfRYu71xyN6qi1miw0pzrzhkot8MVXaaxpK5cvTaMT
	 uUwJpI2inNyLu3pyywvD8/q3vc21Ngn6Zvv2XGnA3KKFlaM3WBQt/3+Eah95gvpxcS
	 qaGB/DG0mgkdEmYoL0AZp0X7Mh91UK8ZNfj2DTY/wYFmbJf9bUIjRKe1B3fJOuCdhP
	 BrsNXho4czpGFJL6BTsOOp6m8uxNgSiY+0fbT9ddo3IYeV9Y2N6jZPebI8LM/JKURg
	 qBZxnLbQDEYYQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C74A215C02FD; Wed,  7 Feb 2024 12:40:09 -0500 (EST)
Date: Wed, 7 Feb 2024 12:40:09 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] filesystem visibililty ioctls
Message-ID: <20240207174009.GF119530@mit.edu>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206201858.952303-1-kent.overstreet@linux.dev>

On Tue, Feb 06, 2024 at 03:18:48PM -0500, Kent Overstreet wrote:
> previous:
> https://lore.kernel.org/linux-fsdevel/20240206-aufwuchs-atomkraftgegner-dc53ce1e435f@brauner/T/
> 
> Changes since v1:
>  - super_set_uuid() helper, per Dave
> 
>  - nix FS_IOC_SETUUID - Al raised this and I'm in 100% agreement,
>    changing a UUID on an existing filesystem is a rare operation that
>    should only be done when the filesystem is offline; we'd need to
>    audit/fix a bunch of stuff if we wanted to support this

NAK.  First, this happens every single time a VM in the cloud starts
up, so it happens ZILLIONS of time a day.  Secondly, there is already
userspace programs --- to wit, tune2fs --- that uses this ioctl, so
nixing FS_IOC_SETUUID will break userspace programs.

							- Ted

