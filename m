Return-Path: <linux-fsdevel+bounces-25625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CAE94E512
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7F61F212C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39838136328;
	Mon, 12 Aug 2024 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BikFb0wJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B3912C486;
	Mon, 12 Aug 2024 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723430452; cv=none; b=cHD8Zks7+gNghk5XtyFbIioXG5N4FshDQ4zB96e0/GAPl52O2U/C9ojSvjq2+MwaBCr6XdszmNvjuOo3dAllrkFk6pIVz/MOk+ThhKvSp9/vb7JNuBNxeULkxQxEAsJ+iAbawXE4V0STcK03rwNHVdIooq6RlLeu28GV1kITvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723430452; c=relaxed/simple;
	bh=T9Yld2q72WF/ECrqdIH1NemhWrlLZZCEYX8teec6w+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1BRzVVLQIwgV/9GKMOqIs/5nxQTadZwGaPEBcgw7aXc/qd0hZ+nyjs1tO5OyWdz+gFdaYNAdEw/UVR4eb/84o5O1qFsTAlKTYjldf4acXIyKg9haqbXqht7QD7/xFEOJk3cpS3EJkPCmnnR9bbqpIu1YavOcc6uZVvXFvXcrxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BikFb0wJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pgEtrVlv/kMeVCF2Dckbik9jinBIaKG6z7DYc+o7tA0=; b=BikFb0wJzI7QGfvQ7U+WjUOj0F
	DTCU6hR2MVlPl9mYLkM9LnjjnmyjBnq+BkpbFfu4KAymljFCn470jRmj3jwuh+S6Yw0TYnyEtKV/H
	GscMO7INLg4945eIBZ3vvn0qrc18D+f6Sn3laNS6ziz++XT8LTudAqxhfpQKGG8sKsKJhNQRyKwcG
	6Cy/vUNXhHIHqMz1olckuoNXKjzZu3c0+QmJB2YUW4yW65rCFSFvgfvGrAD8tyVZzietf617lrZr3
	fLOtbyo/vs7/pFBh1yseYX4iwmrNQVwK53yLwr9mJlp85dN1b5PWcwXW2eKoru3PmMNAdJA+ieO8U
	6s/eUz7Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdKzE-00000000xdX-0SEF;
	Mon, 12 Aug 2024 02:40:44 +0000
Date: Mon, 12 Aug 2024 03:40:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Ma, Yu" <yu.ma@intel.com>
Cc: Christian Brauner <brauner@kernel.org>, jack@suse.cz, mjguzik@gmail.com,
	edumazet@google.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, pan.deng@intel.com,
	tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v5 0/3] fs/file.c: optimize the critical section of
 file_lock in
Message-ID: <20240812024044.GF13701@ZenIV>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240722-geliebt-feiern-9b2ab7126d85@brauner>
 <20240801191304.GR5334@ZenIV>
 <20240802-bewachsen-einpacken-343b843869f9@brauner>
 <20240802142248.GV5334@ZenIV>
 <20240805-gesaugt-crashtest-705884058a28@brauner>
 <5210f83c-d2d9-4df6-b3eb-3311da128dae@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5210f83c-d2d9-4df6-b3eb-3311da128dae@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 12, 2024 at 09:31:17AM +0800, Ma, Yu wrote:
> 
> On 8/5/2024 2:56 PM, Christian Brauner wrote:
> > On Fri, Aug 02, 2024 at 03:22:48PM GMT, Al Viro wrote:
> > > On Fri, Aug 02, 2024 at 01:04:44PM +0200, Christian Brauner wrote:
> > > > > Hmm...   Something fishy's going on - those are not reachable by any branches.
> > > > Hm, they probably got dropped when rebasing to v6.11-rc1 and I did have
> > > > to play around with --onto.
> > > > 
> > > > > I'm putting together (in viro/vfs.git) a branch for that area (#work.fdtable)
> > > > > and I'm going to apply those 3 unless anyone objects.
> > > > Fine since they aren't in that branch. Otherwise I generally prefer to
> > > > just merge a common branch.
> > > If it's going to be rebased anyway, I don't see much difference from cherry-pick,
> > > TBH...
> > Yeah, but I generally don't rebase after -rc1 anymore unles there's
> > really annoying conflicts.
> 
> Thanks Christian and Al for your time and efforts. I'm not familiar with the
> merging process, may i know about when these patches could be seen in master

It's in work.fdtable in my tree, will post that series tonight and add to #for-next

