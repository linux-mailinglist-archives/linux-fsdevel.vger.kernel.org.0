Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5971716DDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjE3Toa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 15:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjE3To2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 15:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59BBB2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 12:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685475821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=61jSLilvI6Kq8tZP1TgtpGiMrTcQZMGT4z3p0LusAeA=;
        b=GsqdTmCHT8NP5LleVwFUabg+LvtnmZO5v9mDR9wPf2rrLNfZJBgGf2nKlMOr3cVPLa7Esr
        GAauaXnrrWwitvj482RvEUAbGm/ZcvQTnSgP0IBeHVZlj70uU4oFIbuRtCshIgW6jHzCbg
        qu6TgDQflvxViPtjr4fpkSNSHxDoMRI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-MsdeEUCPPlCHG2sXrVx-fA-1; Tue, 30 May 2023 15:43:35 -0400
X-MC-Unique: MsdeEUCPPlCHG2sXrVx-fA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 903E8800B2A;
        Tue, 30 May 2023 19:43:34 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5346B2166B25;
        Tue, 30 May 2023 19:43:34 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 34UJhY4b022142;
        Tue, 30 May 2023 15:43:34 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 34UJhXMb022117;
        Tue, 30 May 2023 15:43:33 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 30 May 2023 15:43:33 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Mike Snitzer <snitzer@kernel.org>
cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "axboe @ kernel . dk" <axboe@kernel.dk>, shaggy@kernel.org,
        damien.lemoal@wdc.com, cluster-devel@redhat.com, kch@nvidia.com,
        agruenba@redhat.com, linux-mm@kvack.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        jfs-discussion@lists.sourceforge.net, willy@infradead.org,
        ming.lei@redhat.com, linux-block@vger.kernel.org, song@kernel.org,
        dm-devel@redhat.com, rpeterso@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        hch@lst.de
Subject: Re: [PATCH v5 16/20] dm-crypt: check if adding pages to clone bio
 fails
In-Reply-To: <ZHYbIYxGbcXbpvIK@redhat.com>
Message-ID: <alpine.LRH.2.21.2305301527410.18906@file01.intranet.prod.int.rdu2.redhat.com>
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com> <20230502101934.24901-17-johannes.thumshirn@wdc.com> <alpine.LRH.2.21.2305301045220.3943@file01.intranet.prod.int.rdu2.redhat.com> <ZHYbIYxGbcXbpvIK@redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 30 May 2023, Mike Snitzer wrote:

> On Tue, May 30 2023 at 11:13P -0400,
> Mikulas Patocka <mpatocka@redhat.com> wrote:
> 
> > Hi
> > 
> > I nack this. This just adds code that can't ever be executed.
> > 
> > dm-crypt already allocates enough entries in the vector (see "unsigned int 
> > nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;"), so bio_add_page can't 
> > fail.
> > 
> > If you want to add __must_check to bio_add_page, you should change the 
> > dm-crypt code to:
> > if (!bio_add_page(clone, page, len, 0)) {
> > 	WARN(1, "this can't happen");
> > 	return NULL;
> > }
> > and not write recovery code for a can't-happen case.
> 
> Thanks for the review Mikulas. But the proper way forward, in the
> context of this patchset, is to simply change bio_add_page() to
> __bio_add_page()
> 
> Subject becomes: "dm crypt: use __bio_add_page to add single page to clone bio"
> 
> And header can explain that "crypt_alloc_buffer() already allocates
> enough entries in the clone bio's vector, so bio_add_page can't fail".
> 
> Mike

Yes, __bio_add_page would look nicer. But bio_add_page can merge adjacent 
pages into a single bvec entry and __bio_add_page can't (I don't know how 
often the merging happens or what is the performance implication of 
non-merging).

I think that for the next merge window, we can apply this patch: 
https://listman.redhat.com/archives/dm-devel/2023-May/054046.html
which makes this discussion irrelevant. (you can change bio_add_page to 
__bio_add_page in it)

Mikukas

