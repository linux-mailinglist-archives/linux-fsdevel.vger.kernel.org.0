Return-Path: <linux-fsdevel+bounces-9671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D08443F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 17:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053101F2BE33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D5D12BF22;
	Wed, 31 Jan 2024 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CgORUqrJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D712BF04;
	Wed, 31 Jan 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717815; cv=none; b=DtlDLfrOpFKrgioGhjBUy4lPhId86mTNvTPgFy8Gnxm56g36zsTHfKIcfvqYmU20WLzuGyi/dUPDMYOcLNcGKsX2DLV6NUjGmGGE+hGCb3YOeQNMGpDKgwH0UFLLme1MZ3H7k9MyQrj4BkNGUUMGif3A9E5u0VCTos8y4Yup2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717815; c=relaxed/simple;
	bh=UWlq1EvrM0m1ICwPMbYYxNGA47wTvXH22WzmLVpjSio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYO+zqimSqrEDPrvrtPfhVH6616/+e8MtYUvpuvT3pjuhPLP58GKGfoEiXToJGa6vWvx7VEAqFzK8aOUWnFWNfumkLnaQLPhTkk8TaJZpu7ZM4SP5XvkvQ5Cc4OZqwMY/T3LUVfRnC/DHObq2kbDJXfUA6HUibIcN09F7ili5Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CgORUqrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE299C43394;
	Wed, 31 Jan 2024 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706717814;
	bh=UWlq1EvrM0m1ICwPMbYYxNGA47wTvXH22WzmLVpjSio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgORUqrJmMRy+gVz2WCDjKWTEcugunpPRz1KOkLESVexKQmfsQnJYdqUuBz3sUPZ5
	 uarGdPXOwzHzLluU5h8xUdzXA/6nuIWUeZPHlK37WXT8q8/lDhrNKur26A4mv8mYh4
	 u8PERyhH9A4LdAC+CI34Ay5qoQNbZssp3TOu4CAk=
Date: Wed, 31 Jan 2024 08:16:54 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org,
	willemdebruijn.kernel@gmail.com, weiwan@google.com,
	David.Laight@aculab.com, arnd@arndb.de,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maik Broemme <mbroemme@libmpq.org>,
	Steve French <stfrench@microsoft.com>,
	Julien Panis <jpanis@baylibre.com>, Thomas Huth <thuth@redhat.com>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <2024013145-payment-enjoyment-6274@gregkh>
References: <20240131014738.469858-1-jdamato@fastly.com>
 <20240131014738.469858-4-jdamato@fastly.com>
 <2024013001-prison-strum-899d@gregkh>
 <20240131022756.GA4837@fastly.com>
 <efee9789-4f05-4202-9a95-21d88f6307b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efee9789-4f05-4202-9a95-21d88f6307b0@kernel.org>

On Wed, Jan 31, 2024 at 07:03:54AM +0100, Jiri Slaby wrote:
> On 31. 01. 24, 3:27, Joe Damato wrote:
> > On Tue, Jan 30, 2024 at 06:08:36PM -0800, Greg Kroah-Hartman wrote:
> > > On Wed, Jan 31, 2024 at 01:47:33AM +0000, Joe Damato wrote:
> > > > +struct epoll_params {
> > > > +	__aligned_u64 busy_poll_usecs;
> > > > +	__u16 busy_poll_budget;
> > > > +
> > > > +	/* pad the struct to a multiple of 64bits for alignment on all arches */
> > > > +	__u8 __pad[6];
> > > 
> > > You HAVE to check this padding to be sure it is all 0, otherwise it can
> > > never be used in the future for anything.
> > 
> > Is there some preferred mechanism for this in the kernel that I should be
> > using or is this as simple as adding a for loop to check each u8 == 0 ?
> 
> You are likely looking for memchr_inv().

Ah, never noticed that, thanks!

