Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C49A55412D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354898AbiFVEGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiFVEGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347A42F6
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A68E56184A
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jun 2022 04:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C951BC34114;
        Wed, 22 Jun 2022 04:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655870791;
        bh=d8kO0pd6SehiNxbelIWiffhc3qVb0CqkrbDktfpqwQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=shAuaogFOzo2o4EifANHQGgC02yBZ3Ep/88NvKjIL3/+MiIAk4CCcWb8pyBeg5YeI
         nRxopH0pGtkhBzNmCBM4w01ARD7n5wRzrCTvWrwVuT4IG3nRmvjNPA63Txmf7gLUSv
         rxrUmUwyPMM4Td0rbvt1ur9Nk5F1Va170buUfKWTxg/lGFRwuLwAbN87R3s0eaU/Yk
         aC1dGdzxPsS0gbuhqHmtIOsWut0u7YsaMZ9R/esLxVkCKRxIlGGIXqa+g8sjtapL45
         +CYZ5qzDB6oHLFqEybacuO19mkjDTgIIDcrAbOr3K9YDBx/wQEJoOn5maOgCyniRQP
         PxR6TFwEt0zfw==
Date:   Wed, 22 Jun 2022 06:06:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 8/8] attr: port attribute changes to new types
Message-ID: <20220622040624.lak6hccs6z4vmrzv@wittgenstein>
References: <20220621141454.2914719-1-brauner@kernel.org>
 <20220621141454.2914719-9-brauner@kernel.org>
 <CAHk-=wgSWHmLQtRr0v60utSEtbNk5PO8rkxJhhy2TkmvZoR7nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgSWHmLQtRr0v60utSEtbNk5PO8rkxJhhy2TkmvZoR7nw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 21, 2022 at 12:33:04PM -0500, Linus Torvalds wrote:
> On Tue, Jun 21, 2022 at 9:15 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > The other nice effect is that filesystems like overlayfs don't need to
> > care about idmappings explicitly anymore and can simply set up struct
> > iattr accordingly directly.
> 
> Btw, do we have any actual tests for this situation?

Absolutely! In fact, I made it so that the whole xfstests testsuite can
be run on top of idmapped mounts with overlayfs:

FSTYP=xfs
export TEST_DEV=/dev/sda3
export SCRATCH_DEV=/dev/sda4
export TEST_DIR=/mnt/test
export SCRATCH_MNT=/mnt/scratch
export IDMAPPED_MOUNTS=true

sudo ./check -overlay

from the README I added:

 - set IDMAPPED_MOUNTS=true to run all tests on top of idmapped mounts. While                   
   this option is supported for all filesystems currently only -overlay is                      
   expected to run without issues. For other filesystems additional patches                     
   and fixes to the test suite might be needed.

That's __in addition__ to the whole idmapped mounts testsuite which is
part of xfstests and which also covers overlayfs (e.g. in generic/692).
