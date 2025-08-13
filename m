Return-Path: <linux-fsdevel+bounces-57655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18216B24370
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918391894F1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921F02BE65A;
	Wed, 13 Aug 2025 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zSX0e3HN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BFA2EA172;
	Wed, 13 Aug 2025 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071694; cv=none; b=UnxrGR/tN99/HcgOb5STmBTlu7OB87WcsrJs+R/mXjNaNAr7b/kwZfVcFw0qDtQzpY6/SQoV5SCGPpHDf3gtn6WDVeoGwnldUAd04Ni9+VEK9SR56v3meHFYnWwLq2Kud2+6r6go5a2HyAGSQxMcdDuGpfxwO7xf02+ZQ6Vb2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071694; c=relaxed/simple;
	bh=nhmeHZzqroCvs7ulB28xjaiWqbSDAQeSQWycbTLLpD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkG4BMcH2tEzVr1lPf+UfT3QFDXYcJhWmziIMrtoIOaZJELXrOhw9lr3HS1pWwLnb9gNJLumPof5FRGngrq6HA66rYtm+1R7zg7iYd97gbwlrdBTu1uoDiR4wt2iUCEjGNSSjTxP9k/mSK5l8oM5/d5z0leapXlk6lytoHjoEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zSX0e3HN; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c20p45mmJzYTn;
	Wed, 13 Aug 2025 09:47:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1755071244;
	bh=kiYuZJB2YsWQDkZMPyAoNj5aBOt/37ctd8+2F4wCRdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zSX0e3HNonQS4B90zVb9aRW3SYtNmR0KTfjhrSR25eWnG9ML3hB2N46KXhJUfIOKS
	 2Q07fGgBWP4Si/2CRscB21x5K4gduiOhf4c6Gy2FUvtz5CGZ5n3u14+q/S/TEVC8Mu
	 9uFq35qoK4XnIyqxrWr9z/N8GuaqnccIU5MoI1QE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4c20p36NYVzM9Z;
	Wed, 13 Aug 2025 09:47:23 +0200 (CEST)
Date: Wed, 13 Aug 2025 09:47:21 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	v9fs@lists.linux.dev, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] fs/9p: Add ability to identify inode by path for
 .L
Message-ID: <20250813.dei7hooKa2ie@digikod.net>
References: <cover.1743971855.git.m@maowtm.org>
 <e839a49e0673b12eb5a1ed2605a0a5267ff644db.1743971855.git.m@maowtm.org>
 <20250705002536.GW1880847@ZenIV>
 <b32e2088-92c0-43e0-8c90-cb20d4567973@maowtm.org>
 <20250808.oog4xee5Pee2@digikod.net>
 <df6cb208-cb14-4ca5-bd25-cb0f05bfc6a1@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df6cb208-cb14-4ca5-bd25-cb0f05bfc6a1@maowtm.org>
X-Infomaniak-Routing: alpha

On Wed, Aug 13, 2025 at 12:57:49AM +0100, Tingmao Wang wrote:
> Thanks for the review :)  I will try to send a v2 in the coming weeks with
> the two changes you suggested and the changes to cached mode as suggested
> by Dominique (plus rename handling).  (will also try to figure out how to
> test with xfstests)
> 
> On 8/8/25 09:32, Mickaël Salaün wrote:
> > [...]
> >> On 7/5/25 01:25, Al Viro wrote:
> >>> On Sun, Apr 06, 2025 at 09:43:02PM +0100, Tingmao Wang wrote:
> >>>> +bool ino_path_compare(struct v9fs_ino_path *ino_path,
> >>>> +			     struct dentry *dentry)
> >>>> +{
> >>>> +	struct dentry *curr = dentry;
> >>>> +	struct qstr *curr_name;
> >>>> +	struct name_snapshot *compare;
> >>>> +	ssize_t i;
> >>>> +
> >>>> +	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
> >>>> +
> >>>> +	rcu_read_lock();
> >>>> +	for (i = ino_path->nr_components - 1; i >= 0; i--) {
> >>>> +		if (curr->d_parent == curr) {
> >>>> +			/* We're supposed to have more components to walk */
> >>>> +			rcu_read_unlock();
> >>>> +			return false;
> >>>> +		}
> >>>> +		curr_name = &curr->d_name;
> >>>> +		compare = &ino_path->names[i];
> >>>> +		/*
> >>>> +		 * We can't use hash_len because it is salted with the parent
> >>>> +		 * dentry pointer.  We could make this faster by pre-computing our
> >>>> +		 * own hashlen for compare and ino_path outside, probably.
> >>>> +		 */
> >>>> +		if (curr_name->len != compare->name.len) {
> >>>> +			rcu_read_unlock();
> >>>> +			return false;
> >>>> +		}
> >>>> +		if (strncmp(curr_name->name, compare->name.name,
> >>>> +			    curr_name->len) != 0) {
> >>>
> >>> ... without any kind of protection for curr_name.  Incidentally,
> >>> what about rename()?  Not a cross-directory one, just one that
> >>> changes the name of a subdirectory within the same parent?
> >>
> >> As far as I can tell, in v9fs_vfs_rename, v9ses->rename_sem is taken for
> >> both same-parent and different parent renames, so I think we're safe here
> >> (and hopefully for any v9fs dentries, nobody should be causing d_name to
> >> change except for ourselves when we call d_move in v9fs_vfs_rename?  If
> >> yes then because we also take v9ses->rename_sem, in theory we should be
> >> fine here...?)
> > 
> > A lockdep_assert_held() or similar and a comment would make this clear.
> 
> I can add a comment, but there is already a lockdep_assert_held_read of
> the v9fs rename sem at the top of this function.

I wrote this comment before reading your new version beneath, which
already have this lockdep, so no need to change anything. :)

> 
> > [...]
> >> /*
> >>  * Must hold rename_sem due to traversing parents
> >>  */
> >> bool ino_path_compare(struct v9fs_ino_path *ino_path, struct dentry *dentry)
> >> {
> >> 	struct dentry *curr = dentry;
> >> 	struct name_snapshot *compare;
> >> 	ssize_t i;
> >>
> >> 	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
> >>
> >> 	rcu_read_lock();
> >> 	for (i = ino_path->nr_components - 1; i >= 0; i--) {
> >> 		if (curr->d_parent == curr) {
> >> 			/* We're supposed to have more components to walk */
> >> 			rcu_read_unlock();
> >> 			return false;
> >> 		}
> >> 		compare = &ino_path->names[i];
> >> 		if (!d_same_name(curr, curr->d_parent, &compare->name)) {
> >> 			rcu_read_unlock();
> >> 			return false;
> >> 		}
> >> 		curr = curr->d_parent;
> >> 	}
> >> 	rcu_read_unlock();
> >> 	if (curr != curr->d_parent) {
> 
> Looking at this again I think this check probably needs to be done inside
> RCU, will fix as below:
> 
> >> 		/* dentry is deeper than ino_path */
> >> 		return false;
> >> 	}
> >> 	return true;
> >> }
> 
> diff --git a/fs/9p/ino_path.c b/fs/9p/ino_path.c
> index 0000b4964df0..7264003cb087 100644
> --- a/fs/9p/ino_path.c
> +++ b/fs/9p/ino_path.c
> @@ -77,13 +77,15 @@ void free_ino_path(struct v9fs_ino_path *path)
>  }
>  
>  /*
> - * Must hold rename_sem due to traversing parents
> + * Must hold rename_sem due to traversing parents.  Returns whether
> + * ino_path matches with the path of a v9fs dentry.
>   */
>  bool ino_path_compare(struct v9fs_ino_path *ino_path, struct dentry *dentry)
>  {
>  	struct dentry *curr = dentry;
>  	struct name_snapshot *compare;
>  	ssize_t i;
> +	bool ret;
>  
>  	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
>  
> @@ -101,10 +103,8 @@ bool ino_path_compare(struct v9fs_ino_path *ino_path, struct dentry *dentry)
>  		}
>  		curr = curr->d_parent;
>  	}
> +	/* Comparison fails if dentry is deeper than ino_path */
> +	ret = (curr == curr->d_parent);
>  	rcu_read_unlock();
> -	if (curr != curr->d_parent) {
> -		/* dentry is deeper than ino_path */
> -		return false;
> -	}
> -	return true;
> +	return ret;
>  }

Looks good

> 
> > 
> > I like this new version.
> > 
> 

