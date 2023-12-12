Return-Path: <linux-fsdevel+bounces-5701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8FB80EFF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDF21C20ACE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE0975423;
	Tue, 12 Dec 2023 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNFhhEsr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF4575403
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 15:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2F8C433C7;
	Tue, 12 Dec 2023 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702394435;
	bh=crSGxOfPWwIvuCpNnDeOqff5stZDLNzne/XaAS2bWfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNFhhEsrfYN8XpTIaBwlqf+1S8YlDuNeuuTeP4OswvmV4x6qf2Hlp68nyQRUjIpoV
	 ulz4yFxsvPiet8/GdUD69IihIu3OowC/a1FSMMU3M+UQv+gGkPnY6FqMXVEtQoyvbk
	 9fJpIOCAIfabX8g43+md4xyeJBG5krHnzmq+Jp9cslBAoX1PgTHvgjLr1MGuO3cK7P
	 hLFdV7OIi9HOZf1JfL63/HwD5At7PTK4RpXbTMWafV6kxCAAppV4jA0LQ/s4prONS7
	 rQAhDyI8L2dVQm8cs38XyigCynUeIbtFuHZzvMuUX3fQpHLO8FquT40SzsMpNEZqkp
	 BKWcosL+2Iq+g==
Date: Tue, 12 Dec 2023 16:20:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] splice: return type ssize_t from all helpers
Message-ID: <20231212-autohandel-gebastelt-2e8b9049f70b@brauner>
References: <20231212094440.250945-1-amir73il@gmail.com>
 <20231212094440.250945-2-amir73il@gmail.com>
 <20231212141937.f4ihbex46ndhu3nt@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212141937.f4ihbex46ndhu3nt@quack3>

On Tue, Dec 12, 2023 at 03:19:37PM +0100, Jan Kara wrote:
> On Tue 12-12-23 11:44:36, Amir Goldstein wrote:
> > Not sure why some splice helpers return long, maybe historic reasons.
> > Change them all to return ssize_t to conform to the splice methods and
> > to the rest of the helpers.
> > 
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Link: https://lore.kernel.org/r/20231208-horchen-helium-d3ec1535ede5@brauner/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> 
> Looks good to me. Just one nit below. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> > diff --git a/fs/splice.c b/fs/splice.c
> > index 7cda013e5a1e..13030ce192d9 100644
> > --- a/fs/splice.c
> > +++ b/fs/splice.c
> > @@ -201,7 +201,7 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
> >  	unsigned int tail = pipe->tail;
> >  	unsigned int head = pipe->head;
> >  	unsigned int mask = pipe->ring_size - 1;
> > -	int ret = 0, page_nr = 0;
> > +	ssize_t ret = 0, page_nr = 0;
> 
> A nit but page_nr should stay to be 'int'.

Fixed in-tree.

