Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3F631195F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 04:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhBFDDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 22:03:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230497AbhBFCvz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:51:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0C2364FFE;
        Fri,  5 Feb 2021 23:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612568749;
        bh=Pr7WM4tsg/J35Ck/YdPrRlNAqyJGCBTFnW6SViKvg+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R5/w6LL/l/5MQ3s4um0Uu/BR3/k3Ti0xT2rRqXouM/uVIohxIu+FMZgSbunGSBs68
         mWrlLvl/kON51NM67TTxRuI35eQgjUnkfyrsmS93513iIJHdHMt3JVQ+vVdlQlY4xV
         uOlDmG1tkEIhblCx1yr3hfHl6QHpWHevhsC68JIk=
Date:   Fri, 5 Feb 2021 15:45:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yang Guo <guoyang2@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] fs/buffer.c: Add checking buffer head stat before clear
Message-Id: <20210205154548.49dd62b161b794b9f29026f1@linux-foundation.org>
In-Reply-To: <1612332890-57918-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1612332890-57918-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 3 Feb 2021 14:14:50 +0800 Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:

> From: Yang Guo <guoyang2@huawei.com>
> 
> clear_buffer_new() is used to clear buffer new stat. When PAGE_SIZE
> is 64K, most buffer heads in the list are not needed to clear.
> clear_buffer_new() has an enpensive atomic modification operation,
> Let's add checking buffer head before clear it as __block_write_begin_int
> does which is good for performance.

Did this produce any measurable improvement?

Perhaps we should give clear_buffer_x() the same optimization as
set_buffer_x()?


static __always_inline void set_buffer_##name(struct buffer_head *bh)	\
{									\
	if (!test_bit(BH_##bit, &(bh)->b_state))			\
		set_bit(BH_##bit, &(bh)->b_state);			\
}									\
static __always_inline void clear_buffer_##name(struct buffer_head *bh)	\
{									\
	clear_bit(BH_##bit, &(bh)->b_state);				\
}									\


