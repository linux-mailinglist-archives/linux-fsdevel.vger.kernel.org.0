Return-Path: <linux-fsdevel+bounces-39357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B843A1324F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5829B1887A4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3A8156F41;
	Thu, 16 Jan 2025 05:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OQ8pWSFr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A041E505;
	Thu, 16 Jan 2025 05:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737004870; cv=none; b=RnJwwGtm1VQtxXp1cCP/+Zb04LPhaDmKLTMvmN6b6iUyUeMWVKTgpPXY/yRrK9YvIezXwJejSHKQNB3g9qN9Gu0vNmlN9YYoVfhgads58t5qtQ6PAbUcTG4YBs6Ovdgt32LWdYLSIDmNiRl+SR1FCM0QdQg8gkgzvjqCEsLaPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737004870; c=relaxed/simple;
	bh=IiHVZnPTKWSwu7e9i2PtISLlxl361S1nSH+yOnQjHyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3ae4tMcZWqGA0CVTME7wYszcOqS7gKM76Y0D1j/AaEfVZ+C0VLLXueD4x7KpjjohFaE85U6hCGOu+nF5qSP7vGfPgz8hrBLAbv8zXA+TbDlyOmnl2kFHyNBcq8YMCglZ/CRA3QbGzrL3y9pPH1F6F71S4C3UuD66iu15EaC35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OQ8pWSFr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I1aOaJYtdYgLNPP6Yad9b3o7yqnMnEV5392Y2T0er3U=; b=OQ8pWSFrwb5MsuzusUTyrLpU5E
	jEtzuZyDAoPJ+vC/67TccRBjZ9THv+hXMtnwt8p+hUrcVWGml/MOTz9jJlfriooSVkeg48Pg4gVZ5
	yEB+x8u7kSfUqG9RnIBvkoz0sUZMCJGGS6qodeTf7aVTZQcVf+sZPTipjUPbdPndtRUsMmvAdgAYa
	5QOy7bEwWfQX/UT8C3IffCSuXGLVQmbZenknZlNSeI958U9ZxwosVtaMjaACdhnLOskqZ9BHbnGfy
	Q8sIc0iiZqugbu3oOZLM6qOr4NgVYfsTrvVxWI72jF8lnLcxrZJtP+K+/oWVNwmy074veFNIK90CY
	1Xc4rDHw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYIJT-0000000225V-3fvn;
	Thu, 16 Jan 2025 05:21:03 +0000
Date: Thu, 16 Jan 2025 05:21:03 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Gabriel Krisman Bertazi <krisman@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCHES v2][RFC][CFT] ->d_revalidate() calling conventions changes
 (->d_parent/->d_name stability problems)
Message-ID: <20250116052103.GF1977892@ZenIV>
References: <20250110023854.GS1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110023854.GS1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

	Series updated and force-pushed to the same place:
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.d_revalidate
itself on top of #work.dcache.
 
	Individual patches in followups; please, review.

	Changes since v1:
* reordered external_name members to get rid of hole on 64bit, as suggested by
dhowells.
* split the added method in two in the last commit ("9p: fix ->rename_sem exclusion")

	Folks, if no objections materialize, into #for-next it goes.

