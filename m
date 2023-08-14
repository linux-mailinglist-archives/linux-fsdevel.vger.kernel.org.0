Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D7577C0B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 21:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjHNTYN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 15:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjHNTYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:24:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE659C;
        Mon, 14 Aug 2023 12:24:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34AD9640B6;
        Mon, 14 Aug 2023 19:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD7FC433C7;
        Mon, 14 Aug 2023 19:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692041048;
        bh=o3Hr6U8ctryPOyOYt2lVWBvOEWrDutJ89GR/VnTpMVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OesZRZ9PiKG3L4wcz5xDW1Lc17kKT6aeN3dnVAkSQhARhNhfBUyE0oYpJ/gUTaoOq
         7JilTzw3/wuSlhdNjZBUa7rI+S4+p9MlFG/CiqXRp+AdBfPoe39cdJgls4yIpHxclK
         /OusVTJntyl8hB6HdZ0ao55bHLfQxMDfEcpH3Uiur2RirmnspkqQCNB87xR7WEoGWd
         OiHNr/1tNgHnwuczie1P8jvYZbbOAD9Va9fEChQCNma4Ho7ZoPB77zg3eqekSRThuO
         LQQtnT2DedPomEAg2K8Ig14ntksk+q6IVdLYsdYu4tv8gu2+Ro9loD+cNtfH5QJz7f
         rgQ7sXM/R7TwQ==
Date:   Mon, 14 Aug 2023 12:24:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/3] ext4: reject casefold inode flag without casefold
 feature
Message-ID: <20230814192406.GD1171@sol.localdomain>
References: <20230814182903.37267-1-ebiggers@kernel.org>
 <20230814182903.37267-2-ebiggers@kernel.org>
 <87jztx5tle.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jztx5tle.fsf@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 03:09:33PM -0400, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > From: Eric Biggers <ebiggers@google.com>
> >
> > It is invalid for the casefold inode flag to be set without the casefold
> > superblock feature flag also being set.  e2fsck already considers this
> > case to be invalid and handles it by offering to clear the casefold flag
> > on the inode.  __ext4_iget() also already considered this to be invalid,
> > sort of, but it only got so far as logging an error message; it didn't
> > actually reject the inode.  Make it reject the inode so that other code
> > doesn't have to handle this case.  This matches what f2fs does.
> >
> > Note: we could check 's_encoding != NULL' instead of
> > ext4_has_feature_casefold().  This would make the check robust against
> > the casefold feature being enabled by userspace writing to the page
> > cache of the mounted block device.  However, it's unsolvable in general
> > for filesystems to be robust against concurrent writes to the page cache
> > of the mounted block device.  Though this very particular scenario
> > involving the casefold feature is solvable, we should not pretend that
> > we can support this model, so let's just check the casefold feature.
> > tune2fs already forbids enabling casefold on a mounted filesystem.
> 
> just because we can't fix the general issue for the entire filesystem
> doesn't mean this case *must not* ever be addressed. What is the
> advantage of making the code less robust against the syzbot code?  Just
> check sb->s_encoding and be safe later knowing the unicode map is
> available.
> 

Just to make sure, it sounds like you agree that the late checks of ->s_encoding
are not needed and only __ext4_iget() should handle it, right?  That simplifies
the code so it is obviously beneficial if we can do it.

As for whether __ext4_iget() should check the casefold feature or ->s_encoding,
we should simply go with the one that makes the code clearer, as per what I've
said.  I think it's casefold, but it could be ->s_encoding if others prefer.

- Eric
