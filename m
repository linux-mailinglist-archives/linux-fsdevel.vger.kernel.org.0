Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2AE275839
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 14:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIWMtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 08:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgIWMtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 08:49:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7636AC0613CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jq3gPC6qgDlnlPNRFgIfSG1TQqIyMEv4XmEAs++0L+c=; b=knHiFvcAjls/GpQNqm0JaYYrBu
        CBRwYmM2aVKaG37F5Oz77AlDpnpOX3/tPOFTJKTGfgGluY8I/kqYJzMhftSnq3JRWwkpSao7Mo1/P
        EmBqzpYMnUU5aeedq2LVPWHch6/LPMO162rriL4uOCbczcIRPOVwRqyoEvJ3yuDG5XJ3aGSlV4g86
        rtQVK+5I2pu8QL3sLkyZErbdMYwn8Jep25PKwy7jC0SjF0kJ95At9Dq8ocU5Uh5jFHHx4QGwXdlXO
        2uimPTn+U8AsYmobAUIuiuG9jNBOyka+JNib7MFmdhgn3gejKuadsNjvmmXVoPWXMOm8MyC4HLTrm
        JmrzL5rw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kL4Cw-00048J-Qi; Wed, 23 Sep 2020 12:49:14 +0000
Date:   Wed, 23 Sep 2020 13:49:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V3] fuse: Remove __GFP_FS flag to avoid allocator
 recursing
Message-ID: <20200923124914.GO32101@casper.infradead.org>
References: <1600840675-43691-1-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600840675-43691-1-git-send-email-ppvk@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:27:55AM +0530, Pradeep P V K wrote:
> Changes since V2:
> - updated memalloc_nofs_save() to allocation paths that potentially
>   can cause deadlock.

That's the exact opposite of what I said to do.  Again, the *THREAD*
is the thing which must not block, not the *ALLOCATION*.  So you
set this flag *ON THE THREAD*, not *WHEN IT DOES AN ALLOCATION*.
If that's not clear, please ask again.

