Return-Path: <linux-fsdevel+bounces-41486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC187A2FD31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 23:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F693A85D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 22:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687A0253F32;
	Mon, 10 Feb 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4dPDgDB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930A9253345
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739226898; cv=none; b=YDzpm6YGYS4c9fLg5iDjoSrdheCyFxZJ3NpRqkYm7mgLZurEKn6R3bcwRD8v1tAIo1s2TUNmaElEG80/KGhZzvAoQF93OJLECXcqQsBAVgsh6IMMlRvPE+hQAZxzzV0B2SvEfpR6SdJ91Ps2q3F31ojzxsNsdozsBcqvyaEK/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739226898; c=relaxed/simple;
	bh=2fCX5PStn6c4pFlbyyYdlv5KgQBVPS/Qr6PpU3fb0rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyY0yThN3KiuMV/FQRGiefTT8HZvESOBBwgcJkzK3FOuWXl0MhNrLSxBpxR8YEDqr4WIIglS2zssvXgl270VwxKCDgDyZYZKJW5D0alPrbPAbEovFA2TqAXwBbsVX8KDEdHHlEKg5HNdEjyuYQeyjbOaqeQJ5lZnW8mIj0rdWCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4dPDgDB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739226895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5r8B8FRtWj5F/lOwyJCGOrGALFwc+xhMPApnCgm2s8=;
	b=P4dPDgDBGmCLsSLFH1quKZ70DZuiMuOcnZ5oFWu6Ap+y8F0a403RrqcHr/7oaRvgqX/znU
	BYw5DRNPRExMFnMNJSp8xof5B+ix5JaEVGegh2T/Yu8VO7VONZ1Zp1nly3+3VHOJALrHmW
	hIV2PI3N04o2J8e6NenqdvsTSxF7N8I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-kew8mM_LO_ugytJEgig5uw-1; Mon,
 10 Feb 2025 17:34:50 -0500
X-MC-Unique: kew8mM_LO_ugytJEgig5uw-1
X-Mimecast-MFC-AGG-ID: kew8mM_LO_ugytJEgig5uw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B81111800264;
	Mon, 10 Feb 2025 22:34:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEF0D30001AB;
	Mon, 10 Feb 2025 22:34:45 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 51AMYifL838184
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 17:34:44 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 51AMYg0l838182;
	Mon, 10 Feb 2025 17:34:42 -0500
Date: Mon, 10 Feb 2025 17:34:42 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu,
        djwong@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v2 4/8] dm: add BLK_FEAT_WRITE_ZEROES_UNMAP support
Message-ID: <Z6p_AsZy41XMCEh5@redhat.com>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
 <20250115114637.2705887-5-yi.zhang@huaweicloud.com>
 <Z6aFtJzGWMNhILJW@redhat.com>
 <3b1dcd45-efa6-4aad-9cd4-3302a29eb093@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b1dcd45-efa6-4aad-9cd4-3302a29eb093@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Feb 08, 2025 at 11:12:57AM +0800, Zhang Yi wrote:
> On 2025/2/8 6:14, Benjamin Marzinski wrote:
> > On Wed, Jan 15, 2025 at 07:46:33PM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Set the BLK_FEAT_WRITE_ZEROES_UNMAP feature on stacking queue limits by
> >> default. This feature shall be disabled if any underlying device does
> >> not support it.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >>  drivers/md/dm-table.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> >> index bd8b796ae683..58cce31bcc1e 100644
> >> --- a/drivers/md/dm-table.c
> >> +++ b/drivers/md/dm-table.c
> >> @@ -598,7 +598,8 @@ int dm_split_args(int *argc, char ***argvp, char *input)
> >>  static void dm_set_stacking_limits(struct queue_limits *limits)
> >>  {
> >>  	blk_set_stacking_limits(limits);
> >> -	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
> >> +	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL |
> >> +			    BLK_FEAT_WRITE_ZEROES_UNMAP;
> >>  }
> >>  
> > 
> > dm_table_set_restrictions() can set limits->max_write_zeroes_sectors to
> > 0, and it's called after dm_calculate_queue_limits(), which calls
> > blk_stack_limits(). Just to avoid having the BLK_FEAT_WRITE_ZEROES_UNMAP
> > still set while a device's max_write_zeroes_sectors is 0, it seems like
> > you would want to clear it as well if dm_table_set_restrictions() sets
> > limits->max_write_zeroes_sectors to 0.
> > 
> 
> Hi, Ben!
> 
> Yeah, right. Thanks for pointing this out, and I also checked other
> instances in dm where max_write_zeroes_sectors is set to 0, and it seems
> we should also clear BLK_FEAT_WRITE_ZEROES_UNMAP in
> disable_write_zeroes() as well.

Yep. Makes sense.

Thanks
-Ben

> 
> Thanks,
> Yi.


