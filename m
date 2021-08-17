Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C23EE9EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 11:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhHQJdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 05:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235402AbhHQJc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629192739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tXO0rYgdhyeDYBKbOyKfCbfOOPtHG4G1MWXLBg7l68E=;
        b=PzlrqY4BzM/4Y0tHhazPr+/iXxOpEJQo9VUvoxJerkMnUZ6le8fCfz7CE1IZdCNmIcadl2
        P/V/+hGYh+hWxv2sPI9J7+Zo85xyEcZV65qfvVwaXh6woHL+rINVlRWkz87cP5v6Q+BXu2
        5N+eYNZGDyTMWqyKGPFl6Zlo8oCmjAY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-_rVxnm4uM3qkTt60KOw0OA-1; Tue, 17 Aug 2021 05:32:18 -0400
X-MC-Unique: _rVxnm4uM3qkTt60KOw0OA-1
Received: by mail-wm1-f71.google.com with SMTP id o3-20020a05600c510300b002e6dd64e896so699491wms.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 02:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tXO0rYgdhyeDYBKbOyKfCbfOOPtHG4G1MWXLBg7l68E=;
        b=bYAcezjAz1kMPjaaCV2upTTC8mWvwLBO03kZLy/AiUzce3Mv0+tOxYjjtQVOpUEckR
         bpU0tbirXc4ysP0MjY+KkpT3W80h7XsVZeGkUtoq8E9Zt6BAdIAQL1JZ/5Mvk5UDbBC3
         NWq4v5o4iNw8DbZUR051EYqmKnnfDqu8Mk5cOQc9pgjcMNn1YXguEtS4DiXzWKRawziR
         KwQ6HNQiOD079Pv0/GOCQSr8AnsvjXiyvfDpomEgUKuWktPNXk8zhriZ8cLxAik43YhV
         598Yir/5QzW21gxyJ7ojNaU+JmVmg+nwzS2mIhVM5RRUpxPVrVo6tg/oO7XZW+r65MlD
         RenQ==
X-Gm-Message-State: AOAM530887krbnMYOnB3c5f/pXHrFsQwXtYSzDrtS47osCz7Utd5c/Rj
        gS2uxmdvFf6TIiA2vBqE43C2sO04RBDWfbRTlV/iCKL7GGuEkmTWZPCyZgcq0sRt0C1ESU/ztJI
        UtjscnDqTxBfSh7zHsrv1soQanw==
X-Received: by 2002:a1c:1f17:: with SMTP id f23mr2445349wmf.136.1629192737020;
        Tue, 17 Aug 2021 02:32:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZebtc9nXfqDyMD/ZWMOGBaaLkmeU7uLr7GiJexUrvciVWIfZqrerPJXKpkvUSOmHuGSxz7w==
X-Received: by 2002:a1c:1f17:: with SMTP id f23mr2445334wmf.136.1629192736834;
        Tue, 17 Aug 2021 02:32:16 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id e25sm2097816wra.90.2021.08.17.02.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 02:32:16 -0700 (PDT)
Date:   Tue, 17 Aug 2021 10:32:14 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Message-ID: <YRuCHvhICtTzMK04@work-vm>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Miklos Szeredi (miklos@szeredi.hu) wrote:
> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> >
> > This patchset adds support of per-file DAX for virtiofs, which is
> > inspired by Ira Weiny's work on ext4[1] and xfs[2].
> 
> Can you please explain the background of this change in detail?
> 
> Why would an admin want to enable DAX for a particular virtiofs file
> and not for others?

Where we're contending on virtiofs dax cache size it makes a lot of
sense; it's quite expensive for us to map something into the cache
(especially if we push something else out), so selectively DAXing files
that are expected to be hot could help reduce cache churn.

Dave

> Thanks,
> Miklos
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://listman.redhat.com/mailman/listinfo/virtio-fs
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

