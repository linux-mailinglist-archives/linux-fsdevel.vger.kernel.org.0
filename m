Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8731B7B1F5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 16:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjI1OVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 10:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjI1OVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:21:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E785219E;
        Thu, 28 Sep 2023 07:21:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFC1C433C7;
        Thu, 28 Sep 2023 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695910867;
        bh=RQwLxrhtkj1P5yQ46YDdr98IzOwhhCImXJW1888SN6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYrOiHxeoQbk/JMa+ItyDqPa+s9bdwwLt/sRGpCOjd8280Q6K18xgYIZ/37+aDlME
         ykvXmgHIXk/VXf+6JpqQ0fQ4YuSfcT7hCQbFlhgaEx9w32onspI2WODlqKF/siJi9W
         9kv2gzrGiNmeA27et34v3Ri7YyKLQG4XAzp4yeANaQks1Z16kf97D5YInak18fiHfL
         s90giAQcyPAPveBNiQcVFAKdH3hawdwMTqcOZZPGd0lBxh+hVTsF0ZuwO5+Dmt8KD2
         oUve5bnDK70WX6pHQTTesaMURPBs0gR5rKw9vN7zK3/TOYirq/ieMtztbItOjge33A
         fXDU/yXuBXxMw==
From:   Christian Brauner <brauner@kernel.org>
To:     =?utf-8?q?Lu=C3=ADs_Henriques_=3Clhenriques=40suse=2Ede=3E?=@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mateusz Guzik <mjguzik@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs: fix possible extra iput() in do_unlinkat()
Date:   Thu, 28 Sep 2023 16:20:58 +0200
Message-Id: <20230928-piloten-mitkommen-d284c6b5581d@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928131129.14961-1-lhenriques@suse.de>
References: <20230928131129.14961-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=brauner@kernel.org; h=from:subject:message-id; bh=RQwLxrhtkj1P5yQ46YDdr98IzOwhhCImXJW1888SN6U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSKdp9gYgw7fSrNyiLsleVqQ/WURGVuXqkc+QnntrsdLg74 dDS2o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKBsxkZVnKIhDVv4GI4u5J3he9EzQ nvHurX/4vXW7Bj+3UG9cJHhQz/06M1Ff628qcYHku+Hml2d8nk+HU3ZTrFo/dujnhS1t3HDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 28 Sep 2023 14:11:29 +0100, Luís Henriques wrote:
> Because inode is being initialised before checking if dentry is negative,
> and the ihold() is only done if the dentry is *not* negative, the cleanup
> code may end-up doing an extra iput() on that inode.
> 
> 

Not a bug afaict but as Mateusz points out it's confusing.
So I took it with a changed commit message:

    fs: move d_is_negative() further up

    The code is confusing because inode is dereferenced before the
    d_is_negative() check. Make it clear that iput() isn't called further
    below.

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: fix possible extra iput() in do_unlinkat()
      https://git.kernel.org/vfs/vfs/c/b99cf757431d
