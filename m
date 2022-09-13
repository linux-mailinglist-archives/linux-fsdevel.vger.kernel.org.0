Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E875B67FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 08:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiIMGfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 02:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiIMGfj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:35:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1D71583F;
        Mon, 12 Sep 2022 23:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=URvJwIGuP97ABBt8+HgWagxhk5MVBssXZoiF39WbDV8=; b=djBs1tFnbBGK7QjEVhVFhoShmk
        oT5PaiW8JImMUkBJk97/7OgsY/wPsQZmBuwd5dMJ0kENXy+Y0+NpR3wYM8BGXDsciw9HxqnB1rxXg
        UISsSicLzm1RtnkdqqXdMYpGoyzsWe24Z05VR4VdKc2xalYt2lEmYRPenvc8QsQxw2ZvKOaY+e8Gl
        CtCkF7qEqZFn6I/8bDxOZz3mMAvqZCLD1uPtNFsxgJ31K4oGxmEf+7KoQRwB5TFcVBy35j2Hs0swY
        yWQALJky+hrEMy5fsFXIzpgif+DzxQoK+M/HWAnOQelb0MjWd5Qc1sBCEGrautpRls/hVMsGfy+Sg
        IwB5j7qQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXzVt-00GeRn-HV; Tue, 13 Sep 2022 06:35:17 +0000
Date:   Tue, 13 Sep 2022 07:35:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc/vmcore: fix potential memory leak in vmcore_init()
Message-ID: <YyAkpQNWXrkMGdYr@casper.infradead.org>
References: <20220913062501.82546-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913062501.82546-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 02:25:01PM +0800, Jianglei Nie wrote:
>  	}
> -	elfcorehdr_free(elfcorehdr_addr);
>  	elfcorehdr_addr = ELFCORE_ADDR_ERR;
>  
>  	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
>  	if (proc_vmcore)
>  		proc_vmcore->size = vmcore_size;
> -	return 0;
> +
> +fail:
> +	elfcorehdr_free(elfcorehdr_addr);
> +	return rc;
>  }

Did you test this?  It looks like you now call
elfcorehdr_free(ELFCORE_ADDR_ERR) if 'rc' is 0.
