Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA02B5AD04B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiIEKjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbiIEKjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:39:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE6D17E0F
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Sep 2022 03:39:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D025A37754;
        Mon,  5 Sep 2022 10:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662374372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=90GE9IL4YV2MEocJAVEtD9i2+cT97M8m1gs6maYhf3Q=;
        b=ehS8HoHaBChbJw5OdYIDLiFrsssgk6PbYuiufHtlPJlvxRoC4mh5mISvGw0N9O4NYx6LIx
        +O3dwrjezEylOdASFB8vI/8BXUJfgMdYUeDks+oHH1uFO3U7ubE5YJ320zIl3lCRRtUNP7
        BfO7LABbrk6+GwLYh23Evg4QcLHBCmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662374372;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=90GE9IL4YV2MEocJAVEtD9i2+cT97M8m1gs6maYhf3Q=;
        b=FsCcOUXa3qmbRDPpbz72/y+BKLdIvQTpEw/n8DnSIkgp5D6QeJxgrJ8x7x5B9DMMsA4i0B
        +YScS3HHV9lKOyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3D9A13A66;
        Mon,  5 Sep 2022 10:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1sHHL+TRFWPlSwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 05 Sep 2022 10:39:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4D22FA0682; Mon,  5 Sep 2022 12:39:32 +0200 (CEST)
Date:   Mon, 5 Sep 2022 12:39:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: switching from FAN_MARK_MOUNT to FAN_MARK_FILESYSTEM
Message-ID: <20220905103932.aorusz55mu7az4qm@quack3>
References: <CAJfpegsF1Oohyq942pF0jBxuiybGuP8xab-kvsDU4rbyDRb7xA@mail.gmail.com>
 <CAOQ4uxj309jKiGrGBduoOr17rZXUD25JfHk5cQRus_qpSYBaqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj309jKiGrGBduoOr17rZXUD25JfHk5cQRus_qpSYBaqQ@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 05-09-22 12:16:09, Amir Goldstein wrote:
> On Mon, Sep 5, 2022 at 11:59 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > Hi,
> >
> > Is there anything that needs special attention when switching from
> > FAN_MARK_MOUNT to FAN_MARK_FILESYSTEM?
> >
> 
> Well, if you want to get events from all the mounts then
> switching to FAN_MARK_FILESYSTEM makes sense.
> It also allows you to request more event types.

And also more info coming with the event (like file handle information).

> The only benefit of FAN_MARK_MOUNT that I can think of
> is that it's the only way to implement a subtree watch in the kernel
> (using a mark on bind mount) in case you can control which mount
> users access from (e.g. container) and if you only care about the
> events that are possible on a mount mark.

Agreed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
