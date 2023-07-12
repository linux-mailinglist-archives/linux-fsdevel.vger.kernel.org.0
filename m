Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA34751007
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 19:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjGLRx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjGLRxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:53:18 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146E912F
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 10:53:16 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-193.bstnma.fios.verizon.net [173.48.82.193])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36CHqwKl004990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 13:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689184380; bh=iYK3lUF2GbPPt1xA1PwWleN6r/7tba+hiPLcX61WWlU=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=VUztdmxBOWM7Tx/fAekc5Iqt2n4UQL1FhP9NCmyLYSAlDHD+8iuhuoA6NOJ6H1Gh9
         C/gQ64YeLxytLkLOzZdCJlYTrX6OfxGA9ghmECZAVWiLCvhgzJsfXPANMfJmRnWIhT
         AEAnZuRI8AOcSvP6W3qsiBnoedbQkMVwSTB6k6Kkh4ho7sQEFujK3eug3t8Zg+A5d/
         XooRfZ91K8cNpJdH6oW3zKrddfNdGlHeoTJnYMHCHHAzFI1ECHgdubsuL2oKua8LW9
         WU6V4RUsDRn26NqK3S/vOB/G3NonVNFMi/xpQrWOBTsh5gfcIDBHVcZYEhcWBVoEb9
         HBF4O6Z4i53FQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 332E615C0280; Wed, 12 Jul 2023 13:52:58 -0400 (EDT)
Date:   Wed, 12 Jul 2023 13:52:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     brauner@kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix decoding of raw_inode timestamps
Message-ID: <20230712175258.GB3677745@mit.edu>
References: <20230712150251.163790-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712150251.163790-1-jlayton@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:02:49AM -0400, Jeff Layton wrote:
> When we covert a timestamp from raw disk format, we need to consider it
> to be signed, as the value may represent a date earlier than 1970. This
> fixes generic/258 on ext4.
> 
> Cc: Jan Kara <jack@suse.cz>
> Fixes: f2ddb05870fb ("ext4: convert to ctime accessor functions")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>

Thanks for the fix!

It had been on my list to checking to see if the ext4 kunit tests
would pass, since Jan had mentioned that he had done the work to make
sure the ext4 kunit test would compile, but he hadn't gotten around to
try run the kunit test.  Unfortunately, I hadn't gotten to it.

I *think* the ext4 kunit tests should have caught this as well; out of
curiosity, have you tried running the ext4 kunit tests either before
or after this patch?  If so, what were your findings?

Cheers,

					- Ted
