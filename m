Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72CF7A0B2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 19:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbjINRCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 13:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbjINRCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:02:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6937F1BDF;
        Thu, 14 Sep 2023 10:02:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F43C433CA;
        Thu, 14 Sep 2023 17:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694710925;
        bh=l8U0R882UtrX6c4wSnmZ8eAWwspRftMv3tML/Tshxmc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hbf+Gg6+9qIT7vIuiysYz8LuPoX5GdeWLaoXfFpSEXKc6HOY00TmjolqH2cNyjeO3
         p29VJ2yrJ9QX58uYaHmd+qllDetVqP+Spj5eKWL9OMjIuCIbAte82lBnWHIxMZswla
         WSaJsNGIdAPNQ8IMYHu6TLDcoMb3XSJwZGC/EtG8=
Date:   Thu, 14 Sep 2023 10:02:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Greg Ungerer <gerg@uclinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
Subject: Re: [PATCH] proc: nommu: /proc/<pid>/maps: release mmap read lock
Message-Id: <20230914100203.e5905ee145b7cb580c8df9c4@linux-foundation.org>
In-Reply-To: <20230914163019.4050530-2-ben.wolsieffer@hefring.com>
References: <20230914163019.4050530-2-ben.wolsieffer@hefring.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 14 Sep 2023 12:30:20 -0400 Ben Wolsieffer <ben.wolsieffer@hefring.com> wrote:

> The no-MMU implementation of /proc/<pid>/map doesn't normally release
> the mmap read lock, because it uses !IS_ERR_OR_NULL(_vml) to determine
> whether to release the lock. Since _vml is NULL when the end of the
> mappings is reached, the lock is not released.
> 
> This code was incorrectly adapted from the MMU implementation, which
> at the time released the lock in m_next() before returning the last entry.
> 
> The MMU implementation has diverged further from the no-MMU version
> since then, so this patch brings their locking and error handling into
> sync, fixing the bug and hopefully avoiding similar issues in the
> future.

Thanks.  Is this bug demonstrable from userspace?  If so, how?
