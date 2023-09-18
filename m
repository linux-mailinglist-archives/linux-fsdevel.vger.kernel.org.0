Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A657A4FEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjIRQ5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjIRQ46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:56:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76127112;
        Mon, 18 Sep 2023 09:56:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D38C21D17;
        Mon, 18 Sep 2023 14:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695047000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dGxQuTqFmA8IizYiNQmAZsobnCdmatBjOS6CO3GvZaQ=;
        b=1pYPX8mnItYfPUtWcyIvs1PT0FN6f/n1qxUFGg1eXYczDMlHemghdnZXWMhfHX8Y1OOC31
        Hz9IscOVTaD3ghAUak2Y1+qgd3PtYB2f2OENJbB7JYUJicfF6Q3Oh+zmEvWmrTlWRI5IHA
        6eo3jUVz0nAf4m5SndgN1Re8GoReodQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695047000;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dGxQuTqFmA8IizYiNQmAZsobnCdmatBjOS6CO3GvZaQ=;
        b=4vMlfLjKZkPWUiJwVAWZfqqNiaOkhC2jLSpjE+7xlPgvMct89C7fPodFxnyuIzx/NSGuQV
        KcejQHY9qI0bu2Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2AD7F13480;
        Mon, 18 Sep 2023 14:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 84FnClhdCGWwNQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 14:23:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 98E9EA0759; Mon, 18 Sep 2023 16:23:19 +0200 (CEST)
Date:   Mon, 18 Sep 2023 16:23:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, amir73il@gmail.com
Subject: Re: [PATCH 3/4] inotify_user: add system call inotify_add_watch_at()
Message-ID: <20230918142319.kvzc3lcpn5n2ty6g@quack3>
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com>
 <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-09-23 15:57:43, Max Kellermann wrote:
> On Mon, Sep 18, 2023 at 2:40 PM Jan Kara <jack@suse.cz> wrote:
> > Note that since kernel 5.13 you
> > don't need CAP_SYS_ADMIN capability for fanotify functionality that is
> > more-or-less equivalent to what inotify provides.
> 
> Oh, I missed that change - I remember fanotify as being inaccessible
> for unprivileged processes, and fanotify being designed for things
> like virus scanners. Indeed I should migrate my code to fanotify.
> 
> If fanotify has now become the designated successor of inotify, that
> should be hinted in the inotify manpage, and if inotify is effectively
> feature-frozen, maybe that should be an extra status in the
> MAINTAINERS file?

The manpage update is a good idea. I'm not sure about the MAINTAINERS
status - we do have 'Obsolete' but I'm reluctant to mark inotify as
obsolete as it's perfectly fine for existing users, we fully maintain it
and support it but we just don't want to extend the API anymore. Amir, what
are your thoughts on this?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
