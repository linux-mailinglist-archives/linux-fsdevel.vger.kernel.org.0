Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6026C7A003C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbjINJg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 05:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbjINJgw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:36:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75D51BEF;
        Thu, 14 Sep 2023 02:36:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE55C433C8;
        Thu, 14 Sep 2023 09:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694684206;
        bh=H2srYEKdzkCILZo1VmZDz5SnBJ+dNxreB69yshcWmz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BasUXXnDxP2Rf1ySoLlqGBiOwNwHrCwX08D9JXdLGTuYH3KyF4dy6Wk6VpqBNA3MZ
         3tKSUWXRKYOMAVga/s4v06Fj1tkON+XAOoUCL96KWim7Kp9F+vtuZMblcZycUuNFlK
         Z8Znf7Eh6J+7mnU3yyU/e6x2YtwQbQ59nV0yhA2sZwAginnQZTx+MTXkyS2/8jTSyA
         7uourZWptEgtc21TYZam4B6atbCW6zTHySGqU5dLdlwOZ6vh30FtgGhmE2APU6LO1J
         OMQ8FisgUilhC7bbHIrgf7pYb/LQdBxMbYKeynHLaoSAuXeIlQUhyKiLzCqH3xqn5a
         FZ8E5Jta5HyUg==
Date:   Thu, 14 Sep 2023 11:36:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 1/3] add unique mount ID
Message-ID: <20230914-jeweiligen-normung-47816c153531@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-2-mszeredi@redhat.com>
 <20230914-himmel-imposant-546bd73250a8@brauner>
 <CAJfpegv8ZVyyZN7ppSYMD4g8i7rAP1_5UBxzSo869_SKmFhgvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegv8ZVyyZN7ppSYMD4g8i7rAP1_5UBxzSo869_SKmFhgvw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Yes, one concern is that humans confuse the old and the new ID.
> 
> I also think it makes sense to allow the new interfaces to look up the
> mount based on either the old or the new ID.   But I could be wrong

Hm, mount id recycling may happen so quickly that for service restarts
with a lot of mounts this becomes mostly useless...

> there, since that might encourage bad code.  Maybe the new interface
> should only use take the new ID, which means no mixed use of
> /proc/$$/mountinfo and statmnt/listmnt.

... so I think that is indeed the better way of doing things. There's no
need to encourage userspace to mix both identifiers.
