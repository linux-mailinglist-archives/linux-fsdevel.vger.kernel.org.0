Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B412276D4D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 19:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjHBRNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 13:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHBRNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:13:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACDD11D
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 10:13:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 649EF21A31;
        Wed,  2 Aug 2023 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690996383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8a6nSQ6BGJjmwI1qe/ove6DusMgVnapcDCqX2gdNmSs=;
        b=Gr3yxU2gQKPzLKxN8LIhOoydaPy82iHF+Cv8YB2SbjlKOSv6TPSzZLa4pO8SLY4fWtfDzh
        n+6WBm5nU9k+FKcjCgpchyUD7ezNcuKgL2kLMThfqCTnBnGyIUms45vGVR0CLyS+4XB/js
        /WqsfEuSy8hAzBfZskWqu9JqYAcoYaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690996383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8a6nSQ6BGJjmwI1qe/ove6DusMgVnapcDCqX2gdNmSs=;
        b=Id49LMf+EblobUitpCqVoDh7gc2HrD0SXZwyKZO0CHRWi++kPp3bLoqd57vM20m4+7JOD+
        Yih3hbaiYMKNs/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5690B13919;
        Wed,  2 Aug 2023 17:13:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yxceFZ+OymS4XwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 02 Aug 2023 17:13:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E923CA076B; Wed,  2 Aug 2023 19:13:02 +0200 (CEST)
Date:   Wed, 2 Aug 2023 19:13:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] fs: add vfs_cmd_create()
Message-ID: <20230802171302.5kceref6gp7wn3os@quack3>
References: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org>
 <20230801-vfs-super-exclusive-v1-2-1a587e56c9f3@kernel.org>
 <20230802170155.l7sru3projdgsna5@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802170155.l7sru3projdgsna5@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-08-23 19:01:55, Jan Kara wrote:
> On Tue 01-08-23 15:09:01, Christian Brauner wrote:
> > Split the steps to create a superblock into a tiny helper. This will
> > make the next patch easier to follow.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> I agree with Christoph that the error handling in vfs_fsconfig_locked() is
> confusing - in particular the fact that if you 'break' out of the switch
> statement it causes the fs context to be marked as failed is probably handy
> but too subtle to my taste.
> 
> Also I think this patch does cause a behavioral change because before if we
> bailed e.g. due to:
> 
> if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
> 
> we returned -EBUSY but didn't set fc->phase = FS_CONTEXT_FAILED. After your
> patch we 'break' on any error and thus fc->phase is set on any error...

Ah, I can see you've already posted v2 where you addressed this problem.
Sorry for the noise.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
