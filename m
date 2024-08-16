Return-Path: <linux-fsdevel+bounces-26143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B912954FF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 19:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AEE1F25A3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 17:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95731C230E;
	Fri, 16 Aug 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="keliqowv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962072BB0D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828982; cv=none; b=ZdrSpFvQNmc4gRP12l6NtZ1sQ/tyXau4s0F440W+OZjJjCDbAzLTFEwLmLareJqhWjeU5NrFHqqznXUcOvZ24V2NrZ/C7cY+w54R5T2Vh0caE3WOXoodxKhpK9hStL5xJFHIMtSGaEqqeaRAs3fAiNRGvOwYiXceiKNT3iwqCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828982; c=relaxed/simple;
	bh=vl8R5U87bSlR4b7hwPZ6eCTc9T+v/pzyr1w+pppq7DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap65lyhVttEODH5qEIyHYZWuqFSOqCdIY0844lf3CKGDst1oZmox5IPyHW1s3Wfthyffcy8eEXnfdkz3JF8p1nPTPkd46wiclVbdtykYcdsihXMcYQPKf4qo3RjifZ69aoaB3LbCvk+U6jIuwcYIh43dE0zorNI4ENZRj3yX5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=keliqowv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P8ANIVlyDQ/t9cCk1cGTAhsqmcvFF9OGTrgGAaLzOSA=; b=keliqowv2ejl+bYoPKeRl++Sht
	waS6rHsLGFYe1BT8fbFSv/wsuER7XIu5/TDgxSMV6IXIrYBRfoVgCXkZE2N1Vgltl5QLIK0LUrE/V
	Uc1atk3FH5bkIkeWBmhQx/5uyv/VPLe1cnS8HXECzSn/5abthOE0WzQTu6Uc2etpHEzKMVhglRiMB
	5l7F0bpq7xP1gUMfwmYyfQggamdLlZWo8lqB2g7wAPm0ntgFLRlwpvmCti7kWhZdsTHINphYnRdly
	Cgfr5JhGEdZ4vp+AQsBki5gw1uKlnk1qpZ9/S/ps1xB+y75xwQkO7VBiwkesRFQAREp7DrQY7eFF6
	g5tzo8jQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sf0fC-00000002MzF-07sy;
	Fri, 16 Aug 2024 17:22:58 +0000
Date: Fri, 16 Aug 2024 18:22:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] more close_range() fun
Message-ID: <20240816172257.GC504335@ZenIV>
References: <20240816030341.GW13701@ZenIV>
 <CAHk-=wh_K+qj=gmTjiUqr8R3x9Tco31FSBZ5qkikKN02bL4y7A@mail.gmail.com>
 <20240816171925.GB504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816171925.GB504335@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 16, 2024 at 06:19:25PM +0100, Al Viro wrote:
> On Fri, Aug 16, 2024 at 09:26:45AM -0700, Linus Torvalds wrote:
> > On Thu, 15 Aug 2024 at 20:03, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > It *can* actually happen - all it takes is close_range(2) decision
> > > to trim the copied descriptor table made before the first dup2()
> > > and actual copying done after both dup2() are done.
> > 
> > I think this is fine. It's one of those "if user threads have no
> > serialization, they get what they get" situations.
> 
> As it is, unshare(CLOSE_FILES) gives you a state that might be possible

CLONE_FILES, that is.

