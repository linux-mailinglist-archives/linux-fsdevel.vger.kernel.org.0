Return-Path: <linux-fsdevel+bounces-5566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CFA80DAA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 20:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8B01F218E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 19:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91521524D1;
	Mon, 11 Dec 2023 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Jks55oU7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB17BD;
	Mon, 11 Dec 2023 11:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/Rtkzcsv8kzgc8T4PwLaUwempDK+53xq2O37eAIju6o=; b=Jks55oU7rWGh8Gjb3z9pm/ASZV
	splnAzk8Kuua7BffcEhEnk1XNim2qW0j/aVpBCtraGU1+XKNhizBpMcqNWeTn/Akv+rRO0aILl3fV
	jqkaBuffi3yv4Xe27LgcVPgofKyt0Pl8g7ztVmt1AJ2BJa7mKz0HsMWb4XRVZItxQIHvJvCcB5nge
	qMqx6XP2dL5d8X8scShWKyAucys69reFq7/J7AU+2r5vrcoWWxzL4LrdOF/P1l43Gux8eHuEQMEmh
	04BjRqlSyevf9neK5+yeJckBIMUAODRpq52kHQKjicaKU8fx9bTgiEQq23zfz4Q+6J5/ucGEW1Lvh
	6/phlXkA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rClgT-00AzWG-0e;
	Mon, 11 Dec 2023 19:11:17 +0000
Date: Mon, 11 Dec 2023 19:11:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Message-ID: <20231211191117.GD1674809@ZenIV>
References: <20231208033006.5546-1-neilb@suse.de>
 <20231208033006.5546-2-neilb@suse.de>
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170224845504.12910.16483736613606611138@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 11, 2023 at 09:47:35AM +1100, NeilBrown wrote:

> Similarly would could wrap __fput_sync() is a more friendly name, but
> that would be better if we actually renamed the function.
> 
>   void fput_now(struct file *f)
>   {
>       __fput_sync(f);
>   }

It is unfriendly *precisely* because it should not be used without
a very good reason.

It may be the last opened file keeping a lazy-umounted mount alive.
It may be taking pretty much any locks, or eating a lot of stack
space.

It really isn't a general-purpose API; any "more friendly name"
is going to be NAKed for that reason alone.

Al, very much tempted to send a patch renaming that sucker to
__fput_dont_use_that_unless_you_really_know_what_you_are_doing().

