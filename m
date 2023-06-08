Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A18B72767C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 07:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjFHFBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 01:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjFHFBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:01:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BBB26AF;
        Wed,  7 Jun 2023 22:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IAO4FrOfs1P1S/rh6JwNk0FG/9u/tz0QHuvVjkXbpDY=; b=iOaftM0svwdaamuTg4GXrVYUAN
        FdmapHcgBrEI/eCTofTu8QIr2ztV/MxfFgowMaNrqvzKsP216gJP7tC4/PunnnC+pWtyDqqdI+qD5
        jiDn2H8Wkfrp1NcDYG45vzdsJO/FB5fdXaubBxAruqUnbdWaZWKYjzmLfvH1Wh9UbjDXFTHbrlVts
        USLCKerVnFqLAa5+/XE15VCRWIA6ZP6Vaq5CjlIFeudrfiFf1ZRKH30fNxvLh1ZSQ9qWbSAdVRpEC
        gjorD+v6oygp0F3tsgYTYF5/jGg8SxPoa9S/X0wfwwxYl7wDubzLL4ILiBW1Suv13Cao4k90plMsb
        7GDsY7bw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q77lq-0086dy-2B;
        Thu, 08 Jun 2023 05:01:14 +0000
Date:   Wed, 7 Jun 2023 22:01:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs: unify locking semantics for fs freeze / thaw
Message-ID: <ZIFgmjywefaAqLGi@infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508011717.4034511-2-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 07, 2023 at 06:17:12PM -0700, Luis Chamberlain wrote:
> Right now freeze_super()  and thaw_super() are called with
> different locking contexts. To expand on this is messy, so
> just unify the requirement to require grabbing an active
> reference and keep the superblock locked.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Maybe I'm just getting old, but where did I suggest this?

That being said, holding an active reference over any operation is a
good thing.  As Jan said it can be done way simpler than this, though.

Also please explain the actual different locking contexts and what
semantics you unify in the commit log please.

> - * freeze_super - lock the filesystem and force it into a consistent state
> + * freeze_super - force a filesystem backed by a block device into a consistent state
>   * @sb: the super to lock

This is not actually true.  Nothing in here has anything to do
with block devices, and it is used on a at least one non-block file
system.
