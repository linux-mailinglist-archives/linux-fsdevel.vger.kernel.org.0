Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2845EF827
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiI2O7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbiI2O6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:58:55 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AD814A780;
        Thu, 29 Sep 2022 07:58:54 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28TEwT9A008325
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664463515; bh=6Wnh1KxwQC30aGLb7Arpgapp5GBqfRDmGjxLP+HwTKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZByoBki0g1jf2cVHx8JI6H7N0AbHCTxK0McTtIjWceR8q4Yjz+8mTCBZ1JXrlkVcV
         MlXv3qzpQWZOQ+kT20tdrJQ1urXC8SovpXMBEXVUFPHUbVR39gmoW6QfuAZDCWsDCy
         RuqWagZXZtQgiRboMTZ+KCcbu3HnterzwjDrC+EAX7sYOLXiwVVIalQ0cCRM+EWR84
         9+wiyskM8TH56VF6fhIKugpFmDyP2XwDcjI9W4yjyNjEHeuPdNa7qcEdSVxS4zsE4q
         PKSr+aFHB9MVUHyvAbXIiPhBV7W+3xCpfl19retV13f7QHAooak1J6g8p2J51/1u8K
         cDKNTOoNGFv2g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7A1B115C3441; Thu, 29 Sep 2022 10:58:29 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, lczerner@redhat.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jlayton@kernel.org,
        ebiggers@kernel.org, jack@suse.cz, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v5] fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE
Date:   Thu, 29 Sep 2022 10:58:26 -0400
Message-Id: <166446350051.149484.15018548252092429742.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220825100657.44217-1-lczerner@redhat.com>
References: <20220824160349.39664-2-lczerner@redhat.com> <20220825100657.44217-1-lczerner@redhat.com>
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

On Thu, 25 Aug 2022 12:06:57 +0200, Lukas Czerner wrote:
> Currently the I_DIRTY_TIME will never get set if the inode already has
> I_DIRTY_INODE with assumption that it supersedes I_DIRTY_TIME.  That's
> true, however ext4 will only update the on-disk inode in
> ->dirty_inode(), not on actual writeback. As a result if the inode
> already has I_DIRTY_INODE state by the time we get to
> __mark_inode_dirty() only with I_DIRTY_TIME, the time was already filled
> into on-disk inode and will not get updated until the next I_DIRTY_INODE
> update, which might never come if we crash or get a power failure.
> 
> [...]

Applied, thanks!

[1/1] fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE
      commit: 625e1e67b66245b93ccae868cd4a950d257de003

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
