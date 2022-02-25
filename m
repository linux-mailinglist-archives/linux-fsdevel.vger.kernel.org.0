Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C14C46E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 14:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiBYNt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 08:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiBYNt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:49:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514191D9B67;
        Fri, 25 Feb 2022 05:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MPuHGeakBb0lLUUKu9y63JbVCmoE2AOMbAVttJ8N+D4=; b=N3m/G9CCBBYsgc6DJ6SRSE6WeG
        PZE/NCL8X/mwWkFXKq7t3UbaBpUKAGhesV34TPVmsAMSUA14Uw8fsP72abrKyQDMIlpm4ENFPxNTs
        TP873xRVtUIwcFDsn2M2vkYJNwJO5cTRix/2+k1XFF5bIkCwep7ELlx1l8lpKQsGjS6bHy0xTmYmK
        OqTZe+EQi+/tn8vZf9SpVxgnovHHZLS3AU7iv+l5arfMKLmf7hT4R1eHf+RQKTbuPXwOCK6R4VW/v
        H2SAhIN343LuD1tQtBcHSNV/IdFNmwTLUSnSt7tdeOyJELtqOj0FCh+5UiXCVgOVTcFrIfZaEqtFp
        Q8rOYz2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNayF-005pPJ-0t; Fri, 25 Feb 2022 13:49:19 +0000
Date:   Fri, 25 Feb 2022 13:49:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ioannis Angelakopoulos <jaggel@bu.edu>
Subject: Re: [LSF/MM/BPF TOPIC] Enabling change notification for network and
 cluster fs
Message-ID: <YhjeX0HvXbED65IM@casper.infradead.org>
References: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
 <Yhf+FemcQQToB5x+@redhat.com>
 <CAH2r5mt6Sh7qorfCHWnZzc6LUDd-s_NzGB=sa-UDM2-ivzpmAQ@mail.gmail.com>
 <YhjYSMIE2NBZ/dGr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhjYSMIE2NBZ/dGr@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:23:20AM -0500, Vivek Goyal wrote:
> What about local events. I am assuming you want to supress local events
> and only deliver remote events. Because having both local and remote
> events delivered at the same time will be just confusing at best.

This paragraph confuses me.  If I'm writing, for example, a file manager
and I want it to update its display automatically when another task alters
the contents of a directory, I don't care whether the modification was
done locally or remotely.

If I understand the SMB protocol correctly, it allows the client to take
out a lease on a directory and not send its modifications back to the
server until the client chooses to (or the server breaks the lease).
So you wouldn't get any remote notifications because the client hasn't
told the server.
