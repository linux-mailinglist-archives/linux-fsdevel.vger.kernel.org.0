Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA157B2F86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 11:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjI2Jqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 05:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjI2Jqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:46:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD998195;
        Fri, 29 Sep 2023 02:46:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6843D1F45E;
        Fri, 29 Sep 2023 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695980804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pN3c3QQPPPAhyxYgHCSW03sdnuK9hUjdYxe4GCRHThM=;
        b=tsJaFfa7fdKwpPyAUwhCqCin4S6XXd7zrBCMTgJZGhPQ8f0udLE/j56LBVhoLIUJKDOfcA
        NLhsemFUGzMOYH3J6nybm4sqqYWilfPAzKpfQ22B/4eMsrWhzKArSUxDhN5g0o96NJ5o1Z
        +mII5q1hK5+na6bOM7K4Bg2HTMYBVcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695980804;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pN3c3QQPPPAhyxYgHCSW03sdnuK9hUjdYxe4GCRHThM=;
        b=taLcdXbXpfNOHPbfnBjZzIPcTZb1IVl4MmEaf4AFfhvSIrqmyZJfAn/gaLFYz047yRnV4q
        r5+/X2l+qPcO6YCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E555D1390A;
        Fri, 29 Sep 2023 09:46:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TCADNQOdFmWqEwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 29 Sep 2023 09:46:43 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 71b5e434;
        Fri, 29 Sep 2023 09:46:43 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] fs: simplify misleading code to remove ambiguity
 regarding ihold()/iput()
In-Reply-To: <20230929-verkraften-abblendlicht-b4b67ccd45f9@brauner>
        (Christian Brauner's message of "Fri, 29 Sep 2023 11:28:56 +0200")
References: <20230928152341.303-1-lhenriques@suse.de>
        <20230928-zecken-werkvertrag-59ae5e5044de@brauner>
        <87il7tz5zt.fsf@suse.de>
        <20230929-verkraften-abblendlicht-b4b67ccd45f9@brauner>
Date:   Fri, 29 Sep 2023 10:46:43 +0100
Message-ID: <87edihz4zg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

>> Could you please double-check this was indeed applied?  I can't see it
>> anywhere.  Maybe I'm looking at the wrong place, but since your scripts
>> seem to have messed-up my email address, something else may have went
>> wrong.
>
> It was applied it's just not pushed out yet because of another patch
> discussion. It should show up in the next 30 minutes though.

Awesome, thanks for confirming!  I guess I should have waited a bit longer
before asking.

Cheers,
--=20
Lu=C3=ADs
