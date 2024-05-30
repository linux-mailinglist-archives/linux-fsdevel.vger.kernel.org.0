Return-Path: <linux-fsdevel+bounces-20527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C14F8D4E7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 16:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7701F2228C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 14:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A917D8A0;
	Thu, 30 May 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dvhl/4kD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566617D89A
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081094; cv=none; b=iEX7M4gqi5QEMBLlzr+tDrGtqYW9+tSmuRhu5GWkm7EU97+i0zPf1GOe/4WP+LdDt6OtwrAGnGX1gr4Ak+PDgMkfQkG+WcXwRPHMO+00fm57IkcHxZh3G/X0K65rSLva9SvBv+CNL3NIlueL9BmyalpvEa9aSj7BIqdFGKDBzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081094; c=relaxed/simple;
	bh=G7aA+84dOCaZeR85BLPAO/fROgjc2bBecY1qTHvGZIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmtIHS+QkqurADy+4vYS8d6WgpwNQRw48n+SoM0FO1mzosUWz0/S+K4P27fEgOnxqwpUaS6z8irowoGXztGaVe9CNLHRhzQQqjx3kDpo75wrO7hzQED8gCDqd87JTguVbdBTBe4+MDoRJqgyR/gyyDli/A0+TQYjPZ/LQZPgj1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=dvhl/4kD; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43fb18ad56dso5441631cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717081092; x=1717685892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m0qvHudrMdeG6GYXCX1OZJe27IqRuTNRBkoEpa9jzXU=;
        b=dvhl/4kDR+ogUXaHa5auuTqLY/ohQcJDJgXiMfP1j2oEAqeMOwEsLhQIFfy/v1ypZG
         7msxisHIqg/wqWgnK0TVXBMrHjDjUf53flRVLA/YV993oAf75DTIVuflSej8KGbu5cwD
         42Vaoqr3CE+TmFlEBL/11NsPnlCD06h/WgiocEUbimCDgUJuy4v02H+rapXwUTUprQ+v
         eHp8x+HRt68Q//kXh02ovSBZO2h023ir4BJABNI21HTL25kkqSV7IsO58yyeNe+RiPGN
         bNOaWtMa8Lv3mv6akSe8AszfdwV7uBIFoUM/mpWwiCtpP9tF5VX6+MJ2RMw2MjOGE1nN
         RjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717081092; x=1717685892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0qvHudrMdeG6GYXCX1OZJe27IqRuTNRBkoEpa9jzXU=;
        b=sLzNaw3RCwEwxgzWFGKrMH5Rtiq+SgjIppPpVMU6dm4uXh1nK+E2S/rs2j99HTJpLV
         Q+5pwgLWH7xJ49+mqci54VWRyD8yRNeDSXWlYX+WG61yOrZgCZDVNJzFwtYKJ7Qq9ndo
         ciGQA4IOib9YHE7byfASVxiK+wD9ZvKe0YjHBbpvai/bMbjyJIQfdLBY/UDsn9Q9LkJK
         c6EUmr+xqMDuygn4DOQx8XtZhSUlkP2vBUenzIc2NLSh0wWCS2/vUg7wyRj6Ocmu7NO9
         t4YRrhU0fGJ0Ew12463hr1RDVrDmL++lQFgvr45qc0p3iQog0lSlmL50njaOO8Epmrkr
         8m3A==
X-Forwarded-Encrypted: i=1; AJvYcCULUV204s+wcZQLRUw3nrv365hqzS3aeborlC+wiGONC36B5t9mwrjuWg0D2EkORQA130E0UT5DThd0kNnEHEk+jOnLuZK0sJMMIsfGWg==
X-Gm-Message-State: AOJu0Yw2hCXjCHHU/sOK2BHV4kk1G0o3Pn5z/+HuA5NJ8u8XBynn1z0v
	7VfjdtziMYqKdgj36XgMRxnUhLer/vH+sb2gcd3y/LJqR2/ZfIXdaprGOWVum32H9E7UMvNUdkQ
	h
X-Google-Smtp-Source: AGHT+IE0fMKBuA1NlRjlWxTTMfT3hoiKWOQouuXkd8m8xuv6vTv4ynG2aLF+rT8W1aYFBFVUplRJHQ==
X-Received: by 2002:a05:6214:15c8:b0:6ae:19e2:39d3 with SMTP id 6a1803df08f44-6ae19e239d7mr11413526d6.45.1717081091605;
        Thu, 30 May 2024 07:58:11 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae0c519a7dsm8117206d6.70.2024.05.30.07.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:58:11 -0700 (PDT)
Date: Thu, 30 May 2024 10:58:10 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, david@fromorbit.com, amir73il@gmail.com, hch@lst.de
Subject: Re: [PATCH][RFC] fs: add levels to inode write access
Message-ID: <20240530145810.GA2205585@perftesting>
References: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>
 <20240530-atheismus-festland-c11c1d3b7671@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-atheismus-festland-c11c1d3b7671@brauner>

On Thu, May 30, 2024 at 12:32:06PM +0200, Christian Brauner wrote:
> On Wed, May 29, 2024 at 04:41:32PM -0400, Josef Bacik wrote:
> > NOTE:
> > This is compile tested only.  It's also based on an out of tree feature branch
> > from Amir that I'm extending to add page fault content events to allow us to
> > have on-demand binary loading at exec time.  If you need more context please let
> > me know, I'll push my current branch somewhere and wire up how I plan to use
> > this patch so you can see it in better context, but hopefully I've described
> > what I'm trying to accomplish enough that this leads to useful discussion.
> > 
> > 
> > Currently we have ->i_writecount to control write access to an inode.
> > Callers may deny write access by calling deny_write_access(), which will
> > cause ->i_writecount to go negative, and allow_write_access() to push it
> > back up to 0.
> > 
> > This is used in a few ways, the biggest user being exec.  Historically
> > we've blocked write access to files that are opened for executing.
> > fsverity is the other notable user.
> > 
> > With the upcoming fanotify feature that allows for on-demand population
> > of files, this blanket policy of denying writes to files opened for
> > executing creates a problem.  We have to issue events right before
> > denying access, and the entire file must be populated before we can
> > continue with the exec.
> > 
> > This creates a problem for users who have large binaries they want to
> > populate on demand.  Inside of Meta we often have multi-gigabyte
> > binaries, even on the order of tens of gigabytes.  Pre-loading these
> > large files is costly, especially when large portions of the binary may
> > never be read (think debuginfo).
> > 
> > In order to facilitate on-demand loading of binaries we need to have a
> > way to punch a hole in this exec related write denial.
> 
> Hm. I suggest we try to tackle this in a completely different way. Maybe
> I mentioned it during LSFMM but instead of doing this dance we should
> try and remove the deny_write_access() mechanisms for exec completely.
> 
> Back in 2021 we removed the remaining VM_DENYWRITE bits but left in
> deny_write_access() for exec. Back then I had thought that this was a
> bit risky for not too much gain. But looking at this code here I think
> we now have an even stronger reason to try and get rid of this
> restriction. And I've since changed my mind. See my notes on the
> _completely untested_ RFC patch I appended.
> 
> Ofc depends on whether Linus still agrees that removing this might be
> something we could try.
> 

Muahaha you took the bait.

I obviously much prefer this solution, and from what I can tell we're all pretty
well in agreement about this.  Turn it into a real patch and I'll happily add my
reviewed-by.  Thanks,

Josef

