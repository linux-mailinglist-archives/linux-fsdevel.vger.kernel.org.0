Return-Path: <linux-fsdevel+bounces-45594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DDBA79AA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 05:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E743B2C15
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 03:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ECD197558;
	Thu,  3 Apr 2025 03:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hyOq+BzP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47B2581;
	Thu,  3 Apr 2025 03:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743652247; cv=none; b=Rs0M/LTbXB4cf2HGL62/sBk2zziqtUI25uwQdf6ocuVCyLBy2SJOlv+JI7J+2aXTL7IytPc9uc7oHCnQbsSyYhBTu7nO4ga6ZEmLAhmH0jWwwwyfg2TOo0/l54Rm4abM9BXxbwyXU8fO316ZuEIQafS2P5dFriD8ZaTOC5V+HGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743652247; c=relaxed/simple;
	bh=bqZuM5lPtkFFl5BW3C27cWg9aVz5id/woq/3m2/1HII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcZkJTbnukZtTD/XYnesE/LuAY4kKHwB8qrY3ArkkSPgHd0mtgm4do7XgMACfZq0K/guteehXdad8qxV2NnuP2817JiKFz0Nq06wvuKRHSgB9abQeVrZLYhO+HwBMlc8glmrA7DwHmppRoBfDKJB1Zbfcui0vXyTkKlkiIsiAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hyOq+BzP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DeK8Kuf5tprwuRtqHOlQKfmPUg7DzKRX9Vs7L5+3uEA=; b=hyOq+BzPufZTrboJE+EMz6Ov5Z
	v2H9hxTCr8TCsvjt3qEX9eFde71Uyr2saAt2H5oQ5ErOdcCXvv4STcYKlHhOQFZCN5GjNwUGYjlFM
	Is1qhsK3Aa9YsFFXuSG52pEZ+rGKe5UZdc6c73NtA7YscNXF5feOKfJWBvO9qPmLzVEj5FNLAgXNL
	hhEJws4JiVHPJrYQLXdKGf2QhqyBs6G96Ytq5A8A24J0xFVrPLw7q0iDoyDZNjKQr0GEjAw0/mFzF
	gZzm2/mVa5acrXfycjTwhH3pv2Evej6K1bIlxhZ2hCyTh1wz8shEuVIAEMCwzt+LcO8XHJ9YdklTw
	A5P0D/3g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0BbE-0000000APBV-1SkC;
	Thu, 03 Apr 2025 03:50:40 +0000
Date: Thu, 3 Apr 2025 04:50:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xiaole He <hexiaole1994@126.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] fs/super.c: Add NULL check for type in
 iterate_supers_type
Message-ID: <20250403035040.GM2023217@ZenIV>
References: <20250402034529.12642-1-hexiaole1994@126.com>
 <35a8d2093ba4c4b60ce07f1efc17ff2595f6964d.camel@HansenPartnership.com>
 <4ee2fdcb.1854a.195f9828c86.Coremail.hexiaole1994@126.com>
 <20250403024756.GL2023217@ZenIV>
 <75a45193.18746.195f9a088c4.Coremail.hexiaole1994@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75a45193.18746.195f9a088c4.Coremail.hexiaole1994@126.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 03, 2025 at 11:10:02AM +0800, Xiaole He wrote:
> Thank you for your thoughtfully feedback.
> I think you are right, and I'm sorry for my pedantic anxiety.
> So if we just ignore this patch for now, or I should submit a bug
> report to kernel community in order to invite more thorough fix?
> Thanks for your patient again.

I don't believe that adding random checks would make any sense -
same as for any library function, really.

Having the documentation slightly more clear would make sense,
though; currently it's

 *      iterate_supers_type - call function for superblocks of given type
 *      @type: fs type
 *      @f: function to call
 *      @arg: argument to pass to it
 *
 *      Scans the superblock list and calls given function, passing it
 *      locked superblock and given argument.

and description could've been better.  The weakest part in there is,
IMO, "the superblock list" - there is a global list of all superblocks
(inventively called 'super_blocks'), but that's not what gets scanned;
the list of superblocks of given type (type->fs_supers) we iterate
through.

Something along the lines of "Call given callback @f for all superblocks
of given type.  The first argument passed to @f points to a locked superblock
that belongs to @type; the second is a caller-supplied opaque pointer @arg.
The caller is responsible for passing @arg that would make a valid second
argument for @f - compiler can't help here" might be a starting point,
but I'm not up to turning that into proper English.

