Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07682511EC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbiD0QRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 12:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244238AbiD0QPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:15:53 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36493A6AF8;
        Wed, 27 Apr 2022 09:12:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 969811506; Wed, 27 Apr 2022 12:12:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 969811506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651075941;
        bh=m1TQG+8HO4vSnL7xPgnhMppcOqFyQebLGcqTBdJy5Jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nD+sfUBnyVuO+Bzls3yZtjr5pV2+N09GC2WpmU3E6eKLGQWctHezwPWKwgvj2auFw
         UBi9BT82TvZQZ0DYN9RlNAODdbCPM3t8stetDnSvOxqgF8Svxg1AzMN7+6hAJrKBC4
         3CrGjXK6xgrf47chj2NjZPIlxen+tqQvh4Prii2w=
Date:   Wed, 27 Apr 2022 12:12:21 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v22 1/7] NFSD: add courteous server support for
 thread with only delegation
Message-ID: <20220427161221.GD13471@fieldses.org>
References: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
 <1651049573-29552-2-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651049573-29552-2-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 27, 2022 at 01:52:47AM -0700, Dai Ngo wrote:
> +	if (!try_to_expire_client(clp)) {
> +		nn = net_generic(clp->net, nfsd_net_id);
> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +	}
...
> +static inline bool try_to_expire_client(struct nfs4_client *clp)
> +{
> +	bool ret;
> +
> +	ret = NFSD4_ACTIVE ==
> +		cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
> +	return ret;
> +}

Hm, this feels a little backwards to me.  I'd expect
"try_to_expire_client" to return true on success.  Maybe call it
"client_is_expirable()" to make that clear?  Or stick with
"try_to_expire_client and make it return 0/-EAGAIN.

If "NFSD4_ACTIVE != cmpxchg(...)" is too confusing, I don't think we
really even need the atomic return of the previous value, I think it
would be OK just to do:

	cmpschg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
	return clp->cl_state == NFSD4_EXPIRABLE;

--b.
