Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E00F7A6345
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 14:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjISMln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 08:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjISMlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:41:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CF099;
        Tue, 19 Sep 2023 05:41:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78A9C433C8;
        Tue, 19 Sep 2023 12:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695127296;
        bh=sdNgLMHUaM9EotsLPKRMXdZdUQrg70sPmYa/XAc0bSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftGqKQL4Xpl9ksEbF9kVIdFF6MC45/9W9MV9ZLGrEGLN3RbD12jnPRc54rGSxjK63
         GNAsWaV+cP6dWUHXZrqwbuhZpsxpPpURNCVhH1DHSKgyNpjCFjUXoI7GwmhaQUbsn5
         eg3PLHExudRGbYamTZSzZ56fxe8gEIVXloT8armL49S30NLIcooICXsWKt/IJDiBdJ
         6z4OSXV1TUgouaw7mq+dEZhu2uL9nuj1xRffJd7ZkbChdnqQMrHqJHCgPnsHbDUK9d
         54+4zvEayOJfLjh0Kdsxv6R2OIlVHmWHHT1lk3U7wKkA0gbvSLBO5Ot8hKZyQmVI8P
         t8TC7i1SN/eWQ==
Date:   Tue, 19 Sep 2023 14:41:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Matthew House <mattlloydhouse@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230919-hackordnung-asketisch-331907800aa0@brauner>
References: <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
 <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner>
 <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
 <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner>
 <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com>
 <20230919003800.93141-1-mattlloydhouse@gmail.com>
 <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com>
 <20230919-abfedern-halfen-c12583ff93ac@brauner>
 <CAJfpegsjE_G4d-W2hCZc0y+PioRgvK5TxT7kFAVgBqX6zN2dKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsjE_G4d-W2hCZc0y+PioRgvK5TxT7kFAVgBqX6zN2dKg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >  with __u32 size for mnt_root and mnt_point
> 
> Unnecessary if the strings are nul terminated.

All ok by me so far but how does the kernel know the size of the buffer
to copy into? Wouldn't it be better to allow userspace to specify that?
I'm probably just missing something but I better ask.
