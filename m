Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B3F7442FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 21:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjF3Tz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 15:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjF3Tzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:55:55 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3595719AF;
        Fri, 30 Jun 2023 12:55:51 -0700 (PDT)
Date:   Fri, 30 Jun 2023 21:55:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688154949; bh=qO2t88Qohwhj2xIJpyQRKbtASY9ZCj2av7m7ovm4rCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7jHlr6ZvfqHkHfCM7qxuvEZBCyGZWZp0h7lhmKP7eq62Pq8RWEhgKhdO8VrrD7e2
         fA0ESdp+sJ5lR1fRjIn4XAvXZDqRNdGvkzaCPNgSRKcAsz+LE1sO8HJZ6iqM3BRJsz
         5jycqMz6TJ4hJs5IeHH8nLrAnZz4uip7lFQyYpBQ=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Willy Tarreau <w@lwt.eu>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH] mm: make MEMFD_CREATE into a selectable config option
Message-ID: <534f113b-546b-4795-83a1-b87b67727302@t-8ch.de>
References: <20230630-config-memfd-v1-1-9acc3ae38b5a@weissschuh.net>
 <20230630153236.GD11423@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230630153236.GD11423@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-06-30 08:32:36-0700, Darrick J. Wong wrote:
> On Fri, Jun 30, 2023 at 11:08:53AM +0200, Thomas Weißschuh wrote:
> > The memfd_create() syscall, enabled by CONFIG_MEMFD_CREATE, is useful on
> > its own even when not required by CONFIG_TMPFS or CONFIG_HUGETLBFS.
> 
> If you don't have tmpfs or hugetlbfs enabled, then what fs ends up
> backing the file returned by memfd_create()?  ramfs?

ramfs, correct.

It goes via mm/memfd.c -> mm/shmem.c -> fs/ramfs/ .

Thomas

> (Not an objection, I'm just curious...)
> 
> --D
> 
> > Split it into its own proper bool option that can be enabled by users.
> > 
> > Move that option into mm/ where the code itself also lies.
> > Also add "select" statements to CONFIG_TMPFS and CONFIG_HUGETLBFS so
> > they automatically enable CONFIG_MEMFD_CREATE as before.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  fs/Kconfig | 5 ++---
> >  mm/Kconfig | 3 +++
> >  2 files changed, 5 insertions(+), 3 deletions(-)

> [..]
