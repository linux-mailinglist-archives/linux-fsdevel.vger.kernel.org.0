Return-Path: <linux-fsdevel+bounces-13266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1195986E167
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6031C2166F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035EB4087A;
	Fri,  1 Mar 2024 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdrD36i5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667643E47F
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297846; cv=none; b=lbrgMjRf9VVIf8H7k0EethQ+Wo11Arj52kbTrEuI+S1r700smAOV6WbDxzhHt21ReW4p2YPsNVJboim5qpOjduNhajavtZOuyc0raofy7bWScvAlpCB+HhEjrcMnHOLFy7MnSjPvpS9U3YK0v8Q7/aedhJ5lDfs1rBvFceWtstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297846; c=relaxed/simple;
	bh=RpJahEMw+xWp8TA56IwROuaIMUIWozptg7WJ3K0KL4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tijhOF0kbGrb+NrsZjRm86KQg3d5cDrLAS90BfqKgpHB8pX3qDa4OUZjkhsRzF/uYm56J0UT5JdZtRWCL/6RoVKrxT9KGx8L7/itJFjZjKVNY9mHXU9VaaUEriUONWlXWddtggJGvrWMZoBEOoOdjIfi1pgqvnWYF4lakAAOLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdrD36i5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E2CC433C7;
	Fri,  1 Mar 2024 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709297845;
	bh=RpJahEMw+xWp8TA56IwROuaIMUIWozptg7WJ3K0KL4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdrD36i5y5Q5OcwZatJ2B5ewU5YbcbBWeO592qSbA1hQgIT8QMD9whqqoGUDbbp7Z
	 GzG3U0QF4up0kAl8NapgY5sUjWATKoWH3q/xr/7JOvTWJHNHJtRpK51wvr/qCw6ewg
	 OUaJPp9/E3ZZoVq2ZL6l9au5p2W/Yq+WuQQC9q24CpGLGgJ+18NUQQ1CwEpJTZTu0O
	 0NLmMhirhM3WHhJFsOeXS3Kk7sDHMAlQgUrxrPngHHzDybsCdfpiAEpBbeuWEdf6LR
	 sCwQ8SQqiW5bRfvx1AJ9tFFJv/60Se9NW9Xm0ISArc+rPab4qSizEA+EDfBsQ9pRLb
	 t9CD9CuZ3dlNg==
Date: Fri, 1 Mar 2024 13:57:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, linux-fsdevel@vger.kernel.org, 
	rodrigo@sdfg.com.ar
Subject: Re: [PATCH] hugetlbfs: support idmapped mounts
Message-ID: <20240301-wedel-lenkung-db380eb1e90f@brauner>
References: <20240229152405.105031-1-gscrivan@redhat.com>
 <1B974CF9-C919-48F5-AC0F-7F296EC5364F@linux.dev>
 <87ttlq5q6g.fsf@redhat.com>
 <B8C52AAA-C8B5-4DF9-B9B2-A7DC1270E0AF@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B8C52AAA-C8B5-4DF9-B9B2-A7DC1270E0AF@linux.dev>

On Fri, Mar 01, 2024 at 04:47:30PM +0800, Muchun Song wrote:
> 
> 
> > On Mar 1, 2024, at 16:09, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> > 
> > Muchun Song <muchun.song@linux.dev> writes:
> > 
> >>> On Feb 29, 2024, at 23:24, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> >>> 
> >>> pass down the idmapped mount information to the different helper
> >>> functions.
> >>> 
> >>> Differently, hugetlb_file_setup() will continue to not have any
> >>> mapping since it is only used from contexts where idmapped mounts are
> >>> not used.
> >> 
> >> Sorry, could you explain more why you want this changes? What's the
> >> intention?
> > 
> > we are adding user namespace support to Kubernetes to run each
> > pod (a group of containers) without overlapping IDs.  We need idmapped
> > mounts for any mount shared among multiple pods.
> > 
> > It was reported both for crun and containerd:
> > 
> > - https://github.com/containers/crun/issues/1380
> > - https://github.com/containerd/containerd/issues/9585
> 
> It is helpful and really should go into commit log to explain why it
> is necessary (those information will useful for others). The changes
> are straightforward, but I am not familiar with Idmappings (I am not
> sure if there are more things to be considered).

Fwiw, I've reviewed this before and it should be fine. I'll take another
close look at it but last time I didn't see anything obvious that would
be problematic so I'd be tempted to apply it unless there's specific
objections.

