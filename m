Return-Path: <linux-fsdevel+bounces-19152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8868C0AC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 07:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391EE1F23EF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 05:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE1E14900A;
	Thu,  9 May 2024 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bVYEAU2N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703710E5;
	Thu,  9 May 2024 05:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715231160; cv=none; b=icYY1VbBvH/MHNsXpfd+jh+OuRBQfVFnGQyg7/yHHdzqOSvFjE97b2WsoZC2QpE36PMG1MD+st419WT0sDxAP3hzqqUYBDwyIxnwKUcQ4RLnV3rbLKtTRlxGA7AWH3AnS4vq3gfvNbKhniaWxs8WZ84Va4PumlfR2+GhLGatAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715231160; c=relaxed/simple;
	bh=cMWq8f4EQ6ITGXaJRXM9W/JwicIuWHoUbHLHX/yiNwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbbv5lhsJqA1MsjL+ZFcsHSvwYLYyEcMDSFzHlIt1zouyxSz5/iO9L5OuJ8YsRgCbQFD4ehASKXt8Tl+SMiq41magupxcbQ9gY80BCAw3V53Dwti5So8eGr9s9VoD3yzDuYircJEiUMZRnRefdvK/+yWWTRSLUIIbB75v6YpnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bVYEAU2N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F1NX3V4uTye8+jwA+W6eOBhcK78McvSSmZKfhuMjbMc=; b=bVYEAU2N2/734kZtUxxKF3scaY
	04LfrbgNBDV+c31jWp9vGPalwTmrXuX2ydiiGf1gFuBXP5fcuCEUgFfpAbgSL8WS8XCMf52zGFhEq
	JHRh6GdkM+XtCBkhfiO0bSv66ohzlR3or+WaoMrufNtvhtjNzlyORl5ylbPlnauz9WijxLVY4U+4W
	DfcUy3WfAl499WsssAcMOqe0uEvj/ZXWP4HhpBQ1dgUU8L345lMDwOnWXR90Yp8iUrF/mSnRtR1LU
	fjmWfKBlNBsEqSqbaR/IaziFLBpiLQEaI6U0ZA0pXaHt1BpIXWC2XlTLzLqzksf6zYJGymP0Bg9Sp
	9hQ2mh9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4vyg-00000000NP5-1Nc4;
	Thu, 09 May 2024 05:05:58 +0000
Date: Wed, 8 May 2024 22:05:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Chandan Babu R <chandan.babu@oracle.com>
Subject: Re: [Lsf-pc] XFS BoF at LSFMM
Message-ID: <ZjxZttSUzFTd_UWc@infradead.org>
References: <CAB=NE6V_TqhQ0cqSdnDg7AZZQ5ZqzgBJHuHkjKBK0x_buKsgeQ@mail.gmail.com>
 <CAOQ4uxj8qVpPv=YM5QiV5ryaCmFeCvArFt0Uqf29KodBdnbOaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj8qVpPv=YM5QiV5ryaCmFeCvArFt0Uqf29KodBdnbOaw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 09, 2024 at 08:01:39AM +0300, Amir Goldstein wrote:
> 
> FYI, I counted more than 10 attendees that are active contributors or
> have contributed to xfs in one way or another.
> That's roughly a third of the FS track.

FYI, I'm flying out at 4:15pm on Wednesday, and while I try to keep my
time at the airport short I'd still be gone by 3:30.

But that will only matter if you make the BOF and actual BOF and not the
usual televised crap that happens at LSFMM.


