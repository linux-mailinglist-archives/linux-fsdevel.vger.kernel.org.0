Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755487472E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGDNkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 09:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjGDNku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9282E6D;
        Tue,  4 Jul 2023 06:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49C3261241;
        Tue,  4 Jul 2023 13:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0359AC433C7;
        Tue,  4 Jul 2023 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688478045;
        bh=KqnNycdfwTnK89YXVJiqvJO71iZYNapVXtrGgGRpNkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iDajaYjRgsBBwlE0pZCeDpyYTpCfMVeZWCANZkynVTNTobZqHZ3B+2FnsL/bh5o5G
         rKmynkgRqn+S1H/OLJ7ZTcj5c+kIMuyrNplEMDtql/scl0Tgaofd8SYRGxTwy9OmWt
         /p0fkNtNexwUC9OXa2PUQCZ4awCRu0ffZLnuq50E2ndIXnW8038+jiV5kayaEGkqEi
         Qtp4B3xcIl0uf2n3o8gpYsG4AmMvFaS+Iu1c9UIOxp7YPNPzoUPkm42OIHCT3KivKl
         RUAwPyRt1fxCOPdpl+hjZkN7im0vpThRNV6hVn5tlAvLjehdYhlrKabHIJ3ENkAYgd
         g3ZNHmK7rBoxg==
Date:   Tue, 4 Jul 2023 15:40:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH RFC 0/6 v2] block: Add config option to not allow writing
 to mounted devices
Message-ID: <20230704-holzrahmen-diebstahl-cd758ca7158e@brauner>
References: <20230704122727.17096-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230704122727.17096-1-jack@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 04, 2023 at 02:56:48PM +0200, Jan Kara wrote:
> Hello!
> 
> This is second version of the patches to add config option to not allow writing
> to mounted block devices. For motivation why this is interesting see patch 1/6.
> I've been testing the patches more extensively this time and I've found couple
> of things that get broken by disallowing writes to mounted block devices:
> 1) Bind mounts get broken because get_tree_bdev() / mount_bdev() first try to
>    claim the bdev before searching whether it is already mounted. Patch 6
>    reworks the mount code to avoid this problem.
> 2) btrfs mounting is likely having the same problem as 1). It should be fixable

It likely would. Note that I've got a series to port btrfs to the new
mount api that I sent out which changes btrfs mounting quite
significantly.
