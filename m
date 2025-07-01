Return-Path: <linux-fsdevel+bounces-53484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E54AEF7BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812164453E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2479927380F;
	Tue,  1 Jul 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXJJcXUr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703602737F2;
	Tue,  1 Jul 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371431; cv=none; b=pOxdYTP8Xtl2hlU5iCfIHgM2MicZk+vBxvPbbFY7hFVRBXyQDR/ELVEAmP5P5FNOwW/jqKNznvpo4E+XZWAqJIUCHmwnEl6feKGGd5DHB2Bq5NHeWIu4pZSWSTp6mdVAtzTgpihbEN9ZbB6DIUBc4NSMYEFNAIYFaL3G2dFhhHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371431; c=relaxed/simple;
	bh=Q7QVc2qsYqqx0YXVW49AwV+9qD+1NySnWlFCXrePDPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1gjjiUSBIW6NZ+890JvOCQEfqRToXjCpRe6+YnTdwCW3ignTo/rNcVGbEFmGMNlxAj9fkf6grNjKnBHClnA3xKJJJf0PR4/MsdNfVZdSfBIKgM2btG86tRKHhYGVnZ1GngFBydPOwq7BZeClD+PUD/oKu3mcc5ioqNeat6in3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXJJcXUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39886C4CEEB;
	Tue,  1 Jul 2025 12:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751371431;
	bh=Q7QVc2qsYqqx0YXVW49AwV+9qD+1NySnWlFCXrePDPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXJJcXUrvHSAIOPY2gI4XfjpcD2WMOoRpuEgtUiwLc9iKiaRf/krf8PhSdchunuJM
	 8u4WdXAy7Y0lAjuaqgCxhvE5mdRI/Z/Bhz6v7ZTq3DO5qFtAmvy+fZ79lilbCEO+zE
	 DyC82eMXBFcVinxD0Bq1Zl/0D6OADwhCc9kl6BmvhVS6tqonauHkLcJAZQRR+nWS24
	 Ig9OwkHGHt3GJVFLkQxDVHQNy9mVlClJS2w92exPJHXe4GW1pms/B2EuiRgOh76FiT
	 /QRyLz/jJ3FHlOtG54Y7wBA1O2+Tk4GI8Qj5vI7iIMD9uJ/MQyeLiWGQXzGig+olW3
	 w7BWS9u7aqa0Q==
From: Christian Brauner <brauner@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Date: Tue,  1 Jul 2025 14:03:38 +0200
Message-ID: <20250701-wochen-bespannt-33e745d23ff6@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527090836.1290532-1-namcao@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=brauner@kernel.org; h=from:subject:message-id; bh=Q7QVc2qsYqqx0YXVW49AwV+9qD+1NySnWlFCXrePDPA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQkn1sQnrzZI0ljcfwpHbZEDYcZy5wUhU6vDzAqev/T+ FMGi4RqRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERefGT47+I7r6lfRrx4SZPC gr1nvyx/+ETLa9GU1lkpywpdORRPzmFk2P41wiBiwnsBnxR1dl8pydePEwQ5opmTf1rcsdl8aU4 PCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 27 May 2025 11:08:36 +0200, Nam Cao wrote:
> The ready event list of an epoll object is protected by read-write
> semaphore:
> 
>   - The consumer (waiter) acquires the write lock and takes items.
>   - the producer (waker) takes the read lock and adds items.
> 
> The point of this design is enabling epoll to scale well with large number
> of producers, as multiple producers can hold the read lock at the same
> time.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] eventpoll: Fix priority inversion problem
      https://git.kernel.org/vfs/vfs/c/e73f3008405b

