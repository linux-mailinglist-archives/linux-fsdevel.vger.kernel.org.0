Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44854C623E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 05:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiB1EsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 23:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiB1EsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 23:48:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1364E193E1;
        Sun, 27 Feb 2022 20:47:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78CB760F76;
        Mon, 28 Feb 2022 04:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FC0C340E7;
        Mon, 28 Feb 2022 04:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646023649;
        bh=G8sG7lhMtemU8UaIfAlQyFfdM52xrPiAjoIoRCmr5pk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oGPNq6p6XPM77SHgO9aQqRI1rnuXHCc+59DXZQ1WNrGmN3OQd6S99TorBGhKumdok
         /al88n7DG2J8BkHYEPTcnC3PkoeWXPmOgtseuFvQx3PRiJwblKmCI9fhBlhdsjcaOW
         hLr6Rg6R30jUXs/Md/sM9bDGeMUMnt9uzXly3vn0=
Date:   Sun, 27 Feb 2022 20:47:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "NeilBrown" <neilb@suse.de>
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
Message-Id: <20220227204728.b2eb5dd94ecc3e86912bacad@linux-foundation.org>
In-Reply-To: <164602251992.20161.9146570952337454229@noble.neil.brown.name>
References: <164447124918.23354.17858831070003318849.stgit@noble.brown>
        <164447147257.23354.2801426518649016278.stgit@noble.brown>
        <20220210122440.vqth5mwsqtv6vjpq@quack3.lan>
        <164453611721.27779.1299851963795418722@noble.neil.brown.name>
        <20220224182622.n7abfey3asszyq3x@quack3.lan>
        <164602251992.20161.9146570952337454229@noble.neil.brown.name>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 28 Feb 2022 15:28:39 +1100 "NeilBrown" <neilb@suse.de> wrote:

> When writing documentation the intent of the author is of some interest,
> but the behaviour of the code is paramount.

uh, er, ah, no.  The code describes the behaviour of the code.  The
comments are there to describe things other than the code's behaviour.
Things such as the author's intent.

Any deviation between the author's intent and the code's behaviour is
called a "bug", so it's pretty important to understand authorial
intent, no?

