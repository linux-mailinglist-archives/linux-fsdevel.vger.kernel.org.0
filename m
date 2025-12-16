Return-Path: <linux-fsdevel+bounces-71483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DDFCC4A13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 18:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC10830966AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0108630F81A;
	Tue, 16 Dec 2025 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB+7A08E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91326A0B9;
	Tue, 16 Dec 2025 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905214; cv=none; b=GmWmWg+Aj5JITP4ATbcQQ3fzk0KwvlgDzg/G47P+Cdomz86nVDsSXSgJ0oqLbRmAMcG4YqyVahljJLck5BKohcU9WjRjJk+VYf7KHXbYzIp0Sq7f4smt9GeRwhybbnA6Yzk0aEw2cH7+Bn+UnpZaJAnM06E9Ov8IxfINIPdzh0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905214; c=relaxed/simple;
	bh=PmG7mhtDlW1rzkeObmk2MqIcRkoEkEJJYUz6mFqYU2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSVaadac/nRGfQqJkTjkwuGgk1xIBLEm3kqGkj2/yf9pPgQszbOAaowmesXmGttT7QI7tSkS/jxJJ/slJiP2HnSwgI9R1/tm00hSpIbVWAIXkqpj/kBaGmpu1lXZBYoQRon5hRE3DSkHJawm5jndKdgw2cv4nzRMKMc+ehnjWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB+7A08E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8A3C4CEF1;
	Tue, 16 Dec 2025 17:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765905214;
	bh=PmG7mhtDlW1rzkeObmk2MqIcRkoEkEJJYUz6mFqYU2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jB+7A08EVz8OHc1FfUGAS+uZ5fuuXToioi6pmX53LwhvA6zMLAx7TD8TeE/ekNldQ
	 OYpp5hRgUY8ZmNz+3zZKHHVWv50vwHNgx/rppbs0fMABtj/gX5IgXDUpqwE0D75i5W
	 4snQswZOp2P/dw1zHjztjcjjwLDZj+uduLudH6wcWAV2SyBCnNlX9HPNog01C7VhAz
	 DnT3iGacW9+sxgpsrXl3nOqGDma3sET+DzdlcAh1ubiaA8Qfycd4xm5/SSFUdEDHH3
	 jp2RMBS87pq0AnLJbf09YNC7xt927zTy5+uk/Txyz2Qce+9xcT2Df8BWhyTlNAep4J
	 0keF2BYHqH3DA==
Date: Tue, 16 Dec 2025 09:13:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH fstests v3 3/3] generic: add tests for file delegations
Message-ID: <20251216171333.GG7716@frogsfrogsfrogs>
References: <20251203-dir-deleg-v3-0-be55fbf2ad53@kernel.org>
 <20251203-dir-deleg-v3-3-be55fbf2ad53@kernel.org>
 <20251205172554.pmzqzdmwpmflh5bi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <be8dace96aa68c59330f6c7be6ec5e2482bb6ca3.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be8dace96aa68c59330f6c7be6ec5e2482bb6ca3.camel@kernel.org>

On Sun, Dec 07, 2025 at 03:35:29AM +0900, Jeff Layton wrote:
> On Sat, 2025-12-06 at 01:25 +0800, Zorro Lang wrote:
> > On Wed, Dec 03, 2025 at 10:43:09AM -0500, Jeff Layton wrote:
> > > Mostly the same ones as leases, but some additional tests to validate
> > > that they are broken on metadata changes.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > 
> > This version is good to me. But this test fails without the:
> > https://lore.kernel.org/linux-fsdevel/20251201-dir-deleg-ro-v1-1-2e32cf2df9b7@kernel.org/
> > 
> 
> 
> Thanks. Yes, that bug is unfortunate. I'm hoping Christian will take
> that patch in soon so all of the tests will pass.
> 
> > So maybe we can mark that:
> > 
> >   _fixed_by_kernel_commit xxxxxxxxxxxx ...
> > 
> > or
> > 
> >   _wants_kernel_commit xxxxxxxxxxxx ...
> > 
> > Anyway, we can add that after the patchset get merged. I'll merge this patchset
> > at first.
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> If you like. This functionality is only in v6.19-rc so far, so there is
> no released kernel that has this (yet).

Hi Jeff/Zorro,

Having rebased on 6.19-rc1, I now see that generic/787 (this test) fails
with:

 --- /run/fstests/bin/tests/generic/787.out	2025-12-09 09:18:49.076881595 -0800
 +++ /var/tmp/fstests/generic/787.out.bad	2025-12-16 07:23:40.092000000 -0800
 @@ -1,2 +1,4 @@
  QA output created by 787
 -success!
 +ls: cannot access '/mnt/dirdeleg': No such file or directory
 +Server reported failure (2)
 +(see /var/tmp/fstests/generic/787.full for details)

The 787.full file contains:

      ***** Client log *****
 10 tests run, 0 failed
      ***** Server log *****
      ***** Server failure *****
      in test 3, while Set Delegationing using offset 1, length 0 - err = 0:Success
      3:Fail Write Deleg if file is open somewhere else
      ***** Server failure *****
      in test 3, while Get Delegationing using offset 1, length 0 - err = 0:Success
      3:Fail Write Deleg if file is open somewhere else
      ***** Server failure *****
      in test 4, while Set Delegationing using offset 0, length 0 - err = 0:Success
      4:Fail Read Deleg if opened with write permissions
      ***** Server failure *****
      in test 4, while Get Delegationing using offset 0, length 0 - err = 0:Success
      4:Fail Read Deleg if opened with write permissions
 13 tests run, 2 failed
      ***** End file details *****
 Server reported failure (2)

(Apparently this test would _notrun in 6.18-rc)

Is this the failure fixed by the patch above?  If so, I'll ignore the
failure until rc2.

--D

> Jeff Layton <jlayton@kernel.org>
> 

