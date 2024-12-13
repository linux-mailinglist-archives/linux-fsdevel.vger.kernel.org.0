Return-Path: <linux-fsdevel+bounces-37287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B0D9F0CC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 13:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717A6188A0CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AE01DF975;
	Fri, 13 Dec 2024 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4bovoOE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AE2B640;
	Fri, 13 Dec 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094511; cv=none; b=fc2WXXfEDTl+QpHRiuZk7vv4N+286BFjI4fBfzMZI6eW5fufdWVwR5Ag/LbOuOGL3A0r3cE3tqczDg1h2AZg4Jv8r6bz8EeCf0z91Nm91aVtnlerUD64NmCLp7/lkxBnwYT1TY3l2+i2CsQio3BaJuNWa2m222gFRkbw5Lo19d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094511; c=relaxed/simple;
	bh=7mwCOvuyHIc22FD6tLxBjbr9hEruZoO7s86JF9h5Lf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AO9a6XaLyUaj5KpB2WyoUOGgKlgZoltuAmV8aZRM8+/AdRIDIIutcoFrkn1sVifat1oZiLNkxKczeQ7/IzQfsP+p0LXaTX4wVw+oLn0EgvbnRIXj6aQjAZmmNBHrVCobVrJIts36tercAqNo0k6kxOeGJwMElx0VLADBjLmMHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4bovoOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2943CC4CED0;
	Fri, 13 Dec 2024 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734094511;
	bh=7mwCOvuyHIc22FD6tLxBjbr9hEruZoO7s86JF9h5Lf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4bovoOEPYkWakW8u7zzLHS5jn7VUiWmHKI7vVil1VmyIqs8KY6+5SBbt3dRjb5eX
	 ardmDRWvPpzjbnMGz1ciz0NofGXVwltinAbee6QB6ve8Uzk+aV5y97ISoI65EqUZgr
	 ilkzMkanJmaGhfUh2sIi29mCTgM5M5jWqsOGQ9ALukeS+maj3rUxhvwUY69ft08OCr
	 HDZh7x+ZDisFhdk5UQdA14xjIC24mlar796OedY+T+Pxwuwyu3kRtZpcWLQauv28xU
	 as3+UV3YM2869XJyYWnU/JFBhrH5Q7LgoO+NokYtezBwUHiS30/4VTdP0scYRN8ybL
	 W9h/hdvjZRzcA==
Date: Fri, 13 Dec 2024 13:55:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] Add a prctl to disable ".." traversal in path resolution
Message-ID: <20241213-raupen-jodhaltig-15b59bde264b@brauner>
References: <20241211142929.247692-1-mjg59@srcf.ucam.org>
 <20241211.154841-core.hand.fragrant.rearview-Ajjgdy5TrwhO@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211.154841-core.hand.fragrant.rearview-Ajjgdy5TrwhO@cyphar.com>

On Thu, Dec 12, 2024 at 02:56:59AM +1100, Aleksa Sarai wrote:
> On 2024-12-11, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > Path traversal attacks remain a common security vulnerability
> > (https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=%22path+traversal%22)
> > and many are due to either failing to filter out ".." when validating a
> > path or incorrectly collapsing other sequences of "."s into ".." .
> > Evidence suggests that improving education isn't fixing the problem.
> 
> I was thinking about adding a RESOLVE_NO_DOTDOT which would do something
> like this but on a per-openat2-call basis.

That's what I was thinking a while ago. I discussed that with Linus
in connection to a change by Jann for looking up module paths.

https://lore.kernel.org/r/CAADWXX_zpqzYdCpmQGF3JgsN4+wk3AsuQLCKREkDC1ScxSfDjQ@mail.gmail.com

> 
> The main problem with making this global for the entire process is that
> most tools would not be able to practically enable this for themselves
> as it would require auditing the entire execution environment as well as
> all dependencies that might dare to use ".." in a path anywhere in their
> codebase.

I agree.

