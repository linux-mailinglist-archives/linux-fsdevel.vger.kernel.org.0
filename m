Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73B074B0C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 14:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjGGM2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 08:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjGGM2h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:28:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8CD2115;
        Fri,  7 Jul 2023 05:28:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 244C31FD93;
        Fri,  7 Jul 2023 12:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688732912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y90ezv/KA4m8VkAiDQ9+ttfqvfo0qSDNIBSr1bJ8sLw=;
        b=pJ72ZOhoMy0fQW48wqjWdunA24pCLKKJmAHUswX4m2T0bN3ukHMoyremObjN825AvvQnT4
        OEKRN4wkaBAJfOxvrTcdFz3SqGVaLkeNOV0RTSMz0KitlAjk+pEoyC1sMU5GUaa8ppiSjT
        Dm7LM62V8GuF7BtlP6KeBfh/Xc2hxq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688732912;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y90ezv/KA4m8VkAiDQ9+ttfqvfo0qSDNIBSr1bJ8sLw=;
        b=dX0edD3MIrX246VfKQUkFjfqTSY5DJ97WMYeMYby9kJcFU0FWP8B5G0R+aRgHtXeIGAYkH
        nXRhnpKDyNQEaLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15570139E0;
        Fri,  7 Jul 2023 12:28:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DesuBfAEqGSCOQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 07 Jul 2023 12:28:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9F6FCA0717; Fri,  7 Jul 2023 14:28:31 +0200 (CEST)
Date:   Fri, 7 Jul 2023 14:28:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 6/6] fs: Make bind mounts work with
 bdev_allow_write_mounted=n
Message-ID: <20230707122831.7wg3nlcra6wqz36f@quack3>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-6-jack@suse.cz>
 <ZKbj5v4VKroW7cFp@infradead.org>
 <20230706161255.t33v2yb3qrg4swcm@quack3>
 <20230707-mitangeklagt-erdumlaufbahn-688d4f493451@brauner>
 <ZKf3ezb4/XMwg+3a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKf3ezb4/XMwg+3a@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 07-07-23 04:31:07, Christoph Hellwig wrote:
> On Fri, Jul 07, 2023 at 09:39:05AM +0200, Christian Brauner wrote:
> > Can you do this rework independent of the bdev_handle work that you're
> > doing so this series doesn't depend on the other work and we can get
> > the VFS bits merged for this?
> 
> It really should be before it.  I have a few other things related to
> it, so if Jan doesn't mind I'd be happy to take it over and post a
> series with a version of this and some sget and get_super rework.

OK, sure go ahead. I'll be on vacation with my family in the coming weeks
anyway so I won't have time to seriously dwelve into this. So I'll just see
what's the situation once I return.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
