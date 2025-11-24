Return-Path: <linux-fsdevel+bounces-69675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0987CC80F35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDE13A2B22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9F230C63C;
	Mon, 24 Nov 2025 14:16:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B912AD0C;
	Mon, 24 Nov 2025 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763993788; cv=none; b=OOZTZjr9Hvw9dNSR5X3EoBXMCxFp8kx1g/sXrCOpuCxSaj+pe7E5YCy+5X+vc+ehBJrML8W0IDryYMe5XQPbBbH7qGHgGEcmrIC98r3f+TaTz7Hha0bANKqMhtsOImGp572Uzm0ANY8wrGhLQ7n+fEHTcimNPj1PYFOF14qOZ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763993788; c=relaxed/simple;
	bh=gpD35ESx9gRHNke9UOuyFBKfd/cSmCuhLxV7sxGCKvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/amoY6gh7qEKTjrysVOHxuRDUwbVAYMb+vZZyJbQHN2lklT9BKQVp+fAjUJUaDMXkq2MInWi3s1KSLlhdAAClIwf8Lm+bM8npvj5MgudAXKjhtkpt/z4Yn0+UEbIuD2jW1/AWyvG6eIcxOY2AYK2dWPCFcMUfvojV37QcezxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0436768B05; Mon, 24 Nov 2025 15:16:21 +0100 (CET)
Date: Mon, 24 Nov 2025 15:16:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/11] fscrypt: pass a byte offset to
 fscrypt_mergeable_bio
Message-ID: <20251124141621.GC14417@lst.de>
References: <20251118062159.2358085-1-hch@lst.de> <20251118062159.2358085-5-hch@lst.de> <20251122181717.GA1626@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122181717.GA1626@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 22, 2025 at 10:17:17AM -0800, Eric Biggers wrote:
> On Tue, Nov 18, 2025 at 07:21:47AM +0100, Christoph Hellwig wrote:
> > diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
> > index 1773dd7ea7cf..aba830e0827d 100644
> > --- a/fs/crypto/inline_crypt.c
> > +++ b/fs/crypto/inline_crypt.c
> > @@ -361,7 +361,7 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_bh);
> >   * fscrypt_mergeable_bio() - test whether data can be added to a bio
> >   * @bio: the bio being built up
> >   * @inode: the inode for the next part of the I/O
> > - * @next_lblk: the next file logical block number in the I/O
> > + * @pos: the next file logical offset (in bytes) in the I/O
> 
> In comments, maybe call it a "file position" instead of "file logical
> offset" to match the variable name?

Doing a quick grep, "file offset" seems to be a bit more than twice
as common as "file position" in the kernel.  Logical offset, even
without file is barely used.  So I think "file offset' might be best
here, but if you prefer "file position" I can switch to that as well.


