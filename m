Return-Path: <linux-fsdevel+bounces-46436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3168EA89622
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F38188F7B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 08:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E25F27A92E;
	Tue, 15 Apr 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoDQJ6ei"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0890205AA3
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704679; cv=none; b=jJja9UgHbDWn7/YNuijwpP1epvsysJVB8SGSbTdp3n9W0ulkoI0CIZZkRi+qBL6ymB+r893SVhzoBxAsoe9lVd7QS44uCBGcfiH8cccegki1O/MF2+XZ7vjMTOh5oQbQ4eUT0wTQPjyIduPB9Ej3jWrTunerg63RxtLy2rrsTrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704679; c=relaxed/simple;
	bh=7MY0DpxzYzXfDDdECVdCOWiTRMozuCmRZwDblB/8Q/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/8nqCCSn2VBfCSQmxiMR6L84+ADSAtqTV3qxFlbwhSU6ZJb5c1qJTtXwSJwiHpslKYPKDDXEwoG775OE7g8Zzpx5N4lsxwTD40M9dW+S62kOKUkjlXyug1/OdRkIgfVnH35+rd5bbVkHoTkJ0pTWTnopv0ZpETnUaNt5GEMp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoDQJ6ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBB0C4CEDD;
	Tue, 15 Apr 2025 08:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744704678;
	bh=7MY0DpxzYzXfDDdECVdCOWiTRMozuCmRZwDblB/8Q/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NoDQJ6eisqWaV36mi8V97KbC1xyj/R+1L/ack5h47hpB1uLfFkX4AT4WTB+f8U1IL
	 Fo2kd6WqA3/aZA8aehZGnwv1fG53Ot+Aa0CzCY3uiV3d+nY+J95w4nDRILxBa+vhsW
	 A/QvODGQXr7luUBEaJSLUTgGgB0vW+R1KqVNu8XH73f9EX1skvTflDG1Yj3MXvDwRv
	 Jf7GtFuuMv7rp4G1QCR09weuU+i9+siinkz/FbypTHBsry/KXOk9XW3qKZmeXHRATe
	 GTzWIzGoGzxjzNH9pb3rvN0mJ1NurZeN9eNF4LGIqoACSidzTeKIDbrFKE+ze8drLN
	 KD1ngznz4h0fg==
Date: Tue, 15 Apr 2025 10:11:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Can we remove the sysfs() system call?
Message-ID: <20250415-schlecht-raushalten-2af1f84f25b8@brauner>
References: <20250414-gefangen-postkarten-3bb55ab4f76a@brauner>
 <CAHk-=wj+SJCYnBT-CZx0sCgWg1jovGZHb+OKs7kqN-enF-Gz8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+SJCYnBT-CZx0sCgWg1jovGZHb+OKs7kqN-enF-Gz8A@mail.gmail.com>

On Mon, Apr 14, 2025 at 08:45:56AM -0700, Linus Torvalds wrote:
> On Mon, 14 Apr 2025 at 06:35, Christian Brauner <brauner@kernel.org> wrote:
> >
> > we've been carrying sysfs() around since forever and we marked the
> > sysfs() system call as deprecated in 2018 iiuc.
> >
> > Should we try and get rid of this odd system call or at least flip the
> > config switch to default to N instead of Y?
> 
> We can certainly try. But I bet it's used somewhere. Deprecation
> warnings tend to mean nothing ;(

So let's try to decouple if from CONFIG_EXPERT and switch the default to N
and see what happens.

> 
> > (Another candidate that comes to mind is uselib().)
> 
> That one is already 'default n' since a few years ago, and only
> enabled on some legacy architectures that still use a.out:
> 
>         default ALPHA || M68K || SPARC
> 
> so ...

Ok, let's try and shed it.

