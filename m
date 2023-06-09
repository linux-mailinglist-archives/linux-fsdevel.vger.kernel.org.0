Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331C7729EE0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 17:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241908AbjFIPmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 11:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241822AbjFIPmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:42:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE1130F7;
        Fri,  9 Jun 2023 08:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D377560FAA;
        Fri,  9 Jun 2023 15:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3988BC433D2;
        Fri,  9 Jun 2023 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686325326;
        bh=lzKXlDqvhrmxKXiluIeR7meNRS3j1RGM0ooh6vsjSh8=;
        h=From:Subject:Date:To:Cc:From;
        b=BaIHLWAdCjnpxZNmkesvnWpKlODIjritVu/B0GAXi9fwvd24S/PxTbfbxpKV3WunB
         fLvQKtWHVWOOGmvf5YKebltN6OCPNmN/VynMPwJOvOsp9JMEGICHXIoKWzKJXk0aBA
         uVj6VH0d1qBVJvjXle4ZVpD+iJQc2468Ek5gXfGtd/DKvtXEsb2EB9gwfHCcIgJwh5
         aDbWKdLoBk/I8JpYFltMt6m0gCRIdVfUFLXm/ScE47zlrXnoiS+HyGDiEeaSzsjqv3
         0/m9grYX+DizwhCM1CSAe2LAL3biW/g89DJYZ242rqYG/mGyVEKhDiC74OzVH3OHjK
         c2bqQZRhec+1g==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/2] ovl: port to new mount api & updated layer parsing
Date:   Fri, 09 Jun 2023 17:41:47 +0200
Message-Id: <20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADtIg2QC/4WOUQ6CMBBEr0L6bU0pqMQv72GI2cIWNkJLtthIC
 He3cAH/5s1kMrOKgEwYxD1bBWOkQN4l0KdMND24DiW1iYVWulBXdZE2SB+RB1iSGv3HzS+YSGq
 FUBlVorWlSGUDAaVhcE2/10cIM/IeTIyWvsfis07cU5g9L8eBmO/u362Yy1xC1d6qprAGwT7ey
 A6Hs+dO1Nu2/QBw+bm41gAAAA==
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=704; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lzKXlDqvhrmxKXiluIeR7meNRS3j1RGM0ooh6vsjSh8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ0e/hY6ASW1TDMa/+gYpkRc6l424pzV6w36wbOiwtZpqOx
 gdujo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL8/IwMB2vq3rUwFb+LupXEqvqdcc
 LvJeW7WjZ/DHqVJnwx2Cv1GcMfznP3/8VxHbxrGK79KGDb9/SNvgn/rZ6IrlVZtbzT7+gGHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

This ports overlayfs to the new mount api and modifies layer parsing to
allow for additive layer specification via fsconfig().

I'm not sure if I need to rebase the changes on top of Amir's lazy
lookup. If so, please let me know!

Christian

---
Changes in v2:
- Split into two patches. First patch ports to new mount api without changing
  layer parsing. Second patch implements new layer parsing.
- Move layer parsing into a separate file.
- Link to v1: https://lore.kernel.org/r/20230605-fs-overlayfs-mount_api-v1-1-a8d78c3fbeaf@kernel.org

---



---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230605-fs-overlayfs-mount_api-20ea8b04eff4

