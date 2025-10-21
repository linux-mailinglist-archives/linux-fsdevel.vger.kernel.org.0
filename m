Return-Path: <linux-fsdevel+bounces-64903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3854BBF653D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC8119A2FF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC3E33DEF0;
	Tue, 21 Oct 2025 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2Iq+SBT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051432E754;
	Tue, 21 Oct 2025 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047676; cv=none; b=c9f518lQOin+Gu2TiJ9WkY4ew+P9uNd20m9WQFzQPkwPAmfaLKsvwQRgZspKqTju/qdEslK1JLBaD5JDXrGq+6/ZRI9rSW+UiMxMyMEDYtNzg2FFYzgLypak+B/huCjgjrNdefrsGR53o6UcS6PjTg+I2ylphdKqnt4tXp+Y6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047676; c=relaxed/simple;
	bh=1X22I8AalINBQHO2KHCJSA3n1eV/GIP2rbmm+yja0eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGj8XoElgov/ZMMAQGDBZVAP9Xhl84cjGChPLAM2QddK8vPlM80Kq8nmtgKqKbWKF+AN+DKTiWh0Wq+dhY3RLxDy12BEseGTTV9f36LRISMbbsyaVM74s6kip3WWRUL2ZETQeXAMiEpWxTWvK3/KhdIqAwPQ5FDCMvbCFym1QZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2Iq+SBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05F2C4CEF1;
	Tue, 21 Oct 2025 11:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047676;
	bh=1X22I8AalINBQHO2KHCJSA3n1eV/GIP2rbmm+yja0eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2Iq+SBT1oEpF59MHaaWcHvbRgknlIcAfpOJeaR3tW5fplUNJDUVX/YxCaxVPVL63
	 MnXYUgA11Tsn2iI4Q2dFpVjEMli37VbPhktb/uW/FKImJyUbQKeMFrjRrrqn+Mm4+T
	 +cd3n7+NzHZH49AfMRnuyf0SKVlKmP/a/31lthPt0ZahDvPsioOuAGGB3uHJYHZsc4
	 emNRTw+PSkAVb6FqsB5JXOx86G4b3Z27hXiMFceLB9lw6Uks+qAwu28LdndR47CVEx
	 7EUSGhDSVD2g1uXnzEWp4JhBgrN6g856mHhF1F95bpj5to5jr6XKja0XcCf0QlpGTE
	 d+3bZjDXd0XOA==
Date: Tue, 21 Oct 2025 13:54:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Volker Lendecke <Volker.Lendecke@sernet.de>, CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
Message-ID: <20251021-zypressen-bazillus-545a44af57fd@brauner>
References: <CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
 <87tt0gqa8f.fsf@mailhost.krisman.be>
 <28ffeb31-beec-4c7a-ad41-696d0fd54afe@kernel.org>
 <87plb3ra1z.fsf@mailhost.krisman.be>
 <4a31ae5c-ddb2-40ae-ae8d-747479da69e3@kernel.org>
 <87ldlrr8k3.fsf@mailhost.krisman.be>
 <20251006-zypressen-paarmal-4167375db973@brauner>
 <87zfa2pr4n.fsf@mailhost.krisman.be>
 <20251010-rodeln-meilenstein-0ebf47663d35@brauner>
 <6b709bcc-d9bb-4227-8f84-96a67d86042b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b709bcc-d9bb-4227-8f84-96a67d86042b@kernel.org>

On Fri, Oct 10, 2025 at 08:43:33AM -0400, Chuck Lever wrote:
> On 10/10/25 7:11 AM, Christian Brauner wrote:
> >>> I'm not too fond of wasting statx() space for this. Couldn't this be
> >>> exposed via the new file_getattr() system call?:
> >> Do you mean exposing of unicode version and flags to userspace? If so,
> >> yes, for sure, it can be fit in file_get_attr. It was never exposed
> >> before, so there is no user expectation about it!
> > Imho it would fit better there than statx(). If this becomes really
> > super common than we can also later decide to additional expose it via
> > statx() but for now I think it'd be better to move this into the new
> > file_attr()* apis.
> 
> Christian, I'm still not clear what you mean by "this". Do you mean only
> the unicode version? Or do you mean both the unicode version *and* the
> case sensitivity/preservation flags?

Sorry, my thought had been both would fit into file_getattr() if that's
feasible.

