Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3885C081
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfGAPnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 11:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727640AbfGAPnU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:43:20 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 428EC205C9;
        Mon,  1 Jul 2019 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561995799;
        bh=+m8Ocelpq6IIEdvehzEZ7RfzLRSFhV0Ix0maHlwbSlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3WXaZ/toRpBKp2h1GgJ2CKzOjeyx7woYnDHIKnJE93FDeYQs3Q7TMmTdQddUCdG6
         l5QQzWkGSFwppS0ZtBwytsfPTWxaVHs3oxNOOPViOCbYfYW3hS2BW7DOtKwBGmSM+X
         IDbCt+3HYx0fCQ1Z5jZIY++u2tTyWCVWi85bur/8=
Date:   Mon, 1 Jul 2019 08:43:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] vfs: move_mount: reject moving kernel internal mounts
Message-ID: <20190701154317.GB790@sol.localdomain>
References: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629202744.12396-1-ebiggers@kernel.org>
 <20190629203916.GV17978@ZenIV.linux.org.uk>
 <20190701010847.GA23778@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701010847.GA23778@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 02:08:48AM +0100, Al Viro wrote:
> 
> Let's reorder that a bit:
>         /* The mountpoint must be in our namespace. */
>         if (!check_mnt(p))
>                 goto out;
> 
> 	/* The thing moved must be mounted... */
> 	if (!is_mounted(old_path->mnt))
> 		goto out;
> 
>         /* ... and either ours or the root of anon namespace */
> 	if (!(attached ? check_mnt(old) : is_anon_ns(ns)))
> 		goto out;
> 
> IMO that looks saner and all it costs us is a redundant check
> in attached case.  Objections?

Looks good to me.

- Eric
