Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5642F431A30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 14:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhJRM7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 08:59:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60026 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhJRM7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:59:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2472B1FD7A;
        Mon, 18 Oct 2021 12:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634561840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qUSPnlwYX4UmIJ5IFa2QfK7msAcxJ6nERZpTfDeS5AU=;
        b=kIhKk2UOZA49YMcSVN35V1gCbcZiWvBDV0bKNHC6xOZssD0jieiv4JOlECdVe3WqKFul0Q
        TFbg9AIa5zOxSR052KtNH94Jxz46lipuAQEdzZCJij8wV81mw4czeoTFFW2/V1YLN5sN9d
        KinmfdPT2vY0emFQTD/Zb1tML8jQCXU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D38EC13D41;
        Mon, 18 Oct 2021 12:57:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IMIhMS9vbWFzTAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Oct 2021 12:57:19 +0000
Subject: Re: [PATCH v11 11/14] btrfs: send: write larger chunks when using
 stream v2
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <7d62209de1399ce59d84fc3b06ac37d5b336be27.1630514529.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <627cde76-3876-13ad-209d-990a02691e94@suse.com>
Date:   Mon, 18 Oct 2021 15:57:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7d62209de1399ce59d84fc3b06ac37d5b336be27.1630514529.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The length field of the send stream TLV header is 16 bits. This means
> that the maximum amount of data that can be sent for one write is 64k
> minus one. However, encoded writes must be able to send the maximum
> compressed extent (128k) in one command. To support this, send stream
> version 2 encodes the DATA attribute differently: it has no length
> field, and the length is implicitly up to the end of containing command
> (which has a 32-bit length field). Although this is necessary for
> encoded writes, normal writes can benefit from it, too.
> 
> For v2, let's bump up the send buffer to the maximum compressed extent
> size plus 16k for the other metadata (144k total). Since this will most
> likely be vmalloc'd (and always will be after the next commit), we round
> it up to the next page since we might as well use the rest of the page
> on systems with >16k pages.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
