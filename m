Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D68EE3D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 16:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfKDPa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 10:30:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37223 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729355AbfKDPa5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572881457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mbwo60yuhf9zn/no1y4eRlxn1KfPxIVdxOh+1RcQBXI=;
        b=XDos2O1tpK2qcXO+k6Vu+nMhqrJbV5ox4PoLkwBOu3hF4eRohS8nViJEkB/AX+WQtLKVIu
        OkgUce8Kg9BErdW9/yMoRcIVXYg8eoQ/OUXigH2NgM/d+KkqwBuBNV3Y8/yiSXm+8qi1eN
        n6eAPB7d/GvYR0CrrdbiKJMXD3SlSwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-V26_gtMDPGyIgQsEcz9NSg-1; Mon, 04 Nov 2019 10:30:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D800107ACC2;
        Mon,  4 Nov 2019 15:30:52 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B00265D6C5;
        Mon,  4 Nov 2019 15:30:51 +0000 (UTC)
Date:   Mon, 4 Nov 2019 10:30:49 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/28] shrinker: clean up variable types and tracepoints
Message-ID: <20191104153049.GD10665@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-14-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-14-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: V26_gtMDPGyIgQsEcz9NSg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:03AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> The tracepoint information in the shrinker code don't make a lot of

Nit:=09=09=09=09=09=09  doesn't

> sense anymore and contain redundant information as a result of the
> changes in the patchset. Refine the information passed to the
> tracepoints so they expose the operation of the shrinkers more
> precisely and clean up the remaining code and varibles in the

Nit:=09=09=09=09=09=09variables

> shrinker code so it all makes sense.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  include/trace/events/vmscan.h | 69 ++++++++++++++++-------------------
>  mm/vmscan.c                   | 24 +++++-------
>  2 files changed, 41 insertions(+), 52 deletions(-)
>=20
...
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c0e2bf656e3f..7a8256322150 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
...
> @@ -624,23 +622,21 @@ static unsigned long do_shrink_slab(struct shrink_c=
ontrol *shrinkctl,
>  =09=09cond_resched();
>  =09}
>  done:
...
>  =09if (next_deferred > 0)
> -=09=09new_nr =3D atomic64_add_return(next_deferred,
> -=09=09=09=09=09=09&shrinker->nr_deferred[nid]);
> -=09else
> -=09=09new_nr =3D atomic64_read(&shrinker->nr_deferred[nid]);
> +=09=09atomic64_add(next_deferred, &shrinker->nr_deferred[nid]);
> =20
> -=09trace_mm_shrink_slab_end(shrinker, nid, freed, deferred_count, new_nr=
,
> -=09=09=09=09=09scan_count);
> +=09trace_mm_shrink_slab_end(shrinker, nid, freed, scanned_objects,
> +=09=09=09=09 next_deferred);

I guess this invalidates my comment on the previous patch around new_nr.
Looks Ok to me:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  =09return freed;
>  }
> =20
> --=20
> 2.24.0.rc0
>=20

