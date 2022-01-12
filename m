Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FB948C756
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 16:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbiALPii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 10:38:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37440 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbiALPih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:38:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C09421F39B;
        Wed, 12 Jan 2022 15:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642001916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l7jbLt0aceZPv8DdrPzm/wcUUF+yUNzfzQcXbU+ZjrQ=;
        b=gD21sEhJXwT7NldE5yhix+cs2VJQTZxTwQl9fxjDSaphG342S0fLizo5zSIc30d6kSKHRG
        DFSDQGMBhMllejObb42ILGXgahFXY4URi/zN0MlZFVJqajYuYOLal45Ok2j8U+5Y6u2sQF
        8HB7Xw0o9JWrjmLO56DU0kMGgbZ3oVg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78F2513B72;
        Wed, 12 Jan 2022 15:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 75FeG/z13mFfKQAAMHmgww
        (envelope-from <mwilck@suse.com>); Wed, 12 Jan 2022 15:38:36 +0000
Message-ID: <6181df9237e121affdb432c86c7408b50ad08afe.camel@suse.com>
Subject: Re: [PATCH v6 4/6] gen_init_cpio: fix short read file handling
From:   Martin Wilck <mwilck@suse.com>
To:     David Disseldorp <ddiss@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org
Date:   Wed, 12 Jan 2022 16:38:35 +0100
In-Reply-To: <20220107133814.32655-5-ddiss@suse.de>
References: <20220107133814.32655-1-ddiss@suse.de>
         <20220107133814.32655-5-ddiss@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-01-07 at 14:38 +0100, David Disseldorp wrote:
> When processing a "file" entry, gen_init_cpio attempts to allocate a
> buffer large enough to stage the entire contents of the source file.
> It then attempts to fill the buffer via a single read() call and
> subsequently writes out the entire buffer length, without checking
> that
> read() returned the full length, potentially writing uninitialized
> buffer memory.
> 
> Fix this by breaking up file I/O into 64k chunks and only writing the
> length returned by the prior read() call.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Looks ok to me.

Reviewed-by: Martin Wilck <mwilck@suse.com>

