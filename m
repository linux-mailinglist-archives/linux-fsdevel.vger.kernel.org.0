Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E757C4D238A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 22:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350494AbiCHVrV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 16:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350519AbiCHVrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:47:18 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000D4554B2
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 13:46:20 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id v189so265334qkd.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 13:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=pBT9wHk0kv9phQaF2jSMAucWeXRUjsHTpKabj8I6JEU=;
        b=RAmhDr5MJvaQL3qZE74+KSH75ORbbrkgRY9YObb//xmoMlf33p1hpBU9rIXZG6L7ml
         J+/UM1uySARXqyiozkXgec1tI0uVeDVycFFmvGBE54shXKr2/rvIjivnr7QpM+2k1g+X
         +MyLRsKUEWJsrs8IpmNwBg0pBdBBlc0pA0nJUj7Thmh2J9Fz9sOANtG3znbE95Dm8lrO
         HCzlO5HMdIBw9+kLBiRDV0nqPh+7o9hbPBoNbAXXXds8jWdu1YLtB7e8jax1fkkbp7iR
         cjg2PIbda0n5tQiHwcjQQwDU8eQ4Bw5JM4SDtvvqYk7/xwSqid8QSIaayOx11CfWeNOO
         hPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=pBT9wHk0kv9phQaF2jSMAucWeXRUjsHTpKabj8I6JEU=;
        b=UdeSenv3UpPXXyTS3g3AkWGPpmj+KNSipiRU9XsoOAp+9hpoiC/gm+wSWQkNYm5Ifl
         OiUAXZtLYMMZ+oC5M1GpA/sGHwPqIvZCX34tdSA7NRx4E04vMwf3doLf74C4zLrcf5b/
         Y8t+JptoLrLxxJMcieEf/efvpjtrxOa2JfObmBj3+kNAs47LLDCkfN/E/lPjNJjmykml
         59HPuAX8VJQHefMNLY5zs37n+E1rC46ECi9ZhPljx+Iv5xhTy2wlQVAkRdEJbiPQDhiS
         JVSC1yJYR+8WozmNymSwEfKcIpxgDUKGWKS9mvpJjrKWG3yOFUXNOEjCqQoD5iFfFDWW
         paEA==
X-Gm-Message-State: AOAM531XNudXgc/N53fq7TQz+9+pGlwTUZMRNWAiaN1g7qJyJ4tPFdmd
        jSsUa136c0J+9xR04IdE+AU8ug==
X-Google-Smtp-Source: ABdhPJxWHyEAuF8GKQrPH4aj80OVaMZ68Mo/l/yema1f/6PqDgdd6gWKrf8+d4sG3STa70ORNpDdgg==
X-Received: by 2002:a05:620a:134e:b0:67b:d16:89f7 with SMTP id c14-20020a05620a134e00b0067b0d1689f7mr9931286qkl.123.1646775979553;
        Tue, 08 Mar 2022 13:46:19 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g2-20020a37e202000000b00607e264a208sm66421qki.40.2022.03.08.13.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 13:46:19 -0800 (PST)
Date:   Tue, 8 Mar 2022 13:46:15 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     "Darrick J. Wong" <djwong@kernel.org>
cc:     Christoph Hellwig <hch@lst.de>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Borislav Petkov <bp@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm v2] tmpfs: do not allocate pages on read
In-Reply-To: <20220308172734.GC1479066@magnolia>
Message-ID: <9798e3b-1c2a-6c47-decc-7d4148de5114@google.com>
References: <f9c2f38f-5eb8-5d30-40fa-93e88b5fbc51@google.com> <20220306092709.GA22883@lst.de> <90bc5e69-9984-b5fa-a685-be55f2b64b@google.com> <20220307064434.GA31680@lst.de> <20220308172734.GC1479066@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Mar 2022, Darrick J. Wong wrote:
> 
> I've long wondered (for my own nefarious purposes) why tmpfs files
> didn't just grab the zero page,

(tmpfs files have been using the zero page for reads for many years:
it was just this odd internal "could it be for a stacking filesystem?"
case, which /dev/loop also fell into, which was doing allocation on read.

I wonder what your nefarious purposes are ;) Maybe related to pages
faulted into an mmap: those pages tmpfs has always allocated for, then
they're freed up later by page reclaim if still undirtied. We may change
that in future, and use the zero page even there: there are advantages
of course, but some care and code needed - never been a priority.)

> so:
> 
> Acked-by: Darrick J. Wong <djwong@kernel.org>

Thanks,
Hugh
