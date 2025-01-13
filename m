Return-Path: <linux-fsdevel+bounces-39022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B3BA0B3E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 11:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572163A4C4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 10:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C82045AF;
	Mon, 13 Jan 2025 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnjTeJOi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738151FDA94;
	Mon, 13 Jan 2025 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762510; cv=none; b=Cs1BpGz5FupjivucV8/U9WYNu/PwHUVnKau/Xqz/o/eLGdZd0HuYaKBJkrkcJQpDqkAHpgaP3esmK7z2gAooArmCB6SeivE5Xgn5NX5da8FtMZkH67DfUuDKjBkI6xeqhog43Ldl8igh2nw/stXbf9uJIm/aS5J6xkN6OmwELys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762510; c=relaxed/simple;
	bh=y18EF1hj7EoOZtZ1srEkTJuNylFpJ516m9Ff1dfjmkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZ1zlCP1m3g8uQEy/NFi5MHmMsUXQ8TwWO2xK72Y7d/OWU13tpz3/9CJMmR01E8+ZAz+wk4RmWBliPj8/AuQiK7QvIrGfmew7ldLHcHG8ttcvXF7Y2FeI7JJdDiOa1l6ma+Ugpy9nM26QVxGhqrqd+JCLWFfPE0krZPtsoB6M6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnjTeJOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9AFC4CEDD;
	Mon, 13 Jan 2025 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736762510;
	bh=y18EF1hj7EoOZtZ1srEkTJuNylFpJ516m9Ff1dfjmkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnjTeJOiyNiBppsmSSzzAkCQdeZ/47TAb9H8gsWrDT/VQn3XGxYcw5JNurI8BFpi6
	 CEJsB7pLhAZsJWBTPCR3NvA3813LghpkInoNQx7MmiSHwA42Spvs3g6DH6wZ/B6d83
	 kDO8BGCfndvzaYHjRJzEKrgaq4ZG9f9UV9EGC96CqZIlgEJLv3wPlJFSzSMwOM4Tto
	 0UPsBKDAGq+PoKhuyYen5wsjCgOGZZe8RCl3sPwSQOVkd2dTcdi2cmupl7GjGt/ITs
	 fgvehcQthtvjAuIwFPZjEKjDH72DVJ9IJLx4N4M2zl8ctCsb3yGhVTxx5nGBYc+B2y
	 Wam73AgQggsxw==
Date: Mon, 13 Jan 2025 11:01:45 +0100
From: Joel Granados <joel.granados@kernel.org>
To: John Sperbeck <jsperbeck@google.com>
Cc: Kees Cook <kees@kernel.org>, Wen Yang <wen.yang@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] sysctl: expose sysctl_check_table for unit testing
 and use it
Message-ID: <opxtvf4uk7joyd5wqij5a4uffzwnkfgppxgfkirudm5gtwbdyx@olcdcwt3kjo2>
References: <20250112215013.2386009-1-jsperbeck@google.com>
 <20250113070001.143690-1-jsperbeck@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113070001.143690-1-jsperbeck@google.com>

On Sun, Jan 12, 2025 at 11:00:01PM -0800, John Sperbeck wrote:
> In commit b5ffbd139688 ("sysctl: move the extra1/2 boundary check
> of u8 to sysctl_check_table_array"), a kunit test was added that
> registers a sysctl table.  If the test is run as a module, then a
> lingering reference to the module is left behind, and a 'sysctl -a'
> leads to a panic.
> 
> This can be reproduced with these kernel config settings:
> 
>     CONFIG_KUNIT=y
>     CONFIG_SYSCTL_KUNIT_TEST=m
> 
> Then run these commands:
> 
>     modprobe sysctl-test
>     rmmod sysctl-test
>     sysctl -a
> 
> The panic varies but generally looks something like this:
> 
>     BUG: unable to handle page fault for address: ffffa4571c0c7db4
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 100000067 P4D 100000067 PUD 100351067 PMD 114f5e067 PTE 0
>     Oops: Oops: 0000 [#1] SMP NOPTI
>     ... ... ...
>     RIP: 0010:proc_sys_readdir+0x166/0x2c0
>     ... ... ...
>     Call Trace:
>      <TASK>
>      iterate_dir+0x6e/0x140
>      __se_sys_getdents+0x6e/0x100
>      do_syscall_64+0x70/0x150
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Instead of fully registering a sysctl table, expose the underlying
> checking function and use it in the unit test.
thx for taking the time to change it. I have added it to my backlog and
will get to it at some point. It is not pressing as this touches sysctl
testing, which should not be used in the wild.

I know why you created the V3, but please add a comment on the mail (not
the commit) of what changed in every version.

Best

-- 

Joel Granados

