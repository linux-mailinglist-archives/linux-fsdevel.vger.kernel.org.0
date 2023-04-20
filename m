Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE76E9687
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjDTOCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 10:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjDTOCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:02:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42641728
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 07:02:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9BB1E21903;
        Thu, 20 Apr 2023 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681999354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wh1XX+NIsMFChIJFhOmeoghzgkkDTbLXHLLd1wCDovM=;
        b=Kwq2f9eraPsyISaXQc3iey2GbKD78fz/FETtSkC/hIJSPxcM37J/NmZ+iaCS63dkLxlE++
        ItSwjoAQilNgk2qmqF/1XbYT7vt7cJhGP6gKuDzDrb2brMOshuwnVu7dPPczWX/cige3O7
        m+pxMdVQo+ImmOaG1zKOHDxg+UVFWA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681999354;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wh1XX+NIsMFChIJFhOmeoghzgkkDTbLXHLLd1wCDovM=;
        b=gKEjB7YDO9c0y2ZIH0Boow/P/aFU4IfdbjexfZcX2IBCZhfYRaFZxFaevTL+mjdlhzSGlP
        eNuFf7alGYezE6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B44D13584;
        Thu, 20 Apr 2023 14:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kkL4IfpFQWTOLAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 20 Apr 2023 14:02:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1FA29A0729; Thu, 20 Apr 2023 16:02:34 +0200 (CEST)
Date:   Thu, 20 Apr 2023 16:02:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     cem@kernel.org
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH V2 5/6] shmem: quota support
Message-ID: <20230420140234.5mv5kixwr7bxnu5r@quack3>
References: <20230420080359.2551150-1-cem@kernel.org>
 <20230420080359.2551150-6-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420080359.2551150-6-cem@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-04-23 10:03:58, cem@kernel.org wrote:
> From: Lukas Czerner <lczerner@redhat.com>
> 
> Now the basic infra-structure is in place, enable quota support for tmpfs.
> 
> This offers user and group quotas to tmpfs (project quotas will be added
> later). Also, as other filesystems, the tmpfs quota is not supported
> within user namespaces yet, so idmapping is not translated.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

I've found only one typo fix below. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> index 0408c245785e3..1d4ef4f7cca7e 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -86,6 +86,21 @@ use up all the memory on the machine; but enhances the scalability of
>  that instance in a system with many CPUs making intensive use of it.
>  
>  
> +tmpfs also supports quota with the following mount options
> +
> +========  =============================================================
> +quota     User and group quota accounting and enforcement is enabled on
> +          the mount. Tmpfs is using hidden system quota files that are
> +          initialized on mount.
> +usrquota  User quota accounting and enforcement is enabled on the
> +          mount.
> +grpquota  Group quota accounting and enforcement is enabled on the
> +          mount.
> +========  =============================================================
> +
> +Note that tmpfs quotas do not support user namespaces so no uid/gid
> +translation is done if quotas are enable inside user namespaces.
					^^ enabled

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
