Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EADE517B049
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 22:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCEVJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 16:09:17 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36694 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbgCEVJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:09:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 055BA8EE244;
        Thu,  5 Mar 2020 13:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583442556;
        bh=bwLxcbAMeiwR4V5t5j/2Pgb9y0sCJg8lpag1/gaMX4I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z002gCaT9Bv+LNhT1zzAelNOJx8Sn99IIMgwWq2pi8Al2rhVrMiAlNe9k24zlpIJW
         KcJuj++sODDmzmsLZKN01N67CP6PlXKVvpm6LzSVcn18AVJnZgnJt76tJclclMD7I0
         6UxCMikXzOJpIToOz59LLGtnaAtEt0DLFuCAoG6c=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b_2eVtIUKL5X; Thu,  5 Mar 2020 13:09:15 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 214EB8EE149;
        Thu,  5 Mar 2020 13:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583442555;
        bh=bwLxcbAMeiwR4V5t5j/2Pgb9y0sCJg8lpag1/gaMX4I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QcVt/DZ+0mZCFOp3LqQTPAdo2Z+BV7tr8LUIPRyBz1edQzlAEXhv1zxJqj24c5vrA
         lLGdf+4rcy/GKe8BWjXi6iUJ61sIFfI0/c3oGC3fNXrL/+pPTIc7pkZrAYm/UV9h28
         QKZeAziu7qiGQXwxztOLqshv9sf27yezCyoKTzoQ=
Message-ID: <1583442550.3927.47.camel@HansenPartnership.com>
Subject: Re: [PATCH] mnt: add support for non-rootfs initramfs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ignat Korchagin <ignat@cloudflare.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com
Date:   Thu, 05 Mar 2020 13:09:10 -0800
In-Reply-To: <20200305193511.28621-1-ignat@cloudflare.com>
References: <20200305193511.28621-1-ignat@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-03-05 at 19:35 +0000, Ignat Korchagin wrote:
> The main need for this is to support container runtimes on stateless
> Linux system (pivot_root system call from initramfs).
> 
> Normally, the task of initramfs is to mount and switch to a "real"
> root filesystem. However, on stateless systems (booting over the
> network) it is just convenient to have your "real" filesystem as
> initramfs from the start.
> 
> This, however, breaks different container runtimes, because they
> usually use pivot_root system call after creating their mount
> namespace. But pivot_root does not work from initramfs, because
> initramfs runs form rootfs, which is the root of the mount tree and
> can't be unmounted.

Can you say more about why this is a problem?  We use pivot_root to
pivot from the initramfs rootfs to the newly discovered and mounted
real root ... the same mechanism should work for a container (mount
namespace) running from initramfs ... why doesn't it?

The sequence usually looks like: create and enter a mount namespace,
build a tmpfs for the container in some $root directory then do


    cd $root
    mkdir old-root
    pivot_root . old-root
    mount --
make-rprivate /old-root
    umount -l /old-root
    rmdir /old-root

Once that's done you're disconnected from the initramfs root.  The
sequence is really no accident because it's what the initramfs would
have done to pivot to the new root anyway (that's where container
people got it from).


James

