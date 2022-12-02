Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEB7640FCB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 22:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiLBVKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 16:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiLBVKe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:10:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494B4DBF72;
        Fri,  2 Dec 2022 13:10:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 076E6B8229B;
        Fri,  2 Dec 2022 21:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D653C433C1;
        Fri,  2 Dec 2022 21:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670015430;
        bh=leQP6OmGjss7eL3jNcnl/Bw5gjzQ0u1AnRVRsOkXVlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F0DAfu1lupy5YDs9vy3ihQX7YAQ7rE/5LdTZcL1zRJcQI/Yw2CIYDBbK49aXzuaE+
         v87hS0zw27rukrqD0FNNNWAbBE/OUWi3u3/c+Hl1IhXlBrGTtbFxCc4+obU/OIpyTh
         DtKw6KcD50O5K5xBZefaUrw8W+GVb5HdSg+P2bkk=
Date:   Fri, 2 Dec 2022 13:10:29 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Aditya Garg <gargaditya08@live.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] hfsplus: Add module parameter to enable force writes
Message-Id: <20221202131029.50fde1c15a2dd7e156f7e1e8@linux-foundation.org>
In-Reply-To: <Y4pnuBnoHvIS8UB6@casper.infradead.org>
References: <53821C76-DAFE-4505-9EC8-BE4ACBEA9DD9@live.com>
        <20221202125344.4254ab20d2fe0a8e784b33e8@linux-foundation.org>
        <Y4pnuBnoHvIS8UB6@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2 Dec 2022 21:01:44 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Dec 02, 2022 at 12:53:44PM -0800, Andrew Morton wrote:
> > > +		if (force_journaled_rw) {
> > > +			pr_warn("write access to a journaled filesystem is not supported, but has been force enabled.\n");
> > > +		} else {
> > > +			pr_warn("write access to a journaled filesystem is not supported, use the force option at your own risk, mounting read-only.\n");
> > > +			sb->s_flags |= SB_RDONLY;
> > > +		}
> > 
> > All these super long lines are an eyesore.  How about
> > 
> > 			pr_warn("write access to a journaled filesystem is "
> > 				"not supported, but has been force enabled.\n");
> 
> Linus has asked us to not do that because it makes it hard to grep.

Yup.  But as with everything, there are tradeoffs.  These messages are
so messy to read and reading code is more common than grepping for
error messages.  Just grep the first 20-30 characters...

