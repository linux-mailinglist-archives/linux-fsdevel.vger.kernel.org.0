Return-Path: <linux-fsdevel+bounces-16222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFB889A4A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF52285479
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 19:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E12E172BCA;
	Fri,  5 Apr 2024 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HZ97vexP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2862172796
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344013; cv=none; b=VO0x9g/YtnOrcCuyVyPJD216BIwWnAZsQ3oL6KCQrTCJ7ON5WUOyqjU3kdI4JzC5pCdsJDo0VpHUjZsso7qLc2msAelV6Nl+TYEKcwYXsfIarcNMHNyzzPT4HMfsTIEyRUKENiSdaAHA4Th6GyFZLSjBbeB01iWSgVO+kbKvTLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344013; c=relaxed/simple;
	bh=cFa86Z8RRLF4vPDeov8Dfg04JBAwVybrO/2egSFq9GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRpRqymJj2et6kTz+YDJvCOwtdGlwVdovwLgOfmrawJ/2T4iWqZp3KXgHUHplMV71PMiza8XggQvOm61FpOnJ54bpDLNeaNzjBo0E4SBwFucoTp5v4yejU1/9ldcRZ1+BibGteHi7UdlPuidE3kk5JlJxh86vp3ziKA1HzHZpVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HZ97vexP; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Apr 2024 15:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712344009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xy7rrQFx/ai4jiHF7erHWLhfU4NiOdULn/JTP2Sih9s=;
	b=HZ97vexPrKySNDCOlz9qANDAP2JyhZBo/XKrmr+lyOE6CHkjHxJYL3ItLuk9OGrZpDRot0
	Q2UlJMp5dDfEit2UE6bzXAAdCDy+AAHKq7O1YfadBIDO1LT0kCLSqROgs2CrC0IoQX2GA0
	sxKvTykI3035G7lRq82NPDS2a99O47w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, 
	Jonathan Corbet <corbet@lwn.net>, Brian Foster <bfoster@redhat.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, linux-doc@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel-team@meta.com
Subject: Re: [PATCH v3 02/13] fiemap: update fiemap_fill_next_extent()
 signature
Message-ID: <3bvnvw5lvlraveup3du7esp3v54wissngudpov3xzneajo2fji@hbqk52z2xp2z>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <58f9c9eef8b0e33a8d46a3ad8a8db46890e1fbe8.1712126039.git.sweettea-kernel@dorminy.me>
 <BDD29EBF-3A5F-4241-B9F2-789605D99817@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BDD29EBF-3A5F-4241-B9F2-789605D99817@dilger.ca>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 05, 2024 at 01:05:01PM -0600, Andreas Dilger wrote:
> On Apr 3, 2024, at 1:22 AM, Sweet Tea Dorminy <sweettea-kernel@dorminy.me> wrote:
> > 
> > Update the signature of fiemap_fill_next_extent() to allow passing a
> > physical length. Update all callers to pass a 0 physical length -- since
> > none set the EXTENT_HAS_PHYS_LEN flag, this value doesn't matter.
> 
> Patch-structure-wise, it doesn't make sense to me to change all of the callers
> to pass "0" as the argument to this function, and then submit a whole series
> of per-filesystem patches that sets only FIEMAP_EXTENT_HAS_PHYS_LEN (but also
> passes phys_len = 0, which is wrong AFAICS).
> 
> A cleaner approach would be to rename the existing fiemap_fill_next_extent()
> to fiemap_fill_next_extent_phys() that takes phys_len as an argument, and then
> add a simple wrapper until all of the filesystems are updated:
> 
> #define fiemap_fill_next_extent(info, logical, phys, log_len, flags, dev) \
>    fiemap_fill_next_extent_phys(info, logical, phys, log_len, 0, flags, dev)
> 
> Then the per-filesystem patches would involve changing over the callers to
> use fiemap_fill_next_extent_phys() and setting FIEMAP_EXTENT_HAS_PHYS_LEN.

Cleaner still would be to just have the callers initiaize and pass a
struct fiemap_extent instead of passing around a whole bunch of integer
parameters.

You get more explicit naming, better typesafety - functions with a bunch
of integer parametrs are not great from a type safety POV - and you can
add and pass fields to fiemap_extent without having to update callers
that aren't using it.

