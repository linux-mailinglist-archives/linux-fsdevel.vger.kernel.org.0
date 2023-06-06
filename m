Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C53723C3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 10:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbjFFIxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 04:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjFFIw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:52:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC468F;
        Tue,  6 Jun 2023 01:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96BC16255A;
        Tue,  6 Jun 2023 08:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57954C433EF;
        Tue,  6 Jun 2023 08:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686041578;
        bh=X/JIUXUe2IkAlocYqunb8oWKBdUtN9T7H11lqNuTCMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cy95tkdeuGaOCO5TagvbVLFZBJKlFdUYOjwcXK8cVL3xTktbt4UlQJRlhQxvjI1mU
         0sKmeS7cKOFH401WHFqcSj1sPQnTd+egQ5lcjGDanws8VcBeFGqTJF3IIJoiFxdeZ1
         ufqn9LXNQrLjMfmHRa5kKH1FvDXOpkGM07NxNBzIlAdGn9CvtOPdcuroHNeTq/s/Rp
         BizNMfgE4giWVqisQudJ+p1b2lonYJ5d4OJynwVpmi/5ZzUnQt6yTAmCeRWnHq5m9A
         Iw9mkXnB4DOvLZfKnPc/c9cErMau761ZcC7CSxazglQWMeTU6/VoU8nVgqRlm2JqWO
         Ps6eVBi8Yugkg==
From:   Christian Brauner <brauner@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Nick Alcock <nick.alcock@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v5] kernel/watch_queue: NULL the dangling *pipe, and use it for clear check
Date:   Tue,  6 Jun 2023 10:52:49 +0200
Message-Id: <20230606-getaucht-groschen-b2f1be714351@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605143616.640517-1-code@siddh.me>
References: <20230605143616.640517-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=brauner@kernel.org; h=from:subject:message-id; bh=X/JIUXUe2IkAlocYqunb8oWKBdUtN9T7H11lqNuTCMM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTUfb6xo2jtlmO73U4yNT3dKpy5eZaHqQ1vrKzNzQWx3ts7 6ktaOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiE8HIsGJfZrftln2bNvseYXbwNF 0a/U3wl6hG3qzJBzO/3JIqsWP4K6nYdLZn843qrQlrQq8afjrV1HEg36q2oazFUtZ0aj0bEwA=
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

On Mon, 05 Jun 2023 20:06:16 +0530, Siddh Raman Pant wrote:
> NULL the dangling pipe reference while clearing watch_queue.
> 
> If not done, a reference to a freed pipe remains in the watch_queue,
> as this function is called before freeing a pipe in free_pipe_info()
> (see line 834 of fs/pipe.c).
> 
> The sole use of wqueue->defunct is for checking if the watch queue has
> been cleared, but wqueue->pipe is also NULLed while clearing.
> 
> [...]

Massaged the commit message a bit and applied David's Ack as requested.

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] kernel/watch_queue: NULL the dangling *pipe, and use it for clear check
      https://git.kernel.org/vfs/vfs/c/ae33d3de5ff5
