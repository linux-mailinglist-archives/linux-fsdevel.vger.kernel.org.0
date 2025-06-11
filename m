Return-Path: <linux-fsdevel+bounces-51315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1BEAD544F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8698D17E2CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4326E70E;
	Wed, 11 Jun 2025 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StAndGnW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772762571A0;
	Wed, 11 Jun 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642188; cv=none; b=JZ0l2/JZSZ8r8EfY5ItKIKXRHLV3hVTBImpplcUvNmXzsaQMYjjzfUi2BEhEna9cAo5H6og0Zr+VXJ/S7ZG2OypySZG+PFFUWw1Hffje6G4enjxWpr1pyNx5vCiIFT4lxRrpxyvys38dD/nCI9WYVnkFhFkoy3Tgf2bekUeHpRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642188; c=relaxed/simple;
	bh=wedYisN82oAzQqCkn77HY7K3bpEVwF4ATKaiB1hyoA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNneKxTTYf/j7X16AahWYRo9nJtxEwfZcw9/afk+dp5+RHRDFITvuiyhYPt6rKX7rivEGHR5jErcJftgAgBD/sdTLh6RNQ8EEdRr6oWS7aQ7Z9oXZUcLzBnWKTeTEndl0f8CA9gD+0BJhGfmUbEIUJEvD0vPfxY7rjyuyCE1k0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StAndGnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4E8C4CEEE;
	Wed, 11 Jun 2025 11:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749642188;
	bh=wedYisN82oAzQqCkn77HY7K3bpEVwF4ATKaiB1hyoA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=StAndGnWkWVO4VmX6+XnHOy6BYaOOXdzT1px9NCwZgLFkVjx2z1LyKbUw8kt3g5oU
	 uPd41WfAo5FvDAV3RJvQbuB69VI8JVugTduSKOeRKy7Tw/ULasUbjnzRLo1QigaQQs
	 ZJ+f36nkEQbv7kMT1AP8aBS5IStjgOMG5S4QSmpVC3kFZ/vpBBRqScp9gS0ia1+nZV
	 +zfshxSe2HsxU9tDkiv8khquYgS12eUdJ66T3apFsH+N3+AmRtS9iksyJeuJOH1Oph
	 r9VzF4kg2QCdq5ry0wA9bBDUfXWv+dy9xT8LnTPIbFy2EwexqPPnJ7XWCCZIijRAJe
	 ZViRnfPH4Mx0g==
Date: Wed, 11 Jun 2025 13:43:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org, 
	coda@cs.cmu.edu, codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Minor cleanup preparation for some dir-locking API
 changes
Message-ID: <20250611-ihnen-gehackt-39b5a2c24db4@brauner>
References: <20250608230952.20539-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250608230952.20539-1-neil@brown.name>

On Mon, Jun 09, 2025 at 09:09:32AM +1000, NeilBrown wrote:
> The following 5 patches provide further cleanup that serves as
> preparation for some dir-locking API changes that I want to make.  The
> most interesting is the last which makes another change to vfs_mkdir().
> As well as returning the dentry or consuming it on failure (a recent
> change) it now also unlocks on failure.  This will be needed when we
> transition to locking just the dentry, not the whole directory.

All of the patches except the vfs_mkdir() one that Al is looking at
make sense as independent cleanups imho. So I'd take them unless I hear
screams.

