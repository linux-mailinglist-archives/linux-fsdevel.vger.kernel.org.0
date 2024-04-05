Return-Path: <linux-fsdevel+bounces-16165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE4D899A7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 12:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744D0281B7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 10:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E091649A8;
	Fri,  5 Apr 2024 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caMJ71mm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF48F27447;
	Fri,  5 Apr 2024 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312145; cv=none; b=FRf/9LI8EZtwQDI3NFDfVmKkFyomRACUHaHFr7JwEbEVbAcgfjekdqoKBd5qxyhfZ+yWy8Vge/CEdv/gvbvFdkqzdL05Ynol/1XBQ2ZZyYmbWgtBCIO7eVKfBDSh25Avi5Q94PP9Nqzhr/900qd7VeqthUDPeqYql1t1KqjqxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312145; c=relaxed/simple;
	bh=yIHeOwT1Z+4CwFKwe4RcKGCjnk0s2xBp+R1BOpUfFsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOoOkt2YAldLu2yTTJ5AyWwxcI4eJ851JbGwibmJNmAN9EJcvcEeRJainUrKwDhOvcF3MnozlI1MnfoRqOlrDGMiOdlriWn3WQJATMdaHEnCRIrl7NCcDNR2TjCMvn4bgtfRRTN1yyMs5gj2FOuySaLLthK7e/PgfIFjMvIquL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caMJ71mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F21BC433F1;
	Fri,  5 Apr 2024 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712312144;
	bh=yIHeOwT1Z+4CwFKwe4RcKGCjnk0s2xBp+R1BOpUfFsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caMJ71mmy73c69ZyZyNX4wS/2d8Gtly6EtzykUIE0yXHbrAMwv7eMWt2apQEno6io
	 8Ny3HtFvTnC9Gaz97HDodO14jUPgFC3leggZFXx05N0QdQvMLPMYwokSZFQfHYbZxp
	 O/nEAmSn8QWyea3nkipZVjXjYGJ9KgFkOeQnWOkMeRzcnwCDzqKGT2YLEgcy1zW6DW
	 epW118aIRpl+hKttSW1y64jhg1CcH5IhVBH6IsGyDznq/8k7bxLKOAjx7fl1UZW+BT
	 erfELlSyjrxr9gChb3R7X47yIZZ6/lr6monLIC+TD0k2YntQu2xsEIQ2MH1kiRPpGw
	 NigJI7ozoCNng==
Date: Fri, 5 Apr 2024 12:15:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, 
	linux-cachefs@redhat.com, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/26] mm: Export writeback_iter()
Message-ID: <20240405-kanarienvogel-besuchen-63c433180767@brauner>
References: <20240403124124.GA19085@lst.de>
 <20240403101422.GA7285@lst.de>
 <20240403085918.GA1178@lst.de>
 <20240328163424.2781320-1-dhowells@redhat.com>
 <20240328163424.2781320-16-dhowells@redhat.com>
 <3235934.1712139047@warthog.procyon.org.uk>
 <3300438.1712141700@warthog.procyon.org.uk>
 <3326107.1712149095@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3326107.1712149095@warthog.procyon.org.uk>

On Wed, Apr 03, 2024 at 01:58:15PM +0100, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > > So why are we bothering with EXPORT_SYMBOL at all?  Why don't you just
> > > send a patch replace all of them with EXPORT_SYMBOL_GPL()?
> > 
> > No my business.
> 
> Clearly it is as you're gradually replacing APIs with stuff that is GPL'd.
> 
> > But if you want to side track this let me just put this in here:
> > 
> > NAK to the non-GPL EXPORT of writeback_iter().
> 
> Very well, I'll switch that export to GPL.  Christian, if you can amend that
> patch in your tree?

Sorted yesterday night!

