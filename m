Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05226C72C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 23:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCWWLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 18:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCWWLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:11:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C751F92D
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 15:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B596B8227E
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 22:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA892C433D2;
        Thu, 23 Mar 2023 22:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679609473;
        bh=yNzdXs0jlKa5oEb92maO/avegSZEB8iOyQikXYKNFeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MKMZJsBo3JVwF/EwV+ZZiu/BL2/G6BUDxJNzwFdFV1c9bnvrQ9sglF83b3IwZE85c
         +HeLbn4sGozma+ZCDAmOlNJINZGiAbjdpCwO2heqzE98p5JsbnGz4igtWlVfKSD5Z7
         sCRd2OCA7JYR8BrZG9jeXysK1e59jUtVYVhpcaqQ=
Date:   Thu, 23 Mar 2023 15:11:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <djwong@kernel.org>
Subject: Re: [PATCH] fsdax: unshare: zero destination if srcmap is HOLE or
 UNWRITTEN
Message-Id: <20230323151112.1cc3cf57b35f2dc704ff1af8@linux-foundation.org>
In-Reply-To: <a41f0ea1-c704-7a2e-db6d-93e8bd4fcdea@fujitsu.com>
References: <1679483469-2-1-git-send-email-ruansy.fnst@fujitsu.com>
        <20230322160311.89efea3493db4c4ccad40a25@linux-foundation.org>
        <a41f0ea1-c704-7a2e-db6d-93e8bd4fcdea@fujitsu.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Mar 2023 14:50:38 +0800 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> 
> 
> 在 2023/3/23 7:03, Andrew Morton 写道:
> > On Wed, 22 Mar 2023 11:11:09 +0000 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> > 
> >> unshare copies data from source to destination. But if the source is
> >> HOLE or UNWRITTEN extents, we should zero the destination, otherwise the
> >> result will be unexpectable.
> > 
> > Please provide much more detail on the user-visible effects of the bug.
> > For example, are we leaking kernel memory contents to userspace?
> 
> This fixes fail of generic/649.

OK, but this doesn't really help.  I'm trying to determine whether this
fix should be backported into -stable kernels and whether it should be
fast-tracked into Linus's current -rc tree.

But to determine this I (and others) need to know what effect the bug
has upon our users.
