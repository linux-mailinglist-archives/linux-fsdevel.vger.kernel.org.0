Return-Path: <linux-fsdevel+bounces-12560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B3E8610DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 12:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B071C21C7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 11:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1407A722;
	Fri, 23 Feb 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrtCsKVY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F49042AB1
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689383; cv=none; b=EkY+7BFOS9v9VTUSn7LCSB5W1HR4x6aFz9Q5HPKduJ/bpo/9DpY/fo+rFokWadePcS1N73j6jwyJxM614nbZb/KUJawjiMss1D8kkQ6OOewJq2klOPE9HMssSlGptCHD+ARDozU2a7NUfzEnX1ETOnzgPm1o/XbkGx9n1zkLobY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689383; c=relaxed/simple;
	bh=TWGldSYW08LYgTHxHn6krdmnAYcbKIdgka9kRcLbGQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYb+zJXL3XxwAGLdficEo4f5CUvYgLAI4G7gGFrp1veDyedG6qShqRia9jcGvES5DeV+Jc+MMVLLnFKZQQtDR89T+FlYtYctQzMG/z1Ew3QnfMV+88XuR94ZS590kHSLXTp0DUkD50AznHs+DJEuJ39peIRsSDh3AH852u4y0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrtCsKVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190CDC433C7;
	Fri, 23 Feb 2024 11:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708689382;
	bh=TWGldSYW08LYgTHxHn6krdmnAYcbKIdgka9kRcLbGQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RrtCsKVYWgCgDDVCsAuX1pfUyn/Z4CkzISaZQvkDJu11tvBGciRhIOzrB/6ZG8hT2
	 fTfheVDf0YTs7HQFvxIXyCAZYpRkkc4LSeiMhT0lVIAZ8dgfFcCRjtyJjiPZd+6tl4
	 tanWbeBeqDLZIXvtw9fFruJe/knIfQc9QKCyGpkUkL1XBXn6e3lbirH8tdpfUXibsm
	 cS3+1kQC4e316WUb+ws/rX+PN7HJmPn07nuXldb2dXbTHeMgxSq82SuRlPnq1NHkUn
	 mw6Hn/mQ573wVThqeFSTPeWSwz+Q5TithgMXYdyp6R08dB9zGViiWYmlPa2ApJQZVO
	 JcEmo6vvDK7yQ==
Date: Fri, 23 Feb 2024 12:56:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240223-gaspipeline-oberdeck-49040b9cb4c4@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223101833.16153-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240223101833.16153-A-hca@linux.ibm.com>

On Fri, Feb 23, 2024 at 11:18:33AM +0100, Heiko Carstens wrote:
> On Thu, Feb 22, 2024 at 12:03:34PM -0700, Nathan Chancellor wrote:
> > Apologies if this has already been reported or fixed but I did not see
> > anything on the mailing list.
> > 
> > On next-20240221 and next-20240222, with CONFIG_FS_PID=y, some of my
> > services such as abrtd, dbus, and polkit fail to start on my Fedora
> > machines, which causes further isssues like failing to start network
> > interfaces with NetworkManager. I can easily reproduce this in a Fedora
> > 39 QEMU virtual machine, which has:
> 
> Same here with Fedora 39 on s390 and next-20240223: network does not
> come up.
> 
> Disabling CONFIG_FS_PID "fixes" the problem.

It's Selinux. See the other reply. It's already tracked.

