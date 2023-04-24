Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ED86EC935
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjDXJna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 05:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjDXJn1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:43:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F23B2D47;
        Mon, 24 Apr 2023 02:43:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D9B621A29;
        Mon, 24 Apr 2023 09:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682329405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WC/dt75N+hDAUmu++Ih6NqVKD/ape2sN09upWYqvvfo=;
        b=TRaPh3HUNIJm4RO5srNYjWR1XL8WPw2ah4eR5HM5KI0tK0V5SCC8qnGp7afJiRC1R7fZq0
        H+K7jkbv/4YTCKkq3Bd4AertN+vdduNBfx6wHAT/KQhIKvexhPt7YamXMA1kPFV0fby2hK
        sCV73/xAGPjK8ByJHJQfNPUEKm7WAg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682329405;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WC/dt75N+hDAUmu++Ih6NqVKD/ape2sN09upWYqvvfo=;
        b=V8iYK5XudnGEWXXgq6h3xm6CIK86/WnCQQ/FrxKS12kTRprpL6SwfDCkwqkIUQdEl+SXAf
        XIu8u2neAk+lEEDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DDD61390E;
        Mon, 24 Apr 2023 09:43:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k/wpCz1PRmRpFQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 24 Apr 2023 09:43:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B6625A0729; Mon, 24 Apr 2023 11:43:24 +0200 (CEST)
Date:   Mon, 24 Apr 2023 11:43:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Ted Tso <tytso@mit.edu>
Subject: Re: [PATCHv6 0/9] ext2: DIO to use iomap
Message-ID: <20230424094324.lq3nqfj54hocm423@quack3>
References: <20230421112324.mxrrja2hynshu4b6@quack3>
 <87edodigo4.fsf@doe.com>
 <20230421154058.GH360881@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421154058.GH360881@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 21-04-23 08:40:58, Darrick J. Wong wrote:
> On Fri, Apr 21, 2023 at 05:35:47PM +0530, Ritesh Harjani wrote:
> > Jan Kara <jack@suse.cz> writes:
> > 
> > > Hello Ritesh,
> > >
> > > On Fri 21-04-23 15:16:10, Ritesh Harjani (IBM) wrote:
> > >> Hello All,
> > >>
> > >> Please find the series which rewrites ext2 direct-io path to use modern
> > >> iomap interface.
> > >
> > > The patches now all look good to me. I'd like to discuss a bit how to merge
> > 
> > Thanks Jan,
> > 
> > 
> > > them. The series has an ext4 cleanup (patch 3) and three iomap patches
> > 
> > Also Patch-3 is on top of ext4 journalled data patch series of yours,
> > otheriwse we might see a minor merge conflict.
> > 
> > https://lore.kernel.org/all/20230329154950.19720-6-jack@suse.cz/
> > 
> > > (patches 6, 8 and 9). Darrick, do you want to take the iomap patches through
> > > your tree?
> 
> Hmm.  I could do that for 6.4 since the first one should be trivially
> verifiable and so far Linus hasn't objected to patches that add
> tracepoints being thrown into for-next right at the start of the merge
> window.

Great! Then I'll wait a bit until rc1 when your iomap tree + Ted's ext4
tree should have landed in Linus' tree and push the ext2+ext4 patches into
my tree to a branch based on rc1 which should deal with all the merge
troubles.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
