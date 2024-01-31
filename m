Return-Path: <linux-fsdevel+bounces-9604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC078433F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 03:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAA01F283E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 02:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63CCDF6E;
	Wed, 31 Jan 2024 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G498xFUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EB0611E;
	Wed, 31 Jan 2024 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668319; cv=none; b=QDXCR0/QLS30S6LnTSmJFKSsvGhuV3GYMvXM4oBNIH5358DuCihFztml21Z00ku+KeYuk9XL5Dhqh1d5UvI1vNhvmgeEWwR2w9a3QtPFanQ53S4qNqRyhU/rlI4Ptp/D3VUOoeAfYxeHEIEyKC2cTWRdxYuc2056S8prQqR9eWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668319; c=relaxed/simple;
	bh=djoFTXuxmksb/FdNwJVAeN6Af9a5fltCn/3BeXgcsxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5BthIHpkmx1waXuo7iBVHZqrW5eiiND3k5qmCt5N5I/UZtW7yojRXqB+si0Xp+yhjMNr4x1QZlG/Pdv3q7YlIEjVptKQnje28+2lUKHez2XleGsWEYj439WewojECMtNQHTtpY2gZZjHuhC9RyrO2EDXSQ3hF8RtPKlGfTFKvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G498xFUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AD7C433F1;
	Wed, 31 Jan 2024 02:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706668318;
	bh=djoFTXuxmksb/FdNwJVAeN6Af9a5fltCn/3BeXgcsxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G498xFUh+N8EeVWIa6bF34OWQdzTtoP+Y4iTIG/ugVxJ5uRGI9Tmy3N9VJSM0Eb03
	 5Yi+to2iuPepzWGviH7Iqk4RuWLmZly0mVQaWVZOlJdGGPewlO3dlIcgBEL/humtWU
	 hFGp7QORHSFyEwPOnZWL3Ul1ps3uXD/izeJQlAa8=
Date: Tue, 30 Jan 2024 18:31:58 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
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
	Julien Panis <jpanis@baylibre.com>,
	Jiri Slaby <jirislaby@kernel.org>, Thomas Huth <thuth@redhat.com>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <2024013045-manifesto-each-cbdc@gregkh>
References: <20240131014738.469858-1-jdamato@fastly.com>
 <20240131014738.469858-4-jdamato@fastly.com>
 <2024013001-prison-strum-899d@gregkh>
 <20240131022756.GA4837@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131022756.GA4837@fastly.com>

On Tue, Jan 30, 2024 at 06:27:57PM -0800, Joe Damato wrote:
> On Tue, Jan 30, 2024 at 06:08:36PM -0800, Greg Kroah-Hartman wrote:
> > On Wed, Jan 31, 2024 at 01:47:33AM +0000, Joe Damato wrote:
> > > +struct epoll_params {
> > > +	__aligned_u64 busy_poll_usecs;
> > > +	__u16 busy_poll_budget;
> > > +
> > > +	/* pad the struct to a multiple of 64bits for alignment on all arches */
> > > +	__u8 __pad[6];
> > 
> > You HAVE to check this padding to be sure it is all 0, otherwise it can
> > never be used in the future for anything.
> 
> Is there some preferred mechanism for this in the kernel that I should be
> using or is this as simple as adding a for loop to check each u8 == 0 ?

It's as simple as a loop :)


