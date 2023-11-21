Return-Path: <linux-fsdevel+bounces-3320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFA17F32A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 16:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE3EB21EAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 15:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEBF58125;
	Tue, 21 Nov 2023 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0wcJgRh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B20156760
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 15:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29215C433C8;
	Tue, 21 Nov 2023 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700581649;
	bh=IWOFKmWJrH2ABNRyaEtqxJlBTxkv3OL7NCDr4gb6vNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0wcJgRhbYVbuQodFDbm7nEjo/8fBQYBPx9jiHtgaYiSur93u1I/v+6qppMxAksyW
	 r8ttr6Yr2/rvQtefOkBVM7MBntBKeBWAFhpDxcArQUWWyYCiPIgNJhttuchdbb2FrV
	 Cza0relOjH06+yJEJ6CMoTstsYgurr6p9MtlUHE4N4hy1j5XuOzpDWQb4EBb003ULX
	 yhs91YbtpTn7CYZkXzYblGl1zPNyz+N0Cavr5RdvRe7agtZ2nwCqDaAWqjNLEAAGCn
	 5zwxY55wb68U+IZJnTAsGlfO48L2voxwwrJ87f1eCIbhVBFYf6tcfFIAq6J4ytSp/s
	 CtPBJ45V5NrgA==
Date: Tue, 21 Nov 2023 16:47:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/15] remap_range: move file_start_write() to after
 permission hook
Message-ID: <20231121-traufe-farmen-977689b1e790@brauner>
References: <20231114153321.1716028-1-amir73il@gmail.com>
 <20231114153321.1716028-8-amir73il@gmail.com>
 <20231121-datum-computer-93e188fe5469@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231121-datum-computer-93e188fe5469@brauner>

> the mount can still change. Once you've gotten write access though we
> tell the anyone trying to change the mount's write-relevant properties
> to go away.

I should also clarify that this is unlikely to matter in practice. It's
more about correctness. You have to be in a very specific scenario for
that to even be a relevant concern.

