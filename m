Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81971452965
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 06:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbhKPFMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 00:12:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243280AbhKPFMS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:12:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2E8461A6C;
        Tue, 16 Nov 2021 05:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637039360;
        bh=GWgVUr1tOeQPllh9l2xS/tGKpZOm9t/Ms3FlnLUhw1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fwL0kwVa/4GGpvh8OnAB2is8WhAyTWcfBW7W3tlP+Fci8Sj6FNrpq5yA76D0ta+sW
         QtCEaUraWOXsxcvByS0cmG+kd0S2GnWblA4rGVCwR/OUuSm0PkRw/Q7LPOfc6/uNDO
         dwX7nbYsPkqkAdND8NkNim1/hsFab9MI/rtHHtVI=
Date:   Mon, 15 Nov 2021 21:09:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     adobriyan@gmail.com, gladkov.alexey@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] remove PDE_DATA()
Message-Id: <20211115210917.96f681f0a75dfe6e1772dc6d@linux-foundation.org>
In-Reply-To: <20211101093518.86845-1-songmuchun@bytedance.com>
References: <20211101093518.86845-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon,  1 Nov 2021 17:35:14 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> I found a bug [1] some days ago, which is because we want to use
> inode->i_private to pass user private data. However, this is wrong
> on proc fs. We provide a specific function PDE_DATA() to get user
> private data. Actually, we can hide this detail by storing
> PDE()->data into inode->i_private and removing PDE_DATA() completely.
> The user could use inode->i_private to get user private data just
> like debugfs does. This series is trying to remove PDE_DATA().

Why can't we do

/*
 * comment goes here
 */
static inline void *PDE_DATA(struct inode *inode)
{
	return inode->i_private;
}

to abstract things a bit and to reduce the patch size?

otoh, that upper-case thing needs to go, so the patch size remains the
same anyway.

And perhaps we should have a short-term

#define PDE_DATA(i) pde_data(i)

because new instances are sure to turn up during the development cycle.

But I can handle that by staging the patch series after linux-next and
reminding myself to grep for new PDE_DATA instances prior to
upstreaming.
