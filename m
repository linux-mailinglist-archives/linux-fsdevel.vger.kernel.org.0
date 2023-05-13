Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF83701388
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 May 2023 02:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbjEMAwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 20:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241600AbjEMAwA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 20:52:00 -0400
Received: from out-3.mta1.migadu.com (out-3.mta1.migadu.com [IPv6:2001:41d0:203:375::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE1A2707
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 17:51:58 -0700 (PDT)
Date:   Fri, 12 May 2023 20:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683939114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3ZWOnFMn6rXzZy1LX1xJQs1cF9xdamY9fafeP7AU+Q=;
        b=qUiM/tu+oB8nQpuf95qu4oz1t1IaVvz9SQGzYOZFU1nnEDaAn4LXzUtiQTpG6cNbwW2aqs
        P2TQqf02EWjWeIhIFUkVvG66ZbjVnThIydN+HeF/HiBiK32cn/tVrgISHe2FmP5wJ60wiw
        bIeE8JFd3wxfE1ctTpCVYLQAUDtb+Cw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 04/32] locking: SIX locks (shared/intent/exclusive)
Message-ID: <ZF7fJlQM4KmenDkC@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-5-kent.overstreet@linux.dev>
 <7233p553-861o-9772-n4nr-rr5424prq1r@vanv.qr>
 <ZF6oejsUGUC0gnYx@moria.home.lan>
 <o52660s0-3s6s-9n74-8666-84s2p4qpoq6@vanv.qr>
 <ZF7LJdKoHj44KzVu@moria.home.lan>
 <d0c0488e-d862-fd4d-1687-5c9fec42ef76@infradead.org>
 <ZF7XEzTT+liYXEge@moria.home.lan>
 <20230513004518.GB3033@quark.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513004518.GB3033@quark.localdomain>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 12, 2023 at 05:45:18PM -0700, Eric Biggers wrote:
> On Fri, May 12, 2023 at 08:17:23PM -0400, Kent Overstreet wrote:
> > On Fri, May 12, 2023 at 04:49:04PM -0700, Randy Dunlap wrote:
> > > 
> > > 
> > > On 5/12/23 16:26, Kent Overstreet wrote:
> > > > On Sat, May 13, 2023 at 12:39:34AM +0200, Jan Engelhardt wrote:
> > > >>
> > > >> On Friday 2023-05-12 22:58, Kent Overstreet wrote:
> > > >>> On Thu, May 11, 2023 at 02:14:08PM +0200, Jan Engelhardt wrote:
> > > >>>>> +// SPDX-License-Identifier: GPL-2.0
> > > >>>>
> > > >>>> The currently SPDX list only knows "GPL-2.0-only" or "GPL-2.0-or-later",
> > > >>>> please edit.
> > > >>>
> > > >>> Where is that list?
> > > >>
> > > >> I just went to spdx.org and then chose "License List" from the
> > > >> horizontal top bar menu.
> > > > 
> > > > Do we have anything more official? Quick grep through the source tree
> > > > says I'm following accepted usage.
> > > 
> > > Documentation/process/license-rules.rst points to spdx.org for
> > > further info.
> > > 
> > > or LICENSES/preferred/GPL-2.0 contains this:
> > > Valid-License-Identifier: GPL-2.0
> > > Valid-License-Identifier: GPL-2.0-only
> > > Valid-License-Identifier: GPL-2.0+
> > > Valid-License-Identifier: GPL-2.0-or-later
> > > SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
> > 
> > Thanks, I'll leave it at GPL-2.0 then.
> 
> https://spdx.org/licenses/GPL-2.0.html says that GPL-2.0 is deprecated.  Its
> replacement is https://spdx.org/licenses/GPL-2.0-only.html.  Yes, they mean the
> same thing, but the new names were introduced to be clearer than the old ones.

Perhaps updating LICENCES/preferred/GPL-2.0 is in order.
