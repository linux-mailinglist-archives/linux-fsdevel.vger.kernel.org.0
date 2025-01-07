Return-Path: <linux-fsdevel+bounces-38547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEBCA0386C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 08:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720671886752
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 07:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779AA1E0DD8;
	Tue,  7 Jan 2025 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a++2Dgo8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BEB1E048A;
	Tue,  7 Jan 2025 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736233702; cv=none; b=RO6rGmcIb2n87uAci6nZGEz+/JxQSLt7eJ33pZ2rUUgtsctOJN312NAYw11euxCfmM5luIcTWGeLP2Jgve6gn8/tEiypJBOQH1fByDayCnL48UCzxP68SeCZAZn07HdJRlL915V471sKAHypzlbtKFq85dBNVgvP4HKb35EH6Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736233702; c=relaxed/simple;
	bh=riRq09BCQs2eWbe53PVULdlkjmUtPBgbr9/pEmKTjic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkHF2PTonShMZvZd/HS1KA/jHnnL2qs1/7EYiYODqf+NGMIhkgfWUE5g/RPf/11YGHWyO6kGa+pGSn9m2AYV1kKXaHXRDkXzWwZ5YADlmE7m8kH6v5qIlcA1kooRsk4KzIAvxlycQ4DoQ6NBzCgQRG+J2/KcNpIkH8XS+cXsSYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a++2Dgo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B36C4CED6;
	Tue,  7 Jan 2025 07:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736233702;
	bh=riRq09BCQs2eWbe53PVULdlkjmUtPBgbr9/pEmKTjic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a++2Dgo82RtXhLPymQXK/9RjUhn1bBxGRBUciehp3GrCJO9Z+ELD2SUiSOth7dm2G
	 1pSFQQwdeQj4cLH27UvsmBbyRRjYevfuPsv5iy5tvfoQeX9pYhEvT+SnerBO+Onw/E
	 0CjxcN+5DqW3Wv75P4Jspacc47ggMSOhNGEbfamyl0wdKXg4PEVquXi9bKqtZloX6U
	 kNczfdT7Axp8fYMfCMIfgY771SyEl1UK++O+u6M1TziTqvctxnwhj7Y2E2s0Cflz86
	 ya70HWHusONXIAHk2F/w1NAcxiS2r7jxz0Il/SNXADjo92wuX+lxNZ19BEYDdBhk1/
	 xuUTNpJCZu8Aw==
Date: Mon, 6 Jan 2025 23:08:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, sunyongjian1@huawei.com,
	Yang Erkun <yangerkun@huawei.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [BUG REPORT] ext4: =?utf-8?B?4oCcZXJy?=
 =?utf-8?Q?ors=3Dremount-ro=E2=80=9D_has_become_=E2=80=9Cerrors=3Dshutdown?=
 =?utf-8?B?4oCdPw==?=
Message-ID: <20250107070820.GJ6174@frogsfrogsfrogs>
References: <22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com>
 <z52ea53du2k66du24ju4yetqm72e6pvtcbwkrjf4oomw2feffq@355vymdndrxn>
 <17108cad-efa8-46b4-a320-70d7b696f75b@huawei.com>
 <umpsdxhd2dz6kgdttpm27tigrb3ytvpf3y3v73ugavgh4b5cuj@dnacioqwq4qq>
 <20250103153517.GB1284777@mit.edu>
 <20250103155406.GC1284777@mit.edu>
 <5eb2ad64-c6ea-45f8-9ba1-7de5c68d59aa@huawei.com>
 <20250106234956.GM6174@frogsfrogsfrogs>
 <0acc1709-1349-4dbb-ba3e-ae786c4b5b53@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0acc1709-1349-4dbb-ba3e-ae786c4b5b53@huawei.com>

On Tue, Jan 07, 2025 at 10:01:32AM +0800, Baokun Li wrote:
> On 2025/1/7 7:49, Darrick J. Wong wrote:
> > On Sat, Jan 04, 2025 at 10:41:28AM +0800, Baokun Li wrote:
> > > Hi Ted,
> > > 
> > > On 2025/1/3 23:54, Theodore Ts'o wrote:
> > > > On Fri, Jan 03, 2025 at 10:35:17AM -0500, Theodore Ts'o wrote:
> > > > > I don't see how setting the shutdown flag causes reads to fail.  That
> > > > > was true in an early version of the ext4 patch which implemented
> > > > > shutdown support, but one of the XFS developers (I don't remember if
> > > > > it was Dave or Cristoph) objected because XFS did not cause the
> > > > > read_pages function to fail.  Are you seeing this with an upstream
> > > > > kernel, or with a patched kernel?  The upstream kernel does *not* have
> > > > > the check in ext4_readpages() or ext4_read_folio() (post folio
> > > > > conversion).
> > > > OK, that's weird.  Testing on 6.13-rc4, I don't see the problem simulating an ext4 error:
> > > > 
> > > > root@kvm-xfstests:~# mke2fs -t ext4 -Fq /dev/vdc
> > > > /dev/vdc contains a ext4 file system
> > > > 	last mounted on /vdc on Fri Jan  3 10:38:21 2025
> > > > root@kvm-xfstests:~# mount -t ext4 -o errors=continue /dev/vdc /vdc
> > > We are discussing "errors=remount-ro," as the title states, not the
> > > continue mode. The key code leading to the behavior change is as follows,
> > > therefore the continue mode is not affected.
> > Hmm.  On the one hand, XFS has generally returned EIO (or ESHUTDOWN in a
> > couple of specialty cases) when the fs has been shut down.
> Indeed, this is the intended behavior during shutdown.
> > 
> > OTOH XFS also doesn't have errors=remount-ro; it just dies, which I
> > think has been its behavior for a long time.
> Yes. As an aside, is there any way for xfs to determine if -EIO is
> originating from a hardware error or if the filesystem has been shutdown?

XFS knows the difference, but nothing above it does.

> Or would you consider it useful to have the mount command display
> "shutdown" when the file system is being shut down?

Trouble is, will mount get confused and try to pass ",shutdown" as part
of a remount operation?  I suppose the fs is dead so what does it
matter...

> > To me, it doesn't sound unreasonable for ext* to allow reads after a
> > shutdown when errors=remount-ro since it's always had that behavior.
> Yes, a previous bug fix inadvertently changed the behavior of
> errors=remount-ro,
> and the patch to correct this is coming.
> 
> Additionally, ext4 now allows directory reads even after shutdown, is this
> expected behavior?

There's no formal specification for what shutdown means, so ... it's not
unexpected.  XFS doesn't allow that.

> > Bonus Q: do you want an errors=fail variant to shut things down fast?
> > 
> > --D
> 
> In my opinion, I have not yet seen a scenario where the file system needs
> to be shut down after an error occurs. Therefore, using errors=remount-ro
> to prevent modifications after an error is sufficient. Of course, if
> customers have such needs, implementing this mode is also very simple.

IO errors, sure.  Metadata errors?  No, we want to stop the world
immediately, either so the sysadmin can go run xfs_repair, or the clod
manager can just kill the node and deploy another.

--D

> 
> 
> Thanks,
> Baokun
> 
> 

