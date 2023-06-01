Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB24C719CDB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 15:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjFANCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 09:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjFANCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:02:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68155E7;
        Thu,  1 Jun 2023 06:02:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B525921981;
        Thu,  1 Jun 2023 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685624533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8x1uoNpgM5IX5BiPKnhSb/ZauUWOslfg6+9IkI8nFwo=;
        b=OxRy+vR8rw0DB8tXFEUojTcVeqikFJUmX/+LzYh5qbJlXRrgUwIxQZxNahDIiXzac2+Sn5
        sFL7ZqGZi+hQuJoiQMlw/nus2BvsdRfFja15owWIB6cCroVln5kBv57XeFaYONdtM7nQuX
        aRUhr8Bz/CtpLEsAecPIsJi7lisFrPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685624533;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8x1uoNpgM5IX5BiPKnhSb/ZauUWOslfg6+9IkI8nFwo=;
        b=hayvR+sVNPDzCntOwfP6W+KnecYu4SePmHLzbsxXYNiVYGumMCHYJl9SQB26+Ru3/MZyI+
        Lrb24iHAxvTKkLDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7D77139B7;
        Thu,  1 Jun 2023 13:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0lr1KNWWeGTwHgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Jun 2023 13:02:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0A000A0754; Thu,  1 Jun 2023 15:02:11 +0200 (CEST)
Date:   Thu, 1 Jun 2023 15:02:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] fanotify: support reporting non-decodeable file
 handles
Message-ID: <20230601130211.a3lqvahrauqqymr7@quack3>
References: <ca02955f-1877-4fde-b453-3c1d22794740@kili.mountain>
 <CAOQ4uxi6ST19WGkZiM=ewoK_9o-7DHvZcAc3v2c5GrqSFf0WDQ@mail.gmail.com>
 <20230524140648.u6pexxspze7pz63z@quack3>
 <080107ac-873c-41dc-b7c7-208970181c40@kili.mountain>
 <CAOQ4uxgA-kQOOp69pyKhQpMZZuyWZ0t6ir+nqL4yL9wX5CBNgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgA-kQOOp69pyKhQpMZZuyWZ0t6ir+nqL4yL9wX5CBNgQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 25-05-23 12:48:33, Amir Goldstein wrote:
> On Thu, May 25, 2023 at 12:26 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Wed, May 24, 2023 at 04:06:48PM +0200, Jan Kara wrote:
> > > Yes, I've checked and all ->encode_fh() implementations return
> > > FILEID_INVALID in case of problems (which are basically always only
> > > problems with not enough space in the handle buffer).
> >
> > ceph_encode_fh() can return -EINVAL
> 
> Ouch! thanks for pointing this out
> 
> Jeff,
> 
> In your own backyard ;-)
> Do you think this new information calls for rebasing my fix on top of master
> and marking it for stable? or is this still low risk in your opinion?

OK, since I don't see a strong push for merging this ASAP, I'm keeping the
fix in my fsnotify branch and will push it to Linus during the merge
window.
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
