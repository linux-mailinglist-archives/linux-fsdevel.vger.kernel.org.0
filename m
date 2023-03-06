Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DDF6AB526
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 04:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCFDuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Mar 2023 22:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFDuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:50:54 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246EDC646;
        Sun,  5 Mar 2023 19:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1678074650;
        bh=uOpjYi/uwBaBMW8bz4zVun2hNpZrW4Dt7bBTAD9vHpA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=T8lPnbWzdOIza/IhsTAWCawsX4jPwiAZ25CHyR43GLMM+uOn29OwSNeEqsQuwVh0D
         ETAQy8e7nidLM/i/reZxUWFxis3vec10HQAxcWY28nIvBFIoSLpgklbsFXl0jRK4BR
         Kt8cjZdreuOEPCRgUZUck9FfeieOYgy7Zit5gke4=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9F2E01280671;
        Sun,  5 Mar 2023 22:50:50 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8kPEqNcgNz3h; Sun,  5 Mar 2023 22:50:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1678074650;
        bh=uOpjYi/uwBaBMW8bz4zVun2hNpZrW4Dt7bBTAD9vHpA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=T8lPnbWzdOIza/IhsTAWCawsX4jPwiAZ25CHyR43GLMM+uOn29OwSNeEqsQuwVh0D
         ETAQy8e7nidLM/i/reZxUWFxis3vec10HQAxcWY28nIvBFIoSLpgklbsFXl0jRK4BR
         Kt8cjZdreuOEPCRgUZUck9FfeieOYgy7Zit5gke4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9FCF11280651;
        Sun,  5 Mar 2023 22:50:49 -0500 (EST)
Message-ID: <9bdeda94a7cd2ee9218d992e1da95a322ce0ec68.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Date:   Sun, 05 Mar 2023 22:50:48 -0500
In-Reply-To: <ZAN0JkklyCRIXVo6@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
         <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
         <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
         <f68905c5785b355b621847974d620fb59f021a41.camel@HansenPartnership.com>
         <ZAL0ifa66TfMinCh@casper.infradead.org>
         <2600732b9ed0ddabfda5831aff22fd7e4270e3be.camel@HansenPartnership.com>
         <ZAN0JkklyCRIXVo6@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2023-03-04 at 16:39 +0000, Matthew Wilcox wrote:
> > I fully understand that eventually we'll need to get a single large
> > buffer to span discontiguous pages ... I noted that in the bit you
> > cut, but I don't see why the prototype shouldn't start with
> > contiguous pages.
> 
> I disagree that this is a desirable goal.  To solve the scalability
> issues we have in the VFS, we need to manage memory in larger chunks
> than PAGE_SIZE.  That makes the concerns expressed in previous years
> moot.

Well, what is or isn't desirable in this regard can be left to a later
exploration.  Most of the cloud storage problems seem to be solved with
a 16k block size, for which I think we'll find current compaction is
good enough.  I actually think we might not have a current cloud use
case beyond 64k sectors.

James

