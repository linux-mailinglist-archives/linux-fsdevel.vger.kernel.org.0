Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282FA530132
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 08:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiEVGJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 02:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiEVGJO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 02:09:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFA73C704;
        Sat, 21 May 2022 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f8vODVBPPT4aieHBVtPQZPwEE8oetsAgiBP0SHP03Ns=; b=dVrwKB+az4x8MRcYyIRObMC3Kz
        0/Lk5RsZ/uHq7rxWTwLfDctoffMnHd/XYI6CywnbwDoBtQ0kGP0IAReMVRjqBcN7i0SOfz0WyQzjA
        72LMGsN8V9ohaRMa+yuZL8XoU9VwEiQiE2PgbZvQra5fAtbw50/0JLdprjgLYkqxfuWFiZ6BP/ylm
        NxxYXDcrYvan5XviHSu6Iu2oEMAP9rTCG164FVGAiNtLsWVSqGCba2HcD3pGV4AYzuLQExeQAeT4l
        L1Dtehj+OTr3rq74yGZS0MDlKvD/f3IME9yzaWi1wHGZN47KQaz/+4mUl1RmIeJIrS4yLTIpAl1X9
        obWQzOxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsekq-000fUe-8y; Sun, 22 May 2022 06:07:52 +0000
Date:   Sat, 21 May 2022 23:07:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     keescook@chromium.org, pmladek@suse.com, bcain@quicinc.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, mcgrof@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, arnd@arndb.de,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, v.narang@samsung.com,
        onkarnath.1@samsung.com
Subject: Re: [PATCH 0/5] kallsyms: make kallsym APIs more safe with scnprintf
Message-ID: <YonTOL4zC4CytVrn@infradead.org>
References: <CGME20220520083715epcas5p400b11adef4d540756c985feb20ba29bc@epcas5p4.samsung.com>
 <20220520083701.2610975-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520083701.2610975-1-maninder1.s@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 02:06:56PM +0530, Maninder Singh wrote:
> kallsyms functionality depends on KSYM_NAME_LEN directly.
> but if user passed array length lesser than it, sprintf
> can cause issues of buffer overflow attack.
> 
> So changing *sprint* and *lookup* APIs in this patch set
> to have buffer size as an argument and replacing sprintf with
> scnprintf.

This is still a pretty horrible API.  Passing something like
a struct seq_buf seems like the much better API here.  Also with
the amount of arguments and by reference passing it might be worth
to pass them as a structure while you're at it.

