Return-Path: <linux-fsdevel+bounces-61324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC69B579AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477B11883725
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1C302158;
	Mon, 15 Sep 2025 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNuRCWkZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A543E30101A;
	Mon, 15 Sep 2025 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937267; cv=none; b=ql7ldw2ZbL/5yxXc2Jv+m1Oa9GcYP7GPytw/raCuNGBgrgZPAtRodWFOR+LE7WaBGL/YGgBJ3de0g6nDKNlLYuEYeIHDbxiFjwuUKSiZQflq+/0koRUBfk/VNF+ECJl5Yxjn3MvY9BhzUOGKBAW0QBs7ryeMdWkFePRpkyybeYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937267; c=relaxed/simple;
	bh=O6oXltWjbyyGt5xAMfPgI1qX7BVTXNaWiJ13TGR5IGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSxVicJVqVpneej2uyccqfk4GdL5aUjjjAfrv1wUYapre7RF59oR+Bern5UK3ApPIwp0xFMoVCPBogzfPv96pkkIZwqlEDF7hQM5gFATfjpvbK+zHwAQG/0pzDlhPSNCeIWt8nRoh2DJ0GWbudF8Mo8TSs5lCsau4E6hubpCIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNuRCWkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2734C4CEF1;
	Mon, 15 Sep 2025 11:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937267;
	bh=O6oXltWjbyyGt5xAMfPgI1qX7BVTXNaWiJ13TGR5IGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNuRCWkZzPp0qsEnUVvGTFshx0vVjC0zXTp8pg5SYPc70y9KziIIa35hZMwdOKPEZ
	 hnHGD9MfZ+Mje39gVi1D05PE2dUQt34w6xXhupgdMH18p8IHdndC39lTpHfUPddCBv
	 OgKns27afeeA6+tO8K4a8wvwKIN+lESMF53H7BAFmLBrjbtYmIb5cBpHDlr1HuCQN+
	 emp+VqqUOtwtLiajixJphFPwuPOkedQMdn4bVSiElQCDUpQQpOFo4umxrpIr9W1AKz
	 ILS1b8sBlHiFF1zQ8CecSp99N7yJfVBllTe8Vk+AQbaZR8wVQULQIh5yd1r3nUrqGc
	 dS2dU5YesnmTA==
Date: Mon, 15 Sep 2025 13:54:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/4] procfs: make reference pidns more user-visible
Message-ID: <20250915-sesshaft-lackieren-c7f074e8fc4a@brauner>
References: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
 <20250902-gehofft-ruheraum-3c286b25b6d3@brauner>
 <2025-09-05-kinky-napping-auction-creeks-pbN1Vi@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025-09-05-kinky-napping-auction-creeks-pbN1Vi@cyphar.com>

> The main issues are:
> 
> 1. pid1 can often be non-dumpable, which can block you from doing that.
>    In principle, because the dumpable flag is reset on execve, it is
>    theoretically possible to get access to /proc/$pid/ns/pid if you win
>    the race in a pid namespace with lots of process activity, but this
>    kind of sucks.
> 
> 2. This approach doesn't work for empty pid namesapces.
>    pidns_for_children doesn't let you get a handle to an empty pid
>    namespace either (I briefly looked at the history and it seems this
>    was silently changed in v2 of the patchset based on some feedback
>    that I'm not sure was entirely correct).
> 
> 3. Now that you can configure the procfs mount, it seems like a
>    half-baked interface to not provide diagnostic information about the
>    namespace. (I suspect the criu folks would be happy to have this too
>    ;).)

I think the easiest would be to add an ioctl that returns a pid
namespace based on a procfs root if the caller is located in the pid
namespace of the procfs instance (like
current_in_namespace(proc->pid_ns) or if the caller is privileged over
the owning ns. That would be simple and doesn't need to involve any
ptrace.

