Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1F6C8700
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 21:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjCXUoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 16:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjCXUoj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:44:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7BD5B87
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 13:44:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4683B825E3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 20:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AC3C433D2;
        Fri, 24 Mar 2023 20:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679690675;
        bh=E+q9BVKMXnsSuuNWE3t11Nolq2S02u98RDYORR6z1P4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gK2r0F6hyL+xPnA7Ss+wNARgQvSmvU/T6PDg9lmynhkTQis67eFl1rjJPfm9I3am0
         WnaXp0n2aG7+0DrNAqrSk/Bo0XW79QN++4HmK6K4pbFCQq90TSbOl1elRfmnbC8BUp
         jrR9XJA8YXGV8MxcQ2OugFldPfQTOmru58wU9xjM=
Date:   Fri, 24 Mar 2023 13:44:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <jack@suse.cz>, <djwong@kernel.org>
Subject: Re: [PATCH] fsdax: unshare: zero destination if srcmap is HOLE or
 UNWRITTEN
Message-Id: <20230324134434.9f005404a90cb44bdb9a8c49@linux-foundation.org>
In-Reply-To: <cf8419ae-e1ce-ee8b-6346-3bcb49f59cc2@fujitsu.com>
References: <1679483469-2-1-git-send-email-ruansy.fnst@fujitsu.com>
        <20230322160311.89efea3493db4c4ccad40a25@linux-foundation.org>
        <a41f0ea1-c704-7a2e-db6d-93e8bd4fcdea@fujitsu.com>
        <20230323151112.1cc3cf57b35f2dc704ff1af8@linux-foundation.org>
        <a30006e8-2896-259e-293b-2a5d873d42aa@fujitsu.com>
        <ZB0aB7DzhzuyaM9Z@casper.infradead.org>
        <4aee7cfd-09d6-43a1-3d8c-15fe5274446b@fujitsu.com>
        <ZB0kRXVFXOJg0rQC@casper.infradead.org>
        <cf8419ae-e1ce-ee8b-6346-3bcb49f59cc2@fujitsu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 24 Mar 2023 12:28:07 +0800 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> > ie it's the data that was in whatever file happened to use that space
> > last, so this is a security bug because it's a data leak, and a backport
> > is needed, and you should have indicated that by putting a cc: stable
> > tag on the patch?
> 
> Yes, cc stable is needed.  Then should I send a new patch with the tag 
> added?

Thanks.  I updated the changelog and added cc:stable.

: unshare copies data from source to destination.  But if the source is
: HOLE or UNWRITTEN extents, we should zero the destination, otherwise
: the HOLE or UNWRITTEN part will be user-visible old data of the new
: allocated extent because it wasn't cleared.
: 
: Found by running generic/649 while mounting with -o dax=always on pmem.
