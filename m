Return-Path: <linux-fsdevel+bounces-59901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C21FB3ED8D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 19:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15AB97A28E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD52320A04;
	Mon,  1 Sep 2025 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="IKi0cYxI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158E2747B;
	Mon,  1 Sep 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749229; cv=none; b=K94CTdu3ziQdoF0jeZ0md9c83vVKeuTpB34sbiQGc9qTXsU+25XOTDYTeKRB5qW6s/EVN/aYMcnZ3vNh1hq/qL9bXN8Xmvj33KxLYh/6mbecRPNRDOodvQFQnIQS6wskp9jeVenSak6HZ1IKKGEfM3/L6Z53p6szfc2gz9TAC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749229; c=relaxed/simple;
	bh=nyBnqz5zBQXt6AGqTsNoueT98d16sN/bpY0dsX3OgkQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CO4wm7xFA2KlMRo+CjMZ9CNRJTY7NE5qalQ9lteNWgZBIjfJHQw4S5JaTEHYSgJ+5M9mNrcwRoVxUjhmbYATYdGpfPVXYgWhp6J08lThDxrr+BwV1hDOZPsgpLJ41NsSYE/mekV1p9ahkTnPESm/U6728zgj4uoUIT6tZGmR2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=IKi0cYxI; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3CB2E40A3264;
	Mon,  1 Sep 2025 17:53:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3CB2E40A3264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756749225;
	bh=nyBnqz5zBQXt6AGqTsNoueT98d16sN/bpY0dsX3OgkQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IKi0cYxIQI0XgeSpj19N/YOs+aFCz0E1AV3JWv7YLbGuDe3KzGU1EOVb4WqUR8Zve
	 pOy/smZ2Z8c+kSWU+6YoTtx5tjeARTNU7j4q9gnvLM1pGBrMxAG4d/2bMnHINgwIM2
	 Ce1mbvCRrqwZoI9GhB4cOlEqOmFnIwMiwOQrRQSY=
Date: Mon, 1 Sep 2025 20:53:38 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Jan Kara <jack@suse.cz>
cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
    Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
In-Reply-To: <fkq7gvtjqx4jilgu75nbmckmwdndl7d7fzljuycqfzmvumdft2@jiycade6gzgo>
Message-ID: <68c99812-e933-ce93-17c0-3fe3ab01afb8@ispras.ru>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru> <5a4513fe-6eae-9269-c235-c8b0bc1ae05b@ispras.ru> <20250829-diskette-landbrot-aa01bc844435@brauner> <e7110cd2-289a-127e-a8c1-f191e346d38d@ispras.ru> <20250829-therapieren-datteln-13c31741c856@brauner>
 <9d492620-1a58-68c0-2b47-c8b16c99b113@ispras.ru> <fkq7gvtjqx4jilgu75nbmckmwdndl7d7fzljuycqfzmvumdft2@jiycade6gzgo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Fri, 29 Aug 2025, Jan Kara wrote:

> Umount (may_umount_tree()) looks at mnt->mnt_count which is decremented by
> mntput() completely at the end of __fput(). I tend to agree with Christian
> here: We've never promised that all effects of open fd are cleaned up
> before the flock is released and as Christian explained it will be actually
> pretty hard to implement such behavior. So attempts to wait for fd to close
> by waiting for its flock are racy...

(flock is not a Linux invention, if BSD implementations offered that guarantee,
I'd expect Linux to follow, but I'm not sure if they did)

That's unfortunate. If the remount/unmount issues are not convincing, shall we
try to get this issue called out in the Linux man pages? Would you help me with
wordsmithing?

How about adding the following to the NOTES section in flock.2?

Releasing the lock when a file descriptor is closed is not sequenced after all
observable effects of close(). For example, when one process places an exclusive
lock on a file, writes to it, then closes it, and another process waits on a
shared lock for the file to be closed, it may observe that subsequent execve()
fails with ETXTBSY, and umount() of the underlying filesystem fails with EBUSY,
as if the file is still open in the first process.

Alexander

