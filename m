Return-Path: <linux-fsdevel+bounces-59343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494A1B37B66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 09:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FBE36710B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 07:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7744C1E8342;
	Wed, 27 Aug 2025 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="cjUH6w95"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE603164B5;
	Wed, 27 Aug 2025 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279342; cv=none; b=X1ZehebEzwyw3BOHTGiCfs9P/Pi8ajt3PvKTZTo8VRN5hIh1YnynGyFIQCXfDxfCr3vDMv/GUJMuqwFo7iYdCBY7As2m+Qgp2YZEF1DErP3Kuv7Ag9eWpG4qRrjSBAbcZ8opPrTsgegofm/SI9H6X3SeqCkDKwKYJqbF9eHAovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279342; c=relaxed/simple;
	bh=5XWS7XyCw+NJDczou25GCvSbDPiWfkEbfUlH2AruYok=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q26lSbxPDQe1gnc1Eqe3v5OVTiuO4o3f1at0Esn5nEJguzhtYpSLD28n5r1uh4+BMqEmXfIAxpgzz5jKLvp/jYygpTwC0Ux8ySVzsrslMt62n3TNBB/sZuVRppk411k+X602mIx7oa/huFzbZGEqjh1MnHmsUs6CeKoN45Yvl2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=cjUH6w95; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5637D406B8A5;
	Wed, 27 Aug 2025 07:22:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5637D406B8A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756279334;
	bh=0h56dmYpXFNvXHv2vka/Yl8VSMF1DnH9PsEa/ZEq58I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=cjUH6w95ke+Qj4M3fskURmO7vCqRHo68Ynm+jMhX4XDg5un+thblBAQsAe7fPxo+7
	 3O/nyeoWciWjPIvWFF+FD6mz58nTPWOLR5eZDUdmgvEG3ZNSXiKfWKmzZC8oCU7YHY
	 dwaShfMDJnXU+zuNtvxAtJs4+4K800+PgaiOovVo=
Date: Wed, 27 Aug 2025 10:22:14 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Al Viro <viro@zeniv.linux.org.uk>
cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
    Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
In-Reply-To: <20250826220033.GW39973@ZenIV>
Message-ID: <0a372029-9a31-54c3-4d8a-8a9597361955@ispras.ru>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru> <20250826220033.GW39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Tue, 26 Aug 2025, Al Viro wrote:

> Egads...  Let me get it straight - you have a bunch of threads sharing descriptor
> tables and some of them are forking (or cloning without shared descriptor tables)
> while that is going on?

I suppose if they could start a new process in a more straightforward manner,
they would. But you cannot start a new process without fork. Anyway, I'm but
a messenger here: the problem has been hit by various people in the Go community
(and by Go team itself, at least twice). Here I'm asking about a potential
shortcoming in __fput that exacerbates the problem.

> Frankly, in such situation I would spawn a thread for that, did unshare(CLONE_FILES)
> in it, replaced the binary and buggered off, with parent waiting for it to complete.

Good to know, but it doesn't sound very efficient (and like something that could be
integrated in Go runtime).

Anyhow, if the alleged race window in __fput is real, why not close it for good?

Alexander

