Return-Path: <linux-fsdevel+bounces-42633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8A9A45408
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 04:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747941894E29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 03:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8298F25A623;
	Wed, 26 Feb 2025 03:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tF0QJu5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F121C9FD;
	Wed, 26 Feb 2025 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540915; cv=none; b=b853fEZ0WIVELV5fxNwQbiw+PSVEXf2oUo9TczIJd2oI+EdFgKBSCxd8/klLGflvrHdYUlYqJD93Unoayap7y3lIn1Y/QGR2L9VLMdDQNAlVm84x2pwGVEIH9YSBILTMlapgOTCzsC8JV5JenDsgMVKlbdR5F7+NfNfmCFNswS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540915; c=relaxed/simple;
	bh=M5VdN1L/4acqzoTRMzx7ccCFAgC7XTYQIX4QlM8CYp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvBfn3ogASbxy6jDwcYQZA7kXZkrLVhED7Yzyx0nTyVd0vN7JxPiv7PlEJSiBKfojFBjHUZYLeUqLNF1pln35rTO3mJMpiiLV4DLS04Zh4vaGXUzel0+QaAYKj0+zm+UC4mNzP5dh5XxuDi5muRvaF1duYWOcc9ho3dz65qU9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tF0QJu5l; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gfLaod49ckkklrS5HkMhsUUQYxad/szdqQ5Z3G50Xxc=; b=tF0QJu5lrPkZBMtLbiLy4Bz1tH
	WcfomiLvJTogVrL3Tm3HLUWsQkmVsguQ3kKBOQtM8U1GP7NJTm4ssI9t7V04farVLYkNl1rieqwyh
	AYSqiINBHrXOLqT/4WE0ylXNEahosCIQYeUXTO05cznqwrBCaYnLaDJ4v/F2/+SMW77u27JkdVbk7
	POrmBkRBps1JfVkaaZcTMMr9f1snr1/bo7w0g/WJqGnPjJENRjtAM1aQzSSkLMGj7I9isyfI6s1mj
	u5K5s0hWNEvdijcR5mlFiz1dJ7GYBCwzTYwxiL+DTreVwX0/EmcMRkQcOUucQheqL6UTfDWQNlXXN
	fRD4wEqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tn8CQ-00000008k3i-3dIs;
	Wed, 26 Feb 2025 03:35:06 +0000
Date: Wed, 26 Feb 2025 03:35:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	"xiubli@redhat.com" <xiubli@redhat.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>,
	"okorniev@redhat.com" <okorniev@redhat.com>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>,
	"anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
	"jack@suse.cz" <jack@suse.cz>, "tom@talpey.com" <tom@talpey.com>,
	"richard@nod.at" <richard@nod.at>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"netfs@lists.linux.dev" <netfs@lists.linux.dev>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>
Subject: Re: [PATCH 1/6] Change inode_operations.mkdir to return struct
 dentry *
Message-ID: <20250226033506.GE2023217@ZenIV>
References: <>
 <50e6b21c644b050a29e159c9484a5e01061434f6.camel@hammerspace.com>
 <174053988113.102979.18024415194793753569@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174053988113.102979.18024415194793753569@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 26, 2025 at 02:18:01PM +1100, NeilBrown wrote:

> Thanks.  I'll submit a patch through the VFS tree as I have other VFS
> patches in the works that will depend on that so having them together
> would be good.

Do it on top of mainline, please (say, -rc4) and let's put it into
a separate branch - easier that way to pull it into other branches
without causing headache.

