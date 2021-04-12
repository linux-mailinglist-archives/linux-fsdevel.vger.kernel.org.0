Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B4835B8A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 04:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbhDLC3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Apr 2021 22:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbhDLC3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Apr 2021 22:29:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE4DC061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Apr 2021 19:29:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id v6so16421076ejo.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Apr 2021 19:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RNEjN/ct/FlkAjQi8rxJdheGa8bmvu02xXB4l37nwrM=;
        b=FOz39AKcwplpKJyNx0NIPW0Qxx9GVSOkwmlSdFoFsCH4j1cMdNLHaRawZ52t/qxPyA
         uRI/OLp6ye/jxoXRngG0ot6XzrrDRkX8G181xgNr9q+Qj9TQC2cUxE9ovmOCW4OeOkM8
         Its9N6KOffR/umh46UiBZFyiWaY3ovaBva0EmJ4s7Pz7DKuivQ5oWmcfMlH5obQ96c+O
         BRxB0t8bKhfcqscoMuS0Cq5YTtM8KIwgyjQuihPeXQBREqe/FaqEZUAXc28nZxZKeHyW
         /x15g2Arxlg2o0kblb40UGUZNNTHsPLHSqOinxpg+HRF4/wWFAVjj498Xh0oZ6ihxYwi
         W08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RNEjN/ct/FlkAjQi8rxJdheGa8bmvu02xXB4l37nwrM=;
        b=bdhDN4gJLmacdvuKTP5B/ZfJ3W2+Wt9sB9n8D/cho8Rrw/UYYMqjTMQ/XwGIzSC1JU
         nSYnIbeqVoqiXPXhWmvWrfN4OOPg9Y+B7WjTRbwRkp9tklqqh76IDqGKtS948xUToTzL
         ouQWecrys40Xz22OTrto1eHFVtImIpEECElYlH1GShfzsKpOpVYMbUfwqDVXWt/U6L3q
         9Gz8Kusf2WD9SbY1pLfWbSScBIXJGzrn1J0v9DB/yVnKxvUrnRCOjU8663GPVCwG9FIb
         pTIusNKvF/J7ZT8sz3fQEDloZK708C2ye90UNfTfa0Y//T03FLCwWaFoUqY/SHCxXdXe
         whkw==
X-Gm-Message-State: AOAM5304kvOwPj/50VBuV4PZt14lrvGlOel6+vr/weVmMklwC8GMBUVq
        aQo764fyfiWSHi2etG6q6FIlQZUK6WTXZMhT8EUB
X-Google-Smtp-Source: ABdhPJxsEWMEf+3c5imH4BOsI4c2n9Tx4Ooniap6LM5Dzuj+RFXLE4f8MQRKB4x8AJfTTB6zP7v1eB9FhSaVEo8mNJo=
X-Received: by 2002:a17:906:af5a:: with SMTP id ly26mr34077ejb.372.1618194568020;
 Sun, 11 Apr 2021 19:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210331080519.172-1-xieyongji@bytedance.com> <20210331080519.172-4-xieyongji@bytedance.com>
 <20210409121512-mutt-send-email-mst@kernel.org> <CACycT3tPWwpGBNEqiL4NPrwGZhmUtAVHUZMOdbSHzjhN-ytg_A@mail.gmail.com>
 <20210411164827-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210411164827-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 12 Apr 2021 10:29:17 +0800
Message-ID: <CACycT3v5Z8s9_pL79m0FY5jxx3fTRHHbtARfg0On3xTnNCOdkg@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v6 03/10] vhost-vdpa: protect concurrent access to
 vhost device iotlb
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 12, 2021 at 4:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Apr 11, 2021 at 01:36:18PM +0800, Yongji Xie wrote:
> > On Sat, Apr 10, 2021 at 12:16 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Mar 31, 2021 at 04:05:12PM +0800, Xie Yongji wrote:
> > > > Use vhost_dev->mutex to protect vhost device iotlb from
> > > > concurrent access.
> > > >
> > > > Fixes: 4c8cf318("vhost: introduce vDPA-based backend")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > > I could not figure out whether there's a bug there now.
> > > If yes when is the concurrent access triggered?
> > >
> >
> > When userspace sends the VHOST_IOTLB_MSG_V2 message concurrently?
> >
> > vhost_vdpa_chr_write_iter -> vhost_chr_write_iter ->
> > vhost_vdpa_process_iotlb_msg()
> >
> > Thanks,
> > Yongji
>
> And then what happens currently?
>

Then we might access vhost_vdpa_map() concurrently and cause
corruption of the list and interval tree in struct vhost_iotlb.

Thanks,
Yongji
