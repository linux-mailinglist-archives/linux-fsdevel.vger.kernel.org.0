Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE3528E9F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 13:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfHOLSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 07:18:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:59972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730497AbfHOLSC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:18:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0583FAFD4;
        Thu, 15 Aug 2019 11:18:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BBFD41E4200; Thu, 15 Aug 2019 13:18:00 +0200 (CEST)
Date:   Thu, 15 Aug 2019 13:18:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 02/11] quota: Only module_put the format when existing
Message-ID: <20190815111800.GD14313@quack2.suse.cz>
References: <20190814121834.13983-1-s.hauer@pengutronix.de>
 <20190814121834.13983-3-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814121834.13983-3-s.hauer@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-08-19 14:18:25, Sascha Hauer wrote:
> For filesystems which do not have a quota_format_type such as upcoming
> UBIFS quota fmt may be NULL. Only put the format when it's non NULL.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

But you do have quota format in the end. So is this patch needed?

								Honza

> ---
>  fs/quota/dquot.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 3cb836351c22..b043468e53f2 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -218,6 +218,9 @@ static struct quota_format_type *find_quota_format(int id)
>  
>  static void put_quota_format(struct quota_format_type *fmt)
>  {
> +	if (!fmt)
> +		return;
> +
>  	module_put(fmt->qf_owner);
>  }
>  
> -- 
> 2.20.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
