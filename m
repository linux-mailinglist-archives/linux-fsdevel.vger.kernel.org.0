Return-Path: <linux-fsdevel+bounces-54858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2EEB0410A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 16:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C223AC3DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595982566E8;
	Mon, 14 Jul 2025 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThUFJ/6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF72561B6
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502142; cv=none; b=iRzqWox3FfLDeDDy2bXWj4PGOK1SBkJXdVT3HZqMA0xpT1oq3gZSUVX9ciYq1KMUNtGujIqDc61YFs0NkWK10Xd6Aj6zPYqHx07fFV32Kk2+CIQx48kAvpiumELo3s3PXoqMGSG6wvOHhR1cvy8W8l4anLdZmTP5zn4nRlKmZYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502142; c=relaxed/simple;
	bh=qs/Flz2IMa+ZAR5R6PqMSRYJTQ4X6MG+3WlQgvXxVms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0uNlQ56iVlnlx/XKYcH8ysEyPe73LxblpmtmKRclA326+eOeNvt22PQX+ZMI4AZ+ExNEoGNsXEJaYHeERSE2glKZb+KrkyhulV+N69gx3OrnUNQiEb4O+2SebgU+XPbDAtpBeQ4Ymc87UBxaF6vwq2h1Qo41w2o9is6W+zlpWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThUFJ/6O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752502139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OPs78cLbRWCJyfKDridU8XrYJR+Ht/I/0x3d9CFQm8s=;
	b=ThUFJ/6OyVqoJOgGk28tqVrI+Lx7oF5vEogQSW+5UKNbDAO+oFgGLjWgYCT0SJqSqqwX/l
	RP7QVOG8VZw8PtmMRwBpEiIsHKvrQSgIkTaP+FEd/Amevt7BSW9IVarHmwY1UMRdSsMwxO
	oe/jLd0w+voFuh5zwJbnxz2us9xgboc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-jGDTCNUAM7GXvePmG1kKig-1; Mon,
 14 Jul 2025 10:08:55 -0400
X-MC-Unique: jGDTCNUAM7GXvePmG1kKig-1
X-Mimecast-MFC-AGG-ID: jGDTCNUAM7GXvePmG1kKig_1752502134
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A9141809C86;
	Mon, 14 Jul 2025 14:08:53 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.43])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CD28180045B;
	Mon, 14 Jul 2025 14:08:52 +0000 (UTC)
Date: Mon, 14 Jul 2025 10:12:34 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, djwong@kernel.org, willy@infradead.org
Subject: Re: [PATCH v2 7/7] xfs: error tag to force zeroing on debug kernels
Message-ID: <aHUQUguvDUUhrsA0@bfoster>
References: <20250714132059.288129-1-bfoster@redhat.com>
 <20250714132059.288129-8-bfoster@redhat.com>
 <aHUEtVJK6PPepNde@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHUEtVJK6PPepNde@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Jul 14, 2025 at 06:23:01AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 14, 2025 at 09:20:59AM -0400, Brian Foster wrote:
> > -	error = xfs_free_file_space(XFS_I(inode), offset, len, ac);
> > -	if (error)
> > -		return error;
> > +	/* randomly force zeroing to exercise zero range */
> 
> This comment feels very sparse for this somewhat confusing behavior.
> Can you add a shortened version of the commit message here explaining
> why this is useful?
> 

I replaced the comment with:

        /*
         * Zero range implements a full zeroing mechanism but is only used in
         * limited situations. It is more efficient to allocate unwritten
         * extents than to perform zeroing here, so use an errortag to randomly
         * force zeroing on DEBUG kernels for added test coverage.
         */

Unless I hear further comments I'll post an update with this by the end
of the day.

Brian

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 


