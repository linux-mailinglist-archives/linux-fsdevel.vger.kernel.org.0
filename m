Return-Path: <linux-fsdevel+bounces-8443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFB3836971
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 17:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1E1283571
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F6281219;
	Mon, 22 Jan 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJv7WUTs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF14CB52
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936240; cv=none; b=n+NaFMiPzRZUY6iJbU6dWwQqftBj963sHeUAZ4DhwoJlI7+qvkWqQUZQcE2Ol0uOrkxlRkSTIIdATrIZHoyikaZCW2qQSAtzr6ofP6o3g/dlPMyLoJUCkNyr8CKlzGHRs9STL/itinZqhG9hG0oKDGxh66vEhmiuSm4o7whCk3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936240; c=relaxed/simple;
	bh=fSBeLj2FXGrY56pzMCxEoTq591DFXhn2WJr+AS9rKWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiTtNjEMfdI2nH4Gv+eM8GtPe8FJgzjuL6XhMhP+KYn1Dg+rLxVrA8AL3Z/mqLRiH0se//x+VShwqoVkHYapYSxHFz7vM5HMqup3fDOOUAsX2rIwCrp1BrVNAy71g3jsFDPu0NPJimJF+FfD/2zn1UeBova+Lx2YsoCq22xNgc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJv7WUTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CC0C43390;
	Mon, 22 Jan 2024 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936240;
	bh=fSBeLj2FXGrY56pzMCxEoTq591DFXhn2WJr+AS9rKWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJv7WUTsLSy9ByM4eev04JVS8+V8b85uf1BPn0B9w+0FR1lyrI1H8mDg2rsAupYLX
	 18UVwR2wU3LhYODF6vEoKfV/L0UfF2C2KcolgYsJXP5fLFIfwipgfsCgQPZrCDC2bv
	 B7bNY9KqEc/lNMkWxKzsnzEVqLS32WYfVr0kNVpOWhtOzFROtoSGHcx9dCdJ46z+cC
	 jBp1F7djoAIPFI3atY9CNOoD7C6cZApPN38il5FkJ8lSJMQXHqvB6pr/HcS1tRicJi
	 f5mtZtnPs1W9CC0EiMae+LaS36D67lnbWdt2QjwJvnK45kram274oJeVbs3yiwriU7
	 tn9KkGIc1dUJA==
Date: Mon, 22 Jan 2024 16:10:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Gabriel Ryan <gabe@cs.columbia.edu>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: Race in fs/posix_acl.c posix_acl_update_mode and related checks
 on inode->i_mode in kernel v6.6
Message-ID: <20240122-summieren-einchecken-4d9d27edcacc@brauner>
References: <CALbthtcSSJig8dzTT0LNkhYOFEZCWZR1fvX8UCN2Z57_78oWnA@mail.gmail.com>
 <20240119-rastplatz-sauer-b8a809f0498c@brauner>
 <CALbthtcRoJ_mBRmEBUmyMDw-WPpLOyAEecpu6jj+1AFBEWrkoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALbthtcRoJ_mBRmEBUmyMDw-WPpLOyAEecpu6jj+1AFBEWrkoA@mail.gmail.com>

On Fri, Jan 19, 2024 at 10:24:59AM -0500, Gabriel Ryan wrote:
> Thank you for your response Christian. I reported the race because it
> appeared potentially harmful, but based on your response it sounds like the
> race is almost certainly benign, and any potential issues would be
> addressed with WRITE_ONCE() as you suggest.

Ok. What I'm asking is whether you can confirm that the thing that your
tool discovered is indeed a WRITE_ONCE() issue. Is there any trace and
any more details?

