Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B03275E27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 19:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgIWRDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 13:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIWRD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:03:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97BEC0613CE;
        Wed, 23 Sep 2020 10:03:29 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kL8As-004fka-To; Wed, 23 Sep 2020 17:03:23 +0000
Date:   Wed, 23 Sep 2020 18:03:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
Cc:     avagin@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] fsopen: fsconfig syscall restart fix
Message-ID: <20200923170322.GP3421308@ZenIV.linux.org.uk>
References: <20200923164637.13032-1-alexander.mikhalitsyn@virtuozzo.com>
 <20200923164637.13032-2-alexander.mikhalitsyn@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923164637.13032-2-alexander.mikhalitsyn@virtuozzo.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 07:46:36PM +0300, Alexander Mikhalitsyn wrote:
> During execution of vfs_fsconfig_locked function we can get ERESTARTNOINTR
> error (or other interrupt error). But we changing fs context fc->phase
> field to transient states and our entry fc->phase checks in switch cases
> (see FS_CONTEXT_CREATE_PARAMS, FS_CONTEXT_RECONF_PARAMS) will always fail
> after syscall restart which will lead to returning -EBUSY to the userspace.
> 
> The idea of the fix is to save entry-time fs_context phase field value and
> recover fc->phase value to the original one before exiting with
> "interrupt error" (ERESTARTNOINTR or similar).

If you have e.g. vfs_create_tree() fail in the middle of ->get_tree(),
the only thing you can do to that thing is to discard it.  The state is
*NOT* required to be recoverable after a failure exit - quite a bit of
config might've been consumed and freed by that point.

CREATE and RECONFIGURE are simply not restartable.
