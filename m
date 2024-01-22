Return-Path: <linux-fsdevel+bounces-8440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9EE836842
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 16:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C537B1F21D89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A674A6024C;
	Mon, 22 Jan 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PtQvFDUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33835FF0C;
	Mon, 22 Jan 2024 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935754; cv=none; b=QL7aqc3jzU8gNLvwPaZ1yLcdzjsWC7vMiZJ6evKV+ezp7HzohipULnkYBJvrSTWVE+qqKzF5mi8qAWZezdcmI0kOpKFZJ6QPOu4PkhqkeB0eyr7Fn8P60JBv/9WCN40ZjaTTeSq2/QDqgYPs4yN0guMUKseg++Wbcshgt/2XixQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935754; c=relaxed/simple;
	bh=kyWsi1lflAk62F6EHmBXI3C2GexH6zr3BdO3AakAaSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0VT3xQqPn+IEOz4o/WBoRvrUqUUmZTiXE9CqzUYnhWf/4p7ey3nqeEzRhZVvSKx1vU1A16qp2IVNh54e3hcRm6STcNflgKqvLW/vQ2DZXYLtQ8PESL1NqmjPPs0B2FEyKZ6sIyPTsX5P7YhEJccGOmz+yBhqulNZfHqmkNR0og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PtQvFDUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FB7C433B1;
	Mon, 22 Jan 2024 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705935753;
	bh=kyWsi1lflAk62F6EHmBXI3C2GexH6zr3BdO3AakAaSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtQvFDUJAtrOcjflFRQ0iI04ZPcVZ541fBxhg8XqTxh6yY2C+z6QU7W5ScDPb9nk0
	 bmfPyQqnEFrrhI86mtQz6gY3jag4IJGcXFTw2q442B4O+YY5nrV20ay69AUTfXSgST
	 jbQEosMvABiE2as/ZBbnGG7cII6G3ltI46of09ik=
Date: Mon, 22 Jan 2024 07:02:32 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: sedat.dilek@gmail.com
Cc: David Howells <dhowells@redhat.com>, ceph-devel@vger.kernel.org,
	davem@davemloft.net, eadavis@qq.com, edumazet@google.com,
	horms@kernel.org, jaltman@auristor.com, jarkko@kernel.org,
	jlayton@redhat.com, keyrings@vger.kernel.org, kuba@kernel.org,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
	markus.suvanto@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
	pengfei.xu@intel.com, smfrench@gmail.com, stable@vger.kernel.org,
	torvalds@linux-foundation.org, wang840925@gmail.com,
	sashal@kernel.org, pvorel@suse.cz
Subject: Re: [PATCH] keys, dns: Fix size check of V1 server-list header
Message-ID: <2024012218-unlocking-pushy-c7e6@gregkh>
References: <1850031.1704921100@warthog.procyon.org.uk>
 <CA+icZUUc_0M_6JU3dZzVqrUUrWJceY1uD8dO2yFMCwtHtkaa_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUUc_0M_6JU3dZzVqrUUrWJceY1uD8dO2yFMCwtHtkaa_Q@mail.gmail.com>

On Mon, Jan 22, 2024 at 08:32:20AM +0100, Petr Vorel wrote:
> From: Sedat Dilek <sedat.dilek@gmail.com>
> 
> On Wed, Jan 10, 2024 at 10:12 PM David Howells <dhowells@redhat.com> wrote:
> >
> >
> > Fix the size check added to dns_resolver_preparse() for the V1 server-list
> > header so that it doesn't give EINVAL if the size supplied is the same as
> > the size of the header struct (which should be valid).
> >
> > This can be tested with:
> >
> >         echo -n -e '\0\0\01\xff\0\0' | keyctl padd dns_resolver desc @p
> >
> > which will give "add_key: Invalid argument" without this fix.
> >
> > Fixes: 1997b3cb4217 ("keys, dns: Fix missing size check of V1 server-list header")
> 
> [ CC stable@vger.kernel.org ]
> 
> Your (follow-up) patch is now upstream.
> 
> https://git.kernel.org/linus/acc657692aed438e9931438f8c923b2b107aebf9
> 
> This misses CC: Stable Tag as suggested by Linus.
> 
> Looks like linux-6.1.y and linux-6.6.y needs it, too.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.6.11&id=da89365158f6f656b28bcdbcbbe9eaf97c63c474
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.72&id=079eefaecfd7bbb8fcc30eccb0dfdf50c91f1805

And 5.10.y and 5.15.y.  Now queued up, thanks.

greg k-h

