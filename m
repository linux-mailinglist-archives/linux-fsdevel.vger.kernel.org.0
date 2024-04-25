Return-Path: <linux-fsdevel+bounces-17699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754378B188B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 03:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFB42854F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 01:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7902710A14;
	Thu, 25 Apr 2024 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="l192Y4uT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8410A0A;
	Thu, 25 Apr 2024 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714009450; cv=none; b=SxXfg2DSXtS2IUinH83zg3IQMypDf2q4atZ7czslBtm3B6tkUeq/OAZBBHUQmYf7z9re0000XiLn+7BACvmVbRucgNw1ytGBYqmvCEflNH/s1bbSMlNLn1raAMaNng/ZGgs2DDAI2WWsNz1NcjlxC/5cdXOCPw2vk5B/xUmSB44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714009450; c=relaxed/simple;
	bh=rV/A03jIZW1y0g5q45g9NzDUZlMGGsmwEFTnMP9wheQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmNFIGCmmDq/9Ni+lVlXvoYeLS0m5A4plP/0wr/h9qybartA2n6wTdBuwN1C6UA2P+jTNH6QcIcgLIl6Dsic8nOmqohcR5srQ8IT2JLQ1+DQj5Mns2iLRNCAQWo9+IOtOGJ9FeEJCmBt54Lxk7Pj/XeeaxrYt9YHqt/r0HXKiNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=l192Y4uT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0QPUxVsvhoTHhWPZA9B73OH+l2QpvxncXISUjO3pjIA=; b=l192Y4uTA9QaUOpENAX93/ZlAf
	cQ4W9w9FnI+vCPocvnaUvJfDLyChWOKc8zYq2u5gBG1sXvrd6Gtvr2eRQ96LOx14c7kDWx61eRhxH
	9A6mhpbMOTTQJzG1+KxDO5dMBcNBRjt9UJYdzX3c0OGd5KTYLCE1FDrn1sO249FgU6upKrfrV/4xS
	IgYOgx0Mxd/AcqdJJqIBObfoDAEvHbSPFVfzvkSmJ+a14E22nmVw7AqDiiM9dv5TE9TmgVywATpV6
	Jt6VAP+mloeSbSHHxw8beiQGymTAm9tiYVeKFTngaXs+LeUQME2Xw/70Y9uNTu3MOgNqm46OQdr8I
	y1chXGMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rzo9W-003GR2-0S;
	Thu, 25 Apr 2024 01:43:58 +0000
Date: Thu, 25 Apr 2024 02:43:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andy Lutomirski <luto@amacapital.net>
Cc: stsp <stsp2@yandex.ru>, linux-kernel@vger.kernel.org,
	Stefan Metzmacher <metze@samba.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v2 0/2] implement OA2_INHERIT_CRED flag for openat2()
Message-ID: <20240425014358.GG2118490@ZenIV>
References: <20240423110148.13114-1-stsp2@yandex.ru>
 <4D2A1543-273F-417F-921B-E9F994FBF2E8@amacapital.net>
 <0e2e48be-86a8-418c-95b1-e8ca17469198@yandex.ru>
 <CALCETrWswr5jAzD9BkdCqLX=d8vReO8O9dVmZfL7HXdvwkft9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWswr5jAzD9BkdCqLX=d8vReO8O9dVmZfL7HXdvwkft9g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 24, 2024 at 05:43:02PM -0700, Andy Lutomirski wrote:

> I like that, but you're blocking it the wrong way.  My concern is that
> someone does dfd = open("/proc/PID/fd/3") and then openat(dfd, ...,
> OA2_INHERIT_CRED);  IIRC open("/proc/PID/fd/3") is extremely magical
> and returns the _same open file description_ (struct file) as PID's fd
> 3.

No, it doesn't.  We could implement that, but if we do that'll be
*not* a part of procfs and it's going to be limited to current task
only.

There are two different variants of /dev/fd/* semantics - one is
"opening /dev/fd/42 is an equivalent of dup(42)", another is
"opening /dev/fd/42 is an equivalent of opening the same fs object
that is currently accessed via descriptor 42".  Linux is doing the
latter, and we can't switch - that would break a lot of userland
software, including a lot of scripts.

I'm not saying I like the series, but this particular objection is bogus -
open via procfs symlinks is *not* an equivalent of dup() and that is not
going to change.

