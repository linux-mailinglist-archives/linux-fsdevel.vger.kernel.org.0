Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51A73B5E0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 14:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhF1MgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 08:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232598AbhF1MgE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:36:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE94261C69;
        Mon, 28 Jun 2021 12:33:36 +0000 (UTC)
Date:   Mon, 28 Jun 2021 14:33:33 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH 1/1] xattr: Allow user.* xattr on symlink/special files
 with CAP_SYS_RESOURCE
Message-ID: <20210628123333.4lueag2a5uhdsfor@wittgenstein>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
 <20210625191229.1752531-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625191229.1752531-2-vgoyal@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 03:12:29PM -0400, Vivek Goyal wrote:
> As of now user.* xattrs are allowed only on regular files and directories.
> And in case of directories if sticky bit is set, then it is allowed
> only if caller is owner or has CAP_FOWNER.
> 
> "man xattr" suggests that primary reason behind this restrcition is that
> users can set unlimited amount of "user.*" xattrs on symlinks and special
> files and bypass quota checks. Following is from man page.
> 
> "These differences would allow users to consume filesystem resources  in
>  a  way not controllable by disk quotas for group or world writable spe‐
>  cial files and directories"
> 
> Capability CAP_SYS_RESOURCE allows for overriding disk quota limits. If
> being able to bypass quota is primary reason behind these restrictions,
> can we relax these restrictions if caller has CAP_SYS_RESOURCE.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---

I think this change is fine especially since it seems to solve a real
problem there since it prevents relabeling for virtiofsd.
