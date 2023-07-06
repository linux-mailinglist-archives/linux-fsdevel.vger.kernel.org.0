Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23807749F28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjGFOho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjGFOhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:37:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD27010F5;
        Thu,  6 Jul 2023 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=baht0WSMZ6QbZM7pntmZjkkjFnLfU481ZUm81KibBA4=; b=X0+ZV0gap58VSs2uIfMFpkbEJf
        x6AtYUJWe4uER2c03zE0niPknfxHoSLbdWmPzjJx+EoXBduZ+/GnPN0+4IxD+D2xME6glwrK6iWou
        Ylj5KzcGYagn1hvcb7+E1hKb9IHJFIPqjRv92s5TMRoN5+ZNr1nxw2rLJbO3i7aKUmolj2RoGdy+U
        V9VcpZbTdLaN8qLwRtFjBbIuUop/Kf/7jWpPZE4p0AZQKj9Li+PkEfkmhc7qVvEj/1e8XZ+D19KdN
        zy/ozN7aaZEYB9U5bK/N03hXRcuLmF5F5hiA0yCSJteaHM/A7vadQyCfFlf4iE57iwSpFzkdgMVUV
        kHYihmeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHQ6y-001t1W-02;
        Thu, 06 Jul 2023 14:37:36 +0000
Date:   Thu, 6 Jul 2023 07:37:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Hou Tao <houtao@huaweicloud.com>,
        Alexey Gladkov <legion@kernel.org>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v1] fs: Add kfuncs to handle idmapped mounts
Message-ID: <ZKbRrziFf4tf09vo@infradead.org>
References: <c35fbb4cb0a3a9b4653f9a032698469d94ca6e9c.1688123230.git.legion@kernel.org>
 <babdf7a8-9663-6d71-821a-34da2aff80e2@huaweicloud.com>
 <20230704-anrollen-beenden-9187c7b1b570@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704-anrollen-beenden-9187c7b1b570@brauner>
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

On Tue, Jul 04, 2023 at 03:01:21PM +0200, Christian Brauner wrote:
> That's too much stability for my taste for these helpers. The helpers
> here exposed have been modified multiple times and once we wean off
> idmapped mounts from user namespaces completely they will change again.
> So I'm fine if they're traceable but not as kfuncs with any - even
> minimal - stability guarantees.

I fully agree.  I also don't think any eBPF program has any business
looking at idmapping.
