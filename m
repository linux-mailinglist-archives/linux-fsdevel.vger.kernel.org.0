Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C255C55082C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 05:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiFSD4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 23:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiFSD4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:56:45 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F051C11C00
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 20:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tRKLSEEpIL79Dr+X8BYqnnSSVgWE2nlUMQUdVjH4UlQ=; b=OnW0J5d6BxNApXMRhY2CKtNr1Z
        Ev2E1Z11X6CRTh19XzmBZ4FHNKOZCFm93fOFtpUD5nTVN3VghNoH0jddljxXQUstJ3C8AKpsGAd8p
        pZO+nEq5B8zh+haONtfa1zIxTe2GGo+exTck4UYItLmTQ6MWBhSWOQ+assdqoBKUOsug9jij5ntsi
        dDaV3F2WlSewF6f70Qihjx8zQBlJJmgLScEl8cKs/wiKLQripIDBouzUAh/K2+Azc7V3vvxBMx36r
        yEEnDVi+uiuSYEY+0IUdfT6s7JGMOaflGWEBR/AbSpbULhdg9RSP68qqVLkoa7coyz9ApKLX7LID7
        r4cKubdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2m3F-001wId-Si;
        Sun, 19 Jun 2022 03:56:41 +0000
Date:   Sun, 19 Jun 2022 04:56:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 16/31] unify the rest of
 iov_iter_get_pages()/iov_iter_get_pages_alloc() guts
Message-ID: <Yq6eeYuzai/xe+u4@ZenIV>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
 <20220618053538.359065-17-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618053538.359065-17-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 18, 2022 at 06:35:23AM +0100, Al Viro wrote:
> -		res = get_user_pages_fast(addr, n, gup_flags, pages);
> +		if (*pages) {

		if (!*pages) {

obviously; transient - it goes away in 22/31.
