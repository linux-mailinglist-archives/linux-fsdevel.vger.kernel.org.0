Return-Path: <linux-fsdevel+bounces-19370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478508C41AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC38B23BCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C9F152171;
	Mon, 13 May 2024 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="IifgAf4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9959164
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606318; cv=none; b=Hue1deEPeSHIxz0wKGjj9mSHKJUl+dx9pf6/A5X66e9iuPNf109aAs7sm4oo/iH2zo4GR0gAF/u7Zvxf7nTTKia2eoLo3MFVhh109B+2FssA6fPtWm0xk8bgJKcjpIJjHAayQypvb7ZLXcShKJjWozSSCJIT5hMZMDIuTiW55dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606318; c=relaxed/simple;
	bh=8PhTGRjd8+6GJDfeREoG0YGtQsybA/R0fey74tXJ3VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHcc+8EaB4JG8WAIwDGPCbLKLZoJ778Vb9Ii2tzHsh4Q95DgpqKkA5xSu5OMuXgxKBGJLVKHDkKTEJapNfj8bu0kAgoVBi3dSQbiP5+zh2LQWDxXscXvbM+WMAue02h5SotKYZ5jg+RHHuLgwlN+8RXWTvVh9GyWbKDt1Hl+srE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=IifgAf4f; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([50.204.89.32])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44DDHsBl000516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 09:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715606277; bh=fusCymI4GhBy81z2Xc6g11DY96LNc+EefUe6nehYSRU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=IifgAf4fU1FayX/7K8/8GofW+2BjfJgpnpnyO74mQZwA5fUCxtF27onioRAvtS3JS
	 2xADWgLG1Im7FPtrcOaXmQHVykmy0yzQ7pvAeu592lUAeDz9CAjKxCb6QkM0y5Mvbf
	 Z3uBx7iwWZQV4EJzID9rwvhc3pZQaefWZcJCMExD+eBN7QgLJLxiA3JHDf+Orjgh3K
	 XcNWCslc8L55q207Rg8qypvcE5wXldh9JKkzMqq+CSp+C2aNI74xl0M6+Nd/5QVWbz
	 MrO7VDWEvv5+Hrqknb6OVuYtgpgWFBSmlS5NP0P2q2n3A18Wv7lMFmwh8aoVGH/rGt
	 Y6A07YGUjiDYw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id AA89F340269; Mon, 13 May 2024 09:17:53 -0400 (EDT)
Date: Mon, 13 May 2024 07:17:53 -0600
From: "Theodore Ts'o" <tytso@mit.edu>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Steve French <smfrench@gmail.com>, Amir Goldstein <amir73il@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "kdevops@lists.linux.dev" <kdevops@lists.linux.dev>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: kdevops BoF at LSFMM
Message-ID: <20240513131753.GA520598@mit.edu>
References: <CAB=NE6XyLS1TaAcgzSWa=1pgezRjFoy8nuVtSWSfB8Qsdsx_xQ@mail.gmail.com>
 <CAOQ4uxigKrtZwS4Y0CFow0YWEbusecv2ub=Zm2uqsvdCpDRu1w@mail.gmail.com>
 <CAH2r5mt=CRQXdVHiXMCEwtyEXt-r-oENdESwF5k+vEww-JkWCg@mail.gmail.com>
 <E2589F86-7582-488C-9DBB-8022D481AFB3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E2589F86-7582-488C-9DBB-8022D481AFB3@oracle.com>

On Wed, May 08, 2024 at 05:54:50PM +0000, Chuck Lever III wrote:
> 
> In my experience, these require the addition of a CI
> apparatus like BuildBot or Jenkins -- they are not
> directly part of kdevops' mission. Scott Mayhew and
> I have been playing with BuildBot, and there are some
> areas where integration between kdevops and BuildBot
> could be improved (and could be discussed next week).

This is support which gce-xfstests has.  You can either have it watch
a particular branch on a git repo, and whenever it changes it will
kick off a tests:

   gce-xfstests ltm [-c <cfg>] [-g <group>]|[<tests>] ... [--repo <url>] \
      --watch <branch>

As an example:

   gce-xfstests ltm -c ext4/all -g auto --repo ext4 --watch dev

Or you can specify a specific commit that you want to run tests on:

   gce-xfstests ltm -c ext4/all -g auto --repo ext4 --commit dev

In the two examples above ext4 is an abbrevation so you don't have to
type the full URL; you can define additional abbrevs in your config
file.

> > 3) make it easier to auto-bisect what commit regressed when a failing test
> > is spotted
> 
> Jeff Layton has mentioned this as well. I don't think
> it would be impossible to get kdevops to orchestrate
> a bisect, as long as it has an automatic way to decide
> when to use "git bisect {good|bad}"

gce-xfstests has this as well:

    gce-xfstests ltm [-c <cfg>] [-g <group>]|[<tests>] ... [--repo <url>] \
        --bisect-bad <bad_rev> --bisect-good <good_rev> \
        [--bisect-good <good_rev1> ...]
    
So yeah, not that hard --- we had intern learn how to program in Go
and to implement the base lightweight test manager, and a team of
undergraduates who implemented the build server, test spinner, and
auto-bisector as part of their software engineering classes's project.  :-)

The code is up on github at github.com/tytso/xfstests-bld if anyone
wants to repurpose it.

	      	      	       		- Ted


