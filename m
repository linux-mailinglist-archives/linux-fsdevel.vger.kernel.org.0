Return-Path: <linux-fsdevel+bounces-24857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E31945CC5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 13:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CD81C21C1B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928FB1DE87D;
	Fri,  2 Aug 2024 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8l2eSC9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF93814A4E0;
	Fri,  2 Aug 2024 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596691; cv=none; b=AJnw0suNkdIC8T5xLmt/q1RuFbqQmeyTQZjXqPIUtid1p874vx2Hr4H1cBCkwx9tuLII28iglLY9RNFq9J+DiYhViCSs+eNlTNYhxJYhRDUd4mkY+LllG5dkP05sHR2c+/HnyyE1DrGIM8PXxGKfugaoVDFG2/GlP7UgZv2vxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596691; c=relaxed/simple;
	bh=rfZBKiJj7o7FkUeOwIoib9NwpSc0mxv6TtnHUJo2hxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEgHq1xBoe0lWmU1MJNibtigTqNHc1MnE0m5cBDkmucYGf33TeY3JyDFqNBCLcbw/mb5AJlKt+/2ymlM9AbGX4/MCGxg7fTVApC9EYgn4OnX/clx4+Wuau+g+SCVhPVD6lrp4TGHXfj7j5qXNzDovJSWIZOF7KrEwcpyhwdUTNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8l2eSC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A1FC32782;
	Fri,  2 Aug 2024 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722596690;
	bh=rfZBKiJj7o7FkUeOwIoib9NwpSc0mxv6TtnHUJo2hxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8l2eSC9sd5ESG273ZVw7EMnedJ3qHgzZHciX9UiWB3tLvG53JsY/85iyTVuHoTmN
	 z0mJK+nMa6gsz4jlbzVmKs4+8rnVf2W9XAcdMMJWMetKp3BR2AAdbZys1Wgp67f4/0
	 MVtxVJsp/rYCWhmPPnoVuyY7lo6+1WreibRGo69ZJ0yl0bweNFgYtSwyCNWK9soQLW
	 8Xd/KGnXn6cVwzVcXD7sJeZhpUXQcYK9XF/TLA0uVm03abKi7HsjGULD2iI3CfkSXh
	 +Oho2TC0DtpNSiWIncsv6rpT1HPHYGV9kw9tKlWCqd2MZhqbmc/J9jUWYhsUCKW1fh
	 12cqA0xmGvqmw==
Date: Fri, 2 Aug 2024 13:04:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: jack@suse.cz, mjguzik@gmail.com, edumazet@google.com, 
	Yu Ma <yu.ma@intel.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com, 
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v5 0/3] fs/file.c: optimize the critical section of
 file_lock in
Message-ID: <20240802-bewachsen-einpacken-343b843869f9@brauner>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240722-geliebt-feiern-9b2ab7126d85@brauner>
 <20240801191304.GR5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801191304.GR5334@ZenIV>

> Hmm...   Something fishy's going on - those are not reachable by any branches.

Hm, they probably got dropped when rebasing to v6.11-rc1 and I did have
to play around with --onto.

> I'm putting together (in viro/vfs.git) a branch for that area (#work.fdtable)
> and I'm going to apply those 3 unless anyone objects.

Fine since they aren't in that branch. Otherwise I generally prefer to
just merge a common branch. But that's rarely needed since Linus handles
merge conflicts anyway and doesn't mind.

