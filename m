Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E27ABAAF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 16:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394398AbfIFOS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 10:18:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729405AbfIFOS4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:18:56 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7212E83F45
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2019 14:18:56 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id l23so6462155qtp.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 07:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=741o/xQPcgkh8sbSjiFyBn3gsnAEkmJOCIfqfDhtUBo=;
        b=VU6JYDi3+sJBJAqqlidCX31tq40uZG0QbOILlWj1+8TVdFj1tl3bGcoQ6zp0mkOeyJ
         R4rQNYUPQY54ANBhJWRmP58OwCeffuT3sKxilSL2dsAy/PQq+VUXoNKMPNsWHi8JRCNz
         q2a2ArdzN7CuUyxCgQTUYiparT8uVx/ZPXqOK34yElTRCdrCDc9+jYoOvN7cTOb0v/Us
         qtD1J2oP1zAbowKqLLIbM9uTi+gNR+/dJV6EPJZgL0em6U11lUmrb4w0tNGOxCF19ctG
         vWcRVoF1eSKGA3myemyb4Xse9JqjBrpX9h5PUXqlOKR8R93/Uf4hVWFYWRT4TddRA8wZ
         NGag==
X-Gm-Message-State: APjAAAX7d1qp2eUg+jFPtb2PNnZPyvr4zSO/yG8SHiQbQlUkmsmXdtKr
        kb/jnaAfHQ0spyJ2KXGzrSeiTBeh6S7qmHKOc5E0Rxzu184m0uyWjke0Mamo5miB8zoBTAy2jvb
        W/vLxC7IHfU3hY8ikSni3fS4jFw==
X-Received: by 2002:ac8:3195:: with SMTP id h21mr9753402qte.350.1567779535855;
        Fri, 06 Sep 2019 07:18:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxGLpg1Ryu90HpqFQxE1o/aqz1GtskO77HSqagnTOVU8en/4xP+XAgktTlx6GUHLSwh5hScgw==
X-Received: by 2002:ac8:3195:: with SMTP id h21mr9753390qte.350.1567779535712;
        Fri, 06 Sep 2019 07:18:55 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id g12sm2422156qkm.25.2019.09.06.07.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 07:18:54 -0700 (PDT)
Date:   Fri, 6 Sep 2019 10:18:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com
Subject: Re: [PATCH 08/18] virtiofs: Drain all pending requests during
 ->remove time
Message-ID: <20190906101819-mutt-send-email-mst@kernel.org>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-9-vgoyal@redhat.com>
 <20190906105210.GP5900@stefanha-x1.localdomain>
 <20190906141705.GF22083@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906141705.GF22083@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 10:17:05AM -0400, Vivek Goyal wrote:
> On Fri, Sep 06, 2019 at 11:52:10AM +0100, Stefan Hajnoczi wrote:
> > On Thu, Sep 05, 2019 at 03:48:49PM -0400, Vivek Goyal wrote:
> > > +static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
> > > +{
> > > +	WARN_ON(fsvq->in_flight < 0);
> > > +
> > > +	/* Wait for in flight requests to finish.*/
> > > +	while (1) {
> > > +		spin_lock(&fsvq->lock);
> > > +		if (!fsvq->in_flight) {
> > > +			spin_unlock(&fsvq->lock);
> > > +			break;
> > > +		}
> > > +		spin_unlock(&fsvq->lock);
> > > +		usleep_range(1000, 2000);
> > > +	}
> > 
> > I think all contexts that call this allow sleeping so we could avoid
> > usleep here.
> 
> usleep_range() is supposed to be used from non-atomic context.
> 
> https://github.com/torvalds/linux/blob/master/Documentation/timers/timers-howto.rst
> 
> What construct you are thinking of?
> 
> Vivek

completion + signal on vq callback?

-- 
MST
