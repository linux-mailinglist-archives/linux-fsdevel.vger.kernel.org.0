Return-Path: <linux-fsdevel+bounces-26066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFFF95326C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 16:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A0CB25E52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 14:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040AB1AD3FD;
	Thu, 15 Aug 2024 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bUve43u4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575791AC432;
	Thu, 15 Aug 2024 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730649; cv=none; b=SOa8ZJA9q99tEopJoY+FZpXFOypGcq49sOCbCLXKjXt76fCCtp3mHoMr18vG65bs4uDCcQjUR+n1xHCWA0Py094x9DRoyZYjStl+J4k+mwCmw1Wy9rmkwvqHErJWO6+WJTKW3JQ7DsTe9edU3UofkkF35Nmq1lnpQx/AltoK1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730649; c=relaxed/simple;
	bh=IyNq08OOPD3iI6K9aKbI+QxdbiNrOV2VF4erWCqy+x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrpQ2OxE64B32LFLq1YbLlwJ13hVFw9otrC+LJJADHxfo+VUTFVDh8GK7dN5erXCSnQOnz5q6aipicU8c0vdZCqK3RWvhwM1lsMNzE2Q7y68w6Gb4hrVd5i5zkn9nMKUJE1/wO1vpNaQtIWxHZksHAxrE0JabTXuUFAlju8FJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bUve43u4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A9AC4AF0F;
	Thu, 15 Aug 2024 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730649;
	bh=IyNq08OOPD3iI6K9aKbI+QxdbiNrOV2VF4erWCqy+x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bUve43u4OECaExKFcujr9GiZUZ++T2sXa0YmIcXhTA/AICjb19ONW/NmkA0V05WJQ
	 qkRUbvIUkgtgUJ5/79NOSBFlvKQsFpi5TLAKXT47oDjrz92ibe0dSaRxlzQy77CvZf
	 EfEOKsA8Aue024nO6h2615cQZCnhLpQ/1WKylq9I=
Date: Thu, 15 Aug 2024 10:04:07 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>, 
	Max Kellermann <max.kellermann@ionos.com>, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org
Subject: Re: [PATCH] netfs, ceph: Partially revert "netfs: Replace PG_fscache
 by setting folio->private and marking dirty"
Message-ID: <20240815-wakeful-satisfied-bittern-e04bd5@lemur>
References: <2181767.1723665003@warthog.procyon.org.uk>
 <20240815-seiten-vorteil-168ac82432a7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240815-seiten-vorteil-168ac82432a7@brauner>

On Thu, Aug 15, 2024 at 02:51:58PM GMT, Christian Brauner wrote:
> @Konstantin, for some reason I keep having issues with this patch
> series. It confuses b4 to no end. When I try to shazam this single patch
> here using 2181767.1723665003@warthog.procyon.org.uk it pull down a 26
> patch series. And with -P _ it complains that it can't find the messag
> id.

I cannot reproduce this, which suggests to me that there's something going on
with cached data specific to your local content. Can you please run the
following:

    b4 -d shazam 2181767.1723665003@warthog.procyon.org.uk > /tmp/b4-debug.out 2>&1

then gzip and send that to me?

-K

