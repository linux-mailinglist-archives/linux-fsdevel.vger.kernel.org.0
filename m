Return-Path: <linux-fsdevel+bounces-39407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A4A13BDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 15:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F6D1881D22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFA222ACEE;
	Thu, 16 Jan 2025 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYd27SWQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF08B1A08BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036753; cv=none; b=KtyeLHCMaMwrjk/qxqvDI0QsNIErmG8JyVvmSJcQPw/nOuMbMJBijX2BRuPqiwDpfWTssiPb181nKPXqHsLlV5oc/gpKCgXvfeLHbyhzPP/4O8y5Au5BP4n8AxN/mAk7439uic44pCmU5fcQGl3Yt9YibwE9FpVBOUOLy305I9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036753; c=relaxed/simple;
	bh=oRtFi8McpCxVVsyZleMs0GMtACqZkHAyjdFnsbDBZQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAsL8eLgrFJd9rGmDipVp+6oD4eRDMRaOaBesxN5sCguOUwIWCQYUA/Cfnu7YuQjajsk4Gh7Z+PZ7GUFmlVhdNAp4GurGwyILGL3/oa7N463jfZvOZuSb5naeG5DHqLrgaM42k56S5/1XPs6b5E778Esl+03mwD8AYAROWTh+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYd27SWQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737036750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbWlw8NVg/axutqw+0j5popL7IrrTmwSvM9kB1WHeaI=;
	b=MYd27SWQUQWo8uaxUnSoHeShe0hikW9dkHGuWQmthcsaV1UA53WNGwZJW3oP68djjXosS4
	44YQjep75RHtBA/6AsCNEvrRbXffd4mTR88AvHF6qddYbaVhIQ/5C8KKII7r/9dDmQE/hb
	1UsP2Xd1/Gwh7lL8lO/DJF6CpNBFgEU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-fwybAtCwNFOwZ8zFI9-9hg-1; Thu,
 16 Jan 2025 09:12:26 -0500
X-MC-Unique: fwybAtCwNFOwZ8zFI9-9hg-1
X-Mimecast-MFC-AGG-ID: fwybAtCwNFOwZ8zFI9-9hg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3683F1910B28;
	Thu, 16 Jan 2025 14:12:17 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.118])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C7341955F10;
	Thu, 16 Jan 2025 14:12:16 +0000 (UTC)
Date: Thu, 16 Jan 2025 09:14:28 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFCv2 2/4] iomap: optional zero range dirty folio
 processing
Message-ID: <Z4kURGvOPFX_yDU-@bfoster>
References: <20241213150528.1003662-1-bfoster@redhat.com>
 <20241213150528.1003662-3-bfoster@redhat.com>
 <Z394x1XyN5F0fd4h@infradead.org>
 <Z4Fejwv9XmNkJEGl@bfoster>
 <Z4SbwEbcp5AlxMIv@infradead.org>
 <Z4UkBfnm5kSdYdv3@bfoster>
 <Z4dL8PzrIN1NuyZF@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4dL8PzrIN1NuyZF@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jan 14, 2025 at 09:47:28PM -0800, Christoph Hellwig wrote:
> On Mon, Jan 13, 2025 at 09:32:37AM -0500, Brian Foster wrote:
> > In turn, this means that extending write zero range would have either
> > physically zeroed delalloc extents or skipped unwritten blocks,
> > depending on the situation. Personally, I don't think it really matters
> > which as there is no real guarantee that "all blocks not previously
> > written to are unwritten," for example, but rather just that "all blocks
> > not written to return zeroes on read."
> 
> Yes.
> 
> > For that reason, I'm _hoping_
> > that we can keep this simple and just deal with some potential spurious
> > zeroing on folios that are already dirty, but I'm open to arguments
> > against that.
> 
> I can't see one.  But we really should fine a way to write all this
> including the arguments for an again down.
> 

Indeed. If the first non-rfc pass ultimately makes this tradeoff, I'll
plan to document the behavior in the code and the reasoning and
tradeoffs in the commit log so it can be reviewed.

Brian


