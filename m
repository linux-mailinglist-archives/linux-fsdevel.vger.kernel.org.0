Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146CF49DD65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 10:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiA0JLJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 04:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiA0JLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:11:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89AAC061714;
        Thu, 27 Jan 2022 01:11:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81CD161AA8;
        Thu, 27 Jan 2022 09:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B89C340E4;
        Thu, 27 Jan 2022 09:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643274667;
        bh=hzv6BBLBmy3v1zyFdlGFfXIlH/vYw+ko+X4k+Zwpdb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lytURb+uK4yu32zgERAJBLoC3F/nHoC+NIY5i8kN7AqkSiJnN2kOj46tyuAtUbKME
         vXh6ru25JsfHnDF6KcyBOIlLSXhkDDNBnJN593umDr6CKQB2kRXIW9vr4N8TRTJCz/
         K8/8EfmrsIXvD8anW9n7vlvE7ib7Uo0nx4eIuHXIfuawHbLNSYj9Djzs31D3zoAhdD
         jgohlWp6qhfHdtT7itwnB0zcW+lheU76aA0LEMxGX69muue8Z2nsm8+2JMVadpJttn
         qlyF+9Yguo/o5crqm/zAqaQviOb/M9C9TNIpyBA2iJcej0SmE2bV9fsVCxpJ+hN+zj
         O5iikH0o8Fjsw==
Date:   Thu, 27 Jan 2022 10:11:03 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Subject: Re: [PATCHSET 0/4] vfs: actually return fs errors from ->sync_fs
Message-ID: <20220127091103.yfmqj3u3fzxegrq3@wittgenstein>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
 <20220126082153.mz5prdistkkvc6bc@wittgenstein>
 <20220126180507.GB13499@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220126180507.GB13499@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:05:07AM -0800, Darrick J. Wong wrote:
> On Wed, Jan 26, 2022 at 09:21:53AM +0100, Christian Brauner wrote:
> > On Tue, Jan 25, 2022 at 06:18:09PM -0800, Darrick J. Wong wrote:
> > > Hi all,
> > > 
> > > While auditing the VFS code, I noticed that while ->sync_fs is allowed
> > > to return error codes to reflect some sort of internal filesystem error,
> > > none of the callers actually check the return value.  Back when this
> > > callout was introduced for sync_filesystem in 2.5 this didn't matter
> > 
> > (Also, it looks like that most(/none?) of the filesystems that
> > implemented ->sync_fs around 2.5/2.6 (ext3, jfs, jffs2, reiserfs etc.)
> > actually did return an error?
> 
> Yes, some of them do -- ext4 will bubble up jbd2 errors and the results
> of flushing the bdev write cache.
> 
> > In fact, 5.8 seems to be the first kernel to report other errors than
> > -EBADF since commit 735e4ae5ba28 ("vfs: track per-sb writeback errors
> > and report them to syncfs"?)
> 
> Yeah.  I think the bdev pagecache flush might occasionally return errors
> if there happened to be dirty pages, but (a) that doesn't help XFS which
> has its own buffer cache and (b) that doesn't capture the state "fs has
> errored out but media is fine".
> 
> As it is I think the ext4 syncfs needs to start returning EIO if someone
> forced a shutdown, and probably some auditing for dropped error codes
> due to the 'traditional' vfs behavior.  btrfs probably ought to return
> the result of filemap_flush too.

Makes sense. Fwiw,
Acked-by: Christian Brauner <brauner@kernel.org>
