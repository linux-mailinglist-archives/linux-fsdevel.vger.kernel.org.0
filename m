Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9FE29E311
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 03:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgJ2Cox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 22:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbgJ1VeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603920848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dc3xSQ/kErSqUBkrK0lDySaO4HZl16icllTK3oHjLqM=;
        b=Lsqcxlq+530JPHkpm/NKwYg+atBQMx1YG+zxEO+iMpkCPvDD8XcCs6aUKFuYar2Gxmmp0D
        i8Y/8IKS4IKEYtucMavVf1zjqCrIPtj3NdE3T22cpQwSyHFyxLrCsZErItQWFQWUaLymkZ
        Z3Kd2MGRPDy9a6hE3FXYQPCKBZRD0r0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-ZNVLzF42PQW02MhVeEzb1A-1; Wed, 28 Oct 2020 07:32:04 -0400
X-MC-Unique: ZNVLzF42PQW02MhVeEzb1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2697186DD29;
        Wed, 28 Oct 2020 11:32:02 +0000 (UTC)
Received: from bfoster (ovpn-113-186.rdu2.redhat.com [10.10.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81C3E196FE;
        Wed, 28 Oct 2020 11:32:02 +0000 (UTC)
Date:   Wed, 28 Oct 2020 07:32:00 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: support partial page discard on writeback block
 mapping failure
Message-ID: <20201028113200.GC1610972@bfoster>
References: <20201026182019.1547662-1-bfoster@redhat.com>
 <20201028073127.GA32068@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028073127.GA32068@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 28, 2020 at 07:31:27AM +0000, Christoph Hellwig wrote:
> >  	if (unlikely(error)) {
> > +		unsigned int	pageoff = offset_in_page(file_offset);
> > +		/*
> > +		 * Let the filesystem know what portion of the current page
> > +		 * failed to map. If the page wasn't been added to ioend, it
> > +		 * won't be affected by I/O completion and we must unlock it
> > +		 * now.
> > +		 */
> > +		if (wpc->ops->discard_page)
> > +			wpc->ops->discard_page(page, pageoff);
> 
> I don't think we need the pageoff variable here.   Also it would
> seem more natural to pass the full file_offset offset instead of
> having to recreate it in the file system.
> 

I used the variable just to avoid having to split the function call into
multiple lines. I.e., it just looked more readable to me than:

               if (wpc->ops->discard_page)
                        wpc->ops->discard_page(page,
                                               offset_in_page(file_offset));

I can change it back if that is preferred (or possibly use a function
pointer variable instead). I suppose that's also avoided by passing
file_offset directly, but that seems a little odd to me for a page
oriented callback.

Brian

