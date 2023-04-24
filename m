Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B341B6ED817
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 00:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjDXWkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 18:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDXWka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:40:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95E665BD;
        Mon, 24 Apr 2023 15:40:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4189A21940;
        Mon, 24 Apr 2023 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682376027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=feM04i0/6vRuC/hd4QJiH2jTDvSUCiEV+H+qsq5ng/c=;
        b=jG+djohD8LGJypEysxreNq4J8bODv9nphYXo5fWEF17C4/Gp3msq4EBRjGFKymD74WWmPm
        IOpO3GfwWAxh82FJ48B0HmTHg0BPLqY64nj52Ce3TDPCAKWFmAPUv1JXkEDyZkSUIlV5bB
        1XMM9ghroU4WStNf9bzrRWgcT1esNc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682376027;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=feM04i0/6vRuC/hd4QJiH2jTDvSUCiEV+H+qsq5ng/c=;
        b=HVvj5Jq4rjhdr0M094REXU/pQH9kVDhjtHdES+sbOskKKlCDCStXvr1hjWGjcnxMTOEX//
        RzBOPSkmJFiWP+AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E7FC13780;
        Mon, 24 Apr 2023 22:40:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CBiBFVYFR2QwSwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Apr 2023 22:40:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Hugh Dickins" <hughd@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Chinner" <david@fromorbit.com>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Jan Kara" <jack@suse.cz>,
        "Amir Goldstein" <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs: add infrastructure for multigrain inode i_m/ctime
In-reply-to: <404a9a8066b0735c9f355214d4eadf0d975b3188.camel@kernel.org>
References: <20230424151104.175456-1-jlayton@kernel.org>,
 <20230424151104.175456-2-jlayton@kernel.org>,
 <168237287734.24821.11016713590413362200@noble.neil.brown.name>,
 <404a9a8066b0735c9f355214d4eadf0d975b3188.camel@kernel.org>
Date:   Tue, 25 Apr 2023 08:40:19 +1000
Message-id: <168237601955.24821.11999779095797667429@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 25 Apr 2023, Jeff Layton wrote:
> On Tue, 2023-04-25 at 07:47 +1000, NeilBrown wrote:
> > On Tue, 25 Apr 2023, Jeff Layton wrote:
> > > +	/*
> > > +	 * Warn if someone sets SB_MULTIGRAIN_TS, but doesn't turn down the ts
> > > +	 * granularity.
> > > +	 */
> > > +	return (sb->s_flags & SB_MULTIGRAIN_TS) &&
> > > +		!WARN_ON_ONCE(sb->s_time_gran == 1);
> > 
> >  Maybe 
> > 		!WARN_ON_ONCE(sb->s_time_gran & SB_MULTIGRAIN_TS);
> >  ??
> > 
> 
> I'm not sure I understand what you mean here.

That's fair, as what I wrote didn't make any sense.
I meant to write:

 		!WARN_ON_ONCE(sb->s_time_gran & I_CTIME_QUERIED);

to make it explicit that s_time_gran must leave space for
I_CTIME_QUERIED to be set (as you write below).  Specifically that
s_time_gran mustn't be odd. 
  
>                                                We want to check whether
> SB_MULTIGRAIN_TS is set in the flags, and that s_time_gran > 1. The
> latter is required so that we have space for the I_CTIME_QUERIED flag.
> 
> If SB_MULTIGRAIN_TS is set, but the s_time_gran is too low, we want to
> throw a warning (since something is clearly wrong).
> 

NeilBrown
