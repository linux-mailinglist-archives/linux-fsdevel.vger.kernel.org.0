Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2937688FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 00:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjG3WCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 18:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3WCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:02:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AE6A1;
        Sun, 30 Jul 2023 15:02:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F3472195F;
        Sun, 30 Jul 2023 22:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690754556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DtQLsEPs2QEX8EYeZ0XdC8blDLkykDYdkAAk1sVMV0=;
        b=jk1dGzewobiiNJlcH/DTn9D1rWiv4aageju1X+61JXnKJKeEcC7KbtNGkkUnnCP4Uv8nyt
        EOE6xFzbg1xoe428yCTvwNeT2wLXijXM8WcHKgfZS0J68KyevRZsOXVcSYUt1UoK5YavhE
        XMlSDKaseRORzV9uFH6hYayFZdTcbwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690754556;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DtQLsEPs2QEX8EYeZ0XdC8blDLkykDYdkAAk1sVMV0=;
        b=9gWX19jQn5rm4XsHi8Th3zyqX+CkGgDSAjQANMcpdBieRpaOiHFzhLmqUT+QhDTMg58tMI
        N73msxgi+1DTN7Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 135F813595;
        Sun, 30 Jul 2023 22:02:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4kDXLfjdxmRtOQAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 30 Jul 2023 22:02:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Chuck Lever" <cel@kernel.org>,
        "David Howells" <dhowells@redhat.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Hugh Dickins" <hughd@google.com>, "Jens Axboe" <axboe@kernel.dk>,
        "Matthew Wilcox" <willy@infradead.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] nfsd: Fix reading via splice
In-reply-to: <ZMaB1BwBfNko1ZoE@tissot.1015granger.net>
References: <169054754615.3783.11682801287165281930.stgit@klimt.1015granger.net>,
 <169058849828.32308.14965537137761913794@noble.neil.brown.name>,
 <ZMaB1BwBfNko1ZoE@tissot.1015granger.net>
Date:   Mon, 31 Jul 2023 08:02:29 +1000
Message-id: <169075454985.32308.7692478577605440938@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 31 Jul 2023, Chuck Lever wrote:
> 
> I'd like to apply David's fix as-is, unless it's truly broken or
> someone has a better quick solution.
> 

Your reasoning is sound.  From a behavioural perspective (though not
from a maintenance perspective) the patch is no worse than the current
code, so
   Reviewed-by: NeilBrown <neilb@suse.de>

NeilBrown
