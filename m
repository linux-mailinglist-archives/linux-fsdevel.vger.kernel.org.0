Return-Path: <linux-fsdevel+bounces-32680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1C39AD51A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 21:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499D5B238B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 19:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566A21FEFCB;
	Wed, 23 Oct 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="kZsOsOWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7F1FDFA3
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712595; cv=none; b=rRq93jO06mLuB7Lzszj8H60M8PwcywFB0CGPxNxnfaW/o/Ybfg86YnjxO0K+hewWFHLYs5BAI86hskKdA13UfHoTflf4DDFzBNEOSHv/FVIIsOxemLR3Xf+e6RbSwWuVjY//YE3olH5r3NL1+t16j7dIPvGg+ckeHakFV+jcXmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712595; c=relaxed/simple;
	bh=483glRYuN7eV91sT6M6ka//aRHT9NYyaQEqATTcjNbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOHkAXweboswriS3ttgWBLilGmSVAd0l9ePTGjfpRE6MjllS15gvhA4NUNutCstvCHHOva/TQ3KPUDX2JD9BrzpxiDSPjpxsOE8nY6E3CK5gi4s6pFpEylx1wbBZKAiyMnetTUttX1lH5fcLojUrmYZf+1vTpnw5vvtq5V7Lepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=kZsOsOWP; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49NJgrni007493
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729712578; bh=OzxxnkdsQsRPVgvolJY2V7rbnSYSClX5Xcw7A3Ey33A=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=kZsOsOWPrTntWlNDpeUM0Lh+WYJpvACDLncfREO26UMnTghQo0nx3w6L8fPM07FVQ
	 NVO81l49taba/2MzXNm5O0mSr2uiwBVckDq/OV0UGHlNPXAqcbDhXpNVxNwBvEfSmb
	 sphPmWGfipRkc3tzgWZ+OeohgMq3Qg2v5eNDZp46igDe8RuMdtiIHqxVRbQDt1rcTk
	 wRCy6vtXIl7Q3149pnfoQxx7cB6Oj9jyg2d4EMaAlmKSaif1+xgtNeeGD1E3bGMofS
	 9pKlL373qn98EmKNiPuSvRYekIunXsgniRIerLfy/Wk5Tttw0dYAGAOmWNeVb3kTUX
	 E9hQ4SkWmmZ6w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 109F815C0329; Wed, 23 Oct 2024 15:42:53 -0400 (EDT)
Date: Wed, 23 Oct 2024 15:42:53 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, sunjunchao2870@gmail.com,
        Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [REGRESSION] generic/564 is failing in fs-next
Message-ID: <20241023194253.GH3204734@mit.edu>
References: <20241018162837.GA3307207@mit.edu>
 <20241019161601.GJ21836@frogsfrogsfrogs>
 <20241021-anstecken-fortfahren-4dd7b79a5f45@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-anstecken-fortfahren-4dd7b79a5f45@brauner>

On Mon, Oct 21, 2024 at 02:49:54PM +0200, Christian Brauner wrote:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/fs/read_write.c?h=fs-next&id=0f0f217df68fd72d91d2de6e85a6dd80fa1f5c95
> > 
> > To Mr. Sun: did you see these regressions when you tested this patch?
> 
> So we should drop this patch for now.

My most recent fs-next testing is still showing this failure, and
looking at the most recent fs-next branch, 

    vfs: Fix implicit conversion problem when testing overflow case

still appears to be in the tree.  Can we please get this dropped?
Thanks!!

							- Ted

