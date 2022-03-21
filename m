Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A3A4E2C0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 16:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350111AbiCUPXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 11:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350018AbiCUPWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:22:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE754B1D9;
        Mon, 21 Mar 2022 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yjHmNUrTcsfBaaW2FV8OWLDc9yEfNnCQ4g7zaOGPWqs=; b=pM6u9L8P999sXYeV/U2ZFRYDSN
        SpEi168deMKZu9jl3PQ2+oOchdAFGkGuEC8zT6guPBzxs5YkCKUmjvKUW9zwv8NvHCPKYaEiecS6t
        7VDVjvBg6ESSZ7MQQSSqB+OuszsrOOcQ14kdJXG6liG6oe206cC7QFz1vnR8MkQVWicnRzRQGHMkm
        KVQrS63cEIfBON47cvlquRNC6Q8lsctQWTLO3kSRia4x42KS8uZKD+iflz4S52GmkYIpS8C1LJEWU
        frUF02UGLNlLqQ483T3LkqrTp9wKwK6BcXpsUOb61xFDTBMJAcp2KcnNDS6QpmMBXA2tqs1xBARiC
        FbIDCPkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWJqI-00Ah2w-Dv; Mon, 21 Mar 2022 15:21:10 +0000
Date:   Mon, 21 Mar 2022 15:21:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Message-ID: <YjiX5oXYkmN6WrA3@casper.infradead.org>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <YjiAVezd5B9auhcP@casper.infradead.org>
 <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com>
 <YjiLACenpRV4XTcs@casper.infradead.org>
 <adb957da-8909-06d8-1b2c-b8a293b37930@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb957da-8909-06d8-1b2c-b8a293b37930@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 21, 2022 at 11:18:05PM +0800, JeffleXu wrote:
> >> Besides, IMHO read-write lock shall be more performance friendly, since
> >> most cases are the read side.
> > 
> > That's almost never true.  rwlocks are usually a bad idea because you
> > still have to bounce the cacheline, so you replace lock contention
> > (which you can see) with cacheline contention (which is harder to
> > measure).  And then you have questions about reader/writer fairness
> > (should new readers queue behind a writer if there's one waiting, or
> > should a steady stream of readers be able to hold a writer off
> > indefinitely?)
> 
> Interesting, I didn't notice it before. Thanks for explaining it.

No problem.  It's hard to notice.

> BTW what I want is just
> 
> ```
> PROCESS 1		PROCESS 2
> =========		=========
> #lock			#lock
> set DEAD state		if (not DEAD)
> flush xarray		   enqueue into xarray
> #unlock			#unlock
> ```
> 
> I think it is a generic paradigm. So it seems that the spinlock inside
> xarray is already adequate for this job?

Absolutely; just use xa_lock() to protect both setting & testing the
flag.
