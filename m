Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390684048FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 13:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhIILMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 07:12:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55208 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhIILMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:12:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E418E2235B;
        Thu,  9 Sep 2021 11:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631185887;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rAO625+Okb3VEAehFr54x49hW24k1LBGvt0E5ie9hvI=;
        b=T4uDL4FbIupwlTQcSxysALBG9RZkJA34VCqU+T/vqSpdzZkRgLIM0x/5nDaGA4xWGD6/za
        PYEsTMRZTujOoQ9LSFJaWVW43vJE27W3z9N1ISu8F7NBZo2euV3d+0QD2Bfsn4efz2niZH
        Um6zh3pDPz0sufl/aIwFc0D6xA3wexI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631185887;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rAO625+Okb3VEAehFr54x49hW24k1LBGvt0E5ie9hvI=;
        b=EZFbZCei9xXrrQGH0UXgSJML5VshH1Tkw44AwGzKc+A3ufLNN0K1582TrmRnJ12T348jX/
        Kh9A+4NUNNHaNZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B025A13B0C;
        Thu,  9 Sep 2021 11:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QsuFKd/rOWGVTQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 09 Sep 2021 11:11:27 +0000
Date:   Thu, 9 Sep 2021 13:11:26 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [regression] fsnotify fails stress test since
 fsnotify_for_v5.15-rc1 merged
Message-ID: <YTnr3gpG44IEjEkf@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210907063338.ycaw6wvhzrfsfdlp@xzhoux.usersys.redhat.com>
 <CAOQ4uxhnnG6g29NomN_MLvfk9Cf6gEfaOkW0RuXDCNREhmofdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhnnG6g29NomN_MLvfk9Cf6gEfaOkW0RuXDCNREhmofdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Tue, Sep 7, 2021 at 9:33 AM Murphy Zhou <jencce.kernel@gmail.com> wrote:

> > Hi,

> > Since this commit:

> > commit ec44610fe2b86daef70f3f53f47d2a2542d7094f
> > Author: Amir Goldstein <amir73il@gmail.com>
> > Date:   Tue Aug 10 18:12:19 2021 +0300

> >     fsnotify: count all objects with attached connectors




> > Kernel fsnotify can't finish a stress testcase that used to pass quickly.

> > Kernel hung at umount. Can not be killed but restarting the server.

> > Reproducer text is attached.


> Hi Murphy,

> Thank you for the detailed report.
> I was able to reproduce the hang and the attached patch fixes it for me.
> Cloud you please verify the fix yourself as well?

> This is a good regression test.
> Did you consider contributing it to LTP?
> I think the LTP team could also help converting your reproducer to
> an LTP test (CC: Petr).

@Murphy: yes, please contribute that to LTP. There are already fanotify tests [1],
here is the C API [2] and shell API [3] (if needed, it should be enough to write
it just in C). If you have any questions, don't hesitate ask on LTP ML and Cc
me.

@Amir: thanks!

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/syscalls/fanotify/
[2] https://github.com/linux-test-project/ltp/wiki/C-Test-API
[3] https://github.com/linux-test-project/ltp/wiki/Shell-Test-API

> Thanks,
> Amir.

> From 14d3c313062dfbc86b3d2c4d7deec56a096432f7 Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Thu, 9 Sep 2021 13:46:34 +0300
> Subject: [PATCH] fsnotify: fix sb_connectors leak

> Fix a leak in s_fsnotify_connectors counter in case of a race between
> concurrent add of new fsnotify mark to an object.

> The task that lost the race fails to drop the counter before freeing
> the unused connector.

> Fixes: ec44610fe2b8 ("fsnotify: count all objects with attached connectors")
> Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> Link: https://lore.kernel.org/linux-fsdevel/20210907063338.ycaw6wvhzrfsfdlp@xzhoux.usersys.redhat.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/mark.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 95006d1d29ab..fa1d99101f89 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -531,6 +531,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
>  		/* Someone else created list structure for us */
>  		if (inode)
>  			fsnotify_put_inode_ref(inode);
> +		fsnotify_put_sb_connectors(conn);
>  		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
>  	}
