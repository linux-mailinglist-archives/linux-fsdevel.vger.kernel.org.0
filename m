Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E3D5EF828
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiI2O7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 10:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiI2O7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:59:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8986914A78D;
        Thu, 29 Sep 2022 07:59:00 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28TEwTlI008338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664463512; bh=e4fgP6dFIaXmrLv7sqbKbojxLHJoPOZrEJq+eOpDnuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LDdM0sRMcyQRV3IOh8BHZAbdG4piE/edNqnawPobaeXx6dGOw74jaq/K0Y/fG3w+G
         Nt3ybJDeJH+MS1kudMl4bUrrHr3isq7mwwNrUGqNE6qlNgZucaX7y4lVYLtm50eYLX
         N22fQJlsFBFfZjtYGZZ484PWtakLy2p7Cqnaz2PnekPt10lfw19lrzU9lMZR1x1nuV
         RJFro3OGZGzQI/L2JaInyMq6oBC4U31cbWcHvxAy6YwaY/S+vuA9ImU2dVwlsnTYIT
         YxlrU9xbaY3Oh8KA+xMckD9qxFmOaBIik/aLWlj2qmJGe3elTvDSJzalxbiLGeaKo8
         nDHf2bE0fNmFA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7BBC715C3443; Thu, 29 Sep 2022 10:58:29 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     ritesh.list@gmail.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        linux-ntfs-dev@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>, jack@suse.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCHv3 0/4] submit_bh: Drop unnecessary return value
Date:   Thu, 29 Sep 2022 10:58:27 -0400
Message-Id: <166446350046.149484.7882160010010426978.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1660788334.git.ritesh.list@gmail.com>
References: <cover.1660788334.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Aug 2022 10:34:36 +0530, Ritesh Harjani (IBM) wrote:
> submit_bh/submit_bh_wbc are non-blocking functions which just submits
> the bio and returns. The caller of submit_bh/submit_bh_wbc needs to wait
> on buffer till I/O completion and then check buffer head's b_state field
> to know if there was any I/O error.
> 
> Hence there is no need for these functions to have any return type.
> Even now they always returns 0. Hence drop the return value and make
> their return type as void to avoid any confusion.
> 
> [...]

Applied, thanks!

[1/4] jbd2: Drop useless return value of submit_bh
      commit: c2939da1fe8b25c82c1991eb983638463ed84a0c
[2/4] fs/ntfs: Drop useless return value of submit_bh from ntfs_submit_bh_for_read
      commit: f102f1ab784c91c559a3505d024008ff2decc77f
[3/4] fs/buffer: Drop useless return value of submit_bh
      commit: 7cb83d3c0c485b3b035cdcac4c6ef4937f920c59
[4/4] fs/buffer: Make submit_bh & submit_bh_wbc return type as void
      commit: 54a55bcabb92f7522e006ca38575159c41914c56

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
