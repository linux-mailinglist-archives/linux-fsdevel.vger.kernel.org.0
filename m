Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C9A704FB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 15:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjEPNqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 09:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjEPNqU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 09:46:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E905264;
        Tue, 16 May 2023 06:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DA5D62BD9;
        Tue, 16 May 2023 13:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71294C433EF;
        Tue, 16 May 2023 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684244778;
        bh=t8z30oiY0fzwDSpixG5W4QvXXHcgLw6aXaPTs2SDSO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUSiP5keC4I3Ju86omAo/EXLS7AHJ+mushRkuf7Pfb/v7T7oetwjovicMKQYd/kUL
         VvyDwmCEMB37xp2tzUUyvAYKb62xeNfHB9dYi9seowqX2ohJi8nNOaPcYelFwgGepS
         0ptAk6hWdxSLJILny6OMp3myP9MTt9wiDa4qD5roIt1L/55xb7CbusQJGOHJ0PBvVU
         PzFvpJ04d+/Vx5wCsde/OJpRRMdSMYyuoOgUgun+1ptsMbW/OmjxVBw5e+Akq6AIR4
         GC0C3sElr43/PIbDgXXYB0SXIXiK4SIiejncYjFvXT8k5KtWHJnFn53AWTU+pOF2/O
         ESjTuj4W7hljw==
From:   Christian Brauner <brauner@kernel.org>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ptikhomirov@virtuozzo.com, Andrey Ryabinin <arbn@yandex-team.com>
Subject: Re: [PATCH] fs/coredump: open coredump file in O_WRONLY instead of O_RDWR
Date:   Tue, 16 May 2023 15:46:11 +0200
Message-Id: <20230516-melancholisch-traten-3336ff6e9d30@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <CAHk-=wjex4GE-HXFNPzi+xE+w2hkZTQrACgAaScNdf-8hnMHKA@mail.gmail.com>
References:  <CAHk-=wjex4GE-HXFNPzi+xE+w2hkZTQrACgAaScNdf-8hnMHKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=685; i=brauner@kernel.org; h=from:subject:message-id; bh=t8z30oiY0fzwDSpixG5W4QvXXHcgLw6aXaPTs2SDSO4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQkd0p78d6N8/W801v/YqFMZkZb5hOFH/HvqrnUjNualJns Mrw6SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJqJ1jJGhudjlMe/TJ1W9ry5WGvEGKM 4WWSgcuvy3r3eEXfDMS7uZGBlW7lvZcYbBMvHQ+3svVoq2fF+za6XxhDNvHqy2DdU+nqjNBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 20 Apr 2023 15:04:09 +0300, Vladimir Sementsov-Ogievskiy wrote:
> This makes it possible to make stricter apparmor profile and don't
> allow the program to read any coredump in the system.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs/coredump: open coredump file in O_WRONLY instead of O_RDWR
      https://git.kernel.org/vfs/vfs/c/f84566e710af
