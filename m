Return-Path: <linux-fsdevel+bounces-1306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 970CA7D8EBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33EB1C20F95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 06:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7239474;
	Fri, 27 Oct 2023 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D548F61
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:30:16 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DEE10D1
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 23:29:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A09467373; Fri, 27 Oct 2023 08:29:50 +0200 (CEST)
Date: Fri, 27 Oct 2023 08:29:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] bdev: implement freeze and thaw holder
 operations
Message-ID: <20231027062949.GC9109@lst.de>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org> <20231024-vfs-super-freeze-v2-5-599c19f4faac@kernel.org> <20231025140105.rovejlelqifwbuqj@quack3> <20231026-ungewiss-sinken-ea11cd5002da@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-ungewiss-sinken-ea11cd5002da@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 26, 2023 at 10:44:27AM +0200, Christian Brauner wrote:
>   */
>  int bdev_freeze(struct block_device *bdev)
>  {
>  	int error = 0;
>  
>  	mutex_lock(&bdev->bd_fsfreeze_mutex);
>  
> +	if (atomic_inc_return(&bdev->bd_fsfreeze_count) > 1) {
> +		mutex_unlock(&bdev->bd_fsfreeze_mutex);
> +		return 0;

Use a goto out_unlock here to share the lock release with the
main flow?

>  	/*
> +	 * If the superblock wasn't already SB_DYING then we hold
> +	 * s_umount and can safely drop our temporary reference.
> +         */

Spaces instead of tabs here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

