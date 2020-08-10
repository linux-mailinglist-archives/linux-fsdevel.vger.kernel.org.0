Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F08240701
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 15:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgHJNyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 09:54:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52944 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726584AbgHJNys (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597067686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=11abmRXCh4a2zJ5GLAvm1E8WzRC1Uo5rJiAJN/2ETwU=;
        b=W39x1KDteRwHyKLP5KgU11hv4NwPFkWQp5CWkQFi30qKmw5gfXPgEgn59D+P0R/egmvyj9
        3cS6l4S//5gg1QMopO4fSozPXGD30sbgrsRvDC6WG7m+C6HOGkIyt/uzSs/x6ZReAgJ+gv
        k0WrBeo0DGkj5kawG5EUiWPUMkDlvyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-qn1pY0SdNde9MBKPXrvQSw-1; Mon, 10 Aug 2020 09:54:42 -0400
X-MC-Unique: qn1pY0SdNde9MBKPXrvQSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CE0E19057A0;
        Mon, 10 Aug 2020 13:54:41 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.10.115.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 172036F128;
        Mon, 10 Aug 2020 13:54:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6512A22036A; Mon, 10 Aug 2020 09:54:32 -0400 (EDT)
Date:   Mon, 10 Aug 2020 09:54:32 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2 03/20] virtio: Add get_shm_region method
Message-ID: <20200810135432.GA459233@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-4-vgoyal@redhat.com>
 <20200810094548-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810094548-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 10, 2020 at 09:47:15AM -0400, Michael S. Tsirkin wrote:
> On Fri, Aug 07, 2020 at 03:55:09PM -0400, Vivek Goyal wrote:
> > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > 
> > Virtio defines 'shared memory regions' that provide a continuously
> > shared region between the host and guest.
> > 
> > Provide a method to find a particular region on a device.
> > 
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Cc: kvm@vger.kernel.org
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> 
> I'm not sure why doesn't b4 pick up reset of this
> patchset. where can I find it?

What is b4? I think I might not have copied to right list. I cced
kvm, but probably I should sent it to virtualization@lists.linux-foundation.org
instead?

> 
> 
> IIUC all this is 5.10 material, right?

I think so. It probably is too late for 5.9.

Thanks
Vivek

> 
> 
> > ---
> >  include/linux/virtio_config.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index bb4cc4910750..c859f000a751 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -10,6 +10,11 @@
> >  
> >  struct irq_affinity;
> >  
> > +struct virtio_shm_region {
> > +       u64 addr;
> > +       u64 len;
> > +};
> > +
> >  /**
> >   * virtio_config_ops - operations for configuring a virtio device
> >   * Note: Do not assume that a transport implements all of the operations
> > @@ -65,6 +70,7 @@ struct irq_affinity;
> >   *      the caller can then copy.
> >   * @set_vq_affinity: set the affinity for a virtqueue (optional).
> >   * @get_vq_affinity: get the affinity for a virtqueue (optional).
> > + * @get_shm_region: get a shared memory region based on the index.
> >   */
> >  typedef void vq_callback_t(struct virtqueue *);
> >  struct virtio_config_ops {
> > @@ -88,6 +94,8 @@ struct virtio_config_ops {
> >  			       const struct cpumask *cpu_mask);
> >  	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
> >  			int index);
> > +	bool (*get_shm_region)(struct virtio_device *vdev,
> > +			       struct virtio_shm_region *region, u8 id);
> >  };
> >  
> >  /* If driver didn't advertise the feature, it will never appear. */
> > @@ -250,6 +258,15 @@ int virtqueue_set_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
> >  	return 0;
> >  }
> >  
> > +static inline
> > +bool virtio_get_shm_region(struct virtio_device *vdev,
> > +                         struct virtio_shm_region *region, u8 id)
> > +{
> > +	if (!vdev->config->get_shm_region)
> > +		return false;
> > +	return vdev->config->get_shm_region(vdev, region, id);
> > +}
> > +
> >  static inline bool virtio_is_little_endian(struct virtio_device *vdev)
> >  {
> >  	return virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
> > -- 
> > 2.25.4
> 

