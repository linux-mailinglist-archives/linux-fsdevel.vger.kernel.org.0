Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D300672C2E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 13:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjFLLgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 07:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbjFLLf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:35:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A5176A0;
        Mon, 12 Jun 2023 04:14:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D6C52019C;
        Mon, 12 Jun 2023 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686568448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=koWa5+PJko8UwOx7SDmZ0Jx0qCD9DwPgEth4yVBTJoA=;
        b=Bij6brySnnLgjSaCrx6aAmRWqkHkImUtbBlrskeZabmKdIlnNB5NNeKdWrjdVHeihnA59r
        qMSwWIfby0KbiFovmXT/rWQBkuZJheJoKYG0J+cSdjuO7GCrwwVmria8Ldv9iN8sDQJG6H
        c1wagb/zjOKUrDoyggx2zIKUj2tOMAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686568448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=koWa5+PJko8UwOx7SDmZ0Jx0qCD9DwPgEth4yVBTJoA=;
        b=BhGKZrheNkNNqQFCGmhJKISHVythvawgaphOyklCUZSlwjA4nUjAAIwlKb1HxxV/Y3ksmk
        eckLOwzNlH5wgfDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2099C138EC;
        Mon, 12 Jun 2023 11:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aUHvBwD+hmTLQAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Jun 2023 11:14:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C09EDA0717; Mon, 12 Jun 2023 13:14:07 +0200 (CEST)
Date:   Mon, 12 Jun 2023 13:14:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     mcgrof@kernel.org, jack@suse.cz, hch@infradead.org,
        ruansy.fnst@fujitsu.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230612111407.c56gqw3zugjyalo3@quack3>
References: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
 <168653972267.755178.18328538743442432037.stgit@frogsfrogsfrogs>
 <20230612110811.m7hv42sfqyfr6rwh@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612110811.m7hv42sfqyfr6rwh@quack3>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 12-06-23 13:08:11, Jan Kara wrote:
> On Sun 11-06-23 20:15:22, Darrick J. Wong wrote:
> > +
> >  	if (sb->s_writers.frozen != SB_UNFROZEN) {
> 
> I still find it strange that:
> 
> Task1					Task2
> 
> while (1) {				while (1) {
>   ioctl(f, FIFREEZE);			  freeze_super(sb, FREEZE_HOLDER_KERNEL);
>   ioctl(f, FITHAW);			  thaw_super(sb, FREEZE_HOLDER_KERNEL);
> }					}
> 
> will randomly end up returning EBUSY to Task1 or Task2 although there is no
> real conflict. I think it will be much more useful behavior if in case of
> this conflict the second holder just waited for freezing procedure to finish
> and then report success. Because I don't think either caller can do
> anything sensible with this race other than retry but it cannot really
> distinguish EBUSY as in "someone other holder of the same type has the sb
> already frozen" from "freezing raced with holder of a different type".

I take this back, you solve the problem in patch 2 :). I'm sorry for the
noise.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
