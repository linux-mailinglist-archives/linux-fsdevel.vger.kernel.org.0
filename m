Return-Path: <linux-fsdevel+bounces-47920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BB6AA729B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E83B5A0F6E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 12:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C598A248F4E;
	Fri,  2 May 2025 12:53:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9D211A1E
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190389; cv=none; b=MM7cNb2d/gwTQ057vj+2wCE4+iVajHGkhNDizISeQ0xsETetTzA65IcxP3cfb8nI62g7QvWbsQMsH5FxywtOmkZTfjG93C7CaS4YcQFxOWqo7QIv8m3ge0+pv7cjXZPaloutFcxmHlRRIaaa+jncPByQU0A8WJ2iCZ1WRaQT/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190389; c=relaxed/simple;
	bh=d6BIDo5o6v8Og9mlVPWHFnFSpDPq3cOdjoFU7Gr+XSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO27eD5S9KTHHa+pSCFjXoQ8iN7G0EDOOEmzNwGHg79bxWWRs0ae7mkCtDEqyVBXF9aFzpi9gJFfhEE9w082bw/eDZuurVPwk3em2fGCVuZpDQ9BWeg9wxiqzwndNZmsaaqoEJRF44GnuUV91etEzRlJ7Y/wsNFmCparXjviqZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-148.bstnma.fios.verizon.net [173.48.82.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 542Cqu9M008239
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 08:52:57 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0415B2E00E9; Fri, 02 May 2025 08:52:56 -0400 (EDT)
Date: Fri, 2 May 2025 08:52:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?=  [PATCH 1/2] hfsplus: fix
 to update ctime after rename
Message-ID: <20250502125255.GA333135@mit.edu>
References: <20250429201517.101323-1-frank.li@vivo.com>
 <d865b68eca9ac7455829e38665bda05d3d0790b0.camel@ibm.com>
 <SEZPR06MB52696A013C6D7553634C4429E8822@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <b0181fae61173d3d463637c7f2b197a4befc4796.camel@ibm.com>
 <082cd97a11ca1680249852e975f8c3e06b53c26c.camel@physik.fu-berlin.de>
 <72b00e25d492fff6f457779a73ef8bc737467b39.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72b00e25d492fff6f457779a73ef8bc737467b39.camel@ibm.com>

On Thu, May 01, 2025 at 07:48:35PM +0000, Viacheslav Dubeyko wrote:
> > Please note that when you apply patches with git-am, you should
> > always use the "-s" option so that the patches are automatically
> > signed-off with your own email address.

Pro tip: If you are using "b4 am" to download patches from
lore.kernel.org, use the -c option, e.g., "b4 am -c [msgid]".  This
will automatically check to make sure the patches have valid DKIM
headers, etc. and will also check to see if there is a newer version
of the patch series on lore.kernel.org and download it instead.

Another cool command is "b4 shazaam"; see the b4 man page for more details.

> > Btw, can you push your tree somewhere until you've got your
> > kernel.org account?
> 
> Do we really need to create some temporary tree? I have a fork of
> kernel tree on github where I am managing SSDFS source code. But I
> am not sure that I can create another fork of kernel tree on github.

If you have a fork of the kernel tree, sure, you can just use that and
tell folks what branch they should look at.

Github should be just fine creating another fork of the kernel tree,
however.  One advantage of having separate forks is that once you set
up the kernel.org tree from your local git tree, it becomes easier to
update multiple trees via separate git trees.  So for example, when I
push out changes, I might do

git push ra     # ra.kernel.org is a CNAME for gitolite.kernel.org
                # and is easier to type.   :-)
git push github

... and this will update my trees on kernel.org and github
automatically, aince I have in my .git/config file:

[remote "ra"]
	url = ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
	fetch = +refs/heads/*:refs/remotes/ext4/*
	push = +master:master
	push = +origin:origin
	push = +fixes:fixes
	push = +dev:dev
	push = +test:test

[remote "github"]
	url = git@github.com:tytso/ext4.git
	fetch = +refs/heads/*:refs/remotes/github/*
	push = +master:master
	push = +origin:origin
	push = +fixes:fixes
	push = +dev:dev
	push = +test:test

Cheers,

						- Ted

