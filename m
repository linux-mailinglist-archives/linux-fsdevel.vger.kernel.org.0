Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE2845F018
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 15:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353875AbhKZOtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 09:49:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42638 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354044AbhKZOrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:47:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AAE93212BD;
        Fri, 26 Nov 2021 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637937847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qPVYNirZVluRFR7YwVBoq3RfYrv4EoJqtFIbgE2GPKs=;
        b=svaLRBYYEwGZ7BY3fgbKRkjzFh9KLREQq3zWbvlh7Ags1qg2/jz5wzTVa8qcJSS3k4i3ED
        p5NPB4+99q10JPt+o0LFZG1fXaw+G6IPX6pi9C/b75O9ZpNhh9IpmP+8I++SHXZZbRc7ah
        DD6OBQ8wYhL8doOjUmqsEhQ7D3rNe+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637937847;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qPVYNirZVluRFR7YwVBoq3RfYrv4EoJqtFIbgE2GPKs=;
        b=5UZRzEZINf9+AwXj/MheqMD/UwEvjuwSY31lK2E7HnDpLJ6tGF7WccaUOhQiAMl6CG38c6
        yAtKdxJj9FKqtlBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 86C2CA3B81;
        Fri, 26 Nov 2021 14:44:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6303D1E11F3; Fri, 26 Nov 2021 15:44:07 +0100 (CET)
Date:   Fri, 26 Nov 2021 15:44:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] fanotify: record old and new parent and name in
 FAN_RENAME event
Message-ID: <20211126144407.GI13004@quack2.suse.cz>
References: <20211119071738.1348957-1-amir73il@gmail.com>
 <20211119071738.1348957-7-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119071738.1348957-7-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 19-11-21 09:17:35, Amir Goldstein wrote:
> In the special case of FAN_RENAME event, we record both the old
> and new parent and name.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Just one nit below:

> @@ -727,6 +751,17 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  		} else if ((mask & ALL_FSNOTIFY_DIRENT_EVENTS) || !ondir) {
>  			name_event = true;
>  		}
> +
> +		/*
> +		 * In the special case of FAN_RENAME event, we record both
> +		 * old and new parent+name.
> +		 * 'dirid' and 'file_name' are the old parent+name and
> +		 * 'moved' has the new parent+name.
> +		 */
> +		if (mask & FAN_RENAME) {
> +			moved = fsnotify_data_dentry(data, data_type);
> +			name_event = true;

Why do you set 'name_event' here? It should be true due to conditions
shortly above because FAN_RENAME is in ALL_FSNOTIFY_DIRENT_EVENTS,
shouldn't it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
