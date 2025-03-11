Return-Path: <linux-fsdevel+bounces-43695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC58A5BE87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078291898314
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C2252913;
	Tue, 11 Mar 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVqYr2vr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F386C24394B
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691256; cv=none; b=lTYNyY7eUd6dDwXkIqGbHTamuXlTWAUytcqBPLcNY+VXzAzCdN3rujz1GqzWBZaHSkdEgSV6Mty8x1EX02iybfFAoCQSEskdkAGShMZ/Iz4sJnp3sPtXfQtsr7mw1tyBf3S56VB7BET3r/t1J8ZByH+TUQ8Z3WW0RimZLdZI2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691256; c=relaxed/simple;
	bh=yCUYZ35L1dCUZlM3Iv2ktpduTKLg8T8RbXihOP5V+3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsXzhW0Fw/J1SOkCtkR1hg5jOjsX7lHquflQHBQNZVxF40LPXcHJv0OYvgDo3j35lAKiqtPXkJWNZbiXN8qMxDQArSc2hzh/LXG3/5pbt+MRHkOueADDOwGkVdQt7UmP1FEwGq8rxAEgNMh98ttmR9I/PQWQ6VyEjwihkCas0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVqYr2vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B380C4CEEB;
	Tue, 11 Mar 2025 11:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741691255;
	bh=yCUYZ35L1dCUZlM3Iv2ktpduTKLg8T8RbXihOP5V+3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVqYr2vrIcQ8sTYIUEi+Bounp1NHfDDSSRylEt4/LpLg9BrgWB5zVcsFNwFRJe/wz
	 Tkf2gRsMeSLcx2ZtHraN6+7bUrrm0vN/F6gwBj9s+hjAXptVdlu8bGqf7oWCveMBs9
	 0XOI2cIaKrqTJaEq1DErUwLeNCKawXA892bV0N4Rj1qvLP35ZPbfUBKFwwUnC/gM+2
	 L3iLJOJIkXHoxx3S5MurlpiydDieMUGD+L1Q3oqlc21tv8ejC6PG+bToEH7qUaRqlT
	 aX2ie7Mhe6iwhmoq+QeIAagnExZ0RYk/y3uSnEpeHIdjQ9E1/1hAp8f3Tb9PJyeeBK
	 kG+/z2kKxP2+A==
Date: Tue, 11 Mar 2025 12:07:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] selftests: add tests for mount notification
Message-ID: <20250311-riesig-leihwagen-62030ac9a55f@brauner>
References: <20250307204046.322691-1-mszeredi@redhat.com>
 <20250308-preis-skandal-1631e95a883c@brauner>
 <CAJfpegs-h8M1PFcnqiHN=wsRJD_8cMyTzjoivJe-BACik7U6sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegs-h8M1PFcnqiHN=wsRJD_8cMyTzjoivJe-BACik7U6sg@mail.gmail.com>

On Mon, Mar 10, 2025 at 12:00:43PM +0100, Miklos Szeredi wrote:
> On Sat, 8 Mar 2025 at 13:10, Christian Brauner <brauner@kernel.org> wrote:
> 
> > setup_namespace() can just be called on each FIXTURE_SETUP() invocation
> > and cleanup_namespace() on each FIXTURE_TEARDOWN(). They will always
> > start with a clean slate this way.
> 
> Ah, hadn't realized that each test case will get a fresh process...
> 
> Attached further cleanup with this in mind.

Thanks! I've folded this into the patch!

Christian

