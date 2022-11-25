Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0F1638405
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 07:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiKYGeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 01:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKYGeD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:34:03 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD5F28728;
        Thu, 24 Nov 2022 22:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pIHGszfecZz9CSc52vNNlxGUv062DoFdWN6o4fVm8hg=; b=DA0htORxwAaODWdcRqz68PyWA4
        iLLlTu3pAovQnRbO3EcAyGWXlWnnWB8ml0OxEL+bNjtc7URnjW6uYIjpWFyxnY1lHxX3qs3lN36KI
        5gIT1fKN4jS1lSgTm5ZxxIwkJXmutWhlmPH1upsZrtifndkP2t0+Z/bb8nKfkmVD6B0ZPtRDCOlW8
        73YyoAPAtzhARYS+UHqEVER8BFS8gYmdH52nFabs74UCQgvCooP/6wzXNs4UtFfadxylDbe4+vGxP
        vlhIIvWIUsembOOSeWs2DGGNGmrkiTL2UhtXk5tnV3wQPoPe55UXaU4MWXn1m3P3NbrS8S0JiTdpQ
        4biOYbTQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oySHZ-006blK-2p;
        Fri, 25 Nov 2022 06:33:53 +0000
Date:   Fri, 25 Nov 2022 06:33:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] pipe: fix potential use-after-free in pipe_read()
Message-ID: <Y4Bh0fTf4vZ6/6Pc@ZenIV>
References: <20221117115323.1718-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117115323.1718-1-thunder.leizhen@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:53:23PM +0800, Zhen Lei wrote:
> Accessing buf->flags after pipe_buf_release(pipe, buf) is unsafe, because
> the 'buf' memory maybe freed.

Huh?  What are you talking about?
                        struct pipe_buffer *buf = &pipe->bufs[tail & mask];
To free *buf you would need to free the entire damn array, which is
obviously not going to be possible here; if you are talking about reuse
of *buf - that's controlled by pipe->tail, and we do not assign it until
later.

Fetching any fields of *buf is safe; what can get freed is buf->page, not
buf itself.  So that buf->flags access is fine.
