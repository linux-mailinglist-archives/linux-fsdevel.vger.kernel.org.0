Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2949729DEAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbgJ2A4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731644AbgJ1WRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U+J9Zk1IP6t34fGKZVaWA98c8E3lKZDT942o5Pt7dGs=;
        b=F+rq1I6cJ/xVBrhEGmeX5wrMHJosY8xQ6au+jaKjhyQMhmCSv0uvNgi6WjSkHlJRMQ00SZ
        nYhCwp2620ZzI0a1kH/mPFMZN4shu8Ll9QghdZt+kDtBvywJxdGdlduxbgnGnSqP+c8Dak
        VGhvLMz0NR2t8sYLKlFe6f5K9bewGZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-1V8D38d5NgSGU6nic-NKUQ-1; Wed, 28 Oct 2020 10:16:02 -0400
X-MC-Unique: 1V8D38d5NgSGU6nic-NKUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D627E86ABCE;
        Wed, 28 Oct 2020 14:16:01 +0000 (UTC)
Received: from bfoster (ovpn-113-186.rdu2.redhat.com [10.10.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AA046EF4A;
        Wed, 28 Oct 2020 14:16:01 +0000 (UTC)
Date:   Wed, 28 Oct 2020 10:15:59 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: support partial page discard on writeback block
 mapping failure
Message-ID: <20201028141559.GB1611922@bfoster>
References: <20201026182019.1547662-1-bfoster@redhat.com>
 <20201028073127.GA32068@infradead.org>
 <20201028113200.GC1610972@bfoster>
 <20201028140408.GA7841@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028140408.GA7841@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:04:08PM +0000, Christoph Hellwig wrote:
> On Wed, Oct 28, 2020 at 07:32:00AM -0400, Brian Foster wrote:
> > I used the variable just to avoid having to split the function call into
> > multiple lines. I.e., it just looked more readable to me than:
> > 
> >                if (wpc->ops->discard_page)
> >                         wpc->ops->discard_page(page,
> >                                                offset_in_page(file_offset));
> > 
> > I can change it back if that is preferred (or possibly use a function
> > pointer variable instead). I suppose that's also avoided by passing
> > file_offset directly, but that seems a little odd to me for a page
> > oriented callback.
> 
> I think passing the file offset makes more sense, especially as the
> only instance needs it anyway.
> 

The callback uses both, but I'm not tied to it either way. I'll make
that tweak for the next version..

Brian

