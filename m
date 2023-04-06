Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47006D9780
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 15:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbjDFNBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 09:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDFNBu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693FC83DC
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 06:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ED3664796
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 13:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDA6C4339B;
        Thu,  6 Apr 2023 13:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680786108;
        bh=3TsDQNdum059+muH41SQQo651rys1o+sj3l57yX+XLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDNgJxbLPg4SHVPCr8POR/PJMqm/wHynIS5VuL+sM6x+GppHzwX2SdHAJZRkx6Lfn
         Lj/H1f8bPs1RytBh2LFEG5vW22/evAFs+LdvW2CfK8VcHD9Q1TiIqyrBCRcXhyS1P6
         d4Iy619y2fJZ7K6PF9hL0WKduMsyyaDUlI0gOI13Xkq7QlxN/d6MZfHwGPJcKS1vor
         a+QdGNBjbZbtWSAvdbOvkf1wT0pPzud8HS9JMQLZGuCVBJSwKzPxMvuIq3ZZb7BVDR
         4kLBex8NXMAq1Szni9btdL0DQL2IYM0O2D12PS55FYieycVCTlforZgt/MEQeQ3dhN
         ktvnRUziTpchg==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/5] pnode: pass mountpoint directly
Date:   Thu,  6 Apr 2023 15:01:39 +0200
Message-Id: <20230406-biochemie-tauchen-5714afb03179@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZC3MXAqKMyh007rV@do-x1extreme>
References: <20230202-fs-move-mount-replace-v2-2-f53cd31d6392@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=685; i=brauner@kernel.org; h=from:subject:message-id; bh=7R99lOY+LGDUnAEVZBA1nQf1hxb/amJOgn2MapUskTA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaToHZo95b/Z/Pf6u+KEJ3+af4alf1/vMh/ew4EB20K4+GVX 5nmf7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIkzfD/0itX6/lZpnpRm48uu1RRk r1Q6c1l5PiVt3ekHD85C3NV7EMf2WEsp3+dAnM281peZrzoPJUbbbOJeKTIhgnffvQadz1ghkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Tue, 28 Mar 2023 18:13:05 +0200, Christian Brauner wrote:
> Currently, we use a global variable to stash the destination
> mountpoint. All global variables are changed in propagate_one(). The
> mountpoint variable is one of the few which doesn't change after
> initialization. Instead, just pass the destination mountpoint directly
> making it easy to verify directly in propagate_mnt() that the
> destination mountpoint never changes.
> 
> [...]

Cherry picking this particular patch,

tree: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
branch: fs.misc
[2/5] pnode: pass mountpoint directly
      commit: 4ea2a8d84c75e20b4d9b5d9010879cdb89f2e384
