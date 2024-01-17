Return-Path: <linux-fsdevel+bounces-8166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B18308D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 15:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241AC1C23F5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0192230C;
	Wed, 17 Jan 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W4zMYe6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7368720DD3;
	Wed, 17 Jan 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503157; cv=none; b=RWSDNIef/VEq7jAPfACxYrBFJa0UhDtSl78Noew3i0ZfZv4IqT2dekXTOFoqG84C+9b3EVG2GJYfjSFbooy/jUJv2Xm5NAJtN97RJwtPImlbwQ9irRMuouIi4dwot8GPZrpbmNzqbWl5wtF6CwStucDkDioBnc0iLIwWCsUuzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503157; c=relaxed/simple;
	bh=mk3Do3OGSoO3lYVK+3O445pImEvdyqK7uj6etB3B5lE=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=YEVr3eRRM5Gm7M42SVkliIpgbebkigBSo2soQDWifM7JAcdGEDdc5UD/IqWW6qGuy8pjBTa1X7/1TxKzTVNEDiQN/oBkXhPb5nTo54spJAcmEoTkX6M1FPSi2d+Dlo/87OUAN5vDCRGeoVQ3nDJ7ziDAd1oc5qCvYmfsNbr4eZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W4zMYe6n; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p9m4ROoLCFI9ZSmSQlv4Jd9ZGwftV7SKWqQ5i1J2RlA=; b=W4zMYe6nwJgS22voMlQazvN+dB
	12kqgxhCjyqVUVflB0+HtQt+H4fhuhKnXMLQVo9kpK1R8S4yeMIOIjM1nyWgChcNSEp2mDkXmllst
	TC+R77/tF5NaawW7SG9qqIs+rvmCY9LlH9nn6s9Nr5tsJWYjIMPP0CEL9uNfGnhEh/7rPGJ5rD8mG
	yHZ8RJPvYKHyutQ6kjWiJSer8Sze0t6CNyBAot108Ek4yRk4kGPsdOMIAx7gCpAKHAbNwdzhs/gIZ
	R+lmFCpLqLZTwtHW2Mxu4Rup4sLIWM1zIjdUnXyfE3Oc8l9daY5AJa0qKkw7Wq+keUDPgzwGfB0Kp
	1R7hBkVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQ7HM-00000000Cg9-1PbJ;
	Wed, 17 Jan 2024 14:52:32 +0000
Date: Wed, 17 Jan 2024 14:52:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <ZafpsO3XakIekWXx@casper.infradead.org>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <20240116114519.jcktectmk2thgagw@quack3>
 <20240117-tupfen-unqualifiziert-173af9bc68c8@brauner>
 <20240117143528.idmyeadhf4yzs5ck@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117143528.idmyeadhf4yzs5ck@quack3>

On Wed, Jan 17, 2024 at 03:35:28PM +0100, Jan Kara wrote:
> OK. So could we then define the effect of your desired call as calling
> posix_fadvise(..., POSIX_FADV_DONTNEED) for every file? This is kind of
> best-effort eviction which is reasonably well understood by everybody.

I feel like we're in an XY trap [1].  What Christian actually wants is
to not be able to access the contents of a file while the device it's
on is suspended, and we've gone from there to "must drop the page cache".

We have numerous ways to intercept file reads and make them either
block or fail.  The obvious one to me is security_file_permission()
called from rw_verify_area().  Can we do everything we need with an LSM?

[1] https://meta.stackexchange.com/questions/66377/what-is-the-xy-problem

