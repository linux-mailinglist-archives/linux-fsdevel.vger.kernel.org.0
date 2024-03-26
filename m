Return-Path: <linux-fsdevel+bounces-15353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AFE88C6BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 16:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F8A320558
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D740513C82B;
	Tue, 26 Mar 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNcOZ0TX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628F58220;
	Tue, 26 Mar 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466549; cv=none; b=GsDWE7h62et0uwZY/XQU+i413/8BtNNdJt0DR0pTrOBSc6PP8GeUi0wHCPUmidb9PatBCBavF+lrmI6ZfYyMO/8eJCkA0dyl+rKtPtLdpqVA22nyBYszAkbCN4cUrty9bB85LK2H/IJQFfsQWDbj6q9pmr8uzmmt6SEI6zAyjNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466549; c=relaxed/simple;
	bh=ANF//h4LPnYK7Djd4mKh0asA8VARUBkQkFQlNgabfis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8ClPd66kkaW0jimFlHCa2LjlL7R5yraSYuBaAALNDNRvGLXf5btrgJpYtt4o3X8NsVENyhJZuYmZrjv5jXdi3fYoL5ezzr7/c1xDog/J/0euvXvq+Xx0kgIJebGj/8OkG+0ftfyt5lfuDld2VexjIdT+t+8eZgz01v5szs7sgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNcOZ0TX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0266DC433F1;
	Tue, 26 Mar 2024 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711466549;
	bh=ANF//h4LPnYK7Djd4mKh0asA8VARUBkQkFQlNgabfis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNcOZ0TXcjEkJtIq7KtpyRbx6DDIvwGgULe6ixp2wDu8L40hNxC+JeqfeqPJLzAHg
	 0XNsnlZ7E4fmGlyBtg6ZO2Cw3CkqQ1ffyt5Gq0n9NlJ9KOEKglCIQn0mSqPmfsox7K
	 2RAx90Sm04ZWwIecTWDDM77+rvBPODOvFaG3S+YO3u5RqVMiGkoupRVuSRn1mW9OSN
	 CVtgSGin7l77/WPpX1odsfB4XGvDj/T85oZZd+OWkw7XR42hA7Nvvok34QBOJC/mFi
	 MQoTv7vb6md2YrwjEKoWxYC5Bgs+VGBbsoQBN5Ibfah1daY2E3XzyjWjUUgLjO4Lzm
	 Ak51LXqcfrd+g==
Date: Tue, 26 Mar 2024 08:22:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	kernel test robot <oliver.sang@intel.com>,
	Taylor Jackson <taylor.a.jackson@me.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	linux-fsdevel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
	fstests <fstests@vger.kernel.org>
Subject: Re: [linux-next:master] [fs/mnt_idmapping.c]  b4291c7fd9:
 xfstests.generic.645.fail
Message-ID: <20240326152228.GC6379@frogsfrogsfrogs>
References: <202402191416.17ec9160-oliver.sang@intel.com>
 <20240220-fungieren-nutzen-311ef3e57e8a@brauner>
 <20240325165809.GA6375@frogsfrogsfrogs>
 <20240326-dampf-angemacht-35d6993d67fa@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-dampf-angemacht-35d6993d67fa@brauner>

On Tue, Mar 26, 2024 at 12:43:27PM +0100, Christian Brauner wrote:
> On Mon, Mar 25, 2024 at 09:58:09AM -0700, Darrick J. Wong wrote:
> > On Tue, Feb 20, 2024 at 09:57:30AM +0100, Christian Brauner wrote:
> > > On Mon, Feb 19, 2024 at 02:55:42PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > kernel test robot noticed "xfstests.generic.645.fail" on:
> > > > 
> > > > commit: b4291c7fd9e550b91b10c3d7787b9bf5be38de67 ("fs/mnt_idmapping.c: Return -EINVAL when no map is written")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > 
> > > The test needs to be updated. We now explicitly fail when no map is
> > > written.
> > 
> > Has there been any progress on updating generic/645?  6.9-rc1 is out,
> > and Dave and I have both noticed this regressing.
> 
> Iirc, Taylor wanted to fix this but it seems that hasn't happened yet.
> I'll ping again and if nothing's happened until tomorrow I'll send a
> patch.

Ok, glad to hear that this is still on your radar.  Thank you for
following up!

--D

