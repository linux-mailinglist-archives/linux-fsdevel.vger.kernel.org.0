Return-Path: <linux-fsdevel+bounces-60327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D26B44B59
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 03:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3BF188EFFE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 01:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72451AC88A;
	Fri,  5 Sep 2025 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skAyGzRo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DDB187332
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757037031; cv=none; b=s6CO6ExTPppK+vH9wU/kSsl5lmzJTHMNUJhMVgRHWAuVLuCoSeO1TS0nc7cUssFeFlo/tMSMtxnZ00Xvje/ii0w1+axRPPKHvthTPIiWA7T9DjY4yyLX8S9YUdFJY+LB/MK2Ac3QdipsXGGGXpUXikfFAhkpdY4hqyj+421/xN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757037031; c=relaxed/simple;
	bh=/N35Z0WuqIhNFcHLbSrzPz2SO7IkiJYnQztRrG1K5II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVGSC4MBsedc6HC+4nE2IlFVjJQBGprbpniYeYEoGdqGzsnN5bM2Md6m0dzP34HrUSpsqxszW0W2xjcYjZCZubuseZ7mKwNVM0SU+TWL3gZIzis/vJIR807P1XnB5Apht7D5CJOiY3A0In7Pdsrh/NpkGyLCNW1qxG73MdXQ9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skAyGzRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D455C4CEF0;
	Fri,  5 Sep 2025 01:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757037030;
	bh=/N35Z0WuqIhNFcHLbSrzPz2SO7IkiJYnQztRrG1K5II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skAyGzRojI9oM1FkbxU8BC9ogg7coCRRa2dAM76GEGo2mGkyTmIdX8zP2zRbS2EW7
	 fbbunWMUWY1Nok8qGYsPT3ePdmOnGW0cNsuAg397U649e9F+jpqbRuNIZsCcdwcrF4
	 A8s3pLp8iKELTwydYFS2459tRsex0kAp1whYKFyYxUSg5G2kBPhshiSScDdePcyvMO
	 ZCSw0RJWQOPrIH/U2YZ1bPdwIbzzZT0Y7e3IT/1RCgIBk9NHGvvTRtNAXNCPRqj6bE
	 jOveKsZbX3MGTvK96DCkbvyMGCL91eqKuuvh/WQwFhAMjlf+SZT72ehmeT58d4jCyN
	 am5jurWGzIrDg==
Date: Thu, 4 Sep 2025 18:50:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 02/23] fuse: implement the basic iomap mechanisms
Message-ID: <20250905015029.GC1587915@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
 <175573709157.17510.2779775194786047472.stgit@frogsfrogsfrogs>
 <CAJfpegsUhKYLeWXML+V9G+QLVq3T+YbcwL-qrNDESnT4JzOmcg@mail.gmail.com>
 <20250904144521.GY1587915@frogsfrogsfrogs>
 <CAJfpeguoMuRH3Q4QEiBLHkWPghFH+XVVUuRWBa3FCkORoFdXGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguoMuRH3Q4QEiBLHkWPghFH+XVVUuRWBa3FCkORoFdXGQ@mail.gmail.com>

On Thu, Sep 04, 2025 at 05:17:13PM +0200, Miklos Szeredi wrote:
> On Thu, 4 Sept 2025 at 16:45, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > Or do you prefer the first N patches to include only code and no
> > debugging stuff at all, with a megapatch at the end to add all that
> > instrumentation?
> 
> It doesn't have to be a megapatch, could be a nicely broken up series.
> But separate from the main patchset, if possible.

I'll give it a try.

--D

> Thanks,
> Miklos
> 

