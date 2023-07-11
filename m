Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB7274F751
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 19:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjGKRhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 13:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGKRhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:37:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F62E4F;
        Tue, 11 Jul 2023 10:37:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CE7861579;
        Tue, 11 Jul 2023 17:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E41BC433C8;
        Tue, 11 Jul 2023 17:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689097032;
        bh=g+dg42YNtsQJhOjtGMIfYdxeMk+Q5chUUpj1UHPyuI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OU0fx9r/gW1jdTCG/iJZoodUiAYpTTMgryh+eUwK0SvFFeCzBDxABJWQ/HAhpM8ye
         yBnM//6OA543xk4QBgEbWFDkvCh7ONFKnet6T2nY6GiJNGe++LpNHsBO53yIxRC1dw
         CLUi1qmmodaux6upnMNyF/KqqubSxVHA67DwxYH/aO5VwDsXvdD1T4BZZhZWFZrom9
         +nthUGNjjcFzaX2bY1z9qhdSCg7rB6hz0xgLF1oCv+tCDu8UN7UNhRG5OCUuJUdOw+
         UBXBTnHv6L2WRueaCic7RFYV1/lmEsdEsvaplXp/1qHno7ehBsSMmEORgYmfsLOmFl
         vPA4Eb9AXLl0w==
From:   Christian Brauner <brauner@kernel.org>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        James.Bottomley@HansenPartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
        dalias@libc.org, davem@davemloft.net, deepa.kernel@gmail.com,
        deller@gmx.de, dhowells@redhat.com, fenghua.yu@intel.com,
        fweimer@redhat.com, geert@linux-m68k.org, glebfm@altlinux.org,
        gor@linux.ibm.com, hare@suse.com, hpa@zytor.com,
        ink@jurassic.park.msu.ru, jhogan@kernel.org, kim.phillips@arm.com,
        ldv@altlinux.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, luto@kernel.org, mattst88@gmail.com,
        mingo@redhat.com, monstr@monstr.eu, mpe@ellerman.id.au,
        namhyung@kernel.org, peterz@infradead.org, ralf@linux-mips.org,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, will@kernel.org, x86@kernel.org,
        ysato@users.sourceforge.jp,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: (subset) [PATCH v4 0/5] Add a new fchmodat2() syscall
Date:   Tue, 11 Jul 2023 19:36:45 +0200
Message-Id: <20230711-befreien-unwiderruflich-c2265c61e514@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689092120.git.legion@kernel.org>
References: <cover.1689074739.git.legion@kernel.org> <cover.1689092120.git.legion@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=brauner@kernel.org; h=from:subject:message-id; bh=g+dg42YNtsQJhOjtGMIfYdxeMk+Q5chUUpj1UHPyuI0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSsnSxT9aGqYFXo8u/Pv0u8/8n7p3Ja0Z4JQu5vS1/e2JvM Xda7tKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiwv8ZGa5HavbtmudR8P/916OJ0j 91rvW3zk3vj11VUnvmNlvDpK2MDJ8umZ/uZt1qWrp9+6sJ/1y98jZJfQleeOMaf2RRS0fvbmYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Jul 2023 18:16:02 +0200, Alexey Gladkov wrote:
> In glibc, the fchmodat(3) function has a flags argument according to the
> POSIX specification [1], but kernel syscalls has no such argument.
> Therefore, libc implementations do workarounds using /proc. However,
> this requires procfs to be mounted and accessible.
> 
> This patch set adds fchmodat2(), a new syscall. The syscall allows to
> pass the AT_SYMLINK_NOFOLLOW flag to disable LOOKUP_FOLLOW. In all other
> respects, this syscall is no different from fchmodat().
> 
> [...]

Tools updates usually go separately.
Flags argument ported to unsigned int; otherwise unchanged.

---

Applied to the master branch of the vfs/vfs.git tree.
Patches in the master branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: master

[1/5] Non-functional cleanup of a "__user * filename"
      https://git.kernel.org/vfs/vfs/c/0f05a6af6b7e
[2/5] fs: Add fchmodat2()
      https://git.kernel.org/vfs/vfs/c/8d593559ec09
[3/5] arch: Register fchmodat2, usually as syscall 452
      https://git.kernel.org/vfs/vfs/c/2ee63b04f206
[5/5] selftests: Add fchmodat2 selftest
      https://git.kernel.org/vfs/vfs/c/f175b92081ec
