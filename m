Return-Path: <linux-fsdevel+bounces-28440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5075096A475
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 18:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054941F251F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D73818BC1D;
	Tue,  3 Sep 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKtRjpwM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB418BBAB;
	Tue,  3 Sep 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381189; cv=none; b=QUuVXvOQWTih+ZrcrWZsnfzJKe3UddWs2oJBE8+ZAqSHDF7uEz4T1KwDFhjiRFmBwbXwQ5XnHLQeFxxa7m52vCgMD16ruJQO+z3+H09eOP8mWamwqp14Oj9uf/97uIwpjtUn6fTv+imH/OS33GsB2l4BKOA8URMiGF4YfGGhugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381189; c=relaxed/simple;
	bh=FiTlMgbD0v2nfsBDtR03sU4PhfzNksMw9X1+r29cOqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN9VSvJ//vsXi732JOl+Kmi2WHnw+oPvTOp2WBV1VwkTAtfcREQoL4VpEqoSGl+3Sqgb7A2RhsBLCaE2eLqeAk64x/gDbEDLkVk3M+oAXWKhy/5DBmMVjKvLg8NKfj8Q1O+OLv9ajL47xINvsDFn7NzfJyO1aJy0puOYZvntwJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKtRjpwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80445C4CEC4;
	Tue,  3 Sep 2024 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381189;
	bh=FiTlMgbD0v2nfsBDtR03sU4PhfzNksMw9X1+r29cOqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WKtRjpwMckbUlzKhgdD3e95nSBTyuKDaYEtddA/9oR+znmCjLSrdmnqjlMVKsrqGz
	 JYwaOOTCgkjj2XoE4R4vuIlrXya8ipHp+57BusbLefIDvOyD51rYlWxtRuGZa3kdiO
	 vREqoOQStdVeCeeQBqCYIm2ZDSrOOfdgyHbBFBRTmZxhmXUCb7vdA110gT7zqo1kIZ
	 19hTmvug1ASbI2SRe44j3nl0u8RYBQwC6JYBV+CdzCsrlGXSudewQALvZKRxx9IEJ5
	 mskwCf3o6xSUxzz2B7qi9ARW0lacs8lLt0l9BTAnOfYWVzD/5de5W1I35gPruey3jP
	 kI/y/RjRLZkBA==
Date: Tue, 3 Sep 2024 12:33:08 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 14/26] nfs_common: add NFS LOCALIO auxiliary protocol
 enablement
Message-ID: <Ztc6ROzJ_Q6XFJ0B@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <20240831223755.8569-15-snitzer@kernel.org>
 <172523315282.4433.12624168004076761213@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172523315282.4433.12624168004076761213@noble.neil.brown.name>

On Mon, Sep 02, 2024 at 09:25:52AM +1000, NeilBrown wrote:
> On Sun, 01 Sep 2024, Mike Snitzer wrote:
> > fs/nfs_common/nfslocalio.c provides interfaces that enable an NFS
> > client to generate a nonce (single-use UUID) and associated
> > short-lived nfs_uuid_t struct, register it with nfs_common for
> > subsequent lookup and verification by the NFS server and if matched
> > the NFS server populates members in the nfs_uuid_t struct.
> 
> The nfs_uuid_t isn't short-lived any more.  It will be embedded in the
> struct nfs_client.  I think I revised that comment in one of the patches
> I sent...

Thanks, fixed.

