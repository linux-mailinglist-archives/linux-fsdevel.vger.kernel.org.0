Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B655728910
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 21:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjFHTzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 15:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjFHTzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:55:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E172733;
        Thu,  8 Jun 2023 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+1Y87JI1ExyyqKN04ljVebM0yuw8A6N4rqGWYyXdVbk=; b=z4oGDQW6excVHUsoDrKtRT1INe
        neLeUDTt7v6wFVfj3itYZ8a7QWSnfgd2GrgNbq7wSDLq0QBhvn/nspQgYNDMSaHoDdRuZAlFAWbH2
        6rN0ffPKQHTEG3fW9tac2rqYxSozh7Dw/QX64FQgKwS8TkuEakH/j6aQnzUx9m7HXXOCePnG3J/Iv
        j7QDNc25qsZ/6t+aKEECjIX/pdjf9dPP26hlmNgbHnIvgNlOyplTS3OV5Qd1hIHih+t+Y1A7Uwcmy
        cCLHY+6SRYCzBU3NwtivPWCN8iqU0XKL5QPpxRp/IsKfn5z0rgJnM9kAPvBJfD0hkZa5RGxJAtkM+
        XxX46jRw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q7LjO-00ASde-0D;
        Thu, 08 Jun 2023 19:55:38 +0000
Date:   Thu, 8 Jun 2023 12:55:38 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     djwong@kernel.org, sandeen@sandeen.net, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs: unify locking semantics for fs freeze / thaw
Message-ID: <ZIIyOsHlZLHqP0QB@bombadil.infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-2-mcgrof@kernel.org>
 <ZIFgmjywefaAqLGi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIFgmjywefaAqLGi@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:01:14PM -0700, Christoph Hellwig wrote:
> On Sun, May 07, 2023 at 06:17:12PM -0700, Luis Chamberlain wrote:
> > Right now freeze_super()  and thaw_super() are called with
> > different locking contexts. To expand on this is messy, so
> > just unify the requirement to require grabbing an active
> > reference and keep the superblock locked.
> > 
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> Maybe I'm just getting old, but where did I suggest this?

https://lore.kernel.org/all/20210420120335.GA3604224@infradead.org/

"I don't think we need both variants, just move the locking and s_active
acquisition out of free_super.  Same for the thaw side."

> That being said, holding an active reference over any operation is a
> good thing.  As Jan said it can be done way simpler than this, though.

Great.


  Luis
