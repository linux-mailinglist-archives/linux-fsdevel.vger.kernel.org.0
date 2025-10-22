Return-Path: <linux-fsdevel+bounces-65201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EF5BFDF23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75AB54E18AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C782FABF8;
	Wed, 22 Oct 2025 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsBcZenZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D4325480;
	Wed, 22 Oct 2025 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159427; cv=none; b=cgiZEZr9kzZNC/fNMq3Oyqbtb37QRDkF0NjNcg3cHP1mEFMqvWV/Se7BQqzJB5XBEHc7+1ep2Ws/TYalRv0IEBs9Ybat+MXC0rb/yUqYJ12c6huCQb9dHcsueNQWtOjuVuJ02zUCEhyQlbt2RiEeCqgLdn5Qg5hmThblE+M50k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159427; c=relaxed/simple;
	bh=LOh3uSZkB5BdNxatWsnBLpppmFv7ZA8CFHvbttqLK/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1WHWLcxXgozdemDzVaxFO1hNK5wza0VoL49p4Z/+I8kz8iT5Z+T34xw3JSRue/yM7vMTiU39K7sN4I7RpZH7LIZc0f/bH+CFL2wAKWYlnSuwb7kYhV4530UHAw74kWtkl6eJr5TOJ7zRIUt3E1b4vyT9H/MAeFEQEr6yTGysTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsBcZenZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A786BC4CEE7;
	Wed, 22 Oct 2025 18:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761159426;
	bh=LOh3uSZkB5BdNxatWsnBLpppmFv7ZA8CFHvbttqLK/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsBcZenZXQIpbz56ox/YMTk2OIuF+uB5LzBxN9JJKgZIDceom0xU3WmCPAWl2mujo
	 YtVdDZ9Ngg1DM9IEHGBoHlSWBopII6/R09+TbZ2/W4Klo7Q89Rk74S4Ojqa1fLoKBe
	 9yLemKSE8cFhDsMTefJJWyl/jsovp2z9+O4+DSbGqagmgYVsS4SRCgXvq3bN5gd6gi
	 4lshfmqCiAfBn4ez52eU2t2/qhMD2pryl4eon0VjJkYNoaf0pewBhpcBOzXpaMqthq
	 OcrfEV85swjUYPXQnGGXtbtqo8+WDzZykdYUgOtBlgAVFNQ2H/aa/5cz8+n80BkU0I
	 mePlIeh5CtOow==
Received: by pali.im (Postfix)
	id 4518F7F2; Wed, 22 Oct 2025 20:57:02 +0200 (CEST)
Date: Wed, 22 Oct 2025 20:57:02 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: Namjae Jeon <linkinjeon@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@infradead.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, ebiggers@kernel.org,
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
Message-ID: <20251022185702.qqeexyjyivpjeark@pali>
References: <20251020020749.5522-1-linkinjeon@kernel.org>
 <20251022063056.GR13776@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022063056.GR13776@twin.jikos.cz>
User-Agent: NeoMutt/20180716

On Wednesday 22 October 2025 08:30:56 David Sterba wrote:
> On Mon, Oct 20, 2025 at 11:07:38AM +0900, Namjae Jeon wrote:
> > The feature comparison summary
> > ==============================
> > 
> > Feature                               ntfsplus   ntfs3
> > ===================================   ========   ===========
> > Write support                         Yes        Yes
> > iomap support                         Yes        No
> > No buffer head                        Yes        No
> > Public utilities(mkfs, fsck, etc.)    Yes        No
> > xfstests passed                       287        218
> > Idmapped mount                        Yes        No
> > Delayed allocation                    Yes        No
> > Bonnie++                              Pass       Fail
> > Journaling                            Planned    Inoperative
> > ===================================   ========   ===========
> 
> Having two implementations of the same is problematic but I think what
> votes for ntfs+ is that it's using the current internal interfaces like
> iomap and no buffer heads. I'm not familiar with recent ntfs3
> development but it would be good to know if the API conversions are
> planned at all.
> 
> There are many filesystems using the old interfaces and I think most of
> them will stay like that. The config options BUFFER_HEAD and FS_IOMAP
> make the distinction what people care about most. In case of ntfs it's
> clearly for interoperability.
> 
> As a user I'd be interested in feature parity with ntfs3, eg. I don't
> see the label ioctls supported but it's a minor thing. Ideally there's
> one full featured implementation but I take it that it may not be
> feasible to update ntfs3 so it's equivalent to ntfs+. As this is not a
> native linux filesystem swapping the implementation can be fairly
> transparent, depending only on the config options. The drawback is
> losing the history of fixed bugs that may show up again.

This drawback already happened at the time of switch from old ntfs to
ntfs3 driver. So I think that this is not a problem.

> We could do the same as when ntfs3 appeared, but back then it had
> arguably better position as it brought full write support. Right now I
> understand it more of as maintenance problem.

