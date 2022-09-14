Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062A55B850D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 11:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiINJe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiINJeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:34:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4001EC7D
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 02:29:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 78F6D5CB89;
        Wed, 14 Sep 2022 09:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663147790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yAK55y7aHmshakV3iOOWKERMO4P6AWzXO9nmdfJvK/A=;
        b=NCBsIa5q67c7uKcJwFIvDC1asJ9WJ3dXtsBS8/SWwhY1TPMqyhW7SnmSo6aLa2+08auh7X
        q/EtDrf5u/luiY6i0EjkLPEST0/Xek3f6F4mp2Bdk7pODVSxNeQEJzHlhy2LiluocjTkkv
        jgmZ0tNPOeKXyGAjKs2QbZiID5K+4Es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663147790;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yAK55y7aHmshakV3iOOWKERMO4P6AWzXO9nmdfJvK/A=;
        b=HQ3CS/DFShB0OhonR29hxWgxoLDUIbgeOcM5Mu/zVUqvPU061FXi25UG1on4i0fa6fZEDx
        EI9v8uqsZWTXtOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6ACA4134B3;
        Wed, 14 Sep 2022 09:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u/gHGg6fIWMAKwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Sep 2022 09:29:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 08AE4A0680; Wed, 14 Sep 2022 11:29:50 +0200 (CEST)
Date:   Wed, 14 Sep 2022 11:29:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Plaster, Robert" <rplaster@deepspacestorage.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20220914092949.yypllzsaup7vusxj@quack3>
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220912125734.wpcw3udsqri4juuh@quack3>
 <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <BY5PR07MB6529795F49FB4E923AFCB062A3449@BY5PR07MB6529.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY5PR07MB6529795F49FB4E923AFCB062A3449@BY5PR07MB6529.namprd07.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Robert!

On Mon 12-09-22 21:10:24, Plaster, Robert wrote:
> HI Jan – Our team has been using fanotify for HSM as a DMAPI replacement
> for a while now. We came from StorageTek/Sun/Oracle HSM product line
> development teams. We have been working on this for about 5 years and
> just this month are supporting end-users. DMAPI was a huge stumbling
> block for us. We figured out what minimum set of api calls were needed to
> make it work.
> 
> Our experience with fanotify has been fantastic. Not much overhead CPU
> load but for boot volumes we do filter out events for swap and other
> (there are so many) OS temp files that are really of no concern to HSM.
> We can create as many files as the file system on NVMe can without any
> back-pressure and the HSM process will go as fast as the target media
> supports.

I'm glad to hear fanotify is useful for you.

> We have tested close to 600M files per HSM client and we keep adding
> client files as time permits, we have no coded limits for the number of
> HSM clients or max number of files in the repository. Also, the
> repository for HSM clients is heterogenous so it allows us to push files
> from one client type to another without any transcoding. I asked the guys
> doing the actual fanotify part to comment but they said it would be a
> couple days as they are heads down on a fix for a customer.
> 
> Currently we have HSM and punch-hole running on xfs and tested it on zfs
> (works but client isn’t finalized) and we have Lustre and SpectrumScale
> on our to-do list. Basically any FS with extended attributes should work
> for HSM and some (not all) will work with punch-hole capabilities.
> 
> We have developed a HSM target for certain object stores (Ceph librados
> and we have our own in-house object store) that support stream-IO and of
> course any tape technology. We have a replication tool for making an S3
> target look like the source FS but its just replication, not HSM. Until
> we get a S3 io-streaming we can’t use it for HSM. Our implementation only
> works with our open-source catalog, archive platform. We tried to
> announce this capability to the ceph community but we could never get
> past their gatekeepers so only people we actually talk to know about it.
> 
> Check out our site (kinda sucks and a little markety) but it’s a good
> primer. In it are links to the code and manuals we have done. We have not
> put out on github yet but will very soon. We are getting ready to post
> some big updates to really simplify installation and configuration and
> some bug fixes for some weird edge-cases.

Thanks for info and the links! It is interesting to learn something about
how users are actually using our code :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
