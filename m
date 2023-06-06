Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD98724E39
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 22:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbjFFUiD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 16:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjFFUiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:38:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DF310C3;
        Tue,  6 Jun 2023 13:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0105563045;
        Tue,  6 Jun 2023 20:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4F5C433EF;
        Tue,  6 Jun 2023 20:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686083879;
        bh=zwS9UoNrIw0Gfz8G+aqGyENTio0hYFTJZEMXB9aO/OM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Nub1rafA9h9MuSb4Bk6fZZmGpYNYXZjoqhuHPNI5LvxL37jR4HD/NwT2zMqSUB8Ho
         cehlh8tB9NdyqP4MKUs0dpbyfXANe9UY4VMM5+3heCh+pDbIeMQJZaJWAuz336wr9Q
         2s7+o5wkIacF9D3Q4yJYVtq2pBB1Ix5Hogz5mHylV4CMed+9mHajbkiKYMuLW8If3e
         f2pHJ3WlMUVX1Dh8reWNnwYrTRRUAcaMvDkQgRBua0fvREE/fV5agwzddytBJGZGmT
         G6fPlv1c4N2jD8DVBvxsI8oKSWWmhzGuvFtIng15+2zt3PDY0xGG7qNVGgY+q5f2u3
         teMvlkugHilDw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 23:37:53 +0300
Message-Id: <CT5UUMA0D2AV.33DTZ42K576WS@suppilovahvero>
Cc:     <ebiederm@xmission.com>, <patches@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sysctl: move umh sysctl registration to its own
 file
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Luis Chamberlain" <mcgrof@kernel.org>, <keescook@chromium.org>,
        <yzaikin@google.com>, <dhowells@redhat.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <j.granados@samsung.com>,
        <brauner@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230530232914.3689712-1-mcgrof@kernel.org>
 <20230530232914.3689712-2-mcgrof@kernel.org>
In-Reply-To: <20230530232914.3689712-2-mcgrof@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed May 31, 2023 at 2:29 AM EEST, Luis Chamberlain wrote:
> Move the umh sysctl registration to its own file, the array is
> already there. We do this to remove the clutter out of kernel/sysctl.c
> to avoid merge conflicts.
>
> This also lets the sysctls not be built at all now when CONFIG_SYSCTL
> is not enabled.
>
> This has a small penalty of 23 bytes but soon we'll be removing
> all the empty entries on sysctl arrays so just do this cleanup
> now:
>
> ./scripts/bloat-o-meter vmlinux.base vmlinux.1
> add/remove: 2/0 grow/shrink: 0/1 up/down: 49/-26 (23)
> Function                                     old     new   delta
> init_umh_sysctls                               -      33     +33
> __pfx_init_umh_sysctls                         -      16     +16
> sysctl_init_bases                            111      85     -26
> Total: Before=3D21256914, After=3D21256937, chg +0.00%
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  include/linux/umh.h |  2 --
>  kernel/sysctl.c     |  1 -
>  kernel/umh.c        | 11 ++++++++++-
>  3 files changed, 10 insertions(+), 4 deletions(-)

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
