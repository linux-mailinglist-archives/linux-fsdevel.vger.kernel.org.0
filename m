Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE3E5F20AD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Oct 2022 02:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJBAG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 20:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJBAG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 20:06:27 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067EE46613
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Oct 2022 17:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TVh1rua8AP51PGPpR+OiTnyCw3Ueh0xC9yqZX2v3FWg=; b=ityTcCS1KPNZGeiGHS6915JNnL
        L/SzLa2t3MbAKxYhT+RwE2QvjnwquzB/6yVse7RzgD+72sfns43beqFqJyHYC4+I2jQWlxIRoak2Y
        leJ3aCaVBKBgQn1NbHCP0bvNvtmENRSZA5jm5rfA03OqLTlGZU09jm6o/uqRXggoWw1+iSnnDO9h8
        xQOZV33Z7ABI7XGsWC4EWEOa8vcsLY+696EIavDOaviVl+UpP+mHYBLbTQf+lB+s+qdGZ2rNKA8fP
        bxMSV/9kp77ML4aDVoEBL58Zy6DBwn0+VguafVDJH/zhALjNFYHHDp0nqUTP9bnoZ4QSRmIGkc9EX
        ZTqisaJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oemUw-005oHF-2G;
        Sun, 02 Oct 2022 00:06:22 +0000
Date:   Sun, 2 Oct 2022 01:06:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v2 RESEND] namei: clear nd->root.mnt before O_CREAT unlazy
Message-ID: <YzjV/qCcHDH7gfLZ@ZenIV>
References: <20220923140334.514276-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923140334.514276-1-bfoster@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 10:03:34AM -0400, Brian Foster wrote:

> incompatible with O_CREAT. Otherwise the tradeoff for this change is
> that this may impact behavior when an absolute path O_CREAT lookup
> lands on a symlink that contains another absolute path. The unlazy
> sequence of the create lookup now clears the nd->root mount pointer,
> which means that once we read said link via step_into(), the
> subsequent nd_jump_root() calls into set_root() to grab the mount
> pointer again (from refwalk mode). This is historical behavior for
> O_CREAT and less common than the current behavior of a typical
> create lookup unnecessarily legitimizing the root dentry.

I'm not worried about the overhead of retrieving the root again;
using the different values for beginning and the end of pathwalk,
OTOH...

It's probably OK, but it makes analysis harder.  Do we have a real-world
testcases where the contention would be observable?
