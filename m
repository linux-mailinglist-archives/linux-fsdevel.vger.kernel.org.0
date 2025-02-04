Return-Path: <linux-fsdevel+bounces-40781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F55A27780
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 17:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9661A3A649D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68C421577A;
	Tue,  4 Feb 2025 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0ws8ySX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4130917BEBF;
	Tue,  4 Feb 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687538; cv=none; b=uDqAnOwD1c4nrZcwYxs6ciSursUqLuNyeuvyqhpQ45u89HXCyPv5ZcQSoMyBRSdLCapExyU83P194hF68Zp2FDeaznK/jV2EGKojNi5dXAGXKHwHIdADGdpON3uVNNgB1s6NQd+/IJu74Wv1+pJKM4guju2jGCv0H0YXFfwG+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687538; c=relaxed/simple;
	bh=UbhOxZiqrETevcfz6PoIcX6N+DtmOII92Z+RrlGk0Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUrsySAIIihtdEkepbA5NfAIOs4CjMHvcXu9Aouil+DzRunOhO0abXpGr4g2OwS//BOjlPmWKX49hBib/zPMxpg5xCN0O07P8j7xoat3Ki3HKOJL/pnDr7fYbmEGvU8vfAec7yx+oGv+epG/NCYvAoytBG88K1vrS7ZyiogapPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0ws8ySX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3057CC4CEDF;
	Tue,  4 Feb 2025 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738687537;
	bh=UbhOxZiqrETevcfz6PoIcX6N+DtmOII92Z+RrlGk0Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0ws8ySXbVJi4z6MWVoQdREXoi1DnEHADrKRiq0yo5uTE+AaPVpsoNRh7ncG51FMQ
	 cXj6LFtQwoCyEE54zxekn/eAe2LEkre7bavTstEg1UpVZo0cTCKfCTLDNQ4x4GABTa
	 67dIby/cn5Eta/+U+/AwrBcVt7pHRaE5M6zv3YlFhuuX1fW4YIiZT4pFG0kM9SH8/6
	 R5b8Ssw7/BzyDqdkoE5N3w1ah6fEuMp0iZczdB8y4gMpBt3uwTNLWmmJ4yhjGbd+nY
	 VetBmnmlYDU6Elai9mUydO47QADGg69TvtMbFHP96tGh8ma1hs/33hQIXm73LtkmYD
	 3UVXK3dBwqEeQ==
Date: Tue, 4 Feb 2025 17:45:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] statmount: add a new supported_mask field
Message-ID: <20250204-keimzelle-reibt-84877b62936c@brauner>
References: <20250203-statmount-v1-1-871fa7e61f69@kernel.org>
 <20250204-stengel-lodern-8e6ce624cf77@brauner>
 <8d07cfbab7b1d70b6fc381ad065d55773f73d93f.camel@kernel.org>
 <20250204-vintage-sozusagen-33df0d66bd6c@brauner>
 <3a139a0cca7772935dbc7e376d19547191143ce5.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a139a0cca7772935dbc7e376d19547191143ce5.camel@kernel.org>

On Tue, Feb 04, 2025 at 10:57:39AM -0500, Jeff Layton wrote:
> On Tue, 2025-02-04 at 16:09 +0100, Christian Brauner wrote:
> > On Tue, Feb 04, 2025 at 07:28:20AM -0500, Jeff Layton wrote:
> > > On Tue, 2025-02-04 at 12:07 +0100, Christian Brauner wrote:
> > > > On Mon, Feb 03, 2025 at 12:09:48PM -0500, Jeff Layton wrote:
> > > > > Some of the fields in the statmount() reply can be optional. If the
> > > > > kernel has nothing to emit in that field, then it doesn't set the flag
> > > > > in the reply. This presents a problem: There is currently no way to
> > > > > know what mask flags the kernel supports since you can't always count on
> > > > > them being in the reply.
> > > > > 
> > > > > Add a new STATMOUNT_SUPPORTED_MASK flag and field that the kernel can
> > > > > set in the reply. Userland can use this to determine if the fields it
> > > > > requires from the kernel are supported. This also gives us a way to
> > > > > deprecate fields in the future, if that should become necessary.
> > > > > 
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > > I ran into this problem recently. We have a variety of kernels running
> > > > > that have varying levels of support of statmount(), and I need to be
> > > > > able to fall back to /proc scraping if support for everything isn't
> > > > > present. This is difficult currently since statmount() doesn't set the
> > > > > flag in the return mask if the field is empty.
> > > > > ---
> > > > >  fs/namespace.c             | 18 ++++++++++++++++++
> > > > >  include/uapi/linux/mount.h |  4 +++-
> > > > >  2 files changed, 21 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > > > index a3ed3f2980cbae6238cda09874e2dac146080eb6..7ec5fc436c4ff300507c4ed71a757f5d75a4d520 100644
> > > > > --- a/fs/namespace.c
> > > > > +++ b/fs/namespace.c
> > > > > @@ -5317,6 +5317,21 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +/* This must be updated whenever a new flag is added */
> > > > > +#define STATMOUNT_SUPPORTED (STATMOUNT_SB_BASIC | \
> > > > > +			     STATMOUNT_MNT_BASIC | \
> > > > > +			     STATMOUNT_PROPAGATE_FROM | \
> > > > > +			     STATMOUNT_MNT_ROOT | \
> > > > > +			     STATMOUNT_MNT_POINT | \
> > > > > +			     STATMOUNT_FS_TYPE | \
> > > > > +			     STATMOUNT_MNT_NS_ID | \
> > > > > +			     STATMOUNT_MNT_OPTS | \
> > > > > +			     STATMOUNT_FS_SUBTYPE | \
> > > > > +			     STATMOUNT_SB_SOURCE | \
> > > > > +			     STATMOUNT_OPT_ARRAY | \
> > > > > +			     STATMOUNT_OPT_SEC_ARRAY | \
> > > > > +			     STATMOUNT_SUPPORTED_MASK)
> > > > 
> > > > Hm, do we need a separate bit for STATMOUNT_SUPPORTED_MASK? Afaiu, this
> > > > is more of a convenience thing but then maybe we just do:
> > > > 
> > > > #define STATMOUNT_SUPPORTED_MASK STATMOUNT_MNT_BASIC
> > > > 
> > > > and be done with it?
> > > > 
> > > > Otherwise I think it is worth having support for this.
> > > > 
> > > 
> > > Are you suggesting that we should just add the ->supported_mask field
> > > without a declaring a bit for it? If so, how would that work on old
> > > kernels? You'd never know if you could trust the contents of that field
> > > since the return mask wouldn't indicate any difference.
> > 
> > What I didn't realize because I hadn't read carefully enough in your
> > patch was that STATMOUNT_SUPPORTED_MASK is raised in ->mask and only
> > then is ->supported_mask filled in.
> > 
> > My thinking had been that ->supported_mask will simply always be filled
> > in by the kernel going forward. Which is arguably not ideal but would
> > work:
> > 
> > So the kernel guarantees since the introduction of statmount() that when
> > we copy out to userspace that anything the kernel doesn't know will be
> > copied back zeroed. So any unknown fields are zero.
> > 
> > (1) Say userspace passes a struct statmount with ->supported_mask to the
> >     kernel - even if it has put garbage in there or intentionally raised
> >     valid flags in there - the old kernel will copy over this and set it
> >     to zero.
> > 
> > (2) If you're on a new kernel but pass an old struct the kernel will
> >     fill in ->supported_mask. Imho, that's fine. Userspace simply will
> >     not know about it.
> > 
> > But we can leave the explicit request in!
> > 
> 
> 
> I can respin without STATMOUNT_SUPPORTED_MASK. I was thinking it left
> that part of the return buffer untouched, but if it's zeroed, then that
> works as well.
> 
> If you see a supported_mask of 0, you know the kernel didn't fill it in
> (since it should at least support _something_). That'll need to be
> carefully documented though.

It's probably easier for userspace if that flag must be specifically raised.

