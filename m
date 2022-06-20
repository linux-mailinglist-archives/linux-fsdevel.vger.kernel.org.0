Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1CE551250
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 10:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbiFTIPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 04:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbiFTIPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:15:23 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6611182B;
        Mon, 20 Jun 2022 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1655712922;
  x=1687248922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xq6zEn6uVMYjR4CpQtb8F3SebvExuhNNdlj7lnspcBY=;
  b=ZwdZLzcmmcy3NkeppwiDnc8SrgBe/O6JgGlxpcHzngDjZQdjv0ak7i/O
   wbx2H0o2dGydIpF16/4JpMSE6G/Zlj1sZ+y0ghE8cYt4m1T1p21LXEKBb
   Cgdss51q3H3wCZGvX/xzsYMmUXN7eti2hdRtIffOGovY/o2gAUc3sZaIZ
   DfmNxTOzTWZqzOXEZb9a2sjbWnAtnOmwowEDJdnr28T3AHl3qS0XLNWc6
   XxrGvLml+teduxXTVhis3stw54Cu7RI1n7Qmkt75lmi4GIGv6wqNmNjDy
   CpdyUWcKSl2VP6eAlifScKvN9A92T0IHpAXs3aatM1ei+ymuIXBQ05n3q
   w==;
Date:   Mon, 20 Jun 2022 10:15:19 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     kernel <kernel@axis.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] mm/smaps: add Pss_Dirty
Message-ID: <20220620081518.GA26066@axis.com>
References: <20220620081251.2928103-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220620081251.2928103-1-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 20, 2022 at 10:12:50AM +0200, Vincent Whitchurch wrote:
> Pss is the sum of the sizes of clean and dirty private pages, and the
> proportional sizes of clean and dirty shared pages:
> 
>  Private = Private_Dirty + Private_Clean
>  Shared_Proportional = Shared_Dirty_Proportional + Shared_Clean_Proportional
>  Pss = Private + Shared_Proportional
> 
> The Shared*Proportional fields are not present in smaps, so it is not
> always possible to determine how much of the Pss is from dirty pages and
> how much is from clean pages.  This information can be useful for
> measuring memory usage for the purpose of optimisation, since clean
> pages can usually be discarded by the kernel immediately while dirty
> pages cannot.
> 
> The smaps routines in the kernel already have access to this data, so
> add a Pss_Dirty to show it to userspace.  Pss_Clean is not added since
> it can be calculated from Pss and Pss_Dirty.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---

I forgot to include the changelog:

  v2:
  - Update Documentation/ABI/testing/procfs-smaps_rollup and
    Documentation/filesystems/proc.rst.
  - Move Pss_Dirty next to Pss so that the location is consistent between
    non-rollup and rollup (since the later has some extra Pss* fields).
