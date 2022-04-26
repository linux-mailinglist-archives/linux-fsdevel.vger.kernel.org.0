Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF72F510AAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 22:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353626AbiDZUoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 16:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355024AbiDZUnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DF749914
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 13:40:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC6596151B
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 20:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221DDC385AA;
        Tue, 26 Apr 2022 20:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651005640;
        bh=m3EnwfXk6DtQPECRxwI5v+20YXlRoL0JD2lndq+PKck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uvFYy+ug4Qb0uxKKXF6271/kiEEWoRtATZn6EHFqB4Lh4KulxjQIVvl0Ij2uHQFAX
         ogDd40GfWye7p++M+anZRZQY8rMVVY1BOump7bnwo4BTcSYTLURLyZNwEO8MZzoTm7
         tdmdxD3denOG+JeUmJ6m0cUhjfTscBtQeR7zOA1k=
Date:   Tue, 26 Apr 2022 13:40:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        willy@infradead.org, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v7 4/6] gen_init_cpio: fix short read file handling
Message-Id: <20220426134039.4f6f864141577229a01ad8be@linux-foundation.org>
In-Reply-To: <20220404093429.27570-5-ddiss@suse.de>
References: <20220404093429.27570-1-ddiss@suse.de>
        <20220404093429.27570-5-ddiss@suse.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon,  4 Apr 2022 11:34:28 +0200 David Disseldorp <ddiss@suse.de> wrote:

> When processing a "file" entry, gen_init_cpio attempts to allocate a
> buffer large enough to stage the entire contents of the source file.
> It then attempts to fill the buffer via a single read() call and
> subsequently writes out the entire buffer length, without checking that
> read() returned the full length, potentially writing uninitialized
> buffer memory.

That was rather rude of it.

> Fix this by breaking up file I/O into 64k chunks and only writing the
> length returned by the prior read() call.

Does this change fix any known or reported problems?
