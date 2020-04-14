Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7368A1A7B6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502358AbgDNMyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 08:54:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49298 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502340AbgDNMyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586868864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ccpe52mTDyC9nOe0e/xM0kPaLBd9rNdSI9IJFo2/EN8=;
        b=U6B+tvpRgOIhvhgJ1oTbnVVoE2VQAXaYBM2kIlZS8qxVcMi/1nIVfaPl6oAJBVuVSgAx6U
        m+WZgWkRVdNjyDSvhOVnJZAI6JyZ8+lQo6RzsTNKMwSLLcIScYKrh1XuAxuXMd0Dg32yap
        rsUJMW8xRa0v6hE9a5P6viZcpcVjgxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-YVT18TVnP6iwR2Qxc-UDZw-1; Tue, 14 Apr 2020 08:54:22 -0400
X-MC-Unique: YVT18TVnP6iwR2Qxc-UDZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF89D8017FF;
        Tue, 14 Apr 2020 12:54:20 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-133.rdu2.redhat.com [10.10.115.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B509A10027B3;
        Tue, 14 Apr 2020 12:54:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 24C16220935; Tue, 14 Apr 2020 08:54:11 -0400 (EDT)
Date:   Tue, 14 Apr 2020 08:54:11 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Liu Bo <bo.liu@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: Re: [PATCH 13/20] fuse, dax: Implement dax read/write operations
Message-ID: <20200414125411.GA210453@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-14-vgoyal@redhat.com>
 <20200404002521.GA125697@rsjd01523.et2sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404002521.GA125697@rsjd01523.et2sqa>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 04, 2020 at 08:25:21AM +0800, Liu Bo wrote:

[..]
> > +static int iomap_begin_upgrade_mapping(struct inode *inode, loff_t pos,
> > +					 loff_t length, unsigned flags,
> > +					 struct iomap *iomap)
> > +{
> > +	struct fuse_inode *fi = get_fuse_inode(inode);
> > +	struct fuse_dax_mapping *dmap;
> > +	int ret;
> > +
> > +	/*
> > +	 * Take exclusive lock so that only one caller can try to setup
> > +	 * mapping and others wait.
> > +	 */
> > +	down_write(&fi->i_dmap_sem);
> > +	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos, pos);
> > +
> > +	/* We are holding either inode lock or i_mmap_sem, and that should
> > +	 * ensure that dmap can't reclaimed or truncated and it should still
> > +	 * be there in tree despite the fact we dropped and re-acquired the
> > +	 * lock.
> > +	 */
> > +	ret = -EIO;
> > +	if (WARN_ON(!dmap))
> > +		goto out_err;
> > +
> > +	/* Maybe another thread already upgraded mapping while we were not
> > +	 * holding lock.
> > +	 */
> > +	if (dmap->writable)
> 
> oops, looks like it's still returning -EIO here, %ret should be zero.
> 

Good catch. Will fix it.

Vivek

