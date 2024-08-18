Return-Path: <linux-fsdevel+bounces-26210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A2955D83
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 18:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308EA1F213E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6C01494A9;
	Sun, 18 Aug 2024 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Ud62Q1Hf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CD033C0;
	Sun, 18 Aug 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723999903; cv=none; b=SwCXf71QDvw3BL+wzi55qbkWI1UQm8D7shDEtZ5MNaMuKx951P5YwoQw9+20Xe/2602/dnU61arHzW8Han/wDvCf3JSTwV+G5P2PxhUxNW0gL1rak8sJFffq7XIprHOZxkgyphab7o46Pa5CNqHfS8ycylCwzTQ4kgdMW0c+I7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723999903; c=relaxed/simple;
	bh=7Bl4BOOfFoy8ViYYyTwQiPRdGuQa4IPF5ww1bxZG9Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck3Gwj5SwpwXCMAENECuH0vxPwshCH1Ypbj5hfBnx9WfhNF9dMVcA+8M4US/zKUkKr2CvC2odkU/wl/2U39Nw6n3Wm3sthMsiJa43AwSmjs5kHGdQ3fNCdkTEY9JsjE2O5E2SIeSKPV9zUwL6PnAS4RaWH3cXtUN5UNYMPXlvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Ud62Q1Hf; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Wn1w34sYfz9t0Z;
	Sun, 18 Aug 2024 18:51:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1723999891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iJtQXoqkg1Ql6i6lKlrT5656z34Z7stPQ3wfnhFxFrY=;
	b=Ud62Q1Hfxg0cQlxfaNFcOxaYdhJdHuFYjTbZThaJO7BH6N34wLvYzV1t2F9cgp7qTGc5b9
	1tYxvKOWEUfVZhi0sEt0KhPoLlHNEKCDzrbi9Lh5Wu6oNjjFkZgxL+I+OnqGs3Z8TUtG/4
	9CLOKRqENEqOk0JHVgt3fHU0MKmIzHBBznCYQanLnJYHdsY/rvlJPK7zGwFHmTYaQXuFma
	JoH3+6+mjRnaWR8Wqxvle1g4Zk1CMc63QtHctV/ZT9UMkfTmzAZshJxpYSV+Ue94TglLNH
	MqDVU0fVn3ILLYw2LrnWJi2i08G+AxL+/BnZfGz7jud1NlY/VKvBdYWhctTsWg==
Date: Sun, 18 Aug 2024 16:51:24 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Howells <dhowells@redhat.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
	david@fromorbit.com, Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, john.g.garry@oracle.com,
	cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v12 00/10] enable bs > ps in XFS
Message-ID: <20240818165124.7jrop5sgtv5pjd3g@quentin>
References: <20240815090849.972355-1-kernel@pankajraghav.com>
 <2924797.1723836663@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2924797.1723836663@warthog.procyon.org.uk>
X-Rspamd-Queue-Id: 4Wn1w34sYfz9t0Z

Hi David,

On Fri, Aug 16, 2024 at 08:31:03PM +0100, David Howells wrote:
> Hi Pankaj,
> 
> I applied the first five patches and set minimum folio size for afs files to
> 8K (see attached patch) and ran some tests.
> 
> With simple tests, I can see in the trace log that it is definitely creating
> 8K folios where it would previously create 4K folios.
> 
> However, with 'xfstests -g quick', generic/075 generic/112 generic/393 fail
> where they didn't previously.  I won't be able to look into this more till
> Monday.

Thanks for trying it out!

As you might have seen the whole patchset, typically filesystems will
require some changes to support min order correctly. That is why 
this patchset only enables XFS to use min order to support bs > ps.

In the case of XFS (block-based FS), we set the min order to the FS
block size as that is the smallest unit of operation in the data path,
and we know for sure there are no implicit PAGE_SIZE assumption.

I am no expert in network filesystems but are you sure there are no
PAGE_SIZE assumption when manipulating folios from the page cache in
AFS?

Similar to AFS, XFS also supported large_folios but we found some bugs
when we set min order to be the block size of the FS.
> 
> If you want to try using afs for yourself, install the kafs-client package
> (available on Fedora and Debian), do 'systemctl start afs.mount' and then you
> can, say, do:
> 
> 	ls /afs/openafs.org/www/docs.openafs.org/
> 
> and browse the publicly accessible files under there.

Great. But is this enough to run FStests? I assume I also need some afs
server to run the fstests?

Are the tests just failing or are you getting some kernel panic?

> 
> David
> ---
> commit d676df787baee3b710b9f0d284b21518473feb3c
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Aug 16 19:54:25 2024 +0100
> 
>     afs: [DEBUGGING] Set min folio order
> 
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 3acf5e050072..c3842cba92e7 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -104,6 +104,7 @@ static int afs_inode_init_from_status(struct afs_operation *op,
>  		inode->i_fop	= &afs_file_operations;
>  		inode->i_mapping->a_ops	= &afs_file_aops;
>  		mapping_set_large_folios(inode->i_mapping);
> +		mapping_set_folio_min_order(inode->i_mapping, 1);
>  		break;
>  	case AFS_FTYPE_DIR:
>  		inode->i_mode	= S_IFDIR |  (status->mode & S_IALLUGO);
> 

