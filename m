Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5DD523641
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 16:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245166AbiEKOyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245135AbiEKOyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 10:54:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768432013B0;
        Wed, 11 May 2022 07:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lY5s4swBg7qFq+qfj+bTaun5I4OB95sIbgcujXJp3Do=; b=CsqWIYBIQLAIUxJyn/xWGZA8eg
        HuXtCkWYNU3FffXGdn2FgBsC1nKJcM8xIDu3fQ4LZw6ZvnA20X4dqBHtufRXTnwttYrOkqRfex88v
        wKmAqbJjGM1NJmaUiQFdZEIwp5ezZngDhjKQvgGtb4Ezb5ct1Qd8bMal70JPYECrJbMF1fFQP66kO
        CxbS818lbwsP5L1jdDHgTiqo9sXpYYa4NR4WSGdnXKCImJmZVl6g0XVbIqyWkdWcDErpZtVQ+6FzW
        JsYSTfLcr6KSrVxmCWKhoCRGN/uCgeRw1w0wyAj+lS0DKl4yvf4j66a443+aNjaYo/Urz9L/PMgkL
        d80VtVog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nonjC-007KxH-7q; Wed, 11 May 2022 14:54:14 +0000
Date:   Wed, 11 May 2022 07:54:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/2] fs/super: Add a flag to mark super block defunc
Message-ID: <YnvOFt3sC/XLJj05@infradead.org>
References: <20220511013057.245827-1-dlunev@chromium.org>
 <20220511113050.1.Ifc059f4eca1cce3e2cc79818467c94f65e3d8dde@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511113050.1.Ifc059f4eca1cce3e2cc79818467c94f65e3d8dde@changeid>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 11:30:56AM +1000, Daniil Lunev wrote:
> File system can mark a block "defunc" in order to prevent matching
> against it in a new mount.

Why use a bool instead of using s_iflags?

Also I suspect we should never reuse a force mounted superblock,
but at least for block devices we should also not allow allocating
a new one for that case but just refuse the mount.
