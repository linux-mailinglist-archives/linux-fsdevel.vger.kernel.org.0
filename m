Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7281F180745
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 19:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCJSrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 14:47:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49844 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726391AbgCJSrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583866054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvrq31NBMkv7Vsef+6f+mBGyLXD/eDRO+WBoQLnMO/s=;
        b=A90CR9b+5ERYZcvA94Ya8A4/iAfjbnY5QXsrpGjcZeEwdmVz5nVXuVFen/6a7ud9pqb+Gt
        d97xe8b+yVxT5N0FS7iFqbEY+JVGe2+DxQAFWvzWU2MmgS5CYLFcHqJvxy1xeAwUi0pyAE
        benwlQ2NrIltU/T8D82YEtuxLswDLTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-lrpkCCq3MUejwZtd_UU6uw-1; Tue, 10 Mar 2020 14:47:30 -0400
X-MC-Unique: lrpkCCq3MUejwZtd_UU6uw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A82A2477;
        Tue, 10 Mar 2020 18:47:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDAF6277A4;
        Tue, 10 Mar 2020 18:47:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7B8B322021D; Tue, 10 Mar 2020 14:47:20 -0400 (EDT)
Date:   Tue, 10 Mar 2020 14:47:20 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Message-ID: <20200310184720.GD38440@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-5-vgoyal@redhat.com>
 <20200310071043-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310071043-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 07:12:25AM -0400, Michael S. Tsirkin wrote:
[..]
> > +static bool vp_get_shm_region(struct virtio_device *vdev,
> > +			      struct virtio_shm_region *region, u8 id)
> > +{
> > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> > +	u8 bar;
> > +	u64 offset, len;
> > +	phys_addr_t phys_addr;
> > +	size_t bar_len;
> > +	int ret;
> > +
> > +	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> > +		return false;
> > +	}
> > +
> > +	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
> > +	if (ret < 0) {
> > +		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> > +			__func__);
> > +		return false;
> > +	}
> > +
> > +	phys_addr = pci_resource_start(pci_dev, bar);
> > +	bar_len = pci_resource_len(pci_dev, bar);
> > +
> > +        if (offset + len > bar_len) {
> > +                dev_err(&pci_dev->dev,
> > +                        "%s: bar shorter than cap offset+len\n",
> > +                        __func__);
> > +                return false;
> > +        }
> > +
> 
> Something wrong with indentation here.

Will fix all indentation related issues in this patch.

> Also as long as you are validating things, it's worth checking
> offset + len does not overflow.

Something like addition of following lines?

+       if ((offset + len) < offset) {
+               dev_err(&pci_dev->dev, "%s: cap offset+len overflow detected\n",
+                       __func__);
+               return false;
+       }

Vivek

