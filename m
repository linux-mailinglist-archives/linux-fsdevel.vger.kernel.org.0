Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1997345B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jun 2023 11:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjFRJdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 05:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFRJdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 05:33:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3B310D3;
        Sun, 18 Jun 2023 02:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KTo4dg5Pw2cEjEIq8Y10umtMxG9ZrOcdRjy2b8H93Kw=; b=OmHgEWdBs/F6pO/K6891l6y4SH
        ZlQ298AuC+q4UP6CkIko5rDTMXTbQB1so/I90rY2F8+tNGmqwupZRKOFnwNIyi/Bl+Vjke5hv0NpW
        U8UATYg7aaTnYaFd1qUOC6J7CYjIj2j8VIG7WkXS5I6ZHkCNVnyWfBgQ5q6mTmfC0pQhGMjXgbGGm
        qPQwePIyexOUrabiXLBojG5V7oSPCkkBF1exhSE3JhlK1maA4gB3nA9iYzmNfZR0tiJY58d7glVFq
        aS6krm1SPqEhG75RhQ1yI0yJsMBbxTB2G3GPs0Crv9O3PDmgZVJMO3wM5VKrDZPNaWBkn1/37HZyJ
        dUajjQnA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qAomt-005Xgr-1D;
        Sun, 18 Jun 2023 09:33:35 +0000
Date:   Sun, 18 Jun 2023 02:33:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Remove child from struct ctl_table
Message-ID: <ZI7Pbw5WcJDDISYI@bombadil.infradead.org>
References: <CGME20230616085926eucas1p10709e25a4c0246ed2b22da602f919b4e@eucas1p1.samsung.com>
 <20230616085922.3066990-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616085922.3066990-1-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 16, 2023 at 10:59:14AM +0200, Joel Granados wrote:
> This is part of the effort to remove the empty element of the ctl_table
> structures (used to calculate size) and replace it with an ARRAY_SIZE call. By
> replacing the child element in struct ctl_table with a flags element we make
> sure that there are no forward recursions on child nodes and therefore set
> ourselves up for just using an ARRAY_SIZE. We also added some self tests to
> make sure that we do not break anything.
> 
> Patchset is separated in 4: parport fixes, selftests fixes, selftests additions and
> replacement of child element. Tested everything with sysctl self tests and everything
> seems "ok".
> 
> 1. parport fixes: This is related to my previous series and it plugs a sysct
>    table leak in the parport driver. @mcgrof: I'm just leaving this here so we
>    don't have to retest the parport stuff
> 
> 2. Selftests fixes: Remove the prefixed zeros when passing a awk field to the
>    awk print command because it was causing $0009 to be interpreted as $0.
>    Replaced continue with return in sysctl.sh(test_case) so the test actually
>    gets skipped. The skip decision is now in sysctl.sh(skip_test).
> 
> 3. Selftest additions: New test to confirm that unregister actually removes
>    targets. New test to confirm that permanently empty targets are indeed
>    created and that no other targets can be created "on top".
> 
> 4. Replaced the child pointer in struct ctl_table with an enum which is used to
>    differentiate between permanently empty targets and non-empty ones.
> 
> V2: Replaced the u8 flag with an enumeration.

Thanks, I dropped the old patches and applied this new set. Pushed out
to sysctl-next.

  Luis
