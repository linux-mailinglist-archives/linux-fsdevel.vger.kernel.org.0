Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E786F5E94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjECSxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjECSxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:53:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9811BCA;
        Wed,  3 May 2023 11:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A186628FB;
        Wed,  3 May 2023 18:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D155C433EF;
        Wed,  3 May 2023 18:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683140027;
        bh=Tt1IVHowAm04rV7fMokQMuz8wTkl3aCyv7RhwH49rX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C1UFMFDLq86Q5Uu322j2TdntYxiPuJOCbpIS7B6ayxvqLNiMGNapad5nAW/v5P5JW
         cBfTMV+BAg84mI/i2e4OKxY8q8XY3QenwEn/MfMlqjEYL3pLMRsJa8q5Vgi3rSNz2u
         aAn4CmqwI0ijiIwqpbK1hCzSarSQBXVhC+Bk9ohQ9VpOv53cB6iRHpXQ4+wSwWTjQt
         clw5Ti3m5jtb197SbHMoi0iJ1Yap1FVnhYGiKXe0mUkwoLq3pHzbeHTlO/B4tWsro0
         h1a4Sl2gjYKiqUnjy42PJgBKq7qxp+SEltgCrHCLKZ/q9814CPM7o6fbNEtXkiIwwx
         3DyWjGnKXwMiw==
Date:   Wed, 3 May 2023 12:53:43 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Subject: Re: [PATCH RFC 06/16] block: Limit atomic writes according to bio
 and queue limits
Message-ID: <ZFKtt2Z5BPyV9gHJ@kbusch-mbp.dhcp.thefacebook.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-7-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503183821.1473305-7-john.g.garry@oracle.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 06:38:11PM +0000, John Garry wrote:
> +	unsigned int size = (atomic_write_max_segments - 1) *
> +				(PAGE_SIZE / SECTOR_SIZE);

Maybe use PAGE_SECTORS instead of recalculating it.
