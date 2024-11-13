Return-Path: <linux-fsdevel+bounces-34583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F749C668E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 02:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB8AB275C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658A31C69D;
	Wed, 13 Nov 2024 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NWnQS4xv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D832309AC;
	Wed, 13 Nov 2024 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460801; cv=none; b=qQLalPp3+K0KMN+AtTxd5kWc8eRyo7rVy7eTKZGmzHF0qTRKJoZHB/3jLURmcZKClUggEkgpfDMTQmTckWhCoq2klPMlJ1mLgxbI6+ri8zoZu83sq7l8RQokm8tteL3lZlivOmduQzphqcWI5yLCIGemSG7QtvfLYeExekGwuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460801; c=relaxed/simple;
	bh=EEW2fQlOgw7/LdLNgEFcmqde26RG5RGhFq5cl9pKORY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdizncf6YWY/ICzPb8k70YEGnuU9uT91l335/YpjVoEC3bj2gg7Kg3dSn8SQxQJi7np8gJNCjrcxIhmcPGTjd59XIM8pGAr6QI2PwisG+k97eibiFGYFhHppQMlQ9E4Nef5M39F4q76uUlSLt5q5+KK9WssbOK52fW+TDHNYOTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NWnQS4xv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+xBD1LG1LcD2WvJWHLClpL4CkoduBy/hMixH+3L2C0k=; b=NWnQS4xver1owBO+dn2OG3m35m
	YqYGw2WubUWRGvoj6Nj/I0yVjQQcIshCS5hh7T6H6svbkoLqNtVuFjUB6lmVEGiItwgK6KwVHP24w
	249wjP8HAnySe2tiW15dmU9Uco4QR5sjxt/u9ffiwypdBNYN1uhFwXXejD2H6698UzgMHy4AafB12
	noJhUGXPkJjMlejOr9GPIsgaRcCFPvZ6px03xHvhivHqv+Ei3lp9e0ZtFCY1u5aerpBN+jrgq1G5E
	gOe27ozCV21rRcIkZI5ePTtJ5sgUfkPdiou88Fr9qkqoyxHzsVsJUjrR0Bq2zx/K0t+ut4sXOvs9h
	ibbU2D6g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB230-0000000EJRo-3OnO;
	Wed, 13 Nov 2024 01:19:54 +0000
Date: Wed, 13 Nov 2024 01:19:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission
 events
Message-ID: <20241113011954.GG3387508@ZenIV>
References: <cover.1731433903.git.josef@toxicpanda.com>
 <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
 <20241113001251.GF3387508@ZenIV>
 <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
 <CAHk-=wgVzOQDNASK8tU3JoZHUgp7BMTmuo2Njmqh4NvEMYTrCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgVzOQDNASK8tU3JoZHUgp7BMTmuo2Njmqh4NvEMYTrCw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 12, 2024 at 04:38:42PM -0800, Linus Torvalds wrote:
> Looking at that locking code in fadvise() just for the f_mode use does
> make me think this would be a really good cleanup.
> 
> I note that our fcntl code seems buggy as-is, because while it does
> use f_lock for assignments (good), it clearly does *not* use them for
> reading.
> 
> So it looks like you can actually read inconsistent values.
> 
> I get the feeling that f_flags would want WRITE_ONCE/READ_ONCE in
> _addition_ to the f_lock use it has.

AFAICS, fasync logics is the fishy part - the rest should be sane.

> The f_mode thing with fadvise() smells like the same bug. Just because
> the modifications are serialized wrt each other doesn't mean that
> readers are then automatically ok.

Reads are also under ->f_lock in there, AFAICS...

Another thing in the vicinity is ->f_mode modifications after the calls
of anon_inode_getfile() in several callers - probably ought to switch
those to anon_inode_getfile_fmode().  That had been discussed back in
April when the function got merged, but "convert to using it" followup
series hadn't materialized...

