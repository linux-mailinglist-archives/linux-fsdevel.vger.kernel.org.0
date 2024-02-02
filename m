Return-Path: <linux-fsdevel+bounces-9951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CA8846645
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 04:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F49828A76F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 03:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1880FFBFC;
	Fri,  2 Feb 2024 03:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="b/aMu8Jo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E88F9EB;
	Fri,  2 Feb 2024 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843090; cv=none; b=Sq+aneq3nR7abwyqx6T35uRnq19fNOOCOwiDM3mGRfeHn5PpQmCJT23+tyVAIPYMbczm8skFbVhpTczSHqNfOokk4rAsPk0+p0UGWztBrolI7r/9Y0DoAGak4I7EsfYxGfpzObxor6y5tyPXjkctJJsZHp4Y5fejOp3v03atMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843090; c=relaxed/simple;
	bh=8fHK8o8jc9om6S6NsTKmiBFNLkn6v1fUilTyI9/jVVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSVc3SZGXxHQrTUnt6HIaUGw8QF9rZI6UqAWqV63jrwmvJ7ZegP+iilFuYkXwTly1tmFRNjOh0XyWXuI97ATieNxaPNRFiGbOKgl0LjA/DzzXh8MVnyDxlXfPmg1MS9QNMUnWcah0W/c6kH50T96axGVHaVmb5H9LqUN7xqUeGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=b/aMu8Jo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=skwCDGnLP4ByDSOBblEedQL0pq1fFuzhc2BhN7e3aHY=; b=b/aMu8JoyIi6pJYBgWcGXN8/UL
	ZV4PD80UgkfKr6pNS8JG1V4UccwxSlYwrgseJJPFEZpuLwVa38MCxyhgHRo5KdncYIge1WN+dpbqS
	B/1lOpLFqm2CKapZ6zJ4X5rP0E9ppzecAfULowIMwbcSNmIT80kFFjW7GDT8mdZxu2xyQ6l1D7XGF
	q3PGSLF044jinUnnTJjlThb6VV31oS8mUd7z1EJSenxFA0Nq06FvNXOzOSdMQeFNFZPGacvJ9byOz
	qyKNcOnAu5QzJoxF27mka7u/ZWgwVBgWf1BJ7vQL6+knhEqc/KZTEmNMsvHBDB7ucfRKXsAyn6ihr
	8MIH4/Rg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVjr4-003cIj-1h;
	Fri, 02 Feb 2024 03:04:38 +0000
Date: Fri, 2 Feb 2024 03:04:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Doug Anderson <dianders@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
Message-ID: <20240202030438.GV2087318@ZenIV>
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <20240202012249.GU2087318@ZenIV>
 <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 01, 2024 at 06:54:51PM -0800, Doug Anderson wrote:
> >         What the hell?  Which regset could have lead to that?
> > It would need to have the total size of register in excess of
> > 256K.  Seriously, which regset is that about?  Note that we
> > have just made sure that size is not greater than that product.
> > size is unsigned int, so it's not as if a negative value passed
> > to function could get through that test only to be interpreted
> > as large positive later...
> >
> >         Details, please.
> 
> I can continue to dig more, but it is easy for me to reproduce this.
> On the stack is elf_core_dump() and it seems like we're getting a core
> dump of the chrome process. So I just arbitrarily look for the chrome
> GPU process:
> 
> $ ps aux | grep gpu-process
> chronos   2075  3.0  1.1 34075552 95372 ?      S<l  18:44   0:01
> /opt/google/chrome/chrome --type=gpu-process ...
> 
> Then I send it a quit:
> 
> $ kill -quit 2075
> 
> I added some printouts for this allocation and there are a ton. Here's
> all of them, some of which are over 256K:

Well, the next step would be to see which regset it is - if you
see that kind of allocation, print regset->n, regset->size and
regset->core_note_type.

