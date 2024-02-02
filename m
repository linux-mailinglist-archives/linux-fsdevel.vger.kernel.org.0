Return-Path: <linux-fsdevel+bounces-10050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DD984755A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE40AB2455B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F87149005;
	Fri,  2 Feb 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DVkgZZfi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B701487C1;
	Fri,  2 Feb 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892599; cv=none; b=nzctPdyB2boCj3TFGe8aisqH3kkcZwQfu9+wjQzJAZ/02PaIDpBBgCIcjiAdUAoA+qYZIeJcfdTneo1wYNzFy7Jtsjy4ooTCBCSKb0+AlXeUfsuWLCmGBH1EcHG82CZmIYlxrLw0zmVBaV9jX7IO1Dfi82AlIU7GbziwCZRHf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892599; c=relaxed/simple;
	bh=gnFe0Frak2hFCx8RZtBOH/vB3WQDtpNqAaGgzrVnBdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4W7dCPnF/0wt8v1cyJvWAlDo0+xBRmyfzKqL9amQPnteIzYmy1m4dej2IvjY6HP+mTTasKV/4TMKkh4WiovCqQXg9f2KCGr5XI2W2PwULDCLaOznzMPPXCys3tIcYuDlSSQhscqPvH8r9i/DWnqw/5sCHbnz5w8GE0gc0QCBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DVkgZZfi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=s9JPuMGns8g3lIGXW/Eg6QZhxZ7uPg73+hdVmq5mOgM=; b=DVkgZZfi2r2C6r6Wp9n1fbDZkc
	DDthIagMB72CZNj3c6Nd+qnHEjDJhCtk+e7YNlPIhSqbXDIlapav868Tf9f0/nGKw/U7L571XMIo/
	5Eae+fjojVYAmCBw2LZrYx1fVhXpXagV6YrjFm31MBr9ITLM++fJ32peBWHWA/YkQKCYl0OHDrwfr
	Zo6hElXlTyGl43i2hChpfarFNlP0vWwH0XO6sSiqypqKfPoqU8FWG0fOULIEZ6sfvBQCwB6nr3glw
	R6Cs4T7oJSHCS1ujs+1XRpag4wm5e76zFGg+MKHKGHA1W+YALv8TKXFVZ+RVTsApAkdeSQt7lm75k
	BJ9uapJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVwjb-0047ud-1N;
	Fri, 02 Feb 2024 16:49:47 +0000
Date: Fri, 2 Feb 2024 16:49:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Doug Anderson <dianders@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Oleg Nesterov <oleg@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
Message-ID: <20240202164947.GC2087318@ZenIV>
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <20240202012249.GU2087318@ZenIV>
 <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV>
 <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
 <20240202034925.GW2087318@ZenIV>
 <20240202040503.GX2087318@ZenIV>
 <CAD=FV=X93KNMF4NwQY8uh-L=1J8PrDFQYu-cqSd+KnY5+Pq+_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=X93KNMF4NwQY8uh-L=1J8PrDFQYu-cqSd+KnY5+Pq+_w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 02, 2024 at 08:24:17AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Thu, Feb 1, 2024 at 8:05 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, Feb 02, 2024 at 03:49:25AM +0000, Al Viro wrote:
> > > On Thu, Feb 01, 2024 at 07:15:48PM -0800, Doug Anderson wrote:
> > > > >
> > > > > Well, the next step would be to see which regset it is - if you
> > > > > see that kind of allocation, print regset->n, regset->size and
> > > > > regset->core_note_type.
> > > >
> > > > Of course! Here are the big ones:
> > > >
> > > > [   45.875574] DOUG: Allocating 279584 bytes, n=17474, size=16,
> > > > core_note_type=1029
> > >
> > > 0x405, NT_ARM_SVE
> > >         [REGSET_SVE] = { /* Scalable Vector Extension */
> > >                 .core_note_type = NT_ARM_SVE,
> > >                 .n = DIV_ROUND_UP(SVE_PT_SIZE(SVE_VQ_MAX, SVE_PT_REGS_SVE),
> > >                                   SVE_VQ_BYTES),
> > >                 .size = SVE_VQ_BYTES,
> > >
> > > IDGI.  Wasn't SVE up to 32 * 2Kbit, i.e. 8Kbyte max?  Any ARM folks around?
> > > Sure, I understand that it's variable-sized and we want to allocate enough
> > > for the worst case, but can we really get about 280Kb there?  Context switches
> > > would be really unpleasant on such boxen...
> >
> > FWIW, this apparently intends to be "variable, up to SVE_PT_SIZE(...) bytes";
> > no idea if SVE_PT_SIZE is the right thing to use here.
> 
> +folks from `./scripts/get_maintainer.pl -f arch/arm64/kernel/ptrace.c`
> 
> Trying to follow the macros to see where "n" comes from is a maze of
> twisty little passages, all alike. Hopefully someone from the ARM
> world can help tell if the value of 17474 for n here is correct or if
> something is wonky.

It might be interesting to have it print the return value of __regset_get()
in those cases; if *that* is huge, we really have a problem.  If it ends up
small enough to fit into few pages, OTOH...

SVE_VQ_MAX is defined as 255; is that really in units of 128 bits?  IOW,
do we really expect to support 32Kbit registers?  That would drive the
size into that range, all right, but it would really suck on context
switches.

I could be misreading it, though - the macros in there are not easy to
follow and I've never dealt with SVE before, so take the above with
a cartload of salt.

