Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CE02E9294
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 10:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbhADJ0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 04:26:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbhADJ0W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609752296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1DfRNv/JemPKRiSjvewhQQD9XRV8pm7xARBhqGfFCAQ=;
        b=A8XeBkg/5hFv4Os9gHJ/Ac9UNKaclEhu3iAMjdc1MdV+cN+SI2DhyjzPgtT/z+QV2y2bkh
        rYN5EjIgYzGvk3xA5chqJEFRj2Q4/YN9y+1x/Dizwe25nd+WOEy+ZM27b4w0fC0vRAUL6h
        PRt5J5Y6VHEIk1BPQQQq8QqVVg1SgFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-b_BmQ3-NM1iLbMLIAXTs5w-1; Mon, 04 Jan 2021 04:24:39 -0500
X-MC-Unique: b_BmQ3-NM1iLbMLIAXTs5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5CADB8110;
        Mon,  4 Jan 2021 09:24:37 +0000 (UTC)
Received: from T590 (ovpn-12-200.pek2.redhat.com [10.72.12.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B0116F99F;
        Mon,  4 Jan 2021 09:24:31 +0000 (UTC)
Date:   Mon, 4 Jan 2021 17:24:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fs/buffer: try to submit writeback bio in unit of page
Message-ID: <20210104092425.GA3587310@T590>
References: <20201230000815.3448707-1-ming.lei@redhat.com>
 <20210104084415.GA28741@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104084415.GA28741@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 09:44:15AM +0100, Christoph Hellwig wrote:
> On Wed, Dec 30, 2020 at 08:08:15AM +0800, Ming Lei wrote:
> > It is observed that __block_write_full_page() always submit bio with size of block size,
> > which is often 512 bytes.
> > 
> > In case of sequential IO, or >=4k BS random/seq writeback IO, most of times IO
> > represented by all buffer_head in each page can be done in single bio. It is actually
> > done in single request IO by block layer's plug merge too.
> > 
> > So check if IO represented by buffer_head can be merged to single page
> > IO, if yes, just submit single bio instead of submitting one bio for each buffer_head.
> 
> There is some very weird formatting in here.  From a very quick look
> the changes look sensible, but I wonder if we should spend so much
> time optimizing the legacy buffer_head I/O path, rather than switching
> callers to saner helpers.

It may take long to convert fs code into iomap, and I understand fs/block_dev.c
can't be converted to iomap until all FS removes buffer_head, correct me
if it is wrong.


Thanks,
Ming

