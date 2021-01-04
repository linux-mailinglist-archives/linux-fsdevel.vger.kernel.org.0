Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240042E9E55
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 20:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbhADTwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 14:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhADTwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:52:11 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7E8C061574;
        Mon,  4 Jan 2021 11:51:30 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwVt1-006rin-V2; Mon, 04 Jan 2021 19:51:28 +0000
Date:   Mon, 4 Jan 2021 19:51:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Kyle Anderson <kylea@netflix.com>,
        Manas Alekar <malekar@netflix.com>
Subject: Re: [PATCH] fs: Validate flags and capabilities before looking up
 path in ksys_umount
Message-ID: <20210104195127.GN3579531@ZenIV.linux.org.uk>
References: <20201223102604.2078-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223102604.2078-1-sargun@sargun.me>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 23, 2020 at 02:26:04AM -0800, Sargun Dhillon wrote:
> ksys_umount was refactored to into split into another function
> (path_umount) to enable sharing code. This changed the order that flags and
> permissions are validated in, and made it so that user_path_at was called
> before validating flags and capabilities.
> 
> Unfortunately, libfuse2[1] and libmount[2] rely on the old flag validation
> behaviour to determine whether or not the kernel supports UMOUNT_NOFOLLOW.
> The other path that this validation is being checked on is
> init_umount->path_umount->can_umount. That's all internal to the kernel.
> 
> [1]: https://github.com/libfuse/libfuse/blob/9bfbeb576c5901b62a171d35510f0d1a922020b7/util/fusermount.c#L403
> [2]: https://github.com/karelzak/util-linux/blob/7ed579523b556b1270f28dbdb7ee07dee310f157/libmount/src/context_umount.c#L813

Sorry, I don't like that solution.  If nothing else, it turns path_umount() into
a landmine for the future.  Yes, we have a regression, yes, we need to do something
about it, but that's not a good way to do that.

FWIW, I would rather separate the check of flags validity from can_umount()
and lift _that_ into ksys_umount(), with "path_umount() relies upon the
flags being minimally sane" comment slapped at path_umount() definition.
The rest of can_umount() really shouldn't be taken out of there.
