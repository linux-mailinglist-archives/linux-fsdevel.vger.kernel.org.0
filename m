Return-Path: <linux-fsdevel+bounces-596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43BA7CD7DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 11:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC842811F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC10C182BB;
	Wed, 18 Oct 2023 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trMNMDJ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7EE18051
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 09:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FE7C433C9;
	Wed, 18 Oct 2023 09:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697621075;
	bh=NhuPB8WoDr3nFTdxtomSvCNDDuxNLeX3GORUDiRLFN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=trMNMDJ18oYau9v2zE3uj+bdy2I0anLGR83+A8p3TephJeDKXpgkATXkfTy+JOQ8O
	 nr+xoPnHzofMtKbGgeK1w9RiMfsbVnaNFNgBjKiA8mft3r+Bo/f5uCFfpv3Gxm4y8m
	 LgPynOP2VVUh/aoK7UfZhPNqeTWSkVi/0h8Xe3Ggtwe57z9h/QtxpY2KMyxL+K7VIT
	 xm9WCDRyOqXG6ygQPhUYnBkkO0JRyjk0I6pOBbZ9fZaCfz7XgfjV2vfVWnqUvCoMV9
	 ZF51not7uKFei5Y3ZAIYOg+D/eqiDYIC9IOcG9uSvHA5czPWyU1HTOZhfs975pHCvj
	 AfX66DEwBJX8Q==
Date: Wed, 18 Oct 2023 11:24:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move bdev_mark_dead out of
 disk_check_media_change
Message-ID: <20231018-retten-luftkammer-2bae34ff707f@brauner>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-4-hch@lst.de>

On Tue, Oct 17, 2023 at 08:48:21PM +0200, Christoph Hellwig wrote:
> disk_check_media_change is mostly called from ->open where it makes
> little sense to mark the file system on the device as dead, as we
> are just opening it.  So instead of calling bdev_mark_dead from
> disk_check_media_change move it into the few callers that are not
> in an open instance.  This avoid calling into bdev_mark_dead and
> thus taking s_umount with open_mutex held.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

