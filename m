Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3892E554151
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356783AbiFVEL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356852AbiFVELE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:11:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D274344CC
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2E0D61904
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jun 2022 04:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC81CC3411B;
        Wed, 22 Jun 2022 04:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655871058;
        bh=5T8X0huE8Rl+gI/mpiiLGNJyuCdinc5ySc70DpzWrQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9JWjy3a3RjryMwTiw7Qz6KS2to5fPnbji+fL2q0N5E+3F+PL3hYExaCDRgl7U9Fw
         dLFY9rAHUMkr2pC49D5ZOTiP4Gi0lnl6l3mVKBf0AQJjO9F99wiaQNTFzSrjNzdM11
         bFs07GsgPcfr6dk3R+i2/S4nQTRfXcT/KWGpU7FImp8+xwQxCSEKeAX3rsWrgwWgbS
         g5/imskriy3EuO6Hv7PZVkxf9zdbxqFV1dUjvtUlvPewzAKBLRaY5kNjUpzHooFUrD
         euIQFG5CoeTp2NLuZz1eaxDzJwGCDug/i106rgCdU5nP8RuGvXHZkSdvlu4LNsPA5H
         JsX1IuCqWNx7w==
Date:   Wed, 22 Jun 2022 06:10:51 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/8] mnt_idmapping: add vfs{g,u}id_t
Message-ID: <20220622041051.3qt2vvlju7taepmn@wittgenstein>
References: <20220621141454.2914719-1-brauner@kernel.org>
 <20220621141454.2914719-2-brauner@kernel.org>
 <YrIMZirGoE0VIO45@do-x1extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrIMZirGoE0VIO45@do-x1extreme>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 21, 2022 at 01:22:30PM -0500, Seth Forshee wrote:
> On Tue, Jun 21, 2022 at 04:14:47PM +0200, Christian Brauner wrote:
> > +/**
> > + * kuid_eq_vfsuid - check whether kuid and vfsuid have the same value
> > + * @kuid: the kuid to compare
> > + * @vfsuid: the vfsuid to compare
> > + *
> > + * Check whether @kuid and @vfsuid have the same values.
> > + *
> > + * Return: true if @kuid and @vfsuid have the same value, false if not.
> > + */
> > +static inline bool kuid_eq_vfsuid(kuid_t kuid, vfsuid_t vfsuid)
> > +{
> > +	return __vfsuid_val(vfsuid) == __kuid_val(kuid);
> > +}
> 
> Something that I think would be helpful is if this and other comparison
> functions always returned false for comparisons with invalid, e.g.:
> 
> static inline bool kuid_eq_vfsuid(kuid_t kuid, vfsuid_t vfsuid)
> {
>         return vfsuid_valid(vfsuid) && __vfsuid_val(vfsuid) == __kuid_val(kuid);
> }
> 
> I can't imagine any cases where we would want even two invalid ids to
> evaluate as being equal, and so as it is now we have to take great care
> to ensure that we never end up with comparisons between two invalid ids.
> 
> Honestly I'd like to see that for kuid_t comparisons too, but I suppose
> that's a little out of scope here.

Yes, I agree.
That goes back to our discussion yesterday. Thank you for that idea!

As I've mentioned, I'd like to do to this carefully by applying a final
patch on top of the whole series that adds an additional vfsuid_valid()
check to all equality helpers. In case we see a regression we can then
easily revert the single commit on top.

Christian
