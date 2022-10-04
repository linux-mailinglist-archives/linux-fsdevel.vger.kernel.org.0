Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6125F410D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 12:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiJDKv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 06:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJDKvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:51:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B50F54C9C;
        Tue,  4 Oct 2022 03:50:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C77911F7AB;
        Tue,  4 Oct 2022 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664880644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6CpXpnANGiqLNW8AuN+v74uE4I08ZrzS2Sw8W1oqoA0=;
        b=nXaMHs+rJdgfxOkTQMYu8FTsMGigk8dgQDExbBPXMq8fktJWi9D0gJqNbnt32z+2ijJwDt
        gF7SdVjozEjOX8MpT7m0s8loRBO5HvEzp3add/DtUnp2/2rHA4wdUCvDP2c6O4N5ZeMLUo
        z+yGuregFhpfW3BWiiTXBtzF301Rxpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664880644;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6CpXpnANGiqLNW8AuN+v74uE4I08ZrzS2Sw8W1oqoA0=;
        b=5uN0MVcpQ8avYsJ2q9dJ+cqHNEy21T/qOglGLbJVJbTqQDvjb8/cvXbOd6sE/0eiiuWVYq
        pCTRUuS62rhuF5Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FA28139D2;
        Tue,  4 Oct 2022 10:50:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ouWvGAQQPGPMEQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 04 Oct 2022 10:50:44 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id a481215e;
        Tue, 4 Oct 2022 10:51:39 +0000 (UTC)
Date:   Tue, 4 Oct 2022 11:51:39 +0100
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 08/23] ceph: Convert ceph_writepages_start() to use
 filemap_get_folios_tag()
Message-ID: <YzwQOw7y/l5tHEVx@suse.de>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
 <20220912182224.514561-9-vishal.moola@gmail.com>
 <35d965bbc3d27e43d6743fc3a5cb042503a1b7bf.camel@kernel.org>
 <Yzv37tg5wECSgQ/1@suse.de>
 <ed6de946a3b9f30d1c96f5214a3d6912ac1c742e.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed6de946a3b9f30d1c96f5214a3d6912ac1c742e.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 04, 2022 at 05:49:28AM -0400, Jeff Layton wrote:
> On Tue, 2022-10-04 at 10:07 +0100, Luís Henriques wrote:
> > Hi Jeff,
> > 
> > (Trimming down the CC list)
> > 
> > On Fri, Sep 30, 2022 at 12:25:15PM -0400, Jeff Layton wrote:
> > > 
> > > We have some work in progress to add write helpers to netfslib. Once we
> > > get those in place, we plan to convert ceph to use them. At that point
> > > ceph_writepages just goes away.
> > 
> > Sorry for hijacking this thread, but I was wondering if there was
> > something I could help here.  I haven't seen any netfs patches for this
> > lately, but I may have been looking at the wrong places.  I guess these
> > are still the bits that are holding the ceph fscrypt from progressing, so,
> > again, I'd be happy to at least help with the testing.
> > 
> 
> Work is somewhat stalled at the moment. David was on holiday for a while
> and I've had other priorities. I would like to see this wrapped up soon
> too however.

OK, awesome.  I just took this chance to make sure I didn't miss any netfs
update while I was also on vacations.  I'll keep watching, thanks a lot
for the update, Jeff!

Cheers,
--
Luís
