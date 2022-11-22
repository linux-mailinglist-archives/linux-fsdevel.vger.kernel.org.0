Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74174633F9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 15:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiKVO7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 09:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiKVO64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:58:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BD1C773;
        Tue, 22 Nov 2022 06:56:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C12EA1F85D;
        Tue, 22 Nov 2022 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669129005;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=at6y+TTS2oVXMolCIvQb3yxpVnbineUdxV9fGtNxfj4=;
        b=zLRw/arWcUItGvQQk81m0Q0MzGiML2vcj/dEs3DO6QaUsXJRNv1MBXNe/VvXZNvQIgwcFW
        f/8WniJE7hKwXnS1PQpVQXcRK1CXDJmUkifVVi5Z2onjTKVsqJBLjnRjXfeVvAe1cTgFW7
        ZVINEJVKUtklvunA/yNYDGjb6pvTnBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669129005;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=at6y+TTS2oVXMolCIvQb3yxpVnbineUdxV9fGtNxfj4=;
        b=gVo3iIsAvA6V6/B4tE3nZfbtatg4VQ9mzj/DiSLbBgjm/M78VvqsipK8uGqyn3zizV4Rm6
        EZ+NlKRNIRNhV3AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 829D113B01;
        Tue, 22 Nov 2022 14:56:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WQXfHi3jfGNDBAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 22 Nov 2022 14:56:45 +0000
Date:   Tue, 22 Nov 2022 15:56:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 2/5] fs: affs: initialize fsdata in affs_truncate()
Message-ID: <20221122145615.GE5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221121112134.407362-1-glider@google.com>
 <20221121112134.407362-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121112134.407362-2-glider@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:21:31PM +0100, Alexander Potapenko wrote:
> When aops->write_begin() does not initialize fsdata, KMSAN may report
> an error passing the latter to aops->write_end().
> 
> Fix this by unconditionally initializing fsdata.
> 
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Alexander Potapenko <glider@google.com>

With the fixed Fixes: reference,

Acked-by: David Sterba <dsterba@suse.com>
