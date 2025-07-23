Return-Path: <linux-fsdevel+bounces-55789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A78B0EDC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6553960ABA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 08:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCB8281529;
	Wed, 23 Jul 2025 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSxTc6SO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BB2701CE;
	Wed, 23 Jul 2025 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260938; cv=none; b=eTNHYcoGOh+SB2xHHipR4em5p8SpWUe12U0cURYoIK/tI0h61qm4uNuPORfsU7up5BeMC7pVrg3oEQGUzuby5AJ3XhAI3QKSt/+GvpiE9U77wL0X5TPLPr11t3cSkBlMivYrWeDWVhosGMZu2r19mqhG7mswtMLUB9NotgtIvpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260938; c=relaxed/simple;
	bh=3dsax6R5mUoneMC5L47DERJELj3Kjlt70pXlrr8qEoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6sLME4ZChnFhleNCzr5WutpVU9X8D89YzoqvSQ1dS++aUp2o1fWHf+KdXmzDvweYFNX6isFhmScjciuoUXSGRzS6KvMbt3wqEXU/vz9UcwZ6kkpVbQTTIAVmWINgMSFkLm543hNuBdWQHZbXw834J/dfgl+LY6qL5FWqG2hHU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSxTc6SO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C31C4CEE7;
	Wed, 23 Jul 2025 08:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753260936;
	bh=3dsax6R5mUoneMC5L47DERJELj3Kjlt70pXlrr8qEoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSxTc6SO3ek05IFjX1emSPEfYSo0EkosXv44HJr+nKzW8OGrb0OrBYOiEUGFpsTTZ
	 JIrE0KAOgLJb78zctdK/Gctw486HnJ4J+wPuybQJ2yptXkk/FKlcH2h9O9m9Jog1sW
	 YLldobJsyQKGhmZFIZhLwDSQvV5R9aflpaUKerMnPdXSArN8J6VJBGXd7+WBhOhBlf
	 Dd3WRGYu9XtZvJf/hUPr6Jlk+JDuZYeTCOd5zxvXlWHl+rYRI0GkOAOCELD5EKcL86
	 BVdJUdxI7ZZKKK0cWhZdXXav7DGmZNaPthdBkvJ+0cJhc8oVwIcVPPCLm6SCM1xbwv
	 yT1ViSWyPFUTw==
Date: Wed, 23 Jul 2025 10:55:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	fsverity@lists.linux.dev
Subject: Re: [PATCH v3 09/13] fs/verity: use accessors
Message-ID: <20250723-radar-hetzkampagne-dfe9ddc89a19@brauner>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
 <20250722-work-inode-fscrypt-v3-9-bdc1033420a0@kernel.org>
 <20250722202531.GE111676@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722202531.GE111676@quark>

On Tue, Jul 22, 2025 at 01:25:31PM -0700, Eric Biggers wrote:
> On Tue, Jul 22, 2025 at 09:27:27PM +0200, Christian Brauner wrote:
> >  static inline void fsverity_cleanup_inode(struct inode *inode)
> >  {
> > -	if (inode->i_verity_info)
> > +	if (inode->i_verity_info || inode->i_sb->s_op->i_fsverity)
> >  		__fsverity_cleanup_inode(inode);
> 
> Similarly to fscrypt_put_encryption_info(): I think this should look
> like:
> 
>     if (IS_VERITY(inode))
>             __fsverity_cleanup_inode(inode);
> 
> i_verity_info != NULL implies IS_VERITY(), so that would work and avoid
> adding extra dereferences to non-verity files.
> 
> The converse isn't necessarily true, but that's okay as long as
> __fsverity_cleanup_inode() handles i_verity_info == NULL.

Done.

