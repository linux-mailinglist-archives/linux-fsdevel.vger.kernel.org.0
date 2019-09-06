Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A516AB79F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 14:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389793AbfIFMAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 08:00:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388384AbfIFMAr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:00:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0952E18C4279;
        Fri,  6 Sep 2019 12:00:46 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49891611DE;
        Fri,  6 Sep 2019 12:00:10 +0000 (UTC)
Date:   Fri, 6 Sep 2019 13:00:09 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 14/18] virtiofs: Add a fuse_iqueue operation to put()
 reference
Message-ID: <20190906120009.GV5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-15-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OlucDFihBVSxvK/7"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-15-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 06 Sep 2019 12:00:47 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--OlucDFihBVSxvK/7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2019 at 03:48:55PM -0400, Vivek Goyal wrote:
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 85e2dcad68c1..04e2c000d63f 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -479,6 +479,11 @@ struct fuse_iqueue_ops {
>  	 */
>  	void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq)
>  		__releases(fiq->waitq.lock);
> +
> +	/**
> +	 * Put a reference on fiq_priv.

I'm a bit confused about fiq->priv's role in this.  The callback takes
struct fuse_iqueue *fiq as the argument, not void *priv, so it could
theoretically do more than just release priv.

I think one of the following would be clearer:

 /**
  * Drop a reference to fiq->priv.
  */
 void (*put_priv)(void *priv);

Or:

 /**
  * Clean up when fuse_iqueue is destroyed.
  */
 void (*release)(struct fuse_iqueue *fiq);

In the second case fuse_conn_put() shouldn't check fiq->priv.

--OlucDFihBVSxvK/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ySkkACgkQnKSrs4Gr
c8ivNAf+NYLja/k2E1pzgRX+58rLDkzT6qfQX2XKwJVUqTns/MMKaTPd/OJkf+hW
4ubt3/0sb0kFtAsyffCUY7NiLFRWbanKCEZzP1RLN/ciK2l6bGJldM5TCC0AjMXi
waisC1VR9iopyR8dEIZpZZykVQEjY2CF2UvUJwzCBph382sQM25+a6OpUQ8N2FSI
7/7VMBVILOpdeBDum2QijFCXREuqvk0Si2Kg47nTq+muuOCD/mrGg7byV/pWPvyY
2l3YzL/W0S03phxm8SlNegD0jQ9nr8po2bcY1coriYMz6WSqxDbBwmbb9Izr3aXD
phrdP6+MgQk6AvUlXsmFd/yzwtYC4Q==
=lftV
-----END PGP SIGNATURE-----

--OlucDFihBVSxvK/7--
