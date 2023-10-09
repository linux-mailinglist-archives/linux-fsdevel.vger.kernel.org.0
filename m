Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9307BE73F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 19:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377395AbjJIRAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377376AbjJIRAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:00:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D475ED;
        Mon,  9 Oct 2023 10:00:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E074B21885;
        Mon,  9 Oct 2023 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696870841;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFUIqiMe3bOMJeRTS3G+peu5DBbnk7Gw51HKAJIe3NQ=;
        b=v6ieNDnUNdiEbtgBiDAEKrFZCzGRDf2rHyCMjNRg+9xbrHFCyo1XFPOMJbrd0C4+zIt6Cy
        hIPCU/04m2jNaFWlDKiFHIh4PARO3GBHWAHuHQZpsz9utPLZDBnL+qeEBrBwFVc4x0YipK
        HWQAtldMhrVrsbJR1a+sumUwZF2ffJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696870841;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFUIqiMe3bOMJeRTS3G+peu5DBbnk7Gw51HKAJIe3NQ=;
        b=fL03+ZZQ6IZFhXL86++eIB16tkJD5TVxA8f0okTSyRyt4EBmSVlw9jr/OwGvKZ4B58HnKv
        t2F1uhA7i0QqvJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC9F513905;
        Mon,  9 Oct 2023 17:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QTY9LbkxJGWCYQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Oct 2023 17:00:41 +0000
Date:   Mon, 9 Oct 2023 18:53:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 23/89] btrfs: convert to new timestamp accessors
Message-ID: <20231009165356.GU28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
 <20231004185347.80880-21-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004185347.80880-21-jlayton@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:52:08PM -0400, Jeff Layton wrote:
> Convert to using the new inode timestamp accessor functions.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: David Sterba <dsterba@suse.com>
