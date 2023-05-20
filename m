Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6569970A937
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjETQgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 12:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjETQgG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 12:36:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C68121;
        Sat, 20 May 2023 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rv8xCl7UF34ZL8KiQut7NKFWj7AzkqkzdaOdf/a3SmU=; b=HFQgMq2Omh71TPIaLXTcvdLQvA
        V2hDQuirA4xIvbtDTaLaKAgzz6tl5Qcv9ZUZnVCCFiXG2nVYQdRny6/n4CZvMPHlbkZYOhrw6b934
        ixvILds8DKrnjYonjtqECDPMNbdXQQMG86Yr7ewsei5GABM975RFNPM0tWgXE0PYiWhJEHfXffct0
        973/lQNzI9x4GdxPciftgGF0YSW1yXNcWNqOvyioSUWv267E+S7C+bFW3yFNJwBZR0cvqsd0EL5e9
        HywUjBP4vvTE98RRwlCVAmZgGYB6CC4Ko6rbubO3I7RfdSl4C9XRKeMdLfaUb3GriWy9KN8w2DOn/
        pJkWrj4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q0PYe-007WlD-UZ; Sat, 20 May 2023 16:35:52 +0000
Date:   Sat, 20 May 2023 17:35:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Creating large folios in iomap buffered write path
Message-ID: <ZGj26E4rD52Qfe10@casper.infradead.org>
References: <20230519105528.1321.409509F4@e16-tech.com>
 <ZGeX9Oc5vTkrceLZ@casper.infradead.org>
 <20230520213531.38CB.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520213531.38CB.409509F4@e16-tech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 09:35:32PM +0800, Wang Yugui wrote:
> test result of the second version of the patch.
> 
> # dmesg |grep 'index\|suppressed'
> [   89.376149] index:0 len:292 order:2
> [   97.862938] index:0 len:4096 order:2
> [   98.340665] index:0 len:4096 order:2
> [   98.346633] index:0 len:4096 order:2
> [   98.352323] index:0 len:4096 order:2
> [   98.359952] index:0 len:4096 order:2
> [   98.364015] index:3 len:4096 order:2
> [   98.368943] index:0 len:4096 order:2
> [   98.374285] index:0 len:4096 order:2
> [   98.379163] index:3 len:4096 order:2
> [   98.384760] index:0 len:4096 order:2
> [  181.103751] iomap_get_folio: 342 callbacks suppressed
> [  181.103761] index:0 len:292 order:2

Thanks.  Clearly we're not creating large folios in the write path.
I tracked it down, and used your fio command.  My system creates 1MB
folios, so I think yours will too.  Patch series incoming (I fixed a
couple of other oversights too).
