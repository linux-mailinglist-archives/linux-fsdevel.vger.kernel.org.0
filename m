Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BA1777949
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjHJNML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHJNMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5081291;
        Thu, 10 Aug 2023 06:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF0CF649A1;
        Thu, 10 Aug 2023 13:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ABEC433C7;
        Thu, 10 Aug 2023 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691673129;
        bh=r86+KrBFWpBZ4ui4lqaDN3LO7MYoEiyMnGcqbZZmkao=;
        h=From:Subject:Date:To:Cc:From;
        b=n4KO9mjuPAVebBacGuwUBfTlJypeoyaJ9ix2hNWsk6CnFlVg9amn3gnEpo71darZ6
         npGgE/LDwOI5J9tebEz3jq9VbJnH3oxcRrrm1NPYLQDlxPg2Vu0kEs5d1tjwVXwWNq
         U4gDt9Pm+8KZTHuSUTZQ4dYD3z8FKI1PXouAVd7wrdEw7wdheU7ayaCPHBXN5Sx6An
         Fua587dbvE0/7JigN+OWuLPAJ1nkv8yJrL15IwOyVBwIOWbx03Y9ubviUR05ilw5rH
         jNfLl99zjyCf9Fdp//az6k4L6H7TrauhngRU7o7C6SIlzPa2HBzyIswb99GidPk2I1
         agW3lR0zOpXfA==
From:   Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] fat: revise the FAT patches for mgtime series
Date:   Thu, 10 Aug 2023 09:12:03 -0400
Message-Id: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACPi1GQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC0MD3eSSzNxU3bTEEt1Uk6RUQ5O01CRDM1MloPqCotS0zAqwWdGxtbU
 A8AtQkFsAAAA=
To:     Christian Brauner <brauner@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Frank Sorenson <sorenson@redhat.com>, Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=r86+KrBFWpBZ4ui4lqaDN3LO7MYoEiyMnGcqbZZmkao=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk1OIo0W8IAbJr/H5M9fb0vyl44RKoBYaYtSBJ7
 +9vZYfjZrOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNTiKAAKCRAADmhBGVaC
 FatmD/9e9j+6VECB7kmx/5YuAjqT8I161pzUzgavKKD4rmT3x6YzHaUfTNxV/Hl2VBeVbC1u1sL
 CfXChrj9W9anLFkPEhV4GbszLFYWNa64a8P7TdU6sMNVhR50PXcpXhNOf/NW0FsXsxtb+76hSDh
 iKQUARzo058/kIc7mv3m1ipKJjQ602iNhGemws2z1n7GrEw/HUHjqiOQkvTR0mAU0DuBD1B6wo8
 SCR5t+nmeSwBh8dq3eUFlSrm2FrGyTK+aduJLEEEhQBeUMVVa4d8lrGaNSgBMdCfo9bZadntDQd
 XFNw/ulPLTE+M9c+tF5+zUZjB6mJKwJIWPMyJzHitR9uS19gZ+WU2EAicb0SAwvjp8eSGKcOab6
 UvZ7YIFq3+pMy619RJlI69mB8SDv2ENVrW8N3KcgdeeIgLE+tl+inkeizu7/208QqOdUAC2ovGx
 vwXMVc/zH5umnQGr+tXNbQwFvESpvlQhKn65AufWRDb30TLDOFlC6nR0RHIKRzava9MwO64veLH
 Y1jj3re69SPz0ik5K5pgnlanhxH4LunCmpqz9HyRwHrBsF/+rYNk6//4XbucBaI2QefGlgRJ+8f
 +N/iouWbZ3ML05p4NEoUGDRtCMjyQL7mo9hbiyuwbmiY+/mLjaQnJRCwHD5cu3lmpGKdrzhzQQt
 G9I9yiwy9pxeTuw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a respin of just the FAT patches for the multigrain ctime
series. It's based on top of Christian's vfs.ctime branch, with this
patch reverted:

    89b39bea91c4 fat: make fat_update_time get its own timestamp

Christian, let me know if you'd rather I resend the whole series.

To: Christian Brauner <brauner@kernel.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Frank Sorenson <sorenson@redhat.com>
To: Jan Kara <jack@suse.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      fat: remove i_version handling from fat_update_time
      fat: make fat_update_time get its own timestamp

 fs/fat/misc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
---
base-commit: bae85436bd3cca48ba625d0caf7457fe7708c336
change-id: 20230810-ctime-fat-e4be14feb165

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

