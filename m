Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FCC59EDB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 22:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiHWUqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 16:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiHWUq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:46:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20B0DF46;
        Tue, 23 Aug 2022 13:40:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70E3A21FC6;
        Tue, 23 Aug 2022 20:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661287246;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DdhWZRtupwKymZPlWoKVfVdBWFdhpfcO5trqUY+601M=;
        b=BRmkwi7f8aLtNAbn5NZ0kU3yh8UQ8FxzfrE6j/VbH6DERjgIooshPJTCGQOu02ben4BO1y
        gMDH54ssEIMLDLVk/r1YZuxe0xUp8BmuTfv+ytg0m9FKf00qZ4X7ol10fQjq1be8XnNC8U
        LYOTY+mMDKOERnaMXgtGxmRIdzU/hag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661287246;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DdhWZRtupwKymZPlWoKVfVdBWFdhpfcO5trqUY+601M=;
        b=6jXmlpJjUHNRG0mZLnNVdVTH8AL6Ryuaj3ha1hVbhQk9gk+2uu9+ov1ZoNDXRQkYlHn3N3
        +5eQE/buclDhuUCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3527013A89;
        Tue, 23 Aug 2022 20:40:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iMTtC047BWNmCQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 Aug 2022 20:40:46 +0000
Date:   Tue, 23 Aug 2022 22:35:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] btrfs: Convert __process_pages_contig() to use
 filemap_get_folios_contig()
Message-ID: <20220823203532.GR13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220816175246.42401-1-vishal.moola@gmail.com>
 <20220816175246.42401-3-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816175246.42401-3-vishal.moola@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:52:41AM -0700, Vishal Moola (Oracle) wrote:
> Convert to use folios throughout. This is in preparation for the removal of
> find_get_pages_contig(). Now also supports large folios.
> 
> Since we may receive more than nr_pages pages, nr_pages may underflow.
> Since nr_pages > 0 is equivalent to index <= end_index, we replaced it
> with this check instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: David Sterba <dsterba@suse.com>
