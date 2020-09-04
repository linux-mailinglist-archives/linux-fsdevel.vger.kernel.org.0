Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF325D863
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 14:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgIDMGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 08:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729932AbgIDMG2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:06:28 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEA3020791;
        Fri,  4 Sep 2020 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599221188;
        bh=Ja+eTE9Voa6mNQZ2aKq7v/synKxts6frBKXWiy9f44Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSPVPUy5zCvrS6qvCmuMQnli4ic7XTsB3CYSbjiWwqcQv6yVv3qettzvkp2j9jz0U
         fGJepF7WUQM5O/rQgE+bg7n+9vdRt6HYOxVbDbE7i4vbpim0er5aLO9Qu7tVaQxDYK
         g2ASRBj4mvJorPCaLeSAwlWaFRnhS7/9mxPYgyno=
Received: by pali.im (Postfix)
        id 035FD6EC; Fri,  4 Sep 2020 14:06:25 +0200 (CEST)
Date:   Fri, 4 Sep 2020 14:06:25 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com
Subject: Re: [PATCH v3 02/10] fs/ntfs3: Add initialization of super block
Message-ID: <20200904120625.2af76ebfnacbzwug@pali>
References: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
 <20200828143938.102889-3-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828143938.102889-3-almaz.alexandrovich@paragon-software.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Konstantin!

On Friday 28 August 2020 07:39:30 Konstantin Komarov wrote:
> +	if (nls_name[0]) {
> +		sbi->nls = load_nls(nls_name);
> +		if (!sbi->nls) {
> +			ntfs_printk(sb, KERN_ERR "failed to load \"%s\"",
> +				    nls_name);
> +			return -EINVAL;
> +		}
> +	} else {
> +		sbi->nls = load_nls_default();
> +		if (!sbi->nls) {
> +			ntfs_printk(sb, KERN_ERR "failed to load default nls");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!strcmp(sbi->nls->charset, "utf8")) {
> +		/*use utf16s_to_utf8s/utf8s_to_utf16s instead of nls*/
> +		unload_nls(sbi->nls);
> +		sbi->nls = NULL;
> +	}

You can slightly simplify this code to omit calling load_nls() for UTF-8. E.g.:

    if (strcmp(nls_name[0] ? nls_name : CONFIG_NLS_DEFAULT, "utf8") == 0) {
        /* For UTF-8 use utf16s_to_utf8s/utf8s_to_utf16s instead of nls */
        sbi->nls = NULL;
    } else if (nls_name) {
        sbi->nls = load_nls(nls_name);
        if (!sbi->nls) {
            /* handle error */
        }
    } else {
        sbi->nls = load_nls_default();
        if (!sbi->nls) {
            /* handle error */
        }
    }
