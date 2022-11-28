Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3EC63A59B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 11:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiK1KDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 05:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiK1KDN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:03:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D2AF4D
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 02:03:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 49F6B1F891;
        Mon, 28 Nov 2022 10:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669629789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVQk/BC8lCkJeRKmi++rC4IIiaIxAziHE6qUrtUSs2g=;
        b=1H/1fQ9ZpRp2mOUC+LeZ3VzyZk1KSUC/1BI4v9DxgihhyquCwkiIY0OkgKTh7L72bzLnSL
        pXM+EbZW2dTSLU/b+mVFHvD/CdFP7wKcd0N0WyHa/6e3Lxxm3wpbf5xbqeLlr6zHZ1RFjT
        ORyZvgsRa0VOpybbrmaHFX4zJLBPJTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669629789;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVQk/BC8lCkJeRKmi++rC4IIiaIxAziHE6qUrtUSs2g=;
        b=DVaWYu1A2oNwc2j5ZO8/BXwt4hp/dqtL/YN/TqkFhedZE4GA70GNm5EoovKBLAiRhNmnbi
        Ts+1XOzp5LDse4AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 361BC1326E;
        Mon, 28 Nov 2022 10:03:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VEY0DV2HhGMfEgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 28 Nov 2022 10:03:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 91205A070F; Mon, 28 Nov 2022 11:03:08 +0100 (CET)
Date:   Mon, 28 Nov 2022 11:03:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Jan Kara <jack@suse.com>, Eric Sandeen <sandeen@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: Re: [PATCH v2 1/3] quota: add quota in-memory format support
Message-ID: <20221128100308.rjqipq6kjjnlklim@quack3>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-2-lczerner@redhat.com>
 <20221123170739.sugph5ixr7m3ejk6@quack3>
 <20221125093010.usb5ampqpthe5wae@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125093010.usb5ampqpthe5wae@fedora>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 25-11-22 10:30:10, Lukas Czerner wrote:
> On Wed, Nov 23, 2022 at 06:07:39PM +0100, Jan Kara wrote:
> > On Mon 21-11-22 15:28:52, Lukas Czerner wrote:
> > Instead of this I'd define:
> > 
> > struct shmem_dquot {
> >         struct rb_node node;
> >         qid_t id;
> > 	qsize_t bhardlimit;
> > 	qsize_t bsoftlimit;
> > 	qsize_t ihardlimit;
> > 	qsize_t isoftlimit;
> > };
> > 
> > It would be kept in rbtree like you do with quota_id but it will be also
> > used as ultimate "persistent" storage of quota information when dquot gets
> > reclaimed. We don't need to store grace times or usage information because
> > if there is non-zero usage, dquot is referenced from the inode and thus
> > cannot be reclaimed.
> 
> Ok, this approach will duplicate the limits, but has advantage of having
> much smaller footprint than entire dquot so in case we don't have any
> usage in dquot we can safely reclaim it if needed without loosing user
> provided limits. Probably a worthwhile trade-off.
> 
> Or perhaps we can eliminate the duplicity when we store it in the tree on
> ->destroy_dquot() and free it after we load the limits into dquot on
> ->acquire_dquo().

We could but I don't think it's worth the hassle. In particular because
->release_dquot() must not fail (there's no simple way to recover from such
failure). I don't say it is impossible to overcome but just not worth the
saved memory IMHO.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
