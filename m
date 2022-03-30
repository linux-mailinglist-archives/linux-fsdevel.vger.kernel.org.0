Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7124EB7F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 03:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbiC3Bu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 21:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiC3Bu0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 21:50:26 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE11260E;
        Tue, 29 Mar 2022 18:48:39 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1CD497113; Tue, 29 Mar 2022 21:48:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1CD497113
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1648604919;
        bh=l9GumFcfnlmaNWcSMrOGkOAd+cs63zZNeRtR5T9YlIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rm0+h9oeeFazJ7wvJdOtHbtwwZEQ9UC4IQIG+Cg6yeBW7yzYOVcqp43VZXjTddG3E
         IYiqhlecLNkREkkc8+Mgp8J3GUgzQqmPtaP4x8XYeG2DMgVQ3ZARRrcie/JqE9XY/J
         8lo1xcAwaolg8n9jDAdHC7ZGb8JP1/RokJ7CUDRo=
Date:   Tue, 29 Mar 2022 21:48:39 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Message-ID: <20220330014839.GH32217@fieldses.org>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
 <1648182891-32599-3-git-send-email-dai.ngo@oracle.com>
 <20220329154750.GE29634@fieldses.org>
 <612ef738-20f6-55f0-1677-cc035ba2fd0d@oracle.com>
 <20220329163011.GG29634@fieldses.org>
 <5cddab8d-dd92-6863-78fd-a4608a722927@oracle.com>
 <20220329183916.GC32217@fieldses.org>
 <593317f2-b4d6-eac1-7886-48a7271871e8@oracle.com>
 <20220330001239.GG32217@fieldses.org>
 <24d6dcff-33fd-99c1-c920-9bf56f672a6e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d6dcff-33fd-99c1-c920-9bf56f672a6e@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 06:17:29PM -0700, dai.ngo@oracle.com wrote:
> 
> On 3/29/22 5:12 PM, J. Bruce Fields wrote:
> >On Tue, Mar 29, 2022 at 02:45:28PM -0700, dai.ngo@oracle.com wrote:
> >>This does not prevent the courtesy client from doing trunking in all
> >>cases. It is only prevent the courtesy client from doing trunking without
> >>first reconnect to the server.
> >>
> >>I think this behavior is the same as if the server does not support courtesy
> >>client; the server can expire the courtesy anytime it wants. If the
> >>courtesy client reconnected successfully then by the time nfsd4_create_session/
> >>find_confirmed_client is called the client already becomes active
> >>so the server will process the request normally.
> >I'm not sure what you mean here.  All a client has to do to reconnect is
> >succesfully renew its lease.
> 
> For 4.1 the client renews its lease via the SEQUENCE, either stand-alone
> or in a compound. Once the SEQUENCE completes successfully then the
> subsequent CREATE_SESSION is processed normally. However, if the client
> did not send the SEQUENCE first then server returns BAD_SESSION for the
> CREATE_SESSION request.
> 
> >   That doesn't necessarily require calling
> >CREATE_SESSION again.
> >
> >>Also to handle cases when the courtesy client reconnects after it was in
> >>EXPIRED state, we want to force the client to recover its state starting
> >>with EXCHANGE_ID so we have to return BAD_SESSION on CREATE_SESSION request.
> >The client should not have to send EXCHANGE_ID.
> 
> For 4.1 the expired courtesy client must send EXCHANGE_ID to reconnect
> to start new session. I don't see how the *expired* courtesy client can
> access the export again without sending the EXCHANGE_ID. Attached is the
> pcap that shows how the courtesy client recovers once it's in
> CLIENT_EXPIRED state.

Oh, sorry, sure, we're talking about an actual expired client.  That's
fine.

--b.
