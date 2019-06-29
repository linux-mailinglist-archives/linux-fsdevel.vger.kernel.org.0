Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4375AD5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 22:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfF2UjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 16:39:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60338 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfF2UjS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 16:39:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hhK7w-0000t7-Ol; Sat, 29 Jun 2019 20:39:16 +0000
Date:   Sat, 29 Jun 2019 21:39:16 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] vfs: move_mount: reject moving kernel internal mounts
Message-ID: <20190629203916.GV17978@ZenIV.linux.org.uk>
References: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629202744.12396-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629202744.12396-1-ebiggers@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 29, 2019 at 01:27:44PM -0700, Eric Biggers wrote:

> @@ -2600,7 +2600,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>  	if (attached && !check_mnt(old))
>  		goto out;
>  
> -	if (!attached && !(ns && is_anon_ns(ns)))
> +	if (!attached && !(ns && ns != MNT_NS_INTERNAL && is_anon_ns(ns)))
>  		goto out;
>  
>  	if (old->mnt.mnt_flags & MNT_LOCKED)

*UGH*

Applied, but that code is getting really ugly ;-/
