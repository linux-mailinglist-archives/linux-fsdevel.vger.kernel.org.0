Return-Path: <linux-fsdevel+bounces-51745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F98ADB02E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C4A188756F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC7A27380D;
	Mon, 16 Jun 2025 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xrrWvM6A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC7B2E4278
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750076942; cv=none; b=M0CJuJyns8853A0aaxv1cIYxKv36mKyxZCdAHVn0J8VhtyPkGQziDnb4Etdw9K5GvvYKv7wCSzp/kHp7eEDcyA6jQgDsq7V9hQoh+jnBi0BurTmhcdT0IhEKxbYRlizhFm/Pyds046SbRCVSd610GBQzWPPuOHVx23SiGEZGLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750076942; c=relaxed/simple;
	bh=3PK7kDu8LNgaS40zQb2QmDa52dIU9LgCA/0v10CmQm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZwO5YoweI9ksFyBayYUmnAbOHos/IAMeEevdQwnxhKD4+Pk9fc/pz12Cc+8bnXCNH/TCGq4U/78dUNYzOM7rwbxb6MZiKd6tt8Y+R+IQ5PN1YBj5UBwkqMpPNHsjaDtyqepPtTN80e40MnbchpcRpDR9sYBGZvnGrjo0AqJBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xrrWvM6A; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 16 Jun 2025 08:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750076928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUeQ2TLSZFm17aOXtjfFoI7Xeindrm6e/ItMFmoxfZQ=;
	b=xrrWvM6A1N2CV5xYCVUSKR7a6Mjcn3wmWTzUCLzL2COcGnHdaqvJ91q4lFTBbJQKKXSus7
	EOV8LgyJNSws2XnjQ6w1RVmLZ+y0ceZWiBoBDPvymkcjiOV+embF1vd8w8soRYxYcN50hu
	WnNhF86BuIKQRZrPrffNM8MlrPZ1B7Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable
 filesystems
Message-ID: <bc6tvlur6wdeseynuk3wqjlcuv6fwirr4xezofmjlcptk24fhp@w4lzoxf4embt>
References: <20250602171702.1941891-1-amir73il@gmail.com>
 <oxmvu3v6a3r4ca26b4dhsx45vuulltbke742zna3rrinxc7qxb@kinu65dlrv3f>
 <CAOQ4uxicRiha+EV+Fv9iAbWqBJzqarZhCa3OjuTr93NpT+wW-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxicRiha+EV+Fv9iAbWqBJzqarZhCa3OjuTr93NpT+wW-Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 16, 2025 at 10:06:32AM +0200, Amir Goldstein wrote:
> On Sun, Jun 15, 2025 at 9:20 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Mon, Jun 02, 2025 at 07:17:02PM +0200, Amir Goldstein wrote:
> > > Case folding is often applied to subtrees and not on an entire
> > > filesystem.
> > >
> > > Disallowing layers from filesystems that support case folding is over
> > > limiting.
> > >
> > > Replace the rule that case-folding capable are not allowed as layers
> > > with a rule that case folded directories are not allowed in a merged
> > > directory stack.
> > >
> > > Should case folding be enabled on an underlying directory while
> > > overlayfs is mounted the outcome is generally undefined.
> > >
> > > Specifically in ovl_lookup(), we check the base underlying directory
> > > and fail with -ESTALE and write a warning to kmsg if an underlying
> > > directory case folding is enabled.
> > >
> > > Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Link: https://lore.kernel.org/linux-fsdevel/20250520051600.1903319-1-kent.overstreet@linux.dev/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Miklos,
> > >
> > > This is my solution to Kent's request to allow overlayfs mount on
> > > bcachefs subtrees that do not have casefolding enabled, while other
> > > subtrees do have casefolding enabled.
> > >
> > > I have written a test to cover the change of behavior [1].
> > > This test does not run on old kernel's where the mount always fails
> > > with casefold capable layers.
> > >
> > > Let me know what you think.
> > >
> > > Kent,
> > >
> > > I have tested this on ext4.
> > > Please test on bcachefs.
> >
> > Where are we at with getting this in? I've got users who keep asking, so
> > hoping we can get it backported to 6.15
> 
> I'm planning to queue this for 6.17, but hoping to get an ACK from Miklos first.

This is a regression for bcachefs users, why isn't it being considered for
6.16?

