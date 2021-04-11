Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3219835B6EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Apr 2021 22:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbhDKUtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Apr 2021 16:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32244 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236564AbhDKUtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Apr 2021 16:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618174139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WgCMOQWQVsoo18S8HwQ+Un6/4nDLRTxeG+tZrHLLzJw=;
        b=UfC9crSFSuuYbsN1A/qijOun3yFupTwSioxSXx/+sU/DemIpZE63zr/BP7/3asAmWcjy32
        aAxsCdx0akEThVNI1HeC7OWiuMpNqLxerdgiZGGosw8b1lGTxwsuCAgLbRVICCL79H67Bw
        uH15+9gf+S3WBo5Vjnia+DtiDGQaUX0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-4kHXBvDHMUKNdaiLdGdxOg-1; Sun, 11 Apr 2021 16:48:58 -0400
X-MC-Unique: 4kHXBvDHMUKNdaiLdGdxOg-1
Received: by mail-wr1-f72.google.com with SMTP id j4so5131464wru.20
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Apr 2021 13:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WgCMOQWQVsoo18S8HwQ+Un6/4nDLRTxeG+tZrHLLzJw=;
        b=hj64T9XW4novBrV3caGRSzrtzGcqLll/VsI5DTB9xJX8AlwYa1I5S1wVQijUgpKIiU
         cwa9cVZuTEy9Lwlv9a3Z85NKfdXF+sf/VM8V4OkTXJZ8sHcGTcf8Dv6/AU34n/JhyaAh
         ShCL/2ZtuTuXzf1no7xrCs/mO225Eg9+whQnh1xPnf6SPxuNQl83WVuz9SQN7sx8uOsd
         Zgm9tWtRjtte91y++L8gnxHzE6qe8N7aQqoiy8CW6sjEvZk07f+eBPC2u53t//2jPReo
         bgPcTym4v53YHE6ukLhHSlDmJBypgnR5kcvu+Qk3bzW3DMg5at3SENCyfjouFssTdZEI
         bfHQ==
X-Gm-Message-State: AOAM530jL0w8nEXvxHij8zT4kqgX6laDOaso5KQLrDxJ2J84C1SegjUV
        d54eWMzlRKfK0i2Im7JunO1CtyYtqoL5ZCyPZIDKSFFuQxafF7ZFkFqqhSooxhCgCRTyz+3syQN
        SIAt7o+sOaGMXCjuAVK23/FE3Ww==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr12219243wrp.266.1618174137327;
        Sun, 11 Apr 2021 13:48:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ8f1z7+lBgJ+qTQWMzJhdvfvlDPXwnCbDDkLtc7bGWr9KZU5tbgznyW47X/5g4qaJepDMnQ==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr12219231wrp.266.1618174137201;
        Sun, 11 Apr 2021 13:48:57 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
        by smtp.gmail.com with ESMTPSA id a8sm15566507wrh.91.2021.04.11.13.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 13:48:56 -0700 (PDT)
Date:   Sun, 11 Apr 2021 16:48:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Re: [PATCH v6 03/10] vhost-vdpa: protect concurrent access to
 vhost device iotlb
Message-ID: <20210411164827-mutt-send-email-mst@kernel.org>
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-4-xieyongji@bytedance.com>
 <20210409121512-mutt-send-email-mst@kernel.org>
 <CACycT3tPWwpGBNEqiL4NPrwGZhmUtAVHUZMOdbSHzjhN-ytg_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3tPWwpGBNEqiL4NPrwGZhmUtAVHUZMOdbSHzjhN-ytg_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 11, 2021 at 01:36:18PM +0800, Yongji Xie wrote:
> On Sat, Apr 10, 2021 at 12:16 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Mar 31, 2021 at 04:05:12PM +0800, Xie Yongji wrote:
> > > Use vhost_dev->mutex to protect vhost device iotlb from
> > > concurrent access.
> > >
> > > Fixes: 4c8cf318("vhost: introduce vDPA-based backend")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >
> > I could not figure out whether there's a bug there now.
> > If yes when is the concurrent access triggered?
> >
> 
> When userspace sends the VHOST_IOTLB_MSG_V2 message concurrently?
> 
> vhost_vdpa_chr_write_iter -> vhost_chr_write_iter ->
> vhost_vdpa_process_iotlb_msg()
> 
> Thanks,
> Yongji

And then what happens currently?

-- 
MST

