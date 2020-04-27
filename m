Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16281BA7C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 17:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgD0PT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 11:19:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49945 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgD0PT7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588000798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7/66I/9TwxV9k1UmpZsmOmuoZn3+FHyc6a+ny5vrCT8=;
        b=HGY61h15MPGMXWebjhp1kUeLk1ROeLbM32up/oXIb6qiudbjxsEzgpCPAjXDijySbceCNG
        NN4QppxEoAgQnPhhxFrTwmRM5vdHWKMOeSNJP1qwwVpGs2LNu3y1c8ZDoVb3szxNMNzDq2
        +kKC9ZBD67RriQ/IirVRwo2vaKHWm7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-57TEpnw4OjiYUJQ90_v0qw-1; Mon, 27 Apr 2020 11:19:42 -0400
X-MC-Unique: 57TEpnw4OjiYUJQ90_v0qw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E9AA835B40;
        Mon, 27 Apr 2020 15:19:40 +0000 (UTC)
Received: from localhost (ovpn-114-226.ams2.redhat.com [10.36.114.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AE3860BEC;
        Mon, 27 Apr 2020 15:19:34 +0000 (UTC)
Date:   Mon, 27 Apr 2020 16:19:34 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>, slp@redhat.com
Subject: Re: [PATCH 2/2] fuse: virtiofs: Add basic multiqueue support
Message-ID: <20200427151934.GB1042399@stefanha-x1.localdomain>
References: <20200424062540.23679-1-chirantan@chromium.org>
 <20200424062540.23679-2-chirantan@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200424062540.23679-2-chirantan@chromium.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2020 at 03:25:40PM +0900, Chirantan Ekbote wrote:
> Use simple round-robin scheduling based on the `unique` field of the
> fuse request to spread requests across multiple queues, if supported by
> the device.

Multiqueue is not intended to be used this way and this patch will
reduce performance*.  I don't think it should be merged.

* I know it increases performance for you :) but hear me out:

The purpose of multiqueue is for SMP scalability.  It allows queues to
be processed with CPU/NUMA affinity to the vCPU that submitted the
request (i.e. the virtqueue processing thread runs on a sibling physical
CPU core).  Each queue has its own MSI-X interrupt so that completion
interrupts can be processed on the same vCPU that submitted the request.

Spreading requests across queues defeats all this.  Virtqueue processing
threads that are located in the wrong place will now process the
requests.  Completion interrupts will wake up a vCPU that did not submit
the request and IPIs are necessary to notify the vCPU that originally
submitted the request.

Even if you don't care about SMP performance, using multiqueue as a
workaround for missing request parallelism still won't yield the best
results.  The guest should be able to submit up to the maximum queue
depth of the physical storage device.  Many Linux block drivers have max
queue depths of 64.  This would require 64 virtqueues (plus the queue
selection algorithm would have to utilize each one) and shows how
wasteful this approach is.

Instead of modifying the guest driver, please implement request
parallelism in your device implementation.  Device implementations
should pop a virtqueue element, submit I/O, and then move on to the next
virtqueue element instead of waiting for the I/O to complete.  This can
be done with a thread pool, coroutines, async I/O APIs, etc.

The C implementation of virtiofsd has request parallelism and there is
work underway to do it in Rust for cloud-hypervisor too.  Perhaps you
can try the cloud-hypervisor code, I have CCed Sergio Lopez?

Thanks,
Stefan

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6m+AUACgkQnKSrs4Gr
c8imWgf/V4XVxd+mfF/0LjS2cGvQJD+RnPu9weUhvBRIq/vNdeEeD0iGNWNIL/hM
YGnuLcWnkk02/Lx9riaHVyiM8/Qbn5mCy2O3akAzPAZOQNeDu8fR6Dz0yYONPNVy
eQ+oN1/GHAN5TJ43UcFLs61Cp9UQkko+5Rx5EcxL43UULGILYpN8SyfwidO+YhBm
6i2IqsQop/T7D4t5VLSZvXSvBtua4xDmFkQm4NHiA1yB3Se+q8MBpiRWTLbtrZVY
v5DInOiMEBIY7owjC1iD8Knx0HQpjZzDMxhqnC9hMTgC8of1BvzWdxIQk6zYGsXq
WBaI4wD39nIanroTQVExKX5F8H1wPg==
=MjR+
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--

