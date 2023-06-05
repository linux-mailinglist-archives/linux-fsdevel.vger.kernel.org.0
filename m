Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D725A7224F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 13:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjFELzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 07:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjFELzQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:55:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D39DA;
        Mon,  5 Jun 2023 04:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AD4F6230C;
        Mon,  5 Jun 2023 11:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65681C4339B;
        Mon,  5 Jun 2023 11:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685966114;
        bh=pUSC7oks7piN2gzMx4OqaEMjAcj/eQArd7w290LuOq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=awIf2YtJkTEPkmDuvdcNoLdI2TUe2b+rwXUgF6JOEhN9dPsxR1nzPOUfEgasv7hXt
         Pt9PNG9LzJGeDxAVqq9cSp2Q4D5eZTdoFtYXs8r+WaIKFCFJHsXOw3LEzsOA5ljfBI
         NHApRg+D8Mi0sd06fz2D1iys9KuFD3m9lCoPG/i2HGv4aoztO6W6yZO6jkVNtAd2ny
         MUzSxdfgfigMWahl7Yoh5nSze7VD06AFB9O1H6dPSHsrnEK14qcmu0NY/zD3WENXky
         CVxpHhHbJpOIU3CiqYlpNcQ70wNOb9CH/odTk5olviBlB5M0u6usf9bopYLFl/wt81
         z+FLaZGZbTuSQ==
From:   Christian Brauner <brauner@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] highmem: Rename put_and_unmap_page() to unmap_and_put_page()
Date:   Mon,  5 Jun 2023 13:53:58 +0200
Message-Id: <20230605-brombeeren-pelle-4c3b79161688@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602103307.5637-1-fmdefrancesco@gmail.com>
References: <20230602103307.5637-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=brauner@kernel.org; h=from:subject:message-id; bh=jKeD4wVOOupEPtRNzJJqOCLPd5qFAlNPBImFod19/MQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTUnjlvdCyvjDvpSWaTesoNhuP75+mdnc8+wThpT5J944xO k9otHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMRPsjwP2NZeu6aivR3307/k2Od8f aV2I+b6iLvLe/JzZV7Y7uAjZHhf73E+7VVa1qi/Cy44y9o7rv10T59fdy2/5P2HZzeE5/XzQwA
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

On Fri, 02 Jun 2023 12:33:07 +0200, Fabio M. De Francesco wrote:
> With commit 849ad04cf562a ("new helper: put_and_unmap_page()"), Al Viro
> introduced the put_and_unmap_page() to use in those many places where we
> have a common pattern consisting of calls to kunmap_local() +
> put_page().
> 
> Obviously, first we unmap and then we put pages. Instead, the original
> name of this helper seems to imply that we first put and then unmap.
> 
> [...]

Grabbed it now. Please yell if this wants to go another route.

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] highmem: Rename put_and_unmap_page() to unmap_and_put_page()
      https://git.kernel.org/vfs/vfs/c/01af7e7dd0ea
