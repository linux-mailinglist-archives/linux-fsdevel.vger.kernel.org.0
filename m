Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4941A6B6AA1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Mar 2023 20:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCLT1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Mar 2023 15:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCLT1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Mar 2023 15:27:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EF83801E;
        Sun, 12 Mar 2023 12:27:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0F5E22AD4;
        Sun, 12 Mar 2023 19:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678649231;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qUrtsf7E1uS5r3l73oow/fqBplYDsc0FAxkqV6bSIM4=;
        b=B9EPjU4Opsi9Fdb8YbjafTartBRCu68Kfm6kIeht/b8XQ1goQhKHfm2RC3uLOCclUre7cs
        l/OWj0oc1X9JuBKCG2PhJbxUwQOiXgB0RSiSMzYM9HOoaE0BuI8+uDla5R9QXQxiddR3nW
        ylgcHejpix4h/oIs7gDGi5BSnlb4hoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678649231;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qUrtsf7E1uS5r3l73oow/fqBplYDsc0FAxkqV6bSIM4=;
        b=lI/0GgRXTwhS4mOgsVJrk4Sz9QsSZhoubyXIuBw/Dbk0NigBOXHIqc31ypyDj2N+IJBl9p
        fG7A8cVVF3uVR9Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EE871325E;
        Sun, 12 Mar 2023 19:27:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eoGkAI8nDmS8UwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Sun, 12 Mar 2023 19:27:11 +0000
Date:   Sun, 12 Mar 2023 20:27:04 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, Jason@zx2c4.com, ebiederm@xmission.com,
        yzaikin@google.com, j.granados@samsung.com,
        patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] utsname: simplify one-level sysctl registration for
 uts_kern_table
Message-ID: <20230312192704.GA510320@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230310231656.3955051-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310231656.3955051-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Luis,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
