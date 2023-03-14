Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB5B6BA26E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjCNW1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjCNW1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:27:03 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9588305D7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:27:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMQk8r005549
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678832808; bh=9WAwmkJGWs5lYMlYzHHW4hlu0f+6SGDZ/gDMxZXWqrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HCVtwV4z3Inqu2eOChBdPDfTKN7jtI+0gFdOj8wMnIpwaLw8zwFVvRoFfwH/9EESD
         Qtt4WoxJaY14jSLGe+uk7kvNnqj1deT6tGCPPqCQ/eevRTz2fTr/IqgQwsER2Zdipb
         QG9WJTZk6JJZhNc9IBsIEt9U5IQMFlHPTnp0qYXppz6QXttVPeXsZc/pF4mJ8sdvVK
         QOoLLJhGN06H5KcLC/BrW86t4n3jSWfQeFFupEOMTZHP6M4thBYBx84AWAWgu6jZi2
         GLHmb+yi3bTMe7m2T7jjjB4HSoLMxYkMXF1dUC1a5JSZGp4+PsYBuG5Gbq/2qBw2Sz
         tchirH++xeZIw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7A1E415C5830; Tue, 14 Mar 2023 18:26:46 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:26:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/31] ext4: Convert ext4_writepage() to use a folio
Message-ID: <20230314222646.GT860405@mit.edu>
References: <20230126202415.1682629-6-willy@infradead.org>
 <87y1o9vhvq.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1o9vhvq.fsf@doe.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 12:15:13AM +0530, Ritesh Harjani wrote:
> "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
> 
> > Prepare for multi-page folios and save some instructions by converting
> > to the folio API.
> 
> Mostly a straight forward change. The changes looks good to me.
> Please feel free to add -
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> In later few patches I see ext4_readpage converted to ext4_read_folio().
> I think the reason why we have not changed ext4_writepage() to
> ext4_write_folio() is because we anyway would like to get rid of
> ->writepage ops eventually in future, so no point.
> I think there is even patch series from Jan which tries to kill
> ext4_writepage() completely.

Indeed, Jan's patch series[1] is about to land in the ext4 tree, and
that's going to remove ext4_writepages.  The main reason why this
hadn't landed yet was due to some conflicts with some other folio
changes, so you should be able to drop this patch when you rebase this
patch series.

					- Ted

[1] https://lore.kernel.org/all/20230228051319.4085470-1-tytso@mit.edu/
