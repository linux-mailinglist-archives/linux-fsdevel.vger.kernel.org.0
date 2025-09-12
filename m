Return-Path: <linux-fsdevel+bounces-61079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE00B54CCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF59C5A3666
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD3F303A00;
	Fri, 12 Sep 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLcNqfnZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCBD2FD7D9
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678213; cv=none; b=TABHBBfLjZsRqELqllKG09xTYdm5eN+hDwjOqg+hqz7Jty7rFyMgSydIQjYSdIACMdyx4dz5U31NjjIpe1mctDSVyV8GSKy5TebMVtgGz9JCKvBc22a/Qc7xuc6Cf1JDXZpNJ58/G220MyGr+/bYzjj9rBbYdAfGGdMA62/MOCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678213; c=relaxed/simple;
	bh=+mNtg5JQLMkrEOEyHPRCbKpHStXXOyD5XtUgf68Si4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZFkI6CvICbFlq2taSnX++uGm4VDBbyz8yuJ7GyOo2UGnT9suoFd497LfAThSKB7L9ukZdT5sol5T+UwvorinDPHI587D7CIfRTEWwJIwPFZ0bkiEbABuFJcC21jd1nppweF+bFPZG/Mm65ikK/5Wt93hGwS8cCnTy5dpd/7zNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLcNqfnZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757678210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+6E05kBbROZjYHlECJ6pM3n90elFfaGg1KIjniWKd0=;
	b=HLcNqfnZtQIRRIrw/Pu50WCO0gl5DJMDQ27rYBob+wMyoWgD/2WNaS0RObKULVNJQJr0ds
	7XK5SzLjCVhN+LbZWspqnXGxVS0xhD98R66+G9UQrI//V99BoztWBPTu/A0L7hH64Jy0pe
	tQUH7lWkcT39ALBrE144BQFvWom8Myg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-9KAjX5iLOaaN-C5PVDFDbA-1; Fri, 12 Sep 2025 07:56:49 -0400
X-MC-Unique: 9KAjX5iLOaaN-C5PVDFDbA-1
X-Mimecast-MFC-AGG-ID: 9KAjX5iLOaaN-C5PVDFDbA_1757678208
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dcfc6558cso13785495e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 04:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678208; x=1758283008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+6E05kBbROZjYHlECJ6pM3n90elFfaGg1KIjniWKd0=;
        b=PrkLw2rhI/e7aVO7yM2+3CUfJwfFVJgyYe/0WUWJnIjlMYGTbU/kFu3Lyj1c0xm4oX
         4lxXJuZAXqki9/1iPqgG4QNx+Q3CR6atuoUquzmHDCxYquI1kQl1xRu585+qshekQ6jG
         3Ui3BmNvB6bjWo+7/JxhyDo9JIOzbnQPxXy91mzXL9i3aVqQYMSOq5D+8nYKbdTlSLHS
         dPPuRfXxo19mjk7MU+RJ2xETASmda5hYoBoL3tyVYwaGf91b6MxjiFf7Bu5oUYPx0nFm
         lGviosOI6l6lpCZIwXdQEOD0VXAg7mLr/InOPrgTkFTHhXTBVo9Q7+1AqcXQyLJQQus5
         idcg==
X-Forwarded-Encrypted: i=1; AJvYcCW4n+ShatWy8e8qxnTEbvWjxTcnx/3jO2ljriTLSpA/jMwWnIFQAIFnJXaZ47z1faPx4gRo4qikpPrVURqD@vger.kernel.org
X-Gm-Message-State: AOJu0YwymhuVb7iYlMaGi1GG8WI2AEBfh7I5muCtawthDBwFm8OQ8r6k
	4c4YUwP2jmT9662btDgq6wutVCa3Wr0HRm55IbMMrKHTN3jnLy7QZHxLZrlVz48BtmBwKawarh9
	YUcd/MegLVhkCqsb2c2PQtr+JEGBb4AVJ0BCBDih6nyiRjWW9WQaPWWY+NVUY4GylZzUVxvn+4M
	MU
X-Gm-Gg: ASbGncsze4kar4MxzgRW9O9/S+2XfXX52515eUifZ+HjFrTlJZtWtNcgodby/We2J12
	n4DNBpgGAJ4mP6qAO39fde/49ukgmEAK5dJLPUqO5frLvGJ94/R6TyPd4pZhdQNonIPG8LtIdOR
	BtJc5jkL3kFKwj+SxJggBjxTaFnHgRvj5odAASPw5KQm6PNvMY3OGRoGHCf0I4uVz5+bqwzwVNH
	/JJ8jNi+zLz2bCnl2/g065gaqAPU7Uf3PbklGiDj4Gn/xOWlluWtbJee9qdKZmcJ/mLXO9upU7K
	6atbXlhtqGjyG6BiGgRGSvZYDdtryEFT
X-Received: by 2002:a05:600c:46d3:b0:45e:598:90b0 with SMTP id 5b1f17b1804b1-45f211d4640mr28993445e9.9.1757678207817;
        Fri, 12 Sep 2025 04:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa3w2WIx7VIKrKrQtNbmGIs6VxkTekeX4oKYegwFajbDtX1Br0uRbrYVR+ymTQ7e9/hErz+g==
X-Received: by 2002:a05:600c:46d3:b0:45e:598:90b0 with SMTP id 5b1f17b1804b1-45f211d4640mr28993125e9.9.1757678207364;
        Fri, 12 Sep 2025 04:56:47 -0700 (PDT)
Received: from thinky ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d741asm58941035e9.23.2025.09.12.04.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:56:47 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:56:45 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, david@fromorbit.com, 
	ebiggers@kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 02/29] iomap: introduce iomap_read/write_region
 interface
Message-ID: <khoyx76se2x2z2ktzelsklcqnbjl4budasczm2mjknkgvlsbph@gckk675qmqkj>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-2-9e5443af0e34@kernel.org>
 <20250729222252.GJ2672049@frogsfrogsfrogs>
 <20250811114337.GA8850@lst.de>
 <pz7g2o6lo6ef5onkgrn7zsdyo2o3ir5lpvo6d6p2ao5egq33tw@dg7vjdsyu5mh>
 <20250912071859.GB13505@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912071859.GB13505@lst.de>

On 2025-09-12 09:18:59, Christoph Hellwig wrote:
> On Tue, Sep 09, 2025 at 02:30:14PM +0200, Andrey Albershteyn wrote:
> > > Same thoughts here.  It seems like we should just have a beyond-EOF or
> > > fsverity flag for ->read_iter / ->write_iter and consolidate all this
> > > code.  That'll also go along nicely with the flag in the writepage_ctx
> > > suggested by Joanne.
> > > 
> > 
> > In addition to being bound by the isize the fiemap_read() copies
> > data to the iov_iter, which is not really needed for fsverity.
> 
> Aka, you want an O_DIRECT read into a ITER_BVEC buffer for the data?
> 

hmm, but we want fsverity merkle tree to be in page cache to use the
"verified page" flag. As far as I understand iter_bvec will need a
page attached anyway, so this is the same. Or am I missing
something?

And with direct io there's no readahead then, and we don't get any
benefit going through vfs instead of directly calling to iomap.

-- 
- Andrey


