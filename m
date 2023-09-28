Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F7B7B23B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjI1RVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 13:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1RVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:21:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C738195;
        Thu, 28 Sep 2023 10:21:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6690C1F88F;
        Thu, 28 Sep 2023 17:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695921673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exyewe4TxMpZpDkKoLoAZkvpDFhEoO/g/vJ7pUTs+CU=;
        b=PKuxKWn9A0et8/KvsF5HPT2FI1Rbr1Z5Bg9wxUPeZY0oAQWXW38sxwQA7awXUuVogfP+/t
        ky0vHeo3G13DdBhl3e6frM/2Dt7CiAeU/oJY6Z7QSeGD5B3iQSKQ+j8e1sPa4pcGqNuHtD
        ce9IyIJjgGMKZ5WtSZYjsDYeeWeGAxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695921673;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exyewe4TxMpZpDkKoLoAZkvpDFhEoO/g/vJ7pUTs+CU=;
        b=a0kbyc/IL9VrRTRqywAe7mMtD0+LhW9nvp2abeMpOGhSJmfEmBQ6pxZB1RRUygk0rMQ/An
        5Zmg5EXcCWPLKABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0991138E9;
        Thu, 28 Sep 2023 17:21:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n8KuNwi2FWUTZAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 28 Sep 2023 17:21:12 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 0b14508c;
        Thu, 28 Sep 2023 17:21:12 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix possible extra iput() in do_unlinkat()
In-Reply-To: <20230928-erhoben-nennung-cc3e250c8667@brauner> (Christian
        Brauner's message of "Thu, 28 Sep 2023 18:19:23 +0200")
References: <20230928131129.14961-1-lhenriques@suse.de>
        <20230928134513.l2y3eknt2hfq3qgx@f> <878r8q1gn3.fsf@suse.de>
        <20230928-erhoben-nennung-cc3e250c8667@brauner>
Date:   Thu, 28 Sep 2023 18:21:12 +0100
Message-ID: <874jje1aev.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

>> OK, I'll rephrase the commit message for v2 so that it's clear it's not
>
> I've already applied your first pach and massaged your commit message.
> Authorship and all is retained. No need to resend.

Awesome, thanks!

> Probably got lost because git send-email scrambled your mail address.

Hmm... yeah, I should probably drop non-ascii chars from my email address.

Cheers,
--=20
Lu=C3=ADs
