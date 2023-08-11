Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B930D7787D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 09:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjHKHGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 03:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjHKHGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:06:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA11271B;
        Fri, 11 Aug 2023 00:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7C4064413;
        Fri, 11 Aug 2023 07:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1D0C433C8;
        Fri, 11 Aug 2023 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691737589;
        bh=0mhkwsILu5FGoHxKXt/ZbuBENNtd8n4lJIl2kTSCuOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tx2bYIjMEHlMNbKrnlXSpOuSRZel7w9096TLTXag83HCjPJAkgRlkEIN9jU2yeaXz
         ZHzyFgD1tDxLzAxVAA+asv8L/+ybF/BmxX3ma21qXywicI5To9mBzC6+mOvqOdxLy2
         z2h4ZiASjpBbTGDw2c/ZjgpPJbJnN+Jv0386qTqU6Dr2OeyYMwyGrWvc+bLQsvTtNz
         NsWlpiWqvulqkN5SDfF1QKE2uzIABvoW75FM+dSQ3tA2olwsn9FP7v1gjCjNedGvLU
         PC38mJ8ORp6irhf3Y6hHE7h0h81Rdf/1kut9M8yd99gQanWcJJKWxlJPweahkq3Fal
         oHiVPgNuWnF9w==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Frank Sorenson <sorenson@redhat.com>, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 0/2] fat: revise the FAT patches for mgtime series
Date:   Fri, 11 Aug 2023 09:06:18 +0200
Message-Id: <20230811-fluor-denkfabrik-61880b8fbc86@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
References: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=brauner@kernel.org; h=from:subject:message-id; bh=0mhkwsILu5FGoHxKXt/ZbuBENNtd8n4lJIl2kTSCuOw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRcvftse8qWM6F7Vx+ds82yU63j6DEmpoNmm0+XhZ/X/f7y pKnKh45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJKBkzMvznbtZ/9/9oqluM/7PnMx ICWqRd1k++cnLvxtCHD+6c0hFgZPh3XtTq8TO5hzlX9kY8vrDoufuLq1Llk0+6Gezpu1nDXckPAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 10 Aug 2023 09:12:03 -0400, Jeff Layton wrote:
> This is a respin of just the FAT patches for the multigrain ctime
> series. It's based on top of Christian's vfs.ctime branch, with this
> patch reverted:
> 
>     89b39bea91c4 fat: make fat_update_time get its own timestamp
> 
> Christian, let me know if you'd rather I resend the whole series.
> 
> [...]

I simply dropped the old fat patch and applied these two instead. I've
rebased them so their in the same position as the old patch so the
series is still logically ordered.

---

Applied to the vfs.ctime branch of the vfs/vfs.git tree.
Patches in the vfs.ctime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.ctime

[1/2] fat: remove i_version handling from fat_update_time
      https://git.kernel.org/vfs/vfs/c/93e6c3043544
[2/2] fat: make fat_update_time get its own timestamp
      https://git.kernel.org/vfs/vfs/c/6f4aaee3faa8
