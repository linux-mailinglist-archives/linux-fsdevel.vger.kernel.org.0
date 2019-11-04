Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CFDEE3C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 16:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfKDP3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 10:29:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38572 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727796AbfKDP3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572881387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnIpPAsEfh3l+jictAmtLN7RDDQx739S6dh9HTHu7Ag=;
        b=ie/dLgppUpTE/n3lxN1PyWQtB7Kn4dEzh7GpKoMgyF2gtoXCSMY9o+lJ1Ffi8YIFm4qLU6
        wHN57ZVrlHoxrvQoWIxdsYuN17tEIPxwA4gM2OcmXn/grn4TAN5Y8avIYWN/RhCHRijFPD
        kjyI+XrX6esgFUSMl9qFxiWdGQKI67c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-PWExnVQ_PW6blTwMdJIEhg-1; Mon, 04 Nov 2019 10:29:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69C77800C73;
        Mon,  4 Nov 2019 15:29:41 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7A925D6C5;
        Mon,  4 Nov 2019 15:29:40 +0000 (UTC)
Date:   Mon, 4 Nov 2019 10:29:39 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/28] mm: factor shrinker work calculations
Message-ID: <20191104152939.GB10665@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-12-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-12-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: PWExnVQ_PW6blTwMdJIEhg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:01AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> Start to clean up the shrinker code by factoring out the calculation
> that determines how much work to do. This separates the calculation
> from clamping and other adjustments that are done before the
> shrinker work is run. Document the scan batch size calculation
> better while we are there.
>=20
> Also convert the calculation for the amount of work to be done to
> use 64 bit logic so we don't have to keep jumping through hoops to
> keep calculations within 32 bits on 32 bit systems.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

I assume the kbuild warning thing will be fixed up...

>  mm/vmscan.c | 97 ++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 70 insertions(+), 27 deletions(-)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a215d71d9d4b..2d39ec37c04d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -459,13 +459,68 @@ EXPORT_SYMBOL(unregister_shrinker);
> =20
>  #define SHRINK_BATCH 128
> =20
> +/*
> + * Calculate the number of new objects to scan this time around. Return
> + * the work to be done. If there are freeable objects, return that numbe=
r in
> + * @freeable_objects.
> + */
> +static int64_t shrink_scan_count(struct shrink_control *shrinkctl,
> +=09=09=09    struct shrinker *shrinker, int priority,
> +=09=09=09    int64_t *freeable_objects)
> +{
> +=09int64_t delta;
> +=09int64_t freeable;
> +
> +=09freeable =3D shrinker->count_objects(shrinker, shrinkctl);
> +=09if (freeable =3D=3D 0 || freeable =3D=3D SHRINK_EMPTY)
> +=09=09return freeable;
> +
> +=09if (shrinker->seeks) {
> +=09=09/*
> +=09=09 * shrinker->seeks is a measure of how much IO is required to
> +=09=09 * reinstantiate the object in memory. The default value is 2
> +=09=09 * which is typical for a cold inode requiring a directory read
> +=09=09 * and an inode read to re-instantiate.
> +=09=09 *
> +=09=09 * The scan batch size is defined by the shrinker priority, but
> +=09=09 * to be able to bias the reclaim we increase the default batch
> +=09=09 * size by 4. Hence we end up with a scan batch multipler that
> +=09=09 * scales like so:
> +=09=09 *
> +=09=09 * ->seeks=09scan batch multiplier
> +=09=09 *    1=09=09      4.00x
> +=09=09 *    2               2.00x
> +=09=09 *    3               1.33x
> +=09=09 *    4               1.00x
> +=09=09 *    8               0.50x
> +=09=09 *
> +=09=09 * IOWs, the more seeks it takes to pull the item into cache,
> +=09=09 * the smaller the reclaim scan batch. Hence we put more reclaim
> +=09=09 * pressure on caches that are fast to repopulate and to keep a
> +=09=09 * rough balance between caches that have different costs.
> +=09=09 */
> +=09=09delta =3D freeable >> (priority - 2);

Does anything prevent priority < 2 here?

> +=09=09do_div(delta, shrinker->seeks);
> +=09} else {
> +=09=09/*
> +=09=09 * These objects don't require any IO to create. Trim them
> +=09=09 * aggressively under memory pressure to keep them from causing
> +=09=09 * refetches in the IO caches.
> +=09=09 */
> +=09=09delta =3D freeable / 2;
> +=09}
> +
> +=09*freeable_objects =3D freeable;
> +=09return delta > 0 ? delta : 0;
> +}
> +
>  static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  =09=09=09=09    struct shrinker *shrinker, int priority)
>  {
>  =09unsigned long freed =3D 0;
> -=09unsigned long long delta;
>  =09long total_scan;
> -=09long freeable;
> +=09int64_t freeable_objects =3D 0;
> +=09int64_t scan_count;
>  =09long nr;
>  =09long new_nr;
>  =09int nid =3D shrinkctl->nid;
...
> @@ -487,25 +543,11 @@ static unsigned long do_shrink_slab(struct shrink_c=
ontrol *shrinkctl,
>  =09 */
>  =09nr =3D atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> =20
> -=09total_scan =3D nr;
> -=09if (shrinker->seeks) {
> -=09=09delta =3D freeable >> priority;
> -=09=09delta *=3D 4;
> -=09=09do_div(delta, shrinker->seeks);
> -=09} else {
> -=09=09/*
> -=09=09 * These objects don't require any IO to create. Trim
> -=09=09 * them aggressively under memory pressure to keep
> -=09=09 * them from causing refetches in the IO caches.
> -=09=09 */
> -=09=09delta =3D freeable / 2;
> -=09}
> -
> -=09total_scan +=3D delta;
> +=09total_scan =3D nr + scan_count;
>  =09if (total_scan < 0) {
>  =09=09pr_err("shrink_slab: %pS negative objects to delete nr=3D%ld\n",
>  =09=09       shrinker->scan_objects, total_scan);
> -=09=09total_scan =3D freeable;
> +=09=09total_scan =3D scan_count;

Same question as before: why the change in assignment? freeable was the
->count_objects() return value, which is now stored in freeable_objects.

FWIW, the change seems to make sense in that it just factors out the
deferred count, but it's not clear if it's intentional...

Brian

>  =09=09next_deferred =3D nr;
>  =09} else
>  =09=09next_deferred =3D total_scan;
> @@ -522,19 +564,20 @@ static unsigned long do_shrink_slab(struct shrink_c=
ontrol *shrinkctl,
>  =09 * Hence only allow the shrinker to scan the entire cache when
>  =09 * a large delta change is calculated directly.
>  =09 */
> -=09if (delta < freeable / 4)
> -=09=09total_scan =3D min(total_scan, freeable / 2);
> +=09if (scan_count < freeable_objects / 4)
> +=09=09total_scan =3D min_t(long, total_scan, freeable_objects / 2);
> =20
>  =09/*
>  =09 * Avoid risking looping forever due to too large nr value:
>  =09 * never try to free more than twice the estimate number of
>  =09 * freeable entries.
>  =09 */
> -=09if (total_scan > freeable * 2)
> -=09=09total_scan =3D freeable * 2;
> +=09if (total_scan > freeable_objects * 2)
> +=09=09total_scan =3D freeable_objects * 2;
> =20
>  =09trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
> -=09=09=09=09   freeable, delta, total_scan, priority);
> +=09=09=09=09   freeable_objects, scan_count,
> +=09=09=09=09   total_scan, priority);
> =20
>  =09/*
>  =09 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
> @@ -559,7 +602,7 @@ static unsigned long do_shrink_slab(struct shrink_con=
trol *shrinkctl,
>  =09 * possible.
>  =09 */
>  =09while (total_scan >=3D batch_size ||
> -=09       total_scan >=3D freeable) {
> +=09       total_scan >=3D freeable_objects) {
>  =09=09unsigned long ret;
>  =09=09unsigned long nr_to_scan =3D min(batch_size, total_scan);
> =20
> --=20
> 2.24.0.rc0
>=20

