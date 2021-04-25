Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7B636A871
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 18:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhDYQvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 12:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhDYQvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 12:51:36 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B388CC061574;
        Sun, 25 Apr 2021 09:50:56 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lahyA-008Cja-Rg; Sun, 25 Apr 2021 16:50:54 +0000
Date:   Sun, 25 Apr 2021 16:50:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     haosdent <haosdent@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengyu.duan@shopee.com, Haosong Huang <huangh@sea.com>
Subject: Re: NULL pointer dereference when access /proc/net
Message-ID: <YIWd7v1U/dGivmSE@zeniv-ca.linux.org.uk>
References: <CAFt=RON+KYYf5yt9vM3TdOSn4zco+3XtFyi3VDRr1vbQUBPZ0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFt=RON+KYYf5yt9vM3TdOSn4zco+3XtFyi3VDRr1vbQUBPZ0g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 25, 2021 at 11:22:15PM +0800, haosdent wrote:
> Hi, Alexander Viro and dear Linux Filesystems maintainers, recently we
> encounter a NULL pointer dereference Oops in our production.
> 
> We have attempted to analyze the core dump and compare it with source code
> in the past few weeks, currently still could not understand why
> `dentry->d_inode` become NULL while other fields look normal.

Not really - the crucial part is ->d_count == -128, i.e. it's already past
__dentry_kill().

> [19521409.514784] RIP: 0010:__atime_needs_update+0x5/0x190

Which tree is that?  __atime_needs_update() had been introduced in
4.8 and disappeared in 4.18; anything of that age straight on mainline 
would have a plenty of interesting problems.  If you have some patches
applied on top of that...  Depends on what those are, obviously.
