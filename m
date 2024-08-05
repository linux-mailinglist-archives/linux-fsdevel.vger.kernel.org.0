Return-Path: <linux-fsdevel+bounces-24969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624CF9475A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 08:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC032812B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 06:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BE31487EA;
	Mon,  5 Aug 2024 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByUt0/cs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32502144D15;
	Mon,  5 Aug 2024 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722841026; cv=none; b=NO28x7Nr/0f8GI2YRBeZay2eW33ETomRnuiO+7cbRdpKby/AcnGpSSnNlBEyK1G4jt9rSbgylklt2uSppEkwGtJ1iIFe2DxpR4Zzs3esC0PbsM40pdQtregUH5NUxLk+/f27TPH7wqzfmNmfcbGMZOe31f7HXZII2WvmETJWHbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722841026; c=relaxed/simple;
	bh=rOFTIkNN0o0R2ottCkYE3AdffTi0xhhtd2GB2gRd3ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGTmkcgyu3fuV8WNI98lXX23sCLf+YAII5rWIUPXMID7jmKZTCeJxqcjkBuhXXmHiPLjWQLbnYK7xDPeDKyg0TM7QwAma2NMkIzJIF4YOeFpJ7QKu7R85riDv4W6NBQ+AIYUDJxaNw5kzOUPvD/cuv9rRTQ4CFU3pk4eNIlERAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByUt0/cs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB82C32782;
	Mon,  5 Aug 2024 06:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722841025;
	bh=rOFTIkNN0o0R2ottCkYE3AdffTi0xhhtd2GB2gRd3ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ByUt0/csvVG7Q4dKGLxBNObCKPqJGZXimkv/9wN22sNh/yLzCF2bw881sAoUiNPz+
	 txMbiUjpV4no31mfhJUHm31XUZKazKkeki859jIviyEopdSJWSp00+O4nEMGOLxRNj
	 648VLXAo8byZ8MMgOxTuuKdBLVjoWCFfNC/Kxo5L88kqO/vewG5Z2bcFALpoLoLFhv
	 HV553jnzI7gm3zg2xfor+MSeDiYMaNCYDLXzzMSS+AxLTr59D3Pel6dNyKN1yeax5r
	 Iil3lNiHZJp9iZQADjr8+jFEjRUgVvM8sBZZ9dT6L45nHqdhMWrBn0rDw0nS6YH9b5
	 F1WeFmv8XosyQ==
Date: Mon, 5 Aug 2024 08:56:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: jack@suse.cz, mjguzik@gmail.com, edumazet@google.com, 
	Yu Ma <yu.ma@intel.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com, 
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v5 0/3] fs/file.c: optimize the critical section of
 file_lock in
Message-ID: <20240805-gesaugt-crashtest-705884058a28@brauner>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240722-geliebt-feiern-9b2ab7126d85@brauner>
 <20240801191304.GR5334@ZenIV>
 <20240802-bewachsen-einpacken-343b843869f9@brauner>
 <20240802142248.GV5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240802142248.GV5334@ZenIV>

On Fri, Aug 02, 2024 at 03:22:48PM GMT, Al Viro wrote:
> On Fri, Aug 02, 2024 at 01:04:44PM +0200, Christian Brauner wrote:
> > > Hmm...   Something fishy's going on - those are not reachable by any branches.
> > 
> > Hm, they probably got dropped when rebasing to v6.11-rc1 and I did have
> > to play around with --onto.
> > 
> > > I'm putting together (in viro/vfs.git) a branch for that area (#work.fdtable)
> > > and I'm going to apply those 3 unless anyone objects.
> > 
> > Fine since they aren't in that branch. Otherwise I generally prefer to
> > just merge a common branch.
> 
> If it's going to be rebased anyway, I don't see much difference from cherry-pick,
> TBH...

Yeah, but I generally don't rebase after -rc1 anymore unles there's
really annoying conflicts.

