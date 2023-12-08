Return-Path: <linux-fsdevel+bounces-5359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9859A80AC3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEEB1F211F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75764CB33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjaS20YI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437493B790
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 17:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378E2C433C7;
	Fri,  8 Dec 2023 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702057952;
	bh=Qkhl1LlV2MkBny69hWrJ0A9JMAPeuJK6J1ZTYEAbN/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjaS20YIh0gjyUqb6QzVYkVgQenJp/XxiipD6kFQPKI5GYCLzAeD69MzDbyZnskbC
	 fFWquR7g5CVe4jVVBRq5fGPTbBIvyYsseiZKhk7oubXh+tGcb50VbpOs/vcrxQJHrk
	 6xSMJ8S2wrLqQyIeHuY8WXlAqsUIH0v9JGsqtXknFebSzHA6txMYhl8CmCrlDzinAz
	 BezaUs40c6u5xuYHqzOLz/iuLQNWkeVeerfdpAysy2fJRh9nlVatCuQiPKgiWhhpjL
	 FrJU2+cFTGlAgtz13oTTp0+L71ZIoV+EQU2NysNlBZ6TjQlxh7JIteL4mWx9Ykuvt1
	 tHzHcyH2fdtNA==
Date: Fri, 8 Dec 2023 18:52:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] fsnotify: pass access range in file permission hooks
Message-ID: <20231208-fiskus-gewusel-6ad5b36e917a@brauner>
References: <20231207123825.4011620-1-amir73il@gmail.com>
 <20231207123825.4011620-5-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207123825.4011620-5-amir73il@gmail.com>

On Thu, Dec 07, 2023 at 02:38:25PM +0200, Amir Goldstein wrote:
> In preparation for pre-content permission events with file access range,
> move fsnotify_file_perm() hook out of security_file_permission() and into
> the callers that have the access range information and pass the access
> range to fsnotify_file_perm().

Not pleasant tbh. I really dislike that we have all this extra hook
machinery. In some places we have LSM hook, then IMA, then EVM, then
fsnotify. Luckily there's a push to move IMA and EVM into the LSM hooks
which is at least better and gets rid of some of that stuff. But not too
fond that we're moving fsnotify out of the hooks. But since there's no
obvious way to consolidate fsnotify and that LSM stuff it's ok as far as
I'm concerned.

