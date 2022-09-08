Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0085B18FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 11:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiIHJmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 05:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiIHJmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:42:22 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CBE1197B8;
        Thu,  8 Sep 2022 02:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662630141;
  x=1694166141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RsTH7ifEluKq6XX/DunK8Ba8dE7uhbH5m6Q9/jEy/qU=;
  b=FMOJr7Db/2yT5w0nf2NHFa77MHrr+1/oI86jgPpjZOwSxtU6Xxm1N6fN
   NOZU2Y/kL0cP1tKayC2IpOJ/NuITBUO2BgFdfRAQ0ceSjSaqsIR17cWfh
   58+KmL2LZRRF4ByGC5ONQTlJg4xI1L/jQ1yjc0ijPOuOhoKgfIGftfGKd
   +bIikI94VZ+u00yAjaC1UsJMIRm3samHlf3x8/ndZYSwfGnQ4vS9ildHd
   HHSgh7U/Nr20tCjz08kLRBxhqKYqEbgu3P7xIbiDiBnPFvemBbpgy+vTu
   389Mn1yTVtct6lUcFC+0PsY07v+LDNSIEP13XzcPfVWpTuSaXTaQrAIbH
   A==;
Date:   Thu, 8 Sep 2022 11:42:18 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] process /proc/PID/smaps vs /proc/PID/smaps_rollup
Message-ID: <Yxm4+rGMLtHLUmMU@axis.com>
References: <20200929020520.GC871730@jagdpanzerIV.localdomain>
 <20200929024018.GA529@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200929024018.GA529@jagdpanzerIV.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 29, 2020 at 11:40:18AM +0900, Sergey Senozhatsky wrote:
> On (20/09/29 11:05), Sergey Senozhatsky wrote:
> > One of our unprivileged daemon process needs process PSS info. That
> > info is usually available in /proc/PID/smaps on per-vma basis, on
> > in /proc/PID/smaps_rollup as a bunch of accumulated per-vma values.
> > The latter one is much faster and simpler to get, but, unlike smaps,
> > smaps_rollup requires PTRACE_MODE_READ, which we don't want to
> > grant to our unprivileged daemon.
> > 
> > So the question is - can we get, somehow, accumulated PSS info from
> > a non-privileged process? (Iterating through all process' smaps
> > vma-s consumes quite a bit of CPU time). This is related to another
> > question - why do smaps and smaps_rollup have different permission
> > requirements?
> 
> Hold on, seems that I misread something, /proc/PID/smaps is also
> unavailable. So the question is, then, how do we get PSS info of
> a random user-space process from an unprivileged daemon?

smaps contains a lot of sensitive information, but perhaps smaps_rollup
could be allowed without ptrace rights if the range information is
masked.  I've posted a patch here:

 https://lore.kernel.org/linux-mm/20220908093919.843346-1-vincent.whitchurch@axis.com/
