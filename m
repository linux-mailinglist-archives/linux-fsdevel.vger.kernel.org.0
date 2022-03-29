Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BAD4EB460
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 22:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbiC2UDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 16:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241126AbiC2UDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:03:11 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80551AF516;
        Tue, 29 Mar 2022 13:01:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1DBCC3442; Tue, 29 Mar 2022 16:01:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1DBCC3442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1648584087;
        bh=ix2y2csniRTIk0/lhfMr6fLCWfT6Odi0LihBMpdWKlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vx91hks7/jNSVXfkLNrHxgu+8iN7vjxW984+7bMWyll1nDiKsqaig8MzGh5j8oz0D
         A0U3o4ER1d/A7sezJIhBPotTnsZh5Gy9lhkvW39twVzkkNPVHnBe1DZnv8j5aSnXcY
         mNqakZNo9TH3/rnBPtPwWuI9f3gvHSTwevaMhGNQ=
Date:   Tue, 29 Mar 2022 16:01:27 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Message-ID: <20220329200127.GE32217@fieldses.org>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
 <1648182891-32599-3-git-send-email-dai.ngo@oracle.com>
 <20220329154750.GE29634@fieldses.org>
 <612ef738-20f6-55f0-1677-cc035ba2fd0d@oracle.com>
 <20220329163011.GG29634@fieldses.org>
 <5cddab8d-dd92-6863-78fd-a4608a722927@oracle.com>
 <20220329183916.GC32217@fieldses.org>
 <ED3991C3-0E66-439F-986E-7778B2C81CDB@oracle.com>
 <20220329194915.GD32217@fieldses.org>
 <ACF56E81-BAB9-4102-A4C3-AB03DE1BAE76@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ACF56E81-BAB9-4102-A4C3-AB03DE1BAE76@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 07:58:46PM +0000, Chuck Lever III wrote:
> Got it. Agreed, cl_cs_client_state should be reinitialized if
> a courtesy client is transitioned back to "active".
> 
> Dai, would you add
> 
> +enum courtesy_client_state {
> >>>	NFSD4_CLIENT_ACTIVE = 0,
> +	NFSD4_CLIENT_COURTESY,
> +	NFSD4_CLIENT_EXPIRED,
> +	NFSD4_CLIENT_RECONNECTED,
> +};
> 
> And set cl_cs_client_state to ACTIVE where the client is
> allowed to transition back to being active?

I'm not clear then what the RECONNECTED->ACTIVE transition would be.

My feeling is that the RECONNECTED state shouldn't exist, and that there
should only be a transition of EXPIRED back to ACTIVE.

--b.
