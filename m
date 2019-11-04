Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43816EE3BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 16:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfKDPZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 10:25:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34854 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728392AbfKDPZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572881132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YNUjPtCpzm+8vYW330N9vvutohsdZnTurKhkqwxw6r0=;
        b=U6Y4rOJcDGfpKRjtMehcugg6KhMeQ5f3caqCqfx0e125Vk63JXhJw1+ye7RqJIeElsEARi
        +rt4bRwn+usmPBm11ziVxJqNMuJl3CMMXdr4ubAQztoNuBDhZPqZsL0oHSuTOQFLduzPCV
        R8rY3FYTJQ3fH19OJVajp/VQ9C9Hv+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-u7TOeLLDNXGARytbqgEOlA-1; Mon, 04 Nov 2019 10:25:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62D9E800C73;
        Mon,  4 Nov 2019 15:25:27 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C472B19C4F;
        Mon,  4 Nov 2019 15:25:26 +0000 (UTC)
Date:   Mon, 4 Nov 2019 10:25:25 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/28] mm: directed shrinker work deferral
Message-ID: <20191104152525.GA10665@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-10-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-10-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: u7TOeLLDNXGARytbqgEOlA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:45:59AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> Introduce a mechanism for ->count_objects() to indicate to the
> shrinker infrastructure that the reclaim context will not allow
> scanning work to be done and so the work it decides is necessary
> needs to be deferred.
>=20
> This simplifies the code by separating out the accounting of
> deferred work from the actual doing of the work, and allows better
> decisions to be made by the shrinekr control logic on what action it
> can take.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

My understanding from the previous discussion(s) is that this is not
tied directly to the gfp mask because that is not the only intended use.
While it is currently a boolean tied to the the entire shrinker call,
the longer term objective is per-object granularity.

I find the argument reasonable enough, but if the above is true, why do
we move these checks from ->scan_objects() to ->count_objects() (in the
next patch) when per-object decisions will ultimately need to be made by
the former? That seems like unnecessary churn and inconsistent with the
argument against just temporarily doing something like what Christoph
suggested in the previous version, particularly since IIRC the only use
in this series was for gfp mask purposes.

>  include/linux/shrinker.h | 7 +++++++
>  mm/vmscan.c              | 8 ++++++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 0f80123650e2..3405c39ab92c 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -31,6 +31,13 @@ struct shrink_control {
> =20
>  =09/* current memcg being shrunk (for memcg aware shrinkers) */
>  =09struct mem_cgroup *memcg;
> +
> +=09/*
> +=09 * set by ->count_objects if reclaim context prevents reclaim from
> +=09 * occurring. This allows the shrinker to immediately defer all the
> +=09 * work and not even attempt to scan the cache.
> +=09 */
> +=09bool defer_work;
>  };
> =20
>  #define SHRINK_STOP (~0UL)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ee4eecc7e1c2..a215d71d9d4b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -536,6 +536,13 @@ static unsigned long do_shrink_slab(struct shrink_co=
ntrol *shrinkctl,
>  =09trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
>  =09=09=09=09   freeable, delta, total_scan, priority);
> =20
> +=09/*
> +=09 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
> +=09 * defer the work to a context that can scan the cache.
> +=09 */
> +=09if (shrinkctl->defer_work)
> +=09=09goto done;
> +

I still find the fact that this per-shrinker invocation field is never
reset unnecessarily fragile, and I don't see any good reason not to
reset it prior to the shrinker callback that potentially sets it.

Brian

>  =09/*
>  =09 * Normally, we should not scan less than batch_size objects in one
>  =09 * pass to avoid too frequent shrinker calls, but if the slab has les=
s
> @@ -570,6 +577,7 @@ static unsigned long do_shrink_slab(struct shrink_con=
trol *shrinkctl,
>  =09=09cond_resched();
>  =09}
> =20
> +done:
>  =09if (next_deferred >=3D scanned)
>  =09=09next_deferred -=3D scanned;
>  =09else
> --=20
> 2.24.0.rc0
>=20

