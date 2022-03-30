Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821B54EC987
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346960AbiC3QUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 12:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbiC3QUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:20:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E872DE001;
        Wed, 30 Mar 2022 09:18:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6608B81D6E;
        Wed, 30 Mar 2022 16:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A51C340EC;
        Wed, 30 Mar 2022 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648657093;
        bh=cjFQuqoRMfu2TXAsiXRv9EQjKvH+MdFIXY9uc5fhIeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qL9r9Yws/hUGzKuvIFY+RbuwntrMSK4P43CyL2/dnXSTyynijAjGxTx5jk0MciJBS
         ZU3K1UIDqMzxA88epboJ1p59x5irJJj2JLdT3IY0tPJYmpTuab09WoUfTrxDR16Dfq
         r8N4tXQdQIaPnia1AslHnGmOplVqsKsaI34w3RLi6u1e7bfXjxM+6aYBDQb0MMyTSr
         YPN+3zKng+bKVx0qXsPftkro+4iih8aIVgkJzS6owkJGyF1RHMzDG9okK9EYv0u6/k
         DPUA6Xn7fDXsQPvseUvtae8Ads0cYctEDf9QDUz5BscGpr2wMHyw7xssUbm6ZRtK/f
         ndefofeH+jTig==
Date:   Wed, 30 Mar 2022 09:18:12 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        david <david@fromorbit.com>, Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v11 1/8] dax: Introduce holder for dax_device
Message-ID: <20220330161812.GA27649@magnolia>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-2-ruansy.fnst@fujitsu.com>
 <CAPcyv4jAqV7dZdmGcKrG=f8sYmUXaL7YCQtME6GANywncwd+zg@mail.gmail.com>
 <4fd95f0b-106f-6933-7bc6-9f0890012b53@fujitsu.com>
 <YkPtptNljNcJc1g/@infradead.org>
 <15a635d6-2069-2af5-15f8-1c0513487a2f@fujitsu.com>
 <YkQtOO/Z3SZ2Pksg@infradead.org>
 <4ed8baf7-7eb9-71e5-58ea-7c73b7e5bb73@fujitsu.com>
 <YkR8CUdkScEjMte2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkR8CUdkScEjMte2@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 08:49:29AM -0700, Christoph Hellwig wrote:
> On Wed, Mar 30, 2022 at 06:58:21PM +0800, Shiyang Ruan wrote:
> > As the code I pasted before, pmem driver will subtract its ->data_offset,
> > which is byte-based. And the filesystem who implements ->notify_failure()
> > will calculate the offset in unit of byte again.
> > 
> > So, leave its function signature byte-based, to avoid repeated conversions.
> 
> I'm actually fine either way, so I'll wait for Dan to comment.

FWIW I'd convinced myself that the reason for using byte units is to
make it possible to reduce the pmem failure blast radius to subpage
units... but then I've also been distracted for months. :/

--D
