Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FC5524D38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 14:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353969AbiELMli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 08:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353921AbiELMl0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 08:41:26 -0400
X-Greylist: delayed 143 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 05:41:24 PDT
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD815908B
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 05:41:21 -0700 (PDT)
Date:   Thu, 12 May 2022 12:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1652359279;
        bh=UqamLj4BJ8E9gSU1cyoMnFv0DQaZ7oKu0fpmqx4XkMU=;
        h=Date:To:From:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=Er/8a6YP+4nfThL0mlkEjQDoMW+DqHzTUCotJgaVsuWUECGHKzWSOWmi/ZDsychbd
         61BflP9DaK1qfGptv5nseL0+q8KBsaNOYQCPwyMaA6jTZKvn+IKFfG/DRA0xIELbsP
         5tCItORkIZASbXFQ+3zQ913zO/MAnif9eutcMs38MRODYAEFojglFqJbRFxj6PiZvt
         lMKuAlkXkQqcA5GtU+0wdAZaqDIePksoppnwkxBp+A8/DD26LoAY6qlsLc2/wMHt3+
         1r2z22TxAI2w4wCZJcbwxpRavmTO0fRgX/zcm+hersRlbxIaaoQe4yqZegDJvaaVBX
         X0V1oLSbxAf0Q==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   Simon Ser <contact@emersion.fr>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: procfs: open("/proc/self/fd/...") allows bypassing O_RDONLY
Message-ID: <03l0hfZIzD9KwSxSntGcmfFhvbIKiK45poGUhXtR7Qi0Av0-ZnqnSBPAP09GGpSrKGZWZNCTvme_Gpiuz0Bcg6ewDIXSH24SBx_tvfyZSWU=@emersion.fr>
In-Reply-To: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
References: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday, May 12th, 2022 at 12:37, Simon Ser <contact@emersion.fr> wrote=
:

> what would be a good way to share a FD to another
> process without allowing it to write to the underlying file?

(I'm reminded that memfd + seals exist for this purpose. Still, I'd be
interested to know whether that O_RDONLY/O_RDWR behavior is intended,
because it's pretty surprising. The motivation for using O_RDONLY over
memfd seals is that it isn't Linux-specific.)
