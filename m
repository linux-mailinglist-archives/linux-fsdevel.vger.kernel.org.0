Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FAB638AC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 14:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKYNB5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 08:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiKYNBn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:01:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19D44EC12;
        Fri, 25 Nov 2022 05:01:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB217623C0;
        Fri, 25 Nov 2022 13:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E731EC433C1;
        Fri, 25 Nov 2022 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669381287;
        bh=Bd6+TW+SUllGke4xXPsi3E6NWwGNc4MDvTSGFvrCkNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rN3HdXqTCE4bVjC5CMTwEYV/a3IqLkxDV8dp6hFvDxLFX7AnpNe8ReTonzysdsYOH
         Z8uxb6ZC+Pzpf/C76pu/5Sv0zibmR6Hu1RB9G0Og5MecEpDXIBvcTp8wXTQLuPA0H2
         irjJcfK9oQK/83jsOKllASa9HpcPSDP460eKPrJoenS1Uy3yGBNvfMWjnfcj9Ny2hA
         V7c+OOkTU1rj36gqP+plmOFMGnYcfXVgyIQiyCCIVua2ZkyDO5vLRb1DsXxff+Jt3u
         JCb0In9/OEMc6LiCC6iQDPCFRsWf3y3xE5h2OmSigcgPq+yrmVX0j6mHIhMkBGGY2R
         ht3jRsPiafuTg==
Date:   Fri, 25 Nov 2022 21:01:21 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>, jlayton@kernel.org,
        xiang@kernel.org, chao@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] fscache,cachefiles: add prepare_ondemand_read()
 callback
Message-ID: <Y4C8ocemviAGpxRC@debian>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, jlayton@kernel.org,
        xiang@kernel.org, chao@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221124034212.81892-2-jefflexu@linux.alibaba.com>
 <20221124034212.81892-1-jefflexu@linux.alibaba.com>
 <2386961.1669377478@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2386961.1669377478@warthog.procyon.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Fri, Nov 25, 2022 at 11:57:58AM +0000, David Howells wrote:
> Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
> > Add prepare_ondemand_read() callback dedicated for the on-demand read
> > scenario, so that callers from this scenario can be decoupled from
> > netfs_io_subrequest.
> > 
> > The original cachefiles_prepare_read() is now refactored to a generic
> > routine accepting a parameter list instead of netfs_io_subrequest.
> > There's no logic change, except that the debug id of subrequest and
> > request is removed from trace_cachefiles_prep_read().
> > 
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> Acked-by: David Howells <dhowells@redhat.com>

Thanks!  I will apply them for -next, and soon Jingbo will
submit large folios support for erofs iomap/fscache modes.

Thank all again,
Gao Xiang

