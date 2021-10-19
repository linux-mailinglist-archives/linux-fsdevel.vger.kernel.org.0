Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40DC4337E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbhJSOAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 10:00:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58840 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhJSOAu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:00:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E00771FD66;
        Tue, 19 Oct 2021 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634651916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=abLU67Y73wTxtGcuo7U/jTnXBkUbjKwZiGMqSHa4lp0=;
        b=MFVv/sMFD2ybknsyeCmmca08F6ibvFYkD9cQvfHPi98aXdGjv4iGNWdjD24F9B309wUebX
        tRj0GJJXtITz9weJSaRxtXKDH0Yl2eFkFhm2bk2E7FuxiR2ktafGUoAo8IAg4qZd2aICse
        KeC9TjqSl9UfjjvX8I00lH6MnxLcVj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634651916;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=abLU67Y73wTxtGcuo7U/jTnXBkUbjKwZiGMqSHa4lp0=;
        b=eosRPeQGZNZGzTf8LHxo501EwRjXfOMQs1GGqgsdnpus8T1uYhKI5iBmlW/aViNOSDrZff
        3nh0msIwMHIhi6Ag==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id C72F5A3B83;
        Tue, 19 Oct 2021 13:58:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 99D4E1E0983; Tue, 19 Oct 2021 15:58:36 +0200 (CEST)
Date:   Tue, 19 Oct 2021 15:58:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v8 23/32] fanotify: Wrap object_fh inline space in a
 creator macro
Message-ID: <20211019135836.GL3255@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-24-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019000015.1666608-24-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-10-21 21:00:06, Gabriel Krisman Bertazi wrote:
> fanotify_error_event would duplicate this sequence of declarations that
> already exist elsewhere with a slight different size.  Create a helper
> macro to avoid code duplication.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Among the suggestions, I think this is simpler because it avoids
> deep nesting the variable-sized attribute, which would have been hidden
> inside fee->ffe->object_fh.buf.

One nit from me as well :)

> +#define FANOTIFY_INLINE_FH(size)					\
> +struct {								\
> +	struct fanotify_fh object_fh;					\
> +	/* Space for object_fh.buf[] - access with fanotify_fh_buf() */	\
> +	unsigned char _inline_fh_buf[(size)];				\
> +}
> +

Can the macro perhaps take the name of the fanotify_fh member it creates?
Like:

#define FANOTIFY_INLINE_FH(name, size)

Harcoding _inline_fh_buf is fine since it isn't ever used directly but
hardcoding object_fh looks ugly to me. With that improved feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
