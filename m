Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6A22A82EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 17:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgKEQBt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 11:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKEQBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:01:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCADC0613CF;
        Thu,  5 Nov 2020 08:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=rLThOPXKIwNo2OJAxZQtS2as82b92rbvpNs/8J7TzUQ=; b=bNXNQb2ePw8Wm/CDkfDBU9fCEw
        0+Jecahd0Jq1vhI5x0j38zpnS6M9HzQYoDeKs8+G4AAhxit2CobkzNNN3ef7RPxuFvk8AQ3FaQNqo
        CiNFGvzzLcHiSbiDiSzJLtlt3cLoI6ObH74D7CinKfd5hFhb6R9pugxc34nvVg+shCzR8cerhjM1w
        1Ky231OOuhnUyvraqCSl7vkpCE938UQFUZEwZAW5rJb8Mt+fnm3Gk7rhRpz8k3yxouLmiYARv3hLv
        Z3CfLORlCNZ5f2vDgqyVgoRZawrlzsZK75Jgn5dFtTT6MKtBwWHEEGhXCj5fXzJl5rha7evGRM/bJ
        hrQENEjw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kahhr-0002yr-9H; Thu, 05 Nov 2020 16:01:47 +0000
Date:   Thu, 5 Nov 2020 16:01:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: bcachefs-for-review
Message-ID: <20201105160147.GO17076@casper.infradead.org>
References: <20201027200433.GA449905@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201027200433.GA449905@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 04:04:33PM -0400, Kent Overstreet wrote:
> Here's where bcachefs is at and what I'd like to get merged:
> 
> https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-for-review

When building for x86-32 (ie make allnoconfig, enable BLOCK, enable BCACHEFS):

../fs/bcachefs/util.h:40: warning: "memcpy" redefined
   40 | #define memcpy(dst, src, len)      \
../arch/x86/include/asm/string_32.h:182: note: this is the location of the previous definition
  182 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)

In function ‘journal_seq_copy’,
    inlined from ‘__bch2_create’ at ../fs/bcachefs/fs.c:291:3:
../arch/x86/include/asm/cmpxchg.h:128:3: error: call to ‘__cmpxchg_wrong_size’ declared with attribute error: Bad argument size for cmpxchg
which comes from:
../fs/bcachefs/fs.c:52:16: note: in expansion of macro ‘cmpxchg’
   52 |  } while ((v = cmpxchg(&dst->ei_journal_seq, old, journal_seq)) != old);

... and similar problems elsewhere in fs.c.
