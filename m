Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05AF613962
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 15:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiJaOw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiJaOw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:52:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC1C10FEB;
        Mon, 31 Oct 2022 07:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RC3NrLoErExSxHY+vh+3bdodn0jnitTTF5VCB2jQink=; b=FClJ7IMr0a3VqPvmWo0fQF03WV
        40X4qWU9Os74/C/rBsrylU6sJSykUUAdeJR/3IUIrAHbwTlk7pOtTVWxvHOWnddr9c3FDYiIX87XM
        pjPkQIoSMm4OiUtvfp3zmfNsnFOBnV689PWz9Yc4H9lx4l4Jfa9Tuw1E7ZebPzjFB7TPL7bnouzNA
        IYsuUgYGNLXgnd9gn5vWqsNmFIxu2GAv4z2ZpBnFY7f3mDAaAJNuNue9KUNAVyBNnsPvUUaMTfe+u
        1dL2L/LR1SDwHsrZucG+LVxg7cqCjZQSgzEeVYc2NS7pvyjn/7HUdwrXhjbNhActm6uJT/Rud0Lvh
        fvf8zO8g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opW9o-003l2F-E1; Mon, 31 Oct 2022 14:52:56 +0000
Date:   Mon, 31 Oct 2022 14:52:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-mm@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        smfrench@gmail.com, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] iov_iter: Provide a function to extract/pin/get
 pages from an iteraor
Message-ID: <Y1/hSO+7kAJhGShG@casper.infradead.org>
References: <166722777223.2555743.162508599131141451.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166722777223.2555743.162508599131141451.stgit@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 02:49:32PM +0000, David Howells wrote:
> I added a macro by which you can query an iterator to find out how the
> extraction function will treat the pages (it returns 0, FOLL_GET or FOLL_PIN
> as appropriate).  Note that it's a macro to avoid #inclusion of linux/mm.h in
> linux/uio.h.

I'd support moving FOLL_* definitions to mm_types.h along with
FAULT_FLAG_* and VM_FAULT_*.
