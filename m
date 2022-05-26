Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265B4534DD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiEZLIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 07:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiEZLIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 07:08:15 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032BD6D842;
        Thu, 26 May 2022 04:08:14 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 74B2B1C0B8F; Thu, 26 May 2022 13:08:12 +0200 (CEST)
Date:   Thu, 26 May 2022 13:08:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Simon Ser <contact@emersion.fr>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: procfs: open("/proc/self/fd/...") allows bypassing O_RDONLY
Message-ID: <20220526110811.GB5138@localhost>
References: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

> I'm a user-space developer working on Wayland. Recently we've been
> discussing about security considerations related to FD passing between
> processes [1].
> 
> A Wayland compositor often needs to share read-only data with its
> clients. Examples include a keyboard keymap, or a pixel format table.
> The clients might be untrusted. The data sharing can happen by having
> the compositor send a read-only FD (ie, a FD opened with O_RDONLY) to
> clients.
> 
> It was assumed that passing such a FD wouldn't allow Wayland clients to
> write to the file. However, it was recently discovered that procfs
> allows to bypass this restriction. A process can open(2)
> "/proc/self/fd/<fd>" with O_RDWR, and that will return a FD suitable for
> writing. This also works when running the client inside a user namespace.
> A PoC is available at [2] and can be tested inside a compositor which
> uses this O_RDONLY strategy (e.g. wlroots compositors).
> 
> Question: is this intended behavior, or is this an oversight? If this is
> intended behavior, what would be a good way to share a FD to another
> process without allowing it to write to the underlying file?

Sounds like a bug. Not all world is Linux, and 'mount /proc' changing
security characteristics of fd passing is nasty and surprising.

We should not surprise people when it has security implications.

Best regards,
							Pavel

-- 
