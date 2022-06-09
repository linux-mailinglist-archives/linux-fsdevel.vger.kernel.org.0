Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84475544229
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 05:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiFIDxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 23:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiFIDxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:53:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15E23AF
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 20:53:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a10so20307204pju.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jun 2022 20:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2koJarmzmGedHyxAL/i+lFQdd0Q5ZAFYaE5poQNe8+A=;
        b=RQ0R70N1jS16HKNC0Ol/Snkv+fFPQxMu+sR7KyTPcd0AtJQdfRDJChe//d33ePjW42
         NUwM+6AWLf4HFFg8nnACUzLphwGwod4E04VS00IvvGGhoglI/uAdn0OmVESO9k7YbA87
         WXoB0WPSZJwIZQYNTDVCrIBlg3nJFEaNR0URvRoZ6V+qEZfc2gJFc0HlrIL1W1WW+rDF
         1/Yc7ng+dbkR+XlDUC9pFMzh9gCVKqODsRZejDoKKLodOa0wkJ1V/grBLEapqp/wFCIH
         /I5BMumfmT4H9nCNsQOMZJKoI5zjOM9KkgLVSCyM7AwYZxsmplXtAzqYRAkSkI1RVqcd
         8nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2koJarmzmGedHyxAL/i+lFQdd0Q5ZAFYaE5poQNe8+A=;
        b=suaogCv1CCEbWKgeM+8JW9T0wIdzw1M3eJhvXqPVL7eWmKhW15viPzaVLfbhzFU/uJ
         BWrTksC68hURNtxhHBrgrttxB6xkYYGhwXXwryI0BTMXonFp1R4qiyRiX+BcWiJ9EQNp
         FAj6PnfBPaNslo0SCUls4Mh8Tg2Jnl7hnw4YVnTUARPVr1+TXurEn9nZr478DDAf+yjZ
         FcxqH8eLeDj4ytsIh7ulO5MMKnoXMJUedOYh5n+nkIVfjXo47ZwL+hPVQ20lgbhTJwXr
         QO6n+d2PgkH4sQhh4D9Rhln+2dcM9mU1M8zx5Kqp/UOMAD6SPSV56SGuD+PQBKq70su/
         oPgA==
X-Gm-Message-State: AOAM533dPFZPkkB6/Z8uQvQmPFVz9+BcgrnCLuqMpZvcZt1d0Ps1tznZ
        TnqQmTMVHoCSlI6sI5FI0gcAlg==
X-Google-Smtp-Source: ABdhPJz3/PMx3RZgt3QHHTiA/K9+ZXI01CeV4NC4DLpNFuQQZTFyqHCu1obpFa9lx3Ct5QRSUsQXvQ==
X-Received: by 2002:a17:902:e748:b0:164:1b1e:28fe with SMTP id p8-20020a170902e74800b001641b1e28femr38251973plf.116.1654746785210;
        Wed, 08 Jun 2022 20:53:05 -0700 (PDT)
Received: from localhost ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id a20-20020a170902b59400b001664ce47e11sm12584649pls.210.2022.06.08.20.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 20:53:04 -0700 (PDT)
Date:   Thu, 9 Jun 2022 11:53:00 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 16/19] hugetlb: Convert to migrate_folio
Message-ID: <YqFunLBBKbZN9uD9@FVFYT0MHHV2J>
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608150249.3033815-17-willy@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 08, 2022 at 04:02:46PM +0100, Matthew Wilcox (Oracle) wrote:
> This involves converting migrate_huge_page_move_mapping().  We also need a
> folio variant of hugetlb_set_page_subpool(), but that's for a later patch.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
