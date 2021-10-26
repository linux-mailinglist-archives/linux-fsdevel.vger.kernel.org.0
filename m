Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A952343B207
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 14:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbhJZMN2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 08:13:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52868 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhJZMN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 08:13:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A949D1FD4C;
        Tue, 26 Oct 2021 12:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635250262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ojnLx7/RIPq4iLl5wUuKWkanLu0q3xCOsIU9XDzqvY4=;
        b=BNDGiE9wHedUBDWKa2YdCeJPriH2RvhBHaRQDba/kAlOrix2TSm1O9guquXcIGjEUJr4G2
        QKYiGovgF/6F+K4l6CLSdnGGuwBhJt4Da6WCt3i+Qv9GpcEq/RZ92IOBb9JlotzUhdyzgh
        Age/+0fXLPf91OIRTyBVPAbkaoN44eQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635250262;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ojnLx7/RIPq4iLl5wUuKWkanLu0q3xCOsIU9XDzqvY4=;
        b=TK6oUzD0s0/LhxE4GT1Lm+hUJpwp48s+zfQGWAd0RLQBM+VmiH+wFOYwsK2C9/C3r8A0aC
        noPqPZj1g3PLiLCg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 92A93A3B81;
        Tue, 26 Oct 2021 12:11:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 122CA1F2C66; Tue, 26 Oct 2021 14:11:02 +0200 (CEST)
Date:   Tue, 26 Oct 2021 14:11:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, jack@suse.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v9 27/31] fanotify: Emit generic error info for error
 event
Message-ID: <20211026121102.GE21228@quack2.suse.cz>
References: <20211025192746.66445-1-krisman@collabora.com>
 <20211025192746.66445-28-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025192746.66445-28-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 25-10-21 16:27:42, Gabriel Krisman Bertazi wrote:
> The error info is a record sent to users on FAN_FS_ERROR events
> documenting the type of error.  It also carries an error count,
> documenting how many errors were observed since the last reporting.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

...

> @@ -530,6 +557,14 @@ static int copy_info_records_to_user(struct fanotify_event *event,
>  		total_bytes += ret;
>  	}
>  
> +	if (fanotify_is_error_event(event->mask)) {
> +		ret = copy_error_info_to_user(event, buf, count);
> +		if (ret < 0)
> +			return ret;
> +		buf += ret;
> +		count -= ret;
> +	}
> +
>  	return total_bytes;
>  }

This is currently harmless but we should add

total_bytes += ret;

here as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
