Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8548F552FEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 12:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347054AbiFUKkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 06:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347324AbiFUKkS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:40:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572E828E27
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 03:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 192DFB8175A
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 10:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC92EC3411D;
        Tue, 21 Jun 2022 10:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655808014;
        bh=O5t4axgXYdHhiBD6feZzdqoPtGvWGIj2xbuiKYrXi/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUmE78/ns7v6C1R1et9bbIwNRHYyojJr7M6+54N8jdKNetibtWoR3H652mhxpsmAI
         R8Eis7l0sEeBBRFEfLYCSS9N1a3rEuPkSE9/hzfICm3jIQuJXhtD4yQNySP/s8ShlC
         qWLHG2+z0Z0IPulZ0G+iAEaybS0Ij1Xh+d/Cc/2mKmP0b/ruAoqpm4QI08+iY+z3Wt
         9U2JM/U5tJ25kuqBQNzOCsma5wtBiR8pN/IS7JJTQrHnlOTOU6EvViDgdYo7WFF5Mi
         pAvOOkQtF1RX0mbOAYccc0B9Q5Mo0hxaTT6hV2sjWN1mm0R/DjVPLr8NCnOwlVcUdE
         s8QH/MFZN6NDw==
Date:   Tue, 21 Jun 2022 12:40:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 6/8] quota: port quota helpers mount ids
Message-ID: <20220621104010.so4nlmmg2rvsz3ov@wittgenstein>
References: <20220620134947.2772863-1-brauner@kernel.org>
 <20220620134947.2772863-7-brauner@kernel.org>
 <20220621102027.iw6yoo5lrr4oe3m6@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220621102027.iw6yoo5lrr4oe3m6@quack3.lan>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 21, 2022 at 12:20:27PM +0200, Jan Kara wrote:
> On Mon 20-06-22 15:49:45, Christian Brauner wrote:
> > Port the is_quota_modification() and dqout_transfer() helper to type
> > safe kmnt{g,u}id_t. Since these helpers are only called by a few
> > filesystems don't introduce a new helper but simply extend the existing
> > helpers to pass down the mount's idmapping.
> > 
> > Note, that this is a non-functional change, i.e. nothing will have
> > happened here or at the end of this series to how quota are done! This
> > a change necessary because we will at the end of this series make
> > ownership changes easier to reason about by keeping the original value
> > in struct iattr for both non-idmapped and idmapped mounts.
> > 
> > For now we always pass the initial idmapping which makes the idmapping
> > functions these helpers call nops.
> > 
> > This is done because we currently always pass the actual value to be
> > written to i_{g,u}id via struct iattr. While this allowed us to treat
> > the {g,u}id values in struct iattr as values that can be directly
> > written to inode->i_{g,u}id it also increases the potential for
> > confusion for filesystems.
> > 
> > Now that we are about to introduce dedicated types to prevent this
> > confusion we will ultimately only map the value from the idmapped mount
> > into a filesystem value that can be written to inode->i_{g,u}id when the
> > filesystem actually updates the inode. So pass down the initial
> > idmapping until we finished that conversion.
> > 
> > Since struct iattr uses an anonymous union with overlapping types as
> > supported by the C filesystems that haven't converted to ia_mnt{g,u}id
> > won't see any difference and things will continue to work as before.
> > In other words, no functional changes intended with this change.
> > 
> > Cc: Seth Forshee <sforshee@digitalocean.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > CC: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> Yeah, this looks fairly innocent. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Just when do you plan to make changes actually using the passed namespace?

Hey Jan,

Thank you for the review!
The changes are in the last patch of the series. But it is all unrelated
to quotas and doesn't alter them in any way. We really just change how
ia_{vfs}uid is set up to get type safety which requires the generic
codepaths like here to calculate the correct value when they actually
perform a write instead of having performed that calculation when we
set up iattr. That's really all.

Thanks!
Christian
