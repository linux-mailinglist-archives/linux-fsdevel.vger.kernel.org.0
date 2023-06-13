Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5336172DB91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 09:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbjFMHwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 03:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbjFMHwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:52:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18221998;
        Tue, 13 Jun 2023 00:52:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 587371FD76;
        Tue, 13 Jun 2023 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686642751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vgzBi4yqsxagL3lZDlQaSBkQGg56JLnxxRjipfnjVvo=;
        b=W5X3D8WUwgo8HYkpbwovYxrWyYJfGaWRgmIuepBwnMCZxfaw8Ka8BOeKMASdJr0ggUFnba
        ZpWuaym1fj53rV5qWAbMQcEu9aNUckQqbdNOWmS4QFE7CQQCXG1BKRZS0MpyUWqwH1/5YV
        te1zynav2yYwnNymHS36Ni+hDiepODk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686642751;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vgzBi4yqsxagL3lZDlQaSBkQGg56JLnxxRjipfnjVvo=;
        b=ST51FDlD8ayzaN42HigkwpKJzinOQkTG7o5QLU30Vd69RlxKnMRDjoI2nJADoXMpMuV22c
        eriJm4BoETJy4cDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A40113345;
        Tue, 13 Jun 2023 07:52:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UBogEj8giGT5IAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 13 Jun 2023 07:52:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C87B9A0717; Tue, 13 Jun 2023 09:52:30 +0200 (CEST)
Date:   Tue, 13 Jun 2023 09:52:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        hch@infradead.org, ruansy.fnst@fujitsu.com
Subject: Re: [PATCH 2/3] fs: wait for partially frozen filesystems
Message-ID: <20230613075230.4a7yshozvheuk6io@quack3>
References: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
 <168653972832.755178.18389114450766371923.stgit@frogsfrogsfrogs>
 <20230612113526.xfhpaohiqusq5ixt@quack3>
 <20230612183657.GI11441@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612183657.GI11441@frogsfrogsfrogs>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 12-06-23 11:36:57, Darrick J. Wong wrote:
> On Mon, Jun 12, 2023 at 01:35:26PM +0200, Jan Kara wrote:
> > What we could be doing to limit unnecessary waiting is that we'd update
> > freeze_holders already when we enter freeze_super() and lock s_umount
> > (bailing if our holder type is already set). That way we'd have at most one
> > process for each holder type freezing the fs / waiting for freezing to
> > complete.
> 
> <shrug> I don't know how often we even really have threads contending
> for s_umount and elevated freeze state.  How about we go with the
> simpler wait_for_partially_frozen and see if complaints crop up?

Yeah, I'm for the simpler approach as well. This was more a suggestion if
you think that is not viable.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
