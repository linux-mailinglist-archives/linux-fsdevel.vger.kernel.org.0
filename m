Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1E45204C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 20:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbiEISzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 14:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbiEISzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 14:55:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D8B286C9;
        Mon,  9 May 2022 11:51:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9065C21C6C;
        Mon,  9 May 2022 18:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652122264;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c3py2NGhSbKCur3EcRzQ7CQDlhCBGKamOhHgEIdujgQ=;
        b=pO/BAromEsaPNf7vRHuACqEldnLsnLN99wrfQ1Wgv587K0WSkppQVHrPwT7tBKjvH0G/vn
        y1lf/MwGYSBmMLaStKW5Vsod2km/7Sc/Y5lcOPPOcubNt7bRfyWEZm7YviubWefI7sHUDf
        odQz0lPMl30SXY7obV1zHFSi7UQEHJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652122264;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c3py2NGhSbKCur3EcRzQ7CQDlhCBGKamOhHgEIdujgQ=;
        b=ynxC4q9BW3xp7FDB1UL7BHKUe8dYe5Vpal7l6WwAt57ziJ067LpKeyPBSNBax6sLMiyxXw
        A1VoyR7dHY4W1OAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49BA113AA5;
        Mon,  9 May 2022 18:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DPINEZhieWJabwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 May 2022 18:51:04 +0000
Date:   Mon, 9 May 2022 20:46:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, dsterba@suse.cz,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: reduce memory allocation in the btrfs direct I/O path
Message-ID: <20220509184650.GA18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220504162342.573651-1-hch@lst.de>
 <20220505155529.GY18596@suse.cz>
 <20220506171803.GA27137@magnolia>
 <20220507052649.GA28014@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507052649.GA28014@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 07, 2022 at 07:26:49AM +0200, Christoph Hellwig wrote:
> On Fri, May 06, 2022 at 10:18:03AM -0700, Darrick J. Wong wrote:
> > > The series is reasonably short so I'd like to add it to 5.20 queue,
                                                              ^^^^
Sorry, I meant 5.19, ie. the one that's about to start soon.

> > > provided that the iomap patches get acked by Darrick. Any fixups I'd
> > > rather fold into my local branch, no need to resend unless there are
> > > significant updates.
> > 
> > Hm.  I'm planning on pushing out a (very late) iomap-5.19-merge branch,
> > since (AFAICT) these changes are mostly plumbing.  Do you want me to
> > push the first three patches of this series for 5.19?
> 
> Given that we have no conflicts it might be easiest to just merge the
> whole series through the btrfs tree.

Yeah, I'd rather take it via the btrfs tree.
