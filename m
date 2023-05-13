Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5CA701381
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 May 2023 02:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241213AbjEMAq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 20:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241556AbjEMAqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 20:46:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392255581;
        Fri, 12 May 2023 17:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7469659AB;
        Sat, 13 May 2023 00:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE2BC433D2;
        Sat, 13 May 2023 00:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683938720;
        bh=J1v1lWDIjaH8025JinHj9kLr52snJuHzkWc9f4ELNIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0sjjObYN2zfjDyEBegldm8wLlTKwrq2CxVCTx28eFPh+kmSPvu5DjBFlWjX+Lh3Y
         YiNO2ul3R3EHG9jzhHMvTOvgk6410ow2XuLiftvE2UGXF/yWkzXzKixxiwe85XU7mR
         NaMSUKo4zu7IqDU9Wn2L5tSJAlK48qeKCEVufy3zn9VBcMLZxf54dPQEyq68SZMkgP
         wpltBPnWOvK3uMV6/bgf8IIaFVG9p4R5g4Fw6WZtJfb+8KHm3zInov1Wh6FUuxtlEp
         m7mDv86gzmLaACsMR3zNSlcZu3SgAZ6kAbWFx0hqKFBGlc9Kge0BKrRob70gqIXbNq
         eFdOs+Kyh+2Vw==
Date:   Fri, 12 May 2023 17:45:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 04/32] locking: SIX locks (shared/intent/exclusive)
Message-ID: <20230513004518.GB3033@quark.localdomain>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-5-kent.overstreet@linux.dev>
 <7233p553-861o-9772-n4nr-rr5424prq1r@vanv.qr>
 <ZF6oejsUGUC0gnYx@moria.home.lan>
 <o52660s0-3s6s-9n74-8666-84s2p4qpoq6@vanv.qr>
 <ZF7LJdKoHj44KzVu@moria.home.lan>
 <d0c0488e-d862-fd4d-1687-5c9fec42ef76@infradead.org>
 <ZF7XEzTT+liYXEge@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZF7XEzTT+liYXEge@moria.home.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 12, 2023 at 08:17:23PM -0400, Kent Overstreet wrote:
> On Fri, May 12, 2023 at 04:49:04PM -0700, Randy Dunlap wrote:
> > 
> > 
> > On 5/12/23 16:26, Kent Overstreet wrote:
> > > On Sat, May 13, 2023 at 12:39:34AM +0200, Jan Engelhardt wrote:
> > >>
> > >> On Friday 2023-05-12 22:58, Kent Overstreet wrote:
> > >>> On Thu, May 11, 2023 at 02:14:08PM +0200, Jan Engelhardt wrote:
> > >>>>> +// SPDX-License-Identifier: GPL-2.0
> > >>>>
> > >>>> The currently SPDX list only knows "GPL-2.0-only" or "GPL-2.0-or-later",
> > >>>> please edit.
> > >>>
> > >>> Where is that list?
> > >>
> > >> I just went to spdx.org and then chose "License List" from the
> > >> horizontal top bar menu.
> > > 
> > > Do we have anything more official? Quick grep through the source tree
> > > says I'm following accepted usage.
> > 
> > Documentation/process/license-rules.rst points to spdx.org for
> > further info.
> > 
> > or LICENSES/preferred/GPL-2.0 contains this:
> > Valid-License-Identifier: GPL-2.0
> > Valid-License-Identifier: GPL-2.0-only
> > Valid-License-Identifier: GPL-2.0+
> > Valid-License-Identifier: GPL-2.0-or-later
> > SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
> 
> Thanks, I'll leave it at GPL-2.0 then.

https://spdx.org/licenses/GPL-2.0.html says that GPL-2.0 is deprecated.  Its
replacement is https://spdx.org/licenses/GPL-2.0-only.html.  Yes, they mean the
same thing, but the new names were introduced to be clearer than the old ones.

- Eric
