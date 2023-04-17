Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A468B6E4647
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 13:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDQLWM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 07:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjDQLWL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:22:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE67198;
        Mon, 17 Apr 2023 04:21:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D15A210EB;
        Mon, 17 Apr 2023 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681730407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3F04YQpv1Md30jtqy0Oglxh4z17ZP+EH21Z95JtSL38=;
        b=u+dgpkIIfIUozJvgMax+zkuKkyoK4ujNbrhrELb9q3qz+pb1d6KAhEgnYR/r/d7suNGNVV
        Lj4wJuDn2Vl1Znh+SK25532X4r8BWXlesoe18ZbEc/vXj6aoEMS7vti6h2ffuH+nQzXAKw
        EIbiDYJQ01+Si9R8oYapaHSRwt6RGcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681730407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3F04YQpv1Md30jtqy0Oglxh4z17ZP+EH21Z95JtSL38=;
        b=tRRMTDRXDRVFOglApyqyELMikZiUn+3m3X+RtYQaVuF4xL4wjqRQ6eIeTrIxw64tXVS5Jq
        aq/qILreugaGANDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F396E13319;
        Mon, 17 Apr 2023 11:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cTBdO2YrPWRQIwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 17 Apr 2023 11:20:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 879B8A0744; Mon, 17 Apr 2023 13:20:06 +0200 (CEST)
Date:   Mon, 17 Apr 2023 13:20:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv5 5/9] ext2: Move direct-io to use iomap
Message-ID: <20230417112006.3bzzitsxy67jpviq@quack3>
References: <cover.1681639164.git.ritesh.list@gmail.com>
 <20553b1a61760dc6a7451e3b4fc9ba76653e6eb0.1681639164.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20553b1a61760dc6a7451e3b4fc9ba76653e6eb0.1681639164.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 16-04-23 15:38:40, Ritesh Harjani (IBM) wrote:
> This patch converts ext2 direct-io path to iomap interface.
> - This also takes care of DIO_SKIP_HOLES part in which we return -ENOTBLK
>   from ext2_iomap_begin(), in case if the write is done on a hole.
> - This fallbacks to buffered-io in case of DIO_SKIP_HOLES or in case of
>   a partial write or if any error is detected in ext2_iomap_end().
>   We try to return -ENOTBLK in such cases.
> - For any unaligned or extending DIO writes, we pass
>   IOMAP_DIO_FORCE_WAIT flag to ensure synchronous writes.
> - For extending writes we set IOMAP_F_DIRTY in ext2_iomap_begin because
>   otherwise with dsync writes on devices that support FUA, generic_write_sync
>   won't be called and we might miss inode metadata updates.
> - Since ext2 already now uses _nolock vartiant of sync write. Hence
>   there is no inode lock problem with iomap in this patch.
> - ext2_iomap_ops are now being shared by DIO, DAX & fiemap path
> 
> Tested-by: Disha Goel <disgoel@linux.ibm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

One comment below:

> @@ -844,6 +868,13 @@ static int
>  ext2_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>  		ssize_t written, unsigned flags, struct iomap *iomap)
>  {
> +	/*
> +	 * Switch to buffered-io in case of any error.
> +	 * Blocks allocated can be used by the buffered-io path.
> +	 */
> +	if ((flags & IOMAP_DIRECT) && (flags & IOMAP_WRITE) && written == 0)
> +		return -ENOTBLK;
> +
>  	if (iomap->type == IOMAP_MAPPED &&
>  	    written < length &&
>  	    (flags & IOMAP_WRITE))

Is this really needed? What for?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
