Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68697712233
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbjEZI34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242701AbjEZI3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:29:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F222D8;
        Fri, 26 May 2023 01:29:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f603ff9c02so3124065e9.2;
        Fri, 26 May 2023 01:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685089787; x=1687681787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1pa2Q0AfaiaqQI2ullEGnQjWj0U14Eq06qxiexcex8=;
        b=L+kkDr2ms492v9mk5G0ugQoPnpWpdza3e4dbO8KflEoaVvUqIKUqYhaKOJzFyjVYpN
         lHn1WaVkAYVNs7AgycnOXYBJwOsJGRMONcS4E59YMT42HsYDLgQtet9yAj7YTClTStrQ
         2SAwUxP1q/2BfqKWbM7Ka+tJC5XKwK27qpRZ6nvivx6D5AsiWWtfAzyTsNCSKZbibqtU
         G61oSgbnGhT/FmmAvFt4FskW1UbbvB1e+Qv8gTkAcZUbJKbPvB32O6z7baabHAHVsml0
         vjc+NkanO0+KwNgNr35fxxfRVBSRqiEsSUKv2qyHl+yxja7Rl/zhXiBsuA95jA7fhGfj
         b+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685089787; x=1687681787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1pa2Q0AfaiaqQI2ullEGnQjWj0U14Eq06qxiexcex8=;
        b=SL50cqVX1TyneTEmLyF3Jktdm2ts/J6TUOyZlok7etvSIQIQ3xcHAI4Fiqg//Ns9tG
         l4HpFL4Sp/i/KeEpnT12eUEGPqzM3sOrdGqUoqnEelCqmfklUzp+TNvG2GKW0ckHP0lx
         yXtl1cr2NKNohWra9S7JfS0qy1c72OPzBAnXkjlVV6s1QexchwFekcMxn4kvuLX4sC6Y
         8UKE7zu4MudxqsND07PUVHmzTXuwZGJVzEpyQNsAdkSA48gu4zfp7m+4TKYvx9RaCplE
         MwfewgmXf0TO2WaW6gxfshINi/ooBxIGuHhMcBrwbvOfRK26rlm5fc+zAFar4Yh9k1HW
         7SwQ==
X-Gm-Message-State: AC+VfDwh78Nc1+2kj7AO8tN3vkgdytktOk9o/MizJGpJ6pFvULuaA8lG
        wyXAZSSNx5zJta/uGgtOYSJWYutKYQQ=
X-Google-Smtp-Source: ACHHUZ4irR/FYHS2vJzInP0aq/HsL1H6Oeax9jQfatuNaGEWy+dOAMSjKp0Rt+Qjz7gwlOFxrtEoCg==
X-Received: by 2002:a05:600c:22d0:b0:3f6:f56:9ad with SMTP id 16-20020a05600c22d000b003f60f5609admr745456wmg.13.1685089787374;
        Fri, 26 May 2023 01:29:47 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003f602e2b653sm8070980wmk.28.2023.05.26.01.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:29:46 -0700 (PDT)
Date:   Fri, 26 May 2023 09:27:37 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
Message-ID: <13ddccb0-c045-4fd7-a495-b0ffe7796bbc@lucifer.local>
References: <20230525223953.225496-1-dhowells@redhat.com>
 <20230525223953.225496-2-dhowells@redhat.com>
 <ZHBsXnJcW3L9SXF4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHBsXnJcW3L9SXF4@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 01:22:54AM -0700, Christoph Hellwig wrote:
> Shouldn't unpin_user_pages and bio_release_page also be updated to
> skip a zero page here?
>

unpin_user_pages*() all call gup_put_folio() which already skips the zero page
so we should be covered on that front.
