Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E37D4255AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 16:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbhJGOnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 10:43:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38230 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242110AbhJGOnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:43:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A26E522415;
        Thu,  7 Oct 2021 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633617716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wg27QjHqYVAaPstpf7so0rTJ0eaThEY9sMKMxSud6sM=;
        b=ZNQracSvE5WinILbpjV5/pnPN/WhcsGYEbozg2lYkFmxM8w9LMxyrRLkjz0YkLxLctxJfq
        Ail7uzAM79IsU/KTJXUQtPiXWN/DOimtNRXCUWg6qz8sWhoIpiaQVNrMZiirTMHSEeif2H
        EBuLbdN3NiRia3c+RNicp6S3QK6m1rI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633617716;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wg27QjHqYVAaPstpf7so0rTJ0eaThEY9sMKMxSud6sM=;
        b=YD5i1L6NIygVjyo/v1tKRFa66cgqmirpQnXpl9Z6oWH6LwcqCTatziIQJZIZiOSAM4pBvO
        8Ej2oPK7pkC4iYCQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 59C6FA3B87;
        Thu,  7 Oct 2021 14:41:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 34B7D1F2C96; Thu,  7 Oct 2021 16:41:56 +0200 (CEST)
Date:   Thu, 7 Oct 2021 16:41:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, miklos <miklos@szeredi.hu>,
        amir73il <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode
 operation
Message-ID: <20211007144156.GK12712@quack2.suse.cz>
References: <20210923130814.140814-1-cgxu519@mykernel.net>
 <20210923130814.140814-7-cgxu519@mykernel.net>
 <20211007090157.GB12712@quack2.suse.cz>
 <17c5ab83d6d.10cdb35ab25883.3563739472838823734@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17c5ab83d6d.10cdb35ab25883.3563739472838823734@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 07-10-21 20:26:36, Chengguang Xu wrote:
>  ---- 在 星期四, 2021-10-07 17:01:57 Jan Kara <jack@suse.cz> 撰写 ----
>  > 
>  > > +    if (mapping_writably_mapped(upper->i_mapping) ||
>  > > +        mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
>  > > +        iflag |= I_DIRTY_PAGES;
>  > > +
>  > > +    iflag |= upper->i_state & I_DIRTY_ALL;
>  > 
>  > Also since you call ->write_inode directly upper->i_state won't be updated
>  > to reflect that inode has been written out (I_DIRTY flags get cleared in
>  > __writeback_single_inode()). So it seems to me overlayfs will keep writing
>  > out upper inode until flush worker on upper filesystem also writes the
>  > inode and clears the dirty flags? So you rather need to call something like
>  > write_inode_now() that will handle the flag clearing and do writeback list
>  > handling for you?
>  > 
> 
> Calling ->write_inode directly upper->i_state won't be updated, however,
> I don't think overlayfs will keep writing out upper inode since
> ->write_inode will be called when only overlay inode itself marked dirty.
> Am I missing something?

Well, if upper->i_state is not updated, you are more or less guaranteed
upper->i_state & I_DIRTY_ALL != 0 and thus even overlay inode stays dirty.
And thus next time writeback runs you will see dirty overlay inode and
writeback the upper inode again although it is not necessary.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
