Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2831DAB665
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 12:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfIFKwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 06:52:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfIFKwR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:52:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8532800DD4;
        Fri,  6 Sep 2019 10:52:16 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C21C460BF1;
        Fri,  6 Sep 2019 10:52:11 +0000 (UTC)
Date:   Fri, 6 Sep 2019 11:52:10 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 08/18] virtiofs: Drain all pending requests during
 ->remove time
Message-ID: <20190906105210.GP5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-9-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4IFtMBbmeqbTM/ox"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-9-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 06 Sep 2019 10:52:16 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--4IFtMBbmeqbTM/ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2019 at 03:48:49PM -0400, Vivek Goyal wrote:
> +static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
> +{
> +	WARN_ON(fsvq->in_flight < 0);
> +
> +	/* Wait for in flight requests to finish.*/
> +	while (1) {
> +		spin_lock(&fsvq->lock);
> +		if (!fsvq->in_flight) {
> +			spin_unlock(&fsvq->lock);
> +			break;
> +		}
> +		spin_unlock(&fsvq->lock);
> +		usleep_range(1000, 2000);
> +	}

I think all contexts that call this allow sleeping so we could avoid
usleep here.

--4IFtMBbmeqbTM/ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yOloACgkQnKSrs4Gr
c8gmeQgAoJQJeQAjTj+aeNGzBdb4oLsqKKM6Q+4z3dqyaIM7pOTsdgiPZ/q1DA5U
3/e2c4UFDTEg+r9xvEx5FFgBiPFrpwGU3N8mroPEUY9yueCllNsIZmS0y8n76YDb
dCAPCksGMF4o9AWlHAMnxFoao+EfbsJd1mNU/7f7hFqFQoAuCu64321mwhqtOO+V
PXUqk6wTZtWxPAzvZCO93D4DuUfrW7jzHRNyvCvgPiJLCTU43uptr1PDJKuDCxAp
Sqpb5jJevhxuwbc84hIEnKY/0ERKxjky+XWBsHHc1Yy/CWAdNCyU0tW8OuUaG5+k
FF9UbW4BK3wqyzMhWOd/4jDbTz6oyA==
=x8L/
-----END PGP SIGNATURE-----

--4IFtMBbmeqbTM/ox--
