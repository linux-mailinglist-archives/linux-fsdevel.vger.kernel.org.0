Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF26995C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 14:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBPN3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 08:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjBPN3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:29:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B416564AE;
        Thu, 16 Feb 2023 05:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HCrOBvUuDVbVO164MMNUpzywaZDP+3tqMzNw5S/Fbvk=; b=XY5fGjnGjRgbK65Y8xa+WJsmVu
        T8L7E3t67b/PhqUl8OsQtLP/K5jo192mFLaGcAixt7/mlKLFZeI/10rh98BdGVn5wGZhItQuaxmB5
        F0Xxy15rMB1sQxrG31MkSRB+EmerQpDVzsHiULeTDkwhulw5PKNTNsMQPAS6jeEqu3jk85oIho1K+
        0q8Cz65HpCPdi2A6dOeJKOTvus2JhaZDB3IKzvozRUhckVyuOPT9XigBu6Iw3qHXWKhGkoOuTZCPM
        YD3pyH5rT7Ta+sqCXQ4eZjjvJ/PsLgwXwnhAj9GfJaDarg3k8nPzdgeK9QHePkMPBnYbDMh4bNuZM
        NxGQSWhA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSeJo-008Rc2-Rp; Thu, 16 Feb 2023 13:29:00 +0000
Date:   Thu, 16 Feb 2023 13:29:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     wenyang.linux@foxmail.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Woodhouse <dwmw@amazon.co.uk>, Fu Wei <wefu@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michal Nazarewicz <m.nazarewicz@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: use wait_event_interruptible_locked_irq() helper
Message-ID: <Y+4vnHS5y5stzg9o@casper.infradead.org>
References: <tencent_47F9893DA354D9509F06DD4C52A7EB30130A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_47F9893DA354D9509F06DD4C52A7EB30130A@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 16, 2023 at 09:17:39PM +0800, wenyang.linux@foxmail.com wrote:
> +		res = wait_event_interruptible_locked_irq(
> +				ctx->wqh, ULLONG_MAX - ctx->count > ucnt) ?
> +			-ERESTARTSYS : sizeof(ucnt);

You've broken the line here in a weird way.  I'd've done it as:

		res = wait_event_interruptible_locked_irq(ctx->wqh,
				ULLONG_MAX - ctx->count > ucnt) ?
					-ERESTARTSYS : sizeof(ucnt));

... also the patch you've sent here doesn't even compile.  Have you
tested it?
