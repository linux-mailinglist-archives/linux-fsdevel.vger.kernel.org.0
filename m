Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C526238B7BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 21:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhETTqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 15:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbhETTqt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 15:46:49 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557AAC061574;
        Thu, 20 May 2021 12:45:27 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ljobZ-00Gvlp-Bb; Thu, 20 May 2021 19:45:13 +0000
Date:   Thu, 20 May 2021 19:45:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kurz <groug@kaod.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 1/5] fuse: Fix leak in fuse_dentry_automount() error
 path
Message-ID: <YKa8SZ8s6QeKZ4XP@zeniv-ca.linux.org.uk>
References: <20210520154654.1791183-1-groug@kaod.org>
 <20210520154654.1791183-2-groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520154654.1791183-2-groug@kaod.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 05:46:50PM +0200, Greg Kurz wrote:
> Some rollback was forgotten during the addition of crossmounts.

Have you actually tested that?  Because I strongly suspect that
by that point the ownership of fc and fm is with sb and those
should be taken care of by deactivate_locked_super().
