Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D427706111
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjEQH0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 03:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEQH0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 03:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356CCC5;
        Wed, 17 May 2023 00:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C638A63CE3;
        Wed, 17 May 2023 07:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76501C433EF;
        Wed, 17 May 2023 07:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684308407;
        bh=aqNY6qE18SxSweL7OgAJaona5RImY/HQUlycRg3Pwe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vMZQ+S21a02s+M0+475Ybj94bAl+EIGza5yKMZf1nxPw75qt0KPUnmwy32MhLXjOO
         V30S95rczEQLaBoZDxVn/hN1+MNhAjIV4s/mH5g9N4m17iN2dXcNeoH8dluj4HPhq3
         leJQYN5nvozfCzfVoG+EDYN4tjV5ELAPjEbKuZi4/2UmQCF7eGXqSMiIZJ5/bHRXcK
         0FxmH9rmGPKypK7dzmuXto7Dx61Sb9I3Uhxej/lC0IeCyemSz5NBlKXAju6KY5AIkR
         9tuUH+lXJHnR/dHviAnkn+xU8iPSnvL8+NaPSmpf3Km1xEzYaegxX7ZGU1hm4FxO0F
         JopB3QI89srjQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] procfs: consolidate arch_report_meminfo declaration
Date:   Wed, 17 May 2023 09:26:21 +0200
Message-Id: <20230517-bargeld-achthundert-0d56603bda7f@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516195834.551901-1-arnd@kernel.org>
References: <20230516195834.551901-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=brauner@kernel.org; h=from:subject:message-id; bh=aqNY6qE18SxSweL7OgAJaona5RImY/HQUlycRg3Pwe8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSkNNa1vbRzrT/o77xHepL944QPMhKS2t2+9xZpWcxdIxl1 83FWRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET8nzH8lW9/nrtIm21nErejtfePeu GUac5Gq8/q24nk/N5yNr/6MyPDpacPY5c0ByfOf3wutTx4atH5rp+t6y2kIyf96L7cFLueDQA=
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

On Tue, 16 May 2023 21:57:29 +0200, Arnd Bergmann wrote:
> The arch_report_meminfo() function is provided by four architectures,
> with a __weak fallback in procfs itself. On architectures that don't
> have a custom version, the __weak version causes a warning because
> of the missing prototype.
> 
> Remove the architecture specific prototypes and instead add one
> in linux/proc_fs.h.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] procfs: consolidate arch_report_meminfo declaration
      https://git.kernel.org/vfs/vfs/c/edb0469aa6e8
