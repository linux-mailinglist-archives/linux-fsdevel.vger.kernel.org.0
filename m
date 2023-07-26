Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342E0762D09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 09:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjGZHRU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 03:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjGZHQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:16:44 -0400
Received: from out-33.mta0.migadu.com (out-33.mta0.migadu.com [IPv6:2001:41d0:1004:224b::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF054696
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 00:14:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690355641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGcKZp3hFkU5xFrSCjAkw6H7DFoCu3eaWoJYWwGl/BE=;
        b=oAdnd9nZjeI3kyPEsvbWMnutbGwA6A/dnneU8CJq7+Jt5loXWooRhnwIByjGtqjMSkXONA
        pNjiGN0aO6zYh0sGJrXLfhIGW2JwY9JyCA6cMT7CdHDW/adI6zyBptMVHroPA7pSViOJ/f
        hCfYb58R4eJqbPwcBX6PzM13HtrcK50=
MIME-Version: 1.0
Subject: Re: [PATCH v2 21/47] mm: workingset: dynamically allocate the
 mm-shadow shrinker
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230724094354.90817-22-zhengqi.arch@bytedance.com>
Date:   Wed, 26 Jul 2023 15:13:37 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, david@fromorbit.com,
        tkhai@ya.ru, Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, djwong@kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <08F2140B-0684-4FB0-8FB9-CEB88882F884@linux.dev>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-22-zhengqi.arch@bytedance.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 24, 2023, at 17:43, Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
>=20
> Use new APIs to dynamically allocate the mm-shadow shrinker.
>=20
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
> mm/workingset.c | 26 ++++++++++++++------------
> 1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 4686ae363000..4bc85f739b13 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -762,12 +762,7 @@ static unsigned long scan_shadow_nodes(struct =
shrinker *shrinker,
> NULL);
> }
>=20
> -static struct shrinker workingset_shadow_shrinker =3D {
> -	.count_objects =3D count_shadow_nodes,
> -	.scan_objects =3D scan_shadow_nodes,
> -	.seeks =3D 0, /* ->count reports only fully expendable nodes */
> -	.flags =3D SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
> -};
> +static struct shrinker *workingset_shadow_shrinker;


Same as patch #17.=
