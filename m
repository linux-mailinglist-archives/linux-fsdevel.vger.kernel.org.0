Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6985AABA11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 15:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393536AbfIFN5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 09:57:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbfIFN5g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:57:36 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63A30C05AA6A
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2019 13:57:35 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id q12so6464846qkm.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 06:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tvOYoeurVEmYtOK8IHP/SsbTbDLRv0QLwd4LI9xguBI=;
        b=E5N14rI0v2LzZYqlf/rOODyLiHQVFEidMvvgehV9MPCTgfCCfNZK/anKuVRUf+rebh
         bDPG4y/eKGcW0h+l262Zh+/WsuMbItbvIMmXoYQexvHS0P6a53r2wXHt31dbGWzpbJou
         tX96iBGMJSAPjFiLzYLB5Fk3W4zPcMZv3Rs5KLScCLEQmfQ7zWbXiqnY47G9WSy5p1Ry
         qsad47hvwn7Ajay2N3aoE63VbIK1o/e2gT6i8DBK2R6E+xwcASSr41p8qHlDz0nUKg7q
         Jcb3hfl0UFj83e6i03Vi6vYwzLF9cyLO23LC2HZWPnvXwtO8vR5/47jPVX1sJRUP24QZ
         VsIA==
X-Gm-Message-State: APjAAAXPLKyglV/phlQx7DGptSQT6EBnZH+lQ5kkhAY4fpPlhfEsWFt1
        l8cqmcozjHCVopsSWW2azReqZ6gwAk6G4UYvMuFz/P+x+ndFkF6w0bn/B4uPQI4T8wYD6QLiyOk
        KKV9nY8fbh/OvlhPmiMqPT0/U3Q==
X-Received: by 2002:ac8:1793:: with SMTP id o19mr9128632qtj.64.1567778254728;
        Fri, 06 Sep 2019 06:57:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZc49QnyXzg0nyuLIbTlHLkfvD93+v8Ae4jU42P20db23h2fLY0IYcXZVIrHdUZq3he+/hHw==
X-Received: by 2002:ac8:1793:: with SMTP id o19mr9128572qtj.64.1567778253776;
        Fri, 06 Sep 2019 06:57:33 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id b16sm3231741qtk.65.2019.09.06.06.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 06:57:33 -0700 (PDT)
Date:   Fri, 6 Sep 2019 09:57:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
Message-ID: <20190906095428-mutt-send-email-mst@kernel.org>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
 <20190906103613.GH5900@stefanha-x1.localdomain>
 <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
 <20190906120817.GA22083@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906120817.GA22083@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 08:08:17AM -0400, Vivek Goyal wrote:
> On Fri, Sep 06, 2019 at 01:52:41PM +0200, Miklos Szeredi wrote:
> > On Fri, Sep 6, 2019 at 12:36 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Fri, Sep 06, 2019 at 10:15:14AM +0200, Miklos Szeredi wrote:
> > > > On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Michael Tsirkin pointed out issues w.r.t various locking related TODO
> > > > > items and races w.r.t device removal.
> > > > >
> > > > > In this first round of cleanups, I have taken care of most pressing
> > > > > issues.
> > > > >
> > > > > These patches apply on top of following.
> > > > >
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
> > > > >
> > > > > I have tested these patches with mount/umount and device removal using
> > > > > qemu monitor. For example.
> > > >
> > > > Is device removal mandatory?  Can't this be made a non-removable
> > > > device?  Is there a good reason why removing the virtio-fs device
> > > > makes sense?
> > >
> > > Hot plugging and unplugging virtio PCI adapters is common.  I'd very
> > > much like removal to work from the beginning.
> > 
> > Can you give an example use case?
> 
> David Gilbert mentioned this could be useful if daemon stops responding
> or dies. One could remove device. That will fail all future requests
> and allow unmounting filesystem.
> 
> Havind said that, current implementation will help in above situation
> only if there are no pending requests. If there are pending requests
> and daemon stops responding, then removal will hang too, as we wait
> for draining the queues.
> 
> So at some point of time, we also need some sort of timeout functionality
> where we end requests with error after a timeout.
> 
> I feel we should support removing device at some point of time. But its
> not necessarily a must have feature for first round.
> 
> Thanks
> Vivek

Without removal how do we stop guest poking at some files if we want to?

I guess we could invent a special event to block accesses,
but unplug will just do it.

blk and scsi support removal out of box, if this is supposed
to be a drop in replacement then I think yes, you want this
support.

-- 
MST
