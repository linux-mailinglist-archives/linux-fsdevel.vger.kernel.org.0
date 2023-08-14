Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2352E77BA3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 15:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjHNNh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 09:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjHNNhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:37:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B978810C0;
        Mon, 14 Aug 2023 06:37:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 76AF11F7AB;
        Mon, 14 Aug 2023 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692020270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5mYSrpxL4D9+Tu4E3dFs5QFfz/kTUIaqraD9BAIWnk=;
        b=GJGtiP44qEyMS++IcCpJVuqAJqNfB892HlH7zzwbWjr2DuUPksM/WuQ2cqOhwGoIW0OkUw
        isNcEFcxNH7Kx4xQN4LIJtrVQmN257YQIV6X/4+0I+a0Z3g2iVvMqzH2l9BrdwUCPYjtpd
        u+hVRyJ7qMCW395p0m59X3/snLioA2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692020270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5mYSrpxL4D9+Tu4E3dFs5QFfz/kTUIaqraD9BAIWnk=;
        b=Cg8S7dDRWqAaCS+21sZ8loL0gWgk28M5gJWJ4JCFrhEn0tKyswCqtWAYJdbbHE8zq6i76K
        GKD+mToYv1MH9lBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61A45138E2;
        Mon, 14 Aug 2023 13:37:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BW9EFy4u2mQTYQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Aug 2023 13:37:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EA49DA0769; Mon, 14 Aug 2023 15:37:49 +0200 (CEST)
Date:   Mon, 14 Aug 2023 15:37:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Song Liu <song@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH 11/29] md: Convert to bdev_open_by_dev()
Message-ID: <20230814133749.yqcgmcuo5xkvlxyc@quack3>
References: <20230810171429.31759-1-jack@suse.cz>
 <20230811110504.27514-11-jack@suse.cz>
 <CAPhsuW5S2gjPv+UpLjX=uBhsbPOmNGMbGjF2eJO7rWMnGVgOmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5S2gjPv+UpLjX=uBhsbPOmNGMbGjF2eJO7rWMnGVgOmg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 13-08-23 19:54:56, Song Liu wrote:
> On Fri, Aug 11, 2023 at 3:05 PM Jan Kara <jack@suse.cz> wrote:
> [...]
> > diff --git a/drivers/md/md.h b/drivers/md/md.h
> > index 1aef86bf3fc3..e8108845157b 100644
> > --- a/drivers/md/md.h
> > +++ b/drivers/md/md.h
> > @@ -59,6 +59,7 @@ struct md_rdev {
> >          */
> >         struct block_device *meta_bdev;
> >         struct block_device *bdev;      /* block device handle */
> > +       struct bdev_handle *bdev_handle;        /* Handle from open for bdev */
> 
> With bdev_handle, we should eventually get rid of md_rdev->bdev.
> But that can be done in a separate patch.

Yeah, we can do that. But in the case of md it would cause a relatively
large amount of churn so at least for this series I've stayed with the
minimal solution.

> Acked-by: Song Liu <song@kernel.org>

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
