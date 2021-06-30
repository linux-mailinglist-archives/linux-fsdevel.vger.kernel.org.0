Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB73C3B87C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 19:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhF3Rg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 13:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229852AbhF3Rgz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625074466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N4ro5oL6ovpNBSp+T8bHCUqPQn0i5VVo5zsyKjCXD18=;
        b=I/t220pDeP1ieCsBbU8Cz8iD8YAHVkd5YgzV+Q7mxHjmeMeuOt6IEKPrUKMwJybyznWxS6
        lrvR8hvQyAXnGFRs1umEC3UZ0WkT2HNii83XUR8TkSJSCAs9Jbva+o38MF/bNaat/RM9v9
        SyR/hsCI1rsJOdDQnZF5P/RbBSj5dmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-uiy8ntILMKG-kB9HWVSukw-1; Wed, 30 Jun 2021 13:34:24 -0400
X-MC-Unique: uiy8ntILMKG-kB9HWVSukw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E04F981CD1C;
        Wed, 30 Jun 2021 17:34:22 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-222.rdu2.redhat.com [10.10.115.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36B343AC2;
        Wed, 30 Jun 2021 17:33:59 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C3B6422054F; Wed, 30 Jun 2021 13:33:58 -0400 (EDT)
Date:   Wed, 30 Jun 2021 13:33:58 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Virtio-fs] [PATCH 3/2] fs: simplify get_filesystem_list /
 get_all_fs_names
Message-ID: <20210630173358.GD75386@redhat.com>
References: <20210621062657.3641879-1-hch@lst.de>
 <20210622081217.GA2975@lst.de>
 <YNGhERcnLuzjn8j9@stefanha-x1.localdomain>
 <20210629205048.GE5231@redhat.com>
 <20210630053601.GA29241@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630053601.GA29241@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 07:36:01AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 29, 2021 at 04:50:48PM -0400, Vivek Goyal wrote:
> > May be we should modify mount_block_root() code so that it does not
> > require that extra "\0". Possibly zero initialize page and that should
> > make sure list_bdev_fs_names() does not have to worry about it.
> > 
> > It is possible that a page gets full from the list of filesystems, and
> > last byte on page is terminating null. In that case just zeroing page
> > will not help. We can keep track of some sort of end pointer and make
> > sure we are not searching beyond that for valid filesystem types.
> > 
> > end = page + PAGE_SIZE - 1;
> > 
> > mount_block_root()
> > {
> > 	for (p = fs_names; p < end && *p; p += strlen(p)+1) {
> > 	}
> > }
> 
> Maybe.  To honest I'd prefer to not even touch this unrelated code given
> how full of landmines it is :)

Agreed. It probably is better to make such changes incrementally. 

Given third patch is nice to have cleanup kind of thing, can we first
just merge first two patches to support non-block device filesystems as
rootfs.

We will really like to have a method to properly boot virtiofs as rootfs.

Thanks
Vivek

