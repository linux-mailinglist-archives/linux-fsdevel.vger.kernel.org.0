Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ABB60E992
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 21:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiJZTti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 15:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbiJZTt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:49:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3415F40;
        Wed, 26 Oct 2022 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/NAaRcMUTyR+OXd33oR0OH1m3Eq7r9GRZrej4mduiik=; b=RbvJzn0nbig1HkQqxR90+2F7Pr
        gho373jXhNFJ8OVG5FD1dBMLniHqxDzYNWsTKkG7bXCbVG+PVp+XDbvSIxeWB5VZhq4G5aos5SqPc
        b5L2BwIUKaGq+NcaO9gY5+fNiA77mlO+TQgyRyptxXFwHRWcMt7N8becoVxsUNVuL0ecll89E13HT
        lQCWT23bVf2f0IsbEtbkhHj9fewA8KztjgAwZnJE1AjCXyOB0PJKJXjUfJqvCvzRI6L383mau4NK2
        /RdxQ9LQWCJsadySDlfa1t+PJpVHLfCYbhGB/D4bM+vu64l0lIJHII19YuBCNPqFZCURAR81vHcuc
        ZbXHRF6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onmOs-00HGKM-Ts; Wed, 26 Oct 2022 19:49:19 +0000
Date:   Wed, 26 Oct 2022 20:49:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <Y1mPPq6mc/C7pNhM@casper.infradead.org>
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
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 01:48:37PM +0800, Zhaoyang Huang wrote:
> hint from my side. The original problem I raised is under v5.15 where
> there is no folio yet.

I really wish you'd stop dropping hints and give all of the information
you have so I can try to figure this out withouot sending individual
emails for every little piece.

Do you have CONFIG_READ_ONLY_THP_FOR_FS=y in your .config?

