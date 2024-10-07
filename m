Return-Path: <linux-fsdevel+bounces-31165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3189992A49
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4AAB220E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 11:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547A51D1E7A;
	Mon,  7 Oct 2024 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9uZIOmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6715101C4
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300950; cv=none; b=Uzy8lIKGzasYLgfk/XB1aeF9E4lFs/nb5WTVxYAtWl9dVkcVR1VCdImoi5u+XHhY80dkD46juU8d2d0Q5ZqxJgwgrUUUvTKTeBIMpkFronI8KRwmuBsHqUuFY/vY7Rqhveorxu18Eq9HzK6eCiRV7QfQtHovpsSbVELm2cezETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300950; c=relaxed/simple;
	bh=ExKbvQRI59nD5ZMwmjywvVJv7FMUpq4qs89AG+vLOVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAwmrEGKoSCoADAqwpRI+AE/83ZqYgtnxv21xhlNbhg1xbY3xpPwYrtZQOr+sHZci542MHOQ+hskwlHZD1M+OUqkjN15Bz9kprUXnqvguo9q5uV7jGDohLQ/OfL4Et2RIXzCmV4rI0cGBsjsTL5lKPIniLXuV9KmK+zWlp89syM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9uZIOmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D63C4CEC6;
	Mon,  7 Oct 2024 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728300950;
	bh=ExKbvQRI59nD5ZMwmjywvVJv7FMUpq4qs89AG+vLOVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9uZIOmHqzcJgOt4HVOEph+iRZunjAuniSYZE9C65r/KP5PMRM6X0GzmRxWBYMXib
	 p/Eg4DiKZC+cO8RPUdVlCfweFjUSOfzk3W8gWbGocH6IPJ9IQ8sJbhqh79ekmfakiM
	 Xvpa5FrbWzK+ftuKDBTBmLBYe6pPaaiNAOWRYmSMs+veyCaQ1CCyS+S9JOpR7NzAoW
	 4LuHxDi6MIlQDBPe2ujHhNxtOq0augGFUJydCaa/MUMv9x3rU7IIAT2y7R9gtq9C9H
	 NCe3ztXdyQLQ2Isy2T7TJiVyPPalm/PWVqiwbv11zXbBGCmiIFcY55lE7G8cx/aBpg
	 PA0RbpmD+3ScA==
Date: Mon, 7 Oct 2024 13:35:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Allison Karlitskaya <allison.karlitskaya@redhat.com>, 
	Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Subject: Re: Incorrect error message from erofs "backed by file" in 6.12-rc
Message-ID: <20241007-zwietracht-flehen-1eeed6fac1a5@brauner>
References: <CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com>
 <bb781cf6-1baf-4a98-94a5-f261a556d492@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb781cf6-1baf-4a98-94a5-f261a556d492@linux.alibaba.com>

On Sat, Oct 05, 2024 at 10:41:10PM GMT, Gao Xiang wrote:
> Hi Allison,
> 
> (try to +Cc Christian)
> 
> On 2024/10/2 20:58, Allison Karlitskaya wrote:
> > hi,
> > 
> > In context of my work on composefs/bootc I've been testing the new support for directly mounting files with erofs (ie: without a loopback device) and it's working well.  Thanks for adding this feature --- it's a huge quality of life improvement for us.
> > 
> > I've observed a strange behaviour, though: when mounting a file as an erofs, if you read() the filesystem context fd, you always get the following error message reported: Can't lookup blockdev.
> > 
> > That's caused by the code in erofs_fc_get_tree() trying to call get_tree_bdev() and recovering from the error in case it was ENOTBLK and CONFIG_EROFS_FS_BACKED_BY_FILE.  Unfortunately, get_tree_bdev() logs the error directly on the fs_context, so you get the error message even on successful mounts.
> > > It looks something like this at the syscall level:
> > 
> > fsopen("erofs", FSOPEN_CLOEXEC)         = 3
> > fsconfig(3, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0
> > fsconfig(3, FSCONFIG_SET_STRING, "source", "/home/lis/src/mountcfs/cfs", 0) = 0
> > fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = 0
> > fsmount(3, FSMOUNT_CLOEXEC, 0)          = 5
> > move_mount(5, "", AT_FDCWD, "/tmp/composefs.upper.KuT5aV", MOVE_MOUNT_F_EMPTY_PATH) = 0
> > read(3, "e /home/lis/src/mountcfs/cfs: Can't lookup blockdev\n", 1024) = 52
> > 
> > This is kernel 6.12.0-0.rc0.20240926git11a299a7933e.13.fc42.x86_64 from Fedora Rawhide.
> > 
> > It's a pretty minor issue, but it sent me on a wild goose chase for an hour or two, so probably it should get fixed before the final release.
> > 
> 
> Sorry for late response. I'm on vacation recently.
> 
> Yes, I also observed this message, but I'm not sure
> how to handle it better.  Indeed, the message itself
> is out of get_tree_bdev() as you said.
> 
> Yet I tend to avoid unnecessary extra lookup_bdev()
> likewise to confirm the type of the source in advance,
> since the majority mount type of EROFS is still
> bdev-based instead file-based so I tend to make
> file-based mount as a fallback...
> 
> Hi Christian, if possible, could you give some other
> idea to handle this case better? Many thanks!

(1) Require that the path be qualified like:

    fsconfig(<fd>, FSCONFIG_SET_STRING, "source", "file:/home/lis/src/mountcfs/cfs", 0)

    and match on it in either erofs_*_get_tree() or by adding a custom
    function for the Opt_source/"source" parameter.

(2) Add a erofs specific "source-file" mount option. IOW, check that
    either "source-file" or "source" was specified but not both. You
    could even set fc->source to "source-file" value and fail if
    fc->source is already set. You get the idea.

?

