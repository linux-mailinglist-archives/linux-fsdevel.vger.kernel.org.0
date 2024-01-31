Return-Path: <linux-fsdevel+bounces-9601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03042843321
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 03:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365C11C21BF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 02:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA2A5672;
	Wed, 31 Jan 2024 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cjp1OFPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97705223;
	Wed, 31 Jan 2024 02:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706666917; cv=none; b=ijfzzVjT6jYgkH34d8UX6TT1iKlht/yyf1p175VjOC6ys0jbVZkNaiuohi4UoFsWIk+QtpKcGEY/dXJV7TX9VcgqnHd+rAfMSidnvy1S8LV14GAS8+Z1e6p07d3tNQ8Pi0xsWRUytXY+G96VHtjgMNN3jKrl6FeJxeuoLdgRe+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706666917; c=relaxed/simple;
	bh=IBH1x5SGT6nGLDE7TxOtnN0YvnQkEver8imdueRKTDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSbVoDWdP0zoJoynYtiWJwRbI3KjACyPaBTtKbgIsFOnRTaSbkIMAj6/n18r+sK2SiIGgVQCNmEPshULW/vvRrCzw2/u5W12JFqWiUF9nH0qTqbRYR829Lpp2U3b55A4feH6/ScbfUXPUjtuHd7lv9uLE9NUvjo4dbTp3LPVQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cjp1OFPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85027C433F1;
	Wed, 31 Jan 2024 02:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706666916;
	bh=IBH1x5SGT6nGLDE7TxOtnN0YvnQkEver8imdueRKTDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cjp1OFPLc8a4EwCy4DTj45NxNuKb9gGIovN6fjagz0WBs9Q2oNt4wrBMB2wclD00Z
	 p0/VDOa22DaYJ4worUHIaKNidJXQoBv/Wc+0N5RxM+/4Z6MpypJG8WdJ/jUL5pMgQp
	 Gduct+iEoXTiI9szqnyCcweZ0tachHDVKilhKvHU=
Date: Tue, 30 Jan 2024 18:08:36 -0800
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
Message-ID: <2024013001-prison-strum-899d@gregkh>
References: <20240131014738.469858-1-jdamato@fastly.com>
 <20240131014738.469858-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131014738.469858-4-jdamato@fastly.com>

On Wed, Jan 31, 2024 at 01:47:33AM +0000, Joe Damato wrote:
> +struct epoll_params {
> +	__aligned_u64 busy_poll_usecs;
> +	__u16 busy_poll_budget;
> +
> +	/* pad the struct to a multiple of 64bits for alignment on all arches */
> +	__u8 __pad[6];

You HAVE to check this padding to be sure it is all 0, otherwise it can
never be used in the future for anything.

thanks,

greg k-h

