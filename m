Return-Path: <linux-fsdevel+bounces-157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B367C6678
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 09:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A70C1C20FEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 07:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43911FC1A;
	Thu, 12 Oct 2023 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXp7F39J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B98101C1;
	Thu, 12 Oct 2023 07:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15A4C433C9;
	Thu, 12 Oct 2023 07:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697096082;
	bh=Xi39sy6oiDYutAM3dpEDKPXI+/aQZHWFGVRwR30E7qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXp7F39JpJgcUyY10FQU5yS6CoKKmZFpzuJFnohQdfyT+JUUVQdxH7btLl/+E9IU5
	 fSkyu7cbb5KxMmVn6vE8HLrNiWncfIkCz7ypHERtuxmpk7ga2MN/BR7J+/TWWk8pWM
	 YC+5bQl21cBdgdYbgOjdXux/+7GMtq+kg0rVZrAfcuIV2aLpr/nl4BNV/UcvcWhm7Y
	 sEXr4XfNQcYU8TjW/XyEf43IvgRZ1YsWDYXBxXV9O74hguu8i/l2dbDHlCdyg01KkG
	 XEzHWK5lvzMKmQQf3qIV9exuwZciDv+a5yUYPOUTOKmGGJi+eF0Mhda/fubineqxMC
	 0df9WddCcNCgA==
Date: Thu, 12 Oct 2023 00:34:40 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 09/28] fsverity: pass log_blocksize to
 end_enable_verity()
Message-ID: <20231012073440.GB2100@sol.localdomain>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-10-aalbersh@redhat.com>
 <20231011031906.GD1185@sol.localdomain>
 <bwwev42i7ahrbdl4kvl7sc27zwrg7btmwf2j5h2grxp25mxxpl@4loq5hqs43gv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bwwev42i7ahrbdl4kvl7sc27zwrg7btmwf2j5h2grxp25mxxpl@4loq5hqs43gv>

On Wed, Oct 11, 2023 at 01:17:36PM +0200, Andrey Albershteyn wrote:
> On 2023-10-10 20:19:06, Eric Biggers wrote:
> > On Fri, Oct 06, 2023 at 08:49:03PM +0200, Andrey Albershteyn wrote:
> > > diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> > > index 252b2668894c..cac012d4c86a 100644
> > > --- a/include/linux/fsverity.h
> > > +++ b/include/linux/fsverity.h
> > > @@ -51,6 +51,7 @@ struct fsverity_operations {
> > >  	 * @desc: the verity descriptor to write, or NULL on failure
> > >  	 * @desc_size: size of verity descriptor, or 0 on failure
> > >  	 * @merkle_tree_size: total bytes the Merkle tree took up
> > > +	 * @log_blocksize: log size of the Merkle tree block
> > >  	 *
> > >  	 * If desc == NULL, then enabling verity failed and the filesystem only
> > >  	 * must do any necessary cleanups.  Else, it must also store the given
> > > @@ -65,7 +66,8 @@ struct fsverity_operations {
> > >  	 * Return: 0 on success, -errno on failure
> > >  	 */
> > >  	int (*end_enable_verity)(struct file *filp, const void *desc,
> > > -				 size_t desc_size, u64 merkle_tree_size);
> > > +				 size_t desc_size, u64 merkle_tree_size,
> > > +				 u8 log_blocksize);
> > 
> > Maybe just pass the block_size itself instead of log2(block_size)?
> 
> XFS will still do `index << log2(block_size)` to get block's offset.
> So, not sure if there's any difference.

It's only used in the following:

	offset = 0;
	for (index = 1; offset < merkle_tree_size; index++) {
		xfs_fsverity_merkle_key_to_disk(&name, offset);
		args.name = (const uint8_t *)&name.merkleoff;
		args.attr_filter = XFS_ATTR_VERITY;
		error = xfs_attr_set(&args);
		offset = index << log_blocksize;
	}

... which can be the following instead:

	for (offset = 0; offset < merkle_tree_size; offset += block_size) {
		xfs_fsverity_merkle_key_to_disk(&name, offset);
		args.name = (const uint8_t *)&name.merkleoff;
		args.attr_filter = XFS_ATTR_VERITY;
		error = xfs_attr_set(&args);
	}

