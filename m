Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7465E5892DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 21:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiHCTqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 15:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiHCTqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:46:30 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D821D307;
        Wed,  3 Aug 2022 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ypV51LSC2yLMN8naik/AVolcR5swmIC7+UCe5lt32x0=; b=k1CL8+0uDNr3/hJG7V3DswqHe6
        t/Rz+U7fIA8MsFqtjQpBeBhmV9WX1tdcw3qexjJ5OUN34MsE+hpXZ1SIR3LJwQlQppA9TL2vxnwwk
        7EicddrS3b7NLPKiMozXtEXU4Flv60OD3ao/v6WjBqVQTnKbWC8B1deiHGBuFOsePNCUYBmc0YS6G
        Eq5UgLjfGoO02vjxWMHm73wgrzYmIW10km3JtZLIs7/NLy0mxfmT9HVJyoZchITqOrmSU+wYZJI6S
        tUXX+ihpQSbVPkd93esen0HFlIi9vwvoSdlsHSIqBMFM+SEmSbpcyOdsLRD2WsNacJgsxmFWi+VjN
        Mf70bO8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oJKK2-000vYN-C1;
        Wed, 03 Aug 2022 19:46:26 +0000
Date:   Wed, 3 Aug 2022 20:46:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: [git pull] vfs.git 9p fix
Message-ID: <YurQkunyW5lfS9DH@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.9p

for you to fetch changes up to f615625a44c4e641460acf74c91cedfaeab0dd28:

  9p: handling Rerror without copy_from_iter_full() (2022-06-09 10:01:34 -0400)

----------------------------------------------------------------
	net/9p abuses iov_iter primitives - attempts to copy _from_
a destination-only iov_iter when it handles Rerror arriving in reply to
zero-copy request.  Not hard to fix, fortunately; it's a prereq for the
iov_iter_get_pages() work in the second part of iov_iter series,
ended up in a separate branch.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      9p: handling Rerror without copy_from_iter_full()

 net/9p/client.c       | 86 +--------------------------------------------------
 net/9p/trans_virtio.c | 34 ++++++++++++++++++++
 2 files changed, 35 insertions(+), 85 deletions(-)
