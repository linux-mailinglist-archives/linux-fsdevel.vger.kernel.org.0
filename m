Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654F97774DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 11:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjHJJqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 05:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjHJJqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:46:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAE31BD9;
        Thu, 10 Aug 2023 02:45:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44EE421852;
        Thu, 10 Aug 2023 09:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691660758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T5qTe0YO8ZqB3VKwRihJas1gwrGZq8M70nX+lVeOtE4=;
        b=ncg0wKhJKKECfLl1sFF4YhPUNlfV59io48guMoOonvWgTdJjVRfGbdT+1/bWhly/jpv7hx
        kIdLlCbqD7WfxmQ2H97bi6Z5frEgW1eDwSJCenXTxKr4sPNFcDpXOcQh97eaztbtVe1DRT
        jGXCmWWCnE6LF3DX1/qMszXsf+Qkxyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691660758;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T5qTe0YO8ZqB3VKwRihJas1gwrGZq8M70nX+lVeOtE4=;
        b=z2fwfT5Fk/VdD3D/wapPZUHO8CNQLtNVsxwkSYm/8Ip/D4tiTihZOBGPtvem3ZPDvLmSn6
        O/i0ueJsxX0FexDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33164138E0;
        Thu, 10 Aug 2023 09:45:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4fbbC9ax1GSsCAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 10 Aug 2023 09:45:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A36BCA076F; Thu, 10 Aug 2023 11:45:57 +0200 (CEST)
Date:   Thu, 10 Aug 2023 11:45:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Haibo Li <haibo.li@mediatek.com>,
        linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xiaoming.yu@mediatek.com
Subject: Re: [PATCH] mm/filemap.c:fix update prev_pos after one read request
 done
Message-ID: <20230810094557.pesc4pnwuicrisqh@quack3>
References: <20230628110220.120134-1-haibo.li@mediatek.com>
 <20230809164446.uwxryhrfbjka2lio@quack3>
 <20230809114507.57282ff1dd14973f3964e669@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809114507.57282ff1dd14973f3964e669@linux-foundation.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 09-08-23 11:45:07, Andrew Morton wrote:
> On Wed, 9 Aug 2023 18:44:46 +0200 Jan Kara <jack@suse.cz> wrote:
> 
> > Willy, any opinion? Andrew, can you pickup the patch if Willy doesn't
> > object?
> 
> I added it to mm.git on July 2.

Ah, sorry for the noise then. I should have checked that. Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
