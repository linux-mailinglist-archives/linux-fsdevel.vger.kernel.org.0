Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9EBCABA92
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394189AbfIFORR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 10:17:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394071AbfIFORQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:17:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9DD910F23F8;
        Fri,  6 Sep 2019 14:17:16 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EE185D9D3;
        Fri,  6 Sep 2019 14:17:06 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 95BB4220292; Fri,  6 Sep 2019 10:17:05 -0400 (EDT)
Date:   Fri, 6 Sep 2019 10:17:05 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 08/18] virtiofs: Drain all pending requests during
 ->remove time
Message-ID: <20190906141705.GF22083@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-9-vgoyal@redhat.com>
 <20190906105210.GP5900@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906105210.GP5900@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Fri, 06 Sep 2019 14:17:16 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 11:52:10AM +0100, Stefan Hajnoczi wrote:
> On Thu, Sep 05, 2019 at 03:48:49PM -0400, Vivek Goyal wrote:
> > +static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
> > +{
> > +	WARN_ON(fsvq->in_flight < 0);
> > +
> > +	/* Wait for in flight requests to finish.*/
> > +	while (1) {
> > +		spin_lock(&fsvq->lock);
> > +		if (!fsvq->in_flight) {
> > +			spin_unlock(&fsvq->lock);
> > +			break;
> > +		}
> > +		spin_unlock(&fsvq->lock);
> > +		usleep_range(1000, 2000);
> > +	}
> 
> I think all contexts that call this allow sleeping so we could avoid
> usleep here.

usleep_range() is supposed to be used from non-atomic context.

https://github.com/torvalds/linux/blob/master/Documentation/timers/timers-howto.rst

What construct you are thinking of?

Vivek
