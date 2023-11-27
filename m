Return-Path: <linux-fsdevel+bounces-3962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 310FE7FA6D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 17:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617A31C20C3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540F5364D0;
	Mon, 27 Nov 2023 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA21AB
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 08:49:01 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B289227A87; Mon, 27 Nov 2023 17:48:57 +0100 (CET)
Date: Mon, 27 Nov 2023 17:48:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] super: don't bother with WARN_ON_ONCE()
Message-ID: <20231127164856.GB2398@lst.de>
References: <20231127-vfs-super-massage-wait-v1-0-9ab277bfd01a@kernel.org> <20231127-vfs-super-massage-wait-v1-2-9ab277bfd01a@kernel.org> <20231127135945.GB24437@lst.de> <20231127-leibgericht-rampen-ce0a28e1c6ba@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-leibgericht-rampen-ce0a28e1c6ba@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 03:53:36PM +0100, Christian Brauner wrote:
> On Mon, Nov 27, 2023 at 02:59:45PM +0100, Christoph Hellwig wrote:
> > This looks ok, but I still find these locking helper so horrible to
> > follow..
> 
> What do you still find objectionable?

Same thing as last time.  The __ helpers that take the share/exclusive
trip me off every single time I have to follow them.   Just open coding
the calls to the rw_semaphore helpers is a lot easier to read in
general, but for anything complex that actually needs an enum with
EXCL and SHARED in it would at least makes it clear what is happening.

