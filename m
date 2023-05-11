Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5E26FF981
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 20:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbjEKSaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 14:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjEKSaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 14:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D51319BE
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 11:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BD6064F64
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 18:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79E8C433EF;
        Thu, 11 May 2023 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683829822;
        bh=zcdqfkhDJV+fqj6SVq8X3nCLMru950KsySlBlAEkZds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAsvLxiQKWufc8o4Ql8gFm1A+43TtFujhsos8ZI1NeerpFXeMB62qcjqyWLN2C4PY
         ftfETK9sA7BzmTzbaC7c8KhHR4twA2dPmDENyDL24NeeYN8yNXAk3NO2qxhGU9LMVz
         Kp8femz+OXlMPdIeIyVt59wzlSO6SEImvAayvKB8QzpXQmt/ifh0nrTpiaFyW+nBGs
         2TNUY8EK2/AKS48tPo56cUYhlrmjD0M2SuJiZX0pQDEpyxxYavKZnJ7ja0xpAus5gE
         AIYE85vjz6ABuZtT1VazchTfzGvh3VRsNvOIWTclpG3hYPlWKzdYDDvBpLdRQND+Er
         fRNGVmIlRlJqA==
From:   Christian Brauner <brauner@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] pipe: check for IOCB_NOWAIT alongside O_NONBLOCK
Date:   Thu, 11 May 2023 20:29:58 +0200
Message-Id: <20230511-bronzen-gleis-2086f7dcfb9e@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e5946d67-4e5e-b056-ba80-656bab12d9f6@kernel.dk>
References: <e5946d67-4e5e-b056-ba80-656bab12d9f6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=608; i=brauner@kernel.org; h=from:subject:message-id; bh=zcdqfkhDJV+fqj6SVq8X3nCLMru950KsySlBlAEkZds=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTEmigF2Cv3buibU9koOP/OrPbtEe99X7qLSPT+FUz9frQ6 mV+4o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLWAYwMa24sNLfQOvHjhHuZ5i/X6W 0n2A+80Pz7/mOih3Pyo00rZjEy7Nu6x5t/b4oAy8bOuK5NFt9Wm8iobL95cf22QC6fV1O8WAE=
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

On Tue, 09 May 2023 09:12:24 -0600, Jens Axboe wrote:
> Pipe reads or writes need to enable nonblocking attempts, if either
> O_NONBLOCK is set on the file, or IOCB_NOWAIT is set in the iocb being
> passed in. The latter isn't currently true, ensure we check for both
> before waiting on data or space.
> 
> 

Thanks. I picked this up and pushed a tag.
I'll get this to Linus before -rc2, Jens.

tree: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
tag: vfs/v6.4-rc1/pipe
[1/1] pipe: check for IOCB_NOWAIT alongside O_NONBLOCK
      commit: d326147107eb7152941ab3b04ed4ffba8ce93f64
