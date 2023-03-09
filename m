Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B76B2FBC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 22:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCIVkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 16:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCIVkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:40:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF167F865E;
        Thu,  9 Mar 2023 13:40:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2595FB819EE;
        Thu,  9 Mar 2023 21:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4786C433EF;
        Thu,  9 Mar 2023 21:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678398046;
        bh=3wq26KsxRYgJgKQkJkLEWmbPo95CFXCI+ZKx265V92U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LEUhFdJZP0Z2dLCCGXGBBICPL6wkCO2qUJV/sKWkdjZRuXy1RNawaQBwfrmvA8V6h
         vN5OSDr3dT5VipUuK0nnu6TMicwJrHnuSO860P54Y7CY+PzUWJ4j0HgUp0x50zxHuL
         LuBpa5avCwJANtWxk0riBrMPYWSvt3CVwDJBEOsJoMQgLGo5gj7cw7ycSOEyovSGfK
         uCwpchCJ06yeU7+s9Ba6QcW1XYvjcv40S9xMcdDnxqwdIIpm1iBDFy7dM2vBGAljNt
         KCJZKplHAW3tQHQU2pqF73GVrwJ7XaNUt3VKigmxDpHzwlblDaFZytgY/E9i2uUdz4
         JfaCqVziC5n+Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filelocks: use mount idmapping for setlease permission check
Date:   Thu,  9 Mar 2023 22:40:33 +0100
Message-Id: <167839721674.824023.1725509969728722779.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309-generic_setlease-use-idmapping-v1-1-6c970395ac4d@kernel.org>
References: <20230309-generic_setlease-use-idmapping-v1-1-6c970395ac4d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=brauner@kernel.org; h=from:subject:message-id; bh=nOBSVxLcGUkeyc4+harlKP21L0eUuTL5amUOKXFfV8A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRwBXnImf729Xj+9H2+R3uN/pfSrfP0ktsZZN4fq0kp1w19 Ibqxo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJvpRj+CiqI3Drhk/pJP5nBd5t11E 8rIZvsm4+rZolWqddxZjz9z8jwpPXWion8ikX7rjGt27vk7MTZj6YuqzEVPSaqnTt1XfhiXgA=
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

From: Christian Brauner (Microsoft) <brauner@kernel.org>


On Thu, 09 Mar 2023 14:39:09 -0600, Seth Forshee (DigitalOcean) wrote:
> A user should be allowed to take out a lease via an idmapped mount if
> the fsuid matches the mapped uid of the inode. generic_setlease() is
> checking the unmapped inode uid, causing these operations to be denied.
> 
> Fix this by comparing against the mapped inode uid instead of the
> unmapped uid.
> 
> [...]

I've added a Cc: stable@vger.kernel.org so it's clear we should backport this.
But just to note this here right away, this will likely apply cleanly on 5.15
and 6.2 but fail to compile because our internal apis changed. So I'll have to
do a custom backport for 5.15 and 6.2 once we'll get the failure report thingy
from the stable folks. But applied now,

[1/1] filelocks: use mount idmapping for setlease permission check
      commit: 42d0c4bdf753063b6eec55415003184d3ca24f6e
