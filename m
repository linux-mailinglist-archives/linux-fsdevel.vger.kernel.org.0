Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C0DADCED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 18:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbfIIQSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 12:18:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388828AbfIIQSV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:18:21 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87B89155DB
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2019 16:18:21 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id t26so16971360qkt.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 09:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xd5J0j1O8RM23sIIIj9h2xCJg8OqHfg7OWxpv2iexsc=;
        b=nqmr2ChURNValWE59O90cwF7CRoCCwijyx3xqJj0RbAud5v6M6gZiSB3ixuArwBFPv
         JfeYhPvKzoHrxRa3737keER/aEqb7vz30ZBBKmgYnbtzEj6HChW+WAJOKsu9xox9Nwp7
         R7FUeshMQEfXWP4rsGQwCmOs2nsitdbJ6tzCooDS4IL8c0w9+eJdvueYxyvStCX5Eqp/
         uk0IGeO/5LoyHAie0DSVXHVzwQfJULUEwlHb84tsDM7UMglEwywJioJ38vkl2/WA0MKA
         msEijPq3jPq+BN50/LvCqOX670QNN4iz2Jn0t1zXKzLUpAgIfw5xE1rHRj8cY4meZvDm
         lQPg==
X-Gm-Message-State: APjAAAVSj8BANpSgt9E323TrFx1JC0oif752DDpEZ25+JKOD7sdxm2vB
        Lb4sW/bfoVJXAbDDM39XeBanRUczKH68815I+h928mHtJ5/cyIn5zAT7Ps4hK1JRS9bvVLKPl8Z
        essLwEYT6kpVVDNBfmcwytvZWzA==
X-Received: by 2002:aed:316d:: with SMTP id 100mr442786qtg.20.1568045900873;
        Mon, 09 Sep 2019 09:18:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxvZ3BxEyb3pt+fbqjr5qKBJvhxJopIJiuMLcQ+RPNA0muqjQbM1NQBmU9ZKN8evHR3WQQZoA==
X-Received: by 2002:aed:316d:: with SMTP id 100mr442761qtg.20.1568045900648;
        Mon, 09 Sep 2019 09:18:20 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
        by smtp.gmail.com with ESMTPSA id c14sm8927771qta.80.2019.09.09.09.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 09:18:19 -0700 (PDT)
Date:   Mon, 9 Sep 2019 12:18:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     piaojun <piaojun@huawei.com>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 00/18] virtiofs: Fix various races and
 cleanups round 1
Message-ID: <20190909121604-mutt-send-email-mst@kernel.org>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
 <20190906103613.GH5900@stefanha-x1.localdomain>
 <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
 <866a1469-2c4b-59ce-cf3f-32f65e861b99@huawei.com>
 <20190909161455.GG20875@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909161455.GG20875@stefanha-x1.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 06:14:55PM +0200, Stefan Hajnoczi wrote:
> On Sun, Sep 08, 2019 at 07:53:55PM +0800, piaojun wrote:
> > 
> > 
> > On 2019/9/6 19:52, Miklos Szeredi wrote:
> > > On Fri, Sep 6, 2019 at 12:36 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >>
> > >> On Fri, Sep 06, 2019 at 10:15:14AM +0200, Miklos Szeredi wrote:
> > >>> On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >>>>
> > >>>> Hi,
> > >>>>
> > >>>> Michael Tsirkin pointed out issues w.r.t various locking related TODO
> > >>>> items and races w.r.t device removal.
> > >>>>
> > >>>> In this first round of cleanups, I have taken care of most pressing
> > >>>> issues.
> > >>>>
> > >>>> These patches apply on top of following.
> > >>>>
> > >>>> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
> > >>>>
> > >>>> I have tested these patches with mount/umount and device removal using
> > >>>> qemu monitor. For example.
> > >>>
> > >>> Is device removal mandatory?  Can't this be made a non-removable
> > >>> device?  Is there a good reason why removing the virtio-fs device
> > >>> makes sense?
> > >>
> > >> Hot plugging and unplugging virtio PCI adapters is common.  I'd very
> > >> much like removal to work from the beginning.
> > > 
> > > Can you give an example use case?
> > 
> > I think VirtFS migration need hot plugging, or it may cause QEMU crash
> > or some problems.
> 
> Live migration is currently unsupported.  Hot unplugging the virtio-fs
> device would allow the guest to live migrate successfully, so it's a
> useful feature to work around the missing live migration support.
> 
> Is this what you mean?
> 
> Stefan

Exactly. That's what I also said. To add to that, hotplug can not be
negotiated, so it's not a feature we can easily add down the road if old
guests crash on unplug. Thus a driver that does not support unplug
should not claim to support removal.

-- 
MST
