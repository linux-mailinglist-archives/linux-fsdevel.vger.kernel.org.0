Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618157B83A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 17:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjJDPci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjJDPch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:32:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0CDDC;
        Wed,  4 Oct 2023 08:32:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 331071F88D;
        Wed,  4 Oct 2023 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696433552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E7rPN2B6EKTGm9PeH9o/j7eO/9ZZxPutpFnqoFCKJ3c=;
        b=PWNpNgIS0ejpZaWNfc0RvB2fG2vV8czGrqfLFnVTWcWRavWyJ4QgAKcXC6NTyqjpPPXLIR
        ctspLD8VBoyOKiAiK+atQY00RcObsQ/ufJFWQxDaExXcReriBuPYwsegsPUtk0sKuldjvw
        NaontetfPZBnTsqhYoaH2uSIFUYt+XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696433552;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E7rPN2B6EKTGm9PeH9o/j7eO/9ZZxPutpFnqoFCKJ3c=;
        b=/a/QgrmLqwF9uzFD93sACvd/cUymLm7NK62R1MpzNFNbQH5uu3qguAu7sOD1484Ey2FveJ
        RH6ttpyXbHMa7yDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2219813A2E;
        Wed,  4 Oct 2023 15:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jbpJCJCFHWUhIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 04 Oct 2023 15:32:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AA6E8A07CC; Wed,  4 Oct 2023 17:32:31 +0200 (CEST)
Date:   Wed, 4 Oct 2023 17:32:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 8/8] shmem,percpu_counter: add _limited_add(fbc, limit,
 amount)
Message-ID: <20231004153231.gj5ds6r2tdjwjdwd@quack3>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-09-23 20:42:45, Hugh Dickins wrote:
> Percpu counter's compare and add are separate functions: without locking
> around them (which would defeat their purpose), it has been possible to
> overflow the intended limit.  Imagine all the other CPUs fallocating
> tmpfs huge pages to the limit, in between this CPU's compare and its add.
> 
> I have not seen reports of that happening; but tmpfs's recent addition
> of dquot_alloc_block_nodirty() in between the compare and the add makes
> it even more likely, and I'd be uncomfortable to leave it unfixed.
> 
> Introduce percpu_counter_limited_add(fbc, limit, amount) to prevent it.
> 
> I believe this implementation is correct, and slightly more efficient
> than the combination of compare and add (taking the lock once rather
> than twice when nearing full - the last 128MiB of a tmpfs volume on a
> machine with 128 CPUs and 4KiB pages); but it does beg for a better
> design - when nearing full, there is no new batching, but the costly
> percpu counter sum across CPUs still has to be done, while locked.
> 
> Follow __percpu_counter_sum()'s example, including cpu_dying_mask as
> well as cpu_online_mask: but shouldn't __percpu_counter_compare() and
> __percpu_counter_limited_add() then be adding a num_dying_cpus() to
> num_online_cpus(), when they calculate the maximum which could be held
> across CPUs?  But the times when it matters would be vanishingly rare.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: Tim Chen <tim.c.chen@intel.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: Darrick J. Wong <djwong@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
