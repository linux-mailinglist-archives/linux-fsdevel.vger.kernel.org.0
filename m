Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C6A12FCB3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgACSn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 13:43:29 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58611 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728279AbgACSn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578077007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G06rLs4TL8KIzGAoCVXXQSepgpLI5vBIheYDXyHB7xI=;
        b=VZDQkr1g7oGB7xJElIsUzrJK6UcS2bFHO2CWhcGR4n1MGaVwziUUz/b1hNOVAlnmhaT5zu
        FAAf0K/+UaQK3xtIWZX+RmeOqDxagJLyDsRKCDQPd18zvuJkKQIxd+UwuVOAcJ/tkGBVME
        6fde26HJZLg7Pg3rO6WXr/IBVM4u7fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-NDHRQ768NaqZh93_ibVOCw-1; Fri, 03 Jan 2020 13:43:24 -0500
X-MC-Unique: NDHRQ768NaqZh93_ibVOCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 059151801256;
        Fri,  3 Jan 2020 18:43:23 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DECFF10021B2;
        Fri,  3 Jan 2020 18:43:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7907C2202E9; Fri,  3 Jan 2020 13:43:17 -0500 (EST)
Date:   Fri, 3 Jan 2020 13:43:17 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
Message-ID: <20200103184317.GC13350@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org>
 <20190826203326.GB13860@redhat.com>
 <20190826205829.GC13860@redhat.com>
 <20200103141235.GA13350@redhat.com>
 <CAPcyv4hr-KXUAT_tVy-GuTOq1GvVGHKsHwAPih60wcW3DGmqRg@mail.gmail.com>
 <CAPcyv4jM8s8T5ifv0c2eyqaBu3f2bd_j+fQHmJttZAajZ-we=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jM8s8T5ifv0c2eyqaBu3f2bd_j+fQHmJttZAajZ-we=g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 03, 2020 at 10:18:22AM -0800, Dan Williams wrote:

> I'll also circle back to your question about
> partitions on patch1.

Hi Dan,

I was playing with having sector information in dax device (and not having
to look back at bdev). I was thinking of something as follows.

- Create a new structure/handle which also contains offset into dax device
  in sectors. Say.

  struct dax_handle {
  	sector_t start_sect;
  	struct dax_device *dax_dev;
  }

 This handle will have pointer to the actual dax device.

- Modify dax_get_by_bdev(struct block_device *bdev) to return dax_handle
  (instead of dax device).

  struct dax_handle *dax_get_by_bdev(struct block_device *bdev);

  This will create dax_handle. Find dax_device from hash table and
  initialize dax_handle.

  dax_handle->start_sect = get_start_sect(bdev);
  dax_handle->dax_dev = dax_dev;

  Now filesystem and stacked block devices can get pointer to dax_handle
  using block device and they can use this handle to refer to underlying
  dax device partition.

- Now dax_handle can be passed around and hopefully we can get rid of
  passing around bdev in many of the dax interfaces. And partition offset
  information has now moved into dax_handle.

- For the use cases which don't have a bdev (like virtiofs), we can
  provide another helper to get dax_handle with offset 0. And then
  we should not need a bdev to be able to use dax API.

Does this sound like a reasonable step in the direction of getting rid
of this assumption that every dax_device has associated block_device.

Thanks
Vivek

