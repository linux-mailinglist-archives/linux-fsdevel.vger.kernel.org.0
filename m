Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484E6515518
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 22:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380498AbiD2UGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 16:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359680AbiD2UGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:06:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820C432996
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8MDpJ7jgFg08FdnKZsV+QprI8ywAQ6xn9uKTmLKEvxk=; b=qMJi22+CPh9NhYIdtTeP0G5M14
        cAFtG1rzZfME7H/xtRxMuT5M+sF2c5CaKswp0wzdgtvpvWYAR/UXRY26/MY1BS7WTjJIBXNwlDGKi
        Iv1MmPoSfb9r0IgtnR1lcyw4ZIF+/1DZcx1dVtahoqE0L0FP9rAlOJbVnkOWl1oHKSONmkY+2seX6
        TnkYgssRM1ExdsvPJiMFmvpEjUuPZczY/6xn3waDPijihgCU4jPM0AqO2NkqDsfE5dPwboUTHYp6o
        FRk7g2uFkvJfCJ6nCt1nEvd5ZQmgasdNox5cd98AzEk+tGdWl3klOv1qTLs0pKh2E2vFSTugy0TG2
        jcurReHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkWpP-00Ckpk-B5; Fri, 29 Apr 2022 20:02:59 +0000
Date:   Fri, 29 Apr 2022 21:02:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kari Argillander <kari.argillander@stargateuniverse.net>,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH v2] fs/ntfs3: validate BOOT sectors_per_clusters
Message-ID: <YmxEc3jLLylGqxsD@casper.infradead.org>
References: <20220429200100.22659-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429200100.22659-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:01:00PM -0700, Randy Dunlap wrote:
> When the NTFS BOOT sectors_per_clusters field is > 0x80,
> it represents a shift value. Make sure that the shift value is
> not too large (> 31) before using it. Return 0xffffffff if it is.
> 
> This prevents negative shift values and shift values that are
> larger than the field size.
> 
> Prevents this UBSAN error:
> 
>  UBSAN: shift-out-of-bounds in ../fs/ntfs3/super.c:673:16
>  shift exponent -192 is negative
> 
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
