Return-Path: <linux-fsdevel+bounces-57571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B50B2394C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBAB584C39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A539C2FE594;
	Tue, 12 Aug 2025 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMEMalru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0808274420;
	Tue, 12 Aug 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028343; cv=none; b=F9cYp7xv81u5aQyHocu99xPVWuGSjbU+ef+ktVr7qjDNTKQ/tiBJlF801GubUpZpXjtnUPtW1WWDXIH2qBd2Om/TZzBxou9UUIpLfaSplDpUkzYqOxtByfdzLaKMmGnoNeKsW/I52LI2Kq7I+Sp/7GNCn9gdWMl14KMHIJ0XBu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028343; c=relaxed/simple;
	bh=EWG5kAL/Ns/8hOr1OySYjFtWDg18A78ZP5BXzP7VvO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8QiAwqGYV3JHHgDEItYEWY1LCIycHGEkMLlO6RUhkuIfV7WC5zSk9Rewez9ckEUEDwvxigmn0Qq4JGqAEnT1v733O7qCTKFoq4jW0lNt+5U2yhUDHM49IqarmOW/v9xzKKdEOhoaUZjkYPx9GmEUNdyL+yJMnds4BsAOKRwUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMEMalru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A748C4CEF0;
	Tue, 12 Aug 2025 19:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755028342;
	bh=EWG5kAL/Ns/8hOr1OySYjFtWDg18A78ZP5BXzP7VvO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMEMalruz0fBGUDsTe5fSqjlX7I48DWPERT1R6ba/W2X0fqhj0G5XuE7aXt4SNSMS
	 H8mIbw+5JIP9hQjYT6KZZ1Y027/Pe0CkqmsHt0flMHaalKQyqZ/b48CVMp+UjFjV2W
	 8NMIPU61zIDSCSInhterr0Uc9zUQH+MXBhlBxegErTv8p033WePHuQHmGDb+rH9MhY
	 EaEYSr2ZWlFWOZshqrM165pC1u6vND/tukpZY3a2aKk7H141AEr0GXKcwqA/u3wEl6
	 B07Nq0qGvmqcXHvGqjrUefhvpxwU3DjwyfO4Nx5VktUXc+GT53jXePtEbKWEykZ0zK
	 /DoaCjr+zIT+w==
Date: Tue, 12 Aug 2025 09:52:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	david@fromorbit.com, djwong@kernel.org, ebiggers@kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 04/29] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <aJubdUBFAFnxe7C_@slm.duckdns.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-4-9e5443af0e34@kernel.org>
 <20250811114519.GA8969@lst.de>
 <aJotnxPj_OXkrc42@slm.duckdns.org>
 <20250812074350.GC18413@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812074350.GC18413@lst.de>

Hello,

On Tue, Aug 12, 2025 at 09:43:50AM +0200, Christoph Hellwig wrote:
...
> Andrey (or others involved with previous versions):  is interference
> with the log completion workqueue what you ran into?
> 
> Tejun, are you going to prepare a patch to fix the rescuer priority?

NVM, I was confused. All rescuers, regardless of the associated workqueue,
set their nice level to MIN_NICE. IIRC, the rationale was that by the time
rescuer triggers the queued work items already have experienced noticeable
latencies and that rescuer invocations would be pretty rare. I'd be
surprised if rescuer behavior is showing up as easily observable
interferences in most cases. The system should already be thrashing quite a
bit for rescuers to be active and whatever noise rescuer behavior might
cause should usually be drowned by other things.

Thanks.

-- 
tejun

