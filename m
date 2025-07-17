Return-Path: <linux-fsdevel+bounces-55240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26297B08BD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C14F3A2B16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E1B29ACE4;
	Thu, 17 Jul 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMgxtGdH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B525FDDAD
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752420; cv=none; b=f64nAPmV0sw9L0FStD4RxHea2DB1CiPh94u0MozcwqfLf66G+bbyMeYgAVuoqKV8PXruhB8WAqboh2pVuKzAtG4A0mX/etlVaVavxNLZ8XaS51HGmmRPAYH8vZ9cD0CRag1gkfhvfNDMCoH+026GdMFpp1FpEnUm3cAft96bScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752420; c=relaxed/simple;
	bh=5o4kSzifsJ/SJQTdh9Aq4lY0Xgrpq4UizldhjkY85ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUW5ZEWbDP+A8DjvAmQuwVckqVg8+HTIiYZWqh6LEoZE94AiRW+zCI7rq+OUN+knZEXlDsGVPyBpm2LArEBWFXvHps9gzk/7Kn61FzVujbkDsa83VGBEOtKd+74RGavM6Bh+VNsU0IZbdFGHT94F/vJKz5DqhFXKgoyWg5jJkKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMgxtGdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DB4C4CEE3;
	Thu, 17 Jul 2025 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752752420;
	bh=5o4kSzifsJ/SJQTdh9Aq4lY0Xgrpq4UizldhjkY85ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMgxtGdHoaPOcROdqskI4/JnyCygDwyKVgjCUuE3ObG8/BEHoy70pnudOAr8+zZmJ
	 J0DaMnZuVZx1g0sm6JC/qQw00xQq8Q/G6Yp9Hg5ChIabuIYjSmkYd7lMMY4SJ01/74
	 Y9e9Otm+J5IuSFRDWfwVm2YeS5K9cZwyszh5DleTjfrWDGTYiWb9XuS6WOdqWz0FxS
	 QAvJtvf8/2oe8Z6EHYKw3VDk4Mv1ruzfM+I4QpW8ztmPvowwlRZSqn1l+pfaFW7hYd
	 +KUrm7Kp73Fnu7c7BszEKXug1o/OTPr4dVjmQu7BU/K4iyEpWdJw/0wbrp+VdQSKnD
	 l+x4wTDDCnBNw==
Date: Thu, 17 Jul 2025 13:40:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250717-klammheimlich-rosen-1868e233883a@brauner>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <20250716112149.GA29673@lst.de>
 <20250716-unwahr-dumpf-835be7215e4c@brauner>
 <a24e87f111509bed526dd0a1650399edda9b75c0.camel@kernel.org>
 <aHeydTPax7kh5p28@casper.infradead.org>
 <20250716141030.GA11490@lst.de>
 <20250717-drehbaren-rabiat-850d4c5212fb@brauner>
 <scdueoausnzt2gusp2i5yt4nvf4adso7oe3gzunb4j5lavyi4p@xzzmjddppihf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <scdueoausnzt2gusp2i5yt4nvf4adso7oe3gzunb4j5lavyi4p@xzzmjddppihf>

On Thu, Jul 17, 2025 at 12:54:48PM +0200, Jan Kara wrote:
> On Thu 17-07-25 10:32:07, Christian Brauner wrote:
> > On Wed, Jul 16, 2025 at 04:10:30PM +0200, Christoph Hellwig wrote:
> > > On Wed, Jul 16, 2025 at 03:08:53PM +0100, Matthew Wilcox wrote:
> > > > struct filemap_inode {
> > > > 	struct inode		inode;
> > > > 	struct address_space	i_mapping;
> > > > 	struct fscrypt_struct	i_fscrypt;
> > > > 	struct fsverity_struct	i_fsverity;
> > > > 	struct quota_struct	i_quota;
> > > > };
> > > > 
> > > > struct ext4_inode {
> > > > 	struct filemap_inode inode;
> > > > 	...
> > > > };
> > > > 
> > > > saves any messing with i_ops and offsets.
> > > 
> > > I still wastest a lot of space for XFS which only needs inode
> > > and i_mapping of those.  As would most ext4 file systems..
> > 
> > We can do a hybrid approach:
> > 
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 2bc6a3ac2b8e..dda45b3f2122 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1198,9 +1198,7 @@ struct ext4_inode_info {
> > 
> >         kprojid_t i_projid;
> > 
> > -#ifdef CONFIG_FS_ENCRYPTION
> > -       struct fscrypt_inode_info       *i_fscrypt_info;
> > -#endif
> > +       struct vfs_inode_adjunct i_adjunct; /* Adjunct data for inode */
> >  };
> 
> Well, but if we moved also fsverity & quota & what not into
> vfs_inode_adjunct the benefit of such structure would be diminishing? Or
> am I misunderstanding the proposal? I think that the new method should
> strive for each filesystem inode to store only the info it needs and not
> waste space for things it isn't interested in.

The benefit will still be there for any filesystem that doesn't care
about any of it which is most of them. One could also just split this up
into topics: fsverity & fscrypt, quota likely separately, and then other
stuff. But we can also just do that later and start with splitting it
individually.

