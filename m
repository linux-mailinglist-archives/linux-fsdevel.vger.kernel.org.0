Return-Path: <linux-fsdevel+bounces-57930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C9B26D74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B925C7791
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798AD233722;
	Thu, 14 Aug 2025 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAIl1XhD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7DC20298D;
	Thu, 14 Aug 2025 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191983; cv=none; b=upNQ1K216ohOiaLHDeqQ9vKnM84qTaKjMLNNrAiVcVO5GCXXHwodN9i8Vef4h2p+OWYw0+nBPWD5E7LcLlQRtydhGkct1Fj0f6l9T4xIvQw1ERUliM2mmE/gPkrwE5zmmT0ZgJhIafgAwg+FLHUezWrPVPkGWDI1SDw57PEp8pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191983; c=relaxed/simple;
	bh=IFafzpayfaPkdGpJ1GtHgExVV5V7zc9Jcmdm1ZW+Jck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUo8cmiUM0hO7qcB6kID3mG10bpNn+kRV46MRHjsrWLi2x+ATtZwGLmlg3oQfvS++zNpNukkTtkZKcbOjU8NNeIYAmmutsR31p4Ifj7VD4R/aLZGVh1GyBxtyOAL4dgaRuuRFETJVU2D0msnM3KqzgIFPBj4qUKhqC9eTv26kig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAIl1XhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B809C4CEED;
	Thu, 14 Aug 2025 17:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755191982;
	bh=IFafzpayfaPkdGpJ1GtHgExVV5V7zc9Jcmdm1ZW+Jck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAIl1XhD/dwGVguLT7QUA0xT3pHiwW6jTWLwC4UaCStiMSMO2wqT+QkJkc1EAy/jf
	 VF3ifXD1d10MIhzPQMUFRxh7iC3rTbfqzctyd6ggUbYJNQ/mnJ7mXpyrxX1CKwMpU5
	 mXlilT2kfIFLwwfTCOwElE2xGOA7yuFyHWngfuwkELMy9K4ldkXm5bWRQZcIoAxza8
	 6TKjyNyQBqDMNW5fPrY8ab6mbFAl8HSsFxT54GDT39x+9B+tA0RnLessSz6OBfuhug
	 //2QlgFN4GpBRVwpxAVAfLdejs2WPQRCsynfUANFq/k+EV67krLc8hbr3GnZ9d7tpg
	 rRWMzT/4uJCjw==
Date: Thu, 14 Aug 2025 10:19:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
Message-ID: <20250814171941.GU7942@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-15-john@groves.net>
 <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com>

On Thu, Aug 14, 2025 at 03:58:58PM +0200, Miklos Szeredi wrote:
> On Thu, 3 Jul 2025 at 20:54, John Groves <John@groves.net> wrote:
> >
> > * The new GET_DAXDEV message/response is enabled
> > * The command it triggered by the update_daxdev_table() call, if there
> >   are any daxdevs in the subject fmap that are not represented in the
> >   daxdev_dable yet.
> 
> This is rather convoluted, the server *should know* which dax devices
> it has registered, hence it shouldn't need to be explicitly asked.
> 
> And there's already an API for registering file descriptors:
> FUSE_DEV_IOC_BACKING_OPEN.  Is there a reason that interface couldn't
> be used by famfs?

What happens if you want to have a fuse server that hosts both famfs
files /and/ backing files?  That'd be pretty crazy to mix both paths in
one filesystem, but it's in theory possible, particularly if the famfs
server wanted to export a pseudofile where everyone could find that
shadow file?

--D

> Thanks,
> Miklos
> 

