Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7B07400D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjF0QXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjF0QXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:23:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDBC1FF0;
        Tue, 27 Jun 2023 09:23:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C83EA611D8;
        Tue, 27 Jun 2023 16:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BEFC433C9;
        Tue, 27 Jun 2023 16:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687883022;
        bh=DSpyRxprW3MPfkhjPF5yXCDbAEFb7zNN+CnoAFHKHDI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bMs4+nSR1W39m4QCMlBeLxy90os9T7tM9/ADdF1aARQ78hSxdCbmkJ9PNaQYK19Ju
         zT5Km1Rls5PK5FwBcnCRm2u8vhBzSgBJE5pybKa7pHa31ysYrrbUPq7/32BtO9VW/e
         R+cvLIVm21mnF9w4lni7NkFqS4JFMdRnADZPQ0Y8FYR6qPIZ9BDRgOZkYqv7VDfx0p
         5yOrxdfxFqXR1PCK0T3PIpSQtr5bItmHVnua3DOpngwk60cVGSFIi4tMAW8hwf7URl
         TqF+XYGeZN0QcUZ1dc5VHIP4tDsuwIlUCUmOZh44BSKeWuSWDJkLyb3wRycnRhv69Y
         vZfR6LZL4Tnaw==
Message-ID: <b18c49ada119b6904b92375a847ce8c764cb1663.camel@kernel.org>
Subject: Re: [PATCH 0/2] v3: F_OFD_GETLK extension to read lock info
From:   Jeff Layton <jlayton@kernel.org>
To:     Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Date:   Tue, 27 Jun 2023 12:23:40 -0400
In-Reply-To: <20230622165225.2772076-1-stsp2@yandex.ru>
References: <20230622165225.2772076-1-stsp2@yandex.ru>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-06-22 at 21:52 +0500, Stas Sergeev wrote:
> This extension allows to use F_UNLCK on query, which currently returns
> EINVAL. Instead it can be used to query the locks on a particular fd -
> something that is not currently possible. The basic idea is that on
> F_OFD_GETLK, F_UNLCK would "conflict" with (or query) any types of the
> lock on the same fd, and ignore any locks on other fds.
>=20
> Use-cases:
>=20
> 1. CRIU-alike scenario when you want to read the locking info from an
> fd for the later reconstruction. This can now be done by setting
> l_start and l_len to 0 to cover entire file range, and do F_OFD_GETLK.
> In the loop you need to advance l_start past the returned lock ranges,
> to eventually collect all locked ranges.
>=20
> 2. Implementing the lock checking/enforcing policy.
> Say you want to implement an "auditor" module in your program,
> that checks that the I/O is done only after the proper locking is
> applied on a file region. In this case you need to know if the
> particular region is locked on that fd, and if so - with what type
> of the lock. If you would do that currently (without this extension)
> then you can only check for the write locks, and for that you need to
> probe the lock on your fd and then open the same file via another fd and
> probe there. That way you can identify the write lock on a particular
> fd, but such trick is non-atomic and complex. As for finding out the
> read lock on a particular fd - impossible.
> This extension allows to do such queries without any extra efforts.
>=20
> 3. Implementing the mandatory locking policy.
> Suppose you want to make a policy where the write lock inhibits any
> unlocked readers and writers. Currently you need to check if the
> write lock is present on some other fd, and if it is not there - allow
> the I/O operation. But because the write lock can appear at any moment,
> you need to do that under some global lock, which can be released only
> when the I/O operation is finished.
> With the proposed extension you can instead just check the write lock
> on your own fd first, and if it is there - allow the I/O operation on
> that fd without using any global lock. Only if there is no write lock
> on this fd, then you need to take global lock and check for a write
> lock on other fds.
>=20
>=20
> The second patch adds a test-case for OFD locks.
> It tests both the generic things and the proposed extension.
>=20
>=20
> The third patch is a proposed man page update for fcntl(2)
> (not for the linux source tree)
>=20
>=20
> Changes in v3:
> - Move selftest to selftests/filelock
>=20
> Changes in v2:
> - Dropped the l_pid extension patch and updated test-case accordingly.
>=20
> Stas Sergeev (2):
>   fs/locks: F_UNLCK extension for F_OFD_GETLK
>   selftests: add OFD lock tests
>=20
>  fs/locks.c                                  |  23 +++-
>  tools/testing/selftests/filelock/Makefile   |   5 +
>  tools/testing/selftests/filelock/ofdlocks.c | 132 ++++++++++++++++++++
>  3 files changed, 157 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/filelock/Makefile
>  create mode 100644 tools/testing/selftests/filelock/ofdlocks.c
>=20
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Chuck Lever <chuck.lever@oracle.com>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: Christian Brauner <brauner@kernel.org>
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kselftest@vger.kernel.org
> CC: linux-api@vger.kernel.org
>=20

I've taken the first two patches into my locks-next branch, so they
should end up in linux-next soon. Adding support for testing this to
fstests is a hard requirement before this will be merged into mainline.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
