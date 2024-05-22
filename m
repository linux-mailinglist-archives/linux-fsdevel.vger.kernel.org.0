Return-Path: <linux-fsdevel+bounces-20019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BCC8CC65B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 20:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088051F220B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 18:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD17D145FE4;
	Wed, 22 May 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4DSL8kc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369831419BC;
	Wed, 22 May 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402808; cv=none; b=HwOBNq+6mz/GWnux/Rz6exNp+9v1ix+VHrIB1HCDoiS1LDHixUvtfGt9J91VnY6aLUgdlLV/k7RRoB8MSjM1la/JPpJKEX2KvFS6Yx8onRX+Hu+HoRoxRYn/Koh14b/wP6cOTTyJtyrd34ohRohfpkKjBqPYX2Hs6fxuTsLLmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402808; c=relaxed/simple;
	bh=00+z9eUtGaL7iexG3FS/WqSmo5CJdAYqSZxtY5+qPkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rt6QxmB+5It2npmLauPvnCpY6zMRNpA61c4F8k8g051O8rkiEoS5DdHOszJmKOzMu1n0TcuP+ByObJvmFsGwBSgTOLs4/UgjtNILTHjyevwIbr9oeWR5dEA+mTe+YxcpyOAd+6WIHqu8+y9tI6QsaliUTZXDKd8jHLctjZ3ubhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4DSL8kc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB993C2BBFC;
	Wed, 22 May 2024 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716402808;
	bh=00+z9eUtGaL7iexG3FS/WqSmo5CJdAYqSZxtY5+qPkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4DSL8kcCY8EI1BRLe9FzpBtaALcS1vingyt6LFQup8H3iq12gs5LHgTgprre/gmD
	 2cxjTBPcGZ/1+BfnG+hsugU3CupopQ0+XzAC4yEu6J+w8cT9Mmx0q+7xpxSvbCrMqw
	 HOGCAguWesdM8dhafgPn0nVJJa3Cuqt13t1MVugywyqoqgf3Udl0SljwpkvPC0on4/
	 XUcYGPaaxmE2DjwJKIw9KVnt4m1CP2YLyW0R17OPIzO3umDP++u1ikr4rwW8/GaElC
	 +sxvw8TssCJMo95SV6RVitnOvqzfQ0sofFErraOLZQCGu6ifoF9EuL5NG1Np8cVK+W
	 Mq+6FNgxGZE2Q==
Date: Wed, 22 May 2024 11:33:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <20240522183326.GC1789@sol.localdomain>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <CAOQ4uxikMjmAkXwGk3d9897622JfkeE8LXaT9PBrtTiR5y3=Rg@mail.gmail.com>
 <z6ctkxtwhwioc5a5kzisjxffkde6xpchstrr3zlflh4bsz4mpd@5z2s2d7lbje5>
 <CAOQ4uxjaLbrmSDk_a_M6YDT5tQoHO=dXTDsHVOSYcMxeQnpP1w@mail.gmail.com>
 <3b7opex4hgm3ed6v24m7k4oagp2gnsjms45yq223u2nnrbvicx@bgoqeylzxelj>
 <20240522162853.GW25518@frogsfrogsfrogs>
 <20240522163856.GA1789@sol.localdomain>
 <qrjb7dq2xc4zhzzevjy7vqacdonyqkoylkthp42rlwcfbvlhl3@zflo33tunkyq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qrjb7dq2xc4zhzzevjy7vqacdonyqkoylkthp42rlwcfbvlhl3@zflo33tunkyq>

On Wed, May 22, 2024 at 07:23:15PM +0200, Andrey Albershteyn wrote:
> On 2024-05-22 09:38:56, Eric Biggers wrote:
> > On Wed, May 22, 2024 at 09:28:53AM -0700, Darrick J. Wong wrote:
> > > 
> > > Do the other *at() syscalls prohibit dfd + path pointing to a different
> > > filesystem?  It seems odd to have this restriction that the rest don't,
> > > but perhaps documenting this in the ioctl_xfs_fsgetxattrat manpage is ok.
> > 
> > No, but they are arbitrary syscalls so they can do that.  ioctls traditionally
> > operate on the specific filesystem of the fd.
> > 
> > It feels like these should be syscalls, not ioctls.
> 
> Won't it also be a bit weird to have FS_IOC_FS[S|G]ETXATTR as
> ioctls for normal files and a syscall for special files? When both
> are doing the same thing
> 

Why would the syscalls be restricted to operating on special files?

- Eric

