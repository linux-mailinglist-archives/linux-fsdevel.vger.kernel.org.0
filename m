Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B8C14C469
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 02:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA2B3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 20:29:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57572 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgA2B3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 20:29:32 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwcAb-00443D-Pr; Wed, 29 Jan 2020 01:29:29 +0000
Date:   Wed, 29 Jan 2020 01:29:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20200129012929.GV23230@ZenIV.linux.org.uk>
References: <20200124131323.23885-1-s.hauer@pengutronix.de>
 <20200124131323.23885-2-s.hauer@pengutronix.de>
 <20200127104518.GC19414@quack2.suse.cz>
 <20200128100631.zv7cn726twylcmb7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128100631.zv7cn726twylcmb7@pengutronix.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 11:06:31AM +0100, Sascha Hauer wrote:
> Hi Jan,

> @@ -810,6 +811,36 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
>  #endif
>  }
>  
> +static struct super_block *quotactl_path(const char __user *special, int cmd,
> +					 struct path *path)
> +{
> +	struct super_block *sb;
> +	int ret;
> +
> +	ret = user_path_at(AT_FDCWD, special, LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
> +			   path);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	sb = path->mnt->mnt_sb;
> +restart:
> +	if (quotactl_cmd_onoff(cmd))
> +		down_write(&sb->s_umount);
> +	else
> +		down_read(&sb->s_umount);
> +
> +	if (quotactl_cmd_write(cmd) && sb->s_writers.frozen != SB_UNFROZEN) {
> +		if (quotactl_cmd_onoff(cmd))
> +			up_write(&sb->s_umount);
> +		else
> +			up_read(&sb->s_umount);
> +		wait_event(sb->s_writers.wait_unfrozen,
> +			   sb->s_writers.frozen == SB_UNFROZEN);
> +		goto restart;
> +	}
> +
> +	return sb;
> +}

This partial duplicate of __get_super_thawed() guts does *not* belong here,
especially not interleaved with quota-specific checks.

> +	if (q_path) {
> +		if (quotactl_cmd_onoff(cmd))
> +			up_write(&sb->s_umount);
> +		else
> +			up_read(&sb->s_umount);
> +
> +		path_put(&sb_path);
> +	} else {
> +		if (!quotactl_cmd_onoff(cmds))
> +			drop_super(sb);
> +		else
> +			drop_super_exclusive(sb);
> +	}

Er...  Why not have the same code that you've used to lock the damn thing
(needs to be moved to fs/super.c) simply get a passive ref to it?  Then
you could do the same thing, q_path or no q_path...
