Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2320A752311
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbjGMNKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbjGMNKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:10:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF9E1BEB
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 06:10:22 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-193.bstnma.fios.verizon.net [173.48.82.193])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36DD4Yae032398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 09:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689253477; bh=PGVfdLiaNeKOXqYS5SmpsfHRuIUBYAsAVs4H4eKxHjo=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=qVBOD2Pg/gEM3y272JLVo2EM58aIUkX0eb1bATEh11Pw97tdxd0l7Zwg1GEvRx9cs
         8QXJdio8RkTj5bWqzs3rkheYIpJJt9n7TQeftRNQjCar8iWTjw3M4LWe4PQpd0kUSy
         s7yC00OUKAZSpac6oclkyNu+EPOMN4+LVHrbHFhq7OebbOt4JBmfLnvURe1fqf0Qei
         +W8fmCfk9rYw7TG+fh25lr5um+mmk+pUDjMHMx5fql/3lctkx59LvbFaw6DIWINihZ
         FVbUoO3zPqwf9nHgHR5QXNLGQeLoalcKy7l0mv5W3rF5+pZKlJ4OWVZUh0eXVyiwmd
         AW61Za+UGV3qQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9F7B315C0280; Thu, 13 Jul 2023 09:04:34 -0400 (EDT)
Date:   Thu, 13 Jul 2023 09:04:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     brauner@kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix decoding of raw_inode timestamps
Message-ID: <20230713130434.GA3724752@mit.edu>
References: <20230712150251.163790-1-jlayton@kernel.org>
 <20230712175258.GB3677745@mit.edu>
 <4c29c4e8f88509b2f8e8c08197dba8cfeb07c045.camel@kernel.org>
 <20230712212557.GE3432379@mit.edu>
 <11bef51bf7fed6082f41a9ecde341b46c0c3e0ec.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11bef51bf7fed6082f41a9ecde341b46c0c3e0ec.camel@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 06:48:04AM -0400, Jeff Layton wrote:
> 
> The above output is what I get with the fix in place. Without this
> patch, I get: ...

Thanks!!  It's good to know the _one_ kunit test we have is capable of
detecting this.  We have a patch series lined up to add our *second*
unit test (for the block allocator) for the next merge window, and
while our unit test coverage is still quite small, it's nice to know
that it can detect problems --- and much faster than running xfstests.  :-}

     	    	   	    	    	 	- Ted
