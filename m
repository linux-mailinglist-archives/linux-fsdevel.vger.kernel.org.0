Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2FD5C165
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 18:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfGAQpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 12:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbfGAQpk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:45:40 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42B8921473;
        Mon,  1 Jul 2019 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561999539;
        bh=eiV74XYal0Mf9H7K9pE50WdL9F4uvMg5OKRaQ8xc3Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQKKG7lSldCNqBzoBW9UabsEioUzbGKIiXuBDXNGVnzkbe1GtG8uFjGnixkCDrn1O
         ikHTh4sppE5JEiYtymRxdMx99JfT/Wdfb4gefJXDrvTlwKU+IsCF3DCN1RJJ3+8eoA
         RNp7j37s/fOx9TLOU1Z2XHFUMfrhGPQC6NY/Yzjg=
Date:   Mon, 1 Jul 2019 09:45:37 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] vfs: move_mount: reject moving kernel internal mounts
Message-ID: <20190701164536.GA202431@gmail.com>
References: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629202744.12396-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629202744.12396-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 29, 2019 at 01:27:44PM -0700, Eric Biggers wrote:
> 
> Reproducer:
> 
>     #include <unistd.h>
> 
>     #define __NR_move_mount         429
>     #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
> 
>     int main()
>     {
>     	  int fds[2];
> 
>     	  pipe(fds);
>         syscall(__NR_move_mount, fds[0], "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
>     }

David, I'd like to add this as a regression test somewhere.

Can you point me to the tests for the new mount syscalls?

I checked LTP, kselftests, and xfstests, but nothing to be found.

- Eric
