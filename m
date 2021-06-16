Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAE73A9A0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 14:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhFPMTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 08:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhFPMTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:19:09 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907E2C061574;
        Wed, 16 Jun 2021 05:17:03 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltUTa-008xcq-AH; Wed, 16 Jun 2021 12:16:58 +0000
Date:   Wed, 16 Jun 2021 12:16:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chen Li <chenli@uniontech.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ramfs: skip mknod if inode already exists.
Message-ID: <YMnrutsyVKD4Ar2z@zeniv-ca.linux.org.uk>
References: <874kdyh65j.wl-chenli@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kdyh65j.wl-chenli@uniontech.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 10:53:12AM +0800, Chen Li wrote:
> 
> It's possible we try to mknod a dentry, which have
> already bound to an inode, just skip it.

Caller should have checked may_create(), which includes EEXIST handling.
NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

Incidentally, if it ever had been called that way, your variant would
leak inode.  Not the main problem, though...
