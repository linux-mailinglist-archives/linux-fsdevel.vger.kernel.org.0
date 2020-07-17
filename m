Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BB522459C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 23:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGQVJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 17:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgGQVJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 17:09:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD044C0619D2;
        Fri, 17 Jul 2020 14:09:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595020153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3w+ao2j8ay23f31a30wpVaCk0kihcfgtNCvHELIfRFU=;
        b=1kzl0sfrZ7taaFJmHtXuxb+2+VK3RzOThFfpi6WPS/pjMerD2iOCqo4Gh7rnioDjwH1+fM
        AwKOHJvhwwjtvHIGTEYF5BHu23HGtbsS7pvtrnUCZ6Cuy4Kf4fz+ld0s4baEGjsd3KJE2H
        ER10e82G0mJ697THBRhbrYUhfv2NiXLZzEI/or0BiWM0u6GeSCt72+pIKzuidRcznDoXC8
        ezclLO9EPYws2ZSEafNYRULhuO//6+Y146WjQd08qbG5UHuobz+gFoV/Qo1KaYf7KBUKDZ
        cvCOqikRObZX26pZSiDnkDcElVGXgGdsIt/Xvvmpdh7pyqo2JK6vRaMWG9Np3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595020153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3w+ao2j8ay23f31a30wpVaCk0kihcfgtNCvHELIfRFU=;
        b=kww5M3lRBUaackEbMwnaUu4Ao/j/lsU7sZWKX2eJvhwKqoqhE6Hcxea2IS+zxjtWCk1cG+
        EV4p26b8gB7gKGDQ==
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/23] seq_file: switch over direct seq_read method calls to seq_read_iter
In-Reply-To: <20200707174801.4162712-16-hch@lst.de>
References: <20200707174801.4162712-1-hch@lst.de> <20200707174801.4162712-16-hch@lst.de>
Date:   Fri, 17 Jul 2020 23:09:13 +0200
Message-ID: <87eep9rgqu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Switch over all instances used directly as methods using these sed
> expressions:
>
> sed -i -e 's/\.read\(\s*=\s*\)seq_read/\.read_iter\1seq_read_iter/g'

This sucks, really. I just got a patch against this converting the
changed version to DEFINE_SHOW_ATTRIBUTE(somefile) and thereby removing
the whole open coded gunk.

If we do a tree wide change like this, then can we pretty please use a
coccinelle script to convert all trivial instances to use
DEFINE_SHOW_ATTRIBUTE so we don't have to touch the same place over and
over.

Out of 375 places changed in your patch something about 2/3rd fall into
the trivial category:

static int debug_stats_open(struct inode *inode, struct file *filp)
{
	return single_open(filp, debug_stats_show, NULL);
}

static const struct file_operations debug_stats_fops = {
	.open		= debug_stats_open,
	.read		= seq_read,
	.llseek		= seq_lseek,
	.release	= single_release,
};

which can be replaced by:

DEFINE_SHOW_ATTRIBUTE(debug_stats);

removing 12 lines of gunk and one central place to do the iter change.

I'm pretty sure that quite some of the others which have only an
additional write function can be replaced by a new macro
DEFINE_RW_ATTRIBUTE() or such.

Needs some thought and maybe some cocci help from Julia, but that's way
better than this brute force sed thing which results in malformed crap
like this:

static const struct file_operations debug_stats_fops = {
	.open		= debug_stats_open,
	.read_iter		= seq_read_iter,
	.llseek		= seq_lseek,
	.release	= single_release,
};

and proliferates the copy and paste voodoo programming.

Thanks,

        tglx
