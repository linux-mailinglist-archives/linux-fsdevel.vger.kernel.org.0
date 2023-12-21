Return-Path: <linux-fsdevel+bounces-6630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4736981AF48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 08:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F392854F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 07:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FAAD510;
	Thu, 21 Dec 2023 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p9aUctXy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE72C2C6;
	Thu, 21 Dec 2023 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FlGscbfTW0+KZ3jK5mNcHMl5tg6QSPd929CFqIP8WR4=; b=p9aUctXyb8mC3Y8J31qjUJd/Dm
	kXv/m0A37ctQPOfBFc5ArzhSiO0fWfVarlLSk8vvvvv/+l5lwCEMG/y7C1UsrruMCzuoiVzuB/yux
	EQnW7FqU+9ynAtgrB9TsBAjwd0z66pMobmqauRorvhD5vhNmZ1ItZg7AXrXM+XYtGTs6e1ehZvlkL
	Fm3dLRmAH3qmvfPQD0pKQPX3x6ZICAS+Bzr2vcSXAPotfuKzhE708sJ46Lw1YnpVCbQeqpdFKaqT9
	fivLhjGFX7ZgOTDXv6xfeDLr/iRTpC6KlfZWhaqTIdUXGecoiwZwaCpBGTTAVWTCjG2WTytOOJry4
	mQuh31qg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rGDL4-001IZE-2A;
	Thu, 21 Dec 2023 07:19:26 +0000
Date: Thu, 21 Dec 2023 07:19:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: ebiggers@kernel.org, jaegeuk@kernel.org, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] fscrypt: Drop d_revalidate if key is available
Message-ID: <20231221071926.GB1674809@ZenIV>
References: <20231215211608.6449-1-krisman@suse.de>
 <20231215211608.6449-3-krisman@suse.de>
 <20231221071402.GA1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221071402.GA1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 21, 2023 at 07:14:02AM +0000, Al Viro wrote:
> On Fri, Dec 15, 2023 at 04:16:02PM -0500, Gabriel Krisman Bertazi wrote:
> > fscrypt dentries are always valid once the key is available.  Since the
> > key cannot be removed without evicting the dentry, we don't need to keep
> > retrying to revalidate it.
> > 
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> > ---
> >  fs/crypto/fname.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> > index 7b3fc189593a..0457ba2d7d76 100644
> > --- a/fs/crypto/fname.c
> > +++ b/fs/crypto/fname.c
> > @@ -591,8 +591,15 @@ int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
> >  	 * reverting to no-key names without evicting the directory's inode
> >  	 * -- which implies eviction of the dentries in the directory.
> >  	 */
> > -	if (!(dentry->d_flags & DCACHE_NOKEY_NAME))
> > +	if (!(dentry->d_flags & DCACHE_NOKEY_NAME)) {
> > +		/*
> > +		 * If fscrypt is the only feature requiring
> > +		 * revalidation for this dentry, we can just disable it.
> > +		 */
> > +		if (dentry->d_op->d_revalidate == &fscrypt_d_revalidate)
> 
> Umm...  What about ceph?  IOW, why do we care how had we gotten to that
> function - directly via ->d_revalidate() or from ->d_revalidate() instance?

Nevermind.

