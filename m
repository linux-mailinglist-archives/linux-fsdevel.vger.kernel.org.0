Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645A8524A6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 12:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352690AbiELKiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 06:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352688AbiELKiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 06:38:09 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0231A5F8DE
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 03:38:06 -0700 (PDT)
Date:   Thu, 12 May 2022 10:37:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1652351884;
        bh=7NmTfOCxDVAfqJ/9f/2B3RstZoJLD303Bp1OuJZ4KeA=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=f02r2AQ9t/AYTiq+emcHSWiFf7xzC6rrO/toal82g03MsexLkvGgplJ0P5CKchR8S
         g4eoOKwjW1BQR8oTTpIl47owvv8yGQCYGhmfVO9EnqRx5iHVzi0kZ7Vd6xopnD5UcZ
         dmKBGRYEkFpP90/ZrWYsrJvwiQbUS8p2z4CAi0p7AlMvraDeer8W6IFjEYiz0wo5Nq
         A1sDfALlDtQXUoeNAt+KeLNLtxDfqJ5MSh2K8o5ghWwJquNznQyhB4aWo0o9ftN49N
         mFCs0jrkfBpCbz4eWI8b2x/aWtWhZA7OXni+hP52rheqU8StS77chUp8xhBxbmoEuP
         Ccbjj/059/lcw==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   Simon Ser <contact@emersion.fr>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: procfs: open("/proc/self/fd/...") allows bypassing O_RDONLY
Message-ID: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I'm a user-space developer working on Wayland. Recently we've been
discussing about security considerations related to FD passing between
processes [1].

A Wayland compositor often needs to share read-only data with its
clients. Examples include a keyboard keymap, or a pixel format table.
The clients might be untrusted. The data sharing can happen by having
the compositor send a read-only FD (ie, a FD opened with O_RDONLY) to
clients.

It was assumed that passing such a FD wouldn't allow Wayland clients to
write to the file. However, it was recently discovered that procfs
allows to bypass this restriction. A process can open(2)
"/proc/self/fd/<fd>" with O_RDWR, and that will return a FD suitable for
writing. This also works when running the client inside a user namespace.
A PoC is available at [2] and can be tested inside a compositor which
uses this O_RDONLY strategy (e.g. wlroots compositors).

Question: is this intended behavior, or is this an oversight? If this is
intended behavior, what would be a good way to share a FD to another
process without allowing it to write to the underlying file?

Thanks,

Simon

[1]: https://gitlab.freedesktop.org/wayland/wayland-protocols/-/issues/92
[2]: https://paste.sr.ht/~emersion/eac94b03f286e21f8362354b6af032291c00f8a7
