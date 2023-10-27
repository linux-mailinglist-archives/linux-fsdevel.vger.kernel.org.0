Return-Path: <linux-fsdevel+bounces-1318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE077D8F9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 09:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15E4B21364
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 07:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27439BA2B;
	Fri, 27 Oct 2023 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D49B659
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 07:21:26 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3852F1BB
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 00:21:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C821767373; Fri, 27 Oct 2023 09:21:21 +0200 (CEST)
Date: Fri, 27 Oct 2023 09:21:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 4/6] bdev: simplify waiting for concurrent claimers
Message-ID: <20231027072121.GA11134@lst.de>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org> <20231024-vfs-super-rework-v1-4-37a8aa697148@kernel.org> <20231025155439.5otniolu5mydjoon@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025155439.5otniolu5mydjoon@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 25, 2023 at 05:54:39PM +0200, Jan Kara wrote:
> This test implicitely assumes that 0 is BD_CLAIM_DEFAULT. I guess that's
> fine although I somewhat prefer explicit value test like:
>
> 	if (whole->bd_claim != BD_CLAIM_DEFAULT)

I find the BD_CLAIM_DEFAULT confusing to be honest.  I'd expect null
to just be check as:

 	if (whole->bd_claim)

That being said, instead of doing all the manual atomic magic, why
not add an

	unsigned long		bd_state;

to struct block_device instead of bd_claim, then define a single
bit for a device being clamed and simply everything while also
giving us space for more bits if we ever need them?

