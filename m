Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384CB4B170A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 21:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344279AbiBJUkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 15:40:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiBJUkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:40:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F7A1034;
        Thu, 10 Feb 2022 12:40:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A96E1F3A1;
        Thu, 10 Feb 2022 20:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644525605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ydogXdpeXhtIqARiomSkF3gPYPozhq0C4V8ZqquuleY=;
        b=x4IFSCQkO053Twtz2nEXX/gtaTI6cI04prqKFQEAAuSXNjUM9qq+ZS1hCPD0/ry8oiOwUo
        7QZ1oBUz1y+q6063oLyXTSEZx+o5rUNA6uTZakHNA98Q0v3w0i6xjwkKMSpeWBAd9oy9Dd
        WMujvYPcYtciyit6J104ZHRTkxr1K9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644525605;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ydogXdpeXhtIqARiomSkF3gPYPozhq0C4V8ZqquuleY=;
        b=ANjfm9yJclbFSlkudXveZUVob20wD/M/eYWpuypC/uuRopK419S+VBOBPPv2ZfQEUae30G
        v3535fICpG5Bq5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4ADA713C4A;
        Thu, 10 Feb 2022 20:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YUlDBCV4BWJQFQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 10 Feb 2022 20:40:05 +0000
Date:   Thu, 10 Feb 2022 14:40:03 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, fvogt@suse.com
Subject: Re: [PATCH] Fix read-only superblock in case of subvol RO remount
Message-ID: <20220210204003.nn4z7zanxmkfqgs6@fiona>
References: <20220210165142.7zfgotun5qdtx4rq@fiona>
 <YgVnL//Q7gMCfxFN@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgVnL//Q7gMCfxFN@casper.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19:27 10/02, Matthew Wilcox wrote:
> On Thu, Feb 10, 2022 at 10:51:42AM -0600, Goldwyn Rodrigues wrote:
> >  	WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
> > -				 (fc->sb_flags & fc->sb_flags_mask)));
> > +				 (sb->s_flags & fc->sb_flags_mask)));
> > +
> 
> what?
> 
> (a & ~b) | (a & b) == a, no?

Yup! I am re-enrolling into middle school to learn bit-arithmetic.

Apparently, I don't need this change at all and can be done in btrfs
code by changing the flags parameter.

Will post a patch to btrfs ML with the updated patch.

-- 
Goldwyn
