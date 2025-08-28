Return-Path: <linux-fsdevel+bounces-59490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FF2B39D77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B270D1C28223
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D2230F818;
	Thu, 28 Aug 2025 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTmj5NMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671A30DED4;
	Thu, 28 Aug 2025 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384729; cv=none; b=Hzb9fE929Jtpxsx3uyd2v2wnRrN7XLiudfejS4u+SnkOEMC8CXl0BhhsWDpt1Jd1c5DE2IwE7PVs5/o2tACs08R+3gJHXhGod5B689QLoiPJjCsfxKqaeSmWTdpEq8eHpZCER+q7J6qiame0XaHqv5A7DoTtcE8d2bB/gF8H/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384729; c=relaxed/simple;
	bh=LBfI+oUrZrcz6c7Hz14GFFzsTOks55XNb3aG4xxk+Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H98BnaZAg/C9Hy9y7pr5+rsfUjjI0VIgi+sTo0yJHUw1nVWfRfZT2Ezgy0032jz3WjzxCe2BqA9xKFua0WaJ+xXYpIWVtZC95Z5BIUrWDbrROts4ir3OZb3CmHLRan5ms3BvMr4NKUAPwU/qCPRvYxnsvGiOqidLIFpR+5yc4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTmj5NMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165CBC4CEF5;
	Thu, 28 Aug 2025 12:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756384729;
	bh=LBfI+oUrZrcz6c7Hz14GFFzsTOks55XNb3aG4xxk+Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTmj5NMyCBCma0X+i9vZneDWtnz+Wi2bAPnFvaPklZ2fTeNSGOxkx5N70GbokYhrN
	 j3SWk11s8P8eCsRgdKedmvTdb1ZKd6Elbv8WqhAS2hXWceKmC5sWoJSonjHKmL38rC
	 q2XcxZrzrSGlMtI5Ns0qYJ3zegWHQj8F7Cele/ZMPRO6+g9WGzpEUCOS48+qhcd0eB
	 vw8uHRdLox3R3YfX7Vpj1SlEZfPTLdZ8orgbUgpvCeq2wO+tHdchsf7BQj9aJkB1lO
	 pbgWK2mJQEUlxWJmgI7meB4p0dYeVQ3FG4PvLpfGGhRVLykhoWPIgPXdqoZbJlWfWZ
	 /7Tuk3sSbDimg==
Date: Thu, 28 Aug 2025 14:38:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, kernel-team@fb.com, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 43/54] fs: change inode_is_dirtytime_only to use
 refcount
Message-ID: <20250828-knicken-erpicht-daacec0648f3@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <caa80372b21562257d938b200bb720dcb53336cd.1756222465.git.josef@toxicpanda.com>
 <3aoxujvj27dpehe2xjswtf73wqffahusomomjqaqcmhufz2pzp@kndlcuu7anam>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3aoxujvj27dpehe2xjswtf73wqffahusomomjqaqcmhufz2pzp@kndlcuu7anam>

On Wed, Aug 27, 2025 at 12:06:12AM +0200, Mateusz Guzik wrote:
> On Tue, Aug 26, 2025 at 11:39:43AM -0400, Josef Bacik wrote:
> > We don't need the I_WILL_FREE|I_FREEING check, we can use the refcount
> > to see if the inode is valid.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  include/linux/fs.h | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index b13d057ad0d7..531a6d0afa75 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2628,6 +2628,11 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
> >  	__mark_inode_dirty(inode, I_DIRTY_SYNC);
> >  }
> >  
> > +static inline int icount_read(const struct inode *inode)
> > +{
> > +	return refcount_read(&inode->i_count);
> > +}
> > +
> >  /*
> >   * Returns true if the given inode itself only has dirty timestamps (its pages
> >   * may still be dirty) and isn't currently being allocated or freed.
> > @@ -2639,8 +2644,8 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
> >   */
> >  static inline bool inode_is_dirtytime_only(struct inode *inode)
> >  {
> > -	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
> > -				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
> > +	return (inode->i_state & (I_DIRTY_TIME | I_NEW)) == I_DIRTY_TIME &&
> > +	       icount_read(inode);
> >  }
> >  
> >  extern void inc_nlink(struct inode *inode);
> > @@ -3432,11 +3437,6 @@ static inline void __iget(struct inode *inode)
> >  	refcount_inc(&inode->i_count);
> >  }
> >  
> > -static inline int icount_read(const struct inode *inode)
> > -{
> > -	return refcount_read(&inode->i_count);
> > -}
> > -
> >  extern void iget_failed(struct inode *);
> >  extern void clear_inode(struct inode *);
> >  extern void __destroy_inode(struct inode *);
> > -- 
> > 2.49.0
> > 
> 
> nit: I would change the diff introducing icount_read() to already place
> it in the right spot. As is this is going to mess with blame for no good
> reason.

Fwiw, I did that in the preliminaries patch. Just looked at your comment
here.

