Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E591E5229B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 04:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbiEKC3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 22:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbiEKC27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 22:28:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF31B381AF;
        Tue, 10 May 2022 19:28:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84E08B81CCA;
        Wed, 11 May 2022 02:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD4CC385D8;
        Wed, 11 May 2022 02:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652236135;
        bh=iY/lEhwjb6LKaL0NjJtVnQB+oNQ+W9132bMfjAgOpIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ti4RHrQHQ/IYAqcw5QtmW2G625U1SYwfY3cdLlEt+2LyvMc28jK7OZtuqpAdciO4E
         A1sDROVPAwe+6g7pxZqpuXEI9pmVEJetL4XvpAT7Oamo0HXuaxWGMgnGEW/sswm6rN
         OqzYpcJy6JZBzUjuzdr0qi0VLvnA2SIfIfJJZKI0=
Date:   Tue, 10 May 2022 19:28:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, linmiaohe@huawei.com
Subject: Re: [PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink
Message-Id: <20220510192853.410ea7587f04694038cd01de@linux-foundation.org>
In-Reply-To: <CAPcyv4h0a3aT3XH9qCBW3nbT4K3EwQvBSD_oX5W=55_x24-wFA@mail.gmail.com>
References: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
        <20220511000352.GY27195@magnolia>
        <20220511014818.GE1098723@dread.disaster.area>
        <CAPcyv4h0a3aT3XH9qCBW3nbT4K3EwQvBSD_oX5W=55_x24-wFA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 10 May 2022 18:55:50 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> > It'll need to be a stable branch somewhere, but I don't think it
> > really matters where al long as it's merged into the xfs for-next
> > tree so it gets filesystem test coverage...
> 
> So how about let the notify_failure() bits go through -mm this cycle,
> if Andrew will have it, and then the reflnk work has a clean v5.19-rc1
> baseline to build from?

What are we referring to here?  I think a minimal thing would be the
memremap.h and memory-failure.c changes from
https://lkml.kernel.org/r/20220508143620.1775214-4-ruansy.fnst@fujitsu.com ?

Sure, I can scoot that into 5.19-rc1 if you think that's best.  It
would probably be straining things to slip it into 5.19.

The use of EOPNOTSUPP is a bit suspect, btw.  It *sounds* like the
right thing, but it's a networking errno.  I suppose livable with if it
never escapes the kernel, but if it can get back to userspace then a
user would be justified in wondering how the heck a filesystem
operation generated a networking errno?

