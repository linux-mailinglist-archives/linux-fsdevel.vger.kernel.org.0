Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF89F95092
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 00:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfHSWNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 18:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbfHSWNs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:13:48 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF79C214DA;
        Mon, 19 Aug 2019 22:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566252827;
        bh=4OL6nVB0qLhHMLV1A+Hg935diBRpXnS4haw7ngoM9j4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kI9kp010sbLvA9Ywre7pB5dBfmLhakbFcsuorxWOsdV6NmA+5vidwNG0D1bwcxfD5
         EJ/hFdkoCAooP46shHMKoYGA4ahBsfgPgTI244f/fzMjmQ5//XKRM3TegfNa+TLMJ2
         sdG4xBNmgNek2PkqFsbwyptx/+1k3hlw6wZ10qXE=
Date:   Mon, 19 Aug 2019 15:13:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: tmpfs: fixups to use of the new mount API
Message-Id: <20190819151347.ecbd915060278a70ddeebc91@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.1908191503290.1253@eggly.anvils>
References: <alpine.LSU.2.11.1908191503290.1253@eggly.anvils>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 19 Aug 2019 15:09:14 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> Several fixups to shmem_parse_param() and tmpfs use of new mount API:
> 
> mm/shmem.c manages filesystem named "tmpfs": revert "shmem" to "tmpfs"
> in its mount error messages.
> 
> /sys/kernel/mm/transparent_hugepage/shmem_enabled has valid options
> "deny" and "force", but they are not valid as tmpfs "huge" options.
> 
> The "size" param is an alternative to "nr_blocks", and needs to be
> recognized as changing max_blocks.  And where there's ambiguity, it's
> better to mention "size" than "nr_blocks" in messages, since "size" is
> the variant shown in /proc/mounts.
> 
> shmem_apply_options() left ctx->mpol as the new mpol, so then it was
> freed in shmem_free_fc(), and the filesystem went on to use-after-free.
> 
> shmem_parse_param() issue "tmpfs: Bad value for '%s'" messages just
> like fs_parse() would, instead of a different wording.  Where config
> disables "mpol" or "huge", say "tmpfs: Unsupported parameter '%s'".

Is this

Fixes: 144df3b288c41 ("vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")?

and a Cc:stable is appropriate?
