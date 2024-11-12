Return-Path: <linux-fsdevel+bounces-34483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B109C60F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04EDDB680BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9875206E7F;
	Tue, 12 Nov 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpWo38hC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC920651E
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429497; cv=none; b=Zz04SRNMW7hvBM6gKTuiHaEkri8JQurzy31M3uq/CQlGakPJE47+dG5f7+Vgwgwi4tFsDuEyjpYamr7XzfTlxKKzK8kNf4Rjcv2T3XC8afIwK/SUuQhts0McMggcko4zitEbyhFwJiXKyd0GLy8XiJZq/WdUt8+X+HFC7XylMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429497; c=relaxed/simple;
	bh=C6t37ZWzJ1PTsG088vbFrL23viz4/3RJrYbMt85bpp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR1J97B/kNXgKSMWEKGF048n9VwrN/Y6Wzs8Rmicryrjx6hZlmLV2zg8MCJOE1x76iLL/IrTKQePyJjR6t+S0xnG8FFy2oTpM0f4Hw+pN6H0I9faYM6x29m/O0rL7jETNk52vgQvwdMd4t7FjUme5frMp4UdHD789GET/GIicvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpWo38hC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731429494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBEamZbjXMqh8LYkIi+wp0uylZlZEO5P3Ysc8nav4wo=;
	b=hpWo38hCM5DNcVKZ1H8nhjhe1RthRToOUsQE/Jx29IveZYrtQTxsR5fLc2FVvm4uzGfiM2
	XM1eUeMvTbn2zwAFABu+uFMxS1VYvkkCTcVIHqSXs3l7JyPeRjBdIU+p/GL151ZF6Ql3dq
	G+PgkycXDJY+kdwui8cDgjGT/R2qNj4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-iz8JA2gkPaqnHlgTCguJOg-1; Tue,
 12 Nov 2024 11:38:13 -0500
X-MC-Unique: iz8JA2gkPaqnHlgTCguJOg-1
X-Mimecast-MFC-AGG-ID: iz8JA2gkPaqnHlgTCguJOg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2A11195395A;
	Tue, 12 Nov 2024 16:38:10 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0FBC30000DF;
	Tue, 12 Nov 2024 16:38:08 +0000 (UTC)
Date: Tue, 12 Nov 2024 11:39:41 -0500
From: Brian Foster <bfoster@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
Message-ID: <ZzOEzX0RddGeMUPc@bfoster>
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
 <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
 <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
 <ZzIfwmGkbHwaSMIn@infradead.org>
 <04fd04b3-c19e-4192-b386-0487ab090417@kernel.dk>
 <31db6462-83d1-48b6-99b9-da38c399c767@kernel.dk>
 <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
 <ZzLkF-oW2epzSEbP@infradead.org>
 <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Nov 12, 2024 at 08:14:28AM -0700, Jens Axboe wrote:
> On 11/11/24 10:13 PM, Christoph Hellwig wrote:
> > On Mon, Nov 11, 2024 at 04:42:25PM -0700, Jens Axboe wrote:
> >> Here's the slightly cleaned up version, this is the one I ran testing
> >> with.
> > 
> > Looks reasonable to me, but you probably get better reviews on the
> > fstests lists.
> 
> I'll send it out once this patchset is a bit closer to integration,
> there's the usual chicken and egg situation with it. For now, it's quite
> handy for my testing, found a few issues with this version. So thanks
> for the suggestion, sure beats writing more of your own test cases :-)
> 

fsx support is probably a good idea as well. It's similar in idea to
fsstress, but bashes the same file with mixed operations and includes
data integrity validation checks as well. It's pretty useful for
uncovering subtle corner case issues or bad interactions..

Brian

> -- 
> Jens Axboe
> 


