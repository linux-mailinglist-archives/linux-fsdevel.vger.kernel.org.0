Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8C710A02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 12:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbjEYKXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 06:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjEYKXy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 06:23:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0B410B;
        Thu, 25 May 2023 03:23:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C61151FDA6;
        Thu, 25 May 2023 10:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685010231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3hIZtE4x1k8MYWVrcf4QjNdzuAbiDSyu0f/OEGIARH4=;
        b=xoLm0zYEA80hsPEgqYGIP98R/Ve+K027+RCyGAoRoQdIl0RQH8AzxjR7KH6YcA6lveVFDW
        Inry46vUo1ZLY3hm+71Juq8yKbqSR1sgfmRcht2tR0nh334Hib4bDVrc1q2lTRsuemKzuk
        G87Y1HY/UGPJWhQUDbEdKwV75JQyKbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685010231;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3hIZtE4x1k8MYWVrcf4QjNdzuAbiDSyu0f/OEGIARH4=;
        b=HEjQcVcpkomuBFVLKuqLCiQGqEqd4ocBlPzXgiwBDaQaFKkwuLVfp4sjIL0GKNsXGIQgNJ
        ZS5kkg+CP33EeMDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4379D134B2;
        Thu, 25 May 2023 10:23:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BlF1EDc3b2SFegAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 10:23:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BA989A075C; Thu, 25 May 2023 12:23:50 +0200 (CEST)
Date:   Thu, 25 May 2023 12:23:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] fanotify: support reporting non-decodeable file
 handles
Message-ID: <20230525102350.wb5nc6lqv56nyona@quack3>
References: <ca02955f-1877-4fde-b453-3c1d22794740@kili.mountain>
 <CAOQ4uxi6ST19WGkZiM=ewoK_9o-7DHvZcAc3v2c5GrqSFf0WDQ@mail.gmail.com>
 <20230524140648.u6pexxspze7pz63z@quack3>
 <080107ac-873c-41dc-b7c7-208970181c40@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <080107ac-873c-41dc-b7c7-208970181c40@kili.mountain>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 25-05-23 07:46:22, Dan Carpenter wrote:
> On Wed, May 24, 2023 at 04:06:48PM +0200, Jan Kara wrote:
> > Yes, I've checked and all ->encode_fh() implementations return
> > FILEID_INVALID in case of problems (which are basically always only
> > problems with not enough space in the handle buffer).
> 
> ceph_encode_fh() can return -EINVAL
> 
> $ smdb.py functions encode_fh > where
> $ for i in $(cut -d '|' -f 3 where | sort -u) ; do smdb.py return_states $i ; done | grep INTER | tee out

Ah, I've missed that return hidden in ceph_encode_snapfh(). This is indeed
cool use of static analysis ;) Thanks for noticing!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
