Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61161766667
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 10:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjG1IHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 04:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjG1IH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7D635A0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 01:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A48D6202A
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 08:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B465C433C8;
        Fri, 28 Jul 2023 08:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690531620;
        bh=SA6A0yrELgyo+eU0lbBKfgUSEb8O2y86fT7korpoL+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKjSac6+s1O1BFRDRt3KJXlNfmtkeUFgxzL9bivmAOZYlD56X7PApiT3jiFLSA+sf
         95iXJ0TOzO40qcC9gk1/fUuyDhjxl6Se+JFYaT86iEwUnZxvPHrMZkOYQOLPwWI+NP
         F0LWIyto9CBoVtwHZ4rk7dzVhVtg9M7Fz+2Vi0qy3Dwf3SFhLM06cLY3dezQJBfIkP
         q7OC41NAUTSnYK3FnOe8JuvzPeDHGecv7acPyHv5SzJe59+oa+wYYI14MK/LLesRPD
         Y4XWYGdtVP2/E4A645ddzEuC3S0J40qF3jx/+GzOxAeEJ7W2pBZ7sXh0SrZJpSoPQZ
         wS6E25n0WwXPA==
From:   Christian Brauner <brauner@kernel.org>
To:     Chuck Lever <cel@kernel.org>, oliver.sang@intel.com
Cc:     Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, oe-lkp@lists.linux.dev,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC] libfs: Remove parent dentry locking in offset_iterate_dir()
Date:   Fri, 28 Jul 2023 10:06:49 +0200
Message-Id: <20230728-sorglos-krempel-7f7b18c4c247@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <169030957098.157536.9938425508695693348.stgit@manet.1015granger.net>
References:  <169030957098.157536.9938425508695693348.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353; i=brauner@kernel.org; h=from:subject:message-id; bh=SA6A0yrELgyo+eU0lbBKfgUSEb8O2y86fT7korpoL+s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQcLhefcL/u7cnS23MzZCTuNJ6VOifrzPiA7TCDr8wSrlsW N7/UdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkuSfDfzeVyGoH2R1vNgWuaf+9Ji tiygMr16IzFcY1CTfm/on7Lc7I8Htb6KWyKaqHH/WuzGxyTNB8wZjnNaOFa+/fjF/CbxiSWAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 25 Jul 2023 14:31:04 -0400, Chuck Lever wrote:
> Since offset_iterate_dir() does not walk the parent's d_subdir list
> nor does it manipulate the parent's d_child, there doesn't seem to
> be a reason to hold the parent's d_lock. The offset_ctx's xarray can
> be sufficiently protected with just the RCU read lock.
> 
> Flame graph data captured during the git regression run shows a
> 20% reduction in CPU cycles consumed in offset_find_next().
> 
> [...]

I've picked this up. It would be very nice if we could get a perf test
from lkp for this fix.

---

Applied to the vfs.tmpfs branch of the vfs/vfs.git tree.
Patches in the vfs.tmpfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.tmpfs

[1/1] libfs: Remove parent dentry locking in offset_iterate_dir()
      https://git.kernel.org/vfs/vfs/c/01c45fd0472c
