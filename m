Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A7755A88A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 11:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiFYJTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 05:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiFYJTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:19:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDA42F00B;
        Sat, 25 Jun 2022 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=obSv7fC50QS9GVguFIU1ed1kozCQr6nKrlMvCioHMhs=; b=UG0+S5zMfvO+mGEodQCPyJAYTw
        i9B451JBonTi4ydY0c4ycO8AD30aaMzCR75Ny43eUPt21Nw2cWgMg+AAD2x8RM4kbxrWEBpPWo8nd
        hus9/E9IYxy55q9ZVa9nJ1mnI5Q5FE5qRQARlTkoajCr+n1rKSFCDByA9RYCWZ8Phjj3+LlPLfeJ9
        EFnsEEQm1DSs55HJWBwrTtsn45l2zjBSJKt1vYP8xkwcpu7oHcqrAMZLwVdTJaqd6xs9hMd1xihyE
        uQBI5TA4QwULMxfaEDUi+N3t7RviU3EMVsmoJaoLc7diL56E9UV7/QWVRSVIK+X/ZIL2OFSnd/En8
        csEgKUvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o51xA-005J9l-3G; Sat, 25 Jun 2022 09:19:44 +0000
Date:   Sat, 25 Jun 2022 02:19:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     cgel.zte@gmail.com
Cc:     viro@zeniv.linux.org.uk, hughd@google.com, ran.xiaokai@zte.com.cn,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] drop caches: skip tmpfs and ramfs
Message-ID: <YrbTMJAuwY59CwRS@infradead.org>
References: <20220624182121.995294-1-ran.xiaokai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624182121.995294-1-ran.xiaokai@zte.com.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 06:21:21PM +0000, cgel.zte@gmail.com wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> All tmpfs and ramfs pages have PG_dirty bit set
> once they are allocated and added to the pagecache。So pages
> can not be freed from tmpfs or ramfs. So skip tmpfs and ramfs
> when drop caches.

Hard coding magic constants in VFS code is a bad idea.  If you have
numbers to justify this change (which should go into this commit log),
it can be properly solved by a flag on the super block,
file_system_type or even better bdi.
