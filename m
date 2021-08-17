Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338433EEB15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 12:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbhHQKiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 06:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239626AbhHQKiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629196647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ylAqgdbrJZr9xkOSrjkKyy1IPEuT4QXdJGcAzYJ78VY=;
        b=AfvsdU6/2eKODMt5tuQvd2SCtr7AoPbhHzFOQhMWCM0wAya25nfvRP6EctHErpAqm6YUrc
        Kq4hAgM4EiqT3gW92ctMyWgRfPjdaB14fgXqroezu9A8Iu+fI7gpFEwIjN1NYDdMUaH6PJ
        IrUECp1RmnbpSCs+GozfnjbNriPAmPU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-ZXZvlXJDMdSAjUcxsclrqQ-1; Tue, 17 Aug 2021 06:37:24 -0400
X-MC-Unique: ZXZvlXJDMdSAjUcxsclrqQ-1
Received: by mail-wr1-f71.google.com with SMTP id h24-20020adfa4d8000000b00156d9931072so739254wrb.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 03:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ylAqgdbrJZr9xkOSrjkKyy1IPEuT4QXdJGcAzYJ78VY=;
        b=QReLoLGqKDxZBKtZVDJrfyAdUawpjovt7pPEPKJILu4F4LByMPXqn6rY/87kUbI3RN
         ypeg+5D/WWhp3ged7w88SDsHQCHe1Wi+TKIpJNukpkv2N/pv2MoxSEYAVoMtm4I8w1Er
         IfZIMQDGyDl1ohe4xvlHyC8YQqit9v+WcwASj3G+TRF0kSA+dHSl/wiH/cwfDZkNeUsg
         c4iSsS6EmhLY1hgGwHWsftjpREWwHxIcsqjoZCg5JGjs2zMEBIKwc5rZecMR4Xl3N6nl
         DAhmljDgFu5ZScUMdS9Zz8AV9rVIPitr2ys4/AwedWKnYs6q9FEgfrFo7xhlrVeCZM2D
         U0Qg==
X-Gm-Message-State: AOAM532HgXiiGpnhbbaqk6fAHcGmRDRaJYk3z/jDq4QB/0GxuUza/5sf
        i2WsfkumrgK2ggF9uy2SeQFpD2SWtwonEGozvRIuBavBioGNY2GpsMYkr/IQpHi2vmPrTeqTlex
        cZsfG0tlZ43RLYKe8Eo0autvKHQ==
X-Received: by 2002:a5d:4808:: with SMTP id l8mr3194586wrq.349.1629196643828;
        Tue, 17 Aug 2021 03:37:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIw4MIhbeuweeJtzdTPOXRFRTTdHSmvBxHZb0P4/fi6Kf+/mQJrX0KPtKDSsy4idKQTTiLcg==
X-Received: by 2002:a5d:4808:: with SMTP id l8mr3194578wrq.349.1629196643725;
        Tue, 17 Aug 2021 03:37:23 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id p14sm2022341wro.3.2021.08.17.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 03:37:22 -0700 (PDT)
Date:   Tue, 17 Aug 2021 11:37:20 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Message-ID: <YRuRYJ2+hOa704sS@work-vm>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm>
 <CAJfpegvM+S5Xru3Yfc88C64mecvco=f99y-TajQBDfkLD-S8zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvM+S5Xru3Yfc88C64mecvco=f99y-TajQBDfkLD-S8zQ@mail.gmail.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Miklos Szeredi (miklos@szeredi.hu) wrote:
> On Tue, 17 Aug 2021 at 11:32, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Miklos Szeredi (miklos@szeredi.hu) wrote:
> > > On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> > > >
> > > > This patchset adds support of per-file DAX for virtiofs, which is
> > > > inspired by Ira Weiny's work on ext4[1] and xfs[2].
> > >
> > > Can you please explain the background of this change in detail?
> > >
> > > Why would an admin want to enable DAX for a particular virtiofs file
> > > and not for others?
> >
> > Where we're contending on virtiofs dax cache size it makes a lot of
> > sense; it's quite expensive for us to map something into the cache
> > (especially if we push something else out), so selectively DAXing files
> > that are expected to be hot could help reduce cache churn.
> 
> If this is a performance issue, it should be fixed in a way that
> doesn't require hand tuning like you suggest, I think.

I'd agree that would be nice; however:
  a) It looks like other filesystems already gave something admin
selectable
  b) Trying to write clever heuristics is only going to work in some
cases; being able to say 'DAX this directory' might work better in
practice.

> I'm not sure what the  ext4/xfs case for per-file DAX is.  Maybe that
> can help understand the virtiofs case as well.

Yep, I don't understand the case with real nvdimm hardware.

Dave

> Thanks,
> Miklos
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

