Return-Path: <linux-fsdevel+bounces-10655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D041F84D1EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 20:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8B51C22455
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 19:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26A85281;
	Wed,  7 Feb 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw1PNj2J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C380050;
	Wed,  7 Feb 2024 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332655; cv=none; b=eJkBjPfCFkyx/9iMEJI3OvTQ5D+YX/1sPQA4r2GTIW2kf6RO1+uzBxIDO5OTs+QbbQXmo1RyIM1Yz1d7vC9ukDkF/IKJSD3AhOkf0xZOqfh6ev0NrcHFBLhYTWrePKr3q3DfxPYYVgnXfDkkI93c+x+23Si9Ld4pQvmaZmytbZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332655; c=relaxed/simple;
	bh=1eMoQIwa2v9F1EG4OnTgU45DkG8KXU0lJOhuCKUtpaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1o4K0NeNoJvUU5JiuXUG1zoaEvf22KSrnyyRHrlCp5nZUi0AXN3/+rQVj89+izMAf7Q3F3VAy3KMiCIOrAqIQf/jkP/osETjROHDdlBM2o8zZ3/MzxIoi4kdFids+pzrsDAIHr9vkZD5E5a3wm9eDxtAD5t/NMiPj9FMqqHU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw1PNj2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360BAC433C7;
	Wed,  7 Feb 2024 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707332654;
	bh=1eMoQIwa2v9F1EG4OnTgU45DkG8KXU0lJOhuCKUtpaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dw1PNj2JwItoT+3D9hyvFIPIS+84+F4sljILJ2R6pOzHBaf4n34CiMi04rSr0MVlT
	 6l2C1boXR6XQHK9XSRBs/nYGefkbidvcF2o2wW5lLaDrfOnedr8DN9PbiS621nsUAN
	 zJ23Es244HUuvCxr86cSgIe8QtVZ2iBJjSHnXEVWJMbfBHsl3MOJiq347gqGmBp4rE
	 wwOaFTAws8Sc7La3ricgbvn93g6wYX4Cu7q9MK0Kt7INR1SAnwA4KGoOG6CHlUOcgQ
	 fkyc5GvF1EDUJm3Us8rNjObxRDXFIf/MV+wTjIhM7249UXqW0GXeMKoVtl74FqiBuX
	 UyTtp+WW9YHng==
Date: Wed, 7 Feb 2024 11:04:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org,
 brauner@kernel.org, edumazet@google.com, davem@davemloft.net,
 alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, weiwan@google.com,
 David.Laight@ACULAB.COM, arnd@arndb.de, sdf@google.com,
 amritha.nambiar@intel.com, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS
 (VFS and infrastructure))
Subject: Re: [PATCH net-next v6 1/4] eventpoll: support busy poll per epoll
 instance
Message-ID: <20240207110413.0cfedc37@kernel.org>
In-Reply-To: <20240205210453.11301-2-jdamato@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
	<20240205210453.11301-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 21:04:46 +0000 Joe Damato wrote:
> Allow busy polling on a per-epoll context basis. The per-epoll context
> usec timeout value is preferred, but the pre-existing system wide sysctl
> value is still supported if it specified.

Why do we need u64 for usecs? I think u16 would do, and u32 would give
a very solid "engineering margin". If it was discussed in previous
versions I think it's worth explaining in the commit message.

