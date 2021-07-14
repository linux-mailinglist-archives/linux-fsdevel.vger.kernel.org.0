Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235183C7E48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 07:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbhGNF56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 01:57:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237957AbhGNF55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 01:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626242106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vuixl4fC2c2rDMK0JnG+CP570kUeJWSiqn18LVKWU/A=;
        b=ZHrCj9J5MiywYvEk8JK/z4/yFpt1l+XKqoY6dGbaLpa+fSnC7apgZseNeUrYmm2i05eAWD
        7tOWoNXlPf+2tsY42Rl2sdt6vtj6SSVl6Gslc7363MqC3JxJHTDcYYUJAnG6twGCcdKfHZ
        a3AeLSCnXI4XsIYY2BrHTHE2XKeXIjQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-AA8mJD9WOMiA-yZvWDHhMg-1; Wed, 14 Jul 2021 01:55:05 -0400
X-MC-Unique: AA8mJD9WOMiA-yZvWDHhMg-1
Received: by mail-wr1-f69.google.com with SMTP id 32-20020adf82a30000b029013b21c75294so889980wrc.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 22:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vuixl4fC2c2rDMK0JnG+CP570kUeJWSiqn18LVKWU/A=;
        b=FUIU+2XYhgpUyEvaF3Stpfc6McBH0UPcpTh3OfhGp+8BWjC+qT8YhYCZCqHz38V+TD
         AN1NtDVv5OTGR/4a7TzDi2vjPuPPlXgo6ZueliIbGfgepeS2LkJT8GZsgkPrcHt0kU4S
         dv203Y691JbHERR0e6R48zmAY/Xh7SDrUY+2cxM4aryJAR3I/56+YFPe1XRxJEMd4EKd
         ZRT6Cdxe3uUF+5HfaO+zES7rDI+PS95x11KyFp4spYTLjQaXMcAsMy9lH1SW5vH04VMr
         wLTXJVv7escPcIkdXJ3ZvINkKycYzRuDTgl8JIxs4THPJWl9qMWvlJ+jayd0EVHAxFWP
         9Qyw==
X-Gm-Message-State: AOAM530EnNGNWeFDvI/7cjaKeo3PORb4Po9e3wmY3CDrgDTmeoLlw3Jl
        OCi/QgY+tvmftzT624u2s+UJbppREJiV9eRkYoAFoK9GKGcfcmOiMuWMwslTFJLopyHu0OatgF8
        Zcbb4bdFqsmDc5nAnggweo9/49w==
X-Received: by 2002:a7b:c3c1:: with SMTP id t1mr8958244wmj.25.1626242103972;
        Tue, 13 Jul 2021 22:55:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/S4q9eTkg2SYhF6yFeKAyfrn1SBCErVUzbnkOz4rD7u4lWIEWYF5U7IkZ57PnxEN5PdQimQ==
X-Received: by 2002:a7b:c3c1:: with SMTP id t1mr8958222wmj.25.1626242103823;
        Tue, 13 Jul 2021 22:55:03 -0700 (PDT)
Received: from redhat.com ([2.55.15.23])
        by smtp.gmail.com with ESMTPSA id i15sm1182300wro.3.2021.07.13.22.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 22:55:03 -0700 (PDT)
Date:   Wed, 14 Jul 2021 01:54:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in
 Userspace
Message-ID: <20210714014817-mutt-send-email-mst@kernel.org>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-17-xieyongji@bytedance.com>
 <26116714-f485-eeab-4939-71c4c10c30de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26116714-f485-eeab-4939-71c4c10c30de@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 01:45:39PM +0800, Jason Wang wrote:
> > +static int vduse_dev_msg_sync(struct vduse_dev *dev,
> > +			      struct vduse_dev_msg *msg)
> > +{
> > +	int ret;
> > +
> > +	init_waitqueue_head(&msg->waitq);
> > +	spin_lock(&dev->msg_lock);
> > +	msg->req.request_id = dev->msg_unique++;
> > +	vduse_enqueue_msg(&dev->send_list, msg);
> > +	wake_up(&dev->waitq);
> > +	spin_unlock(&dev->msg_lock);
> > +
> > +	wait_event_killable_timeout(msg->waitq, msg->completed,
> > +				    VDUSE_REQUEST_TIMEOUT * HZ);
> > +	spin_lock(&dev->msg_lock);
> > +	if (!msg->completed) {
> > +		list_del(&msg->list);
> > +		msg->resp.result = VDUSE_REQ_RESULT_FAILED;
> > +	}
> > +	ret = (msg->resp.result == VDUSE_REQ_RESULT_OK) ? 0 : -EIO;
> 
> 
> I think we should mark the device as malfunction when there is a timeout and
> forbid any userspace operations except for the destroy aftwards for safety.

This looks like if one tried to run gdb on the program the behaviour
will change completely because kernel wants it to respond within
specific time. Looks like a receipe for heisenbugs.

Let's not build interfaces with arbitrary timeouts like that.
Interruptible wait exists for this very reason. Let userspace have its
own code to set and use timers. This does mean that userspace will
likely have to change a bit to support this driver, such is life.

-- 
MST

