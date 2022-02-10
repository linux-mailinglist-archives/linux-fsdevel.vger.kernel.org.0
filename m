Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ADD4B178E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 22:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbiBJVbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 16:31:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiBJVbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:31:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1F71B1;
        Thu, 10 Feb 2022 13:31:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1FE6C210DF;
        Thu, 10 Feb 2022 21:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644528662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NNd50lImSIq84p5mFKNUFUrLfFjn459wP+9RbYe2xDM=;
        b=Vn4rzCh6QUnAfb8GvqWqK+z/vKjGHCTCOvtJ+UowX3m4IRloF29mX8+6idfHanzIJbTeIV
        3+rvTr1TzFcZCu0M1igu9053AkSMMA7TQkM7eKVyokH0hZSZwZ5ZrHmAj9XHvu3cBpyhCo
        GKBYA7EZn7o+D4WsD3ye3L5B2/NoZLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644528662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NNd50lImSIq84p5mFKNUFUrLfFjn459wP+9RbYe2xDM=;
        b=+GOeIm7TJ7U3zyR8VOnnOact2Vm+jy5Zb6JSqIKz9c7QfvzfKKPbvICsYAmPgrtPiTYg+q
        1D1+zJSwaFJhh2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3A1C13C51;
        Thu, 10 Feb 2022 21:31:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rJAqFxWEBWKGJgAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 10 Feb 2022 21:31:01 +0000
Date:   Thu, 10 Feb 2022 15:30:58 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, fvogt@suse.com
Subject: Re: [PATCH] Fix read-only superblock in case of subvol RO remount
Message-ID: <20220210213058.m7kukfryrk4cgsye@fiona>
References: <20220210165142.7zfgotun5qdtx4rq@fiona>
 <2db10c6d-513a-3b73-c694-0ef112baa389@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db10c6d-513a-3b73-c694-0ef112baa389@cobb.uk.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19:54 10/02, Graham Cobb wrote:
> On 10/02/2022 16:51, Goldwyn Rodrigues wrote:
> > If a read-write root mount is remounted as read-only, the subvolume
> > is also set to read-only.
> 
> Errrr... Isn't that exactly what I want?
> 
> If I have a btrfs filesystem with hundreds of subvols, some of which may
> be mounted into various places in my filesystem, I would expect that if
> I remount the main mountpoint as RO, that all the subvols become RO as
> well. I actually don't mind if the behaviour went further and remounting
> ANY of the mount points as RO would make them all RO.
> 
> My mental model is that mounting a subvol somewhere is rather like a
> bind mount. And a bind mount goes RO if the underlying fs goes RO -
> doesn't it?
> 

If we want bind mount, we would use bind mount. subvolume mounts and bind
mounts are different and should be treated as different features.

> Or am I just confused about what this patch is discussing?

Root can also be considered as a unique subvolume with a unique
subvolume id and a unique name=/

-- 
Goldwyn
