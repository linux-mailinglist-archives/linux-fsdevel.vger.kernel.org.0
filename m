Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E3F781953
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Aug 2023 13:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjHSLtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Aug 2023 07:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHSLtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Aug 2023 07:49:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27ECA7;
        Sat, 19 Aug 2023 04:48:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41BFE619A5;
        Sat, 19 Aug 2023 11:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303DBC433C8;
        Sat, 19 Aug 2023 11:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692445689;
        bh=A9tgsTdBMhQA/WJpr5nRjwwiNo470PILec1afwIdDoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAQ6LryMFjY2tRHa+R9xdI5OJBUao5XIAiOUYvUYLO2fk98nXL1koc72ROfCLeU21
         Zbg8xR7k+XFt0EVR0Uppc6WlHERuL6F/l2bLZZDV0i7bVBX+JhivFzypcoUoTMLc1e
         TvOKj4HKJLQPzAuaZAoVHnpa3cW7q3SaFYZuO2YUReHW0qPA9CGqHC1+Bm5zXlDsGi
         q8UW2boyVaJ8dBZj/mzYiDf+/fU6p6T4XB4wC0S7Xlt2PJwy+ti7bzc/Y5kYNaMj3k
         7vjlhV0pwo2p6YymaJVxcSuKVlkBPHbpMQbZaPCfxthmc8Xv3IK76vY/s+klvpjKZx
         mgrRrT4+AsmYA==
From:   Christian Brauner <brauner@kernel.org>
To:     Anh Tuan Phan <tuananhlfc@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v1] fs/dcache: Replace printk and WARN_ON by WARN
Date:   Sat, 19 Aug 2023 13:48:03 +0200
Message-Id: <20230819-flexibel-erzhaltig-a16a0fd46e24@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817163142.117706-1-tuananhlfc@gmail.com>
References: <20230817163142.117706-1-tuananhlfc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=brauner@kernel.org; h=from:subject:message-id; bh=A9tgsTdBMhQA/WJpr5nRjwwiNo470PILec1afwIdDoE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8WPVk292rTg5nUuY5XLueNLmLs3ShoMR0/feZfxuqny/Q U1/L3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRWdyMDGtXrEjdK/x4ouvUffrnj1 +WNLt0NX9hZeYhJ8v1x58dic9nZHhlZs70fduP8tNpFusvdbMd16hIb/olHPX86pdY/3XN5owA
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

On Thu, 17 Aug 2023 23:31:42 +0700, Anh Tuan Phan wrote:
> Use WARN instead of printk + WARN_ON as reported from coccinelle:
> ./fs/dcache.c:1667:1-7: SUGGESTION: printk + WARN_ON can be just WARN
> 
> 

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

[1/1] fs/dcache: Replace printk and WARN_ON by WARN
      https://git.kernel.org/vfs/vfs/c/7fbf9abcc77f
