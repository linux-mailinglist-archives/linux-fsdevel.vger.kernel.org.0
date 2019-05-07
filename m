Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEDA15708
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 02:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfEGAku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 20:40:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38036 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfEGAku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 20:40:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hNoA2-0001ab-SV; Tue, 07 May 2019 00:40:46 +0000
Date:   Tue, 7 May 2019 01:40:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     yangerkun <yangerkun@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, miaoxie@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: system panic while dentry reference count overflow
Message-ID: <20190507004046.GE23075@ZenIV.linux.org.uk>
References: <af9a8dec-98a2-896f-448b-04ded0af95f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9a8dec-98a2-896f-448b-04ded0af95f0@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 06, 2019 at 11:36:10AM +0800, yangerkun wrote:
> Hi,
> 
> Run process parallel which each code show as below(2T memory), reference
> count of root dentry will overflow since allocation of negative dentry
> should do count++ for root dentry. Then, another dput of root dentry will
> free it, which cause crash of system. I wondered is there anyone has found
> this problem?

The problem is, in principle, known - it's just that you need an obscene
amount of RAM to trigger it (you need 4G objects of some sort to hold those
references).

_If_ you have that much RAM, there's any number of ways to hit that thing -
it doesn't have to be cached results of lookups in directory as in your
testcase.  E.g. raise /proc/sys/fs/file-nr past 4Gb (you will need a lot
of RAM for that, or the thing won't let you go that high) and just keep
opening the same file (using enough processes to get around the per-process
limit, or playing with SCM_RIGHTS sendmsg to yourself, etc.)

I don't think that making dget() able to fail is a feasible approach;
there are too many callers and hundreds of brand-new failure exits
that will almost never be exercised is _the_ recipe for bitrot from
hell.

An obvious approach would be to use atomic_long_t; the problem is that
it's not atomic_t - it's lockref, which is limited to 32 bits.  Doing
a wider variant... hell knows - wider cmpxchg variants might be
usable, or we could put the upper bits into a separate word, with
cmpxchg loops in lockref_get() et.al. treating "lower bits all zero" as
"fall back to grabbing spinlock".

Linus, lockref is your code, IIRC; which variant would you consider
more feasible?

We don't have that many places looking at the refcount, fortunately.
And most of them are using d_count(dentry) (comparisons or printk).
The rest is almost all in fs/dcache.c...  So it's not as if we'd
been tied to refcount representation by arseloads of code all over
the tree.
