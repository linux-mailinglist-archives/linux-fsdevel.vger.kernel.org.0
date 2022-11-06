Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2AB61E1EC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Nov 2022 12:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKFLwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Nov 2022 06:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiKFLwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Nov 2022 06:52:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89CBB7C3;
        Sun,  6 Nov 2022 03:52:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 46E6DCE0B99;
        Sun,  6 Nov 2022 11:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C53C433C1;
        Sun,  6 Nov 2022 11:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667735525;
        bh=cUzSG/ewXQ7ukEwiTeKzTYtwm0Zorco6X9iOVToIFIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IwXeExPTvJRWuzHoam4taltPYk8QtFlGhLvwC2zbMLR1uPB4BVxIY9wkjjdRz4AqU
         mJVHqEvFDyNcfalLMqCXUFf0+bJH2JSAfJGvK4Jk52ISmoFPSfVtqKXsAT/0EDHXt2
         rBtPuJX8zaZQe6Wlq04H55qc2ED9Q1FP7pb3zDee39yc6z8Irxi6Ua5PxXX/qNynvN
         f5R1exgqyw30QznV2g5FoQO7KyZHzj3zpXg8AUJrgSWyNnX+sSfmizEXIg6AljUW81
         VHV9HdY+t1WEkjM9JZbsj29kr6HOXW8BvHij7jQzVQJfIBk+UNz72dC1gEmao7AMO1
         mIp+8q8z91BeA==
From:   Christian Brauner <brauner@kernel.org>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] squashfs: enable idmapped mounts
Date:   Sun,  6 Nov 2022 12:51:55 +0100
Message-Id: <166773513784.1468888.296199198590720418.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024191552.55951-1-michael.weiss@aisec.fraunhofer.de>
References: <20221024191552.55951-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=736; i=brauner@kernel.org; h=from:subject:message-id; bh=PWRPQ0anS+KATo2falJ86mpv2iCS1+5FIiAuxM0+LRY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSnz7+6/+aPQDONoOMn/t8MyQmpNl7yTOIj35InKyZM8Wie 91yCuaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAij88z/C9NCRKa8WCS09z76jP2M7 Gva/+8fXFRbsVluS+Tl6XbnnNkZLh7q7PtnuHXpLCIu89fOiUwtWzN7d53vGnSVZlJUZyW33gA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner (Microsoft) <brauner@kernel.org>

On Mon, 24 Oct 2022 21:15:52 +0200, Michael Weiß wrote:
> For squashfs all needed functionality for idmapped mounts is already
> implemented by the generic handlers in the VFS. Thus, it is sufficient
> to just enable the corresponding FS_ALLOW_IDMAP flag to support
> idmapped mounts.
> 
> We use this for unprivileged (user namespaced) containers based on
> squashfs images as rootfs in GyroidOS.
> 
> [...]

Hey Phillip,

Michael reminded me about this patch just now. I've picked this up now so it
can make it into the next mw. Phillip, in case you'll pick this up just tell me
and I'll drop it.

[1/1] squashfs: enable idmapped mounts
      commit: 01546f1d7142f27002789e8626a32b20d5853a48

Thanks!
Christian
