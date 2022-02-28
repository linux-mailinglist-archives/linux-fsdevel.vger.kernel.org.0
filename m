Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3894C626D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 06:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiB1FUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 00:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiB1FUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 00:20:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8613939154;
        Sun, 27 Feb 2022 21:19:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6BD921155;
        Mon, 28 Feb 2022 05:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646025575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OsOdRKyOPTsqFVySVeje99MCazN8FHXIRZGctTB3Fjc=;
        b=1aDnYNyCMKoqi7852ELng+RjN9qj4H3oZKIs6lZKTxoiwJvkWraBZGmj+Lgr7uB+1SHFJz
        Yh2mZu17ZFxMhdj6twoLK7xeDGS6uw7JuUWs/fN+ewmZBdcdER+polBa/xGaRr74gldhFA
        Ag1t4rw/IZDJ70lWUTD3DCkE1pDKQVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646025575;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OsOdRKyOPTsqFVySVeje99MCazN8FHXIRZGctTB3Fjc=;
        b=ETy1bbk4AvRTgoyR516RJsfNTn47d24xVl6EFjxT7PerkTAmm+E/x1KFcnx2xiTY9paC/z
        4vNKWy2UyfSPGfDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E5C712FC5;
        Mon, 28 Feb 2022 05:19:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5BzICmBbHGIXfAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 28 Feb 2022 05:19:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Jan Kara" <jack@suse.cz>, "Wu Fengguang" <fengguang.wu@intel.com>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Philipp Reisner" <philipp.reisner@linbit.com>,
        "Lars Ellenberg" <lars.ellenberg@linbit.com>,
        "Paolo Valente" <paolo.valente@linaro.org>,
        "Jens Axboe" <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 02/11] MM: document and polish read-ahead code.
In-reply-to: <20220227204728.b2eb5dd94ecc3e86912bacad@linux-foundation.org>
References: <164447124918.23354.17858831070003318849.stgit@noble.brown>,
 <164447147257.23354.2801426518649016278.stgit@noble.brown>,
 <20220210122440.vqth5mwsqtv6vjpq@quack3.lan>,
 <164453611721.27779.1299851963795418722@noble.neil.brown.name>,
 <20220224182622.n7abfey3asszyq3x@quack3.lan>,
 <164602251992.20161.9146570952337454229@noble.neil.brown.name>,
 <20220227204728.b2eb5dd94ecc3e86912bacad@linux-foundation.org>
Date:   Mon, 28 Feb 2022 16:19:24 +1100
Message-id: <164602556430.20161.5451268677064506613@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 28 Feb 2022, Andrew Morton wrote:
> On Mon, 28 Feb 2022 15:28:39 +1100 "NeilBrown" <neilb@suse.de> wrote:
> 
> > When writing documentation the intent of the author is of some interest,
> > but the behaviour of the code is paramount.
> 
> uh, er, ah, no.  The code describes the behaviour of the code.  The
> comments are there to describe things other than the code's behaviour.
> Things such as the author's intent.
> 
> Any deviation between the author's intent and the code's behaviour is
> called a "bug", so it's pretty important to understand authorial
> intent, no?

When the author is writing the documentation - then yes - definitely. 
When the "author" is several different people over a period of years,
then it is not even certain that there is a single unified "intent".

The author's intent is less interesting not so much because it is less
relevant, but because it is less available.

So when writing third-party post-hoc documentation, the focus has to be
on the code, though with reference to the intent to whatever extent it
is available.  Bugs then show up where the actual behaviour turns out to
be impossible to document coherently.

Thanks,
NeilBrown
