Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088A87109F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 12:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbjEYKUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 06:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbjEYKUb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 06:20:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C96171F;
        Thu, 25 May 2023 03:19:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 58CDE21AD3;
        Thu, 25 May 2023 10:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685009954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yn1VwwZZnMGd9wfXMM6sJL9dM2TITZqpRfOp8vPfG6w=;
        b=fVWxm+bL+i5pEgt3Z8XilKr3Gvbbv1jtRwLLQevfT8EnV5hXSShtRaBdDIl0Fr801DJUEM
        AjyCC+wJamU1mTnsOYfzNT+m1UXYjNELEAugmO22VkeMpYez9wnFVIAVHXkn0ARKQsrTLy
        SNexZfs3L4MbBL5VLDXuiLvZxu5RVdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685009954;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yn1VwwZZnMGd9wfXMM6sJL9dM2TITZqpRfOp8vPfG6w=;
        b=E0aCHHgC7A/mVwNdcx8OaBWYtQ/u+k4VT18BeHms/gEfX/RH94JMKMXUQRcXFLhyFAspKV
        Z+Tq6oHIDRN/BrCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C6E5134B2;
        Thu, 25 May 2023 10:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jjOQEiI2b2TFdwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 10:19:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DE789A075C; Thu, 25 May 2023 12:19:13 +0200 (CEST)
Date:   Thu, 25 May 2023 12:19:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] exportfs: check for error return value from
 exportfs_encode_*()
Message-ID: <20230525101913.vokjxsthhoxsz6xk@quack3>
References: <20230524154825.881414-1-amir73il@gmail.com>
 <61146b7311e44d89034bd09dee901254a4a6a60b.camel@kernel.org>
 <CAOQ4uxjY_KqETNDDXYBGgXvE_7JTWStSaYK2CEjfj_UUzmLbzQ@mail.gmail.com>
 <0a140464f921baf88a0295e91a43bbd92faa2f2c.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a140464f921baf88a0295e91a43bbd92faa2f2c.camel@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 24-05-23 13:36:11, Jeff Layton wrote:
> On Wed, 2023-05-24 at 20:24 +0300, Amir Goldstein wrote:
> > On Wed, May 24, 2023 at 8:05 PM Jeff Layton <jlayton@kernel.org> wrote:
...
> > 
> > Beyond the general idea, do you also ACK my fix to _fh_update()
> > above? I wasn't 100% sure about it.
> > 
> 
> That looks like the right way to handle _fh_update(). I think that
> should also make it also treat a value of 0 as an error, which seems
> like the right thing to do (even of no caller tries to do that today).
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks! I've added the patch into my tree.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
