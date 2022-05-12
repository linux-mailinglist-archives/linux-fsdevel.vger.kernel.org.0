Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D32524D28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353890AbiELMjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 08:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353892AbiELMjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 08:39:04 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C2362136
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 05:39:03 -0700 (PDT)
Date:   Thu, 12 May 2022 12:38:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1652359137;
        bh=1bDLbtT4qPpVkhxVZ9YG4YTO1unO0O6HGenM4HeSJ2w=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=V/DCcifQUB+ddK2jWtHHqRxmowantA3oMaNHU+uKPhjqqLt6tXyrgZW4uvCwzGWGs
         mcVXVzWdls/yeWPWw2De+EDnLCRZZrlIv08C+k6RhSoClPywTIj6cq8xmZduXGi5ve
         mpp7X6yxALpSdESq4dF54JDghdDOstCFvQh7nPDlyKSMXmIL2B2OxoPO53I9n8QHEh
         6TYcH6NNSVwP0iVt6jpeZpotvM1iYIhNDmmpX/HEHJjuKtIThAMldkSlTfHE5S8Gwm
         Lj+dUjv2xBdSF2pJ4e/G8pjv1Gw0mjNFQCPAugKLUMDRQuBe2VDxPCRemFBfubUlFH
         G7Dp3F3RJY2VQ==
To:     Amir Goldstein <amir73il@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: procfs: open("/proc/self/fd/...") allows bypassing O_RDONLY
Message-ID: <Uc-5mYLV3EgTlSFyEEzmpLvNdXKVJSL9pOSCiNylGIONHoljlV9kKizN2bz6lHsTDPDR_4ugSxLYNCO7xjdSeF3daahq8_kvxWhpIvXcuHA=@emersion.fr>
In-Reply-To: <CAOQ4uxjOOe0aouDYNdkVyk7Mu1jQ-eY-6XoW=FrVRtKyBd2KFg@mail.gmail.com>
References: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr> <CAOQ4uxjOOe0aouDYNdkVyk7Mu1jQ-eY-6XoW=FrVRtKyBd2KFg@mail.gmail.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday, May 12th, 2022 at 14:30, Amir Goldstein <amir73il@gmail.com> w=
rote:

> Clients can also readlink("/proc/self/fd/<fd>") to get the path of the fi=
le
> and open it from its path (if path is accessible in their mount namespace=
).

What the compositor does is:

- shm_open with O_RDWR
- Write the kyeboard keymap
- shm_open again the same file with O_RDONLY
- shm_unlink
- Send the O_RDONLY FD to clients

Thus, the file doesn't exist anymore when clients get the FD.

> Would the clients typically have write permission to those files?
> Do they need to?

Compositors need to disallow clients from writing to the shared files.
If a client gets write access to the shared file, they can corrupt the
keyboard keymap (and other data) used by all other clients.

> > intended behavior, what would be a good way to share a FD to another
> > process without allowing it to write to the underlying file?
>
> If wayland can use a read-only bind mount to the location of the files th=
at it
> needs to share, then re-open will get EROFS.

Wayland just uses FD passing via Unix sockets to share memory. It
doesn't (and can't) assume anything regarding the filesystem layout,
because the clients might be running in a separate namespace with a
completely different layout (e.g. Flatpak).
