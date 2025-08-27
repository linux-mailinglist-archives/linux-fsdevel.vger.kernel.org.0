Return-Path: <linux-fsdevel+bounces-59365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6E8B38354
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61738687E4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 13:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B80350D68;
	Wed, 27 Aug 2025 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="iesUnEz3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3181331E112;
	Wed, 27 Aug 2025 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299957; cv=none; b=l982ACA50I9th8TcNFCSbcITWd2RiZnkjaTo/ejsVnAfN2fOWCHpdrL8FQ6Ig0n5ZCiaglcLwgJwAqQsWds/oMSRM1eLA6ey+djVcz8GunAoASMNF4NjU+gaxPyTGxP38z/CLuvJo/XUCp2JTnYP/u5N7Pja2O81Ynzsxk7PXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299957; c=relaxed/simple;
	bh=nw/muDBgITviXdUO9uodqJEWDZfngONbrkxYnFKm1ZQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sRUMXRC6vCzk2U2cIgZrbQkE0W8T7G0/xPf3yQ02GGUcAwk0R3rhZHdHz2pCCWOQYmI9iEHm7cCsE711UxLGGNGOG39ApHxp/Bi/6MJSmptDPjyWqxp7R6bYcVIoo+QGRdbuhPxF1nGtYRi9gPjpnSmmCzumexDFu1V56m4RcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=iesUnEz3; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id 15DA8406B369;
	Wed, 27 Aug 2025 13:05:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 15DA8406B369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756299952;
	bh=y7EIXJ3gSrV4vOOLTRHHOfAaTcpZnV58etKp51XlHIo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=iesUnEz32nFZ/2pNUAYUzDhVg5h6C6yDFzz4+20mlbyi3pEa4H8z6d6+gtdjZDaF5
	 jRWw+kLeuMlFfdHwWXlHVmKJggJTosIPJFH+UFR3zkZed1aWu6fgHyo/G921pVtt4F
	 um4IR1BqhSW6wtLCOG8lmt1dawhzbDLU3oLpy9Yw=
Date: Wed, 27 Aug 2025 16:05:51 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Theodore Ts'o <tytso@mit.edu>
cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
In-Reply-To: <20250827115247.GD1603531@mit.edu>
Message-ID: <6d37ce87-e6bf-bd3e-81a9-70fdf08b9c4c@ispras.ru>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru> <20250826220033.GW39973@ZenIV> <0a372029-9a31-54c3-4d8a-8a9597361955@ispras.ru> <20250827115247.GD1603531@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 27 Aug 2025, Theodore Ts'o wrote:

> On Wed, Aug 27, 2025 at 10:22:14AM +0300, Alexander Monakov wrote:
> > 
> > On Tue, 26 Aug 2025, Al Viro wrote:
> > 
> > > Egads...  Let me get it straight - you have a bunch of threads sharing descriptor
> > > tables and some of them are forking (or cloning without shared descriptor tables)
> > > while that is going on?
> > 
> > I suppose if they could start a new process in a more straightforward manner,
> > they would. But you cannot start a new process without fork. Anyway, I'm but
> > a messenger here: the problem has been hit by various people in the Go community
> > (and by Go team itself, at least twice). Here I'm asking about a potential
> > shortcoming in __fput that exacerbates the problem.
> 
> I'm assuming that the problem is showing up in real life when users
> run a go problem using "go run" where the golang compiler freshly
> writes the executable, and then fork/exec's the binary.  And using
> multiple threads sharing descriptor tables was just to make a reliable
> reproducer?

You need at least two threads: while one thread does open-write-close-fork,
there needs to be another thread that forks concurrently with the write.

Alexander

