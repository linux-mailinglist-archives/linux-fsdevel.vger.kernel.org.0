Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B542A74E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 01:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfEYXIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 May 2019 19:08:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58920 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfEYXIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 May 2019 19:08:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hUfmQ-0007tt-IP; Sat, 25 May 2019 23:08:46 +0000
Date:   Sun, 26 May 2019 00:08:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/23] NFS: Add fs_context support.
Message-ID: <20190525230846.GP17978@ZenIV.linux.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
 <155862834550.26654.17230477291010963688.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155862834550.26654.17230477291010963688.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 05:19:05PM +0100, David Howells wrote:

>  out_no_data:
> -	dfprintk(MOUNT, "NFS: mount program didn't pass any mount data\n");
> -	return -EINVAL;
> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
> +		ctx->skip_reconfig_option_check = true;
> +		return 0;
> +	}

That really ought to be
	if (fc->root) { /* remount */
		ctx->skip_reconfig_option_check = true;
		return 0;
	}
and similar in the v4 counterpart.  fc->purpose is a bad idea; it is
possible to get rid of it.

Frankly, I'm tempted to add

static inline bool is_remount_fc(struct fs_context *fc)
{
	return fc->root != NULL;
}

and just use that in such places...
