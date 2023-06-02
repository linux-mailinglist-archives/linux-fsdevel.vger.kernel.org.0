Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF56720305
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 15:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbjFBNST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbjFBNSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B808BE43;
        Fri,  2 Jun 2023 06:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F82262660;
        Fri,  2 Jun 2023 13:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F0BC433D2;
        Fri,  2 Jun 2023 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685711884;
        bh=P5Dc29mxMGV428PPMJZilBV2F/4XqbL5kx2gF5NwrrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQvQJR2lrQhcWaforw0/Bh3AIx4bMkLCS8067SVYMMH9ml2X+5/fHWDlArDX82LC0
         6bUVDnL5sR+4foxZ+Ood383frthkLp+wvOA6MGjj4FwEqbbtMemoktaTtCHgGvI8Kb
         1h9q+m5FCUHptAEDMn2KsGZC9OiR+pBUta63YRJLyeLLZ4MgUaxgcP3mj/HKFVsdW/
         DSYVBtpkFyDZbDmbXAzb5PT+94gCBYmwA1dau5Zia8Y+4VHOr8pWe67E+sz2E2cNmH
         vovJ+0fKZvf7Ezu6Kcm4MwlOPrvof9c12mPCCsNPkEGEK3+v+NLT6oNeqpZdgpAVjZ
         QRsF4kW6NLrTw==
Date:   Fri, 2 Jun 2023 06:18:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] highmem: Rename put_and_unmap_page() to
 unmap_and_put_page()
Message-ID: <20230602131801.GB628@quark.localdomain>
References: <20230602103307.5637-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602103307.5637-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 12:33:07PM +0200, Fabio M. De Francesco wrote:
> With commit 849ad04cf562a ("new helper: put_and_unmap_page()"), Al Viro
> introduced the put_and_unmap_page() to use in those many places where we
> have a common pattern consisting of calls to kunmap_local() +
> put_page().
> 
> Obviously, first we unmap and then we put pages. Instead, the original
> name of this helper seems to imply that we first put and then unmap.
> 
> Therefore, rename the helper and change the only known upstreamed user
> (i.e., fs/sysv) before this helper enters common use and might become
> difficult to find all call sites and instead easy to break the builds.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
