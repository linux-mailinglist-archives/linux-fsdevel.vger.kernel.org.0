Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB92798679
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 13:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbjIHLcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 07:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjIHLcN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:32:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561211BE7;
        Fri,  8 Sep 2023 04:32:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F31C433CA;
        Fri,  8 Sep 2023 11:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694172730;
        bh=fA45esoBjlgFx5PLKu971HgUUGMPaH0ktqfKPC1tx3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nj2YcIfZT54BYwwLaWPGsArYd3DtFHX8UtgE5ywPdFZPhamV2pw//p0wf8MKowFMi
         9B8zMeJQnYvVtQ7DrO3wgct/I86hGXT0w73gh5oOGv68UlBNUMA7g8OqGpm1olSTMP
         0n7KaJYbuZQ7ensvPh1Fg2ANZDndAq2aAP7OKFR7BB7dCYCSC6L3I3BiwwaS20gBk9
         5YMoKFy+J4YNtqfnH5TrU5vF9/S0evNkktTAqyuMmEcFoxGwl8Gr4PhiUFBWyiFULp
         J8giAdsMXOZNdLcnWVRjeoqk/Z2AWsv+xvWameizzwBoPjF5fBZgPv34ljC+R0PWFS
         DULoMT/ocsJeA==
Date:   Fri, 8 Sep 2023 13:32:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zdenek Kabelac <zkabelac@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230908-bergwacht-bannen-1855c8afe518@brauner>
References: <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
 <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
 <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
 <20230907094457.vcvmixi23dk3pzqe@quack3>
 <20230907-abgrenzen-achtung-b17e9a1ad136@brauner>
 <513f337e-d254-2454-6197-82df564ed5fc@redhat.com>
 <20230908073244.wyriwwxahd3im2rw@quack3>
 <86235d7a-a7ea-49da-968e-c5810cbf4a7b@redhat.com>
 <20230908102014.xgtcf5wth2l2cwup@quack3>
 <15c62097-d58f-4e66-bdf5-e0edb1306b2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15c62097-d58f-4e66-bdf5-e0edb1306b2f@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I'd say there are several options and we should aim towards the variant
> which is most usable by normal users.

None of the options is sufficiently satisfying to risk intricate
behavioral changes with unknown consequences for existing workloads as
far as I'm concerned.
