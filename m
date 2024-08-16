Return-Path: <linux-fsdevel+bounces-26100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5AB95447F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 10:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC1528273F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 08:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C5013D504;
	Fri, 16 Aug 2024 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBRXSfTQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40D12E1CA;
	Fri, 16 Aug 2024 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797257; cv=none; b=dvOOGvkvpP2iEx9iAtd6B5yWRJVei9aP3Bq/76WGyMUapx8o/9PFrbn2OD31gy2a1gdV8kn1vB8J5kh/jv+nIvNZ8AuhckYu0JPcoU2BiKGM9Ohz1o7lENDbWphj5PW3zDzQDkYeKVSGaZf8JYm7HNP09q4txkq52QdM8VJsTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797257; c=relaxed/simple;
	bh=xDe90iasmH1trwlC5xaWhknrCdLACXjytWkboMdB1f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDkepIlT55dOJ+0QtmxKx6k0NV8OBahUSfNs+MrcmKX3vy2vpnDybtmqnT7WrjEUmQBU0GcNUSz5Xc5WIK85JUIdKxGNm7q47H/TCnIQ3/ND0qhRYil/mBTWfSEAkYUsiOv8Blym/SX0AfH6w1RTCkG8lSUvM+VK14280o4BcV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBRXSfTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236B8C4AF09;
	Fri, 16 Aug 2024 08:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723797257;
	bh=xDe90iasmH1trwlC5xaWhknrCdLACXjytWkboMdB1f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dBRXSfTQoiea3kg3vWlM7zajBRMdntsfz1W3C2NDkFpU5ju9NBLV7+j45X0KcPgpo
	 or023rI2JUF11RPkt3RJonuUHP2NQhHBYKeXsWVIuHuTR9Ym7Rs0ksvZVGwryWc0gL
	 3AOpJhO50Gkye38HK8QKFrZ1aMUSzp7eQM7azVYUkRwzBj9+bkGYOrCsvknREYAfaH
	 po9PNesg8qOLj7E6fzP074DGgXAcuy01yQaDRmJJF6weatw3sOT/BmqS4S24QUX+7j
	 wK3ugAYqWbghXCjxiMDhBIxv7moTyVVDEIaMxravNadmlhijPEnyQeTxqg3chYIx+S
	 jWB+LpYfnfB2A==
Date: Fri, 16 Aug 2024 10:34:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <20240816-weiden-netzhaut-23262d8778ef@brauner>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <6e5bfb627a91f308a8c10a343fe918d511a2a1c1.camel@kernel.org>
 <20240814021817.GO13701@ZenIV>
 <20240814024057.GP13701@ZenIV>
 <df9ee1d9d34b07b9d72a3d8ee8d11c40cf07d193.camel@kernel.org>
 <20240814-visier-alpinsport-027f787afa2c@brauner>
 <20240814154419.GT13701@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240814154419.GT13701@ZenIV>

On Wed, Aug 14, 2024 at 04:44:19PM GMT, Al Viro wrote:
> On Wed, Aug 14, 2024 at 02:40:23PM +0200, Christian Brauner wrote:
> > > Christian took in my v3 patch which is a bit different from this one.
> > > It seems to be doing fine in testing with NFS and otherwise.
> > 
> > Every branch gets tested with nfs fstests (in addition to the usual
> > suspects):
> > 
> > Failures: generic/732
> > Failed 1 of 600 tests
> > 
> > And that just fails because it's missing your 4fd042e0465c
> > ("generic/732: don't run it on NFS")
> 
> connectathon would be more interesting...

Fwiw, I wasted almost a day to get more testing done here. But that
connectathon thing at [1] just failed to compile on anything reasonably
new and with errors that indicate that certain apis it uses have been
deprecated for a very long time.

In any case, I went out of my way and found that LTP has stresstests for
NFS for creation, open, mkdir, unlink etc and I added them to testing
now.

[1]: https://github.com/dkruchinin/cthon-nfs-tests

