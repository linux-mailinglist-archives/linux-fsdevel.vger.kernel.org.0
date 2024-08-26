Return-Path: <linux-fsdevel+bounces-27139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 178CA95EEAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474651C21865
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AC214A4E1;
	Mon, 26 Aug 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEnQl1QK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C2149DE8
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668931; cv=none; b=MOFZqa395U/B8+maafblSH6Yc/Lfv1/jQ8ToacjH1SUkAGLNlhLYFXZGz9xcZyn05D/0UAJIvqPMEKXLHL8iRWBSmVB4WCxm4rQ1tf3OUxFH0I5qsfz98vvpxdmhWNEf7eqpkQQcDdfJcL2EXZi37imunywVI5L/De3AHjc9+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668931; c=relaxed/simple;
	bh=bwjnIYpKpjgzcYKYHSjKgV9dg5Gpeu1/Lt9N2escRNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQk+hSM9WBNnBiO/K88bLocY2SWpMkhyTrU/42E7shk+YBpthTBrCEI9ozcTN4lCYOCKMnHKDehynatyHUCC6fUx3Zh0qn7VmJQygcxyI8YDx2RnUJi4JH52uEzsJRGK63r+1/ufGxYSG1zQCss0UXmoQJwv8e7IGZhpWs6PwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEnQl1QK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C2AC51408;
	Mon, 26 Aug 2024 10:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724668930;
	bh=bwjnIYpKpjgzcYKYHSjKgV9dg5Gpeu1/Lt9N2escRNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEnQl1QKwlWiv5NqtoIQ2hmsxfjjRtZJhkVGNu1dbeUBXKhzVWaDL91IZqd17lPUm
	 uw9Ag1gltsO/HwTjkMdHGlwoVhxEecSqGUw3f0s5cCdtsNT/QsM+kcU9j81358ACj4
	 QPZPOmW4OMYo88fSsKsqBbV/FSpz3ReC62Dx6zVtA8OnibkAamyfly0W6LF0pqiv1K
	 IV+RHib5Z6gQfbXG/psjBlWVSj4bfYgw/S83J9XHVaiHLKhJu/iEZnDBqAW3ixQpTA
	 A8rZ1oK8oXkXEwc81OgxAMuyx1dyJpI9P/CcA/PgY+0wxKS6xQbaLVaQUWiJa+dGDr
	 s2z6aD7rIXVuw==
Date: Mon, 26 Aug 2024 12:42:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Greg Ungerer <gregungerer@westnet.com.au>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/16] romfs: Convert romfs_read_folio() to use a folio
Message-ID: <20240826-hochbahn-amtieren-de17e3b16852@brauner>
References: <20240530202110.2653630-1-willy@infradead.org>
 <20240530202110.2653630-13-willy@infradead.org>
 <597dd1bb-43ee-4531-8869-c46b38df56bd@westnet.com.au>
 <ZrmBvo6c1N7YnJ6y@casper.infradead.org>
 <bafe6129-209b-4172-996e-5d79389fc496@westnet.com.au>
 <Zr0GTnPHfeA0P8nb@casper.infradead.org>
 <20240815-geldentwertung-riechen-0d25a2121756@brauner>
 <ca926bdf-906c-472f-b240-79997ccf86a9@westnet.com.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca926bdf-906c-472f-b240-79997ccf86a9@westnet.com.au>

On Mon, Aug 26, 2024 at 11:34:21AM GMT, Greg Ungerer wrote:
> 
> On 15/8/24 22:42, Christian Brauner wrote:
> > On Wed, Aug 14, 2024 at 08:32:30PM GMT, Matthew Wilcox wrote:
> > > On Mon, Aug 12, 2024 at 02:36:57PM +1000, Greg Ungerer wrote:
> > > > Yep, that fixes it.
> > > 
> > > Christian, can you apply this fix, please?
> > > 
> > > diff --git a/fs/romfs/super.c b/fs/romfs/super.c
> > > index 68758b6fed94..0addcc849ff2 100644
> > > --- a/fs/romfs/super.c
> > > +++ b/fs/romfs/super.c
> > > @@ -126,7 +126,7 @@ static int romfs_read_folio(struct file *file, struct folio *folio)
> > >   		}
> > >   	}
> > > -	buf = folio_zero_tail(folio, fillsize, buf);
> > > +	buf = folio_zero_tail(folio, fillsize, buf + fillsize);
> > >   	kunmap_local(buf);
> > >   	folio_end_read(folio, ret == 0);
> > >   	return ret;
> > 
> > Yep, please see #vfs.fixes. The whole series is already upstream.
> 
> Just a heads up, this is still broken in 6.11-rc5.

Pull request will be becoming today. Some fixes in the netfs library
caused some delays because they had to be redone a few times.

