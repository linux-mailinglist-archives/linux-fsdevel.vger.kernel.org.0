Return-Path: <linux-fsdevel+bounces-45173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8467A74064
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 22:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED4A16DA28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 21:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC8C1DDC0B;
	Thu, 27 Mar 2025 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqNNF7S4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C01CCB21;
	Thu, 27 Mar 2025 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743111770; cv=none; b=b81k+78mjKjr9WaWy/x3wHlLsa/rpzb3UPfAHHW8FML2di/0fZqFI0JSzi/Oz++O2HpcKIeZGknxBLciLbZ/J/C8U9AcScPDD8tbzkbB2zlItVNOv+xtv5g7eNw7tGEHenEIqPd9wMDmAu2xzt0oLe5XnUVOpnf4D1glnT57a2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743111770; c=relaxed/simple;
	bh=wuNLkKAivy4ND6gJk+lfRdXsflBg+O8HRse8kZCo6g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiHQkkll+9i0D3yYqf6UMPz7leoH1yCT4QCVax7/SoZ/13JwBPF6aUDo5S1wm4eo9nYuORRM/gvutGX9PQwGPibLUNyPuNylpNcMAMoze2tEEhbyvneO5UTtaUAiUiPw2+EL/pdx8980eiRWQ8kufdJAKqMmzIbZ8dFsbvI2nug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqNNF7S4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F7EC4CEDD;
	Thu, 27 Mar 2025 21:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743111770;
	bh=wuNLkKAivy4ND6gJk+lfRdXsflBg+O8HRse8kZCo6g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqNNF7S4votd5Xq5iAEeYkkiJIXIg9J8NFpD0RoUrhO9hbm1NqNGRNw2Y7By4KZLx
	 XW/FQuyzNQhUU10z5i4Td0LSUXEHUwKOJB2ht0BhP3/+tTZ/30t9qQmR1oKdclsT4Y
	 pP8VagRQBCjgSo81azT7L2tN/zbAOz5i83+L5efhoRjGgLzm83kNgOkcgj6+cSFLBD
	 LjdVCF+x99sR/Ril4HWToOypmzBvYp0k/ZfURsGHN904zy2VVSZP4kt8g0MSdmIsE5
	 yq+45AADRgLSi/f7dmEunz87AWX9MfQ/ZRnCODkwTiZ0kT75swOEBTVygd0JDPIP0A
	 9ngntWTxCzogQ==
Date: Thu, 27 Mar 2025 14:42:48 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: syzbot <syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com>,
	Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, hare@suse.de, joel.granados@kernel.org,
	john.g.garry@oracle.com, kees@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
	willy@infradead.org
Subject: Re: [syzbot] [mm?] [fs?] BUG: sleeping function called from invalid
 context in folio_mc_copy
Message-ID: <Z-XGWGKJJThjtsXM@bombadil.infradead.org>
References: <67e57c41.050a0220.2f068f.0033.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e57c41.050a0220.2f068f.0033.GAE@google.com>

On Thu, Mar 27, 2025 at 09:26:41AM -0700, syzbot wrote:
> Hello,

Thanks, this is a known issue and we're having a hard time reproducing [0].

> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152d4de4580000

Thanks! Sadly this has not yet been able to let me reprodouce the issue,
and so we're trying to come up with other ways to test the imminent spin
lock + sleep on buffer_migrate_folio_norefs() path different ways now,
including a new fstests [1] but no luck yet.

We will work on a fix, let's follow up on the original report [0] or the new
tests case suggested thread [1] thanks!

[0] https://lkml.kernel.org/r/202503101536.27099c77-lkp@intel.com                    
[1] https://lkml.kernel.org/r/0250326185101.2237319-1-mcgrof@kernel.org

  Luis

