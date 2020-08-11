Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F541241F62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgHKRon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 13:44:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53701 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728554AbgHKRon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597167881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttmjy05YtDY5fs+rLP1raSH+zo+BvNvZy0wKOqfr0Vs=;
        b=gV/M5gIKaVLK0g0dbZ4DBnsKOHPk8Ke79H9tX8gW6QZC4rdJdtzqnbOOBT9Z1+3qu37KTy
        uAIoiRjl5rvTZOxok/OIRjGan62ZWWybvlBbykHuqgMaquvx3SvYYTXn9o2ly/ve5kNOgf
        VD7W9Lhjod8kOW9yKDfiY/DGxnDoNis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-bJdVG4_rPeKuZKndxfh5DQ-1; Tue, 11 Aug 2020 13:44:39 -0400
X-MC-Unique: bJdVG4_rPeKuZKndxfh5DQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 184F2100CCC1;
        Tue, 11 Aug 2020 17:44:37 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-120.rdu2.redhat.com [10.10.117.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1E6D61982;
        Tue, 11 Aug 2020 17:44:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6A84222036A; Tue, 11 Aug 2020 13:44:29 -0400 (EDT)
Date:   Tue, 11 Aug 2020 13:44:29 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: Re: [PATCH v2 13/20] fuse, dax: Implement dax read/write operations
Message-ID: <20200811174429.GA497326@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-14-vgoyal@redhat.com>
 <20200810220655.GC2079@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810220655.GC2079@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 08:06:55AM +1000, Dave Chinner wrote:
> On Fri, Aug 07, 2020 at 03:55:19PM -0400, Vivek Goyal wrote:
> > This patch implements basic DAX support. mmap() is not implemented
> > yet and will come in later patches. This patch looks into implemeting
> > read/write.
> 
> ....
> 
> > +static int iomap_begin_setup_new_mapping(struct inode *inode, loff_t pos,
> > +					 loff_t length, unsigned flags,
> > +					 struct iomap *iomap)
> 
> please doin't use the iomap_* namespace even for static functions in
> filesystem code. This really doesn't have anything to do with iomap
> except that whatever fuse sets up is used to fill an iomap.
> i.e. fuse_setup_new_dax_mapping() would be far more appropriate
> name.
> 
> > +static int iomap_begin_upgrade_mapping(struct inode *inode, loff_t pos,
> > +					 loff_t length, unsigned flags,
> > +					 struct iomap *iomap)
> 
> ditto: fuse_upgrade_dax_mapping().
> 

Hi Dave,

Will rename these functions as you suggested.

Vivek

