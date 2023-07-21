Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F40B75D00E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 18:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGUQxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 12:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGUQxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:53:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04209272E
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 09:53:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A7E02218E3;
        Fri, 21 Jul 2023 16:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689958397;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kXBac9kuj1lDbLrtSlygpYRAplHmcRuQr8q7kf0wKlI=;
        b=xCPVh33k/Tzo5/qz4Fvh12qB0K83KdRuYlbuVSrb3uupt+uuW0ZsJx41MvwFLqIok4tCVg
        beFe6TDdHc7Isx49NAODQfwx9520E3AId9Zsulv4nabMY5vcp5RnFL/tID9NuQGoMPw7YR
        Oc3JtfRQDIf/EBGCL6L+y2zAFGG9Qlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689958397;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kXBac9kuj1lDbLrtSlygpYRAplHmcRuQr8q7kf0wKlI=;
        b=q4Pcj78tGokzZD/4C/61fiu+kAla2U2L3+Xr46VRvyspcG1dHOHQWQl7LesCAoBiLta4RT
        6SkBPutNvkmC3MDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FAFE134BA;
        Fri, 21 Jul 2023 16:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TW1THv23umQMUQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 21 Jul 2023 16:53:17 +0000
Date:   Fri, 21 Jul 2023 18:46:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] affs: Remove writepage implementation
Message-ID: <20230721164635.GC20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230714183440.307525-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714183440.307525-1-willy@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 14, 2023 at 07:34:40PM +0100, Matthew Wilcox (Oracle) wrote:
> If the filesystem implements migrate_folio and writepages, there is
> no need for a writepage implementation.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Added to my AFFS branch, thanks.
