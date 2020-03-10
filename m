Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F8F180A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 22:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCJV1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 17:27:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29362 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726100AbgCJV1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583875638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=elF36Gh6wAO43EXQWi3veY++EdOPHWUl7a5YAiXhFTQ=;
        b=HziVMxK2D5RJcYF0bqBbXWQ4EDx1t0YTx09F0AKtSze4CAM39HvESxL4VhtXPm8gIjJ2yC
        Xzk353m2CIwXQXo10qBUNwzvgSvQ5ZikWL/laAXQnJA+KfgXFfq1NbNIPZMiop6NKdJNBY
        k5h56Vg36nn4E+oElzwpeqAx7ehH/TM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-5wkyNo8WNc-wW39XlW0zzA-1; Tue, 10 Mar 2020 17:27:16 -0400
X-MC-Unique: 5wkyNo8WNc-wW39XlW0zzA-1
Received: by mail-qt1-f197.google.com with SMTP id y11so7874839qtn.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 14:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elF36Gh6wAO43EXQWi3veY++EdOPHWUl7a5YAiXhFTQ=;
        b=CV9KXyppP3teu05KGZCyi8RQZpg+8kJj/iPZUOHI+mmowpMd672qCnxTXX6Uf1GXwl
         4i8vV45XI4HGpgO1wjjnIpQLM/+nNaLUhvCHs4XTvlnSABwEWwSXxfQrTzC49krMdQc6
         rKZbnZ6LTljrK+qlOAtoC3JlxEDfvf/GlKZwWeHd29kbuGzxHwJpSDfQDl5Fug7x8lKv
         +cGKMR71Kr6HmxzyUGPVb2mj0YYWtnqj23hlGgeIz1BrcDEUVhSM10pSRCpCs4X8XEeH
         FPx+cXmRCG2v98dp0GKsAnUD3yZ4PLTO0h0Llc8c26T67K+vhcrB6Zb17TS4FSLpoxn9
         jZxg==
X-Gm-Message-State: ANhLgQ1lUcDYFyZBRudVlqXcALyDEH5z10iVlhql7hYuw7hKXi6ZB7cK
        w26K9C9lK1ApUni7LSQicfem9gFJA7nZWI6KNM6ZyuQIeYEbLm9CiMSl6Vdhqs6vp9XhrdOu8wY
        VcqzowhQUtIsgI6VaEtecKnYXcg==
X-Received: by 2002:a37:40d2:: with SMTP id n201mr21535563qka.211.1583875636364;
        Tue, 10 Mar 2020 14:27:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtXf2G2CIG42koICoLhPiploL8mRnMRgCVqT/plH2Fo1ASYnuHMzPvSDT2uyk6rvt8fR12jmg==
X-Received: by 2002:a37:40d2:: with SMTP id n201mr21535545qka.211.1583875636149;
        Tue, 10 Mar 2020 14:27:16 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id x51sm3774837qtj.82.2020.03.10.14.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:27:14 -0700 (PDT)
Date:   Tue, 10 Mar 2020 17:27:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Message-ID: <20200310172603-mutt-send-email-mst@kernel.org>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-5-vgoyal@redhat.com>
 <20200310071043-mutt-send-email-mst@kernel.org>
 <20200310184720.GD38440@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310184720.GD38440@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 02:47:20PM -0400, Vivek Goyal wrote:
> On Tue, Mar 10, 2020 at 07:12:25AM -0400, Michael S. Tsirkin wrote:
> [..]
> > > +static bool vp_get_shm_region(struct virtio_device *vdev,
> > > +			      struct virtio_shm_region *region, u8 id)
> > > +{
> > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> > > +	u8 bar;
> > > +	u64 offset, len;
> > > +	phys_addr_t phys_addr;
> > > +	size_t bar_len;
> > > +	int ret;
> > > +
> > > +	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> > > +		return false;
> > > +	}
> > > +
> > > +	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
> > > +	if (ret < 0) {
> > > +		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> > > +			__func__);
> > > +		return false;
> > > +	}
> > > +
> > > +	phys_addr = pci_resource_start(pci_dev, bar);
> > > +	bar_len = pci_resource_len(pci_dev, bar);
> > > +
> > > +        if (offset + len > bar_len) {
> > > +                dev_err(&pci_dev->dev,
> > > +                        "%s: bar shorter than cap offset+len\n",
> > > +                        __func__);
> > > +                return false;
> > > +        }
> > > +
> > 
> > Something wrong with indentation here.
> 
> Will fix all indentation related issues in this patch.
> 
> > Also as long as you are validating things, it's worth checking
> > offset + len does not overflow.
> 
> Something like addition of following lines?
> 
> +       if ((offset + len) < offset) {
> +               dev_err(&pci_dev->dev, "%s: cap offset+len overflow detected\n",
> +                       __func__);
> +               return false;
> +       }
> 
> Vivek

That should do it.

