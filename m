Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446196C3B30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 21:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCUUCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 16:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCUUCd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:02:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE20559EA;
        Tue, 21 Mar 2023 13:01:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5496561DF1;
        Tue, 21 Mar 2023 20:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C23C433D2;
        Tue, 21 Mar 2023 20:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679428916;
        bh=aeUK7WkObcA3ioIoyAIxBv/4CKXxT3qJju3bQdYLKI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IRYYlsqmqMfoJLVwwCAGou+jMgXv9PDz1CcWZf1VxcrhpKKnu1N85CSsaTOzkayte
         UcpcPKHDOfZffrFpgsCkfH9JkJqsrP/Sw08dTWMLW8/o1P+xgnONwL91/8tQuXngTD
         IVOeId6AFJshplT8VEaGKGqCTpAcYRKQT+KAJ8Qs=
Date:   Tue, 21 Mar 2023 13:01:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tomas Mudrunka <tomas.mudrunka@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rppt@kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net
Subject: Re: [PATCH v2] Add results of early memtest to /proc/meminfo
Message-Id: <20230321130155.dfd4ba94d093faa90213182b@linux-foundation.org>
In-Reply-To: <20230321103430.7130-1-tomas.mudrunka@gmail.com>
References: <20230317165637.6be5414a3eb05d751da7d19f@linux-foundation.org>
        <20230321103430.7130-1-tomas.mudrunka@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 21 Mar 2023 11:34:30 +0100 Tomas Mudrunka <tomas.mudrunka@gmail.com> wrote:

> Currently the memtest results were only presented in dmesg.
> This adds /proc/meminfo entry which can be easily used by scripts.

Looks good to me, thanks.  But the changelog still doesn't explain why
we should make this change.  I grabbed that from your other email and
used the below as the changelog:


: Currently the memtest results were only presented in dmesg.
: 
: When running a large fleet of devices without ECC RAM it's currently not
: easy to do bulk monitoring for memory corruption.  You have to parse
: dmesg, but that's a ring buffer so the error might disappear after some
: time.  In general I do not consider dmesg to be a great API to query RAM
: status.
: 
: In several companies I've seen such errors remain undetected and cause
: issues for way too long.  So I think it makes sense to provide a monitoring
: API, so that we can safely detect and act upon them.
: 
: This adds /proc/meminfo entry which can be easily used by scripts.

