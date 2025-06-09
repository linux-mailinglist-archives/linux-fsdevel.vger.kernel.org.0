Return-Path: <linux-fsdevel+bounces-50975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11441AD1850
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E4316896F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 05:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5135B27FD7B;
	Mon,  9 Jun 2025 05:24:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A12F4A;
	Mon,  9 Jun 2025 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446672; cv=none; b=ne/53SEv8YMPkLP43n8ZIzw7cov18e6JeV+v/rimRF98j5ZHVRNNq/Il24g7t9QgTAeyQhcfBXclaKrsNiyNchjQ4UzKruZtsxzMSosdwi6zLZ5+S6b1RqaebhHePyt/7GcCHMuXWy8rB/ZoatA2clsyiwMtH7vr68219XBM2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446672; c=relaxed/simple;
	bh=L7/KnI6450/qLxPF/MzLzFgMhQYd+Uz0sDOC3iC3MCo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rgqLCZyA4WiyqHP6oCPiuoKiNbMo2QrErvMUR9VABI0s0MBoJOqj9iPu+TywCF9YJqlPqmPNKF51aWX/lkUsYVHiqdvQkkVtGlr+lKYjixr1Ja2wfftOkZE300+AaPs8X1ui88QndTIi3fTZhXk3fXZPHq/HMrVNiKojsxoCTc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOUzf-006B3U-Dq;
	Mon, 09 Jun 2025 05:24:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Harkes" <jaharkes@cs.cmu.edu>,
 "David Howells" <dhowells@redhat.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Carlos Maiolino" <cem@kernel.org>,
 linux-fsdevel@vger.kernel.org, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
 linux-nfs@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Change vfs_mkdir() to unlock on failure.
In-reply-to: <20250609005009.GB299672@ZenIV>
References: <>, <20250609005009.GB299672@ZenIV>
Date: Mon, 09 Jun 2025 15:22:00 +1000
Message-id: <174944652013.608730.3439111222517126345@noble.neil.brown.name>

On Mon, 09 Jun 2025, Al Viro wrote:
> On Mon, Jun 09, 2025 at 09:09:37AM +1000, NeilBrown wrote:
> > Proposed changes to directory-op locking will lock the dentry rather
> > than the whole directory.  So the dentry will need to be unlocked.
> 
> Please, repost your current proposal _before_ that one goes anywhere.
> 

I've posted my proposal for the new API.  This makes the value of the
vfs_mkdir() change clear (I hope).

Would you also like me to post the patches which introduce the new
locking scheme?

Thanks,
NeilBrown

