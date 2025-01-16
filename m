Return-Path: <linux-fsdevel+bounces-39412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641FDA13D6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 16:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD2F7A4B1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF09722B8B9;
	Thu, 16 Jan 2025 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="kbi7HO35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87322AE55;
	Thu, 16 Jan 2025 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040538; cv=none; b=Lj66I70L956xPeLk+fprJoBeO2ec8baY6KyOk2JI5C7GecxBx1ug8d0BuScA8d+X7tfn2mYK9LWizoh+zW0QOOkItwv81/krSbvDpqv9IyWbxMP1g5EIlxFp+DuWZn3IDiVr+iE7Pqic+xGX3szLEt9DUG61uILG3sITChw0ZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040538; c=relaxed/simple;
	bh=fCnwLyD2cTgHj3QC26+Ze8LptZdY+cZ/w/9xafjpc8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jaH00fxsT014FcPzIeeS1xY9tb0PrHmS8lzHySUBOWzzJ4HeuAJ5IahZClSy68eg/MQRgr4T3f9U9tlAzYX4+HZB6rViN07u6PwBmqSNXvCncxKfoKLOQaGN+pcQkgxYOxGZKziJLfV4Fs/7fDBfmmVLGlSZdOUJC2dXA9OEE+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=kbi7HO35; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB4C62000D;
	Thu, 16 Jan 2025 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1737040528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EWNolShWvdF0CK4Zkd5gjASMtQDKoQPirYmEZnZiDXE=;
	b=kbi7HO35bL0JxhxSOzQujUdwyoQecTnCieYN9xAjKex/rT5S/lWAsvS9Ia3teV7Cm5DlgU
	PBHD7Hj1glPsfbRYkhGbjW1gD8EfpX1dldHon7pesr/v3Q9Rl2mHlVY+Ftshkudxzufe9o
	/Na+On60XFfVrHeRMyn820VI2oX8Ewx3Brc1BW/txWwZfpI16kiFlQ5YK9+aXewfRoxFTV
	2PRYkK+bL1A4efn55gPlnEpXvYiLKFJFwaabpayeIunmsq3Bk0Hr8haEPrhUk5K205UAGD
	0cin88eLMgQrNJzYuU1ptLbYM+qFjtho5EUZcdwA4K8be1cUBh6/iDc+N4vs/g==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,  agruenba@redhat.com,
  amir73il@gmail.com,  brauner@kernel.org,  ceph-devel@vger.kernel.org,
  dhowells@redhat.com,  hubcap@omnibond.com,  jack@suse.cz,
  linux-nfs@vger.kernel.org,  miklos@szeredi.hu,
  torvalds@linux-foundation.org
Subject: Re: [PATCH v2 07/20] Pass parent directory inode and expected name
 to ->d_revalidate()
In-Reply-To: <20250116052317.485356-7-viro@zeniv.linux.org.uk> (Al Viro's
	message of "Thu, 16 Jan 2025 05:23:04 +0000")
References: <20250116052103.GF1977892@ZenIV>
	<20250116052317.485356-1-viro@zeniv.linux.org.uk>
	<20250116052317.485356-7-viro@zeniv.linux.org.uk>
Date: Thu, 16 Jan 2025 10:15:23 -0500
Message-ID: <87h65ylrhw.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

Al Viro <viro@zeniv.linux.org.uk> writes:

> ->d_revalidate() often needs to access dentry parent and name; that has
> to be done carefully, since the locking environment varies from caller
> to caller.  We are not guaranteed that dentry in question will not be
> moved right under us - not unless the filesystem is such that nothing
> on it ever gets renamed.
>
> It can be dealt with, but that results in boilerplate code that isn't
> even needed - the callers normally have just found the dentry via dcache
> lookup and want to verify that it's in the right place; they already
> have the values of ->d_parent and ->d_name stable.  There is a couple
> of exceptions (overlayfs and, to less extent, ecryptfs), but for the
> majority of calls that song and dance is not needed at all.
>
> It's easier to make ecryptfs and overlayfs find and pass those values if
> there's a ->d_revalidate() instance to be called, rather than doing that
> in the instances.
>
> This commit only changes the calling conventions; making use of supplied
> values is left to followups.
>
> NOTE: some instances need more than just the parent - things like CIFS
> may need to build an entire path from filesystem root, so they need
> more precautions than the usual boilerplate.  This series doesn't
> do anything to that need - these filesystems have to keep their locking
> mechanisms (rename_lock loops, use of dentry_path_raw(), private rwsem
> a-la v9fs).
>

Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>

Thanks for this. It is a requirement for the negative dentry patchset I
sent a while ago that I'll revive now.

-- 
Gabriel Krisman Bertazi

