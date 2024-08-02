Return-Path: <linux-fsdevel+bounces-24877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4E9945FCF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 17:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9578C1C213B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C9C2101B9;
	Fri,  2 Aug 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tT1tcJxp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADDD1E486B;
	Fri,  2 Aug 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611033; cv=none; b=Rj4s+I/z2t4D6AVQpXR2h4bWS0JEKekWJ22NhCYigdmeBA4UOb9PlHMoPefcmTjyooREOWy6BB/j5XsD/eWY/bXkJQbsSZyOiqs343csdzGukBeH19FlaZ9nxEiplnw6Km1kE21OoxQ1h3a1SSQH8VW3F8c8Y3ZUdWtUhgld4vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611033; c=relaxed/simple;
	bh=NFbE6wcKOrGwIHjrSYbTyK8tMuT7kg3hhHMG+9xGGoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fa89feuC/eWQrtEfx8mAEXixp3+e9orJHASCWjeRjvJKLYkIIw+idSk+lFE2s7STjzwg7JjaGDmwQBwzGNkez31RGRgQJsTOVKRgjCVr3WqbnfRwB8wnb0IRxugBVpyX/ef+I8adiy/TjVTylvwkjxr/gN6HxGCPnqB7XC6s4tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tT1tcJxp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CqEkaHSEEPeOywt8SbTu6VXQzxUsBKtJMu8dGqAFKS0=; b=tT1tcJxpzDsSFshX9jXzy2hGk2
	WQXchSk8VqnCtCBd9gUcZIMIj5Ph3OWKALzlxnjH8/8IIYawSOqL0FKwpHlQDPv3NTOT813l+RQLk
	y1abLCE1RIKaVJf6loU8/FoAxfFR4iN+IZGGEomesmjDoxfIprSLyEYY6qzVowNZeg4V2nHrONfxa
	Srjq2EtKr+i1aQipbmavG9TdXoKvlfss/kiMBOwrNCkJ1j/7oL4NY1jNAWLIdF7FI5GPhK6cu53Bm
	+AXLR9bfzeSAK9QLs1BdcOssVRcUyPYGaMnlywLruCuf3M07qnIy1/wBYyzM5l+Oo4Cl1m5p+7jdC
	uMLK0rOw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sZtoq-000000018B1-0QbF;
	Fri, 02 Aug 2024 15:03:48 +0000
Date: Fri, 2 Aug 2024 16:03:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
	squashfs-devel@lists.sourceforge.net,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] filemap: Init the newly allocated folio memory to 0 for
 the filemap
Message-ID: <20240802150348.GW5334@ZenIV>
References: <20240802135214.GU5334@ZenIV>
 <20240802144415.259364-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802144415.259364-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 02, 2024 at 10:44:15PM +0800, Lizhi Xu wrote:
> On Fri, 2 Aug 2024 14:52:14 +0100, Al Viro wrote:
> > > +			ERROR("Wrong i_size %d!\n", inode->i_size);
> > > +			return -EINVAL;
> > > +		}
> > 
> > ITYM something like
> I do not recommend this type of code, as it would add unnecessary calls
> to le32_o_cpu compared to directly using i_size.
> > 		if (le32_to_cpu(sqsh_ino->symlink_size) > PAGE_SIZE) {
> > 			ERROR("Corrupted symlink\n");
> > 			return -EINVAL;
> > 		}

You do realize that it's inlined, right?  Seriously, compare the
generated code...

