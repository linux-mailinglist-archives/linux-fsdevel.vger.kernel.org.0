Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A344D5A40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 06:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbiCKFHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 00:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiCKFHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:07:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0DD1AC28A;
        Thu, 10 Mar 2022 21:06:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F1C1B82A7D;
        Fri, 11 Mar 2022 05:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384E1C340ED;
        Fri, 11 Mar 2022 05:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646975168;
        bh=AKcJwdPPGCmC8fnT+SzRmfs6FPJaBvqwnNz4bzPIPRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwWXoihYFEXXdqVuediOElDChCGopC96LqjN28ounv6QQ4t/nM6nQ7zaEaW74K00I
         VU+JqBS/dFskSGFDaX8oATaI3CDAz/mEXDUUCbQG1m5Q0vxLet99mwu/eGHpBrJgK3
         KGB4n9QfE7o6GOj3CEWYKcKACgXEQBwVLBA336ZWe8Z+kR3OJT1u9gIPtv8kdNJKO0
         OhBBIq0xXlhD0H37V5rvzy2MIn13nbIEosxwBa37jdA7LHwr8B05do7MhB+FZRxK+V
         g7E6xbqhpFY1ZRpxP/zwLkkaqom62qVk8+xNwD/c+ZjczSPOLRa5PXgmTnaGiuVeQt
         chMhruCRIAHuA==
Date:   Thu, 10 Mar 2022 21:06:06 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Luca Porzio (lporzio)" <lporzio@micron.com>
Cc:     "hch@lst.de" <hch@lst.de>, Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "song@kernel.org" <song@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Message-ID: <YirYvvIBW+XNGvxP@sol.localdomain>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <20220310142148.GA1069@lst.de>
 <CO3PR08MB7975AB3E282C7DA35A5B1CF0DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO3PR08MB7975AB3E282C7DA35A5B1CF0DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 06:51:39PM +0000, Luca Porzio (lporzio) wrote:
>
> Micron Confidential

This is a public mailing list, so please do not use this header/footer.

> it is used across the (Android) ecosystem.

So why hasn't it been submitted upstream?

- Eric
