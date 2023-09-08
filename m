Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D325799203
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 00:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbjIHWFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 18:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjIHWFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:05:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE9E19B4;
        Fri,  8 Sep 2023 15:05:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0949C201B0;
        Fri,  8 Sep 2023 22:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694210703;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3wgDNOg10tFaG5sW5PDLx5Me9drYwFkQ2Q+3t6fhh34=;
        b=yUpfimZyp/4UX8NRNaH3tw6G8dPOxwmNMhIDNvkEA64TaxCNP0eBmRytdAbDL/gV8LT3LL
        3D1TJAb8E2Zto4MOTMzUWdi99zXFErcu0mdjs70lJt6RcUP2aLii+fZM0CidF0pzZwmD3a
        5Vm3EZefBcY3bDECps7NA+66Sr0MlNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694210703;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3wgDNOg10tFaG5sW5PDLx5Me9drYwFkQ2Q+3t6fhh34=;
        b=oYuZ7w/HlNhz3NWdBBubTGj5GDdNIJcQ7Zsud9f1PFMpq5Llo/a1i+g4NRabtTY+F2/rbQ
        Ct4LOeEPQ4pagFAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6F84131FD;
        Fri,  8 Sep 2023 22:05:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4bnCL46a+2TtJgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Sep 2023 22:05:02 +0000
Date:   Fri, 8 Sep 2023 23:58:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-btrfs@vger.kernel.org, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com,
        Christoph Hellwig <hch@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] btrfs: file_remove_privs needs an exclusive lock
Message-ID: <20230908215830.GZ3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230906155903.3287672-1-bschubert@ddn.com>
 <20230906155903.3287672-2-bschubert@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906155903.3287672-2-bschubert@ddn.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:59:03PM +0200, Bernd Schubert wrote:
> file_remove_privs might call into notify_change(), which
> requires to hold an exclusive lock.
> 
> Fixes: e9adabb9712e ("btrfs: use shared lock for direct writes within EOF")
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Added to btrfs tree, with slightly reformatted comments, some minor
coding style changes and updated changelog. Thanks.
