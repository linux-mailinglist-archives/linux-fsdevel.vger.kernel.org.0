Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200227538D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 12:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjGNKxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 06:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjGNKxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:53:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9512130D1;
        Fri, 14 Jul 2023 03:53:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4FA4A22113;
        Fri, 14 Jul 2023 10:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689332012;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0qQY0pMf/UabBAcvhkGlUgib+9xhl7v6k8CF4e0RVcM=;
        b=neMayiXn+Ro3eLm/nmp5aFdNYcam8bFb0D3F0bV2ZrkrvvPBCN6ndp9h3Fh1YR2pf6n24y
        iz0TYWgtW1fQVPkgFZvNMuqSgi6fm3KBiBxPtyjp9zKlAjf+qM7jo7waDTHkBTEIddG1Pc
        jGrcxYqBWTpQFfJWkFZ9S1P3JN6jE5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689332012;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0qQY0pMf/UabBAcvhkGlUgib+9xhl7v6k8CF4e0RVcM=;
        b=F+7Y+yB92SLJegc4FRZD3HtAk4Wp0LEHVtC1EEWGpPrfzMj9nI7te9xDzYAVovYlrmhkGy
        xeP9leyDppFvxGAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25411138F8;
        Fri, 14 Jul 2023 10:53:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kjo/CCwpsWSKIQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Jul 2023 10:53:32 +0000
Date:   Fri, 14 Jul 2023 12:46:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     huzhi001@208suo.com
Cc:     dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VFS: Fix seven errors in bitmap.c
Message-ID: <20230714104655.GH20457@suse.cz>
Reply-To: dsterba@suse.cz
References: <tencent_CE461BFFDACFEA943A778650FB672D9E3207@qq.com>
 <80ff0222e0fc0b8e25ae4837b76bce2d@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ff0222e0fc0b8e25ae4837b76bce2d@208suo.com>
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

On Fri, Jul 14, 2023 at 03:14:18PM +0800, huzhi001@208suo.com wrote:
> The following checkpatch errors are removed:
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: space required after that ',' (ctx:VxV)

The AFFS module gets only bug fixes (as can be seen in the MAINTAINERS
file) or API updates, not coding style fixes.

The sources have way more stylistic things that checkpatch does not like
but we are not going to fix them:

total: 0 errors, 1 warnings, 189 lines checked
total: 1 errors, 5 warnings, 543 lines checked
total: 7 errors, 4 warnings, 365 lines checked
total: 1 errors, 1 warnings, 144 lines checked
total: 2 errors, 13 warnings, 1009 lines checked
total: 8 errors, 12 warnings, 422 lines checked
total: 0 errors, 2 warnings, 584 lines checked
total: 15 errors, 13 warnings, 681 lines checked
total: 1 errors, 2 warnings, 77 lines checked
total: 4 errors, 10 warnings, 328 lines checked
total: 4 errors, 0 warnings, 148 lines checked
