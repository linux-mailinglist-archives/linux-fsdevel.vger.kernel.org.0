Return-Path: <linux-fsdevel+bounces-40233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E22A20B91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 14:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDA51884F7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3998B1A9B27;
	Tue, 28 Jan 2025 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dm0I/o2w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649E1A727D
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738072283; cv=none; b=lHmTgYGFINZWb1apvW0Nm7ET1M0KxCzdtdyMiSzeK/EaQvor+1bqivwJE8Crbg8aEWA3/h23qfWqT6XcGF+4Yxlk5UzQX4dzDaAQ6qYzNXF8LiT6DjRZ+RRfyXL+k93BudypQWN84gb90pwdXTJVhyI6OWPBxffKqcXEr4azUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738072283; c=relaxed/simple;
	bh=vw828RggbuYhwBbU6+9jsIiVYeyisFWDpJcDtu/jafA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stmNVI5Hs/gitalbWVJv4LYqgPkqZy3JxhaBvyvfmSZniW/P+o2C2TcaFkrkzyyn3Q7CywCarWsfTvenszyDl0hEAxQg7COVWGlCH0yDPnsbIRS/r4A5wDf13oeNyVV/VXgQfu2iergSbwR1smG0JjS2ZyBGswqCFXngIcMhRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dm0I/o2w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738072281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tZF4Y/avTtyZDef7prmha6ZoVMCHtxOCxkR/7Ls/Ows=;
	b=Dm0I/o2wyrzvAiRkTximHjvFp/ltnLAqRNjkp2RnCYbMQ8aXEfIE3qQVYrsNLhJx2I8LMS
	XpV5h9rRbbU5tSQIMNDMj757z+MaejGsAB9doNtHciy6m4CFGzUGAJ2tN0IAma+gS9wySd
	nKsQhcDcYpuDOKDj9g2UQKiuRjhFILo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-552KfdE-MoKbHIA7VsIpJQ-1; Tue,
 28 Jan 2025 08:51:17 -0500
X-MC-Unique: 552KfdE-MoKbHIA7VsIpJQ-1
X-Mimecast-MFC-AGG-ID: 552KfdE-MoKbHIA7VsIpJQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 210921801F1E;
	Tue, 28 Jan 2025 13:51:16 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.118])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C024195608E;
	Tue, 28 Jan 2025 13:51:15 +0000 (UTC)
Date: Tue, 28 Jan 2025 08:53:27 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/7] iomap: factor out iomap length helper
Message-ID: <Z5jhV7kuuCvNr9lN@bfoster>
References: <20250122133434.535192-1-bfoster@redhat.com>
 <20250122133434.535192-3-bfoster@redhat.com>
 <Z5hqd31L6Ww6TT_a@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5hqd31L6Ww6TT_a@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jan 27, 2025 at 09:26:15PM -0800, Christoph Hellwig wrote:
> > +static inline u64 iomap_length_trim(const struct iomap_iter *iter, loff_t pos,
> > +		u64 len)
> > +{
> > +	u64 end = iter->iomap.offset + iter->iomap.length;
> > +
> > +	if (iter->srcmap.type != IOMAP_HOLE)
> > +		end = min(end, iter->srcmap.offset + iter->srcmap.length);
> > +	return min(len, end - pos);
> 
> Does this helper warrant a kerneldoc comment similar to iomap_length?
> 

Can't hurt I suppose. I'll add one.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks.

Brian


