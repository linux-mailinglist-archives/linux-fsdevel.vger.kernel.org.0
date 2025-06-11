Return-Path: <linux-fsdevel+bounces-51372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE5AD6263
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 00:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC4617F413
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 22:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A353F24BD04;
	Wed, 11 Jun 2025 22:35:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F508DF49;
	Wed, 11 Jun 2025 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681327; cv=none; b=Z/UNiuUP+roRGRKOsoBZiRme/k4uqNFGqRpd4TPGOSVcI4JMMFcjRBN0WwJst4V0Wcb8YDBFBzQ+sLGmzgD4xVRP+oPwJzkZ0KX1//BuFf51cZamMzMXlVWLzCc3EB7qeX76JdGz4sF/3FH0O1zb0fy2MZF8LHo89LkZTlIlhIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681327; c=relaxed/simple;
	bh=uyJxGwz+QLoecVnaEMoet+qzKUja57qNfLOrfhR8XE8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IqMW8+4E4QiAoJj2H85vlshFjmGFwHyMKjO5K974NrkFrFMl+KsetrTeKzBNBaSJw0j9rkfxQVj8pTE0bG1tzJt/re2YLvzFj7YYwbZl41OzhJepIKEcCur+5g3SedV11i1xpjbvI71Q12f3xwEHo1BJfaSvNnd4DabiHqU1/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPU2J-008NYe-Fs;
	Wed, 11 Jun 2025 22:35:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Harkes" <jaharkes@cs.cmu.edu>,
 "David Howells" <dhowells@redhat.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Carlos Maiolino" <cem@kernel.org>,
 linux-fsdevel@vger.kernel.org, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
 linux-nfs@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 0/5] Minor cleanup preparation for some dir-locking API changes
In-reply-to: <20250611-ihnen-gehackt-39b5a2c24db4@brauner>
References: <20250608230952.20539-1-neil@brown.name>,
 <20250611-ihnen-gehackt-39b5a2c24db4@brauner>
Date: Thu, 12 Jun 2025 08:35:10 +1000
Message-id: <174968131051.608730.6876830326454616279@noble.neil.brown.name>

On Wed, 11 Jun 2025, Christian Brauner wrote:
> On Mon, Jun 09, 2025 at 09:09:32AM +1000, NeilBrown wrote:
> > The following 5 patches provide further cleanup that serves as
> > preparation for some dir-locking API changes that I want to make.  The
> > most interesting is the last which makes another change to vfs_mkdir().
> > As well as returning the dentry or consuming it on failure (a recent
> > change) it now also unlocks on failure.  This will be needed when we
> > transition to locking just the dentry, not the whole directory.
> 
> All of the patches except the vfs_mkdir() one that Al is looking at
> make sense as independent cleanups imho. So I'd take them unless I hear
> screams.
> 

Thanks.  I'm glad you didn't include the vfs_mkdir() change as I found a
problem in the overlayfs code.  I'm make sure I really understand that
code before trying that one again.

Meanwhile I noticed I have a couple of other mostly-independent
cleanups.  I'll send those.

NeilBrown

