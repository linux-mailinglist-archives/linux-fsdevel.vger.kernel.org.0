Return-Path: <linux-fsdevel+bounces-43835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17656A5E654
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0963F7A404E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BFB1EF389;
	Wed, 12 Mar 2025 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jawZtg+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB21EF092;
	Wed, 12 Mar 2025 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814187; cv=none; b=tCB9+mGt1L+2K2xVOWqigrv/DFtZJLkGOU7BnE9FHu0pyflvha9sJF68PvEvfyZNZfQnFwEexfamb55KqXlG+EBV8koNzM14TAm8Rluz8Tfd1ASZCTZp47Meposi6WL55MHr2wG4rwEJzpBCEYpBuAvdM6+FD4Q7nDI58mIOS6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814187; c=relaxed/simple;
	bh=gXobkr5RGlxGsi4Oyj14C+WHajtLZFJfSI92ipFvpXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIPa7IrjLckpuELfFR9ShmbA6zlS1TmdfHs5KdSrEllhbuejKMtekQ9rGttw3a/DXVn68nkpF/NGmjA06XnsrfP8hVRVz1JJpr9QnsVYB7qbapqfFhRKELiaG14VRbUYF++m0mbhdGYcRom3kpFqMKFC4MjaK41PpgJR3c7MBGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jawZtg+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E837C4CEEF;
	Wed, 12 Mar 2025 21:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741814187;
	bh=gXobkr5RGlxGsi4Oyj14C+WHajtLZFJfSI92ipFvpXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jawZtg+1KlRN/fQwKl2oWCwYXgmYGA9bWl0strszKxmCGLiTCEG8XjsyrDcXzQHzM
	 bM1HFavyf/XvZ8jAdu0VfoVNVx1kvH+ZB7aF1uJi3OUMzro8k61YARENoTbCOejhDB
	 3+DVtVO6o8M52APoEvKGlbHzw5JJI5SRtECa+JGQj/5Ff6bNqUvPK/ZmtMc5IYraId
	 rzRmi1SVLXd/fR0KEK+zJI5Xpn1gMAnHYtgZIEljyK7pwg27UU77khh8Lkh0E/ebO8
	 kkoi3DEPZCNvWVfXdW5pHER5xX2JZcx3gbXVLzL2p/yQGyAyzVEgKqimKnPAfl/KRy
	 lhucv3rAjhNEg==
Date: Wed, 12 Mar 2025 22:15:45 +0100
From: Joel Granados <joel.granados@kernel.org>
To: John Sperbeck <jsperbeck@google.com>
Cc: Kees Cook <kees@kernel.org>, Wen Yang <wen.yang@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: unregister sysctl table after testing
Message-ID: <5cves6b5bzpvmhwl3jqepz4pm5oz226fzjqzlxpzmxvxmiftv2@2vgc37lywq3a>
References: <20241224171124.3676538-1-jsperbeck@google.com>
 <jedmwyiggspxnr76ugyax73zwotbnrwpccy7gafdeq6vyweb6z@4c3ivqegpgkd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jedmwyiggspxnr76ugyax73zwotbnrwpccy7gafdeq6vyweb6z@4c3ivqegpgkd>

On Mon, Jan 06, 2025 at 03:15:13PM +0100, Joel Granados wrote:
> 
> On Tue, Dec 24, 2024 at 09:11:24AM -0800, John Sperbeck wrote:
> > In commit b5ffbd139688 ("sysctl: move the extra1/2 boundary check
> > of u8 to sysctl_check_table_array"), a kunit test was added that
> > registers a sysctl table.  If the test is run as a module, then a
> > lingering reference to the module is left behind, and a 'sysctl -a'
> > leads to a panic.
> 
> Very good catch indeed!!!.
> > 
...
> >  	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_foo));
> >  	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_bar));
> > -	KUNIT_EXPECT_NOT_NULL(test, register_sysctl("foo", table_qux));
> > +	hdr = register_sysctl("foo", table_qux);
> > +	KUNIT_EXPECT_NOT_NULL(test, hdr);
> > +	unregister_sysctl_table(hdr);
> This indeed fixes the behaviour, but it is not what should be done
> and this is why:
> 1. sysctl-test.c is part of the unit tests for sysctl and actually
>    trying to execute a register here does not really make sense.
> 2. The file that actually does the regression testing is
>    lib/test_sysctl.c
> 
> If you are up for it this is what needs to be done:
> 1. change what is in sysctl-test.c to call sysctl_check_table_array
>    directly and not worry about keeping track of the registration.

With your V4 it is clear to me know that I should *not* have made the
first suggestion of calling sysctl_check_table. Exposing the
sysctl_check_table just for the kunit test is overkill as we can get the
same result with a register call from lib/tests_sysctl.c without all the
hassle of exposing the function call. Your proposal was still valuable
as it clarified what the "right" approach should be.

Best
> 2. Add a similar regression test in lib/test_sysctl.c where we actually
>    check for the error.
> 
> Please tell me if you are up for it (if not I can add it to my todos)
> 
> Best
> 
> >  }
> >  
> >  static struct kunit_case sysctl_test_cases[] = {
> > -- 
> > 2.47.1.613.gc27f4b7a9f-goog
> > 
> 
> -- 
> 
> Joel Granados

-- 

Joel Granados

