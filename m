Return-Path: <linux-fsdevel+bounces-24060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F610938E37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 13:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE65E1F21DC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 11:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99D816C873;
	Mon, 22 Jul 2024 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Ilm6RCdf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E81640B
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2024 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721648742; cv=none; b=BzL53hdgQNLqYjAr3jC/Q20Oz30aFYfimZYsetStjwn4S5ce9mgFVfOuiUZixQvEuZZKKRbut5nvxqCHO4GunCC2kznBEW6KWHoS0AgW3XlZAD5/ITHO7djegSMdd/Tx5cd6xNYmXLesDfbPwxpkwIVEV2FLUA2wOFvZpRLndRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721648742; c=relaxed/simple;
	bh=8F6Yx5uGHUiSVGdyffU911J9L+V8oHUHpXfo1JiltGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdOGHB9v3CPT4SurMIxJFgqj01fWSdHiet4dP8w3LDs9UZVMCF6BTgURUaJMcVj/9/WXkNDNiE9IE1oJpkvRtIedqmfOYFtcPtV+N9Yp4G6drEOjYU5skyhCTVKqq0rmCGGG5cb/y2816+zSKnxmDFlkXqeBqz7pBf82c4aHVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Ilm6RCdf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-17.bstnma.fios.verizon.net [173.48.115.17])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46MBj4sV025431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 07:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1721648706; bh=tbBSjUa3aVRf1LpHb2pNF8m25+nI+R5jh6E4MKLm1ek=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Ilm6RCdfK36zM9yfQVhQPqVkxvGX+kaXMKOPZglOnPxOF9y2F1z0xFSLQUxS8OpBf
	 Ok69i7cBwTAesYN9VK3y6W0Ux1unZ1w3GVH9ZV67Q6DJLkBsE5P6PU5LXOlTY1NyQh
	 kAZVOxDu57NTX30F3xXUm1eF0BUNly3GwP6cNyiZDKqylrhFEykfRQ6hRO6DiFXtLe
	 soH2x3HIWQt+nc8Cd9mROwrOGQP6lVNZWCBDinYJO8PTCOFYez3kUkkumeKTxhkF7l
	 ACpfXj7xfdHAgaWD4hLR0UpMMaF0xmbhbFC08+gzpyX2ZNcVqFG+zbrUgcYk2I2I9W
	 aIQZEeRk93sUw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 1ED9815C029B; Mon, 22 Jul 2024 07:45:04 -0400 (EDT)
Date: Mon, 22 Jul 2024 07:45:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev
Subject: Re: mounts failing with -EBUSY on device mapper (was: Re: [GIT PULL]
 bcachefs changes for 6.11)
Message-ID: <20240722114504.GA2309824@mit.edu>
References: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
 <CAHk-=wigjHuE2OPyuT6GK66BcQSAukSp0sm8vYvVJeB7+V+ecQ@mail.gmail.com>
 <5ypgzehnp2b3z2e5qfu2ezdtyk4dc4gnlvme54hm77aypl3flj@xlpjs7dbmkwu>
 <CAHk-=wgzMxdCRi9Fqhq2Si+HzyKgWEvMupq=Q-QRQ1xgD_7n=Q@mail.gmail.com>
 <4l32ehljkxjavy3d2lwegx3adec25apko3v355tnlnxhrs43r4@efhplbikcoqs>
 <20240719143001.GA2333818@mit.edu>
 <xp5nl7zi3k6ddkby4phm4swv2wi43slwtvw5fmve5g3jxtdw7w@ygiltwihp2hv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xp5nl7zi3k6ddkby4phm4swv2wi43slwtvw5fmve5g3jxtdw7w@ygiltwihp2hv>

On Sat, Jul 20, 2024 at 11:48:09AM -0400, Kent Overstreet wrote:
> > As far as bcachefs is concerned, my xfstests-bld infrastructure isn't
> > set up to build rust userspace, and Debian has a very ancient bcachefs
> > packages --- the latest version in Debian stable and unstable dates
> > from November 2022.  So I haven't enabled bcachefs support in
> > gce-xfstests and kvm-xfstests yet.  Patches gratefully accepted.  :-)
> 
> I can apt install 1.9.1?

Ah, I see.  bcachefs-tools is currently in Debian unstable, but not in
Debian testing[1]; it's currently hung up due to the auto-libsodium
transition[2].  Once that clears I can look at backporting it to
debian-backports (since my test appliance runs on Debian stable,
for better repeatable test appliance creation.  :-)

[1] https://tracker.debian.org/pkg/bcachefs-tools
[2] https://release.debian.org/transitions/html/auto-libsodium.html

						- Ted

