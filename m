Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E37775448
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 09:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjHIHiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 03:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHIHiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F2F183;
        Wed,  9 Aug 2023 00:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3741F63010;
        Wed,  9 Aug 2023 07:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E09C433C9;
        Wed,  9 Aug 2023 07:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691566698;
        bh=/vk/CU1Gmo1hDzO1N776jRJsg42Jf+F322iPzlE/xpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNDPr5NE2BfdCP6gX4c6UBRNiveKPc6Xc2F07QqqLyCwho5fTTTnPTWfWAGeELiVJ
         ZmZSOLnhOjHdA3E3D3CELry2nF56voTfALoVAViVuo0CsPIOmtG5DjDsyZXUuqmTG3
         S/AkdEP5XHl6ATcWraR8ni/elBaVGdXNcOMxwvIEwv/fic3cLkmeOX8dyv+HfVvyzW
         cLaAl6U+Y8+aYXDA+ahimmj1z2FR42JHknJ6UjI6ddQFrkRzij6I/Nu7ZNBCh+jf8k
         7qUyw2vVesviLlPfK51DjxugtgV6528OOJX5Rkb7zQRqpE5GKa2uPxsD4ntAJ5FRX8
         8yMYhiaZ849Aw==
Date:   Wed, 9 Aug 2023 09:38:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 03/13] xfs: free the mount in ->kill_sb
Message-ID: <20230809-besang-chaoten-642fff8a141a@brauner>
References: <20230808161600.1099516-1-hch@lst.de>
 <20230808161600.1099516-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808161600.1099516-4-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:15:50AM -0700, Christoph Hellwig wrote:
> As a rule of thumb everything allocated to the fs_context and moved into
> the super_block should be freed by ->kill_sb so that the teardown
> handling doesn't need to be duplicated between the fill_super error
> path and put_super.  Implement a XFS-specific kill_sb method to do that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

For filesystems on the new mount api it's always nice if the rules
can simply be made:

* prior to sget_fc() succeeding fc->s_fs_info and freed in fs_context_operations->free()
* after    sget_fc() succeeding fc->s_fs_info transfered to sb->s_fs_info and freed in fs_type->kill_sb()
