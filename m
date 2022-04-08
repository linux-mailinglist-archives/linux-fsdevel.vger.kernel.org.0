Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A5C4F978A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 16:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiDHOEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 10:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbiDHOEN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:04:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC334BAE;
        Fri,  8 Apr 2022 07:02:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 33FF9215FD;
        Fri,  8 Apr 2022 14:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649426526;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NntcuTEBNLs2a5PoQyJ5XTqfafqQKLdTMOol7WzzX0s=;
        b=IOyS+CY4mKgPgZ8USr3nF2sek6nsoLhx0cr5TMVaaAs4Ag4bKj8Vi2sptagRUXESVfNODS
        Ln94gENJtPAW0xwa1YTvXkhHuvtN+PZVtUN04bIOD5Gb1FPiPxXvY9276x42sDgCevWU0p
        F0xk4+Bz9XncCGMfKPV4nKJOLviw8CE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649426526;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NntcuTEBNLs2a5PoQyJ5XTqfafqQKLdTMOol7WzzX0s=;
        b=YyECzpdo2dp1JJsJWW+9IUjgVDYVcTRsNKLbGqCSM7UYLC06N2gtmpywFUAHkgPWFPstwI
        YstMAkxeXK3nzLCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C18F6A3B87;
        Fri,  8 Apr 2022 14:02:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 03176DA80E; Fri,  8 Apr 2022 15:58:02 +0200 (CEST)
Date:   Fri, 8 Apr 2022 15:58:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     cgel.zte@gmail.com
Cc:     dsterba@suse.com, tytso@mit.edu, clm@fb.com, josef@toxicpanda.com,
        sfrench@samba.org, matthew.garrett@nebula.com, jk@ozlabs.org,
        ardb@kernel.org, adilger.kernel@dilger.ca, rpeterso@redhat.com,
        agruenba@redhat.com, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH v2] fs: remove unnecessary conditional
Message-ID: <20220408135802.GQ15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, cgel.zte@gmail.com, dsterba@suse.com,
        tytso@mit.edu, clm@fb.com, josef@toxicpanda.com, sfrench@samba.org,
        matthew.garrett@nebula.com, jk@ozlabs.org, ardb@kernel.org,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-efi@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220408021136.2493147-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408021136.2493147-1-lv.ruyi@zte.com.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 08, 2022 at 02:11:36AM +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> iput() has already handled null and non-null parameter, so it is no
> need to use if().
> 
> This patch remove all unnecessary conditional in fs subsystem.
> No functional changes.

You'd need to split i by subsystem under fs/, each subdirectory has a
differnt maintainer. I can take only the btrfs part.
