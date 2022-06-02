Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD9353BD89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbiFBRrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 13:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbiFBRrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407E612297B;
        Thu,  2 Jun 2022 10:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C29B361684;
        Thu,  2 Jun 2022 17:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920A3C385A5;
        Thu,  2 Jun 2022 17:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654192025;
        bh=wpPoiF86HNO2h+P+3n4vHEbxR9x6vf8QrxKYPYbvJI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L7ANxpnHs3VjgxuY/O7HheUltNZomp2/6Ye/NLrJO7NKdZ9ZQNS5UBdJDDGt4Ch7k
         Bku9VAiJBYByf1vyw5Nkpnsg+0Y0Fa06B/1dzfQCIV+VnVuYlSy0lDi+8sHUehJdvI
         rCaoeXObjbBM4ueQnFkiWjY3by4PhOVljmWKX7Sg=
Date:   Thu, 2 Jun 2022 10:47:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jane Chu <jane.chu@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>, linmiaohe@huawei.com
Subject: Re: [PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink
Message-Id: <20220602104703.c5af5abde1d9b867d6aed9c7@linux-foundation.org>
In-Reply-To: <Ypjw0bldEIFp9+YG@magnolia>
References: <20220511000352.GY27195@magnolia>
        <20220511014818.GE1098723@dread.disaster.area>
        <CAPcyv4h0a3aT3XH9qCBW3nbT4K3EwQvBSD_oX5W=55_x24-wFA@mail.gmail.com>
        <20220510192853.410ea7587f04694038cd01de@linux-foundation.org>
        <20220511024301.GD27195@magnolia>
        <20220510222428.0cc8a50bd007474c97b050b2@linux-foundation.org>
        <20220511151955.GC27212@magnolia>
        <CAPcyv4gwV5ReuCUbJHZPVPUJjnaGFWibCLLsH-XEgyvbn9RkWA@mail.gmail.com>
        <32f51223-c671-1dc0-e14a-8887863d9071@fujitsu.com>
        <1007e895-a0e3-9a82-2524-bb7e8a0b6b8c@fujitsu.com>
        <Ypjw0bldEIFp9+YG@magnolia>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2 Jun 2022 10:18:09 -0700 "Darrick J. Wong" <djwong@kernel.org> wrote:

> On Thu, Jun 02, 2022 at 05:42:13PM +0800, Shiyang Ruan wrote:
> > Hi,
> > 
> > Is there any other work I should do with these two patchsets?  I think they
> > are good for now.  So... since the 5.19-rc1 is coming, could the
> > notify_failure() part be merged as your plan?
> 
> Hmm.  I don't see any of the patches 1-5,7-13 in current upstream, so
> I'm guessing this means Andrew isn't taking it for 5.19?

Sorry, the volume of commentary led me to believe that it wasn't
considered finalized.  Shall take a look now.



