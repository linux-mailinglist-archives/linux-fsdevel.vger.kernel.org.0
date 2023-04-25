Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8E96EE72C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 19:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjDYR47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 13:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjDYR45 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:56:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B19815475;
        Tue, 25 Apr 2023 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IKbCnwH1TA9yC1TlMAtUgmaVJ8UiFakjRZigpfu/WWw=; b=sXQiIYjLiJSgyDqdSq/d1YZKWD
        L3l6BnDrkdUFl2ESqbJSTxoL5yVRNLcVQZjMiBHtAl7Ttr/bHLoTQBYuWa2vdjnLeKLoREp/y+wrs
        TnhOd56KWkGSiTrT6B5tM3gQ4KSL3AvaTDRIA6YIOMnIv3Eh2mhF5rnV0wmqrojojcW6i/UKni/6E
        ubwEDSgB6gZLTq9zh2qr+1joEQoKXYFXZX2KFzg2hz+/75vIC/hOwbpFhXIrsaUHCp+mSJAa59OJb
        TrM+qirgTXCQM75S2eYwao9jeUo/rCSOlXPFlPrDwM8tpsmh6xrGtBwmddm1b00/GB7mbzAmmxwS2
        wgbKU+Pw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prMtv-001fb2-Nb; Tue, 25 Apr 2023 17:56:27 +0000
Date:   Tue, 25 Apr 2023 18:56:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs: add infrastructure for multigrain inode
 i_m/ctime
Message-ID: <ZEgUSw15g4Wbo91Z@casper.infradead.org>
References: <20230424151104.175456-1-jlayton@kernel.org>
 <20230424151104.175456-2-jlayton@kernel.org>
 <168237287734.24821.11016713590413362200@noble.neil.brown.name>
 <404a9a8066b0735c9f355214d4eadf0d975b3188.camel@kernel.org>
 <168237601955.24821.11999779095797667429@noble.neil.brown.name>
 <aa60b0fa23c1d582cfad0da5b771d427d00c4316.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa60b0fa23c1d582cfad0da5b771d427d00c4316.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 01:45:19PM -0400, Jeff Layton wrote:
> Erm...it may be an unpopular opinion, but I find that more confusing
> than just ensuring that the s_time_gran > 1. I keep wondering if we
> might want to carve out other low-order bits too for some later purpose,
> at which point trying to check this using flags wouldn't work right. I
> think I might just stick with what I have here, at least for now.

But what if I set s_time_gran to 3 or 5?  You'd really want a warning
about that.
