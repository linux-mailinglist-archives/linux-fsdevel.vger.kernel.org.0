Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D564C1F96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 00:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244783AbiBWXYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 18:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbiBWXYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:24:40 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6636F4BFFB;
        Wed, 23 Feb 2022 15:24:11 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nN0zQ-004Ozy-UT; Wed, 23 Feb 2022 23:24:09 +0000
Date:   Wed, 23 Feb 2022 23:24:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     keescook@chromium.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Avoid a race in formats
Message-ID: <YhbCGDzlTWp2OJzI@zeniv-ca.linux.org.uk>
References: <20220223231752.52241-1-ppbuk5246@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223231752.52241-1-ppbuk5246@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 08:17:52AM +0900, Levi Yun wrote:
> Suppose a module registers its own binfmt (custom) and formats is like:
> 
> +---------+    +----------+    +---------+
> | custom  | -> |  format1 | -> | format2 |
> +---------+    +----------+    +---------+
> 
> and try to call unregister_binfmt with custom NOT in __exit stage.

Explain, please.  Why would anyone do that?  And how would such
module decide when it's safe to e.g. dismantle data structures
used by methods of that binfmt, etc.?

Could you give more detailed example?  Because it looks like
papering over an inherently unsafe use of binfmt interfaces...
