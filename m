Return-Path: <linux-fsdevel+bounces-3940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C8C7FA390
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 15:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DCA281898
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D32F2F86C;
	Mon, 27 Nov 2023 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IauQcCo6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9661096F
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 14:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3650C433C8;
	Mon, 27 Nov 2023 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701096779;
	bh=bGYTanczWXx/r+Bdq32pD197H7cZS3+iIcGUV1W9fLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IauQcCo6enmfhA5RUNyx+wv3bXbyHuFbfZ24DxSewQJtnr3qWP5ZQzHzwbMj1qyir
	 udyxFwcQH7RgJuXiYWjf1qezOjoiHRZW+/J8w5UJeK7CtVHcQ8EZxM+5ht0o/kInUE
	 e7AyIV5uKSk8iElOX37akvc0rpiwyUk9qJwxiSgPoO+IYvsF9Lhh0CwiypY/1xwhq3
	 qaWW4gdNBgNy82A+b3OAk+rKbuXjpJvDNAc7IairQGdcHDG+LeROxs0BlkN2f7QNxj
	 c0u9W1wWm5TsZa31oT9AaRVZ5+1KLD6Cbh4Z7CX+gvXYt5r0U56DJ8yknqJXS/5Ge3
	 YnI2l1OQQjMlQ==
Date: Mon, 27 Nov 2023 15:52:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] super: massage wait event mechanism
Message-ID: <20231127-hievt-gespuckt-3db6f8bffb5c@brauner>
References: <20231127-vfs-super-massage-wait-v1-0-9ab277bfd01a@kernel.org>
 <20231127-vfs-super-massage-wait-v1-1-9ab277bfd01a@kernel.org>
 <20231127135900.GA24437@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127135900.GA24437@lst.de>

On Mon, Nov 27, 2023 at 02:59:00PM +0100, Christoph Hellwig wrote:
> Can you explain why you're "massaging" things here?

Ah, I didn't update my commit message before sending out:

"We're currently using two separate helpers wait_born() and wait_dead()
when we can just all do it in a single helper super_load_flags(). We're
also acquiring the lock before we check whether this superblock is even
a viable candidate. If it's already dying we don't even need to bother
with the lock."

Is that alright?

