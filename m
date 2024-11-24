Return-Path: <linux-fsdevel+bounces-35739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB2B9D7927
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 00:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A39162137
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 23:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292E3183CC1;
	Sun, 24 Nov 2024 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="c5MJCrnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C90163;
	Sun, 24 Nov 2024 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732491675; cv=none; b=eod9z6sRpWLxNDNCHpYmXHqU2pW62pNhucVRf/xtFLyQfNMqtmyUK0CbWGtlwLxetyQ257WFE+tkaMEvNJt1EiWlcn2XjPUsMO/0gFYp4vzCenMJNm0xNPLJXtUTq2fdJ31MTyEylE+tCuGzOO0g8ISX8afnF8eNixZ0neGq9k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732491675; c=relaxed/simple;
	bh=K0zZybHwCF4UFEVzCmRHvPvZ9cNUH8z54PqJJ6KZjJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZ8bQVmuVNqVSgT+cMRNg1iGzCc/DynT57+6agNIAVsJKAjuTrIoJSTPqUFsRnpua3BfBGpgg+qPP6DCMz3h5Y3PToH9MP8XWqvMZ01oaSC/YV8u+b3mZCmHQ2eIVK2oHsdga0EHd7WTHUOs5QKt0RVSJGG9InwlnTCe8XRryoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=c5MJCrnV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TTlDzivjnoClKlYJp+m8Z0zDzGLZToGs5LN5qU2VPFw=; b=c5MJCrnVAKTsVAK/D/R4uukX+O
	PSjM/lUYrOhZAeKqgE0U5gdEz3oqjId7Tp2GjBkF2kh1+5eEwbcsvdDHJn28FczY0uNvwcwZufu55
	/EDtbzW3bDCYWYGJT60nTRV1qsNckda4aSuD0qttlDgNEl09A+q96P4w5oEj+Isy5EqiljA0HfxHy
	epzubFVmCfkB2/QWTSfCY+rKTMfd9QcmkwYi6innYUjM1mO4peHuoHVUzPZ2mR1EAl4uMRZFHh2uC
	mAYXMvhlUdKgVlirgv929ymmMXq5Kdk820PUElCKLZ7Tzj6iunaSdfuiSLh4xpNsU63pKMh+Dba59
	ooKjF2fQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFME3-00000001LjJ-1eZU;
	Sun, 24 Nov 2024 23:41:11 +0000
Date: Sun, 24 Nov 2024 23:41:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	21371365@buaa.edu.cn
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
Message-ID: <20241124234111.GD3387508@ZenIV>
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV>
 <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
 <CAGudoHEqDaY3=KuV9CuPja8UgVBhiZVZ7ej5r1yoSxRZaMnknA@mail.gmail.com>
 <CAGudoHGyBQMtfgpq3EzaZi+zWBOoTADVro+Gb27DRHFF1iijVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHGyBQMtfgpq3EzaZi+zWBOoTADVro+Gb27DRHFF1iijVA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 25, 2024 at 12:19:44AM +0100, Mateusz Guzik wrote:

> + *
> + * DONTFIXME: no effort is put into ensuring a consistent snapshot of the
> + * metadata read below. For example a call racing against parallel setattr()
> + * can end up with a mixture of old and new attributes. This is not considered
> + * enough to warrant fixing.
>   */
>  void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
>                       struct inode *inode, struct kstat *stat)
> 
> not an actual patch submission, any party is free to take the comment
> and tweak in whatever capacity without credit.
> 
> What I am after here is preventing more people from spotting the
> problem and thinking it is new.

getattr() is not the only reader for those - permission() is *much*
hotter; for uid/gid issues, if somebody can think of any scenario
where it's a real problem, permission() would be the main source
of headache.

