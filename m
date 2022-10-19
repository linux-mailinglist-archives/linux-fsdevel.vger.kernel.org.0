Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6166046D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 15:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiJSNVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 09:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiJSNVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:21:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96B21C2097;
        Wed, 19 Oct 2022 06:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ltxh6lxhvT92TP0SNmx2VMAM1oTzzEXuHTECeCwVWiQ=; b=JE56Tqv1TqmJwtoAXQRLbpFOry
        ZGMXaNEMq8pUUFjt/I7CnQ6keu4uQFUVe+trgltKz6Y6IvlVvWp1wfosHU6tdxUB5J0HqcY/i1BM1
        DiFy6NVN1KYvxoQiYkWyAGFIcip958/MoWR4LX2CaFdUktd2gys9L6MoQz5U3V1jMDXWpeAotHLDR
        xdHu0nFh/QjkEaAAckkYuyUkOTuORV85I4JEyhHGcVee3tJZWOTcTG904nlEl80FZoM+VbUu9k4cU
        f97YyMKAa+98SD7n+uraWWoWLLZVF7HZEkq5kdeZG00r9Epyy7KDnJAXU1wrpJMK0Zt3FurOQulm2
        67cw3CTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ol8m7-00BZ12-Cj; Wed, 19 Oct 2022 13:06:23 +0000
Date:   Wed, 19 Oct 2022 14:06:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <Y0/2T5KpFurV2MLp@casper.infradead.org>
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org>
 <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org>
 <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org>
 <20221018223042.GJ2703033@dread.disaster.area>
 <20221019011636.GM2703033@dread.disaster.area>
 <20221019044734.GN2703033@dread.disaster.area>
 <CAGWkznEGMg293S7jOmZ7G-UhEBg6rQZhTd6ffhjoDgoFGvhFNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEGMg293S7jOmZ7G-UhEBg6rQZhTd6ffhjoDgoFGvhFNw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 01:48:37PM +0800, Zhaoyang Huang wrote:
> On Wed, Oct 19, 2022 at 12:47 PM Dave Chinner <david@fromorbit.com> wrote:
> > I removed the mapping_set_large_folios() calls in the XFS inode
> > instantiation and the test code has now run over 55,000 iterations
> > without failing.  The most iterations I'd seen with large folios
> > enabled was about 7,000 - typically it would fail within 2-3,000
> > iterations.
> hint from my side. The original problem I raised is under v5.15 where
> there is no folio yet.

But 5.15 does use 2MB pages in shmem.  You haven't really provided
any information, so I don't know whether the inode that you're having
problems with is a shmem inode.
