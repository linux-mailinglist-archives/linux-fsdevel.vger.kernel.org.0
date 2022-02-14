Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD124B586B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 18:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357041AbiBNRZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 12:25:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiBNRZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:25:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C50F652EF;
        Mon, 14 Feb 2022 09:24:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC7CC61579;
        Mon, 14 Feb 2022 17:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F74C340E9;
        Mon, 14 Feb 2022 17:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644859494;
        bh=HyrfjL/JgTkobN/PUzQN8ptbeUr4KXCKVVnPjgDNADs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=m+ZifvygaF/sp6mCJhlNpo6pic6lFkNVQzMk1DoFgFzznpim23Pvy0Qakp6g37i8P
         TGS8gfZSJnqErEMbyXbumnyrZU0DrYN4FmDO5LJlYw1/cpZ5rFuCyzkDogDfbwX1Yu
         aBrOR95CPUugVhB7QimBgw+t1T7RH3F606VOrou0yyLrg9z6VhCoUkLL9fRPxhggeW
         nqCauzCmHXn+Oc3z/KH4mtfak5ukONW0EEAwY2b1lDSj7RmLiUT6msM3EFPGLBEFh7
         bP9K/+laOtpXHG7IyCRVW6Y1SRtz1rn8F9cq4JAXS5rYHvyiJP+tI+4XodLmKYiNT9
         ZZ7SsrPr/Umpw==
Message-ID: <496629d25936838bf6e64dcae0e1210c8ed1fcb1.camel@kernel.org>
Subject: Re: [PATCH RFC v13 1/4] fs/lock: documentation cleanup. Replace
 inode->i_lock with flc_lock.
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 14 Feb 2022 12:24:52 -0500
In-Reply-To: <8EF5C08B-E6C9-4B3D-B26C-1088B0130BEF@oracle.com>
References: <1644689575-1235-1-git-send-email-dai.ngo@oracle.com>
         <1644689575-1235-2-git-send-email-dai.ngo@oracle.com>
         <8EF5C08B-E6C9-4B3D-B26C-1088B0130BEF@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-02-14 at 17:03 +0000, Chuck Lever III wrote:
> 
> > On Feb 12, 2022, at 1:12 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > 
> > Update lock usage of lock_manager_operations' functions.
> > 
> > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> 
> I can apply this one to the nfsd tree if Jeff acks it.
> 
> Also I think I want to amend the commit description to mention
> 6109c85037e5 ("locks: add a dedicated spinlock to protect i_flctx lists"),
> which is the commit that did the locking conversion, if that's
> OK with everyone.
> 
> 

Works for me.

> > ---
> > Documentation/filesystems/locking.rst | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> > index 3f9b1497ebb8..aaca0b601819 100644
> > --- a/Documentation/filesystems/locking.rst
> > +++ b/Documentation/filesystems/locking.rst
> > @@ -438,13 +438,13 @@ prototypes::
> > locking rules:
> > 
> > ======================	=============	=================	=========
> > -ops			inode->i_lock	blocked_lock_lock	may block
> > +ops			   flc_lock  	blocked_lock_lock	may block
> > ======================	=============	=================	=========
> > -lm_notify:		yes		yes			no
> > +lm_notify:		no      	yes			no
> > lm_grant:		no		no			no
> > lm_break:		yes		no			no
> > lm_change		yes		no			no
> > -lm_breaker_owns_lease:	no		no			no
> > +lm_breaker_owns_lease:	yes     	no			no
> > ======================	=============	=================	=========
> > 
> > buffer_head
> > -- 
> > 2.9.5
> > 
> 
> --
> Chuck Lever
> 
> 
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>
