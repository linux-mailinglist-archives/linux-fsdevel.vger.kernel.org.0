Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813156C681F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 13:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCWMXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 08:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjCWMXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:23:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48811BEC;
        Thu, 23 Mar 2023 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bkZg0fteEv+ot3llQzJst6tGw3eyrfkN8Eh1a5WHKwU=; b=iebeCD1ikKCkOLi2Kft79o/EpL
        HMA54VQybdeErM4GIeYLu3XCznsTdTk8XlMk+yqVHpdkGLk0EwRnQhw1666LK2hRoyG4ptxuZrP8y
        DY5Rd7sdL6HWnn1aePKytB+WqSkUfxldpLag6fT5q55gmQLqE1ySDK6T5OkNKaKWY0+O/gk87sdvg
        urSaKqpmufPn5BZrOZFHbI9KSGtxRDNnGYGA6DBNgsBrMh7OpVvqZvudqs0Cn7D080p8efg0x9ol6
        o3SJ6PhjM6jmYlojSj+vgrS/0EGym6LDS4ui3k9TEMX3e1zXJnfAWEGf+/zIyU8IgapGgnw/DrRz1
        2QTJmtRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfJyf-003wNM-F2; Thu, 23 Mar 2023 12:23:33 +0000
Date:   Thu, 23 Mar 2023 12:23:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     gouhao@uniontech.com
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/buffer: adjust the order of might_sleep() in
 __getblk_gfp()
Message-ID: <ZBxExR3/4bphAUpF@casper.infradead.org>
References: <20230323093752.17461-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323093752.17461-1-gouhao@uniontech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:37:52PM +0800, gouhao@uniontech.com wrote:
> From: Gou Hao <gouhao@uniontech.com>
> 
> If 'bh' is found in cache, just return directly.
> might_sleep() is only required on slow paths.

You're missing the point.  The caller can't know whether the slow or
fast path will be taken.  So it must _never_ call this function if it
cannot sleep.
